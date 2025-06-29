import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';

import '../../../../core/utils/size_app.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/development_plan.dart';
import 'widgets/job_courser.dart';

class UserPlanPage extends StatefulWidget {
  const UserPlanPage({super.key});

  @override
  State<UserPlanPage> createState() => _UserPlanPageState();
}

class _UserPlanPageState extends State<UserPlanPage> {
  int _currentStep = 0;

  final fakeUserPlan = UserPlanModel(
    step1: Step1(
      jobs: [
        Job(
          id: 'job1',
          title: 'مهندس برمجيات',
          company: 'شركة التقنية الحديثة',
          match:
              'هذه الوظيفة مناسبة لأن لديك خبرة قوية في تطوير التطبيقات باستخدام Flutter، بالإضافة إلى أن الشركة تعمل في مشاريع دولية مما يجعل لغتك الإنجليزية ميزة إضافية.',
          matchScore: 90,
        ),
        Job(
          id: 'job2',
          title: 'مدير مشروع',
          company: 'المؤسسة الدولية',
          match:
              'يتوافق هذا الدور مع خبرتك السابقة في إدارة فرق العمل وتنظيم المشاريع. كما أن المؤسسة لها حضور عالمي مما يفتح لك فرص سفر وتواصل مع عملاء دوليين.',
          matchScore: 80,
        ),
        Job(
          id: 'job3',
          title: 'محلل نظم',
          company: 'مجموعة الحلول الذكية',
          match:
              'تتطابق هذه الفرصة مع مهاراتك التحليلية وقدرتك على فهم متطلبات الأنظمة وتعاملاتك السابقة مع قواعد البيانات الكبيرة، وهي فرصة جيدة لتطوير مهاراتك في مجال التحليل.',
          matchScore: 70,
        ),
      ],
    ),
    step2: Step2(
      months: [
        Month(
          month: 'يوليو',
          tasks: [
            WeekTasks(
              week: 1,
              tasks: [
                'تحديث السيرة الذاتية لتتضمن أحدث المهارات.',
                'كتابة رسالة تعريفية مخصصة لكل وظيفة.',
                'تقديم طلبات التوظيف لعدد ٥ وظائف مختلفة.',
              ],
            ),
            WeekTasks(
              week: 2,
              tasks: [
                'التحضير للإجابة على الأسئلة التقنية للمقابلات.',
                'إجراء مقابلة تجريبية مع صديق أو مرشد مهني.',
                'تقييم نقاط القوة والضعف بعد المقابلات التجريبية.',
              ],
            ),
            WeekTasks(
              week: 3,
              tasks: [
                'توسيع البحث عن شركات مناسبة.',
                'إرسال طلبات توظيف لشركات ناشئة.',
                'متابعة الطلبات المقدمة والتأكد من وصولها.',
              ],
            ),
            WeekTasks(
              week: 4,
              tasks: [
                'حضور ندوة أو ورشة عمل عن مهارات المقابلة.',
                'بناء شبكة علاقات مهنية عبر LinkedIn.',
              ],
            ),
          ],
        ),
        Month(
          month: 'أغسطس',
          tasks: [
            WeekTasks(
              week: 1,
              tasks: [
                'المشاركة في فعالية توظيف محلية.',
                'إرسال رسائل متابعة للشركات التي تم التقديم لها.',
              ],
            ),
            WeekTasks(
              week: 2,
              tasks: [
                'مراجعة العروض الوظيفية المتاحة.',
                'التفاوض على بنود الراتب والمزايا.',
                'استشارة مرشد مهني قبل توقيع العقد.',
              ],
            ),
            WeekTasks(
              week: 3,
              tasks: [
                'تأكيد قبول العرض الوظيفي.',
                'إبلاغ بقية الشركات بالقرار النهائي.',
              ],
            ),
            WeekTasks(
              week: 4,
              tasks: [
                'التحضير لبدء العمل الجديد.',
                'كتابة خطة للأهداف خلال أول ٣ أشهر.',
              ],
            ),
          ],
        ),
      ],
    ),
  );

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('الخطوة الأولى: الوظائف المقترحة',
            style: Styles.textStyle18.copyWith(
              color: _currentStep == 0
                  ? AppColors.primaryColor
                  : AppColors.subHeadingTextColor,
              fontWeight: FontWeight.bold,
            )),
        content: JobCarousel(jobs: fakeUserPlan.step1.jobs),
        isActive: _currentStep == 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('الخطوة الثانية: خطة التطوير',
            style: Styles.textStyle18.copyWith(
              color: _currentStep == 1
                  ? AppColors.primaryColor
                  : AppColors.subHeadingTextColor,
              fontWeight: FontWeight.bold,
            )),
        content: DevelopmentPlan(months: fakeUserPlan.step2.months),
        isActive: _currentStep == 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const CustomAppBar(
            title: 'خطة التطوير',
            backBtn: false,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
        body: Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primaryColor,
                ),
            unselectedWidgetColor: AppColors.borderColor,
          ),
          child: Stepper(
            currentStep: _currentStep,
            onStepTapped: (step) => setState(() => _currentStep = step),
            steps: _buildSteps(),
            controlsBuilder: (context, details) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
