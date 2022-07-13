import 'package:bloc/bloc.dart';

class Loading extends Cubit<bool> {
  Loading({this.loading = false}) : super(loading);

  bool loading;

  void toTrue() {
     this.loading = true;
  }

  void toFalse() {
        this.loading = true;

  }

  @override
  void onChange(Change<bool> change) {
    print(change);
    super.onChange(change);
  }
}
