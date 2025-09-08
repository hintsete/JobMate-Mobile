import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_mate/core/presentation/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:job_mate/core/presentation/widgets/language_toggle_button.dart';

class InterviewSelectionPage extends StatelessWidget {
  const InterviewSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF238471),
        title: Text(
          l10n.interviewPrep,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(Routes.home),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: LanguageToggleButton(
              backgroundColor: Colors.white.withOpacity(0.2),
              iconColor: Colors.white,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              l10n.chooseInterviewMode,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF144A3F),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.selectInterviewType,
              style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
            ),
            const SizedBox(height: 40),

            // Freeform Interview Card
            _buildInterviewModeCard(
              context,
              title: l10n.freeformInterview,
              subtitle: l10n.chatBasedPractice,
              description: l10n.freeformDescription,
              features: [
                l10n.openConversationFormat,
                l10n.askAnyQuestions,
                l10n.realtimeAiResponses,
                l10n.practiceAtOwnPace,
              ],
              icon: Icons.chat_bubble_outline,
              color: const Color(0xFF28957F),
              onTap: () => context.go('/interview/freeform'),
            ),

            const SizedBox(height: 24),

            // Structured Interview Card
            _buildInterviewModeCard(
              context,
              title: l10n.structuredInterview,
              subtitle: l10n.guidedQaSession,
              description: l10n.structuredDescription,
              features: [
                l10n.sixStructuredQuestions,
                l10n.detailedFeedbackPerAnswer,
                l10n.progressTracking,
                l10n.realisticInterviewSimulation,
              ],
              icon: Icons.quiz_outlined,
              color: const Color(0xFF1976D2),
              onTap: () => _showFieldSelectionDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterviewModeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required List<String> features,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF144A3F),
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            ...features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: color, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  void _showFieldSelectionDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController customFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.selectInterviewField),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.chooseFieldForStructuredInterview),
                    const SizedBox(height: 16),
                    _buildFieldOption(
                      context,
                      l10n.softwareEngineer,
                      'software_engineering',
                    ),
                    _buildFieldOption(
                      context,
                      l10n.dataScientist,
                      'data_scientist',
                    ),
                    _buildFieldOption(
                      context,
                      l10n.productManager,
                      'product_manager',
                    ),
                    _buildFieldOption(context, l10n.marketing, 'marketing'),
                    _buildFieldOption(context, l10n.sales, 'sales'),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Custom field input section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.orEnterCustomField,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF144A3F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: customFieldController,
                      decoration: InputDecoration(
                        hintText: l10n.exampleUxDesignerDevopsEngineer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final customField = customFieldController.text.trim();
                          if (customField.isNotEmpty) {
                            Navigator.of(context).pop();
                            // Convert to lowercase with underscores for backend compatibility
                            final fieldForBackend = customField
                                .toLowerCase()
                                .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
                                .replaceAll(RegExp(r'^_+|_+$'), '');
                            context.go(
                              '/interview/structured?field=$fieldForBackend',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF28957F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(l10n.startCustomFieldInterview),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFieldOption(BuildContext context, String label, String field) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          context.go('/interview/structured?field=$field');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label),
      ),
    );
  }
}
