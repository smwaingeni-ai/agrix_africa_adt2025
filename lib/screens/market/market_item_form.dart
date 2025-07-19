import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:your_project_name/models/market_item.dart'; // ✅ Only import here
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MarketItemForm extends StatefulWidget {
  final Function(MarketItem) onSubmit;

  const MarketItemForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _MarketItemFormState createState() => _MarketItemFormState();
}

class _MarketItemFormState extends State<MarketItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _listingTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerContactController = TextEditingController();
  final TextEditingController _investmentStatusController = TextEditingController();
  final TextEditingController _investmentTermController = TextEditingController();

  List<String> _contactMethods = [];
  List<String> _paymentOptions = [];
  List<String> _imagePaths = [];

  bool _isAvailable = true;
  bool _isLoanAccepted = false;
  bool _isInvestmentOpen = false;

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imagePaths = pickedFiles.map((file) => file.path).toList();
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final marketItem = MarketItem(
        id: _uuid.v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        type: _typeController.text,
        listingType: _listingTypeController.text,
        location: _locationController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        imagePaths: _imagePaths,
        contactMethods: _contactMethods,
        paymentOptions: _paymentOptions,
        isAvailable: _isAvailable,
        isLoanAccepted: _isLoanAccepted,
        isInvestmentOpen: _isInvestmentOpen,
        investmentStatus: _investmentStatusController.text,
        investmentTerm: _investmentTermController.text,
        ownerName: _ownerNameController.text,
        ownerContact: _ownerContactController.text,
        postedAt: DateTime.now(),
      );

      widget.onSubmit(marketItem);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    _listingTypeController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _ownerNameController.dispose();
    _ownerContactController.dispose();
    _investmentStatusController.dispose();
    _investmentTermController.dispose();
    super.dispose();
  }

  Widget _buildChips(List<String> options, List<String> selected, Function(List<String>) onChanged) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selectedVal) {
            setState(() {
              if (selectedVal) {
                selected.add(option);
              } else {
                selected.remove(option);
              }
              onChanged(selected);
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const contactOptions = ['Phone', 'SMS', 'WhatsApp', 'Email'];
    const paymentOptions = ['Cash', 'Bank Transfer', 'QR Code', 'Debit Card', 'Loan'];

    return Scaffold(
      appBar: AppBar(title: const Text('Create Market Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _categoryController, decoration: const InputDecoration(labelText: 'Category'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _listingTypeController, decoration: const InputDecoration(labelText: 'Listing Type'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number, validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _ownerNameController, decoration: const InputDecoration(labelText: 'Owner Name'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _ownerContactController, decoration: const InputDecoration(labelText: 'Owner Contact'), validator: (value) => value!.isEmpty ? 'Required' : null),
              TextFormField(controller: _investmentStatusController, decoration: const InputDecoration(labelText: 'Investment Status')),
              TextFormField(controller: _investmentTermController, decoration: const InputDecoration(labelText: 'Investment Term')),
              const SizedBox(height: 12),
              const Text("Select Contact Methods:"),
              _buildChips(contactOptions, _contactMethods, (v) => _contactMethods = v),
              const SizedBox(height: 12),
              const Text("Select Payment Options:"),
              _buildChips(paymentOptions, _paymentOptions, (v) => _paymentOptions = v),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Available'),
                  Switch(value: _isAvailable, onChanged: (val) => setState(() => _isAvailable = val)),
                  const Text('Loan Accepted'),
                  Switch(value: _isLoanAccepted, onChanged: (val) => setState(() => _isLoanAccepted = val)),
                ],
              ),
              Row(
                children: [
                  const Text('Investment Open'),
                  Switch(value: _isInvestmentOpen, onChanged: (val) => setState(() => _isInvestmentOpen = val)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Pick Images"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
