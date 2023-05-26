// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EmailInputModel {
  TextEditingController? emailAddressController;
  late VoidCallback onUpdate;

  String? emailAddressControllerValidator(String? value) {
    // Add your email validation logic here
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    return null;
  }
}

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({Key? key}) : super(key: key);

  @override
  EmailInputWidgetState createState() => EmailInputWidgetState();
}

class EmailInputWidgetState extends State<EmailInputWidget> {
  late EmailInputModel _model;

  @override
  void initState() {
    super.initState();
    _model = EmailInputModel();
    _model.emailAddressController = TextEditingController();
    _model.emailAddressController?.text = '';
  }

  @override
  void dispose() {
    _model.emailAddressController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: _model.emailAddressController,
        textCapitalization: TextCapitalization.none,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Email Address',
          labelStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF57636C),
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF57636C),
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        style: TextStyle(
          fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          color: const Color(0xFF5D6469),
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.emailAddress,
        validator: _model.emailAddressControllerValidator,
      ),
    );
  }
}
