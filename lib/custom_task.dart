import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomTask extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteFunction;
  final Function(BuildContext?)? editFunction;
  const CustomTask(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      this.onChanged, this.deleteFunction, this.editFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
      child: Slidable(
        startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(onPressed: editFunction,
              icon: Icons.edit,
                backgroundColor: Colors.greenAccent,
                borderRadius: BorderRadius.circular(15),
              )
            ]),
        //=======End =====
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(onPressed: deleteFunction,
              icon: Icons.delete_forever,foregroundColor: Colors.white,
                backgroundColor: Colors.red.shade400,
                borderRadius: BorderRadius.circular(15),
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Checkbox(
                  value: taskCompleted,
                  side: BorderSide(color: Colors.white),
                  onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
