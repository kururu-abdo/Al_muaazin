import 'dart:convert';

class AppModel{
  String  date;
  String day;
  String city;
  

  Map<dynamic , dynamic>  timing;

  AppModel(this.date , this.day ,this.city , this.timing);


 
  AppModel.fromJson(Map<String, dynamic> json) {
    date = json['data']['date']['timestamp'];
    day = json['data']['date']['hijri']['weekday']['ar'];
    city= json['data']['meta']['timezone'];
    timing=json['data']['timings'];
   

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.date;
    data['weekday']= this.day;
    data['timezone'] = this.city;
    data['timings']= this.timing;
    



    return data;
  }

}