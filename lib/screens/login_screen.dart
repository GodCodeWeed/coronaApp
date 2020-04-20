import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../Models/api_login.dart';
import '../Services.dart';
import '../screens/registration_screen.dart';
import '../utilities/styles.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
Service get noteService => GetIt.I<Service>();
bool isLoading = false;
TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
    loginUser();

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'CM Sans Serif',
          ),
        ),
      ),
    );
  }


loginUser() async
{
if(_emailController.text.isEmpty == false && _passwordController.text.isEmpty == false){
                    setState(() {
                         isLoading = true;
                          });
                          final note = Login(
                              

                              email: _emailController.text,
                              password: _passwordController.text ,
                             );
                              
                          final result = await noteService.loginUser1(note);
                            setState(() {
                         isLoading = false;
                          });
                          String bodyMe = result.bodyMessage.toString();
                          String response1 = ('"Success"');
                          String response2 = ('"Invalid"');
if(bodyMe ==  response1)
{
Navigator.of(context)
  .push(MaterialPageRoute(builder: (_) => Dashboard(userEmail: _emailController.text)));
//Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Dashboard()));
}
else if(bodyMe == response2)
{
     showDialog(
                             context: context, builder: (_) =>
                              AlertDialog(
                                title: Text("Unauthorized") ,
                                content: Text("Invalid Credentials"),
                                actions: <Widget>
                                [
                                  FlatButton(
                                    onPressed: ()
                                    {
                                      Navigator.of(context).pop();
                                    },
                                     child: Text('Ok'))
                                ],
                              )
                             );

}
else
{
                           final  title = 'Done';
                          final text =  'Something went wrong.';

                          showDialog(
                             context: context, builder: (_) =>
                              AlertDialog(
                                title: Text(title) ,
                                content: Text(text),
                                actions: <Widget>
                                [
                                  FlatButton(
                                    onPressed: ()
                                    {
                                      Navigator.of(context).pop();
                                    },
                                     child: Text('Ok'))
                                ],
                              )
                             );
}
}
else{
  showDialog(
                             context: context, builder: (_) =>
                              AlertDialog(
                                title: Text("Input credentials") ,
                                content: Text("Input email and password."),
                                actions: <Widget>
                                [
                                  FlatButton(
                                    onPressed: ()
                                    {
                                      Navigator.of(context).pop();
                                    },
                                     child: Text('Ok'))
                                ],
                              )
                             );

}
}

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () 
            {

                                        showDialog(
                             context: context, builder: (_) =>
                              AlertDialog(
                                title: Text("Alert") ,
                                content: Text("This feature isnt enabled yet."),
                                actions: <Widget>
                                [
                                  FlatButton(
                                    onPressed: ()
                                    {
                                   //   Navigator.of(context).pop();
                                   Navigator.pop(context);
                                    },
                                     child: Text('Ok'))
                                ],
                              )
                             );
            },
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () {

                                        showDialog(
                             context: context, builder: (_) =>
                              AlertDialog(
                                title: Text("Alert") ,
                                content: Text("This feature isnt enabled yet."),
                                actions: <Widget>
                                [
                                  FlatButton(
                                    onPressed: ()
                                    {
                                       Navigator.pop(context);
                                    //  Navigator.of(context).pop();
                                    },
                                     child: Text('Ok'))
                                ],
                              )
                             );

            },
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () 
      {
             Navigator.of(context)
             .push(MaterialPageRoute(builder: (_) => RegistrationScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: isLoading ? Center(child: CircularProgressIndicator()) : Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'CM Sans Serif',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
