import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppManager/ViewModel/FeedbackVM/view_feedback_vm.dart';
import '../core/constants/app_colors.dart';

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({super.key});

  @override
  State<ViewFeedback> createState() =>
      _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {

  @override
  void initState() {
    super.initState();
    loadFeedbacks();
  }

  Future<void> loadFeedbacks() async {
    final prefs = await SharedPreferences.getInstance();

    int studentId = prefs.getInt("user_id") ?? 0;
    debugPrint("Student ID => $studentId");

    if (!mounted) return;

    context.read<ViewFeedbackViewModel>().getFeedbacks(studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.background,
        ),
        title: Text(
          "View Feedback",
          style: GoogleFonts.poppins(
            color: AppColors.background,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<ViewFeedbackViewModel>(
          builder: (context, vm, child) {
        
            if (vm.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        
            if (vm.feedbackList.isEmpty) {
              return const Center(
                child: Text("No Feedback Found"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.feedbackList.length,
              itemBuilder: (context, index) {

                final feedback =
                vm.feedbackList[index];

                return Card(
                color: AppColors.background,
                  elevation: 2,
                  margin:
                  const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         "ID : ${feedback.id}",
                        //         style: GoogleFonts.poppins(
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w600,
                        //           color: AppColors.primary,
                        //         ),
                        //       ),
                        //     ),
                        //     Text(
                        //       "Student ID : ${feedback.studentId}",
                        //       style: GoogleFonts.poppins(
                        //         fontSize: 13,
                        //         fontWeight: FontWeight.w600,
                        //         color: AppColors.primary,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(height: 8),
                        Text(
                          feedback.title,
                          style:
                          GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          feedback.description,
                          style:
                          GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                feedback.createdDate,
                                style:
                                GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (feedback.remark != null)
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 8),
                            child: Text(
                              "Remark : ${feedback.remark}",
                              style:
                              GoogleFonts.poppins(
                                color:
                                Colors.green,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}