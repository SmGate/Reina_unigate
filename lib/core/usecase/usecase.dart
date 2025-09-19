import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';

/// Base interface for all use cases.
/// Returns Either of [Failure] or result type [Type].
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Placeholder for cases where a use case has no parameters.
class NoParams {
  const NoParams();
}




