import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_app_only/model/vendor_registration_provider.dart';

class VendorRegistrationView extends StatelessWidget {
  const VendorRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final _registrationProvider =
        Provider.of<VendorRegistrationProvider>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.yellow.shade900, Colors.yellow])),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<VendorRegistrationProvider>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return InkWell(
                                  onTap: () {
                                    value.selectImageFromGallery();
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: value.image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.memory(
                                              value.image!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          )
                                        : Icon(Icons.photo),
                                  ),
                                );
                              },
                            )
                          ]),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _registrationProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Business Name'),
                      onChanged: (value) {
                        _registrationProvider.businessName=value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                       onChanged: (value) {
                        _registrationProvider.emailAddress=value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                       onChanged: (value) {
                        _registrationProvider.PhoneNumber=value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length != 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          print("Country changed to: $value");
                          _registrationProvider.setCountryValue(value);
                        },
                        onStateChanged: (value) {
                          print("State changed to: $value");
                          _registrationProvider.setStateValue(value);
                        },
                        onCityChanged: (value) {
                          print("City changed to: $value");
                          _registrationProvider.setCityValue(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax Registered?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: 150,
                              child: DropdownButtonFormField(
                                  items: _registrationProvider.taxOptions
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (value) {
                                    _registrationProvider
                                        .checkTaxStatus(value!);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your tax status';
                                    }
                                    return null;
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Consumer<VendorRegistrationProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: value.textFormField(),
                      );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        _registrationProvider.saveVendorDetails();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade900),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
