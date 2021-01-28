import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_pattern/bloc/post_bloc.dart';
import 'package:repository_pattern/data/respository/post_repository.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
      create: (context) => PostBloc(PostRepositoryImp())..add(FetchData()),
      child: Home(),
      )
    );
    
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repository pattern by Bloc "),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return CircularProgressIndicator();
          } 
          
          
          else if (state is PostLoaded) {
            return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text(state.posts[i].title),
                      subtitle: Text(state.posts[i].id.toString()),
                    ),
                  );
                });
          } 
          
          
          else if (state is PostError) {
            return Text(state.message);
          }




          return CircularProgressIndicator();
        },
      ),
    );
  }
}
