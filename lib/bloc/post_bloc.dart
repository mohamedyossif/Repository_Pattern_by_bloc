import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository_pattern/data/model/post.dart';
import 'package:repository_pattern/data/respository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  PostBloc(this.repository) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event,) async* {
      if(event is FetchData)
      {
        yield PostLoading();
        try
        {
        final posts=await repository.getAll();
        yield PostLoaded(posts);
        }catch(e)
        {
          yield PostError(e.toString());
        }
      }
   
  }
}
