import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/faliures.dart';

// future use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class SynchornousUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
