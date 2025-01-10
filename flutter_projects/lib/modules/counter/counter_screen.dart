// import 'package:first_project/modules/counter/cubit/cubit.dart';
// import 'package:first_project/modules/counter/cubit/states.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CounterScreen extends StatelessWidget
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return BlocProvider(
//       create: (BuildContext) => CounterCubit(),
//       child: BlocConsumer<CounterCubit , CounterStates>(
//         listener: (context , state)
//         {
//           if(state is CounterPlusState) print('We are in Plus State ${state.counter}');
//           if(state is CounterMinusState) print('We are in Minus State ${state.counter}');
//         },
//         builder: (context , state)
//         {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Counter',
//               ),
//             ),
//             body: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(onPressed:()
//                   {
//                     CounterCubit.get(context).minus();
//                   } ,
//                     child: Text(
//                       'Minus',
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       '${CounterCubit.get(context).counter}',
//                       style: TextStyle(
//                           fontSize: 20
//                       ),
//                     ),
//                   ),
//                   TextButton(onPressed:()
//                   {
//                     CounterCubit.get(context).plus();
//                   } ,
//                     child: Text(
//                       'Plus',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
