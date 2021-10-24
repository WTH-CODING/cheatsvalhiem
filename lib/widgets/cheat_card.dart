import 'package:cheatsvalhiem/models/spawnable_model.dart';
import 'package:flutter/material.dart';

class CheatCard extends StatelessWidget {
  final Spawnable spawnable;
  const CheatCard({Key? key, required this.spawnable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF192022),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spawnable.itemName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Spawn ${spawnable.itemName} ${spawnable.quantity}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'Spawns ${spawnable.quantity} ${spawnable.quantity > 1?"pieces":"piece"} of ${spawnable.itemName}',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '${spawnable.type}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star_border_rounded),
                  SizedBox(width: 8),
                  Icon(Icons.copy_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
