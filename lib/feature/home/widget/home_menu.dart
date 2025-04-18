import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_popb/feature/payment/payment_screen.dart';

import '../../../data/network/status.dart';
import '../provider/home_provider.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  void initState() {
    super.initState();
    fetchQuickMenu();
  }

  void fetchQuickMenu() {
    context.read<HomeProvider>().getService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Consumer<HomeProvider>(
        builder: (context, value, _) {
          final status = value.serviceResponse.status;
          final service = value.serviceResponse.data?.data;

          switch (status) {
            case Status.loading:
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                  mainAxisExtent: 82,
                ),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 40,
                          height: 8,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              );

            case Status.completed:
              if (service == null || service.isEmpty) {
                return const Center(child: Text('No services available'));
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: service.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                  mainAxisExtent: 82,
                ),
                itemBuilder: (context, index) {
                  final item = service[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(service: item,)),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          item.serviceIcon,
                          width: 42,
                          height: 42,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 32),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.serviceName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, height: 1.2),
                        ),
                      ],
                    ),
                  );
                },
              );

            case Status.error:
            default:
              return const Center(child: Text('Failed to load services'));
          }
        },
      ),
    );
  }

}
