import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/FeedbackM/view_feedback_model.dart';

class ViewFeedbackService {
  Future<List<ViewFeedbackModel>> getFeedbacks(
      int studentId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://dbs.online-tech.in/api/StudentApi/ViewFeedback?stdId=$studentId",
        ),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data
            .map((e) => ViewFeedbackModel.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}