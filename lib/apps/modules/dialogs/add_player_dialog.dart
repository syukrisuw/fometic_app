import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DialogConfirmCallback = void Function(String number, String name, String pos, bool isPlay);
typedef DialogCancelCallback = void Function();

class AddPlayerDialog extends StatelessWidget {
  final DialogConfirmCallback onConfirmCallback;
  final DialogCancelCallback onCancelCallback;

  AddPlayerDialog(
      {required this.onConfirmCallback, required this.onCancelCallback});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  TextEditingController _playerNumberController = TextEditingController();
  TextEditingController _playerNameController = TextEditingController();
  TextEditingController _playerPositionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Container(
          width: MediaQuery.of(context).size.width-10,
          color: Colors.lightBlueAccent,
            child: Center( child: Text("Add Player"))),
        titlePadding: EdgeInsets.all(5),
        insetPadding: EdgeInsets.all(5),
          content: Form(
        key: _formKey,
        child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _playerNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter player number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Player Number",
                  hintText: "Enter Player Number",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _playerNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter player Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                    labelText: "Player Name",
                    hintText: "Enter Some Text",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _playerPositionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter player Position';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Player Position",
                  hintText: "Enter player Position",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtitution Player"),
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool? checked) {
                        setState(() {
                          isChecked = checked!;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        onCancelCallback();
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onConfirmCallback(_playerNumberController.value.text, _playerNameController.value.text, _playerPositionController.value.text, isChecked);

                        }
                      },
                      child: Text("Confirm")),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
