import 'package:flutter/material.dart';
import 'package:todo_app/helpers/colors.dart';
import 'package:todo_app/helpers/utils.dart';

class CardColor {
  final TaskPageStatus page;
  final bool isCompleted;

  CardColor(this.page, this.isCompleted);

  List<Color> get background {
    switch (page) {
      case TaskPageStatus.all:
        return isCompleted
            ? [AppColors.disabled, Colors.black45]
            : [AppColors.primaryAccent, AppColors.primaryLight];
        break;
      case TaskPageStatus.completed:
        return [AppColors.disabled, AppColors.disabled];
        break;
      default:
        return [AppColors.primarySoft, AppColors.primary];
        break;
    }
  }

  Color get texts {
    if (page == TaskPageStatus.all && !isCompleted) {
      return Colors.white;
    } else if (isCompleted) {
      return Colors.black26;
    }
    return Colors.black45;
  }
}
