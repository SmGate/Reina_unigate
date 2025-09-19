import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  const ForgotPasswordEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}



