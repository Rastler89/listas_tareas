import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listas_tareas/app/view/TaskList/TaskListPage.dart';
import 'package:listas_tareas/app/view/components/TitlePerson.dart';
import 'package:listas_tareas/app/view/components/shape.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Row (
              children: [
                Shape(),
              ],
            ),
            const SizedBox(height:79),
            Image.asset(
                'assets/image/onboarding-image.png',
                width: 180,
                height: 168
            ),
            const SizedBox(height:99),
            const TitlePerson('Lista de Tareas'),
            const SizedBox(height:21),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const TaskListPage();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal:32),
                child: Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                  textAlign: TextAlign.center,
                ),
              ),
            )

          ],
        ),
    );
  }

}