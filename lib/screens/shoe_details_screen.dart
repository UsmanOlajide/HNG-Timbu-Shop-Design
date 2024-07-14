import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hype_kicks/colors.dart';
import 'package:hype_kicks/enums.dart';
import 'package:hype_kicks/models/shoe.dart';
import 'package:hype_kicks/screens/cart_screen.dart';

class ShoeDetailsScreen extends StatefulWidget {
  const ShoeDetailsScreen({super.key});

  static const detailsScreen = '/shoe-details-screen';

  @override
  State<ShoeDetailsScreen> createState() => _ShoeDetailsScreenState();
}

class _ShoeDetailsScreenState extends State<ShoeDetailsScreen> {
  var isFavorite = true;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final shoe = args['shoe'] as Shoe;
    final moreShoes = args['moreShoes'] as List<Shoe>;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset(
                  'assets/arrow_left.svg',
                  // colorFilter: const ColorFilter.mode(tintColor, BlendMode.srcIn),
                  fit: BoxFit.cover,
                ),
              ),
              // backgroundColor: Colors.green[300],
              // expandedHeight: 350,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                // title: OfferIndicator(isCurrentItem: true),
                background: Container(
                  // color: Colors.red,
                  // width: 40,
                  // height: 240,
                  child: Image.network(
                    shoe.photoUrls.first,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shoe.category.first,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 12.0,
                            color: gray500,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoe.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: gray500,
                                      ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  shoe.formattedPrice,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 15.0,
                                        color: gray500,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => isFavorite = !isFavorite),
                            child: Container(
                              width: 30.8,
                              height: 30.8,
                              decoration: BoxDecoration(
                                color: isFavorite
                                    ? const Color(0xFFD42620)
                                    : const Color.fromRGBO(0, 0, 0, 0.6),
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              child: SvgPicture.asset(
                                isFavorite
                                    ? 'assets/favourite_white.svg'
                                    : 'assets/favourite.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          '100 sold',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: gray400,
                                  ),
                        ),
                        const SizedBox(width: 8.0),
                        SvgPicture.asset('assets/star-half.svg'),
                        const SizedBox(width: 4.0),
                        Text(
                          '4.5 (32 reviews)',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: gray400,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 15.0,
                                    color: gray500,
                                  ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'The  Ego Vessel is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that\'s sure to make a statement. Whether you\'re running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 15.0,
                                    color: gray400,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Size',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 15.0,
                                    color: gray500,
                                  ),
                        ),
                        Wrap(
                          spacing: 12.0,
                          // runSpacing: ,
                          children: [
                            for (int i = 0; i < 7; i++)
                              Container(
                                width: 40.86,
                                height: 26.0,
                                decoration: BoxDecoration(
                                    color: i == 3
                                        ? const Color(0xFF0072C6)
                                        : secondary50,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Center(
                                  child: Text(
                                    // Access the corresponding number based on index
                                    '${ShoeSize.values[i].shoeSize}',
                                    style: TextStyle(
                                        color: i == 3 ? Colors.white : gray400),
                                  ),
                                ),
                              ),
                            // const SizedBox(width: 12.0),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Colours',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 15.0,
                                    color: gray500,
                                  ),
                        ),
                        const SizedBox(height: 4.0),
                        Wrap(
                          spacing: 12.0,
                          // runSpacing: ,
                          children: [
                            for (int i = 0; i < 7; i++)
                              Container(
                                width: 25.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                    color: ShoeColor.values[i].shoeColor,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: i == 3
                                    ? SvgPicture.asset('assets/tick.svg')
                                    : null,
                              ),

                            // const SizedBox(width: 12.0),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 15.0,
                                    color: gray500,
                                  ),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          width: 121.0,
                          height: 34.0,
                          decoration: BoxDecoration(
                            color: secondary50,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: 16.0,
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                width: 25.0,
                                height: 26.0,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(0, 114, 198, 0.12),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                child: const Text(
                                  '2',
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 16.0,
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        // child: ,
                      ],
                    ),
                    const SizedBox(height: 52.2),
                    Text(
                      'More from Ego',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 20.0),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: moreShoes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 21.0,
                      ),
                      itemBuilder: (context, index) {
                        // final discountPrice =
                        //     subtractDiscount(shoe.formattedPrice);
                        return LayoutBuilder(builder: (context, constraints) {
                          final maxHeight = constraints.maxHeight;
                          // print(constraints);
                          return Column(
                            children: [
                              Container(
                                height: maxHeight * 0.6,
                                margin: const EdgeInsets.only(bottom: 10.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: gray50,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        moreShoes[index].photoUrls.first),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 92,
                              //   color: Colors.red[400],
                              // ),
                              SizedBox(
                                height: maxHeight * 0.36,
                                // color: Colors.amber,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      moreShoes[index].category.first,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontSize: 10.0,
                                            color: gray500,
                                          ),
                                    ),
                                    Text(
                                      moreShoes[index].name,
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
                                              shoe.formattedPrice,
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
                  ],
                ),
                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   color: Colors.red,
                // ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 21.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 80.0,
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 12.0,
                            color: gray200,
                            height: 0,
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      shoe.formattedPrice,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 19.0,
                            color: gray500,
                            height: 0,
                          ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(CartScreen.cartScreen, arguments: moreShoes),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0072C6),
                  ),
                  label: const Text('Add to Cart'),
                  icon: SvgPicture.asset('assets/basket_white.svg'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
