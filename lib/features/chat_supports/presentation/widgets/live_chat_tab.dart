import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/chat_supports/data/model/chat_models.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/bubble.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/bullet.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/input_field.dart';

class LiveChatTab extends StatefulWidget {
  final bool hasActive;
  final List<ChatMessage> messages;
  final VoidCallback onStartChat;
  final VoidCallback onEndChat;
  final void Function(String text) onSend;

  const LiveChatTab({
    super.key,
    required this.hasActive,
    required this.messages,
    required this.onStartChat,
    required this.onEndChat,
    required this.onSend,
  });

  @override
  State<LiveChatTab> createState() => _LiveChatTabState();
}

class _LiveChatTabState extends State<LiveChatTab> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.hasActive) {
      // Intro / queue card
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: AppSpacing.paddingH16V12,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.skyBlueMid, AppColors.royalBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Live Chat', style: AppTextStyles.inter400White16),
                AppSpacing.height2,
                Text('Chat with a human advisor.',
                    style: AppTextStyles.heading3White),
                AppSpacing.height12,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        width: double.infinity,
                        text: 'Start Chat',
                        onPressed: widget.onStartChat,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.height12,
          Padding(
            padding: AppSpacing.paddingH16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: AppSpacing.paddingH12V12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What to expect',
                        style: AppTextStyles.inter600Black16),
                    const SizedBox(height: 6),
                    const Bullet('Average response time: 1–3 minutes.'),
                    const Bullet(
                        'We may ask for your application ID to help faster.'),
                    const Bullet(
                        'Chat transcript will be saved for your records.'),
                  ],
                ),
              ),
            ),
          ),
          AppSpacing.height24,
        ],
      );
    }

    // Active chat UI
    return Column(
      children: [
        // Header actions
        Container(
          padding: AppSpacing.paddingH16V12,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.skyBlueMid, AppColors.royalBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Connected to Sarah',
                        style: AppTextStyles.inter400White16),
                    AppSpacing.height2,
                    Text('Admissions Advisor',
                        style: AppTextStyles.heading3White),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: CustomButton(
                  width: double.infinity,
                  text: 'End Chat',
                  onPressed: widget.onEndChat,
                ),
              ),
            ],
          ),
        ),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: AppSpacing.paddingH16,
            itemCount: widget.messages.length,
            itemBuilder: (_, i) {
              final m = widget.messages[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Align(
                  alignment:
                      m.fromBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Bubble(message: m),
                ),
              );
            },
          ),
        ),

        // Composer
        SafeArea(
          top: false,
          child: Padding(
            padding: AppSpacing.paddingH16V12,
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: _input,
                    hint: 'Type a message…',
                    onSubmitted: (t) {
                      widget.onSend(t);
                      _input.clear();
                    },
                  ),
                ),
                AppSpacing.width10,
                SizedBox(
                  width: 96,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalBlue,
                    ),
                    onPressed: () {
                      widget.onSend(_input.text);
                      _input.clear();
                    },
                    child: const Text('Send',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
