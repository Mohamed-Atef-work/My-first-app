import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
CounterCubit() : super (CounterInitialState());

static CounterCubit get(context) => BlocProvider.of(context);

int counter = 1;

void minus ()
{
  counter--;
  emit(CounterMunsState(counter));
}

void plus ()
{
  counter++;
  emit(CounterPlusState(counter));
}

}