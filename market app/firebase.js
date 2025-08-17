// firebase.js — put your Firebase Web config here
// Step: create Firebase project -> add Web app -> copy config here
const FIREBASE_CONFIG = {
  apiKey: "REPLACE_API_KEY",
  authDomain: "REPLACE_PROJECT.firebaseapp.com",
  projectId: "REPLACE_PROJECT",
  storageBucket: "REPLACE_PROJECT.appspot.com",
  messagingSenderId: "REPLACE_SENDER_ID",
  appId: "REPLACE_APP_ID"
};

if (!window.firebase) {
  console.error('Firebase SDK not loaded!');
} else {
  firebase.initializeApp(FIREBASE_CONFIG);
}
