import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class CertificatesSection extends StatelessWidget {
  final bool isDark;

  const CertificatesSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 80),
      color: isDark
          ? AppColors.darkSurface.withOpacity(0.4)
          : AppColors.lightCard.withOpacity(0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '05 / Certificates',
            title: 'Certifications',
            isDark: isDark,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          Text(
            'Professional certifications from Huawei — validating expertise across AI, cloud, and networking.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              height: 1.7,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.lightTextMuted,
            ),
          ),

          const SizedBox(height: 48),

          LayoutBuilder(
            builder: (ctx, constraints) {
              final cols = constraints.maxWidth > 800
                  ? 3
                  : constraints.maxWidth > 500
                  ? 2
                  : 1;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: PortfolioData.certificates.asMap().entries.map((e) {
                  final idx = e.key;
                  final cert = e.value;
                  return SizedBox(
                    width: (constraints.maxWidth - (cols - 1) * 20) / cols,
                    child: _CertCard(
                      cert: cert,
                      isDark: isDark,
                      delay: idx * 150,
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 48),

          // Education card
          _EducationCard(isDark: isDark),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final Certificate cert;
  final bool isDark;
  final int delay;

  const _CertCard({
    required this.cert,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
          isDark: isDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent.withOpacity(0.2),
                          AppColors.accentSecondary.withOpacity(0.1),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cert.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.accentGreen.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            cert.issuer,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentGreen,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.verified, color: AppColors.accent, size: 22),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                cert.title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                cert.description,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  height: 1.6,
                  color: isDark
                      ? AppColors.darkTextMuted
                      : AppColors.lightTextMuted,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBg : AppColors.lightBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.numbers,
                      size: 14,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.lightTextMuted,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        cert.certNo,
                        style: GoogleFonts.spaceMono(
                          fontSize: 10,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.lightTextMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 600.ms,
        )
        .slideY(begin: 0.2, end: 0);
  }
}

class _EducationCard extends StatelessWidget {
  final bool isDark;

  const _EducationCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      isDark: isDark,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.accentSecondary.withOpacity(0.3),
                  AppColors.accent.withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: AppColors.accentSecondary.withOpacity(0.4),
              ),
            ),
            child: const Center(
              child: Text('🎓', style: TextStyle(fontSize: 30)),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'B.S. in Computer Science',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Al-Balqa\'a Applied University',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.calendar_today,
                      label: 'Sep 2018 – Jun 2022',
                      isDark: isDark,
                    ),
                    const SizedBox(width: 12),
                    _InfoChip(
                      icon: Icons.location_on_outlined,
                      label: 'As-Salt, Jordan',
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}
