import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final firestoreInstance = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final timestamp = Timestamp.now().microsecondsSinceEpoch;

  final _formKey = GlobalKey<FormState>();

  // final _key = GlobalKey<State>();
  TextEditingController _category,
      _country,
      _date,
      _desc1,
      _desc2,
      _desc3,
      _hostName,
      _imageUrl,
      _place,
      _position,
      _price,
      _time,
      _title,
      _type;

  @override
  void initState() {
    // TODO: implement initState
    _category = TextEditingController();
    _country = TextEditingController();
    _date = TextEditingController();
    _desc1 = TextEditingController();
    _desc2 = TextEditingController();
    _desc3 = TextEditingController();
    _hostName = TextEditingController();
    _imageUrl = TextEditingController();
    _place = TextEditingController();
    _position = TextEditingController();
    _price = TextEditingController();
    _time = TextEditingController();
    _title = TextEditingController();
    _type = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "add event",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildTextFormField(controller: _title,
                  icon: Icons.title, hint: 'Enter title'),
              buildTextFormField(controller: _category,
                  icon: Icons.category, hint: 'Enter category'),
              buildTextFormField(controller: _country,
                  icon: Icons.account_tree_outlined, hint: 'Enter country'),
              buildTextFormField(controller: _position,
                  icon: Icons.place_outlined, hint: 'Enter position'),
              buildTextFormField(controller: _date,
                  icon: Icons.date_range, hint: 'Enter date'),
              buildTextFormField(controller: _desc1,
                  icon: Icons.description, hint: 'Enter desc1'),
              buildTextFormField(controller: _desc2,
                  icon: Icons.description, hint: 'Enter desc2'),
              buildTextFormField(controller: _desc3,
                  icon: Icons.description, hint: 'Enter desc3'),
              buildTextFormField(controller: _hostName,
                  icon: Icons.domain, hint: 'Enter hostName'),
              buildTextFormField(controller: _imageUrl,
                  icon: Icons.image, hint: 'Enter image Url'),
              buildTextFormField(controller: _place,
                  icon: Icons.place, hint: 'Enter place'),
              buildTextFormField(controller: _price,
                  icon: Icons.money, hint: 'Enter price'),
              buildTextFormField(controller: _time,
                  icon: Icons.time_to_leave, hint: 'Enter time'),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    firestoreInstance.collection("event").doc().set({
                      'category': _category.text,
                      'country': _country.text,
                      'positiononmap': _position.text,
                      'date': _date.text,
                      'desc1': _desc1.text,
                      'desc2': _desc2.text,
                      'desc3': _desc3.text,
                      'host_name': _hostName.text,
                      'id': timestamp.toString(),
                      'imageUrl': _imageUrl.text,
                      'place': _place.text,
                      'price': _price.text,
                      'time': _time.text,
                      'title': _title.text,
                      'type': _type.text,
                    }, SetOptions(merge: true)).then((_) {
                      print("success!");
                      return showInSnackBar("success");
                    });
                  }
                },
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Center(child: Text(value))));
  }

  TextFormField buildTextFormField({controller, icon, hint}) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: hint,
        hintStyle:
            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
        prefixIcon: Icon(icon, size: 20, color: Theme.of(context).hintColor),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
