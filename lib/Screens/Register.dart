import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/massagePage.dart';
import '../widgets/ButtonUsed.dart';
import '../widgets/TextFieldUsed.dart';
import '../Functions.dart';

class RegisterScreen extends StatefulWidget {


  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 String? email;

 String? password;
bool isLoading=false;
 bool  obscureText=false;
 Widget icon =Icon(Icons.visibility_rounded, color: Colors.white);
 GlobalKey <FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
                backgroundColor: const Color(0xff2B475E),
                body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Image.asset('assets/images/scholar.png'),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
                const Spacer(
                  flex: 1,
                ),
                const Row(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldUsed(
                  labelText: "Email",
                  onChanged: (data) {
                    email = data;
                  },
                  validator: (data){
                    if (data == null || data.isEmpty) {
                      return 'This field is required';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(data)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldUsed(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      obscureText=!obscureText;
                      icon= !obscureText?Icon(Icons.visibility_rounded, color: Colors.white):Icon(Icons.visibility_off, color: Colors.white);
                    });
                  },icon:icon ),
                  obscureText: obscureText,
                  validator: (data){
                    if (data == null || data.isEmpty) {
                      return 'This field is required';
                    } if (data.length < 4) {
                      return 'Password must be at least 4 characters long';
                    }
                    return null;
                  },
                  labelText: "password",
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ButtonUsed(
                    text: "Sign Up",
                    onTap: () async {
                     if(formKey.currentState!.validate()){
                       setState(() {
                         isLoading=true;
                       });
                       try {
                         await createAccount(
                           email: email!,
                           password: password!,

                         );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MassageScreen(),));
                       } catch (e) {
                         showSnackBar(context, e);
                       }
                       setState(() {
                         isLoading=false;
                       });
                     }
                    }),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?',
                        style: TextStyle(color: Colors.white)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('  Sign In',
                            style: TextStyle(color: Colors.blueAccent)))
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
                ),
              ),
        ));
  }
}
