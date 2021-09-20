import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/Job.dart';

class JobService with ReactiveServiceMixin {
  ReactiveValue<List<Job>> _jobs = ReactiveValue<List<Job>>([]);

  set jobs(List<Job> jobList) {
    _jobs.value = jobList;
  }

  List<Job> get jobs {
    return _jobs.value;
  }

  addJob(Job newJob) {
    _jobs.value.add(newJob);
  }
}
