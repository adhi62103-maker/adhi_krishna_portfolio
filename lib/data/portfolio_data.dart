class Project {
  final String title;
  final String description;
  final String? link;
  final List<String> tools;

  const Project({
    required this.title,
    required this.description,
    this.link,
    this.tools = const [],
  });
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final List<String> points;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.points,
  });
}

class Education {
  final String institution;
  final String degree;
  final String duration;

  const Education({
    required this.institution,
    required this.degree,
    required this.duration,
  });
}

class Service {
  final String title;
  final String description;
  final String iconName; // We'll map this String to an IconData in UI

  const Service({
    required this.title,
    required this.description,
    required this.iconName,
  });
}

class PortfolioData {
  static const String name = "Adhi Krishna S";
  static const String title = "Flutter Developer";
  static const String aboutPoints =
      "Motivated Flutter Developer with hands-on experience in building mobile applications using Flutter and Dart. "
      "Currently learning and implementing state management concepts such as Provider to understand efficient UI updates and scalable application architecture. "
      "Experienced in creating responsive user interfaces, managing application state, and structuring projects using clean code practices. "
      "Passionate about mobile app development, continuous learning, and contributing to real-world Flutter projects while improving problem-solving skills.";

  static const List<String> skills = [
    "Flutter",
    "Dart",
    "Provider",
    "Firebase Auth",
    "Cloud Firestore",
    "Hive",
    "Material Design",
    "Git & GitHub",
    "Responsive UI",
  ];

  static const List<Service> services = [
    Service(
      title: "Mobile App Development",
      description:
          "Building cross-platform mobile applications for Android and iOS using Flutter with clean architecture.",
      iconName: "mobile",
    ),
    Service(
      title: "UI/UX Implementation",
      description:
          "Translating design mockups into responsive, pixel-perfect, and interactive Flutter widgets.",
      iconName: "brush",
    ),
    Service(
      title: "State Management",
      description:
          "Efficiently managing app state using Provider and other solutions for scalable performance.",
      iconName: "layers",
    ),
    Service(
      title: "Firebase Integration",
      description:
          "Implementing authentication, cloud database, and local storage solutions like Hive.",
      iconName: "cloud",
    ),
  ];

  static const List<Experience> experience = [
    Experience(
      company: "Acadeno Technologies Private Limited",
      role: "Flutter Developer - Intern",
      duration: "October 2025 - Present",
      points: [
        "Develop and build mobile applications using Flutter and Dart with a focus on clean, readable, and maintainable code.",
        "Learn, implement, and manage application state using Provider to ensure efficient UI updates and better app performance.",
        "Design responsive and user-friendly UI components following Flutter best practices and structured project architecture.",
        "Used GitHub for version control and collaborative development.",
      ],
    ),
  ];

  static const List<Education> education = [
    Education(
      institution: "Indira Gandhi National Open University",
      degree: "Bachelor of Computer Applications",
      duration: "2024 - Present",
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: "WhatsApp UI Clone",
      description:
          "Developed a WhatsApp-inspired UI application using Flutter with multiple screens including Chats, Calls, and Communities. Designed clean, user-friendly interfaces using Material widgets and implemented responsive layouts for consistent appearance across devices.",
      link: "https://github.com/adhi62103-maker/whatsapp_ui",
      tools: ["Flutter", "UI/UX", "Material Design"],
    ),
    Project(
      title: "Registration App",
      description:
          "Developed a full authentication system using Flutter and Firebase Authentication. Integrated Firebase Authentication for secure email & password login. Stored and retrieved user profile data using Cloud Firestore and implemented form validation.",
      link:
          "https://github.com/adhi62103-maker/registration_app_flutter_firebase",
      tools: ["Flutter", "Firebase Auth", "Firestore"],
    ),
    Project(
      title: "Online Store (MVC)",
      description:
          "Implemented e-commerce functionality using MVC architecture. Built cart and wishlist controllers using ChangeNotifier. implemented theme controller to switch between light and dark modes using Provider.",
      link:
          "https://github.com/adhi62103-maker/mvc_e_commerce_cart_multiprovider",
      tools: ["Flutter", "Provider", "MVC Pattern"],
    ),
    Project(
      title: "Note App with Hive",
      description:
          "Developed a notes application using Flutter and Dart. Implemented local data storage using Hive for offline access. Built CRUD functionality (Create, Read, Update, Delete) and managed application state using StatefulWidget.",
      link: "https://github.com/adhi62103-maker/note_app_using_simple_hive",
      tools: ["Flutter", "Hive", "Local Storage"],
    ),
    Project(
      title: "Netflix Clone UI",
      description:
          "Developed a Netflix-inspired mobile application UI focusing on modern OTT-style design. Implemented multiple content rows such as 'Trending' and 'Popular' using reusable UI components and specialized card widgets.",
      link: "https://github.com/adhi62103-maker/netflix_clone",
      tools: ["Flutter", "Responsive UI", "Animation"],
    ),
    Project(
      title: "Quiz App",
      description:
          "Built a quiz application with multiple screens and responsive layouts. Applied Flutter navigation and basic state handling to manage screen transitions and UI updates. Customized themes and typography.",
      link: "https://github.com/adhi62103-maker/QuizeTime",
      tools: ["Flutter", "State Management"],
    ),
  ];

  // Contact Links
  static const String email = "adhi62103@gmail.com";
  static const String linkedin =
      "https://www.linkedin.com/in/adhi-krishna-b9750638a/";
  static const String github = "https://github.com/adhi62103-maker";
  static const String phone = "+91 7907748057";
  static const String location = "Kozhikode, Kerala, India";

  // Placeholder for resume URL - user would need to host it somewhere or put in assets
  static const String resumeLink = "assets/docs/resume.pdf";
  static const String atsResumeLink = "assets/docs/ats_resume.pdf";
}
