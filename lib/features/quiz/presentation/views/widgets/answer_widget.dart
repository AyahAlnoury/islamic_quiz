import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:islamic_quiz/core/colors/app_colors.dart";
import "package:islamic_quiz/features/end/view_model/end_provider.dart";
import "package:islamic_quiz/features/quiz/presentation/view_model/answer_provider/answer_provider.dart";
import "package:islamic_quiz/features/quiz/presentation/view_model/question_provider/question_provider.dart";
import "package:islamic_quiz/features/quiz/presentation/view_model/quiz_provider/quiz_provider.dart";
import "package:islamic_quiz/features/score/presentation/model_view/score_provider/score_provider.dart";
import "package:islamic_quiz/features/timer/presentation/view_model/timer_provider.dart";

class AnswerWidget extends ConsumerWidget {
  const AnswerWidget({
    super.key,
    required this.text,
    required this.index,
  });

  final String text;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime currentBackPressTime = DateTime.now();
    Color buttonBackground = ref.watch(answerProvider(index));
    final quizIndexP = ref.read(quizIndexProvider.notifier);
    return InkWell(
      onTap: () async {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) < const Duration(seconds: 2)) {
          // double tapped
          return;
        }
        currentBackPressTime = now;
        // check the answer and
        bool isCorrect =
            ref.read(questionsProvider.notifier).checkAnswer(index);
        if (isCorrect) {
          ref.read(answerProvider(index).notifier).showCorrectAnswer();
          // wait for 2 seconds then go to the next question
          await Future.delayed(const Duration(seconds: 1)).then((_) {
            quizIndexP.nextQuestion();
          });

          // update the score
          final timerState = ref.watch(timerProvider);
          int? score = timerState.asData?.value.duration;
          if (score != null) {
            ref.read(scoreProvider.notifier).addScore(score * 7);
          }
        } else {
          // todo: show the correct answer
          // show the wrong answer animation
          ref.read(answerProvider(index).notifier).showWrongAnswer();
          // wait for 2 seconds
          await Future.delayed(const Duration(seconds: 2), () {
            int score = ref.read(scoreProvider);
            // add score to the high scores

            // end game
            endGame(score);
          });
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: buttonBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 4,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.secondary,
                ),
          ),
        ),
      ),
    );
  }
}
