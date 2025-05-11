import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';

import '../../model/movie.dart';
import '../widgets/back_button.dart';

class DetailsScreen2 extends StatelessWidget {
  const DetailsScreen2({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackBtn(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 480,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  movie.title,
                  style: GoogleFonts.belleza(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.asset(
                      'lib/assets/movie____.png',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 500,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Release date: ",
                                style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movie.releaseDate,
                                style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 9),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Rating : ',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${movie.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Overview",
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Text(
                        movie.overview,
                        style: GoogleFonts.roboto(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
