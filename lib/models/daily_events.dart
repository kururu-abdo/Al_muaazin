class Event{
  int id;
  String name;
 int hour;
 int  minute;

Event(this.id  , this.name ,this.hour ,this.minute);


Event.fromJson(Map<dynamic ,dynamic> data){

  this.id = data['id'];
  this.name= data['name'];
  this.hour =data['hour'];
  this.minute = data['minute'];
}



Map<dynamic ,dynamic> toJson()=> {'id' :this.id ,'name':this.name ,'hour':this.hour ,'minute':this.minute};

}