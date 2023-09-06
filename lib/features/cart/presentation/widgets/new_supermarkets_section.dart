import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yabalash_mobile_app/core/constants/constants.dart';
import 'package:yabalash_mobile_app/features/cart/domain/entities/cart_item.dart';
import 'package:yabalash_mobile_app/features/cart/presentation/blocs/cubit/super_markets_cubit.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_layouts.dart';
import '../../../../core/depedencies.dart';
import '../../../../core/services/app_settings_service.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_svg_icon.dart';
import '../../../home/domain/entities/store.dart';

enum _HeaderType { image, title }

List<double> totals = [500, 211, -1];

class NewSupermarketsSection extends StatelessWidget {
  const NewSupermarketsSection({super.key, required this.isAvailableMarkets});

  final bool isAvailableMarkets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuperMarketsCubit, SuperMarketsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isAvailableMarkets
                ? SizedBox()
                : Row(
                    children: [
                      const CustomSvgIcon(
                        iconPath: AppAssets.notAvailable,
                        color: AppColorsLight.kErrorColor,
                      ),
                      smallHorizontalSpace,
                      Text(
                        'بعض المنتجات غير متوفرة',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColorsLight.kErrorColor,
                            ),
                      ),
                    ],
                  ),
            largeVerticalSpace,
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildProductCells(
                        _convertTableColumnHeader(state.supermarketsTable!),
                        _HeaderType.image),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildProductCells(
                        _convertTableColumnHeader(state.supermarketsTable!),
                        _HeaderType.title),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildRows(
                            _convertTable(state.supermarketsTable!),
                            state.tableHeaderRow!,
                            _convertTableTotalRow(state.supermarketsTable!)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            largeVerticalSpace,
          ],
        );
      },
    );
  }
}

List<CartItem> _convertTableColumnHeader(
    Map<CartItem, Map<Store, double>> table) {
  return table.entries.map((e) => e.key).toList();
}

List<double> _convertTableTotalRow(Map<CartItem, Map<Store, double>> table) {
  Map<int, double> total = {};
  for (var item in table.values) {
    for (var prices in item.entries) {
      if (prices.value >= 0) {}
      if (total.containsKey(prices.key.id)) {
        if (prices.value >= 0 && total[prices.key.id]! >= 0) {
          total[prices.key.id!] = total[prices.key.id!]! + prices.value;
        } else if (total[prices.key.id]! >= 0) {
          total[prices.key.id!] = -1;
        }
      } else {
        if (prices.value >= 0) {
          total[prices.key.id!] = prices.value;
        } else {
          total[prices.key.id!] = -1;
        }
      }
    }
  }

  return total.values.toList();
}

int _getMinPrice(List<double> row) {
  double minPrice = maxDouble;
  int index = -1;
  for (int i = 0; i < row.length; i++) {
    if (row[i] > 0 && row[i] < minPrice) {
      minPrice = row[i];
      index = i;
    }
  }
  return index;
}

List<List<double>> _convertTable(Map<CartItem, Map<Store, double>> table) {
  return table.entries
      .map((e) => e.value.entries.map((entry) => entry.value).toList())
      .toList();
}

List<Widget> _buildCells(List<double> row) {
  int min = _getMinPrice(row);
  double width = window.physicalSize.width;
  int minCount = ((width - 300) / 200).round();
  return List.generate(
      row.length >= minCount ? row.length : minCount,
      (index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          decoration: BoxDecoration(
              border: const Border(
                  left: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)),
                  top: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)),
                  bottom: BorderSide(width: 0.5, color: Color(0xFFDEDEDE)),
                  right: BorderSide(width: 0.5, color: Color(0xFFDEDEDE))),
              color: index < row.length
                  ? row[index] > 0
                      ? min == index
                          ? Color(0xFF8BCC64)
                          : Colors.white
                      : const Color(0xFFEBEBEB)
                  : null),
          //
          child: index < row.length
              ? row[index] > 0
                  ? _PriceWidget(
                      price: row[index], isMin: min == index, isTotal: false)
                  : null
              : null));
}

List<Widget> _buildProductCells(List<CartItem> products, _HeaderType type) {
  return List.generate(
      products.length + 1,
      (index) => Container(
            alignment: Alignment.center,
            width: type == _HeaderType.image ? 80 : 100,
            height: index == 0 ? 50 : 60,
            decoration: BoxDecoration(
                border: Border(
                    left: index == 0 && type == _HeaderType.image
                        ? BorderSide(width: 0.0, color: Colors.white)
                        : BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                    top: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                    bottom: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                    right: index == 0 && type == _HeaderType.title
                        ? BorderSide(width: 0.0, color: Colors.white)
                        : BorderSide(width: 0.5, color: Color(0xFFEBEBEB)))),
            //
            child: index == 0
                ? null
                : type == _HeaderType.image
                    ? AppImage(
                        path: products[index - 1].product!.imagePath,
                        fit: BoxFit.contain,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(products[index - 1].product!.name!,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
          ));
}

List<Widget> _buildStoreCells(List<Store> stores) {
  double width = window.physicalSize.width;
  int minCount = ((width - 300) / 200).round();
  return List.generate(
      stores.length >= minCount ? stores.length : minCount,
      (index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  top: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  bottom: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  right: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)))),
          //
          child: index < stores.length
              ? AppImage(
                  path: stores[index].logoImagePath,
                  fit: BoxFit.contain,
                )
              : null));
}

List<Widget> _buildTotalCells(List<double> totalPrices) {
  int min = _getMinPrice(totalPrices);
  double width = window.physicalSize.width;
  int minCount = ((width - 300) / 200).round();
  return List.generate(
      totalPrices.length >= minCount ? totalPrices.length : minCount,
      (index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: min == index
                  ? Color(0xFF8BCC64)
                  : index < totalPrices.length
                      ? totalPrices[index] < 0
                          ? Color(0xFFEBEBEB)
                          : Colors.white
                      : null,
              border: const Border(
                  left: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  top: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  bottom: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)),
                  right: BorderSide(width: 0.5, color: Color(0xFFEBEBEB)))),
          //
          child: index < totalPrices.length
              ? totalPrices[index] < 0
                  ? null
                  : _PriceWidget(
                      price: totalPrices[index],
                      isMin: min == index,
                      isTotal: true)
              : null));
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget(
      {super.key,
      required this.price,
      required this.isMin,
      this.isTotal = false});

  final double price;
  final bool isMin;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$price",
            style: TextStyle(
                fontSize: 16,
                fontWeight: isMin ? FontWeight.w700 : FontWeight.w600,
                color: isMin
                    ? isTotal
                        ? Color(0xFFF5E852)
                        : Colors.white
                    : Colors.black)),
        Text(' جنية',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isMin
                    ? isTotal
                        ? Color(0xFFF5E852)
                        : Colors.white
                    : Colors.black))
      ],
    );
  }
}

List<Widget> _buildRows(
    List<List<double>> columns, List<Store> stores, List<double> totalPrices) {
  return List.generate(
    columns.length + 2,
    (index) => index == 0
        ? Row(
            children: _buildStoreCells(stores),
          )
        : index == columns.length + 1
            ? Row(
                children: _buildTotalCells(totalPrices),
              )
            : Row(
                children: _buildCells(columns[index - 1]),
              ),
  );
}
