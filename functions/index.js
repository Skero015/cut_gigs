const firebase = require('firebase');
const functions = require("firebase-functions");
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});

var config = {
    apiKey: "AIzaSyCO6TiV1mRZESSALvHJqbr7pCKQRlch5Ak",
    authDomain: "noreply@cut-gigs-30f0e.firebaseapp.com",
    databaseURL: "https://<DATABASE_NAME>.firebaseio.com",
    projectId: 'cut-gigs-30f0e',
    appId: '1:331210954672:android:db97c357c44ce9c60ba875',
    storageBucket: "gs://cut-gigs-30f0e.appspot.com",
    messagingSenderId: "331210954672",
};

firebase.initializeApp(config);
admin.initializeApp(config);

const db = admin.firestore();
const fcm = admin.messaging();

const mailgun = require("mailgun-js");
const api_key = '3b0190bdd2a5bb14a194d1884bdee0cb-4de08e90-c78c9fa0';
const DOMAIN = 'sandbox34d37e7bfbd24187b015203924961775.mailgun.org';
const mg = mailgun({apiKey: api_key, domain: DOMAIN});

//sign out user
exports.userSignOut = functions.https.onCall(async (data, context) => {
    await firebase.auth().signOut();
    console.log('sign out');
});

//emails
exports.sendSpeakerRequestEmail = functions.https.onCall(async (data, context) => {

    var data = {
          from: data.email,
          to: 'osamgroupt@gmail.com',
          subject: 'Hello from Mailgun',
          html: 'Hello, This is not a plain-text email, I wanted to test some spicy Mailgun sauce in NodeJS! <a href="http://0.0.0.0:3030/validate?' + req.params.mail + '">Click here to add your email address to a mailing list</a>'
        }

    mg.messages().send(data, function (error, body) {
        if (error) {
            res.render('error', {error: error});
        }
        else {
            console.log("attachment sent", fp);
        }
    });
    
});

//firebase messaging
exports.sendToTopic = functions.firestore.document('Events/{eventId}')
.onUpdate( async (change, context) => {

    const updatedEvent = change.after.data();

    const tokensSnapshot = await db.collection('Events')
        .doc(updatedEvent.eventID)
        .collection('Tokens')
        .get();

    const tokens = tokensSnapshot.docs.map(snap => snap.id);
    console.log('got token from: ' + updatedEvent.eventID);
    console.log('token: ' + tokens);

    const payload = admin.messaging.MessagingPayload = {
        notification: {
            title: updatedEvent.title,
            body: "Details about " + updatedEvent.title + " event have been updated. Click to view updated information about the event.",
            image: updatedEvent.image,
            sound: 'default',
            logo: updatedEvent.image,
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
    };

    return fcm.sendToTopic('Events', payload);
});