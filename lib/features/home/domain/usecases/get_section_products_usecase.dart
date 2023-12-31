import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yabalash_mobile_app/features/home/domain/entities/product.dart';

import '../../../../core/errors/faliures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../repositories/home_repository.dart';

class GetSectionProductsUseCase
    implements UseCase<List<Product>, GetSectionProductsParams> {
  final HomeRepository homeRepository;

  GetSectionProductsUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, List<Product>>> call(
          GetSectionProductsParams params) =>
      homeRepository.getSectionProducts(
          sectionId: params.sectionId, page: params.page);
}

class GetSectionProductsParams extends Equatable {
  final int sectionId;
  final int? page;

  const GetSectionProductsParams({required this.sectionId, this.page});
  @override
  List<Object?> get props => [sectionId, page];
}
