import "package:flutter/material.dart";
class join_team extends StatefulWidget {
  const join_team({super.key});

  @override
  State<join_team> createState() => _join_teamState();
}

class _join_teamState extends State<join_team> {
  TextEditingController TeamNameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Container(
            child: Form(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                    child: Container(
                      height: 45,
                      width: 290,
                      color: Colors.grey,
                      child: TextFormField(
                        controller: TeamNameController,
                        decoration: InputDecoration(
                          // prefixIcon:Icon(Icons.looks),
                          prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                          hintText: "Team Name",
                          contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                          suffixIcon: Icon(Icons.visibility),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
                    child: Container(
                      height: 45,
                      width: 290,
                      color: Colors.grey,
                      child: TextFormField(
                        controller: TeamNameController,
                        decoration: InputDecoration(
                          // prefixIcon:Icon(Icons.looks),
                          prefixIcon:Image.asset("lib/assets/icon_pass.png",height: 20,),
                          hintText: "Domain",
                          contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                          suffixIcon: Icon(Icons.visibility),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(onPressed: (){}, child:Text("")),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
