import 'package:flutter/foundation.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeService _service = EmployeeService();
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  Future<void> loadEmployees() async {
    _employees = await _service.getEmployees();
    notifyListeners();
  }

  Future<void> addEmployee(Employee employee) async {
    _employees.add(employee);
    await _service.saveEmployees(_employees);
    notifyListeners();
  }

  Future<void> updateEmployee(Employee employee) async {
    int index = _employees.indexWhere((e) => e.id == employee.id);
    if (index != -1) {
      _employees[index] = employee;
      await _service.saveEmployees(_employees);
      notifyListeners();
    }
  }

  Future<void> deleteEmployee(String id) async {
    _employees.removeWhere((e) => e.id == id);
    await _service.saveEmployees(_employees);
    notifyListeners();
  }
}
