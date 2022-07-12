import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/detail_chat_page.dart';
import 'package:shamo/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 33),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, DetailChatPage.routes);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailChatPage(
                product: UninitializedProductModel(),
              ),
            ),
          );
        },
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: 54,
                  height: 54,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shoe Store",
                        style: primaryTextStyle.copyWith(fontSize: 15),
                      ),
                      Text(
                        "Good night, This item is avalable on weekend",
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Now",
                  style: secondaryTextStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            ),
          ],
        ),
      ),
    );
  }
}
