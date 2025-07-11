class JobParams {
  final String? workPlaceType;
  final String? jobType;
  final String? jobLocation;
  final String? companyName;
  final String? experienceLevel;
  final List<String>? skillsRequired;
  final String? salaryMin;
  final String? salaryMax;
  final String? currency;
  final String? sortBy;
  final String? orderBy;
  final String? search;
  final int page;
  final int limit;
  JobParams(
      {this.workPlaceType,
      this.jobType,
      this.jobLocation,
      this.companyName,
      this.experienceLevel,
      this.skillsRequired,
      this.salaryMin,
      this.salaryMax,
      this.currency,
      this.sortBy,
      this.orderBy,
      this.search,
      required this.page,
      this.limit = 10});

  toMap() {
    final map = <String, dynamic>{};
    void addIfPresent(String key, dynamic value) {
      if (value != null && (value is! String || value.isNotEmpty)) {
        map[key] = value;
      }
    }

    addIfPresent('workPlaceType', workPlaceType);
    addIfPresent('jobType', jobType);
    addIfPresent('jobLocation', jobLocation);
    addIfPresent('companyName', companyName);
    addIfPresent('experienceLevel', experienceLevel);
    addIfPresent('salaryMin', salaryMin);
    addIfPresent('salaryMax', salaryMax);
    addIfPresent('currency', currency);
    addIfPresent('sortBy', sortBy);
    addIfPresent('orderBy', orderBy);
    addIfPresent('q', search);
    addIfPresent('page', page);
    addIfPresent('limit', limit);
    if (skillsRequired != null && skillsRequired!.isNotEmpty) {
      map['skillsRequired'] = skillsRequired;
    }
    return map;
  }
}
