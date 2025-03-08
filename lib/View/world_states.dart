import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: height * .01),
              FutureBuilder(
                future: statesServices.fetchWorldStates(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50,
                          controller: _controller,
                        ),
                      ),
                    );
                  } else {
                    WorldStatesModel data = snapshot.data!;
                    return Expanded(
                      child: Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(data.cases.toString()),
                              "Recovered":
                                  double.parse(data.recovered.toString()),
                              "Deaths": double.parse(data.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            chartRadius: 130,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            colorList: colorList,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.06),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                        title: "Total Cases",
                                        value: data.cases.toString()),
                                    ReuseableRow(
                                        title: "Recovered",
                                        value: data.recovered.toString()),
                                    ReuseableRow(
                                        title: "Deaths",
                                        value: data.deaths.toString()),
                                    ReuseableRow(
                                        title: "Active Cases",
                                        value: data.active.toString()),
                                    ReuseableRow(
                                        title: "Critical",
                                        value: data.critical.toString()),
                                    ReuseableRow(
                                        title: "Today ",
                                        value: data.active.toString()),
                                    ReuseableRow(
                                        title: "Today Deaths",
                                        value: data.todayDeaths.toString()),
                                    ReuseableRow(
                                        title: "Today recovered",
                                        value: data.todayRecovered.toString()),
                                    ReuseableRow(
                                        title: "Total Population",
                                        value: data.population.toString()),
                                    ReuseableRow(
                                        title: "Tests Done",
                                        value: data.tests.toString()),
                                    ReuseableRow(
                                        title: "Affected Countries",
                                        value:
                                            data.affectedCountries.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CountriesList());
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Track Countries",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 18,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
              Text(value,
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 5),
          Divider(
            height: 10,
          ),
        ],
      ),
    );
  }
}
