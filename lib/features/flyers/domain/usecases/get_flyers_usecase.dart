import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:yabalash_mobile_app/core/usecases/use_cases.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/repositories/flyers_repository.dart';

import '../entities/Flyer.dart';

class GetFlyersUseCase implements UseCase<List<Flyer>, NoParams> {
  final FlyersRepository flyersRepository;

  GetFlyersUseCase({required this.flyersRepository});

  @override
  Future<Either<Failure, List<Flyer>>> call(NoParams params) async {
    return await flyersRepository.getFlyers();
  }
}
