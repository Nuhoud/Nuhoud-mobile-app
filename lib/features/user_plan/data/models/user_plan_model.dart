class UserPlanModel {
  final Step1 step1;
  final Step2 step2;

  UserPlanModel({required this.step1, required this.step2});

  factory UserPlanModel.fromJson(Map<String, dynamic> json) {
    return UserPlanModel(
      step1: Step1.fromJson(json['step1']),
      step2: Step2.fromJson(json['step2']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step1': step1.toJson(),
      'step2': step2.toJson(),
    };
  }
}

class Step1 {
  final List<Job> jobs;

  Step1({required this.jobs});

  factory Step1.fromJson(Map<String, dynamic> json) {
    var jobsList = json['jobs'] as List;
    List<Job> jobs = jobsList.map((job) => Job.fromJson(job)).toList();

    return Step1(
      jobs: jobs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobs': jobs.map((job) => job.toJson()).toList(),
    };
  }
}

class Job {
  final String id;
  final String title;
  final String company;
  final String match;
  final int matchScore;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.match,
    required this.matchScore,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      company: json['company'],
      match: json['match'],
      matchScore: json['matchScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'company': company,
      'match': match,
      'matchScore': matchScore,
    };
  }
}

class Step2 {
  final List<Month> months;

  Step2({required this.months});

  factory Step2.fromJson(Map<String, dynamic> json) {
    var monthsList = json['months'] as List;
    List<Month> months =
        monthsList.map((month) => Month.fromJson(month)).toList();

    return Step2(
      months: months,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'months': months.map((month) => month.toJson()).toList(),
    };
  }
}

class Month {
  final String month;
  final List<WeekTasks> tasks;

  Month({required this.month, required this.tasks});

  factory Month.fromJson(Map<String, dynamic> json) {
    var tasksList = json['tasks'] as List;
    List<WeekTasks> tasks =
        tasksList.map((task) => WeekTasks.fromJson(task)).toList();

    return Month(
      month: json['month'],
      tasks: tasks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }
}

class WeekTasks {
  final int week;
  final List<String> tasks;

  WeekTasks({required this.week, required this.tasks});

  factory WeekTasks.fromJson(Map<String, dynamic> json) {
    var tasksList = json['tasks'] as List;
    List<String> tasks = tasksList.map((task) => task.toString()).toList();

    return WeekTasks(
      week: json['week'],
      tasks: tasks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'tasks': tasks,
    };
  }
}
