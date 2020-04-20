 import 'dart:convert';
import 'package:zenith_testapp/Models/api_login.dart';

import './Models/api_response.dart';
import './Models/api_register.dart';
import 'package:http/http.dart' as http;
class Service 
{
 static const API = 'https://zenithtestapiapp8.azurewebsites.net/RegPage';
  static const headers = {
   'Accept':'application/json',
   'Content-Type':'application/json'
  };

Future<MessgaeRESPONSE<String>> loginUser1(Login item) {
  
return http.post(API + '/Login', headers: headers,body:  json.encode(item.tojson()) )
.then((data)
{
if(data.statusCode == 200)
{
 
 return MessgaeRESPONSE<String>(
    bodyMessage:  data.body
  );


}
return MessgaeRESPONSE<String>(
   bodyMessage:  "Error"
);
}).catchError((_)=>
MessgaeRESPONSE<String>(
  bodyMessage:  "Error"
)

);
}

Future<APIRESPONSE<bool>> createUser(Register item) {
return http.post(API + '/Insert', headers: headers,body:  json.encode(item.tojson()) )
.then((data)
{
if(data.statusCode == 200)
{

return APIRESPONSE<bool>(
  data: true
);

}
return APIRESPONSE<bool>(
  error: true,
  errorMessage: 'And error occured.'
);
}).catchError((_)=>
APIRESPONSE<bool>(
  error: true,
  errorMessage: 'And error occured.'
)

);
}


Future<APIRESPONSE<List<Register>>> getUser(String email) {
return http.get(API + '/GetUser?email='+email, headers: headers)
.then((data)
{
if(data.statusCode == 200)
{

final jsonData = json.decode(data.body);
final notes = <Register>
[];

for(var item in jsonData)
{
notes.add(Register.fromJson(item));

}

return APIRESPONSE<List<Register>>(
     data: notes
);

}
return APIRESPONSE<List<Register>>(

  errorMessage: 'And error occured.'
);
}).catchError((_)=>
APIRESPONSE<List<Register>>(

  errorMessage: 'And error occured.'
)

);
}


}

class MessgaeRESPONSE<T>{

String bodyMessage;
T data;

List<T> data2;

MessgaeRESPONSE({this.bodyMessage,this.data,this.data2});

}





