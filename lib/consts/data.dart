import 'package:awesome_portfolio/models/app_model.dart';
import 'package:awesome_portfolio/models/color_model.dart';
import 'package:awesome_portfolio/models/device_model.dart';
import 'package:awesome_portfolio/screen/miniProjects/education/education.dart';
import 'package:awesome_portfolio/screen/miniProjects/experience/experience.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/experience_model.dart';
import '../models/skill_model.dart';
import '../screen/miniProjects/about/about.dart';
import '../screen/miniProjects/skills/skills.dart';

const double baseHeight = 790;
const double baseWidth = 1440;

List<DeviceModel> devices = [
  DeviceModel(
    device: Devices.android.onePlus8Pro,
    icon: Icons.android,
  ),
  DeviceModel(
    device: Devices.ios.iPhone13,
    icon: Icons.apple,
  ),
  DeviceModel(
    device: Devices.ios.iPad,
    icon: Icons.tablet,
  ),
];

List<ColorModel> colorPalette = [
  ColorModel(
    svgPath: "assets/images/cloudRed.svg",
    color: Colors.yellowAccent,
    gradient: const LinearGradient(
      begin: Alignment.bottomLeft,
      // transform: Grad,
      end: Alignment.topRight,
      colors: [Colors.yellowAccent, Colors.deepOrange],
    ),
  ),
  ColorModel(
    svgPath: "assets/images/cloudyBlue.svg",
    color: Colors.blue,
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      colors: [Colors.blue, Colors.black45],
    ),
  ),
  ColorModel(
      svgPath: "assets/images/cloudyBlue.svg",
      color: const Color(0xff00d6ca),
      gradient: const LinearGradient(
        colors: [Color(0xff00ebd5), Color(0xff293474)],
        stops: [0, 1],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      )),
  ColorModel(
    svgPath: "assets/images/cloudyBlue.svg",
    color: const Color(0xff123cd1),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(-0.31, 0.95),
      colors: [Color(0xFF1042F4), Color(0x00203EA6)],
    ),
  ),
  ColorModel(
    svgPath: "assets/images/cloudyBlue.svg",
    color: Colors.purple,
    gradient: const LinearGradient(
      colors: [Color(0xffc95edb), Colors.black12],
      stops: [0, 1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  ColorModel(
    svgPath: "assets/images/cloudyBlue.svg",
    color: const Color(0xfff35a32),
    gradient: const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Colors.indigo, Colors.deepOrange], // Adjust colors as needed
    ),
  ),
];

List<AppModel> apps = [
  AppModel(
      title: "About",
      color: Colors.white,
      icon: Icons.person,
      screen: const AboutMe()),
  AppModel(
      title: "Skills",
      color: Colors.white,
      icon: Icons.ac_unit_rounded,
      screen: const Skills()),
  AppModel(
    title: "Facebook",
    assetPath: "assets/icons/facebook.png",
    color: Colors.white,
    link: facebook,
  ),
  AppModel(
    title: "LinkedIn",
    assetPath: "assets/icons/in.png",
    color: Colors.white,
    link: linkedIn,
  ),
  AppModel(
    title: "Twitter/X",
    assetPath: "assets/icons/twitter.png",
    color: Colors.white,
    link: twitter,
  ),
  AppModel(
    title: "WhatApp",
    assetPath: "assets/icons/whatsapp.png",
    color: const Color.fromARGB(255, 238, 235, 235),
    link: whatsapp,
  ),
  AppModel(
      title: "Experience",
      color: Colors.white,
      icon: FontAwesomeIcons.idBadge,
      screen: const Experience()),
  AppModel(
    title: "Education",
    color: Colors.white,
    icon: FontAwesomeIcons.edge,
    screen: const Education(),
  ),
  AppModel(
    title: "Github",
    assetPath: "assets/icons/github.png",
    color: Colors.white,
    link: github,
  ),
  AppModel(
    title: "Apps",
    assetPath: "assets/icons/apps.png",
    color: Colors.white,
    // link: playApps,
  ),
];

final List<JobExperience> education = [
  JobExperience(
    color: Colors.red,
    location: "cairo, Egypt",
    title: "Bachelor's degree",
    company: "Bachelor's degree in administrative information and systems",
    startDate: '2018',
    endDate: '2022',
    bulletPoints: [
      " Performing military service",
    ],
  ),
  JobExperience(
    color: Colors.blue,
    location: "cairo, Egypt",
    title: 'Diploma in   Flutter Develpoment',
    company: 'Eraa Soft',
    startDate: 'jan 2024',
    endDate: 'June 2024',
    bulletPoints: [
      'Nine months of continuous filming',
    ],
  ),
];

final List<JobExperience> jobExperiences = [
  JobExperience(
    color: Colors.redAccent,
    location: "Remote",
    title: 'Build Password Manager  App',
    company: 'Treaning',
    startDate: 'June 2022',
    endDate: 'July 2022',
    bulletPoints: [
      "Secure Password Storage: Allows users to save passwords in encrypted form to ensure information privacy.",
      "Generate strong passwords: Provides a tool to generate random and secure passwords, which helps enhance security.",
      "Easy Access: Provides a user-friendly interface that makes it easier for users to access their passwords quickly.",
      "Sync across devices: Supports sync between different devices to ensure that lyrics",
      "Some of the techniques used theming ,localization ,Bloc ,Responsive ,Firebase Storage ,FireBase Fire Store,PhoneAuth,",
    ],
  ),
  JobExperience(
    color: Colors.blue,
    location: "cairo, Egypt",
    title: 'Build Speech To Text  App',
    company: 'Treaning',
    startDate: 'July 2022',
    endDate: 'Present',
    bulletPoints: [
      "This application allows users to convert audio to text easily and quickly. Through a simple user interface, users can:",
      "Record audio directly from within the app.",
      "Download audio files from the device to convert them to text.",
      "Easily share converted text with others.",
      "Log in using Google or email-password..",
      "Use simple animation..",
      "Some of the techniques used theming ,localization ,Bloc ,Responsive ,Firebase Storage ,FireBase Fire Store,Convert Audio To Mb3,LottieFiles ,SharedPreference ,Doi,pdf | Dart package ",
    ],
  ),
  // Add more job experiences here...

  // JobExperience(
  //   color: Colors.orangeAccent,
  //   location: "Remote",
  //   title: 'App Architecture Intern',
  //   company: 'Habeato',
  //   startDate: 'Oct 2021',
  //   endDate: 'Nov 2021',
  //   bulletPoints: [
  //     "Collaborated with founders to develop a HealthifyMe clone, demonstrating strong teamwork and app development skills.",
  //     "Engineered complex animations to enhance user experience and app visual appeal.",
  //     "Played an active role in system design processes, contributing to efficient and scalable app architecture.",
  //   ],
  // ),
  // JobExperience(
  //   color: Colors.greenAccent,
  //   location: "Remote",
  //   title: 'App Developer',
  //   company: 'Kylo Apps',
  //   startDate: 'Sep 2021',
  //   endDate: 'Oct 2021',
  //   bulletPoints: [
  //     "Collaborated as a team member in developing a cryptocurrency wallet, akin to Trust Wallet, showcasing strong teamwork and blockchain app development expertise.",
  //     "Proficiently integrated REST APIs into the application, enhancing its functionality and connectivity with external services."
  //   ],
  // ),
  // JobExperience(
  //   color: Colors.black,
  //   location: "Remote",
  //   title: 'Flutter App Intern',
  //   company: 'Cogent Web Services',
  //   startDate: 'Dec 2020',
  //   endDate: 'June 2021',
  //   bulletPoints: [
  //     "Independently developed a Life Simulator game using Flutter from scratch, applying state-of-the-art state management practices to ensure a top-tier user experience.",
  //     "Leveraged Flutter's robust features to craft an immersive and captivating gameplay experience, demonstrating proficiency in app development.",
  //     "Successfully implemented Google Ads, in-app purchases, and Hive database for efficient user data storage and monetization strategies.",
  //     "Generated creative ideas for client pitches, fostering creativity and ensuring the game's entertainment value and thought-provoking nature.",
  //     "Published the game on the Play Store, achieving over 5,000 downloads, showcasing the ability to deliver a popular and engaging mobile application.",
  //   ],
  // ),
];

const String facebook =
    "https://www.facebook.com/profile.php?id=100085093500634";
const String linkedIn = "https://www.linkedin.com/in/ahmed-saaid-1656021b0/";
const String github = "https://github.com/ahmedmsaaid";
const String twitter = "https://x.com/AhMed51692444";
const String whatsapp = "https://wa.link/2xivst";
const String resumeLink =
    "https://drive.google.com/file/d/1LO3Km6fFkJVW92MNXRLSYl--E9YlTHJd/view";
const String email = "ahmedsaaid908@gmail.com";
String introduction =
    "“Welcome to my portfolio website, this website is highly inspired (almost copied) by Pawan Kumar.\n\nThat I'm a Flutter  developer with experience developing impressive, ready-to-use apps. I have completed two full-fledged applications, working to provide outstanding user experiences by designing easy-to-use interfaces and smooth performance. I always strive to learn and develop, looking for new opportunities to improve my skills and build applications that meet users' needs.";
const String playApps =
    "https://play.google.com/store/apps/developer?id=AppyMonk";

List<SkillsModel> skills = [
  SkillsModel(skillName: "Flutter", colorS: Colors.blue, iconPath: "random"),
  SkillsModel(
    skillName: "Firebase",
    colorS: Colors.yellow,
  ),
  SkillsModel(
    skillName: "Github",
    colorS: Colors.yellow,
  ),
  SkillsModel(
    skillName: "Dart",
    colorS: Colors.blue,
  ),
  SkillsModel(
    skillName: "Bloc",
    colorS: Colors.orange,
  ),
  SkillsModel(
    skillName: "Localization",
    colorS: Colors.orange,
  ),
  SkillsModel(
    skillName: "OOp",
    colorS: Colors.orange,
  ),
  SkillsModel(
    skillName: "Responcive",
    colorS: Colors.orange,
  ),
  SkillsModel(
    skillName: "Dio",
    colorS: Colors.yellow,
  ),
];

List<SkillsModel> languages = [
  SkillsModel(skillName: "Arabic", colorS: Colors.orange),
  SkillsModel(skillName: "English", colorS: Colors.blueGrey),
];
