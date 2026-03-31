class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final String logoAsset;
  final List<String> bullets;
  final List<String> techTags;

  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.logoAsset,
    required this.bullets,
    required this.techTags,
  });
}

class Project {
  final String title;
  final String description;
  final String category;
  final List<String> tech;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final String emoji;

  const Project({
    required this.title,
    required this.description,
    required this.category,
    required this.tech,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    required this.emoji,
  });
}

class TechSkill {
  final String name;
  final String logoAsset;
  final String category;
  final int level; // 1-5

  const TechSkill({
    required this.name,
    required this.logoAsset,
    required this.category,
    required this.level,
  });
}

class Certificate {
  final String title;
  final String issuer;
  final String description;
  final String certNo;
  final String emoji;

  const Certificate({
    required this.title,
    required this.issuer,
    required this.description,
    required this.certNo,
    required this.emoji,
  });
}

// ─── PORTFOLIO DATA ──────────────────────────────────────────────────────────

class PortfolioData {
  static const List<Experience> experiences = [
    Experience(
      role: 'Senior Flutter Developer',
      company: 'Ard Group',
      period: 'August 2025 – Present',
      location: 'Amman, Jordan',
      logoAsset: 'assets/logos/ard.jpg',
      bullets: [
        'Architecting and maintaining a modular super app supporting 10+ integrated services and features for a large-scale user base.',
        'Implementing Clean Architecture with strict separation of concerns across data, domain, and presentation layers.',
        'Driving Test-Driven Development (TDD) practices, achieving significant improvements in code reliability and reducing production bug rates.',
        'Building and maintaining a Server-Driven UI (SDUI) framework enabling dynamic layouts, feature flags, and remote configuration — eliminating the need for frequent store releases.',
        'Deploying over-the-air patches and hotfixes using Shorebird, delivering critical updates in hours rather than the typical app store review cycle.',
        'Leading cross-functional collaboration with backend engineers, QA, product managers, and UI/UX designers to align on technical requirements and timelines.',
        'Mentoring junior developers on Flutter best practices, architecture patterns, and code review standards.',
      ],
      techTags: [
        'Flutter',
        'Clean Architecture',
        'TDD',
        'SDUI',
        'Shorebird',
        'BLoC',
      ],
    ),
    Experience(
      role: 'Software Developer',
      company: 'Awael Technologies',
      period: 'February 2022 – August 2025',
      location: 'Amman, Jordan',
      logoAsset: 'assets/logos/awael.jpg',
      bullets: [
        'Delivered 10+ high-performance, user-centric Flutter mobile applications for enterprise and government clients across diverse sectors.',
        'Built and integrated RESTful APIs, optimizing data retrieval pipelines and significantly improving app response times.',
        'Designed and managed SQL Server database schemas, including data integration, automated backup strategies, and disaster recovery processes.',
        'Integrated critical third-party financial systems: MPGS (Mastercard Payment Gateway), eFawateercom (Jordanian national bill payment platform), and Fortara governmental system — enabling secure, automated financial and governmental transactions.',
        'Developed advanced customized reporting solutions using Bold Reports and SSRS, enabling data-driven decision-making for enterprise clients.',
        'Implemented state management architectures using Provider and GetX, optimizing app performance and maintainability.',
        'Authored comprehensive Software Requirements Specification (SRS) documents by gathering and translating complex client requirements.',
        'Maintained version-controlled workflows with Git/GitHub, conducting code reviews and contributing across cross-functional teams.',
      ],
      techTags: [
        'Flutter',
        'Provider',
        'GetX',
        'REST APIs',
        'SQL Server',
        'SSRS',
        'MPGS',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Ard Super App',
      description:
          'A large-scale modular super app serving thousands of users with multiple integrated financial, utility, and lifestyle services — built with Clean Architecture and SDUI.',
      category: 'Enterprise Mobile',
      tech: ['Flutter', 'Clean Architecture', 'SDUI', 'BLoC', 'Shorebird'],
      emoji: '🏦',
    ),
    Project(
      title: 'eFawateercom Integration',
      description:
          'End-to-end integration of the Jordanian national bill payment platform enabling citizens to pay utility, telecom, and government bills seamlessly within mobile apps.',
      category: 'FinTech',
      tech: ['Flutter', 'REST APIs', 'SQL Server', 'MPGS'],
      emoji: '💳',
    ),
    Project(
      title: 'Fortara Gov System',
      description:
          'Mobile gateway for the Jordanian Fortara governmental transaction system, handling secure citizen-government financial interactions and official record-keeping.',
      category: 'GovTech',
      tech: ['Flutter', 'REST APIs', 'ADO.NET', 'SQL Server'],
      emoji: '🏛️',
    ),
    Project(
      title: 'Enterprise Reporting Suite',
      description:
          'A comprehensive reporting platform with dynamic dashboards, SSRS integration, and customizable report builders that empowered enterprise clients with real-time business intelligence.',
      category: 'Business Intelligence',
      tech: ['Flutter', 'SSRS', 'Bold Reports', 'SQL Server'],
      emoji: '📊',
    ),
    Project(
      title: 'Cross-Platform ERP Client',
      description:
          'A feature-rich ERP mobile client built with Flutter integrating complex business workflows, multi-role access, and real-time sync with backend EF Core services.',
      category: 'Enterprise',
      tech: ['Flutter', 'EF Core', 'Express.js', 'MySQL'],
      emoji: '⚙️',
    ),
    Project(
      title: 'Mobile Banking App',
      description:
          'Secure mobile banking application with MPGS payment gateway integration, biometric authentication, transaction history, and real-time balance tracking.',
      category: 'FinTech',
      tech: ['Flutter', 'MPGS', 'Provider', 'SQL Server'],
      emoji: '📱',
    ),
  ];

  static const List<TechSkill> skills = [
    TechSkill(
      name: 'Flutter',
      logoAsset: 'assets/logos/flutter.png',
      category: 'Mobile',
      level: 5,
    ),
    TechSkill(
      name: 'Dart',
      logoAsset: 'assets/logos/dart_logo.png',
      category: 'Language',
      level: 5,
    ),
    TechSkill(
      name: 'Firebase',
      logoAsset: 'assets/logos/firebase_logo.png',
      category: 'Backend',
      level: 4,
    ),
    TechSkill(
      name: 'SQL Server',
      logoAsset: 'assets/logos/sqlserver_logo.png',
      category: 'Database',
      level: 4,
    ),
    TechSkill(
      name: 'MySQL',
      logoAsset: 'assets/logos/mysql_logo.png',
      category: 'Database',
      level: 4,
    ),
    TechSkill(
      name: 'Git',
      logoAsset: 'assets/logos/git_logo.png',
      category: 'Tools',
      level: 5,
    ),
    TechSkill(
      name: 'Express.js',
      logoAsset: 'assets/logos/expressjs_logo.png',
      category: 'Backend',
      level: 3,
    ),
    TechSkill(
      name: 'EF Core',
      logoAsset: 'assets/logos/dotnet_logo.png',
      category: 'Backend',
      level: 3,
    ),
    TechSkill(
      name: 'ADO.NET',
      logoAsset: 'assets/logos/dotnet_logo.png',
      category: 'Backend',
      level: 3,
    ),
    TechSkill(
      name: 'REST APIs',
      logoAsset: 'assets/logos/api_logo.png',
      category: 'Web',
      level: 5,
    ),
  ];

  static const List<Certificate> certificates = [
    Certificate(
      title: 'HCIA – Artificial Intelligence',
      issuer: 'Huawei',
      description:
          'Foundations of Artificial Intelligence and Machine Learning, covering neural networks, ML algorithms, and AI application development.',
      certNo: '010102001437808462731389314',
      emoji: '🤖',
    ),
    Certificate(
      title: 'HCIA – Cloud Computing',
      issuer: 'Huawei',
      description:
          'Cloud infrastructure, services architecture, virtualization, and deployment models on Huawei Cloud platform.',
      certNo: '010100802437808063011409',
      emoji: '☁️',
    ),
    Certificate(
      title: 'HCIA – Routing & Switching',
      issuer: 'Huawei',
      description:
          'Networking fundamentals, routing protocols, switching technologies, and enterprise network design principles.',
      certNo: '01010010180805065626231',
      emoji: '🔌',
    ),
  ];
}
