import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  final bool isDark;

  const SkillsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    final categories = PortfolioData.skills.map((s) => s.category).toSet().toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '04 / Skills',
            title: 'Tech Stack',
            isDark: isDark,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          Text(
            'Technologies and tools I work with on a daily basis.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              height: 1.7,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),

          const SizedBox(height: 56),

          // Skills Logo Grid
          _SkillsLogoGrid(isDark: isDark),

          const SizedBox(height: 60),

          // Skills by category with bars
          LayoutBuilder(builder: (ctx, constraints) {
            final cols = constraints.maxWidth > 800 ? 2 : 1;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: categories.map((cat) {
                final catSkills = PortfolioData.skills.where((s) => s.category == cat).toList();
                return SizedBox(
                  width: (constraints.maxWidth - (cols - 1) * 24) / cols,
                  child: AnimatedCard(
                    isDark: isDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: const LinearGradient(
                                  colors: [AppColors.accent, AppColors.accentSecondary],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cat,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...catSkills.map((s) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: SkillBar(
                            name: s.name,
                            level: s.level,
                            isDark: isDark,
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),

          const SizedBox(height: 48),

          // Architecture patterns
          _ArchitecturePatterns(isDark: isDark),
        ],
      ),
    );
  }
}

class _SkillsLogoGrid extends StatelessWidget {
  final bool isDark;

  const _SkillsLogoGrid({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: PortfolioData.skills.asMap().entries.map((e) {
        final idx = e.key;
        final skill = e.value;
        return _SkillLogo(skill: skill, isDark: isDark, delay: idx * 60);
      }).toList(),
    );
  }
}

class _SkillLogo extends StatefulWidget {
  final TechSkill skill;
  final bool isDark;
  final int delay;

  const _SkillLogo({required this.skill, required this.isDark, required this.delay});

  @override
  State<_SkillLogo> createState() => _SkillLogoState();
}

class _SkillLogoState extends State<_SkillLogo> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _hovered ? -4.0 : 0.0),
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.darkBorder,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                widget.skill.logoAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withOpacity(0.15),
                  ),
                  child: Center(
                    child: Text(
                      widget.skill.name[0],
                      style: GoogleFonts.orbitron(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.skill.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _hovered
                    ? AppColors.accent
                    : (widget.isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: Duration(milliseconds: widget.delay), duration: 400.ms)
          .scaleXY(begin: 0.8, end: 1),
    );
  }
}

class _ArchitecturePatterns extends StatelessWidget {
  final bool isDark;

  const _ArchitecturePatterns({required this.isDark});

  final _patterns = const [
    ('Clean Architecture', '🏗️'),
    ('BLoC Pattern', '🔵'),
    ('TDD', '✅'),
    ('SDUI', '🖥️'),
    ('MVVM', '📐'),
    ('Provider', '⚡'),
    ('GetX', '🟠'),
    ('Repository Pattern', '📦'),
    ('Dependency Injection', '🔌'),
    ('RESTful APIs', '🌐'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧠', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Text(
                'Architecture & Patterns',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _patterns
                .map((p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.accentSecondary.withOpacity(0.08),
                border: Border.all(color: AppColors.accentSecondary.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(p.$2, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    p.$1,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                ],
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}