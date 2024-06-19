import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordDialog extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  Future<String?> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);

      //e-mail de redefinição de senha enviado com sucesso
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(
                  'A link to reset your password has been sent to ${_emailController.text}'),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text('Ok'),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      //Tratamento de erro
      switch(e.code){
        case "invalid-email":
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('Error sending password reset email: The email is invalid!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
          case "missing-email":
          return  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('Error sending password reset email: Please enter an email in the field'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('Erro ao enviar o e-mail de redefinição de senha: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(Icons.local_post_office_outlined),
          SizedBox(height: 10),
          Text('Forgot your password?',style: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please confirm your e-mail and check your inbox to reset the password'),
          SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'E-mail'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
            onPressed: () => _resetPassword(context),
            child: Text('Send password reset email',style: TextStyle(fontWeight: FontWeight.bold),))
      ],
    );
  }
}
