import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/core/errors/exceptions.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:yabalash_mobile_app/features/flyers/data/datasources/flyer_remote_datasource.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/entities/Flyer.dart';
import 'package:yabalash_mobile_app/features/flyers/domain/repositories/flyers_repository.dart';

class FlyersRepositoryImpl extends FlyersRepository {
  final FlyerRemoteDataSource flyerRemoteDataSource;

  FlyersRepositoryImpl({required this.flyerRemoteDataSource});

  @override
  Future<Either<Failure, List<Flyer>>> getFlyers({int? page}) async {
    try {
      final response = await flyerRemoteDataSource.getFlyers(page: page);
      return Right(response.data as List<Flyer>);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }

  @override
  Future<Either<Failure, Flyer>> getFlyerById({required int id}) async {
    try {
      final response = await flyerRemoteDataSource.getFlyerById(id: id);
      return Right(response.data as Flyer);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }
}
