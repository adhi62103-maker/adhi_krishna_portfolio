import 'package:adhi_krishna_portfolio/core/theme/app_colors.dart';
import 'package:adhi_krishna_portfolio/data/portfolio_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:adhi_krishna_portfolio/core/utils/download_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:adhi_krishna_portfolio/core/widgets/animated_on_scroll.dart';
import 'package:adhi_krishna_portfolio/core/widgets/floating_widget.dart';
import 'package:adhi_krishna_portfolio/core/widgets/underwater_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showFab) {
        setState(() => _showFab = true);
      } else if (_scrollController.offset <= 300 && _showFab) {
        setState(() => _showFab = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
              child: const Icon(Icons.arrow_upward),
            ).animate().scale()
          : null,
      body: UnderwaterBackground(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 48.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    _buildHeader(context),
                    const SizedBox(height: 100),
                    _buildSection(_buildAbout(context), index: 0),
                    const SizedBox(height: 100),
                    _buildSection(_buildServices(context), index: 1),
                    const SizedBox(height: 100),
                    _buildSection(_buildExperience(context), index: 2),
                    const SizedBox(height: 100),
                    _buildSection(_buildEducation(context), index: 3),
                    const SizedBox(height: 100),
                    _buildSection(_buildSkills(context), index: 4),
                    const SizedBox(height: 100),
                    _buildSection(_buildProjects(context), index: 5),
                    const SizedBox(height: 100),
                    _buildFooter(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(Widget child, {required int index}) {
    final bool isEven = index % 2 == 0;
    return VisibilityDetector(
      key: Key('section-$index'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          // You could use a state map to trigger animations once,
          // but flutter_animate's fadeIn/slide already look great
          // when key-based builders are used.
          // For simplicity, we just use the default trigger.
        }
      },
      child: child
          .animate()
          .fadeIn(duration: 800.ms, curve: Curves.easeOut)
          .slideX(
            begin: isEven ? -0.2 : 0.2,
            end: 0,
            duration: 800.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, I'm",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn().slideX(begin: -0.1),
              const SizedBox(height: 8),
              Text(
                PortfolioData.name,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
              const SizedBox(height: 16),
              Text(
                PortfolioData.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                children: [
                  _socialButton(FontAwesomeIcons.github, PortfolioData.github),
                  _socialButton(
                    FontAwesomeIcons.linkedin,
                    PortfolioData.linkedin,
                  ),
                  _socialButton(
                    FontAwesomeIcons.envelope,
                    "mailto:${PortfolioData.email}",
                  ),
                  _socialButton(
                    FontAwesomeIcons.whatsapp,
                    "https://wa.me/${PortfolioData.phone.replaceAll(RegExp(r'\s+'), '')}",
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PortfolioData.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),

        const SizedBox(width: 48),
        FloatingWidget(
          amplitude: 8,
          phase: 0.1,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: AppColors.surface,
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
              onBackgroundImageError: (exception, stackTrace) {
                // Handle missing image gracefully
              },
            ),
          ),
        ).animate().fadeIn(delay: 600.ms),
      ],
    );
  }

  Widget _socialButton(IconData icon, String url) {
    return IconButton(
      onPressed: () => launchUrlString(url),
      icon: FaIcon(icon),
      color: AppColors.textSecondary,
      hoverColor: AppColors.primary,
      iconSize: 28,
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "About Me"),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PortfolioData.aboutPoints,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary.withOpacity(0.9),
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => DownloadUtils.downloadResume(
                  PortfolioData.atsResumeLink,
                  'Adhi_Krishna_ATS_Resume.pdf',
                ),
                icon: const Icon(Icons.description_rounded, size: 20),
                label: const Text("Download Resumé"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServices(BuildContext context) {
    // Map icon names to IconData
    final Map<String, IconData> iconMap = {
      'mobile': Icons.smartphone,
      'brush': Icons.brush,
      'layers': Icons.layers,
      'cloud': Icons.cloud,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "What I Do"),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            mainAxisExtent: 260,
          ),
          itemCount: PortfolioData.services.length,
          itemBuilder: (context, index) {
            final service = PortfolioData.services[index];
            return FloatingWidget(
              amplitude: 6,
              phase: index * 0.08,
              child: Card(
                color: AppColors.surface.withValues(alpha: 0.5),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          iconMap[service.iconName] ?? Icons.code,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        service.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().scale(delay: (100 * index).ms);
          },
        ),
      ],
    );
  }

  Widget _buildExperience(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "Experience"),
        const SizedBox(height: 24),
        ...List.generate(PortfolioData.experience.length, (i) {
          final exp = PortfolioData.experience[i];
          return AnimatedOnScroll(
            delay: Duration(milliseconds: 80 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exp.role,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        exp.duration,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exp.company,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...exp.points.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              right: 12.0,
                            ),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              point,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    height: 1.5,
                                    color: AppColors.textPrimary.withValues(
                                      alpha: 0.9,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEducation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "Education"),
        const SizedBox(height: 24),
        ...List.generate(PortfolioData.education.length, (i) {
          final edu = PortfolioData.education[i];
          return AnimatedOnScroll(
            delay: Duration(milliseconds: 80 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.school_rounded,
                    color: AppColors.accent,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          edu.institution,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          edu.degree,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          edu.duration,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "Skills"),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(PortfolioData.skills.length, (i) {
            final skill = PortfolioData.skills[i];
            return AnimatedOnScroll(
              delay: Duration(milliseconds: 40 * i),
              axis: Axis.horizontal,
              offset: 0.06,
              child: FloatingWidget(
                amplitude: 4,
                phase: i * 0.06,
                child: Chip(
                  label: Text(skill),
                  backgroundColor: AppColors.surface,
                  labelStyle: const TextStyle(color: AppColors.textPrimary),
                  side: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProjects(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, "Featured Projects"),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            mainAxisExtent: 220,
          ),
          itemCount: PortfolioData.projects.length,
          itemBuilder: (context, index) {
            final project = PortfolioData.projects[index];
            return FloatingWidget(
              amplitude: 6,
              phase: index * 0.06,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    if (project.link != null) {
                      launchUrlString(project.link!);
                    }
                  },
                  hoverColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                project.title,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_outward,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            project.description,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ...project.tools.map(
                              (t) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().scale(delay: (200 * index).ms);
          },
        ),
      ],
    ).animate().fadeIn(delay: 700.ms);
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          "© ${DateTime.now().year} ${PortfolioData.name}. All rights reserved.",
          style: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
