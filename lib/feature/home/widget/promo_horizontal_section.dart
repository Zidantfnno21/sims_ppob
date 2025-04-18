import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_popb/feature/home/provider/home_provider.dart';

import '../../../data/network/status.dart';

class PromoHorizontalSection extends StatefulWidget {
  const PromoHorizontalSection({super.key});

  @override
  State<PromoHorizontalSection> createState() => _PromoHorizontalSectionState();
}

class _PromoHorizontalSectionState extends State<PromoHorizontalSection> {
  @override
  void initState() {
    super.initState();
    fetchPromo();
  }

  void fetchPromo() {
    context.read<HomeProvider>().getBanner();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final promoHeight = screenHeight * 0.18;

    return SizedBox(
      child: Consumer<HomeProvider>(
        builder: (context, value, _) {
          final status = value.bannerResponse.status;
          final promoItem = value.bannerResponse.data?.data;

          Widget content;

          switch (status) {
            case Status.loading:
              content = ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, __) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 240,
                    height: promoHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
              break;

            case Status.completed:
              content = ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                scrollDirection: Axis.horizontal,
                itemCount: promoItem?.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final item = promoItem![index];
                  return Image.network(
                    item.bannerImage,
                    fit: BoxFit.cover,
                    height: promoHeight,
                  );
                },
              );
              break;

            case Status.error:
            default:
              content = const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Gagal memuat promo.",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              );
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Temukan promo menarik",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: promoHeight,
                child: content,
              ),
            ],
          );
        },
      ),
    );
  }

}
