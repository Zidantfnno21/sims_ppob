import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionItemShimmer extends StatelessWidget {
  const TransactionItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Container(
            height: 16,
            width: 100,
            color: Colors.white,
          ),
          subtitle: Container(
            height: 14,
            width: 80,
            color: Colors.white,
          ),
          trailing: Container(
            height: 16,
            width: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
