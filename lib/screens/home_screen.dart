import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hype_kicks/colors.dart';
import 'package:hype_kicks/data/home_repository.dart';
import 'package:hype_kicks/enums.dart';
import 'package:hype_kicks/models/shoe.dart';
import 'package:hype_kicks/offer_indicator.dart';
import 'package:hype_kicks/screens/shoe_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLiked = false;
  var _currentIndex = 0;

  final gradientColors = [
    [
      const Color.fromRGBO(0, 114, 198, 0.8),
      const Color.fromRGBO(0, 55, 96, 0.9),
    ],
    [
      Colors.black26,
      const Color(0xFF333333),
    ],
    [
      const Color(0xFF1D2939),
      // const Color.fromARGB(117, 14, 26, 56),
      const Color.fromARGB(192, 129, 49, 0)
    ],
    [
      const Color.fromARGB(37, 41, 71, 146),
      const Color(0xFF1D2939),
      // Colors.blue[900]!,
      // Colors.amber[900]!,
    ]
  ];

  void navigate(Shoe shoe, List<Shoe> moreShoes) {
    Navigator.pushNamed(
      context,
      ShoeDetailsScreen.detailsScreen,
      arguments: {
        'shoe': shoe,
        'moreShoes': moreShoes,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(Brand.values.toList());

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/ag.svg'),
              const SizedBox(width: 100),
              SvgPicture.asset('assets/search.svg'),
            ],
          ),
        ),
      )),
      body: FutureBuilder(
          future: homeRepo.fetchShoes(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.hasData) {
              final shoes = snapshot.data!;
              final viewList = [shoes[8], shoes[3], shoes[0], shoes[10]];
              final specialOffers = [shoes[6], shoes[12], shoes[5], shoes[11]];
              final moreShoes = [shoes[3], shoes[10], shoes[0], shoes[8]];
              // final moreShoes = [shoes[10]];
              final featuredSneakers = [
                shoes[8],
                shoes[1],
                shoes[2],
                shoes[7],
                shoes[4],
                shoes[9]
              ];
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/dp.png'),
                            const SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good afternoon 👋🏽',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                        color: gray300,
                                      ),
                                ),
                                Text(
                                  'Ada Dennis',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.0,
                                        color: gray500,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        SizedBox(
                          height: 200.0,
                          child: PageView.builder(
                            itemCount: viewList.length,
                            onPageChanged: (itemIndex) {
                              setState(() {
                                _currentIndex = itemIndex;
                              });
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () =>
                                    navigate(viewList[index], moreShoes),
                                child: Stack(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                        left: 32.0,
                                        top: 23.0,
                                        right: 18.0,
                                        bottom: 16.0,
                                      ),
                                      decoration: BoxDecoration(
                                        // color: dummy,
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: gradientColors[index],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Image.network(
                                        viewList[index].photoUrls.first,
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.contain,
                                      ),
                                      // Image.network(shoes[0].photoUrls.first),
                                    ),
                                    Positioned(
                                      top: 66.0,
                                      right: 20.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            viewList[index].category.first,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  fontSize: 8.0,
                                                  color: gray50,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                viewList[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: gray50,
                                                    ),
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                viewList[index].formattedPrice,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: gray50),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 18.0,
                                      bottom: 65.0,
                                      child: SizedBox(
                                        height: 30.0,
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFF0072C6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          onPressed: () {},
                                          label: Text(
                                            'Add to cart',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 12.0,
                                                  color:
                                                      const Color(0xFF0072C6),
                                                ),
                                          ),
                                          icon: SvgPicture.asset(
                                              'assets/basket.svg'),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (var i = 0;
                                              i < viewList.length;
                                              i++) ...[
                                            OfferIndicator(
                                              isCurrentItem: i == _currentIndex,
                                            ),
                                            const SizedBox(width: 8.0),
                                          ],
                                        ],
                                      ),
                                    ),
                                    // Image.
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const BrandSection(),
                        const SizedBox(height: 48.0),
                        Text(
                          'Our Special Offers',
                          style: GoogleFonts.robotoFlex(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            color: black,
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: specialOffers.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.5,
                            crossAxisCount: 2,
                            crossAxisSpacing: 21.0,
                          ),
                          itemBuilder: (context, index) {
                            return LayoutBuilder(
                                builder: (context, constraints) {
                              final maxHeight = constraints.maxHeight;
                              // print(constraints);
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: maxHeight * 0.6,
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: gray50,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                shoes[index].photoUrls.first),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8.0,
                                        right: 8.2,
                                        child: GestureDetector(
                                          onTap: () => setState(
                                              () => isLiked = !isLiked),
                                          child: Container(
                                            width: 30.8,
                                            height: 30.8,
                                            decoration: BoxDecoration(
                                              color: isLiked
                                                  ? const Color(0xFFD42620)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 0.6),
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                            child: SvgPicture.asset(
                                              isLiked
                                                  ? 'assets/favourite_white.svg'
                                                  : 'assets/favourite.svg',
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   height: 92,
                                  //   color: Colors.red[400],
                                  // ),
                                  SizedBox(
                                    height: maxHeight * 0.36,
                                    // color: Colors.amber,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoes[index].category.first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 10.0,
                                                color: gray500,
                                              ),
                                        ),
                                        Text(
                                          shoes[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                color: gray500,
                                              ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/star-half.svg'),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              '4.5 (100 sold)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    fontSize: 10.0,
                                                    color: gray500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  shoes[index].discountPrice,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color: const Color(
                                                            0xFF0072C6),
                                                      ),
                                                ),
                                                Text(
                                                  shoes[index].formattedPrice,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color: gray200,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                              width: 36.0,
                                              height: 28.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                          },
                        ),
                        Text(
                          'Featured Sneakers',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 24.0,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(height: 20.0),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: featuredSneakers.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.5,
                            crossAxisCount: 2,
                            crossAxisSpacing: 21.0,
                          ),
                          itemBuilder: (context, index) {
                            return LayoutBuilder(
                                builder: (context, constraints) {
                              final maxHeight = constraints.maxHeight;
                              // print(constraints);
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: maxHeight * 0.6,
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: gray50,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                shoes[index].photoUrls.first),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8.0,
                                        right: 8.2,
                                        child: GestureDetector(
                                          onTap: () => setState(
                                              () => isLiked = !isLiked),
                                          child: Container(
                                            width: 30.8,
                                            height: 30.8,
                                            decoration: BoxDecoration(
                                              color: isLiked
                                                  ? const Color(0xFFD42620)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 0.6),
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                            child: SvgPicture.asset(
                                              isLiked
                                                  ? 'assets/favourite_white.svg'
                                                  : 'assets/favourite.svg',
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   height: 92,
                                  //   color: Colors.red[400],
                                  // ),
                                  SizedBox(
                                    height: maxHeight * 0.36,
                                    // color: Colors.amber,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoes[index].category.first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 10.0,
                                                color: gray500,
                                              ),
                                        ),
                                        Text(
                                          shoes[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                color: gray500,
                                              ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/star-half.svg'),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              '4.5 (100 sold)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    fontSize: 10.0,
                                                    color: gray500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  shoes[index].formattedPrice,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                        color: const Color(
                                                          0xFF0072C6,
                                                        ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                          },
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF0072C6),
                            ),
                            child: const Text('View more'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 100.0,
                      color: Colors.red,
                    ),
                    Text('Failed to load hyper kicks'),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Loading...'),
            );
          }),
    );
  }
}

class BrandSection extends StatelessWidget {
  const BrandSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 50.0,
      runSpacing: 46.0,
      children: [
        // ...Brand.allValues,
        ...Brand.values.map(
          (brand) {
            return Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    // color: Colors.grey,
                    color: secondary50,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    brand.imagePath,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  brand.name,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: gray500,
                      ),
                )
              ],
            );
          },
        ),
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            // color: Colors.grey,

            color: secondary50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'View all',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w500,
                    color: gray500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
