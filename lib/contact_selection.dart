import 'package:flutter/material.dart';
import 'package:portfolio/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.contact,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          children: [
            TextButton(
              onPressed: () => launchUrl(Uri.parse('mailto:${Strings.mailId}')),
              child: const Text(Strings.mailId),
            ),
            TextButton(
              onPressed: () => launchUrl(Uri.parse(Strings.gitHubURL)),
              child: const Text(Strings.gitHub),
            ),
            TextButton(
              onPressed: () => launchUrl(Uri.parse(Strings.linkedInURL)),
              child: const Text(Strings.linkedIn),
            ),
          ],
        )
      ],
    );
  }
}
