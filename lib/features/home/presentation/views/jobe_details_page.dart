import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/job_model.dart';
import 'widgets/custom_job_details_appbar.dart';

class JobDetailsPage extends StatefulWidget {
  final JobModel job;

  const JobDetailsPage({super.key, required this.job});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final Map<String, bool> _expandedSections = {
    'description': false,
    'requirements': false,
    'responsibilities': false,
  };
  String _getDeadlineText(int days) {
    if (days == 0) return "ينتهي اليوم";
    if (days == 1) return "يوم واحد";
    return "$days أيام";
  }

  Color _getDeadlineBackgroundColor(int days) {
    if (days == 0) return Colors.red[100]!;
    if (days <= 2) return Colors.orange[100]!;
    return const Color.fromARGB(255, 162, 250, 167);
  }

  Color _getDeadlineTextColor(int days) {
    if (days == 0) return Colors.red[800]!;
    if (days <= 2) return Colors.orange[800]!;
    return AppColors.subHeadingTextColor;
  }

  String getCurrencyArabic(String currency) {
    if (currency == "USD") return "دولار";
    if (currency == "SAR") return "ريال";
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: customAppBar(
          text: "",
          onPressed: () {
            Navigator.pop(context);
          },
          context: context,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Job Title & Company
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.job.companyName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.subHeadingTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "نظرة عامة على الوظيفة",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: response(context, 45),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _DetailChip(
                          icon: Icons.location_on_outlined,
                          text: widget.job.jobLocation,
                        ),
                        const SizedBox(width: 10),
                        // Updated salary chip
                        _DetailChip(
                          icon: Icons.attach_money_outlined,
                          text:
                              "${widget.job.salaryRange.min}-${widget.job.salaryRange.max} ${getCurrencyArabic(widget.job.salaryRange.currency)}",
                        ),
                        const SizedBox(width: 10),
                        _DetailChip(
                          icon: Icons.workspaces_outline,
                          text: widget.job.experienceLevel,
                        ),
                        const SizedBox(width: 10),
                        _DetailChip(
                          icon: Icons.business_center_outlined,
                          text: widget.job.jobType,
                        ),
                        const SizedBox(width: 10),
                        _DetailChip(
                          icon: Icons.business_outlined,
                          text: widget.job.workPlaceType,
                        ),
                      ],
                    ),
                  ),
                ),

                // Deadline chip
                if (widget.job.daysRemaining >= 0) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getDeadlineBackgroundColor(widget.job.daysRemaining),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: _getDeadlineTextColor(widget.job.daysRemaining),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _getDeadlineText(widget.job.daysRemaining),
                            style: TextStyle(
                              color: _getDeadlineTextColor(widget.job.daysRemaining),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),

                // Description Section
                _buildExpandableSection(
                  title: "وصف العمل",
                  content: widget.job.description,
                  key: 'description',
                ),

                // Requirements Section
                _buildExpandableSection(
                  title: "متطلبات العمل",
                  content: widget.job.requirements.join(", "),
                  key: 'requirements',
                ),

                // Responsibilities Section
                _buildExpandableSection(
                  title: "المسؤوليات",
                  content: widget.job.skillsRequired.join(", "),
                  key: 'responsibilities',
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<ApplictionCubit, ApplictionState>(
          listener: (context, state) {
            if (state is SubmitApplictionError) {
              CustomSnackBar.showSnackBar(
                  context: context, title: "خطأ", message: state.message, contentType: ContentType.failure);
            }
            if (state is SubmitApplictionSuccess) {
              CustomSnackBar.showSnackBar(
                  context: context, title: "نجاح", message: "تم تقديم طلبك بنجاح", contentType: ContentType.success);
            }
          },
          builder: (context, state) {
            return CustomButton(
              isLoading: state is SubmitApplictionLoading,
              onPressed: () {
                context.read<ApplictionCubit>().submitOffer(
                      OfferParams(
                        title: widget.job.title,
                        employerId: widget.job.employerId,
                        companyName: widget.job.companyName,
                      ),
                      widget.job.id,
                    );
              },
              child: const Text(
                "تقدم على العمل",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ));
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
    required String key,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
            ),
          ),
          const SizedBox(height: 12),
          ExpandableText(
            text: content,
            isExpanded: _expandedSections[key]!,
            maxLines: 3,
            onTap: () => setState(() {
              _expandedSections[key] = !_expandedSections[key]!;
            }),
          ),
        ],
      ),
    );
  }
}

// Expandable Text Widget
class ExpandableText extends StatefulWidget {
  final String text;
  final bool isExpanded;
  final int maxLines;
  final VoidCallback onTap;

  const ExpandableText({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.maxLines,
    required this.onTap,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.subHeadingTextColor,
            height: 1.5,
          ),
          maxLines: widget.isExpanded ? null : widget.maxLines,
          overflow: widget.isExpanded ? null : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.isExpanded ? "قراءة أقل" : "قراءة المزيد",
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// Detail Chip Widget
class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.headingTextColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
