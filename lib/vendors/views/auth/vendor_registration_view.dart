import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorRegistrationView extends StatelessWidget {
  const VendorRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.yellow.shade900, Colors.yellow])),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(CupertinoIcons.photo)),
                            )
                          ]),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
