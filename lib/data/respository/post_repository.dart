import 'dart:convert';
import 'package:http/http.dart';
import 'package:repository_pattern/data/model/post.dart';

abstract class PostRepository
{
  Future<List<Post>> getAll();

}
class PostRepositoryImp extends PostRepository
{
  // get data from web service
  @override
  Future<List<Post>> getAll() async{
   final respones=await get('https://jsonplaceholder.typicode.com/posts');
   if(respones.statusCode==200)
   {
      final convert=json.decode(respones.body).cast<Map<String,dynamic>>();
      return convert.map<Post>((item)=>Post.fromJson(item)).toList();
   }
   else{
     throw Exception("data is not loaded");
   }
  }
  
}