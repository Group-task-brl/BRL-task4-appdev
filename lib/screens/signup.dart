import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Utils/Routes.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController comfpassController =TextEditingController();

  bool obscureText= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        decoration:BoxDecoration(
          color: Colors.purple.shade50.withOpacity(0.1),
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
                      "lib/assets/signup.png",
                      fit: BoxFit.fitWidth,
                      height: 250,
                    ),
                    Text("Sign Up",style:TextStyle(fontSize: 40,fontWeight: FontWeight.w500)),
                    Text("Agree to terms and conditions",style:TextStyle(fontSize: 14)),
                  ],),
                SizedBox(height: 20,),
                Form(
                  key: _formKey,
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 45,
                            width: 290,
                            color: Colors.grey,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                                hintText: "Username",
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
                            height: 45,
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
                            height: 45,
                            width: 290,
                            color: Colors.grey,
                            child: TextFormField(
                              controller: passController,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                // prefixIcon:Icon(Icons.looks),
                                prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Password",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
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
                        SizedBox(height:10),
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                          child: Container(
                            height: 45,
                            width: 290,
                            color: Colors.grey,
                            child: TextFormField(
                              controller: comfpassController,
                              obscureText: true,
                              decoration: InputDecoration(
                                // prefixIcon:Icon(Icons.looks),
                                prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                                hintText: "Confirm Password",
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                                suffixIcon:  Icon(Icons.visibility_off),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              // validator: (value){
                              //   if(passController.text==comfpassController.text){
                              //     return null;
                              //   }
                              //   else{
                              //     return "Password mismatch";
                              //   }
                              // },
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text("Signup via",style: TextStyle(color: Colors.black)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 2, width: 138,color: Colors.purple,),
                            IconButton(onPressed: (){},
                                padding: EdgeInsets.all(1.0),
                                icon:(Image.asset("lib/assets/google.png",height: 30,)) ),
                            Container(height: 2,width:138,color: Colors.purple,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 45,
                          width: 290,
                          child: ElevatedButton(onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                if (passController.text == comfpassController.text) {}}
                            else {

                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password mismatch"),
                                ),
                              );
                            }
                          },
                            style:ElevatedButton.styleFrom(backgroundColor: Colors.black,
                              // padding: const EdgeInsets.symmetric(horizontal: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            ),

                            child: Text("Sign up",style:TextStyle(color: Colors.white)),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            SizedBox(width: 3,),
                            TextButton(onPressed: (){
                              Navigator.pushReplacementNamed(context, MyRoutes.LoginRoutes);
                            }, child: Text("Login",style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black)))
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