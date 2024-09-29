import 'package:bloc/bloc.dart';
import 'package:firebaseproject/cubit/obsecure_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObsecureCubit extends Cubit<ObsecureState>{
  ObsecureCubit():super(InitObserveState());


 static ObsecureCubit get(context)=>BlocProvider.of(context);

 bool obsecure=true;
 changeObsecure(){
  obsecure = ! obsecure;
  emit(ChangeObsecurestate());
 }
  
}