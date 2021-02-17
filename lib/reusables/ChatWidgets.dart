
import 'package:cut_gigs/config/preferences.dart';
import 'package:cut_gigs/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class ChatWidgets {

  static buildMessage(BuildContext context, String message, bool isLiked, DateTime createdAt, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Colors.red[400],
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat('hh:mm a').format(createdAt),
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: isLiked
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  static buildMessageComposer(BuildContext context, String eventID) {

    final TextEditingController _message = new TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextFormField(
              autofocus: false,
              controller: _message,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {_message.text = value; print(_message.text);},
              onSaved: (value) {
                try{
                  SystemChannels.textInput.invokeMethod('TextInput.hide');

                  if(_message.text.trim().isNotEmpty){
                    DatabaseService(uid: Preferences.uid).postMessage(_message.text, eventID);
                  }

                }catch(e) {
                  print(e.toString());
                }
              },
              onFieldSubmitted: (value) {
                try{
                  SystemChannels.textInput.invokeMethod('TextInput.hide');

                  if(_message.text.trim().isNotEmpty){
                    DatabaseService(uid: Preferences.uid).postMessage(_message.text, eventID);
                  }

                }catch(e) {
                  print(e.toString());
                }
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.black26,
            onPressed: () {

              try{
                SystemChannels.textInput.invokeMethod('TextInput.hide');

                if(_message.text.trim().isNotEmpty){
                  DatabaseService(uid: Preferences.uid).postMessage(_message.text, eventID);
                }

              }catch(e) {
                print(e.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}