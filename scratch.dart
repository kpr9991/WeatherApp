import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2data=await task2();
  print(task2());
  task3(task2data);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2()  async{
  Duration seconds=Duration(seconds: 4);
  String res;
  await Future.delayed(seconds,()
  {
    res = 'task 2 data';
    print('Task 2 complete');      //content inside the future method is the only one that is done asynchronously and remaining all the processess outside this future are done synchronously.
  });
  return res;
}

void task3(String task2data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2data');
}