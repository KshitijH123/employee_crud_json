import 'dart:convert';

class Employee {
  final String id;
  final String name;
  final String position;
  final double salary;

  Employee(
      {required this.id,
      required this.name,
      required this.position,
      required this.salary});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      salary: json['salary'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
    };
  }
}
