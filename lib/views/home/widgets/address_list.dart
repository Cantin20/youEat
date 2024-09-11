import 'package:flutter/material.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/address_response.dart';
import 'package:youeat/views/home/widgets/address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.address});

  final List<AddressResponse> address;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: address.length,
      itemBuilder: (context, index) {
        final addresses = address[index];
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(
              color: kGray,
              width: 0.5,
            ),
            top: BorderSide(
              color: kGray,
              width: 0.5,
            ),
            
            )
          ),
          child: AddressTile(address: addresses),
        );
      },
    );
  }
}
