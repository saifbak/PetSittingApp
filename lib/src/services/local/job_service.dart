import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/Job.dart';

class JobService with ReactiveServiceMixin {
  ReactiveValue<List<Job>> _jobs = ReactiveValue<List<Job>>([]);
  ReactiveValue<Map<String, dynamic>> _selectedJobProposal =
      ReactiveValue<Map<String, dynamic>>(
    {'petsitter': {}, 'job': {}, 'price': null, 'description': null},
  );
  ReactiveValue<Map<String, dynamic>> _selectedAprrovedJobProposal =
      ReactiveValue<Map<String, dynamic>>(
    {'petsitter': {}, 'job': {}, 'price': null, 'description': null},
  );

  set jobs(List<Job> jobList) {
    _jobs.value = jobList;
  }

  List<Job> get jobs {
    return _jobs.value;
  }

  addJob(Job newJob) {
    _jobs.value.add(newJob);
  }

  set selectedJobProposal(Map<String, dynamic> val) {
    _selectedJobProposal.value = val;
  }

  set selectedaApprovedJobProposal(Map<String, dynamic> val) {
    _selectedAprrovedJobProposal.value = val;
  }

  Map<String, dynamic> get selectedJobProposal {
    return _selectedJobProposal.value;
  }

  Map<String, dynamic> get selectedaApprovedJobProposal {
    print(_selectedAprrovedJobProposal.value);
    return _selectedAprrovedJobProposal.value;
  }
}
