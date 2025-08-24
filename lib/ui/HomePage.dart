import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

/* class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ===== Carousel state =====
  int _currentCarousel = 0;
  int _currentPromo = 0;

  // ===== Carousel images (top slider) =====
  final List<String> carouselImages = [
    'images/HavitHeadphone.webp',
    'images/mini-3-pro-09Drone.webp',
    'images/mi-a-pro-43-01-500x500.webp',
  ];
  final List<Map<String, dynamic>> productOffers = [
    {
      'name': 'Wireless Headphones',
      'price': '2,499',
      'image': 'assets/images/HavitHeadphone.webp',
      'discount': '20% OFF',
    },
    {
      'name': 'Smart Watch',
      'price': '7,999',
      'image': 'assets/images/t3-ultra-black-01-500x500.webp',
      'discount': '৳50% OFF',
    },
    {
      'name': 'Dressers',
      'price': '1,799',
      'image': 'assets/images/Dressers.webp',
      'discount': '৳10% OFF',
    },
    {
      'name': 'Power Bank',
      'price': '1,299',
      'image': 'assets/images/j105-blue-01-500x500.webp',
      'discount': '৳05% OFF',
    },
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': '89,900',
      'image': 'assets/images/mini-3-pro-09Drone.webp',
      'discount': '৳05% OFF',
    },
    {
      'name': 'Rapoo C200 720p HD Webcam',
      'price': '2,449',
      'image': 'assets/images/RapooWebcap.webp',
      'discount': '৳10% OFF',
    },
    {
      'name': 'Canon Pixma G1010 Refillable Ink Tank Printer',
      'price': '13,600',
      'image': 'assets/images/CanonPrinter.jpg',
      'discount': '৳08% OFF',
    },
    {
      'name': 'Samsung Galaxy Tab A9 LTE 4GB Ram',
      'price': '22,500',
      'image': 'assets/images/SamsungGalaxyTAB.webp',
      'discount': '৳15% OFF',
    },
    {
      'name': 'KSTR HP930C Online UPS With Metal Body',
      'price': '33,500',
      'image': 'assets/images/KstarUPS.webp',
      'discount': '৳13% OFF',
    },
    {
      'name': 'Cukoo CR-303230 Cup Rice Cooker',
      'price': '3,299',
      'image': 'assets/images/CuckooCR.jpg',
      'discount': '৳10% OFF',
    },
  ];

  final List<Map<String, dynamic>> popularProducts = [
    {
      'name': 'iPhone X',
      'price': '25,999',
      'image': 'assets/images/appleiphonex-new-1.jpg',
    },
    {
      'name': 'Lenovo Thinkpad',
      'price': '65,999',
      'image': 'assets/images/ideapad-slim-3-15iah8-01-500x500.webp',
    },
    {
      'name': 'Mi 4k TV',
      'price': '42,999',
      'image': 'assets/images/mi-a-pro-43-01-500x500.webp',
    },
    {
      'name': 'Gaming Console',
      'price': '34,999',
      'image':
          'assets/images/nintendo-switch-oled-model-white-set-01-500x500.webp',
    },
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': '89,999',
      'image': 'assets/images/mini-3-pro-09Drone.webp',
    },
    {
      'name': 'Cisily Black Sponge Holder',
      'price': '1,899',
      'image': 'assets/images/CisilyBlackHolder.webp',
    },
    {
      'name': 'Smart Watch',
      'price': '7,999',
      'image': 'assets/images/t3-ultra-black-01-500x500.webp',
    },
    {
      'name': 'Candle Warner Lamp with Timer Dimmable',
      'price': '2,499',
      'image': 'assets/images/CandleWarnerLanp.webp',
    },
  ];

  final List<Map<String, dynamic>> promotionalHighlights = [
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': 89900,
      'image': 'images/mini-3-pro-09Drone.webp',
    },
    {
      'name': 'Rapoo C200 720p HD Webcam',
      'price': 2449,
      'image': 'assets/images/RapooWebcap.webp',
    },
  ];

  // ======= Helpers =======
  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 5; // Desktop
    if (width > 800) return 3; // Tablet
    return 2; // Mobile
  }

  // ======= Widgets =======
  Widget buildImageCarousel(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 700),
                enableInfiniteScroll: true,
                onPageChanged: (idx, reason) {
                  setState(() => _currentCarousel = idx);
                },
              ),
              items: carouselImages.map((path) {
                return Builder(
                  builder: (context) {
                    return Image.asset(
                      path,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselImages.length, (i) {
            final selected = _currentCarousel == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selected ? 18 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.black87 : Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildProductGrid(
    List<Map<String, dynamic>> items,
    BuildContext context,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: MediaQuery.of(context).size.width > 800 ? 0.72 : 0.68,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.grey.shade300,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1, // 1:1 ratio for square images
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(product['image'], fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "৳${product['price']}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (product.containsKey('discount'))
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      product['discount'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPromoBanner(BuildContext context) {
    // promotionalHighlights[0] থেকে ডাটা নিয়ে ডায়নামিক ব্যানার
    final item = promotionalHighlights.first;
    final name = item['name'] as String;
    final price = item['price'];
    final imagePath = item['image'] as String;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 5, // wide banner
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              // gradient overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "🎯 Promotional Highlights",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Starting at ৳$price",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            // TODO: Navigator.push to product details / category
                          },
                          child: const Text("Shop Now"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======= Build Method =======
  /*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🔥 Product Offers",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(productOffers, context),
            // const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "⭐ Popular Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(popularProducts, context),
            // const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🎯 Promotional Highlights",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(promotionalHighlights, context),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Image Carousel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildImageCarousel(context),
            ),

            const SizedBox(height: 16),

            // 2) Product Offers
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🔥 Product Offers",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(productOffers, context),
            const SizedBox(height: 8),

            // 3) Popular Products
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "⭐ Popular Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(popularProducts, context),
            const SizedBox(height: 8),

            // 4) Promotional Highlights (Wide Banner)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🎯 Promotional Highlights",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildPromoBanner(context),

            // (ঐচ্ছিক) চাইলে নিচে promotionalHighlights গ্রিডও দেখাতে পারো:
            // buildProductGrid(promotionalHighlights, context),
          ],
        ),
      ),
    );
  }
}
 */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarousel = 0;
  int _currentPromo = 0;

  final List<String> carouselImages = [
    'assets/images/3d-yellow-great-discount-sale-260nw-2056851839.webp',
    'assets/images/360_F_249501541_XmWdfAfUbWAvGxBwAM0ba2aYT36ntlpH.jpg',
    'assets/images/mi-a-pro-43-01-500x500.webp',
  ];

  final List<Map<String, dynamic>> productOffers = [
    {
      'name': 'Wireless Headphones',
      'price': '2,499',
      'image': 'assets/images/HavitHeadphone.webp',
      'discount': '20% OFF',
    },
    {
      'name': 'Smart Watch',
      'price': '7,999',
      'image': 'assets/images/t3-ultra-black-01-500x500.webp',
      'discount': '৳50% OFF',
    },
    {
      'name': 'Dressers',
      'price': '1,799',
      'image': 'assets/images/Dressers.webp',
      'discount': '৳10% OFF',
    },
    {
      'name': 'Power Bank',
      'price': '1,299',
      'image': 'assets/images/j105-blue-01-500x500.webp',
      'discount': '৳05% OFF',
    },
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': '89,900',
      'image': 'assets/images/mini-3-pro-09Drone.webp',
      'discount': '৳05% OFF',
    },
    {
      'name': 'Rapoo C200 720p HD Webcam',
      'price': '2,449',
      'image': 'assets/images/RapooWebcap.webp',
      'discount': '৳10% OFF',
    },
    {
      'name': 'Canon Pixma G1010 Refillable Ink Tank Printer',
      'price': '13,600',
      'image': 'assets/images/CanonPrinter.jpg',
      'discount': '৳08% OFF',
    },
    {
      'name': 'Samsung Galaxy Tab A9 LTE 4GB Ram',
      'price': '22,500',
      'image': 'assets/images/SamsungGalaxyTAB.webp',
      'discount': '৳15% OFF',
    },
    {
      'name': 'KSTR HP930C Online UPS With Metal Body',
      'price': '33,500',
      'image': 'assets/images/KstarUPS.webp',
      'discount': '৳13% OFF',
    },
    {
      'name': 'Cukoo CR-303230 Cup Rice Cooker',
      'price': '3,299',
      'image': 'assets/images/CuckooCR.jpg',
      'discount': '৳10% OFF',
    },
  ];
  final List<Map<String, dynamic>> popularProducts = [
    {
      'name': 'iPhone X',
      'price': '25,999',
      'image': 'assets/images/appleiphonex-new-1.jpg',
    },
    {
      'name': 'Lenovo Thinkpad',
      'price': '65,999',
      'image': 'assets/images/ideapad-slim-3-15iah8-01-500x500.webp',
    },
    {
      'name': 'Mi 4k TV',
      'price': '42,999',
      'image': 'assets/images/mi-a-pro-43-01-500x500.webp',
    },
    {
      'name': 'Gaming Console',
      'price': '34,999',
      'image':
          'assets/images/nintendo-switch-oled-model-white-set-01-500x500.webp',
    },
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': '89,999',
      'image': 'assets/images/mini-3-pro-09Drone.webp',
    },
    {
      'name': 'Cisily Black Sponge Holder',
      'price': '1,899',
      'image': 'assets/images/CisilyBlackHolder.webp',
    },
    {
      'name': 'Smart Watch',
      'price': '7,999',
      'image': 'assets/images/t3-ultra-black-01-500x500.webp',
    },
    {
      'name': 'Candle Warner Lamp with Timer Dimmable',
      'price': '2,499',
      'image': 'assets/images/CandleWarnerLanp.webp',
    },
  ];

  final List<Map<String, dynamic>> promotionalHighlights = [
    {
      'name': 'DJI Mini 3 Pro Drone',
      'price': 89900,
      'image': 'assets/images/mini-3-pro-09Drone.webp',
    },
    {
      'name': 'Rapoo C200 720p HD Webcam',
      'price': 2449,
      'image': 'assets/images/RapooWebcap.webp',
    },
  ];

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 5;
    if (width > 800) return 3;
    return 2;
  }

  Widget buildImageCarousel(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 700),
                enableInfiniteScroll: true,
                onPageChanged: (idx, reason) {
                  setState(() => _currentCarousel = idx);
                },
              ),
              items: carouselImages.map((path) {
                return Image.network(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselImages.length, (i) {
            final selected = _currentCarousel == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selected ? 18 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.black87 : Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildProductGrid(
    List<Map<String, dynamic>> items,
    BuildContext context,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: MediaQuery.of(context).size.width > 800 ? 0.72 : 0.68,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.grey.shade300,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(product['image'], fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "৳${product['price']}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (product.containsKey('discount'))
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      product['discount'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPromoBannerSlider(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width > 800 ? 250 : 180,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _currentPromo = index;
              });
            },
          ),
          items: promotionalHighlights.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AspectRatio(
                aspectRatio: 16 / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(item['image'], fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.55),
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "🎯 Promotional Highlights",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Starting at ৳${item['price']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Shop Now"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(promotionalHighlights.length, (index) {
            final selected = _currentPromo == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selected ? 18 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.black87 : Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildImageCarousel(context),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🔥 Product Offers",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(productOffers, context),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "⭐ Popular Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildProductGrid(popularProducts, context),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "🎯 Promotional Highlights",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
               const SizedBox(height: 12),
            buildPromoBannerSlider(context),
              
          ],
        ),
      ),
    );
  }
}
