import 'dart:convert';

import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesServices
{
  Future<WorldStatesModel> fetchWorldStates() async{
    var response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body);

      return WorldStatesModel.fromJson(data);
    }
    else
    {
      throw Exception("Failed to load data");
    }

  }
}