import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:yabalash_mobile_app/core/usecases/use_cases.dart';
import 'package:yabalash_mobile_app/features/reciepies/domain/entities/recipie.dart';
import 'package:yabalash_mobile_app/features/reciepies/domain/repositories/recipies_repository.dart';

class GetBrandRecipiesUseCase
    implements UseCase<List<Recipie>, GetBrandRecipiesParams> {
  final RecipiesRepository recipiesRepository;

  GetBrandRecipiesUseCase({required this.recipiesRepository});
  @override
  Future<Either<Failure, List<Recipie>>> call(GetBrandRecipiesParams params) =>
      recipiesRepository.getBrandRecipies(
          brandId: params.brandId, page: params.page);
}

class GetBrandRecipiesParams extends Equatable {
  final int brandId;
  final int? page;
  const GetBrandRecipiesParams({required this.brandId, this.page});

  @override
  List<Object?> get props => [brandId, page];
}
