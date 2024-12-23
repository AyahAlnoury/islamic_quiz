import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:islamic_quiz/core/colors/app_colors.dart";
import "package:islamic_quiz/features/timer/presentation/views/widgets/timer_value.dart";

class TimerWidget extends ConsumerWidget {
  const TimerWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.timerBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.amber[200]!,
              blurRadius: 8,
              spreadRadius: 8,
              offset: const Offset(0, 0),
            ),
            const BoxShadow(
              color: Colors.amber,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: const Center(
          child: TimerValue(),
        ));
  }
}
