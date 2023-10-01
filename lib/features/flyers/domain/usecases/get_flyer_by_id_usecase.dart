import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:yabalash_mobile_app/core/usecases/use_cases.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/repositories/flyers_repository.dart';

import '../entities/Flyer.dart';
import 'get_flyers_usecase.dart';

class GetFlyerByIdUseCase implements UseCase<Flyer, FlyersParams> {
  final FlyersRepository flyersRepository;

  GetFlyerByIdUseCase({required this.flyersRepository});

  @override
  Future<Either<Failure, Flyer>> call(FlyersParams params) async {
    return await flyersRepository.getFlyerById(id: params.id!);
  }
}