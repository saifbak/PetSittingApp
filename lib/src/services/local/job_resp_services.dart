import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/JobResponse.dart';

class JobRespService with ReactiveServiceMixin {
  ReactiveValue<List<JobResp>> _jobsResp = ReactiveValue<List<JobResp>>([]);

  set jobresp(List<JobResp> jobRespList) {
    _jobsResp.value = jobRespList;
  }

  List<JobResp> get jobresp {
    return _jobsResp.value;
  }

  addJobresp(JobResp newJobResp) {
    _jobsResp.value.add(newJobResp);
  }
}
