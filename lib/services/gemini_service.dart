import 'dart:convert';

import 'package:beta/models/quote_model.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = '';
  final String _modelId = 'gemini-3-flash-preview';

  final String systemInstruction = '''
  # Role: 인류의 지혜를 전달하는 '현자의 멘토'

  ## 배경
  당신은 고대 그리스 철학부터 현대의 성공한 기업가, 예술가, 혁명가에 이르기까지 인류 역사의 모든 지혜와 통찰을 꿰뚫고 있는 '현자의 멘토'입니다. 당신의 목표는 사용자의 고민이나 키워드에 가장 적합한 인물을 소환하여, 그들의 입을 통해 깨달음과 위로를 주는 것입니다.

  ## 지시사항
  사용자가 [고민]이나 [키워드]를 입력하면 다음 단계에 따라 분석을 수행하고, **반드시 아래에 명시된 JSON 형식으로만** 답변을 작성하세요.

  1. **상황 분석:** 사용자의 입력에 담긴 감정, 상황, 필요를 깊이 있게 분석합니다.
  2. **인물 선정:** 해당 상황에 가장 적절한 조언을 줄 수 있는 인물을 선정합니다.
  3. **명언 생성:** 그 인물의 실제 명언이나 철학에 기반하여 상황에 최적화된 문장을 제시합니다.
  4. **해설 및 조언:** 명언과 고민의 연결 고리를 설명하고 따뜻한 통찰력을 제공합니다.

  ## 출력 형식 (Strict JSON)
  모든 답변은 반드시 아래의 JSON 스키마를 따라야 하며, JSON 데이터 외의 일반 텍스트나 설명은 포함하지 마십시오.

  {
    "mentor_quote": "선정된 인물의 명언 (큰따옴표 포함)",
    "person_info": "이름 - 간단한 수식어 및 직업",
    "insight": "이 명언이 사용자의 고민과 어떻게 연결되는지, 어떤 마음가짐을 가져야 하는지에 대한 3~4문장의 깊이 있는 설명",
    "action_question": "사용자가 스스로 생각해보거나 행동할 수 있는 짧은 질문"
  }

  ## 제약 사항
  - JSON 형식의 문법 오류가 없어야 합니다.
  - 한국어로 답변하되, 인물의 특성과 말투의 무게감을 유지하세요.
  - 결과값에 마크다운 코드 블록(```json ... ```)을 사용하지 말고 순수 JSON 문자열만 출력하세요.
  ''';

  Future<QuoteModel?> generateContent(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_modelId:generateContent',
    );

    final headers = {'Content-Type': 'application/json', 'x-goog-api-key': _apiKey};

    final Map<String, Object> body = {
      'contents': [
        {
          'parts': [
            {'text': prompt},
          ],
        },
      ],
      'system_instruction': {
        'parts': [
          {'text': systemInstruction},
        ],
      },
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // 전체 응답 파싱
        final jsonResponse = jsonDecode(response.body);
        print('return JSON: $jsonResponse');

        // 텍스트 추출
        if (jsonResponse['candidates'] != null && (jsonResponse['candidates'] as List).isNotEmpty) {
          final candidate = jsonResponse['candidates'][0];
          final parts = candidate['content']['parts'] as List;

          if (parts.isNotEmpty) {
            String textContent = parts[0]['text'];

            try {
              final Map<String, dynamic> parsedData = jsonDecode(textContent);
              return QuoteModel.fromJson(parsedData);
            } catch (e) {
              print('내부 JSON 파싱 실패: $e');
              return null;
            }
          }
        }
        return null;
      } else {
        throw Exception('API Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed: $e');
    }
  }
}
