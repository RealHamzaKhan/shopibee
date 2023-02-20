import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/chats_controller.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/chat_screen/components/sender_bubble.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        foregroundColor: fontGrey,
        title: '${controller.friendName}'.text.fontFamily(bold).make(),
      ),
      body: Column(
        children: [
          Obx(()=>
            controller.isLoading.value?const CircularProgressIndicator().centered().expand():
            Expanded(
                child: StreamBuilder(
                    stream: FireStoreServices.getChatMessage(docId: controller.chatDocId),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData || snapshot.data==null){
                    return const CircularProgressIndicator().centered();
                  }
                  else if(snapshot.data!.docs.isEmpty){
                    return "Start a conversation with the seller".text.fontFamily(bold).size(20).color(fontGrey).makeCentered();
                  }
                  else{
                    return ListView(
                        children:snapshot.data!.docs.mapIndexed((currentValue, index){
                          var snap=snapshot.data!.docs[index];
                          bool isSender=snap['uid']==user!.uid?true:false;
                      return Align(
                          alignment: isSender?Alignment.centerRight:Alignment.centerLeft,
                          child: senderBubble(data: snapshot.data!.docs[index],isSender: isSender));
                    }).toList());
                  }
                })),
          ),
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: controller.messageController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Message....',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.blueGrey.withOpacity(0.2),
                  filled: true,
                ),
              )),
              IconButton(onPressed: (){
                controller.sendMsg(msg: controller.messageController.text);
                controller.messageController.clear();
              }, icon: const Icon(Icons.send,color: Colors.green,)),
            ],
          ).box.margin(const EdgeInsets.symmetric(vertical: 10)).make()
        ],
      ).p12(),
    );
  }
}
