import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yabalash_mobile_app/features/addresses/presentation/blocs/cubit/update_address_cubit.dart';

import '../../../../core/constants/app_layouts.dart';
import '../../../../core/depedencies.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/zone_service.dart';
import '../../../../core/theme/light/app_colors_light.dart';
import '../../../../core/widgets/custom_form_section.dart';
import '../../../../core/widgets/phone_number_text_field.dart';
import '../../domain/entities/address.dart';

class AddressForm extends StatelessWidget {
  final bool isFromEdit;
  final GlobalKey<FormBuilderState> formkey;
  final BuildContext context;
  final Address? address;
  const AddressForm(
      {super.key,
      required this.isFromEdit,
      this.address,
      required this.formkey,
      required this.context});
  void validateOnChanged(String value) {
    if (value.isEmpty) {
      BlocProvider.of<UpdateAddressCubit>(context).changeButtonDisability(true);
    }

    if (formkey.currentState!.fields['district']!.value != '' &&
        formkey.currentState!.fields['zone']!.value != '' &&
        formkey.currentState!.fields['fullName']!.value != '' &&
        formkey.currentState!.fields['street']!.value != '' &&
        formkey.currentState!.fields['buildingNo']!.value != '' &&
        formkey.currentState!.fields['floor']!.value != '' &&
        formkey.currentState!.fields['apartment']!.value != '') {
      BlocProvider.of<UpdateAddressCubit>(context)
          .changeButtonDisability(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رقم الهاتف',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
            mediumVerticalSpace,
            PhoneTextField(
              intialValue: getIt<UserService>().currentCustomer != null
                  ? getIt<UserService>().currentCustomer!.phoneNumber
                  : 'غير متوفر',
              readOnly: true,
            ),
            mediumVerticalSpace,
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CustomFormSection(
                      title: Text(
                        'الحي',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      name: 'district',
                      intialValue: address != null
                          ? address!.fullAddress!.split('%')[1]
                          : '',
                      onChanged: (value) {
                        validateOnChanged(value!);
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'الحي مطلوب')
                      ]),
                    )),
                mediumHorizontalSpace,
                Expanded(
                    flex: 1,
                    child: CustomFormSection(
                      title: Text(
                        'المنطقة',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      name: 'zone',
                      fillColor: AppColorsLight.kDisabledButtonColor,
                      intialValue: getIt<ZoneService>().currentSubZone!.name,
                      readOnly: true,
                      onChanged: (value) {
                        validateOnChanged(value!);
                      },
                      validator: !isFromEdit
                          ? FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'المنطقة مطلوبة')
                            ])
                          : null,
                    ))
              ],
            ),
            largeVerticalSpace,
            CustomFormSection(
              title: Text(
                'الاسم بالكامل',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
              name: 'fullName',
              intialValue:
                  address != null ? address!.fullAddress!.split('%')[0] : '',
              onChanged: (value) {
                validateOnChanged(value!);
              },
              validator: !isFromEdit
                  ? FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'الاسم مطلوب')
                    ])
                  : null,
            ),
            largeVerticalSpace,
            CustomFormSection(
              title: Text(
                'اسم / رقم الشارع',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
              name: 'street',
              intialValue:
                  address != null ? address!.fullAddress!.split('%')[2] : '',
              onChanged: (value) {
                validateOnChanged(value!);
              },
              validator: !isFromEdit
                  ? FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'اسم او رقم الشارع مطلوب')
                    ])
                  : null,
            ),
            largeVerticalSpace,
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CustomFormSection(
                      title: Text(
                        'رقم المبني',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      name: 'buildingNo',
                      intialValue: address != null ? address!.buildingNo : '',
                      onChanged: (value) {
                        validateOnChanged(value!);
                      },
                      validator: !isFromEdit
                          ? FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'رقم المبنى مطلوب')
                            ])
                          : null,
                    )),
                mediumHorizontalSpace,
                Expanded(
                    flex: 1,
                    child: CustomFormSection(
                      title: Text(
                        'رقم الدور',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      name: 'floor',
                      intialValue: address != null ? address!.floor : '',
                      onChanged: (value) {
                        validateOnChanged(value!);
                      },
                      validator: !isFromEdit
                          ? FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'رقم الدور مطلوب')
                            ])
                          : null,
                    )),
                mediumHorizontalSpace,
                Expanded(
                    flex: 1,
                    child: CustomFormSection(
                      title: Text(
                        'رقم الشقة',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                      name: 'apartment',
                      intialValue: address != null ? address!.apartmentNo : '',
                      onChanged: (value) {
                        validateOnChanged(value!);
                      },
                      validator: !isFromEdit
                          ? FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'رقم الشقة مطلوب')
                            ])
                          : null,
                    ))
              ],
            ),
          ],
        ));
  }
}
