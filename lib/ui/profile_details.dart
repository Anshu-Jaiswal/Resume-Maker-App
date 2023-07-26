import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:resume_maker/global/gInfo.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    final profile = gInfo.profile;
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Details")),
      body: ListView(children: [
        _listTile("First Name", profile.firstName),
        _listTile("Last Name", profile.lastName),
        _listTile("Email", profile.email),
        _listTile("Phone No", profile.phoneNumber),
        _listTile("Location", profile.location),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _editFabBtn(),
    );
  }

  _listTile(String head, String? end) => ListTile(title: Text("$head: ${end ?? 'Empty'}"));

  _editFabBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );

            setState(() {});
          },
          child: const Icon(Icons.edit)),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtr = TextEditingController();
  final TextEditingController _lastNameCtr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();
  final TextEditingController _phoneNoCtr = TextEditingController();
  final TextEditingController _locationCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameCtr.text = gInfo.profile.firstName;
    _lastNameCtr.text = gInfo.profile.lastName ?? '';
    _emailCtr.text = gInfo.profile.email;
    _phoneNoCtr.text = gInfo.profile.phoneNumber ?? '';
    _locationCtr.text = gInfo.profile.location ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameCtr,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "First name can not be blank";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameCtr,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                controller: _emailCtr,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty || EmailValidator.validate(value) == false) {
                    return "Email can not be blank";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNoCtr,
                decoration: const InputDecoration(labelText: "PhoneNo"),
              ),
              TextFormField(
                controller: _locationCtr,
                decoration: const InputDecoration(labelText: "Location"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;

          String fn = _firstNameCtr.text;
          gInfo.profile.firstName = fn;

          String? ln = _lastNameCtr.text.isNotEmpty ? _lastNameCtr.text : null;
          gInfo.profile.lastName = ln;

          String em = _emailCtr.text;
          gInfo.profile.email = em;

          String? pn = _phoneNoCtr.text.isEmpty ? null : _phoneNoCtr.text;
          gInfo.profile.phoneNumber = pn;

          String? lc = _locationCtr.text.isEmpty ? null : _locationCtr.text;
          gInfo.profile.location = lc;

          // ====================
          // go back

          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameCtr.dispose();
    _lastNameCtr.dispose();
    _emailCtr.dispose();
    _locationCtr.dispose();
    _phoneNoCtr.dispose();

    super.dispose();
  }
}
