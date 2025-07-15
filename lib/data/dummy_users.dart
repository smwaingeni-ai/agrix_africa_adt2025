import '../models/user_model.dart';

/// 🔹 Mocked list of users for dev/testing/demo purposes
final List<UserModel> dummyUsers = [
  const UserModel(
    id: 'user001',
    name: 'John Zulu',
    role: 'Farmer',
    passcode: '1234',
  ),
  const UserModel(
    id: 'user002',
    name: 'Officer Mary Banda',
    role: 'AREX Officer',
    passcode: '5678',
  ),
  const UserModel(
    id: 'user003',
    name: 'Mr. Mwamba',
    role: 'Government Official',
    passcode: '9999',
  ),
  const UserModel(
    id: 'user004',
    name: 'Admin AgriX',
    role: 'Admin',
    passcode: 'admin',
  ),
  const UserModel(
    id: 'user005',
    name: 'Trader Nyambe',
    role: 'Trader',
    passcode: 'trade123',
  ),
  const UserModel(
    id: 'user006',
    name: 'Investor Grace',
    role: 'Investor',
    passcode: 'invest456',
  ),
];
