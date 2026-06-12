import 'package:flutter/material.dart';

import '../../Model/FeedbackM/view_feedback_model.dart';
import '../../Service/FeedbackS/view_feedback_service.dart';

class ViewFeedbackViewModel extends ChangeNotifier {
  final ViewFeedbackService _service =
  ViewFeedbackService();

  bool isLoading = false;

  List<ViewFeedbackModel> feedbackList = [];

  Future<void> getFeedbacks(int studentId) async {
    try {
      isLoading = true;
      notifyListeners();

      feedbackList =
      await _service.getFeedbacks(studentId);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}