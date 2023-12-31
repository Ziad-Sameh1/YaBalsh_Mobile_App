import 'package:yabalash_mobile_app/core/errors/exceptions.dart';
import 'package:yabalash_mobile_app/features/reciepies/data/datasources/recipie_mock_data_source.dart';
import 'package:yabalash_mobile_app/features/reciepies/domain/entities/recipie.dart';
import 'package:yabalash_mobile_app/features/reciepies/domain/entities/brand.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/features/reciepies/domain/repositories/recipies_repository.dart';

class RecipiesRepositoryImpl implements RecipiesRepository {
  final RecipieDataSource recipieDataSource;

  RecipiesRepositoryImpl({required this.recipieDataSource});
  @override
  Future<Either<Failure, List<Brand>>> getBrands({int? page}) async {
    try {
      final response = await recipieDataSource.getAllBrands(page: page);

      return Right(response);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }

  @override
  Future<Either<Failure, List<Recipie>>> getAllRecipies({int? page}) async {
    try {
      final response = await recipieDataSource.getAllRecipies(page: page);

      return Right(response);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }

  @override
  Future<Either<Failure, Recipie>> getRecipieById({required int id}) async {
    try {
      final response = await recipieDataSource.getRecipieDetails(recipieId: id);

      return Right(response);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }

  @override
  Future<Either<Failure, List<Recipie>>> getBrandRecipies(
      {required int brandId, int? page}) async {
    try {
      final response = await recipieDataSource.getBrandRecipies(
          brandId: brandId, page: page);

      return Right(response);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }
}
