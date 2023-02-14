import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwithapi/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        HomeProvider provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(title: const Text("Rest Api")),
          body: Builder(
            builder: (context) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.error.isNotEmpty) {
                return Center(
                  child: Text(provider.error),
                );
              } else {
                return ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.data!.getAt(index)!.title.toString()),
                  );
                },
                itemCount: provider.data!.length,);
              }
            },
          ),
        );
      },
    );
  }
}
