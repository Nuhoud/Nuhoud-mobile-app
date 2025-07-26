import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/widgets/loading_widget.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction_item.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/size_app.dart';
import '../../../data/models/job_model.dart';

class JobApplication extends StatefulWidget {
  final List<JobModel> jobs;
  const JobApplication({super.key, required this.jobs});

  @override
  State<JobApplication> createState() => _JobApplicationState();
}

class _JobApplicationState extends State<JobApplication> {
  final ScrollController _scrollController = ScrollController();
  late final HomeCubit cubit;
  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!cubit.hasReachedMax && !cubit.isFetchingJobs) {
        cubit.getJobs(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: response(context, 65)),
      color: AppColors.backgroundColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              // Title Section
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "الوظائف المقترحة",
                        style: TextStyle(
                          color: AppColors.headingTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.sizeOf(context).shortestSide * 0.055,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // list Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => JobApplicationItem(
                    job: widget.jobs[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: widget.jobs.length,
                ),
              ),
              if (!cubit.hasReachedMax && cubit.isFetchingJobs)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LoadingWidget(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
