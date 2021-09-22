import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class MyEmployeesViewModel extends BaseViewModel {
  List<String> get weekDaysSequence => ['01-08', '08-15', '15-22', '22-30'];

  List<PetSitter> get petSittersList => [
        PetSitter('Ralph Edwards', 'Houston', 'assets/images/profile_pic.jpg',
            10, '20'),
        PetSitter('Ralph Edwards', 'Houston', 'assets/images/profile_pic.jpg',
            5, '15'),
        PetSitter('Ralph Edwards', 'Houston', 'assets/images/profile_pic.jpg',
            3, '10'),
        PetSitter('Ralph Edwards', 'Houston', 'assets/images/profile_pic.jpg',
            9, '12'),
      ];
}
