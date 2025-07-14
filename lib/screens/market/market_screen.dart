import 'package:flutter/material.dart';
import 'package:agrix_africa_adt2025/models/market_item.dart';
import 'package:agrix_africa_adt2025/services/market_service.dart';
import 'market_item_form.dart';
import 'market_detail_screen.dart';
import 'market_invite_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<MarketItem> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await MarketService.loadItems();
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  void _goToCreateItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketItemFormScreen()),
    );
    _loadItems();
  }

  void _goToInviteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketInviteScreen()),
    );
  }

  void _goToDetail(MarketItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MarketDetailScreen(item: item)),
    );
  }

  Widget _buildMarketCard(MarketItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${item.type}'),
            Text('Location: ${item.location}'),
            Text('Price: ${item.price}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => _goToDetail(item),
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
            icon: const Icon(Icons.group_add),
            onPressed: _goToInviteScreen,
            tooltip: "Invite to Market",
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _goToCreateItem,
            tooltip: "Add Listing",
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(
                  child: Text(
                    '📭 No market listings available.\nTap ➕ to add one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadItems,
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) => _buildMarketCard(_items[index]),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateItem,
        tooltip: 'Add New Listing',
        child: const Icon(Icons.add),
      ),
    );
  }
}
