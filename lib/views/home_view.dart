import 'package:cartvia_project/data/repositories/shopping_list_repository.dart';
import 'package:cartvia_project/viewmodels/home_view_model.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:cartvia_project/views/shopping_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(viewModel.title),
      ),
      body: Container(
        // Background gradient (very subtle like design)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF3EEE8),
              Color(0xFFEDE6DF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TOP HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "APRIL 2026",
                          style: TextStyle(
                            letterSpacing: 2,
                            color: Color(0xFFB84E2A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Saved Lists",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey.shade300,
                      child: const Text(
                        "S",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 25),

                /// ORANGE CARD (Gradient)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEB6B3F),
                        Color(0xFFF39A61),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "YOUR LISTS",
                            style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Saved grocery lists",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          "New List",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// COLLECTIONS
                const Text(
                  "COLLECTIONS",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Color(0xFFB84E2A),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Choose a saved list",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                /// LIST ITEMS
                Expanded(
                  child: ListView(
                    children: [
                      listCard(
                        title: "Home Monthly List",
                        subtitle: "MAIN HOME",
                        items: "24 items",
                        action: "Share",
                        highlight: true,
                      ),
                      listCard(
                        title: "School Week List",
                        subtitle: "KIDS SNACKS",
                        items: "8 items",
                        action: "View",
                      ),
                      listCard(
                        title: "Family Dinner List",
                        subtitle: "WEEKEND MEAL",
                        items: "12 items",
                        action: "View",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listCard({
    required String title,
    required String subtitle,
    required String items,
    required String action,
    bool highlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: highlight ? Border.all(color: const Color(0xFFE6B8A5)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              subtitle,
              style: const TextStyle(
                letterSpacing: 2,
                color: Color(0xFFB84E2A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Row(
            children: [
              Text(items, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  action,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
