import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shopibee/views/chat_screen/chat_screen.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getMessages(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const CircularProgressIndicator(color: redColor,).centered();
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No Messages found".text.bold.size(20).color(fontGrey).makeCentered();
            }
            else{
              return ListView(
                children: List.generate(snapshot.data!.docs.length, (index){
                  var snap=snapshot.data!.docs;
                  return ListTile(
                    onTap: (){
                      Get.to(()=>const ChatScreen(),arguments: [
                        snap[index]['to_id'],snap[index]['friend_name']
                      ]);
                    },
                    leading: VxCircle(child: Icon(Icons.person),radius: 80,),
                    title: "${snap[index]['friend_name']}".text.bold.make(),
                    subtitle: "${snap[index]['last_message']}".text.make(),
                    trailing: intl.DateFormat.yMMMd().format(snap[index]['created_on'].toDate()).text.make(),
                  );
                }),
              );
            }
          }),
    );
  }
}
