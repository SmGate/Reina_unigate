// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/document_center/data/model/document_models.dart';
import 'package:unigate/features/document_center/presentation/widgets/documents_tab.dart';
import 'package:unigate/features/document_center/presentation/widgets/expert_review_tab.dart';
import 'package:unigate/features/document_center/presentation/widgets/sop_builder_tab.dart';
import 'package:unigate/features/document_center/presentation/widgets/sop_preview_block.dart';
import 'package:unigate/features/document_center/presentation/widgets/upload_row.dart';

class DocumentCenterScreen extends StatefulWidget {
  const DocumentCenterScreen({super.key});

  @override
  State<DocumentCenterScreen> createState() => _DocumentCenterScreenState();
}

class _DocumentCenterScreenState extends State<DocumentCenterScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // Mock state (replace with your data/bloc)
  final List<DocItem> _docs = [
    DocItem(type: 'Transcript', status: DocStatus.uploaded, size: '1.2 MB'),
    DocItem(type: 'Passport', status: DocStatus.missing, size: '—'),
    DocItem(type: 'Resume', status: DocStatus.uploaded, size: '380 KB'),
    DocItem(type: 'SOP', status: DocStatus.draft, size: '—'),
    DocItem(type: 'Recommendation 1', status: DocStatus.missing, size: '—'),
    DocItem(type: 'Recommendation 2', status: DocStatus.missing, size: '—'),
  ];

  // SOP builder controllers
  final _sopTitle = TextEditingController();
  final _sopIntro = TextEditingController();
  final _sopAcademic = TextEditingController();
  final _sopProjects = TextEditingController();
  final _sopGoals = TextEditingController();
  final _sopConclusion = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _sopTitle.dispose();
    _sopIntro.dispose();
    _sopAcademic.dispose();
    _sopProjects.dispose();
    _sopGoals.dispose();
    _sopConclusion.dispose();
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
          preferredSize: const Size.fromHeight(2),
          child: Container(
            alignment: Alignment.centerLeft,
            color: AppColors.white,
            child: TabBar(
              controller: _tab,
              indicatorColor: AppColors.royalBlue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                    child: Text('Documents',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('SOP Builder',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Expert Review',
                        style: AppTextStyles.displayMediumMedium12)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          DocumentsTab(
            docs: _docs,
            onUploadTap: (item) => _openUploadSheet(item),
            onCreateSop: () => _tab.animateTo(1),
          ),
          SopBuilderTab(
            title: _sopTitle,
            intro: _sopIntro,
            academic: _sopAcademic,
            projects: _sopProjects,
            goals: _sopGoals,
            conclusion: _sopConclusion,
            onPreview: _openSopPreview,
            onExport: () => _toast('SOP exported as PDF'),
          ),
          ExpertReviewTab(
            onSubmit: () => _toast('Submitted for expert review'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openUploadSheet(null),
        backgroundColor: AppColors.royalBlue,
        icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
        label: const Text('Upload',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }

  // ===== Helpers =====

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _openUploadSheet(DocItem? item) {
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
            Text(item == null ? 'Upload Document' : 'Upload – ${item.type}',
                style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height12,
            const UploadRow(label: 'Type', hint: 'e.g., Transcript / Passport'),
            AppSpacing.height8,
            const UploadRow(label: 'Notes', hint: 'Optional notes'),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Choose File',
                    onPressed: () => _toast('File picker opened'),
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Upload',
                    onPressed: () {
                      Navigator.pop(context);
                      _toast('Upload started');
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.height8,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: AppTextStyles.displaySmall500),
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }

  void _openSopPreview() {
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
              Text('SOP Preview', style: AppTextStyles.displayMediumMedium18),
              AppSpacing.height12,
              if (_sopTitle.text.trim().isNotEmpty)
                Text(_sopTitle.text, style: AppTextStyles.inter600Black16),
              AppSpacing.height8,
              SopPreviewBlock(label: 'Introduction', text: _sopIntro.text),
              SopPreviewBlock(
                  label: 'Academic Background', text: _sopAcademic.text),
              SopPreviewBlock(
                  label: 'Projects / Experience', text: _sopProjects.text),
              SopPreviewBlock(
                  label: 'Goals & Why this program', text: _sopGoals.text),
              SopPreviewBlock(label: 'Conclusion', text: _sopConclusion.text),
              AppSpacing.height12,
              CustomButton(
                width: double.infinity,
                text: 'Export PDF',
                onPressed: () {
                  Navigator.pop(context);
                  _toast('SOP exported as PDF');
                },
              ),
              AppSpacing.height8,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: AppTextStyles.displaySmall500),
              ),
              AppSpacing.height6,
            ],
          ),
        ),
      ),
    );
  }
}
