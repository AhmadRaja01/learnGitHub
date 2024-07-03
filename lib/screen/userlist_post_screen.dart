import 'package:api/api_service/userlist_post_api_service.dart';
import 'package:api/api_models/userlist_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserListPostPage extends StatefulWidget {
  const UserListPostPage({Key? key}) : super(key: key);

  @override
  State<UserListPostPage> createState() => _UserListPostPageState();
}

class _UserListPostPageState extends State<UserListPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  List<UserPost> _createdUsers = [];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserPost user = await createUser(_nameController.text, _jobController.text);
        setState(() {
          _createdUsers.add(user);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User Post Successful')),
        );
        _nameController.clear();
        _jobController.clear();

        Navigator.pop(context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Post user')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.purple,
        title: const Text(
          'UserList Post Api ( Reqres )',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add User'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _jobController,
                        decoration: InputDecoration(labelText: 'Job'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Post User'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _createdUsers.isEmpty
            ? Center(
          child: Text('No added data..',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        )
            : Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _createdUsers.length,
                itemBuilder: (context, index) {
                  final user = _createdUsers[index];
                  return Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Post User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('ID: ${user.id ?? "N/A"}'),
                            Text('Name: ${user.name}'),
                            Text('Job: ${user.job}'),
                            Text('Created At: ${user.createdAt ?? "N/A"}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
