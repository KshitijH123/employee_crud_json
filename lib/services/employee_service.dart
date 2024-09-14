import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/employee.dart';

class EmployeeService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    return File('assets/employees.json');
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => Employee.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveEmployees(List<Employee> employees) async {
    final file = await _localFile;
    String jsonString = json.encode(employees.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }
}
