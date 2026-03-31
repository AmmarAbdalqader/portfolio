import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'hero_section.dart';
import 'experience_section.dart';
import 'projects_section.dart';
import 'skills_section.dart';
import 'certificates_section.dart';
import 'contact_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollCtrl = ScrollController();
  final _keys = {
    'About': GlobalKey(),
    'Experience': GlobalKey(),
    'Projects': GlobalKey(),
    'Skills': GlobalKey(),
    'Certificates': GlobalKey(),
    'Contact': GlobalKey(),
  };
  String _activeSection = 'About';

  void _scrollTo(String section) {
    final key = _keys[section];
    if (key == null) return;

    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
    setState(() => _activeSection = section);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final isDark = theme.isDark;

    return Scaffold(
      body: Stack(
        children: [
          // Background particle effect
          Positioned.fill(child: _BackgroundDecoration(isDark: isDark)),

          // Main content
          Column(
            children: [
              // Fixed navbar
              PortfolioNavBar(
                onNavTap: _scrollTo,
                activeSection: _activeSection,
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    children: [
                      SizedBox(
                        key: _keys['About'],
                        child: HeroSection(isDark: isDark, onNavTap: _scrollTo),
                      ),
                      SizedBox(
                        key: _keys['Experience'],
                        child: ExperienceSection(isDark: isDark),
                      ),
                      SizedBox(
                        key: _keys['Projects'],
                        child: ProjectsSection(isDark: isDark),
                      ),
                      SizedBox(
                        key: _keys['Skills'],
                        child: SkillsSection(isDark: isDark),
                      ),
                      SizedBox(
                        key: _keys['Certificates'],
                        child: CertificatesSection(isDark: isDark),
                      ),
                      SizedBox(
                        key: _keys['Contact'],
                        child: ContactSection(isDark: isDark),
                      ),
                      _Footer(isDark: isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  final bool isDark;

  const _BackgroundDecoration({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-left glow blob
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withOpacity(isDark ? 0.06 : 0.04),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom-right glow blob
        Positioned(
          bottom: 200,
          right: -100,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentSecondary.withOpacity(isDark ? 0.05 : 0.03),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Grid pattern overlay
        Positioned.fill(
          child: CustomPaint(painter: _GridPainter(isDark: isDark)),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  final bool isDark;

  _GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? AppColors.darkBorder : AppColors.lightBorder)
          .withOpacity(0.3)
      ..strokeWidth = 0.5;

    const spacing = 60.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.isDark != isDark;
}

class _Footer extends StatelessWidget {
  final bool isDark;

  const _Footer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'AA.',
            style: GoogleFonts.orbitron(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentGlow],
                ).createShader(const Rect.fromLTWH(0, 0, 40, 20)),
            ),
          ),
          Text(
            '© ${DateTime.now().year} Ammar AbdAl-Qader. Built with Flutter 💙',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
