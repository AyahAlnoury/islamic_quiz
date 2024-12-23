import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:islamic_quiz/features/quiz/data/model/question_model.dart";
import "package:islamic_quiz/features/quiz/presentation/view_model/question_provider/question_provider.dart";
import "package:islamic_quiz/features/quiz/presentation/views/widgets/build_question_widget.dart";
import "package:islamic_quiz/features/timer/presentation/view_model/timer_provider.dart";

class QuestionWidget extends ConsumerWidget {
  const QuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<QuestionModel> question = ref.watch(questionsProvider);
    ref.invalidate(timerProvider);

    return question.maybeWhen(
      data: (data) {
        return BuildQuestion(question: data);
      },
      orElse: () {
        return const SizedBox();
      },
    );
  }
}
