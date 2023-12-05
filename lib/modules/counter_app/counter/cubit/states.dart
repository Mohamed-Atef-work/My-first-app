abstract class CounterStates {}

class CounterInitialState extends CounterStates {}
class CounterPlusState extends CounterStates
{
  late final int counter;

  CounterPlusState(this.counter);
}
class CounterMunsState extends CounterStates
{
  late final int counter;

  CounterMunsState(this.counter);
}