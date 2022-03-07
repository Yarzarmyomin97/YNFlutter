import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  var dateFormat = DateFormat("dd/MM/yyyy EEEE");

  var modVal = 0;
  var houseName = "";
  var mmYear = 0;
  var isCheckBoxShow = false;
  var isAfterMMNewYear = false;
  String bornAfterMMNewYear = "Born after Myanmar New Year";
  // List<int> mainList = [1, 4, 0, 3, 6, 2, 5];

  List<String> numbersList = [];
  //1,4,0,3,6,2,5

  TextStyle _selectedColor(val) => TextStyle(
      color: houseName == val ? Theme.of(context).primaryColor : Colors.black);

  Text _labelText(val) => Text(val, style: _selectedColor(val));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("MahaBote"),
      ),
      body: _homeDesign(),
    );
  }

  _homeDesign() {
    return ListView(
      children: [
        Container(
          height: 120,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Theme.of(context).primaryColor),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2500),
                    helpText: "Select your Birthday",
                    cancelText: "Not now",
                  );
                  if (picked != null) {
                    if (selectedDate != picked) {
                      setState(() {
                        _calculateMahaBote(picked);
                      });
                    }
                  }
                },
                child: selected
                    ? Text(dateFormat.format(selectedDate))
                    : const Text("Select your Birthday"),
              ),
            ],
          ),
        ),
        isCheckBoxShow
            ? Container(
                margin: const EdgeInsets.all(12),
                child: Card(
                  child: CheckboxListTile(
                    onChanged: (newValue) {
                      setState(() {
                        isAfterMMNewYear = newValue!;
                        _calculateMahaBote(selectedDate);
                      });
                    },
                    value: isAfterMMNewYear,
                    title: Text(bornAfterMMNewYear),
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          height: 150,
          margin: const EdgeInsets.all(12),
          child: Card(
            child: _mahaBoteLayout(),
          ),
        ),
        selected
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text("အကြွင်း $modVal"),
                        Text(
                          houseName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Number List
        selected
            ? Container(
                height: 150,
                margin: const EdgeInsets.all(12),
                child: Card(
                  child: _numberLayout(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  _mahaBoteLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(""),
                _labelText("အဓိပတိ"),
                Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("အထွန်း"),
                _labelText("သိုက်"),
                _labelText("ရာဇ"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("မရဏ"),
                _labelText("ဘင်္ဂ"),
                _labelText("ပုတိ"),
              ],
            ),
          ],
        ),
      );

  _numberLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(""),
              Text(numbersList[3]),
              const Text(""),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(numbersList[6]),
              Text(numbersList[0]),
              Text(numbersList[1]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(numbersList[5]),
              Text(numbersList[4]),
              Text(numbersList[2]),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     const Text(""),
          //     _labelText(numbersList[3]),
          //     const Text(""),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     _labelText(numbersList[6]),
          //     _labelText(numbersList[0]),
          //     _labelText(numbersList[1]),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     _labelText(numbersList[5]),
          //     _labelText(numbersList[4]),
          //     _labelText(numbersList[2]),
          //   ],
          // ),
        ],
      ),
    );
  }

  String _houseResult(year, day) {
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  void _calculateMahaBote(DateTime picked) {
    mmYear = picked.year - 638;
    if (picked.month == 4) {
      isCheckBoxShow = true;
      if (isAfterMMNewYear) mmYear = picked.year - 637;
    } else {
      isCheckBoxShow = false;
    }
    modVal = mmYear % 7;
    selectedDate = picked;
    selected = true;
    houseName = _houseResult(mmYear, picked.weekday);

    // numbersList = [3, 6, 2, 5, 1, 4, 0]; // mod 1
    // numbersList = [4, 0, 3, 6, 2, 5, 1]; // mod 2
    // numbersList = [5, 1, 4, 0, 3, 6, 2]; // mod 3
    // numbersList = [6, 2, 5, 1, 4, 0, 3]; // mod 4
    // numbersList = [0, 3, 6, 2, 5, 1, 4]; // mod 5
    // numbersList = [1, 4, 0, 3, 6, 2, 5]; // mod 6
    // numbersList = [2, 5, 1, 4, 0, 3, 6]; // mod 7

    print("modVal: $modVal");

    List<String> mainList = ["1", "4", "0", "3", "6", "2", "5"];
    numbersList = [];
    numbersList = mainList;

    if (modVal != 6) {
      int lastValue = modVal - 1; // 0
      int lastIndex = 0;

      lastIndex = numbersList.indexOf(lastValue.toString());
      var range = numbersList.getRange(0, lastIndex + 1);
      List<String> removeList = [];
      for (var item in range) {
        removeList.add(item);
      }
      print("removeList: $removeList"); // 1, 4, 0
      numbersList.removeRange(0, lastIndex + 1); // 3, 6, 2, 5
      numbersList.addAll(removeList); // 3, 6, 2, 5, 1, 4, 0
    }
    print("numbersList: $numbersList");
  }
}
