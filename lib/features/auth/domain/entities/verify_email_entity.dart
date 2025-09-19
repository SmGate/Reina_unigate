import 'package:equatable/equatable.dart';

class VerifyEmailEntity extends Equatable {
  const VerifyEmailEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}


