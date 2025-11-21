import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple
      ),
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();


  double? bmi;
  String  category='';
  String gender='Male';


  void calculateBMI(){
    double height=double.parse(heightController.text)/100;
    double weight=double.parse(weightController.text);

    setState(() {

      bmi=weight/(height*height);
      if(bmi!<18.5){
        category='underweight';
      }else if(bmi!>=18.5 && bmi!<24.9){
        category='Normal';

      }else if(bmi!>=25 && bmi! <29.9){
        category='Overweight';
      }else{
        category='Obese';
      }

    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text('BMI Calculator', style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF6A0DAD), Color(0XFF9B5986)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Enter Your Details',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              _buildGenderToggle(),
              SizedBox(height: 20,),
              _buildInputFields(
                controller: heightController,
                label: 'Height(cm)',
                icon: Icons.height,
              ),
              SizedBox(height: 20,),
              _buildInputFields(
                controller: weightController,
                label: 'Weight(kg)',
                icon: Icons.line_weight,
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: (){calculateBMI();},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20)
                    ),
                      elevation: 8
                  ),
                child:Text('Calculate BMI ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),) ,


              ),
              SizedBox(height: 30,),
              if(bmi !=null)
                _buildResultCard()
            ],
          ),
        )

    );
  }


  Widget _buildGenderToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton('Male', Icons.male, gender == 'Male'),
        SizedBox(width: 20,),
        _buildGenderButton('Female', Icons.female, gender == 'Female'),
      ],
    );
  }


  Widget _buildGenderButton(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
              BoxShadow(
                  color: Colors.black26, blurRadius: 5, offset: Offset(0, 5))
            ]
                : []
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.deepPurple : Colors.white,),
            SizedBox(width: 10,),
            Text(label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.deepPurple : Colors.white
              ),)
          ],
        ),
      ),
    );

  }
  Widget _buildInputFields(
      {
        required String label,
        required IconData icon,
        required TextEditingController controller,
      }
      ){
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(icon,color: Colors.white,),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),


          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purpleAccent),
              borderRadius: BorderRadius.circular(15)
          )

      ),
    );

  }
  Widget _buildResultCard(){
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      elevation: 10,
      child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your BMI :${bmi!.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)
            ),
            SizedBox(height: 10,),
            Text('Category: $category',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:bmi!<18.5? Colors.orange:
                  (bmi!<24.9? Colors.green:
                  (bmi!<29.9? Colors.orange:Colors.red))

              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Gender:$gender",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
              ),
            )
          ],
        ),
      ),
    );
  }
}

