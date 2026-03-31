import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDark;

  const ExperienceSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '02 / Experience',
            title: 'Work History',
            isDark: isDark,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 60),

          // Timeline
          ...PortfolioData.experiences.asMap().entries.map((e) {
            final idx = e.key;
            final exp = e.value;
            return _ExperienceCard(
              experience: exp,
              isDark: isDark,
              isLast: idx == PortfolioData.experiences.length - 1,
              delay: idx * 200,
            );
          }),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final Experience experience;
  final bool isDark;
  final bool isLast;
  final int delay;

  const _ExperienceCard({
    required this.experience,
    required this.isDark,
    required this.isLast,
    required this.delay,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;
  static const int _previewCount = 3;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final exp = widget.experience;
    final visibleBullets = _expanded
        ? exp.bullets
        : exp.bullets.take(_previewCount).toList();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.accent, AppColors.accentGlow],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.accent.withOpacity(0.5),
                            AppColors.darkBorder.withOpacity(0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Card content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child:
                  AnimatedCard(
                        isDark: widget.isDark,
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Company logo
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: widget.isDark
                                          ? AppColors.darkBg
                                          : AppColors.lightSurface,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image.asset(
                                      exp.logoAsset,
                                      fit: BoxFit.fill,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Text(
                                          exp.company[0],
                                          style: GoogleFonts.orbitron(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exp.role,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: widget.isDark
                                              ? AppColors.darkText
                                              : AppColors.lightText,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        exp.company,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.accent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (isWide)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: AppColors.accent.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          exp.period,
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 14,
                                            color: widget.isDark
                                                ? AppColors.darkTextMuted
                                                : AppColors.lightTextMuted,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            exp.location,
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 12,
                                              color: widget.isDark
                                                  ? AppColors.darkTextMuted
                                                  : AppColors.lightTextMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),

                            if (!isWide) ...[
                              const SizedBox(height: 12),
                              Text(
                                exp.period,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],

                            const SizedBox(height: 20),

                            // Bullets
                            ...visibleBullets.map(
                              (b) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.accent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Text(
                                        b,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 14,
                                          height: 1.65,
                                          color: widget.isDark
                                              ? AppColors.darkTextMuted
                                              : AppColors.lightTextMuted,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Expand/collapse
                            if (exp.bullets.length > _previewCount) ...[
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _expanded = !_expanded),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _expanded
                                          ? 'Show less'
                                          : 'Show ${exp.bullets.length - _previewCount} more',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      _expanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: AppColors.accent,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: 16),

                            // Tech tags
                            Flexible(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: exp.techTags
                                    .map(
                                      (t) => TechTag(
                                        label: t,
                                        isDark: widget.isDark,
                                        highlighted: true,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: widget.delay),
                        duration: 600.ms,
                      )
                      .slideX(begin: 0.2, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}
