import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherFetchLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherFetchFailure) {
                  return Text(state.failureMessage.failureMessage);
                } else if (state is WeatherFetchSuccess) {
                  String temperature= state.weatherInfo.main!.temp!;
                  return Text(
                    temperature,
                    style: const TextStyle(fontSize: 20),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Please Enter City Name",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 34),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<WeatherBloc>()
                      .add(WeatherFetchEvent(cityName: searchController.text));
                },
                child: const Text("Show temperature"))
          ],
        ),
      ),
    );
  }
}
