import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';

// ─── NAVBAR ──────────────────────────────────────────────────────────────────

class PortfolioNavBar extends StatelessWidget {
  final Function(String) onNavTap;
  final String activeSection;

  const PortfolioNavBar({
    super.key,
    required this.onNavTap,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final isDark = theme.isDark;
    final bg = isDark ? AppColors.darkBg.withOpacity(0.92) : AppColors.lightSurface.withOpacity(0.92);
    final sections = ['About', 'Experience', 'Projects', 'Skills', 'Certificates', 'Contact'];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: bg,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          children: [
            // Logo / Brand
            Text(
              'AA.',
              style: GoogleFonts.orbitron(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [AppColors.accent, AppColors.accentGlow],
                  ).createShader(const Rect.fromLTWH(0, 0, 60, 30)),
              ),
            ),
            const Spacer(),
            // Nav items - only show on wide screens
            if (MediaQuery.of(context).size.width > 800)
              ...sections.map((s) => _NavItem(
                label: s,
                isActive: activeSection == s,
                onTap: () => onNavTap(s),
                isDark: isDark,
              )),
            const SizedBox(width: 20),
            // Theme toggle
            GestureDetector(
              onTap: theme.toggleTheme,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 52,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: isDark
                        ? [AppColors.accentGlow, AppColors.accent]
                        : [const Color(0xFFFFB347), const Color(0xFFFF6B6B)],
                  ),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.white,
                      child: Text(
                        isDark ? '🌙' : '☀️',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({required this.label, required this.isActive, required this.onTap, required this.isDark});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? AppColors.accent
        : _hovered
        ? (widget.isDark ? AppColors.darkText : AppColors.lightText)
        : (widget.isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── SECTION HEADER ──────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final bool isDark;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.orbitron(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.accent, AppColors.accentSecondary],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── ANIMATED CARD ───────────────────────────────────────────────────────────

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final bool isDark;
  final EdgeInsets? padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  const AnimatedCard({
    super.key,
    required this.child,
    required this.isDark,
    this.padding,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()..translate(0.0, _hovered ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.5)
                  : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ]
                : [],
          ),
          padding: widget.padding ?? const EdgeInsets.all(24),
          child: widget.child,
        ),
      ),
    );
  }
}

// ─── TECH TAG ────────────────────────────────────────────────────────────────

class TechTag extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool highlighted;

  const TechTag({super.key, required this.label, required this.isDark, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.accent.withOpacity(0.15)
            : (isDark ? AppColors.darkBg : AppColors.lightBorder.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: highlighted ? AppColors.accent.withOpacity(0.4) : Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: highlighted ? AppColors.accent : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
        ),
      ),
    );
  }
}

// ─── GLOWING BUTTON ──────────────────────────────────────────────────────────

class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final IconData? icon;

  const GlowButton({
    super.key,
    required this.label,
    required this.onTap,
    this.outlined = false,
    this.icon,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: widget.outlined
                ? null
                : LinearGradient(
              colors: _hovered
                  ? [AppColors.accentGlow, AppColors.accentSecondary]
                  : [AppColors.accent, AppColors.accentGlow],
            ),
            border: widget.outlined
                ? Border.all(
              color: _hovered ? AppColors.accent : AppColors.darkBorder,
              width: 1.5,
            )
                : null,
            boxShadow: !widget.outlined && _hovered
                ? [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: widget.outlined
                      ? (_hovered ? AppColors.accent : AppColors.darkTextMuted)
                      : Colors.white,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.outlined
                      ? (_hovered ? AppColors.accent : AppColors.darkTextMuted)
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── SKILL BAR ───────────────────────────────────────────────────────────────

class SkillBar extends StatelessWidget {
  final String name;
  final int level;
  final bool isDark;

  const SkillBar({super.key, required this.name, required this.level, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            Text(
              '${'★' * level}${'☆' * (5 - level)}',
              style: TextStyle(color: AppColors.accent, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: level / 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentSecondary],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}