import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyForm(),
  ));
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool _isHidden = true;
  @override
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scrollable Form'),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScopeNode focusScopeNode = FocusScope.of(context);
              if (!focusScopeNode.hasPrimaryFocus) {
                focusScopeNode.unfocus();
              }
            },
            child: (LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  //padding: EdgeInsets.only(bottom: 200),
                  //scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 200)),
                        Form(
                            key: formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.person),
                                    hintText: 'Enter Username',
                                    labelText: 'Username',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.length < 10 ||
                                        value.isEmpty) {
                                      return 'insufficient characters';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.lock),
                                    hintText: 'Enter Password',
                                    labelText: 'Password',
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(Icons.visibility),
                                    ),
                                  ),
                                  obscureText: _isHidden,
                                  validator: (value) {
                                    if (value == null ||
                                        value.length < 10 ||
                                        value.isEmpty) {
                                      return 'insufficient characters';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(' Submitting')),
                                        );
                                      }
                                    },
                                    child: const Text('Submit'),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black)),
                                  ),
                                ),

                                //Padding(padding: EdgeInsets.only(bottom: 250))
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }))));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
