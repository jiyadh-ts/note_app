import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final List<Map> noteList;
  final int index;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final void Function()? onShare;

  const MyCard({
    super.key,
    required this.noteList,
    required this.index,
    this.onDelete,
    this.onEdit,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  noteList[index]["Title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, size: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              noteList[index]["Description"],
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, size: 18),
                ),
                SizedBox(width: 10),
                Text(
                  noteList[index]["Date"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: onShare,
                  icon: Icon(Icons.share, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
