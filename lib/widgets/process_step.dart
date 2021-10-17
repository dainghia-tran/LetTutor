import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProcessStep extends StatelessWidget {
  const ProcessStep(
      {Key? key,
      required this.order,
      required this.content,
      required this.isCurrentStep,
      required this.isDone})
      : super(key: key);
  final order;
  final content;
  final isCurrentStep;
  final isDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isDone
            ? Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.indigo, width: 1)),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.indigo,
                    size: 16,
                  ),
                ),
              )
            : Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isCurrentStep ? Colors.indigo : Colors.white,
                    border: Border.all(
                        color: isCurrentStep ? Colors.transparent : Colors.grey,
                        width: 1)),
                child: Center(
                  child: Text(
                    order.toString(),
                    style: TextStyle(
                        color: isCurrentStep ? Colors.white : Colors.grey),
                  ),
                ),
              ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              content,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isCurrentStep ? Colors.black : Colors.black38),
            ),
          ),
        )
      ],
    );
  }
}
