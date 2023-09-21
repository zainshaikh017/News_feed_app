import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Username',
                            ),

                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email'
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: 'Phone Number'
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: Icon(Icons.remove_red_eye_outlined)
                            ),
                          ),
                        ],


                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text('SignUp ',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize: 20
                  ),),),
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an account? ',style: TextStyle(
                        color: Colors.grey
                    ),),
                    TextButton(onPressed: (){

                      Navigator.pop(context);

                    }, child: Text('Back To Login',style: TextStyle(
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
