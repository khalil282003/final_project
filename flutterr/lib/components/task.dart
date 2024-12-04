// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class Task extends StatelessWidget {
//   const Task({
//     super.key,
//     required this.taskName,
//     required this.taskCompleted,
//     required this.onChanged,
//     required this.deleteFunction,
//   });

//   final String taskName;
//   final bool taskCompleted;
//   final Function(bool?)? onChanged;
//   final Function(BuildContext)? deleteFunction;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 20,
//         left: 20,
//         right: 20,
//         bottom: 0,
//       ),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const StretchMotion(),
//           children: [
//             SlidableAction(
//               onPressed: deleteFunction,
//               icon: Icons.delete,
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ],
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.deepPurple,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Row(
//             children: [
//               Checkbox(
//                 value: taskCompleted,
//                 onChanged: onChanged,
//                 checkColor: Colors.black,
//                 activeColor: Colors.white,
//                 side: const BorderSide(
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 taskName,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   decoration: taskCompleted
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                   decorationColor: Colors.white,
//                   decorationThickness: 2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.taskName,
    //required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String taskName;
  //final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteFunction?.call(context),
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: /*taskCompleted ? Colors.grey : */Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              /*Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                checkColor: Colors.black,
                activeColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),*/
              Expanded(
                child: Text(
                  taskName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: /*taskCompleted
                        ? TextDecoration.lineThrough
                        : */TextDecoration.none,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
