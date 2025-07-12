import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/empty_widget.dart';
import 'package:nuhoud/core/widgets/loading_widget.dart';
import 'package:nuhoud/core/widgets/skeletonizer_helper.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction_item.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  final ScrollController _scrollController = ScrollController();
  late final HomeCubit homeCubit;
  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    homeCubit.getJobs(loadMore: false);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!homeCubit.hasReachedMax && !homeCubit.isFetchingJobs) {
        homeCubit.getJobs(loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    homeCubit.resetFilter();
    homeCubit.getJobs(loadMore: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const SafeArea(
            child: CustomAppBar(
              title: 'نتائج البحث',
              backBtn: true,
              backgroundColor: AppColors.primaryColor,
            ),
          )),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if ((state is GetJobsLoading && state.isFirstLoading) || state is HomeInitial) {
            return SkeletonizerHelper.homeSkeletonizer();
          }
          if (state is GetJobsFailure) {
            return Center(
                child: CustomErrorWidget(
              errorMessage: state.message,
              textColor: AppColors.headingTextColor,
              onRetry: () {
                homeCubit.getJobs(loadMore: false);
              },
            ));
          }
          if (state is GetJobsSuccess && state.jobs.isEmpty) {
            return const Center(child: EmptyWidget());
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList.separated(
                itemBuilder: (context, index) {
                  return JobApplicationItem(job: homeCubit.jobs[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: homeCubit.jobs.length,
              ),
              if (!homeCubit.hasReachedMax && homeCubit.isFetchingJobs)
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
