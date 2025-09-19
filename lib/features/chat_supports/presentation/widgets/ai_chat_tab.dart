import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/chat_supports/data/model/chat_models.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/bubble.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/input_field.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/suggestion_chip.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/typing_bubble.dart';

class AiChatTab extends StatefulWidget {
  final List<ChatMessage> messages;
  final bool typing;
  final TextEditingController input;
  final void Function(String text) onSend;
  final void Function(String text) onQuickAsk;

  const AiChatTab({
    super.key,
    required this.messages,
    required this.typing,
    required this.input,
    required this.onSend,
    required this.onQuickAsk,
  });

  @override
  State<AiChatTab> createState() => _AiChatTabState();
}

class _AiChatTabState extends State<AiChatTab> {
  final ScrollController _scroll = ScrollController();
  final List<String> _suggestions = const [
    'What are my next steps?',
    'Show deadlines this month',
    'How to build a strong SOP?',
    'Which docs are missing?',
  ];

  @override
  void didUpdateWidget(covariant AiChatTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _jumpToBottom();
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header ribbon with quick filters
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
              Text('Ask UniBot', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Instant answers about your applications.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height10,
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _suggestions.length,
                  separatorBuilder: (_, __) => AppSpacing.width8,
                  itemBuilder: (_, i) => SuggestionChip(
                    label: _suggestions[i],
                    onTap: () => widget.onQuickAsk(_suggestions[i]),
                  ),
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
            itemCount: widget.messages.length + (widget.typing ? 1 : 0),
            itemBuilder: (_, i) {
              if (widget.typing && i == widget.messages.length) {
                return const TypingBubble();
              }
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
                    controller: widget.input,
                    hint: 'Ask anything…',
                    onSubmitted: widget.onSend,
                  ),
                ),
                AppSpacing.width10,
                SizedBox(
                  width: 96,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalBlue,
                    ),
                    onPressed: () => widget.onSend(widget.input.text),
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
