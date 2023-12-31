import 'package:yabalash_mobile_app/core/errors/exceptions.dart';
import 'package:yabalash_mobile_app/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/features/categories/domain/repositories/categories_repository.dart';

import '../../domain/entities/category.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDataSource categoriesDataSource;

  CategoriesRepositoryImpl({required this.categoriesDataSource});
  @override
  Future<Either<Failure, List<Category>>> getSubCategories(
      {required int mainCategoryId}) async {
    try {
      final response = await categoriesDataSource.getMainCategorySubCategories(
          mainCategoryId: mainCategoryId);
      return Right(response.data as List<Category>);
    } on ServerException catch (err) {
      return Left(ServerFailure(message: err.errorModel.message!));
    }
  }
}
