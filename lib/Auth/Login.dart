// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:news_feed_app/Auth/SignUp.dart';
import 'package:news_feed_app/Function/Firebase/FirebaseUtils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset('assets/logo.png',
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      child: Column(
                    children: [

                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email'
                        ),

                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                          suffixIcon: Icon(Icons.remove_red_eye_outlined)
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){

                              },
                              child: const Text('Forgot password',style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),))),
                    ],
                  )),
                ),

                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: (){
                   FirebaseUtils().login(context: context,
                       email: email.text.toString(),
                       password: password.text.toString()
                   );
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child: Text('Login Here',style: TextStyle(
                       color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontSize: 20
                    ),),),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Don\'t have an account? ',style: TextStyle(
                      color: Colors.grey
                    ),),
                    TextButton(onPressed: (){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const SignUp();
                      },));

                    }, child: const Text('SignUP',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),)),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

    );

  }
}
