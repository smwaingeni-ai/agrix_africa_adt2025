import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agrix_africa_adt2025/models/market_item.dart';
import 'package:agrix_africa_adt2025/services/market_service.dart';

class MarketItemForm extends StatefulWidget {
  const MarketItemForm({super.key});

  @override
  State<MarketItemForm> createState() => _MarketItemFormState();
}

class _MarketItemFormState extends State<MarketItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _location = '';
  double _price = 0.0;
  String _type = 'Sale';
  String _category = 'Crops';
  bool _isLoanAccepted = false;
  bool _isInvestorOpen = false;
  String _investmentTerm = 'None';
  String _paymentOption = 'Cash';
  File? _selectedImage;

  final List<String> _types = ['Sale', 'Lease', 'Barter', 'Request'];
  final List<String> _categories = [
    'Crops',
    'Livestock',
    'Land',
    'Equipment',
    'Service'
  ];
  final List<String> _terms = [
    'None',
    'Short-term (1-2 yrs)',
    'Mid-term (3-5 yrs)',
    'Long-term (>6 yrs)'
  ];
  final List<String> _payments = [
    'Cash',
    'Bank Transfer',
    'Mobile Money',
    'QR Code',
    'Loan',
    'Debit Card'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _saveListing() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      final item = MarketItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title,
        description: _description,
        category: _category,
        type: _type,
        listingType: _type,
        location: _location,
        price: _price,
        imagePaths: _selectedImage != null ? [_selectedImage!.path] : [],
        contactMethods: ['Phone'],
        paymentOptions: [_paymentOption],
        isAvailable: true,
        isLoanAccepted: _isLoanAccepted,
        isInvestmentOpen: _isInvestorOpen,
        investmentStatus: _isInvestorOpen ? 'Open' : 'Not Open',
        investmentTerm: _investmentTerm,
        ownerName: 'Self',
        ownerContact: '0000000000',
        postedAt: DateTime.now(),
      );

      await MarketService.addItem(item);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Listing saved successfully!")),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('➕ Add Market Listing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter title' : null,
              onSaved: (value) => _title = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter description' : null,
              onSaved: (value) => _description = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter location' : null,
              onSaved: (value) => _location = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price (USD)'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter price' : null,
              onSaved: (value) =>
                  _price = double.tryParse(value ?? '0') ?? 0.0,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              value: _type,
              items: _types
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: _category,
              items: _categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Payment Option'),
              value: _paymentOption,
              items: _payments
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _paymentOption = value!),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text("Accept Loan as Payment"),
              value: _isLoanAccepted,
              onChanged: (value) =>
                  setState(() => _isLoanAccepted = value ?? false),
            ),
            CheckboxListTile(
              title: const Text("Open for Investment"),
              value: _isInvestorOpen,
              onChanged: (value) =>
                  setState(() => _isInvestorOpen = value ?? false),
            ),
            if (_isInvestorOpen)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Investment Term'),
                value: _investmentTerm,
                items: _terms
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _investmentTerm = value!),
              ),
            const SizedBox(height: 12),
            _selectedImage == null
                ? const Text("📷 No image selected.")
                : Image.file(_selectedImage!, height: 150),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Select Image"),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Listing'),
              onPressed: _saveListing,
            ),
          ]),
        ),
      ),
    );
  }
}
