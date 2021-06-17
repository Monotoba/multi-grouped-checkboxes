import 'package:flutter/material.dart';
import 'checkbox_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;

  final checkboxes = [
    CheckboxModel(title: 'Test 1', value: false),
    CheckboxModel(title: 'Test 2', value: false),
    CheckboxModel(title: 'Toggle Group', value: false),
    CheckboxModel(title: 'Test 3', value: false, shouldToggle: false),
    CheckboxModel(title: 'Test 4', value: false, shouldToggle: false),
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
    TextStyle style2 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    List<Widget> checkboxModels = buildCheckboxes(checkboxes);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multi-Checkbox Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Multi-Checkbox Demo', style: style)),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    checkboxModels[2],
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Group 1", style: style2),
                            ),
                          ),
                          checkboxModels[0],
                          checkboxModels[1],
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("Group 2", style: style2),
                            ),
                          ),
                          checkboxModels[3],
                          checkboxModels[4],
                        ],
                      ),
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

  List<Widget> buildCheckboxes(List<CheckboxModel> data) {
    print('data: $data');
    return data.map((e) => buildSingleCheckbox(e)).toList();
  }

  Widget buildSingleCheckbox(CheckboxModel model) {
    TextStyle style = model.shouldToggle
        ? TextStyle(color: Colors.black)
        : TextStyle(color: Colors.grey);

    return ListTile(
      title: Text(
        model.title,
        style: style,
      ),
      leading: Checkbox(
        value: model.value,
        onChanged: (_) {
          setState(
            () {
              model.toggle();
              swapEnabledGroup(checkboxes[2].value);
            },
          );
        },
      ),
      onTap: () {
        setState(
          () {
            swapEnabledGroup(checkboxes[2].value);
            model.toggle();
          },
        );
      },
    );
  }

  void swapEnabledGroup(bool enableGroup1) {
    if (enableGroup1) {
      checkboxes[0].enable(false);
      checkboxes[1].enable(false);
      checkboxes[3].enable(true);
      checkboxes[4].enable(true);
    } else {
      checkboxes[0].enable(true);
      checkboxes[1].enable(true);
      checkboxes[3].enable(false);
      checkboxes[4].enable(false);
    }
  }
}
