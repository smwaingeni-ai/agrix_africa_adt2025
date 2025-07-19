import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/market/market_item.dart';
import 'package:agrix_africa_adt2025/screens/market/market_item_form.dart';
import 'package:agrix_africa_adt2025/screens/market/market_detail_screen.dart';
import 'package:agrix_africa_adt2025/services/market/market_service.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<MarketItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await MarketService.loadItems();
    setState(() {
      _items = items;
    });
  }

  void _addItem(MarketItem item) async {
    await MarketService.addItem(item);
    _loadItems();
  }

  void _openForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarketItemForm(onSubmit: _addItem),
      ),
    );
  }

  void _openDetails(MarketItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarketDetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openForm,
          )
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No market items available.'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('${item.category} • ${item.location}'),
                  trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                  onTap: () => _openDetails(item),
                );
              },
            ),
    );
  }
}
