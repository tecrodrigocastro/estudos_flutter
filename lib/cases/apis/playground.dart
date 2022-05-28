import 'dart:io';

void main() async {
  var url = 'https://jsonplaceholder.typicode.com/todos';

  final client = HttpClient();
  //request
  final request = await client.openUrl('get', Uri.parse(url));
  //response
}
