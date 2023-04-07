import 'dart:io';
import 'package:demo_ecommerce_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _image;
  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileImage(),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _getImageFromGallery,
                child: Text('Select from gallery'),
              ),
              ElevatedButton(
                onPressed: _getImageFromCamera,
                child: Text('Take a picture'),
              ),
            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(


            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  HomeView(),
              ));
            },
            child: Text('Save as Profile Picture'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_image == null) {
      // If no image has been selected, display a default image
      return CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage('assets/images/man.png'),
      );
    } else {
      // If an image has been selected, display the selected image
      return CircleAvatar(
        radius: 75,
        backgroundImage: FileImage(_image!),
      );
    }
  }
  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Profile",
        style: TextStyle(color: Colors.black),
      ),

      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}

