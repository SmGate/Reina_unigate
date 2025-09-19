// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/chat_supports/data/model/chat_models.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/ai_chat_tab.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/faqs_tab.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/live_chat_tab.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // ---- UniBot (AI) mock state ----
  final List<ChatMessage> _aiMessages = [
    ChatMessage(
      fromBot: true,
      text:
          'Hey there! I’m UniBot 👋\nI can help with applications, documents, deadlines and more.',
      time: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      fromBot: false,
      text: 'What documents do I need for CS undergrad?',
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatMessage(
      fromBot: true,
      text:
          'Typically: transcript, passport, resume/CV, statement of purpose, and 2 recommendations. Requirements vary per university.',
      time: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];
  final TextEditingController _aiInput = TextEditingController();
  bool _aiTyping = false;

  // ---- Live Chat mock state ----
  bool _hasActiveHumanChat = false;
  final List<ChatMessage> _humanMessages = [];

  // ---- FAQs ----
  final TextEditingController _faqSearch = TextEditingController();
  final List<FaqItem> _faqs = const [
    FaqItem('How to upload documents?',
        'Go to Document Center → Upload. Use PDF where possible.'),
    FaqItem('Where can I see my deadlines?',
        'Application Manager cards show deadlines with status.'),
    FaqItem('How do I request expert review?',
        'Document Center → Expert Review → Submit for Review.'),
    FaqItem('What is SOP and how to write it?',
        'Use the SOP Builder with guided tips and sections.'),
    FaqItem('Can I apply to multiple universities?',
        'Yes. Use Application Manager → New Application.'),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _aiInput.dispose();
    _faqSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            alignment: Alignment.centerLeft,
            color: AppColors.white,
            child: TabBar(
              controller: _tab,
              indicatorColor: AppColors.royalBlue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                  child: Text('Ask UniBot',
                      style: AppTextStyles.displayMediumMedium12),
                ),
                Tab(
                  child: Text('Live Chat',
                      style: AppTextStyles.displayMediumMedium12),
                ),
                Tab(
                  child:
                      Text('FAQs', style: AppTextStyles.displayMediumMedium12),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          AiChatTab(
            messages: _aiMessages,
            typing: _aiTyping,
            input: _aiInput,
            onSend: _sendAiMessage,
            onQuickAsk: _quickAsk,
          ),
          LiveChatTab(
            hasActive: _hasActiveHumanChat,
            messages: _humanMessages,
            onStartChat: _startHumanChat,
            onEndChat: _endHumanChat,
            onSend: _sendHumanMessage,
          ),
          FaqsTab(
            faqs: _faqs,
            search: _faqSearch,
            onOpen: _openFaqArticle,
          ),
        ],
      ),
    );
  }

  // ===== UniBot actions =====
  void _sendAiMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _aiMessages
          .add(ChatMessage(fromBot: false, text: text, time: DateTime.now()));
      _aiTyping = true;
      _aiInput.clear();
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _aiMessages.add(ChatMessage(
        fromBot: true,
        text:
            'Here’s what I found for “$text”. You can also check Application Manager or Document Center for next steps.',
        time: DateTime.now(),
      ));
      _aiTyping = false;
    });
  }

  void _quickAsk(String prompt) => _sendAiMessage(prompt);

  // ===== Human chat actions =====
  void _startHumanChat() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: AppSpacing.paddingH16V12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text('Start Live Chat', style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height12,
            Text(
              'You’ll be connected to an advisor. Typical wait time 1–3 min.',
              style: AppTextStyles.heading3Regular,
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Connect',
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => _hasActiveHumanChat = true);
                      _humanMessages.add(ChatMessage(
                        fromBot: true,
                        text:
                            'You are connected with Sarah (Admissions Advisor). How can I help today?',
                        time: DateTime.now(),
                      ));
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }

  void _endHumanChat() {
    setState(() => _hasActiveHumanChat = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat ended. A transcript was saved.')),
    );
  }

  void _sendHumanMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _humanMessages
          .add(ChatMessage(fromBot: false, text: text, time: DateTime.now()));
    });
  }

  // ===== FAQ actions =====
  void _openFaqArticle(FaqItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: AppSpacing.paddingH16V12.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(item.title, style: AppTextStyles.displayMediumMedium18),
              AppSpacing.height12,
              Text(item.body, style: AppTextStyles.inter400Black16),
              AppSpacing.height12,
              CustomButton(
                width: double.infinity,
                text: 'Ask UniBot about this',
                onPressed: () {
                  Navigator.pop(context);
                  _tab.animateTo(0);
                  _sendAiMessage(item.title);
                },
              ),
              AppSpacing.height6,
            ],
          ),
        ),
      ),
    );
  }
}
