import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:agrix_africa_adt2025/models/market/market_item.dart';

class MarketItemForm extends StatefulWidget {
  final Function(MarketItem) onSubmit;

  const MarketItemForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<MarketItemForm> createState() => _MarketItemFormState();
}

class _MarketItemFormState extends State<MarketItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  String? _title;
  String? _description;
  double? _price;
  String _category = 'Crops';
  String? _contact;
  File? _imageFile;

  final List<String> _categories = ['Crops', 'Livestock', 'Equipment', 'Fertilizer', 'Other'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newItem = MarketItem(
        id: _uuid.v4(),
        title: _title!,
        description: _description!,
        price: _price!,
        category: _category,
        contact: _contact!,
        imagePath: _imageFile?.path ?? '',
        postedAt: DateTime.now().toIso8601String(),
      );

      widget.onSubmit(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Market Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Enter a description' : null,
                onSaved: (value) => _description = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null ? 'Enter a valid price' : null,
                onSaved: (value) => _price = double.tryParse(value!),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _category = val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Info'),
                validator: (value) => value == null || value.isEmpty ? 'Provide contact info' : null,
                onSaved: (value) => _contact = value,
              ),
              const SizedBox(height: 16),
              _imageFile != null
                  ? Image.file(_imageFile!, height: 150)
                  : const Text('No image selected'),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Select Image'),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check),
                label: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
