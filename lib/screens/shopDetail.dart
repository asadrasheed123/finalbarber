import 'dart:developer';

import 'package:flutter/material.dart';

import '../shopdetail.dart';
class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key}) : super(key: key);

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/nora.jpg"),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Asad cutting shop",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      Text("talwandi dop lahore kasur"),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Appoitment()));
                        },
                        child: Container(
                          height: 30,
                          width: 80,
                          color: Colors.red,
                          child:Center(child: Text("Book Now",style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ],
                  ),

                ],
                
              ),
              SizedBox(height: 25,),
              Text("Descrption!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 10,),
              Text("descrpion about shops It is worth noting that when no other parameters are given, the Image wi"),
              SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                     height: 140,
                       width: 140,
                       child: Image.asset("assets/images/2.webp")),

                   Container(
                       height: 140,
                       width: 140,
                       child: Image.asset("assets/images/3.webp")),
                 ],
               ),
              SizedBox(height: 25,),
              Text("Services!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1: Hair cutting",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                    Text("2: Hair color",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                    Text("3: face massaj",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                    Text("4: threading",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                    Text("5: style",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Appoitment()));
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.red,
                  child: Center(child: Text("Book now",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
