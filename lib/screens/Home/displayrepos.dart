import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lockbox/services/directory.dart';
import 'package:lockbox/shared/constants.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class DisplayRepo extends StatefulWidget {
  String repo="";
  DisplayRepo(this.repo);


  @override
  State<DisplayRepo> createState() => _DisplayRepoState();
}

class _DisplayRepoState extends State<DisplayRepo> {


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String name="";
  String directory="";
  String newdir="";
  List file =[];
  String user="";
  bool isnewdir=false;

  @override
  void initState() {
    super.initState();
    _listofFiles();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        user=prefs.getString("userin") ?? "";
      });
    });
  }

  // Make New Function
  Future _listofFiles() async {
    var status=await Permission.manageExternalStorage.request();
    if(status.isDenied){
      file=["Storage access not granted"];
      return ;
    }


    directory = (Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory() //FOR IOS
    )!
        .path;
    print(directory);
    setState(() {
      file = (widget.repo=="")?Directory("$directory/$user/").listSync():Directory(widget.repo+"/").listSync();
    });
    print("hi");
  }

  alldirs(context){
    _displayDialog(context);
  }

  allfiles(repo) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["pdf"]);
    if (result != null) {
      File files = File(result.files.single.path!);
      files.copy("${widget.repo}/${basename(files.path)}");
      print("copydone");
      setState(() {
        file=Directory(widget.repo+"/").listSync();
      });
    }
  }

  // Build Part
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: (widget.repo=="")? (){alldirs(context);} : (){allfiles(widget.repo);},
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: widget.repo==""?Text("Your Directories"):Text("Files in ${basename(widget.repo)}"),
          actions: (widget.repo=="")?[]:[
            TextButton(
                onPressed: (){
                  uploadfolder(widget.repo);
                },
                child: Text("upload")
            )
          ],
        ),
        body: Container(
              child: file.length==0?Center(child: widget.repo==""?Text("You have not created any directories ${file.length}"):Text("You have no Files in Your directory")):Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: file.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                              onPressed: (){
                                print(file[index].path);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayRepo(file[index].path)),);
                              },
                              child: Text(file[index].toString())
                          );
                        }),
                  )
                ],
              ),
            ),
      ),
    );
  }

  _displayDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }


  Widget _DialogWithTextField(BuildContext context) => Container(
    height: 210,
    decoration: BoxDecoration(
      color:  Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 24),
        Text(
          "Enter new Directory name",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: Form(
              key: _formkey,
              child: TextFormField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: textinputdecoration.copyWith(hintText: "Directory Name",label: Text("Directory Name"),prefixIcon: Icon(Icons.folder_copy_outlined)),
                onChanged: (val){
                  newdir=val;
                },
                validator: (val)=>(val=="")?"Directory can't be empty": ((isnewdir==true)?null:"Directory Name should be unique"),
              ),
            )
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              onPressed: () {
                newdir="";
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            TextButton(
              style: authbuttonstyle.copyWith(textStyle: MaterialStatePropertyAll(TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.6
              ))),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async{
                if(newdir!="") {
                  isnewdir = await checkFolder("$user/$newdir");
                  if (isnewdir) {
                    setState(() {
                      file = Directory("$directory/$user/").listSync();
                    });
                  }
                }
                if(_formkey.currentState!.validate()){
                  newdir="";
                  print("deidiehiehd");
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ],
    ),
  );


}