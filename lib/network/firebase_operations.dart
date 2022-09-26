
import 'dart:developer';

import 'package:acme_health_tracker_assignment/models/health_data_model.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/controllers/tracker_widget_controller.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class FirebaseOperations {

  FirebaseAnalytics analytics=FirebaseAnalytics.instance;
  final RecordsPageController _recordsPageController =
      Get.put(RecordsPageController());

  final TrackerWidgetController _trackerWidgetController =
      Get.put(TrackerWidgetController());

  fetchData() {
    /*_recordsPageController.weightRecords.value=[];
     _recordsPageController.exerciseRecords.value=[];
     _recordsPageController.bloodPressureRecords.value=[];*/
     _recordsPageController.records=[[],[],[]];

    log("-----------Fetch Data Function");

    // CollectionReference users=FirebaseFirestore.instance.collection('Users');
    FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((QuerySnapshot querySnapshot1) {
      querySnapshot1.docs.forEach((doc1) {
        if (doc1.id == "QwkJSRRjFu9PWncnQxhb") {
          log("Document = ${doc1.data()}");
          FirebaseFirestore.instance
              .collection("Users/${doc1.id}/health_data")
              .orderBy("createdOn",descending: true)
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              // var time = doc['createdOn'].toDate();

              log("Value of doc = ${doc.data()}");

              var record = UserDataModel.fromJson({
                "id": doc.id,
                "type": doc['type'],
                "value": doc["value"].toString(),
                "createdOn": doc['createdOn'],
              });

              log("-------Record = ${record.id}");

              if (record.type == "weight") {
                _recordsPageController.records[0].add(record);
                // _recordsPageController.weightRecords.value.add(record);
                // _trackerWidgetController.latestWeight.value=record.value;

              } else if (record.type == "blood_pressure") {
                log("bp");
                _recordsPageController.records[1].add(record);
                // _recordsPageController.bloodPressureRecords.value.add(record);
                //  _trackerWidgetController.latestBP.value=record.value;
              } else {
                log("exe");
                _recordsPageController.records[2].add(record);
                // _recordsPageController.exerciseRecords.value.add(record);
                // _trackerWidgetController.latestExercise.value=record.value;
              }
            });
           /* _recordsPageController.records.forEach((recordList) { 
              log("Sort function");
              recordList.sort(((a, b) {
                log("Sort function 1");

                log("${a.createdOn},${b.createdOn}");
                b.createdOn.compareTo(a.createdOn);
                return 0;
              }));
            });*/
          });
        } else {
          log("No");
        }
      });
    });
  }

  storeData(data) {
    return FirebaseFirestore.instance
        .collection('/Users/QwkJSRRjFu9PWncnQxhb/health_data')
        .add(data);
  }

  update(id, data) {
    return FirebaseFirestore.instance
        .collection('/Users/QwkJSRRjFu9PWncnQxhb/health_data')
        .doc(id)
        .update(data)
        .then((_) => log("Updated Value"))
        .catchError((onError) => log("Error Occured While Updating"));
  }
}
