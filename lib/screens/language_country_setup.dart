import 'package:flutter/material.dart';

class LanguageCountrySetupScreen extends StatefulWidget {
  const LanguageCountrySetupScreen({super.key});

  @override
  State<LanguageCountrySetupScreen> createState() => _LanguageCountrySetupScreenState();
}

class _LanguageCountrySetupScreenState extends State<LanguageCountrySetupScreen> {
  String? _selectedLanguage;
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedArea;

  final Map<String, List<String>> _provincesByCountry = {
    'Zimbabwe': ['Harare', 'Bulawayo', 'Manicaland', 'Mashonaland Central', 'Masvingo'],
    'Zambia': ['Lusaka', 'Copperbelt', 'Eastern', 'Northern', 'Southern'],
    'Kenya': ['Nairobi', 'Mombasa', 'Kisumu', 'Nakuru', 'Uasin Gishu'],
  };

  final List<String> _languages = ['English', 'French', 'Portuguese', 'Shona'];
  final List<String> _countries = ['Zimbabwe', 'Zambia', 'Kenya'];
  final List<String> _areas = ['Urban', 'Rural', 'Peri-Urban'];

  void _saveSetup() {
    if (_selectedLanguage == null ||
        _selectedCountry == null ||
        _selectedProvince == null ||
        _selectedArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all selections')),
      );
      return;
    }

    // TODO: Save selections to user profile or shared preferences
    // Example: UserPreferences.saveRegionSettings(...)

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Setup saved successfully')),
    );

    Navigator.pushReplacementNamed(context, '/landing'); // Or wherever needed
  }

  @override
  Widget build(BuildContext context) {
    final provinces = _selectedCountry != null
        ? _provincesByCountry[_selectedCountry] ?? []
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language & Region Setup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Language'),
              value: _selectedLanguage,
              items: _languages
                  .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedLanguage = val),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Country'),
              value: _selectedCountry,
              items: _countries
                  .map((country) => DropdownMenuItem(value: country, child: Text(country)))
                  .toList(),
              onChanged: (val) => setState(() {
                _selectedCountry = val;
                _selectedProvince = null; // reset province when country changes
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Province'),
              value: _selectedProvince,
              items: provinces
                  .map((prov) => DropdownMenuItem(value: prov, child: Text(prov)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedProvince = val),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Area'),
              value: _selectedArea,
              items: _areas
                  .map((area) => DropdownMenuItem(value: area, child: Text(area)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedArea = val),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Save and Continue'),
              onPressed: _saveSetup,
            )
          ],
        ),
      ),
    );
  }
}
