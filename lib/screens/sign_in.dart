import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:joride_app/screens/login_screen.dart';
import 'sign_in.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isPassenger = true;
  String gender = "Female";

  static const Color yellow = Color(0xFFF4C430);
  static const Color background = Color(0xFFF5F3EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(width: 30),
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.language, color: yellow),
                ],
              ),

              const SizedBox(height: 30),

              // Driver / Passenger toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPassenger = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isPassenger ? Colors.transparent : yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Text("Driver"),
                          const SizedBox(width: 8),
                          if (!isPassenger)
                            const Icon(
                              Icons.check_circle,
                              size: 18,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPassenger = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isPassenger ? yellow : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Text("Passenger"),
                          const SizedBox(width: 8),
                          if (isPassenger)
                            const Icon(
                              Icons.check_circle,
                              size: 18,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text("First name"),
              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your first name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Last name"),
              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your last name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("select gender"),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = "Female";
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: gender == "Female"
                        ? const Color(0xFFF9F1D6)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: "Female",
                        groupValue: gender,
                        activeColor: yellow,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = "Male";
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: gender == "Male"
                        ? const Color(0xFFF9F1D6)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: "Male",
                        groupValue: gender,
                        activeColor: yellow,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      const Text("Male"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text("Birthday"),
              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: "DD   /   MM   /   YYYY",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
