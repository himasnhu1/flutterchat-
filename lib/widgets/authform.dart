import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(
      String email,
      String name,
      String password,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _logIn = true;
  var _useremail = '';
  var _username = '';
  var _userpassword = '';
  final _formkey = GlobalKey<FormState>();

  void _trysubmit() {
    final isvalid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      _formkey.currentState.save();
      widget.submitFn(_useremail.trim(),
          _username.trim(),
          _userpassword.trim(),
          _logIn,
      context);
      //use.. those value to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        key: ValueKey("email"),
                        onSaved: (value) {
                          _useremail = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please Enter valid Email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email address'),
                      ),
                      if(!_logIn)
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value.length < 4)
                              return 'Please Enter at least 4 digit name';
                            return null;
                          },
                          onSaved: (value) {
                            _username = value;
                          },
                          key: ValueKey('name'),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userpassword = value;
                        },
                        key: ValueKey('password'),
                        decoration: InputDecoration(labelText: "password"),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: _trysubmit,
                        child: Text(_logIn ? 'LogIn' : 'SignUp'),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                          textColor: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            setState(() {
                              _logIn = !_logIn;
                            });
                          },
                          child: Text(_logIn
                              ? 'create new account'
                              : 'I already have an account')
                      )
                    ],
                  ),
                )
            ),
        ),
      ),
    );
  }
}
