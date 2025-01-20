part of 'apps_cubit.dart';

@immutable
abstract class AppsState {}

class AppsInitial extends AppsState {}

class FileGridLoading extends AppsState {}

class FileGridLoaded extends AppsState {
  final List<String> files;

  FileGridLoaded(this.files);
}

class FileGridError extends AppsState {
  final String message;

  FileGridError(this.message);
}

class FileImagesLoading extends AppsState {}

class FileImagesLoaded extends AppsState {
  final List<String> images;

  FileImagesLoaded(this.images);
}

class FileImagesError extends AppsState {
  final String message;

  FileImagesError(this.message);
}
