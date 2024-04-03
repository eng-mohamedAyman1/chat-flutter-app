import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/HomeScreen.dart';
import 'package:scholar_chat/widgets/ChatMassage.dart';
import 'package:scholar_chat/widgets/TextFieldUsed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MassageScreen extends StatefulWidget {
  const MassageScreen({Key? key}) : super(key: key);
  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {
  String? textOfMassage;
  CollectionReference massage = FirebaseFirestore.instance.collection('massages');
  // Stream collectionStream = FirebaseFirestore.instance.collection('massages').snapshots();
  TextEditingController? controller = TextEditingController();
  ScrollController? controllerForListbuilder = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: massage.orderBy('createAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> textOfMassages = [];
            List<String> emailOfMassages = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              textOfMassages.add(snapshot.data!.docs[i]["massage"]);
              emailOfMassages.add(snapshot.data!.docs[i]["id"]);
            }
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){
                    credential.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  }, icon: Icon(Icons.close, color: Colors.white))
                ],
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xff2B475E),
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      width: 75,
                    ),
                    const Text(
                      ' Chat',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse:true ,
                          controller: controllerForListbuilder,
                          itemCount: textOfMassages.length,
                          itemBuilder: (context, index) {
                            if(emailOfMassages[index]==credential.currentUser?.email){
                              return ChatMassage(
                                text: textOfMassages[index],
                                direction: Direction.left,
                              );
                            }else{
                              return ChatMassage(
                                text: textOfMassages[index],
                                direction: Direction.right,
                              );
                            }

                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFieldUsed(
                          onChanged: (data) {
                            textOfMassage = data;
                          },
                          color: Colors.indigo[300],
                          onFieldSubmitted: (data) {
                            textOfMassage = data;
                            if (textOfMassage != null) {
                              massage.add({
                                'massage': textOfMassage,
                                'createAt': DateTime.now(),
                                'id': credential.currentUser?.email
                              });
                              controller!.clear();
                              controllerForListbuilder?.animateTo(
                                  0,
                                  duration: const Duration(microseconds:500 ),
                                  curve: Curves.fastOutSlowIn);
                            }
                          },
                          controller: controller,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (textOfMassage != null) {
                                massage.add({
                                  'massage': textOfMassage,
                                  'createAt': DateTime.now(),
                                  'id': credential.currentUser?.email
                                });
                                controller!.clear();
                                controllerForListbuilder?.animateTo(
                                    0,
                                    duration: Duration(microseconds:500 ,),
                                    curve: Curves.fastOutSlowIn);
                              }
                            },
                          ),
                          hintText: "Send Message",
                        ),
                      ),
                    ],
                  )),
            ));
          } else {
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff2B475E),
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      width: 75,
                    ),
                    const Text(
                      ' Chat',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                        // ListView.builder(
                        //   itemCount: textOfMassages.length,
                        //   itemBuilder: (context, index) {
                        //     return ChatMassage(
                        //       text:textOfMassages[index] ,
                        //       direction: Direction.left,
                        //     );
                        //   },
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFieldUsed(
                          onChanged: (data) {
                            textOfMassage = data;
                          },
                          color: Colors.indigo[300],
                          onFieldSubmitted: (data) {
                            textOfMassage = data;
                            if (textOfMassage != null) {
                              massage.add({
                                'massage': textOfMassage,
                              });
                              controller!.clear();
                            }
                          },
                          controller: controller,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (textOfMassage != null) {
                                massage.add({
                                  'massage': textOfMassage,
                                });
                                controller!.clear();
                              }
                            },
                          ),
                          hintText: "Send Message",
                        ),
                      ),
                    ],
                  )),
            ));
          }
        });
  }
}
