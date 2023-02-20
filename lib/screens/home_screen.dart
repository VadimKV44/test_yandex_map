import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map/cubits/search_cubit/search_cubit.dart';
import 'package:test_map/screens/data_screen.dart';
import 'package:test_map/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TextEditingController searchContoller = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TextFormField(
                  controller: searchContoller,
                  onChanged: (request) {
                    BlocProvider.of<SearchCubit>(context).searchInDataScreen(request);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: 'Поиск',
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    MapScreen(),
                    DataScreen(),
                  ],
                ),
              ),
              SizedBox(
                height: 60.0,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white54,
                  unselectedLabelColor: Colors.white30,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.map, color: Colors.grey),
                    ),
                    Tab(
                      icon: Icon(Icons.list, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
