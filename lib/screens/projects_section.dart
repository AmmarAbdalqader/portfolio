import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class ProjectsSection extends StatefulWidget {
  final bool isDark;

  const ProjectsSection({super.key, required this.isDark});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = 'All';

  List<String> get _categories {
    final cats = ['All', ...PortfolioData.projects.map((p) => p.category).toSet()];
    return cats;
  }

  List<Project> get _filtered {
    if (_filter == 'All') return PortfolioData.projects;
    return PortfolioData.projects.where((p) => p.category == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isDark = widget.isDark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      color: isDark
          ? AppColors.darkSurface.withOpacity(0.5)
          : AppColors.lightCard.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '03 / Projects',
            title: 'My Work',
            isDark: isDark,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 12),

          Text(
            'A selection of enterprise apps, fintech solutions, and mobile products '
                'delivered for real clients and organizations.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              height: 1.7,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),

          const SizedBox(height: 32),

          // Filter tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final active = _filter == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: active
                            ? AppColors.accent
                            : (isDark ? AppColors.darkCard : AppColors.lightSurface),
                        border: Border.all(
                          color: active ? AppColors.accent : AppColors.darkBorder,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: active
                              ? Colors.black
                              : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 40),

          // Projects grid
          LayoutBuilder(
            builder: (ctx, constraints) {
              final cols = constraints.maxWidth > 800 ? 3 : constraints.maxWidth > 500 ? 2 : 1;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _filtered.asMap().entries.map((e) {
                  final idx = e.key;
                  final project = e.value;
                  return SizedBox(
                    width: (constraints.maxWidth - (cols - 1) * 20) / cols,
                    child: _ProjectCard(
                      project: project,
                      isDark: isDark,
                      delay: idx * 100,
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 48),

          // Add your projects CTA
          AnimatedCard(
            isDark: isDark,
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🚀 More Projects Coming Soon',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'More detailed case studies and live demos will be added here. '
                            'Add your project screenshots and Play Store / App Store links '
                            'to bring your portfolio to life.',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.add_circle_outline, color: AppColors.accent, size: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isDark;
  final int delay;

  const _ProjectCard({required this.project, required this.isDark, required this.delay});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, _hovered ? -6.0 : 0.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.darkBorder,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Text(p.emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentSecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.accentSecondary.withOpacity(0.3)),
                    ),
                    child: Text(
                      p.category,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentSecondary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                p.title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                p.description,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  height: 1.6,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: p.tech.map((t) => TechTag(label: t, isDark: isDark)).toList(),
              ),

              // Store links
              if (p.playStoreUrl != null || p.appStoreUrl != null || p.githubUrl != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (p.playStoreUrl != null)
                      _StoreButton(
                        label: 'Play Store',
                        icon: Icons.android,
                        url: p.playStoreUrl!,
                      ),
                    if (p.appStoreUrl != null)
                      _StoreButton(
                        label: 'App Store',
                        icon: Icons.apple,
                        url: p.appStoreUrl!,
                      ),
                    if (p.githubUrl != null)
                      _StoreButton(
                        label: 'GitHub',
                        icon: Icons.code,
                        url: p.githubUrl!,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(delay: Duration(milliseconds: widget.delay), duration: 500.ms)
          .slideY(begin: 0.2, end: 0),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;

  const _StoreButton({required this.label, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: AppColors.accent),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}