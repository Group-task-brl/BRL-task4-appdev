 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 import '../home_page/bottomnavbar.dart';
import '../models/storeToken.dart';
import '../utils/Routes.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

 final SecureStorage secureStorage=SecureStorage();
String key= 'accessToken';
class _LoginState extends State<Login> {

  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();

  Future <void> LoginApi() async {
    final String apiUrl = 'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/user/login';
    final response = await http.post(
        Uri.parse(apiUrl),
        body:({
          'email':emailController.text,
          'password':passController.text,
        })
    );
      print(response.body);
    if (response.statusCode == 200) {

      dynamic generateResponse = jsonDecode(response.body);
      Token.fromJson(generateResponse);
      await secureStorage.writeSecureData(key,generateResponse);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful"),),);
      print('API Response: ${response.body}');
      await Navigator.pushNamed(context, MyRoutes.BottomNavBar);

    } else {
      print('Failed to join the team. Status Code: ${response.statusCode}');
      print('Error Message: ${response.body}');
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool obscureText= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Container(
          height: MediaQuery.of(context).size.height,
          decoration:const BoxDecoration(
            image: DecorationImage(
            image:AssetImage('lib/assets/BgAuth.png'),
            fit: BoxFit.cover,),
          ),
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              // child: Form(
              //   key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "lib/assets/login.png",
                          fit: BoxFit.fitWidth,
                          height: 350,
                        ),
                        Text("Login",style:TextStyle(fontSize: 40,fontWeight: FontWeight.w500)),
                        Text("Agree to terms and conditions",style:TextStyle(fontSize: 14)),
                        ],),
                 SizedBox(height: 15,),
                  Form(
                  key: _formKey,
                  child:Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      ClipRRect(
                       borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                       child: Container(
                        width: 290,
                        color: Colors.grey,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Email",
                            contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                                           ),
                     ),
                      SizedBox(height:10),
                      ClipRRect(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                        child: Container(
                          width: 290,
                          color: Colors.grey,
                          child: TextFormField(
                            controller: passController,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              // prefixIcon:Icon(Icons.looks),
                              prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                              hintText: "********",
                              contentPadding: EdgeInsets.symmetric(vertical: 3.0),
                              suffixIcon:  IconButton(
                                  icon: Icon(obscureText? Icons.visibility_off : Icons.visibility),
                                  onPressed:(){
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                            ),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextButton(child:Text("Forgot Password?",style: TextStyle(color: Colors.black),),onPressed: (){},),
                      SizedBox(height: 30,),
                      // Row(
                      //   children:[
                      //     Text("Remind me nextime"),
                      //   ],
                      // ),
                      Container(
                        height: 45,
                        width: 290,
                        child: ElevatedButton(onPressed: (){
                          LoginApi();
                        },
                          style:ElevatedButton.styleFrom(backgroundColor: Colors.black,
                            // padding: const EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),

                          child: Text("Log in",style:TextStyle(color: Colors.white)),),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 3,),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(context, MyRoutes.SignUpRoutes);
                        }, child: Text("Sign up",style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black)))
                      ],
                    )
                  ]
                ),),],
              ),
              ),
          ),
        ),

    );
  }
}