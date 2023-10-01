import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/Flyer.dart';

abstract class FlyersRepository {
  Future<Either<Failure, List<Flyer>>> getFlyers({int? page});
  Future<Either<Failure,Flyer>> getFlyerById({required int id});
}