// views/employee_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/employee_view_model.dart';
import 'employee_detail_view.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<EmployeeViewModel>().loadEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List',
            style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<EmployeeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.employees.isEmpty) {
            return Center(child: Text('No employees found'));
          }
          return ListView.builder(
            itemCount: viewModel.employees.length,
            itemBuilder: (context, index) {
              final employee = viewModel.employees[index];
              return Dismissible(
                key: Key(employee.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  viewModel.deleteEmployee(employee.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${employee.name} deleted')),
                  );
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text(
                            "Are you sure you want to delete ${employee.name}?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("CANCEL"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("DELETE"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      child: Text(employee.name[0]),
                      backgroundColor: Colors.blue[200],
                    ),
                    title: Text(employee.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(employee.position),
                    trailing: Text('\$${employee.salary.toStringAsFixed(2)}'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              EmployeeDetailView(employee: employee)),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EmployeeDetailView()),
        ),
      ),
    );
  }
}

// ... (rest of the code remains the same)