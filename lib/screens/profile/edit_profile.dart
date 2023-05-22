import 'package:flutter/material.dart';

import '../../api/apis.dart';
import '../../main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white10,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black54,
              ),
            ),
            title: const Text('Edit Profile'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              MongoUser.userDetails["profile_picture"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.amber.shade300,
                            ),
                            child: IconButton(
                              onPressed: () {
                                _editImage(context);
                              },
                              icon: const Icon(Icons.edit),
                              iconSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: mq.height * .015,
                    ),
                    Text(
                      MongoUser.userDetails["email"],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: mq.height * .04,
                    ),
                    TextFormField(
                      initialValue: MongoUser.userDetails["first_name"],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.amber,
                        ),
                        hintText: 'E.g., John Doe',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      // onSaved: (value) => APIs.self.name = value ?? '',
                      // validator: (value) => value != null && value.isNotEmpty
                      //     ? null
                      //     : '* Required Field',
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   log('Form Validated');
                        //   _formKey.currentState!.save();
                        //   APIs.updateUserDetl().then((value) {
                        //     Dialogs.showSnackbar(
                        //         context, 'Profile Updated Successfully');
                        //   });
                        // }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text(
                        'Update',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size(mq.width * .45, mq.height * .055),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .04,
                    ),
                    TextFormField(
                      readOnly: (MongoUser.userDetails["programme"] != null)
                          ? true
                          : false,
                      initialValue: MongoUser.userDetails["programme"],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.menu_book_rounded,
                          color: Colors.amber,
                        ),
                        hintText: 'E.g., B. Tech CSE',
                        labelText: 'Programme',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      // onSaved: (value) => APIs.self.name = value ?? '',
                      // validator: (value) => value != null && value.isNotEmpty
                      //     ? null
                      //     : '* Required Field',
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    TextFormField(
                      readOnly:
                          (MongoUser.userDetails["sex"] != null) ? true : false,
                      initialValue: MongoUser.userDetails["sex"],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.assignment_ind_rounded,
                          color: Colors.amber,
                        ),
                        hintText: 'E.g., TNU2020020110005',
                        labelText: 'TNU ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      // onSaved: (value) => APIs.self.name = value ?? '',
                      // validator: (value) => value != null && value.isNotEmpty
                      //     ? null
                      //     : '* Required Field',
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   log('Form Validated');
                        //   _formKey.currentState!.save();
                        //   APIs.updateUserDetl().then((value) {
                        //     Dialogs.showSnackbar(
                        //         context, 'Profile Updated Successfully');
                        //   });
                        // }
                      },
                      icon: const Icon(Icons.note_add_rounded),
                      label: const Text(
                        'Add',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size(mq.width * .45, mq.height * .055),
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      height: mq.height * 0.08,
                    ),
                    const Text(
                      '* To change Programme and UID, please contact with the Admin at omkar@serenityspace.com',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bottom sheet when clicked on profile pic edit button
  void _editImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return ListView(
              padding: EdgeInsets.only(
                  top: mq.height * 0.03, bottom: mq.height * 0.05),
              shrinkWrap: true,
              children: [
                const Text(
                  'Select Profile Pic from',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: mq.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // final ImagePicker picker = ImagePicker();
                        // // Pick an image.
                        // final XFile? photo = await picker.pickImage(
                        //     source: ImageSource.camera, imageQuality: 80);
                        // if (photo != null) {
                        //   log('Image path: ${photo.path} --mimeType: ${photo.mimeType}');
                        //   setState(() {
                        //     _image = photo.path;
                        //   });

                        //   APIs.updateProfilePic(File(_image!));

                        // for hiding bottom sheet
                        // Navigator.pop(context);
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade100,
                        shape: const CircleBorder(),
                        fixedSize: Size(
                          mq.width * .25,
                          mq.height * .15,
                        ),
                      ),
                      child: Image.asset('assets/images/camera.png'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // final ImagePicker picker = ImagePicker();
                        // // Pick an image.
                        // final XFile? image = await picker.pickImage(
                        //     source: ImageSource.gallery, imageQuality: 80);
                        // if (image != null) {
                        //   log('Image path: ${image.path} --mimeType: ${image.mimeType}');
                        //   setState(() {
                        //     _image = image.path;
                        //   });

                        //   APIs.updateProfilePic(File(_image!));

                        //   // for hiding bottom sheet
                        //   Navigator.pop(context);
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade100,
                        shape: const CircleBorder(),
                        fixedSize: Size(
                          mq.width * .25,
                          mq.height * .15,
                        ),
                      ),
                      child: Image.asset('assets/images/gallery.png'),
                    ),
                  ],
                ),
              ]);
        });
  }
}
