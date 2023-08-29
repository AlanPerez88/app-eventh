import 'dart:convert';

class Event {
    String detail;
    String image;
    String name;
    String? id;
    Event({
        required this.detail,
        required this.image,
        required this.name,
    });

    factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

    
    factory Event.fromMap(Map<String, dynamic> json) => Event(
        detail: json["detail"],
        image: json["image"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "detail": detail,
        "image": image,
        "name": name,
    };
}

