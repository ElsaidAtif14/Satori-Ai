import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:test_ai/core/constants/api_constants.dart';
import 'package:test_ai/core/error/custom_exception.dart';

abstract class GeminiRemoteDataSource {
  Future<String> sendMessageToGemini(String prompt);
}

class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
  final GenerativeModel _model;

  GeminiRemoteDataSourceImpl()
    : _model = GenerativeModel(
        model: ApiConstants.modelName,
        apiKey: ApiConstants.geminiApiKey,
      );

  @override
  Future<String> sendMessageToGemini(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        return response.text!;
      } else {
        throw CustomException('جيمناي لم يرجع أي نص.');
      }
    } on GenerativeAIException catch (e) {
      String m = e.message;
      debugPrint('!!! GEMINI API ORIGINAL ERROR: $m');

      String cleanMessage = 'حدث خطأ في الاتصال بالسيرفر.';

      if (m.contains('quota') || m.contains('limit')) {
        cleanMessage =
            'لقد تخطيت الحد المسموح به من الطلبات حالياً. يرجى الانتظار دقيقة وإعادة المحاولة.';
      } else if (m.contains('503') ||
          m.contains('temporary') ||
          m.contains('demand')) {
        cleanMessage =
            'السيرفر مشغول حالياً بسبب ضغط الطلبات، جرب مرة أخرى بعد قليل.';
      } else if (m.contains('API key')) {
        cleanMessage = 'هناك مشكلة في صلاحية الـ API Key الخاص بالتطبيق.';
      } else {
        cleanMessage = m.split('\n').first;
      }

      throw CustomException(cleanMessage);
    } catch (e) {
      String m = e.toString();
      debugPrint('!!! GENERAL ERROR: $m');
      throw CustomException('تأكد من اتصالك بالإنترنت وأعد المحاولة.');
    }
  }
}