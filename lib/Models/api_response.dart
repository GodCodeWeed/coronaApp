class APIRESPONSE<T>{
T data;
bool error;
String errorMessage;
T bodyMessage;
APIRESPONSE({this.data,this.error= false,this.errorMessage,this.bodyMessage});

}