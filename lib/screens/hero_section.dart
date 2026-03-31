import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class HeroSection extends StatelessWidget {
  final bool isDark;
  final Function(String) onNavTap;

  const HeroSection({super.key, required this.isDark, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return Container(
      constraints: const BoxConstraints(minHeight: 700),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: isWide
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: _HeroText(isDark: isDark, onNavTap: onNavTap)),
          const SizedBox(width: 60),
          Expanded(flex: 2, child: _HeroAvatar(isDark: isDark)),
        ],
      )
          : Column(
        children: [
          _HeroAvatar(isDark: isDark),
          const SizedBox(height: 40),
          _HeroText(isDark: isDark, onNavTap: onNavTap),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isDark;
  final Function(String) onNavTap;

  const _HeroText({required this.isDark, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting
        Row(
          children: [
            Container(
              width: 36,
              height: 2,
              color: AppColors.accent,
            ),
            const SizedBox(width: 12),
            Text(
              "Hello, I'm",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.accent,
                letterSpacing: 1.5,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // Name
        Text(
          'Ammar\nAbdAl-Qader',
          style: GoogleFonts.orbitron(
            fontSize: MediaQuery.of(context).size.width > 700 ? 56 : 40,
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 700.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        // Animated role titles
        SizedBox(
          height: 40,
          child: Row(
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Senior Flutter Developer',
                    textStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [AppColors.accent, AppColors.accentSecondary],
                        ).createShader(const Rect.fromLTWH(0, 0, 340, 30)),
                    ),
                    speed: const Duration(milliseconds: 80),
                  ),
                  TypewriterAnimatedText(
                    'Clean Architecture Advocate',
                    textStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [AppColors.accentSecondary, AppColors.accent],
                        ).createShader(const Rect.fromLTWH(0, 0, 340, 30)),
                    ),
                    speed: const Duration(milliseconds: 80),
                  ),
                  TypewriterAnimatedText(
                    'Super App Architect',
                    textStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [AppColors.accentGreen, AppColors.accent],
                        ).createShader(const Rect.fromLTWH(0, 0, 340, 30)),
                    ),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms),

        const SizedBox(height: 24),

        // Bio
        Text(
          'Experienced Senior Mobile Developer with deep expertise in Flutter, '
              'scalable super app architecture, and enterprise mobile solutions. '
              'Passionate about building high-performance, maintainable applications '
              'that serve large user bases and create real-world impact.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            height: 1.7,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        )
            .animate()
            .fadeIn(delay: 700.ms, duration: 700.ms),

        const SizedBox(height: 20),

        // Stats row
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _StatBadge(value: '4+', label: 'Years Exp.', isDark: isDark),
            _StatBadge(value: '10+', label: 'Apps Delivered', isDark: isDark),
            _StatBadge(value: '2', label: 'Companies', isDark: isDark),
          ],
        )
            .animate()
            .fadeIn(delay: 900.ms, duration: 600.ms),

        const SizedBox(height: 36),

        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            GlowButton(
              label: 'View My Work',
              onTap: () => onNavTap('Projects'),
              icon: Icons.rocket_launch_rounded,
            ),
            GlowButton(
              label: 'Get In Touch',
              onTap: () => onNavTap('Contact'),
              outlined: true,
              icon: Icons.mail_outline_rounded,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1100.ms, duration: 600.ms),

        const SizedBox(height: 28),

        // Social links
        Row(
          children: [
            _SocialLink(
              label: 'GitHub',
              icon: Icons.code,
              url: 'https://github.com/AmmarAbdalqader',
            ),
            const SizedBox(width: 16),
            _SocialLink(
              label: 'LinkedIn',
              icon: Icons.link,
              url: 'https://www.linkedin.com/in/ammar-abdalqader-8161281b8/',
            ),
            const SizedBox(width: 16),
            _SocialLink(
              label: 'Email',
              icon: Icons.mail,
              url: 'mailto:ammarkhalid513@gmail.com',
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1300.ms),
      ],
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;

  const _StatBadge({required this.value, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBorder),
        borderRadius: BorderRadius.circular(10),
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.orbitron(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentGlow],
                ).createShader(const Rect.fromLTWH(0, 0, 60, 30)),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _SocialLink({required this.label, required this.icon, required this.url});

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _hovered ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
            border: Border.all(
              color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.darkBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? AppColors.accent : AppColors.darkTextMuted,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? AppColors.accent : AppColors.darkTextMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  final bool isDark;

  const _HeroAvatar({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withOpacity(0.15),
                  AppColors.accentGlow.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .scaleXY(begin: 0.9, end: 1.05, duration: 3000.ms, curve: Curves.easeInOut)
              .then()
              .scaleXY(begin: 1.05, end: 0.9, duration: 3000.ms, curve: Curves.easeInOut),

          // Rotating dashed ring
          SizedBox(
            width: 280,
            height: 280,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 1.5,
              backgroundColor: AppColors.darkBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .rotate(duration: 10000.ms, begin: 0, end: 1),

          // Avatar container
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accent.withOpacity(0.3),
                  AppColors.accentSecondary.withOpacity(0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.fitHeight,
                errorBuilder: (_, _, _) => Container(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 80, color: AppColors.accent),
                      const SizedBox(height: 8),
                      Text(
                        'Ammar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          color: AppColors.darkTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 800.ms)
              .scaleXY(begin: 0.8, end: 1),

          // Flutter logo badge
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent.withOpacity(0.5), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FlutterLogo()

                // Image.asset(
                //   'assets/logos/flutter.png',
                //   errorBuilder: (_, __, ___) => const Text('F', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w900, fontSize: 22)),
                // ),
              ),
            )
                .animate()
                .fadeIn(delay: 1000.ms)
                .scaleXY(begin: 0, end: 1, curve: Curves.elasticOut),
          ),
        ],
      ),
    );
  }
}