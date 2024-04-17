import 'dart:io';
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? profileImage;

  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage?.path != null){
      setState((){
        profileImage = File(pickedImage!.path);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        width: w,
        height: h * 0.08,
        padding:const EdgeInsets.all(10),
        child: GestureDetector(
          child: Container(
            width: w,
            height: h * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Constants.customRed,
            ),
            child:Obx(() => userController.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,)) : const Center(
              child: Text("Update Profile",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            )
          )),
          onTap: () async{
            await userController.updateUser();
            await userController.getUser();
            Get.to(const Home(), transition: Transition.leftToRight, duration: 300.milliseconds);

          },
        )
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon:const Icon(Icons.arrow_back_ios_rounded ,color: Colors.black,)
        ),
        title: const Text("Edit Profile",style: TextStyle(fontFamily: 'poppins',fontSize: 20,color: Colors.black),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /*Container(
            width: w,
            height: h * 0.2,
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 251, 251, 255),
            child:Stack(
              children: [
                Container(
                  width: w * 0.35,
                  height: w * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 232, 232, 232),
                  ),
                  child: profileImage == null 
                  ? Center(
                    child: IconButton(
                      onPressed: (){
                      },
                      icon: const Icon(Icons.camera_alt_outlined,size: 30,color: Colors.grey,)
                    ),
                  ): Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: FileImage(File(profileImage!.path)),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: GestureDetector(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Constants.customRed,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white,width: 2)
                      ),
                      child: const Icon(Icons.edit,color: Colors.white,size: 15,),
                    ),
                    onTap: (){
                      pickImage();
                    },
                  ),
                )
              ],
            )
          ),*/
          Container(
            width: w,
            height: h * 0.1,
            margin:const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: w*0.92,
                  child: TextField(
                    controller: userController.nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Updated Name',
                      labelStyle: const TextStyle(fontFamily: 'poppins',fontSize: 14),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.customRed)
                      ),
                    ),
                  ),
                ),
                /*SizedBox(
                  width: w * 0.45,
                  child: TextField(
                    controller: userController.lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Enter Last Name',
                      labelStyle: const TextStyle(fontFamily: 'poppins',fontSize: 14),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.customRed)
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          Container(
            width:w,
            height:h * 0.08,
            margin:const EdgeInsets.symmetric(vertical: 8),
            padding:const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: userController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email ID',
                labelStyle: const TextStyle(fontFamily: 'poppins',fontSize: 14),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.customRed)
                ),
              ),
            ),
          ),
          Container(
            width:w,
            height:h * 0.08,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding:const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              readOnly: true,
              controller: userController.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText:userController.userModel.number.toString(),
                labelText: "Phone Number",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.customRed)
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}