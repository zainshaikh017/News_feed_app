import 'package:flutter/material.dart';
import 'package:news_feed_app/Function/Firebase/FirebaseUtils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey=GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phone=TextEditingController();
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
                    key: _formKey,
                      child: Column(
                        children: [

                          TextFormField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                            ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30,),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Email'
                            ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30,),
                          TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                hintText: 'Phone Number'
                            ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
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
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],


                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      print('data send');
                      // print(email.text.toString());
                      // print(password.text.toString());
                      FirebaseUtils().signUp(
                          email: email.text.toString(),
                          password: password.text.toString(),
                          phone: phone.text.toString(),
                          username: name.text.toString(),
                        context: context,
                      );
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child: Text('SignUp ',style: TextStyle(
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
                    const Text('Already have an account? ',style: TextStyle(
                        color: Colors.grey
                    ),),
                    TextButton(onPressed: (){

                      Navigator.pop(context);

                    }, child: const Text('Back To Login',style: TextStyle(
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
