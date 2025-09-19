import 'package:equatable/equatable.dart';

class ResendCodeEntity extends Equatable {
  const ResendCodeEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}


