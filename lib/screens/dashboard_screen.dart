import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zenith_testapp/Models/api_register.dart';
import 'package:zenith_testapp/Models/api_response.dart';
import '../Services.dart';
import '../utilities/styles.dart';


class Dashboard extends StatefulWidget {
    final String userEmail;
  Dashboard({this.userEmail});

  @override
  DashBoardState createState() => new DashBoardState();
}


class DashBoardState extends State<Dashboard> {
  String name;
 bool isLoading = false;
 Service get noteService => GetIt.I<Service>();
  APIRESPONSE<List<Register>> _apiresponse;
@override
  void initState() {
    super.initState();  
       _fetchUser();
      }

_fetchUser() async
{
       setState(() {
        isLoading = true;
      });
        
    _apiresponse=   await noteService.getUser(widget.userEmail);  
        setState(() {
          isLoading = false;
        });

       for(var item in _apiresponse.data)
       {
        name = item.fullName.toString();
       }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5036D5),
      
      body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome Back,",
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      
                      name.toString(),
                      style: kTitleStyle,
                    ),
        

    

                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(Icons.exit_to_app),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
         GridDashboard()
        ],
      ),
    );
  }
}


class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Calendar",
      subtitle: "Quarantine",
      event: "0 Events",
      img: "assets/calendar.png");

  Items item2 = new Items(
    title: "Health",
    subtitle: "Stay safe",
    event: "4 Items",
    img: "assets/safety.png",
  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "Lagos",
    event: "lock-down",
    img: "assets/map.png",
  );
  Items item4 = new Items(
    title: "Activities",
    subtitle: "Program",
    event: "0 projects",
    img: "assets/work.png",
  );
  Items item5 = new Items(
    title: "To do",
    subtitle: "Watch ",
    event: "peaky blinders",
    img: "assets/todo.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/setting.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xFF4563DB;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: kSubtitleStyle,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: kHintTextStyle,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.event,
                    style: kHintTextStyle,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}