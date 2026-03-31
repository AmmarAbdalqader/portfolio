import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class ContactSection extends StatelessWidget {
  final bool isDark;

  const ContactSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '06 / Contact',
            title: "Let's Build\nTogether",
            isDark: isDark,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          Text(
            "Have a project in mind or want to discuss opportunities? "
            "I'm always open to new challenges and collaborations.",
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
              final isRowLayout = constraints.maxWidth > 800;
              if (isRowLayout) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _ContactLinks(isDark: isDark)),
                    const SizedBox(width: 40),
                    Expanded(flex: 3, child: _ContactForm(isDark: isDark)),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContactLinks(isDark: isDark),
                  const SizedBox(height: 32),
                  _ContactForm(isDark: isDark),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactLinks extends StatelessWidget {
  final bool isDark;

  const _ContactLinks({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.mail_outline_rounded,
        label: 'Email',
        value: 'ammarkhalid513@gmail.com',
        url: 'mailto:ammarkhalid513@gmail.com',
      ),
      (
        icon: Icons.phone_outlined,
        label: 'Phone',
        value: '+962 77 631 1665',
        url: 'tel:00962776311665',
      ),
      (
        icon: Icons.link_rounded,
        label: 'LinkedIn',
        value: 'ammar-abdalqader',
        url: 'https://www.linkedin.com/in/ammar-abdalqader-8161281b8/',
      ),
      (
        icon: Icons.code_rounded,
        label: 'GitHub',
        value: 'AmmarAbdalqader',
        url: 'https://github.com/AmmarAbdalqader',
      ),
      (
        icon: Icons.location_on_outlined,
        label: 'Location',
        value: 'Amman, Jordan',
        url: '',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((e) {
        final idx = e.key;
        final item = e.value;
        return _ContactItem(
          icon: item.icon,
          label: item.label,
          value: item.value,
          url: item.url,
          isDark: isDark,
          delay: idx * 100,
        );
      }).toList(),
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final bool isDark;
  final int delay;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.isDark,
    required this.delay,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.url.isNotEmpty
            ? () => launchUrl(Uri.parse(widget.url))
            : null,
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.isDark
                        ? AppColors.darkCard
                        : AppColors.lightCard,
                    border: Border.all(
                      color: _hovered && widget.url.isNotEmpty
                          ? AppColors.accent.withOpacity(0.5)
                          : AppColors.darkBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent.withOpacity(0.1),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 18,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.label,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: widget.isDark
                                    ? AppColors.darkTextMuted
                                    : AppColors.lightTextMuted,
                              ),
                            ),
                            Text(
                              widget.value,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _hovered && widget.url.isNotEmpty
                                    ? AppColors.accent
                                    : (widget.isDark
                                          ? AppColors.darkText
                                          : AppColors.lightText),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.url.isNotEmpty)
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: _hovered
                              ? AppColors.accent
                              : AppColors.darkBorder,
                        ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: widget.delay),
                  duration: 500.ms,
                )
                .slideX(begin: -0.2, end: 0),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  final bool isDark;

  const _ContactForm({required this.isDark});

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return AnimatedCard(
        isDark: widget.isDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('✅', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              "Message Sent!",
              style: GoogleFonts.orbitron(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.accentGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Thanks for reaching out. I'll get back to you soon.",
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: widget.isDark
                    ? AppColors.darkTextMuted
                    : AppColors.lightTextMuted,
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedCard(
      isDark: widget.isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: widget.isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
          _Field(
            label: 'Your Name',
            controller: _nameCtrl,
            isDark: widget.isDark,
          ),
          const SizedBox(height: 16),
          _Field(
            label: 'Email Address',
            controller: _emailCtrl,
            isDark: widget.isDark,
          ),
          const SizedBox(height: 16),
          _Field(
            label: 'Message',
            controller: _msgCtrl,
            isDark: widget.isDark,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          GlowButton(
            label: 'Send Message',
            icon: Icons.send_rounded,
            onTap: () {
              if (_nameCtrl.text.isNotEmpty &&
                  _emailCtrl.text.isNotEmpty &&
                  _msgCtrl.text.isNotEmpty) {
                final subject = Uri.encodeComponent(
                  'Portfolio Contact from ${_nameCtrl.text}',
                );
                final body = Uri.encodeComponent(
                  '${_msgCtrl.text}\n\nFrom: ${_nameCtrl.text}\nEmail: ${_emailCtrl.text}',
                );
                launchUrl(
                  Uri.parse(
                    'mailto:ammarkhalid513@gmail.com?subject=$subject&body=$body',
                  ),
                );
                setState(() => _sent = true);
              }
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideX(begin: 0.2, end: 0);
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isDark;
  final int maxLines;

  const _Field({
    required this.label,
    required this.controller,
    required this.isDark,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? AppColors.darkBg : AppColors.lightBg,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.darkBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.darkBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
