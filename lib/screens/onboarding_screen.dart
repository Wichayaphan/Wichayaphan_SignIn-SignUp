// flutter pub add google_fonts
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/component/my_textbutton.dart';
import 'package:onboarding_screen/sign_in/sign_in.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3ac3cb), Color(0xFFf85187)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue.withOpacity(0.5),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 20), 
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: demo_data.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemBuilder: (context,index) => OnBoardingWidget(
                      image: demo_data[index].image,
                      title: demo_data[index].title,
                      description: 
                        demo_data[index].description,
                    )
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(
                      demo_data.length, 
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      )),
                    const Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageIndex != demo_data.length - 1) {
                            _pageController.nextPage(
                                duration: const Duration(
                                  microseconds: 300,
                                ),
                                curve: Curves.ease);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.pink),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key, required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 16 : 4, 
      width: 4, 
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white, 
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image, 
    required this.title, 
    required this.description,
  });
}

final List<OnBoard> demo_data = [
  OnBoard(
    image: "assets/images/ArcticFox.jpg",
    title: "Arctic Fox (Mammal)", 
    description: "These small foxes have thick fur coat and their long fluffy tails act like a blanket, keeping the fox warm when it wraps the tail around its body to sleep."),
  OnBoard(
    image: "assets/images/Koala.jpg", 
    title: "Koala (Mammal)", 
    description: "The koala is an iconic Australian animal. Often called the koala “bear,” this tree-climbing animal is a marsupial—a mammal with a pouch for the development of offspring."),
  OnBoard(
    image: "assets/images/Platypus.jpg", 
    title: "Platypus (Mammal)", 
    description: "Platypuses are small, shy animals. They have a flattened head and body to help them glide through the water.\n Their fur, dark brown on top and tan on their bellies, is thick and repels water to keep them warm and dry even after hours of swimming."),
  OnBoard(
    image: "assets/images/Flamingo.jpg", 
    title: "Flamingo (Bird)", 
    description: "Flamingos are famous for their bright pink feathers, stilt-like legs, and S-shaped neck."),
  OnBoard(
    image: "assets/images/MobulaRay.jpg", 
    title: "Mobula Ray (Fish)", 
    description: "Launching itself six feet above the ocean’s surface, a fish called a mobula ray does a flip before plunging back into the water with a splash."),
];

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key, 
    required this.image, 
    required this.title, 
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const Spacer(),
        Image.asset(
          image, 
          height: 280,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color:Colors.white
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.white
          ),
        ),
        const Spacer(),
        const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Don't have time?", style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                      ),
                    ),
                    const MyLoginButton(labelText: "Skip now", pageRoute: "login",),
                  ],
                ),
              ),
              const Spacer(),
      ],
    );
  }
}