import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ParcelasCalculator(),
  ));
}

class ParcelasCalculator extends StatefulWidget {
  @override
  _ParcelasCalculatorState createState() => _ParcelasCalculatorState();
}

class _ParcelasCalculatorState extends State<ParcelasCalculator> {
  DateTime? dataCompra;
  int numParcelas = 1;
  List<DateTime?> datasParcelas = List.filled(10, null);

  String calcularPrazo() {
    if (dataCompra == null || datasParcelas.any((d) => d == null)) return '';

    List<int> intervalos = [];
    DateTime? primeiraData = dataCompra;

    for (int i = 0; i < numParcelas; i++) {
      if (datasParcelas[i] != null && primeiraData != null) {
        int diferenca = datasParcelas[i]!.difference(dataCompra!).inDays;
        intervalos.add(diferenca);
      }
    }
    return intervalos.isNotEmpty ? 'O prazo escolhido pelo cliente foi (${intervalos.join('/')})' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qual foi o prazo escolhido?')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Quando a compra foi feita?'),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                    ),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dataCompra = pickedDate;
                        });
                      }
                    },
                    child: Text(dataCompra == null
                        ? 'Selecionar Data'
                        : DateFormat('dd/MM/yyyy').format(dataCompra!)),
                  ),
                  SizedBox(height: 20),
                  Text('Em quantas parcelas a compra foi feita?'),
                  SizedBox(height: 8),
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: DropdownButton<int>(
                      value: numParcelas,
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      underline: SizedBox(),
                      items: List.generate(10, (index) => index + 1)
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text('$value vezes'),
                      ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          numParcelas = newValue!;
                          datasParcelas = List.filled(numParcelas, null);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  for (int i = 0; i < numParcelas; i++) ...[
                    Text('Que dia a ${i + 1}ª parcela foi paga?'),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            datasParcelas[i] = pickedDate;
                          });
                        }
                      },
                      child: Text(datasParcelas[i] == null
                          ? 'Selecionar Data'
                          : DateFormat('dd/MM/yyyy').format(datasParcelas[i]!)),
                    ),
                    SizedBox(height: 10),
                  ],
                  SizedBox(height: 20),
                  if (dataCompra != null && datasParcelas.any((date) => date != null)) ...[
                    Text(
                      calcularPrazo(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
