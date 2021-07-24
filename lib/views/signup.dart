import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormFieldState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp(){
    if (formKey.currentState!.validate()) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appBarMain(BuildContext),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 58.0,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  // child: Column(
                  //   children: [
                  //     //  ||
                  //     TextFormField(
                  //       validator: (val) {
                  //         return val!.isEmpty || val.length < 2
                  //             ? 'Please provide valid username'
                  //             : null;
                  //         },
                  //       controller: userNameTextEditingController,
                  //       style: simpleTextStyle(),
                  //       decoration: textFieldInputDecoration('username'),
                  //     ),
                  //     TextFormField(
                  //       validator: (val){
                  //         return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //             .hasMatch(val!) ?
                  //               null : "Enter correct email";
                  //              },
                  //       controller: emailTextEditingController,
                  //       style: simpleTextStyle(),
                  //       decoration: textFieldInputDecoration('email'),
                  //     ),
                  //     TextFormField(
                  //       validator: (val){
                  //         return val!.length > 6 ? null : 'Provide 6+ character password';
                  //       },
                  //       controller: passwordTextEditingController,
                  //       style: simpleTextStyle(),
                  //       decoration: textFieldInputDecoration('password'),
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    children: [
                      //  ||
                      TextFormField(
                        validator: (val) {
                          return val==null || val.isEmpty || val.length < 2
                              ? 'Please provide valid username'
                              : null;
                        },
                        controller: userNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('username'),
                      ),
                      TextFormField(
                        validator: (val){
                          if(val==null) return "Enter email";
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val) ?
                          null : "Enter correct email";
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('email'),
                      ),
                      TextFormField(
                        validator: (val){
                          return val == null || val.length < 6 ? 'Provide 6+ character password' : null;
                        },
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('password'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0,),
                Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Forgot Password?', style: simpleTextStyle(),),
                    ),
                  ),

                const SizedBox(height: 8.0),
                GestureDetector(
                    onTap: (){
                      signMeUp();
                    },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xff007EF4),
                            Color(0xff2A75BC)]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text('Sign Up', style: mediumTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text('Sign Up with Google', style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: mediumTextStyle(),),
                    const Text('Sign In now!', style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: TextDecoration.underline,
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
