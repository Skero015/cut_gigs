import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/models/Message.dart';
import 'package:cut_gigs/notifiers/event_notifier.dart';
import 'package:cut_gigs/reusables/ChatWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  EventNotifier eventNotifier;

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    eventNotifier = Provider.of<EventNotifier>(context, listen: false);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 55.0, 25.0, 25.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 39,
                              ),
                              Text('Back',
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 0.8)),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: getChatMessages(eventNotifier.currentEvent.eventID),
                      builder: (context, snapshot) {
                        print(snapshot.connectionState.toString());
                        return snapshot.connectionState == ConnectionState.active  && snapshot.hasData? ListView.builder(
                          reverse: false,
                          padding: EdgeInsets.only(top: 15.0),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(snapshot.data.docs[index]['senderID']);
                            DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data.docs[index]['createdAt'].millisecondsSinceEpoch);
                            final bool isMe = snapshot.data.docs[index]['senderID'] == Preferences.uid;
                            return ChatWidgets.buildMessage(this.context, snapshot.data.docs[index]['message'], snapshot.data.docs[index]['isLiked'], eventDate, isMe);
                          },
                        ) : Container();
                      }
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ChatWidgets.buildMessageComposer(context, eventNotifier.currentEvent.eventID),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
