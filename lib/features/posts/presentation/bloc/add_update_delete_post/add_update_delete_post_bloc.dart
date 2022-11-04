import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/strings/messages.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post.dart';

import '../../../../../core/exceptions/failures.dart';
import '../../../../../core/strings/failures.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;

  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final failureOrDoneMessage = await addPost(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddUpdateDeletePostState(
              message: _mapFailureToMessage(failure)));
        }, (_) {
          emit(MessageAddUpdateDeletePostState(message: ADD_SUCCESS_MESSAGE));
        });
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final failureOrDoneMessage = await updatePost(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddUpdateDeletePostState(
              message: _mapFailureToMessage(failure)));
        }, (_) {
          emit(
              MessageAddUpdateDeletePostState(message: UPDATE_SUCCESS_MESSAGE));
        });
      } else if (event is DeletePostEvent) {}
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue. Veuillez réessayer plus tard";
    }
  }
}
