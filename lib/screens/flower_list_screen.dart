import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solulab_technology/api/flower_api.dart';
import 'package:solulab_technology/screens/details_screen.dart';

class FlowerListScreen extends StatefulWidget {
  final FlowerApi api;

  const FlowerListScreen({Key? key, required this.api}) : super(key: key);

  @override
  _FlowerListScreenState createState() => _FlowerListScreenState();
}

class _FlowerListScreenState extends State<FlowerListScreen> {
  late Future<List<Flower>> _flowersFuture;
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.validateStatus = (status) => true;

    _flowersFuture = widget.api.getFlowers(_dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        shape: Border.symmetric(),
        title: Text('Flowers List'),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Flower>>(
        future: _flowersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No flowers found'));
          } else {
            final flowers = snapshot.data!;
            return ListView.builder(
              itemCount: flowers.length,
              itemBuilder: (context, index) {
                final flower = flowers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.greenAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          flower.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          flower.description,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(flower.imageUrl),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlowerDetailsScreen(flower: flower),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
