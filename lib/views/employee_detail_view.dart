import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/employee.dart';
import '../viewmodels/employee_view_model.dart';

class EmployeeDetailView extends StatefulWidget {
  final Employee? employee;

  EmployeeDetailView({this.employee});

  @override
  _EmployeeDetailViewState createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _position;
  late double _salary;

  @override
  void initState() {
    super.initState();
    _name = widget.employee?.name ?? '';
    _position = widget.employee?.position ?? '';
    _salary = widget.employee?.salary ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _position,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a position' : null,
                onSaved: (value) => _position = value!,
              ),
              TextFormField(
                initialValue: _salary.toString(),
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a salary' : null,
                onSaved: (value) => _salary = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.employee == null ? 'Add' : 'Update'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final viewModel = context.read<EmployeeViewModel>();
      if (widget.employee == null) {
        viewModel.addEmployee(Employee(
          id: DateTime.now().toString(),
          name: _name,
          position: _position,
          salary: _salary,
        ));
      } else {
        viewModel.updateEmployee(Employee(
          id: widget.employee!.id,
          name: _name,
          position: _position,
          salary: _salary,
        ));
      }
      Navigator.pop(context);
    }
  }
}
