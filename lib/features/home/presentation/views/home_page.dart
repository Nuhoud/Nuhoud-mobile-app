import 'package:flutter/material.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction.dart';

import '../../../../core/utils/assets_data.dart';
import '../../data/models/job_model.dart';
import 'widgets/custom_home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<JobModel> jobs = [
      JobModel(
        name: 'مدير الموارد البشرية',
        image: AssetsData.logo,
        company: 'نهوض',
        location: 'دمشق',
        salary: '2500\$/شهرياً',
        type: 'دوام كامل / في المكتب',
        experience: '2 سنوات',
        jobDescription:
            'نبحث عن مدير موارد بشرية متحمس للانضمام إلى فريقنا. سيكون مسؤولاً عن إدارة جميع جوانب الموارد البشرية بما في ذلك التوظيف، تطوير الموظفين، علاقات الموظفين، وحزم التعويضات والمزايا. يجب أن يكون لديه فهم قوي للقوانين المحلية للعمل وأن يكون قادراً على إنشاء سياسات تلبي احتياجات الشركة.',
        jobRequirements: '''
- درجة البكالوريوس في إدارة الأعمال أو مجال ذي صلة
- خبرة لا تقل عن سنتين في إدارة الموارد البشرية
- معرفة عميقة بقوانين العمل السورية
- مهارات اتصال وتفاوض ممتازة
- إجادة استخدام برامج Microsoft Office
- القدرة على التعامل مع المعلومات السرية بحساسية
''',
        jobResponsibilities: '''
- إدارة عملية التوظيف والمقابلات
- تطوير وتنفيذ سياسات الموارد البشرية
- معالجة استفسارات الموظفين وشكاواهم
- تنظيم برامج التدريب والتطوير
- إدارة ملف الرواتب والمزايا
- ضمان الامتثال لجميع القوانين واللوائح
''',
      ),
      JobModel(
        name: 'مدير المبيعات',
        image: AssetsData.logo,
        company: 'نهوض',
        location: 'دمشق',
        salary: '5000\$/شهرياً',
        type: 'دوام كامل / في المكتب',
        experience: '2 سنوات',
        jobDescription:
            'نبحث عن مدير مبيعات ديناميكي لقيادة فريق المبيعات لدينا وتحقيق الأهداف المالية للشركة. سيكون مسؤولاً عن تطوير استراتيجيات المبيعات، إدارة فريق المبيعات، بناء العلاقات مع العملاء، وتحقيق أهداف الإيرادات.',
        jobRequirements: '''
- درجة البكالوريوس في التسويق أو إدارة الأعمال
- خبرة لا تقل عن سنتين في مجال المبيعات
- مهارات قيادية وقدرة على تحفيز الفريق
- معرفة بالسوق المحلي والمنافسين
- القدرة على تحليل البيانات واتخاذ القرارات
- إجادة اللغة الإنجليزية والعربية
''',
        jobResponsibilities: '''
- وضع أهداف المبيعات واستراتيجيات تحقيقها
- إدارة وتدريب فريق المبيعات
- متابعة أداء المبيعات وإعداد التقارير
- بناء علاقات قوية مع العملاء الرئيسيين
- المشاركة في المفاوضات والعقود الكبيرة
- تحليل اتجاهات السوق وتحديد فرص النمو
''',
      ),
    ];
    return Scaffold(
      appBar:
          CustomHomeAppBar(height: MediaQuery.sizeOf(context).height * 0.13),
      body: SafeArea(
        child: JobApplication(jobs: jobs),
      ),
    );
  }
}
