import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  final Key widgetKey;
  const ProjectsSection({super.key, required this.widgetKey});
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> projects = [
      {
        'title': 'RashanPani: Delivery in Bokaro(E-Commerce App)',
        'description':'RashanPani, the premier grocery delivery app dedicated to serving the residents of Bokaro. This App is to bring convenience and quality right to your doorstep, saving you time and effort with our fast and reliable service. With RashanPani, you can say goodbye to the hassle of traditional grocery shopping and enjoy a seamless shopping experience from the comfort of your home.',
        'link': 'https://play.google.com/store/apps/details?id=com.onlinerashanpani.app'
      },
      {
        'title': 'Doctor Appointment App(Patient App)',
        'description':
            'Get rid of the hassle of standing in the queue just for consultation, Dr. Anjani Kumar Sharma app is going to help you to get medical care and assistance directly within minutes from the Doctor.Features include real-time availability, secure bookings, in-app reviews, and smart filtering for amenities, price, and ratings.',
        'link': 'https://play.google.com/store/apps/details?id=com.anjanisharma'
      },
      {
        'title': 'Doctor Appointment System App(Doctor App)',
        'description':
            'Doctor Admin App is a doctor appointment booking app that display live Queue status on large screen to both patients and doctor. App has been designed to assist doctors to get rid of manual management of long patients queue at clinics.',
        'link': 'https://play.google.com/store/apps/details?id=com.emizend.dev'
      },
      {
        'title': 'E-Commerce B2B model(User App)',
        'description': 'This App basically deals on B2B model. It is a service provider based company which deals in moving goods from vendors(distributors) to client(shopkeepers)',
        'link': 'https://play.google.com/store/apps/details?id=com.richmart.user'
      },
      {
        'title': 'E-Commerce B2B model(Vendor App)',
        'description': 'This App basically deals on B2B model. It is a service provider based company which deals in moving goods from vendors(distributors) to client(shopkeepers)',
        'link': 'https://play.google.com/store/apps/details?id=com.richamart_vendor',
      },
      {
        'title': 'Ananda SelfCare(User Android)',
        'description':
            'Stay connected and in control with Ananda SelfCare, the official app for managing your Ananda broadband internet service. Designed for customers who want more flexibility and convenience, this selfcare app allows you to easily manage your broadband service, track your usage, pay bills, upgrade plans, and much more — all from your mobile device.',
        'link': 'https://play.google.com/store/apps/details?id=com.ananda.selfcare.mm'
      },
      {
        'title': 'Ananda Field Staff App(Admin)',
        'description':
            'Ananda Field Staff App is an internal-use application developed to support field personnel in managing day-to-day broadband service operations. It is used for handling customer service activations, ticket resolution, inventory transactions, and on-site workflow execution.',
        'link': 'https://play.google.com/store/apps/details?id=com.ananda.fieldapp.mm'
      },
      {
        'title': 'Ananda SelfCare(User Ios)',
        'description':
            'Stay connected and in control with Ananda SelfCare, the official app for managing your Ananda broadband internet service. Designed for customers who want more flexibility and convenience, this selfcare app allows you to easily manage your broadband service, track your usage, pay bills, upgrade plans, and much more — all from your mobile device.',
        'link': 'https://apps.apple.com/in/app/ananda-selfcare/id6747145787'
      },
      {
        'title': 'Ananda Field Staff App(Admin)',
        'description':
        'Ananda Field Staff App is an internal-use application developed to support field personnel in managing day-to-day broadband service operations. It is used for handling customer service activations, ticket resolution, inventory transactions, and on-site workflow execution.',
        'link': 'https://apps.apple.com/in/app/ananda-field-staff-app/id6747333201'

      },
    ];

    return Container(
      key: widgetKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Projects",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(
              projects.length,
              (index) => _ProjectCard(
                  index: index,
                  title: projects[index]['title'] ?? "",
                  description: projects[index]['description'] ?? "",
                  link: projects[index]['link'] ?? ""),
            ),
          )
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final int index;
  final String title;
  final String description;
  final String? link;
  const _ProjectCard({required this.index, required this.title, required this.description, this.link});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _scaleController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _scaleController.reverse();
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: widget.link != null ? () => launchUrl(Uri.parse(widget.link.toString())) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "View",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
