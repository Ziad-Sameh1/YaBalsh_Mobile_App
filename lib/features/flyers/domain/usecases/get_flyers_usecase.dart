import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:yabalash_mobile_app/core/usecases/use_cases.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/repositories/flyers_repository.dart';

import '../entities/Flyer.dart';

class GetFlyersUseCase implements UseCase<List<Flyer>, FlyersParams> {
  final FlyersRepository flyersRepository;

  GetFlyersUseCase({required this.flyersRepository});

  @override
  Future<Either<Failure, List<Flyer>>> call(FlyersParams params) async {
    return await flyersRepository.getFlyers(page: params.page);
  }
}

class FlyersParams extends Equatable {

  final int? id;
  final int? page;

  const FlyersParams({this.id, this.page});

  @override
  List<Object?> get props => [id, page];

}