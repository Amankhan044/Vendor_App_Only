class VendorsUserModel {
  final bool? approved;
  final String? bussinessName;
  final String? cityValue;
  final String? countryValue;
  final String? emailAddress;
  final String? phoneNumber;
  final String? stateValue;
  final String? storeImage;
  final String? taxNumber;
  final String? taxStatus;

  VendorsUserModel({
    required this.approved,
    required this.bussinessName,
    required this.cityValue,
    required this.countryValue,
    required this.emailAddress,
    required this.phoneNumber,
    required this.stateValue,
    required this.storeImage,
    required this.taxNumber,
    required this.taxStatus,
  });

   VendorsUserModel.fromJson(Map<String, Object?> json): 
    this(
      approved: json['approved']! as bool , 
      bussinessName: json['bussinessName']! as String, 
      cityValue: json['cityValue']! as String,
      countryValue: json['countryValue']! as String,
      emailAddress: json['emailAddress']! as String,
      phoneNumber: json['phoneNumber']! as String,
      stateValue: json['stateValue']! as String,
      storeImage: json['storeImage']! as String,
      taxNumber: json['taxNumber']! as String,
      taxStatus: json['taxStatus']! as String,
    );

    Map<String, Object?> toJson(){
      return {
          'approved': false,
        'bussinessName': bussinessName,
          'cityValue': cityValue,
          'countryValue': countryValue,
          'emailAddress': emailAddress,
          'phoneNumber': phoneNumber,
          'stateValue': stateValue,
          'storeImage': storeImage,
          'taxNumber': taxNumber,
          'taxStatus': taxStatus,
      };
    }
  
}
