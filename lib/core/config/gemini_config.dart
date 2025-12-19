class GeminiConfig {
  final String apiKey;
  final String modelId;
  final String version;
  final String baseUrl;
  final String generateContentApi;

  const GeminiConfig({
    required this.apiKey,
    this.modelId = 'gemini-3-flash-preview',
    this.version = 'v1beta',
    this.baseUrl = 'https://generativelanguage.googleapis.com',
    this.generateContentApi = 'generateContent',
  });

  Uri get generateContentUrl => Uri.parse('$baseUrl/$version/models/$modelId:$generateContentApi');
}
