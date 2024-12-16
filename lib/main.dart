import 'package:flutter/material.dart';
import 'core/network/api_endpoints.dart';
import 'core/network/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _token = 'No Token';

  /// 调用接口获取 Token
  void _fetchToken() async {
    const path = '/token'; // 替换为你的接口路径
    const params = {
      'thirdPartyType': null,
      'phoneNumber': '0010',
      'password': '123456',
    };

    // 使用 ApiService 调用接口
    await ApiService().post(
      ApiEndpoints.login,
      data: params,
      requiresToken: false,
      onSuccess: (data) {
        setState(() {
          _token = data['token']; // 假设接口返回的 JSON 中有 `token` 字段
        });
      },
      onError: (error) {
        setState(() {
          _token = 'Error: $error';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Click the button to fetch the token:'),
            Text(
              _token,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchToken,
              child: const Text('Fetch Token'),
            ),
          ],
        ),
      ),
    );
  }
}