import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

getReceiptFromApi(File imageFile) async {
  // open a bytestream
  var stream = http.ByteStream(imageFile.openRead());
  stream.cast();
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("https://api.taggun.io/api/receipt/v1/verbose/file");

  // create multipart request

  // multipart that takes file
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // send
  var headers = {
    'Content-Type': 'multipart/form-data',
    'apikey': 'f5e5d700c3f411ec8215c512ccf27e54'
  };
  var request = http.MultipartRequest('POST', uri);
  request.files.add(multipartFile);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('success');
    return (await response.stream.bytesToString());
  } else {
    return ('erro');
  }
}
