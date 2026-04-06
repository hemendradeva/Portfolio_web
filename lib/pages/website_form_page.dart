import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class WebsiteFormPage extends StatefulWidget {
  const WebsiteFormPage({super.key});

  @override
  State<WebsiteFormPage> createState() => _WebsiteFormPageState();
}

class _WebsiteFormPageState extends State<WebsiteFormPage> {
  /// 🔹 Controllers
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final designationCtrl = TextEditingController();
  final shortDescCtrl = TextEditingController();
  final linkedinCtrl = TextEditingController();
  final githubCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  final skillCtrl = TextEditingController();
  final projectNameCtrl = TextEditingController();
  final projectDescCtrl = TextEditingController();

  /// 🔹 Data
  final List<String> skills = [];
  final List<Map<String, String>> projects = [];

  String? resumePath;
  String? imagePath;

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Create Your Website 🚀"),
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.all(24),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 BASIC INFO
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        _field(nameCtrl, "Full Name", isMobile),
                        _field(emailCtrl, "Email", isMobile),
                        _field(phoneCtrl, "Phone", isMobile),
                        _field(designationCtrl, "Company / Business", isMobile),
                        _field(shortDescCtrl, "Short Description", isMobile),
                        _field(linkedinCtrl, "LinkedIn URL", isMobile),
                        _field(githubCtrl, "GitHub URL", isMobile),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 SKILLS SECTION
                    _buildSkillSection(),

                    const SizedBox(height: 20),

                    /// 🔹 PROJECT SECTION
                    _buildProjectSection(),

                    const SizedBox(height: 20),

                    /// 🔹 FILE UPLOAD
                    _buildFileButtons(),

                    const SizedBox(height: 20),

                    /// 🔹 ABOUT
                    _field(aboutCtrl, "About You", true, maxLines: 5),

                    const SizedBox(height: 20),

                    /// 🔹 SAVE BUTTON
                    Center(
                      child: ElevatedButton(
                        onPressed: saveData,
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================= UI COMPONENTS =================

  Widget _buildSkillSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Skills", style: TextStyle(color: Colors.white)),

        Row(
          children: [
            Expanded(child: _field(skillCtrl, "Add Skill", true)),
            IconButton(
              onPressed: addSkill,
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        Wrap(
          spacing: 8,
          children: skills.map((e) => Chip(label: Text(e))).toList(),
        ),
      ],
    );
  }

  Widget _buildProjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Projects", style: TextStyle(color: Colors.white)),

        _field(projectNameCtrl, "Project Name", true),
        _field(projectDescCtrl, "Project Description", true),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: addProject,
          child: const Text("Add Project"),
        ),

        const SizedBox(height: 20),

        ...projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project["name"] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        project["desc"] ?? "",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => projects.removeAt(index));
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFileButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              resumePath == null ? "Upload Resume" : "Resume Selected",
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              imagePath == null ? "Upload Photo" : "Image Selected",
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(
      TextEditingController controller,
      String label,
      bool isMobile, {
        int maxLines = 1,
      }) {
    return SizedBox(
      width: isMobile ? double.infinity : 450,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white.withOpacity(0.05),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    );
  }

  /// ================= LOGIC =================

  void addSkill() {
    if (skillCtrl.text.trim().isEmpty) return;

    setState(() {
      skills.add(skillCtrl.text.trim());
      skillCtrl.clear();
    });
  }

  void addProject() {
    if (projectNameCtrl.text.isEmpty || projectDescCtrl.text.isEmpty) {
      _showSnack("Enter project details");
      return;
    }

    setState(() {
      projects.add({
        "name": projectNameCtrl.text,
        "desc": projectDescCtrl.text,
      });

      projectNameCtrl.clear();
      projectDescCtrl.clear();
    });
  }

  bool validate() {
    return nameCtrl.text.isNotEmpty &&
        emailCtrl.text.contains("@") &&
        phoneCtrl.text.length >= 10 &&
        designationCtrl.text.isNotEmpty;
  }

  void saveData() {
    if (!validate()) {
      _showSnack("Please fill required fields");
      return;
    }

    final data = {
      "name": nameCtrl.text,
      "designation": designationCtrl.text,
      "shortDesc": shortDescCtrl.text,
      "email": emailCtrl.text,
      "phone": phoneCtrl.text,
      "linkedin": linkedinCtrl.text,
      "github": githubCtrl.text,
      "skills": skills,
      "projects": projects,
      "resume": resumePath,
      "image": imagePath,
      "about": aboutCtrl.text,
    };

    final list = storage.read("forms") ?? [];
    list.add(data);
    storage.write("forms", list);

    _showSnack("Saved Successfully ✅");
print("object");
    log("Data==${jsonEncode(storage.read("forms")) }");
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}