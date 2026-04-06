import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/strings.dart';

class ContactSection extends StatefulWidget {
  final Key contactKey;

  const ContactSection({super.key, required this.contactKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  int hoveredIndex = -1;
  final getStorage = GetStorage();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool isDark = false;

  final List<Map<String, dynamic>> contactItems = [
    {
      "title": Strings.mailId,
      "icon": Icons.email,
      "url": "mailto:${Strings.mailId}",
    },
    {
      "title": Strings.gitHub,
      "icon": Icons.code,
      "url": Strings.gitHubURL,
    },
    {
      "title": Strings.linkedIn,
      "icon": Icons.work,
      "url": Strings.linkedInURL,
    },
  ];

  @override
  void initState() {
    super.initState();
    printMessages();
  }

  void launchLink(String url) async {
    await launchUrl(Uri.parse(url));
  }

  void openWhatsApp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();
    // 🧾 Format message
    final text = '''
Hello ${Strings.name} How Are You 👋,
''';

    final url = "https://wa.me/919782755170?text=${Uri.encodeComponent(text)}";

    await launchUrl(Uri.parse(url));
  }

  void sendMessage() {
    if (nameController.text.isEmpty || messageController.text.isEmpty|| nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }
    final data = {
      "name": nameController.text,
      "email": emailController.text,
      "message": messageController.text,
      "time": DateTime.now().toString(),
    };

    List messages = getStorage.read("contacts") ?? [];
    messages.add(data);

    getStorage.write("contacts", messages);

    printMessages();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Message Sent Successfully ✅")),
    );

    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? Colors.blueGrey : Colors.blueGrey;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      key: widget.contactKey,
      padding: const EdgeInsets.all(30),
      // color: bgColor,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 Animated Heading
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText(
                "Get In Touch 👋",
                textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor),
                speed: const Duration(milliseconds: 80),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🎬 Lottie Animation
          Center(
            child: Lottie.network(
              "https://assets1.lottiefiles.com/packages/lf20_u25cckyh.json",
              height: 180,
            ),
          ),

          const SizedBox(height: 30),

          /// Contact Cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(contactItems.length, (index) {
              final item = contactItems[index];

              return MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index),
                onExit: (_) => setState(() => hoveredIndex = -1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: hoveredIndex == index
                          ? (Matrix4.identity()..scale(1.05))
                          : Matrix4.identity(),
                      width: 260,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF0F172A)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.15)
                              : Colors.white.withOpacity(0.4),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.4)
                                : Colors.grey.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () => launchLink(item["url"]),
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: item["title"]));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              item["icon"],
                              color: isDark ? Colors.blueAccent : Colors.blue,
                              size: 30,
                            ),
                            const SizedBox(height: 10),
                            Text(item["title"],
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 40),

          /// Contact Form
          TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name")),
          TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email")),
          TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: "Message")),

          const SizedBox(height: 20),

          Row(children: [
            ElevatedButton(
              onPressed: sendMessage,
              child: const Text("Send Message"),
            ),
            const SizedBox(width: 20),
            TextButton(
                onPressed: () => openWhatsApp(),
                child: Text(
                  "Whatsapp Chat",
                  style: TextStyle(color: Colors.blue),
                )),
          ],),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void printMessages() {
    final box = GetStorage();
    List messages = box.read("contacts") ?? [];

    for (var msg in messages) {
      print(msg);
    }
  }
}
