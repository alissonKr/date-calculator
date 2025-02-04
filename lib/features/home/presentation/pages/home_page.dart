// Página inicial (home_page.dart)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/date_selector.dart';
import '../../logic/dropdown_parser.dart';

class CalculadoraPrazosHomePage extends StatefulWidget {
  const CalculadoraPrazosHomePage({Key? key}) : super(key: key);

  @override
  _CalculadoraPrazosHomePageState createState() =>
      _CalculadoraPrazosHomePageState();
}

class _CalculadoraPrazosHomePageState extends State<CalculadoraPrazosHomePage> {
  DateTime selectedDate = DateTime.now();
  String selectedPrazo = '14/28/42';
  List<int> intervals = [14, 28, 42];

  // Lista completa de prazos fornecidos
  final List<String> prazos = [
    '28', '30', '7', '10', '14', '21', '25', '28/56', '20/40', '30/60',
    '28/42', '15/30', '20/35', '25/50', '25/45', '14/28', '30/35', '14/21', '7/14', '10/20', '28/35',
    '21/28', '15/45', '25/35', '7/28', '25/40/55', '25/35/50', '20/40/60', '30/60/90', '28/56/84',
    '15/30/45', '25/50/75', '30/45/60', '25/45/65', '20/30/40', '21/35/49', '25/35/45', '28/35/42',
    '21/28/35', '14/21/28', '10/20/30', '7/14/21', '14/28/42', '28/42/56', '30/40/50', '30/50/70',
    '17/37/57', '28/56/84', '28/42/56/70', '20/40/60/80', '15/30/45/60', '30/60/90/120', '21/35/49/63', '20/35/50/65',
    '20/30/40/50', '30/40/50/60', '25/40/55/70', '30/45/60/75', '14/28/42/56', '25/35/45/55', '21/42/63/84',
    '28/35/42/49', '7/14/21/28', '21/28/35/42', '28/56/84/112', '10/20/30/40', '14/21/28/35',
    '15/25/35/45', '20/30/40/50/60', '30/45/60/75/90', '28/42/56/70/84', '25/35/45/55/65',
    '15/30/45/60/75', '21/28/35/42/49', '20/40/60/80/100', '7/14/21/28/35', '20/35/50/65/80', '28/35/42/49/56',
    '14/28/42/56/70', '10/20/30/40/50', '30/40/50/60/70', '14/21/28/35/42', '25/40/55/70/85', '10/20/30/40/50/60',
    '15/25/35/45/55/65', '15/30/45/60/75/90', '25/35/45/55/65/75', '14/28/42/56/70/84', '21/28/35/42/49/56',
    '7/14/21/28/35/42', '28/35/42/49/56/63', '14/21/28/35/42/49', '20/40/60/80/100/120', '28/35/42/49/56/63/70',
    '7/14/21/28/35/42/49', '14/21/28/35/42/49/56', '15/30/45/60/75/90/15/120', '21/28/35/42/49/56/63/70',
    '7/14/21/28/35/42/49/56', '14/21/28/35/42/49/56/63/70', '7/14/21/28/35/42/49/56/63/70',
  ];

  List<Widget> buildBoletosDates(DateTime startDate, List<int> intervals) {
    return intervals.map((interval) {
      DateTime boletoDate = startDate.add(Duration(days: interval));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // Adiciona espaço no topo do primeiro item
            child: Text(
              DateFormat('dd/MM/yyyy').format(boletoDate), // Formata a data corretamente
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(color: Colors.grey), // Adiciona linha sublinhada
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue, // Cor inicial do gradiente
              Colors.tealAccent, // Cor final do gradiente
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: Text(
                'Descubra qual dia vai cair seu boleto!',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Anton', // Nome da família de fonte
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0), // Define a posição da sombra
                      blurRadius: 3.0, // Define o quão desfocada será a sombra
                      color: Colors.black.withOpacity(0.5), // Cor da sombra com opacidade
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selecione a data inicial:',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DateSelector(
                          selectedDate: selectedDate,
                          onDatePicked: (pickedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Data alterada para ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Selecione o prazo:',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedPrazo,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPrazo = newValue!;
                              intervals = parseIntervals(selectedPrazo);
                              if (selectedPrazo.isEmpty || intervals.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Por favor, selecione um prazo válido!')),
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Prazo alterado para $selectedPrazo'),
                                ),
                              );
                            });
                          },
                          items: prazos.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Text(
                      'Datas dos boletos:',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adiciona espaçamento lateral
                          child: ListView(
                            shrinkWrap: true,
                            children: buildBoletosDates(selectedDate, intervals), // Garante exibição correta das datas
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
