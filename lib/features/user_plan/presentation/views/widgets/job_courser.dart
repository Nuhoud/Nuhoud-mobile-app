import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/size_app.dart';
import '../../../data/models/user_plan_model.dart';
import 'job_match_card.dart';
import 'job_detials_bottom_sheet.dart';

class JobCarousel extends StatefulWidget {
  final List<Job> jobs;

  const JobCarousel({super.key, required this.jobs});

  @override
  State<JobCarousel> createState() => _JobCarouselState();
}

class _JobCarouselState extends State<JobCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showJobDetails(BuildContext context, Job job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => JobDetailsBottomSheet(job: job),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: response(context, 510),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.jobs.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final job = widget.jobs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: JobMatchCard(
                  jobTitle: job.title,
                  company: job.company,
                  matchReason: job.match,
                  matchScore: job.matchScore,
                  onReadMore: () => _showJobDetails(context, job),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.jobs.length,
            (index) => Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? AppColors.primaryColor : Colors.transparent,
                border: Border.all(
                  color: _currentIndex == index ? AppColors.primaryColor : AppColors.borderColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
