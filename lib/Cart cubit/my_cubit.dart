
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo/database/model/add_product.dart';

part 'my_state.dart';



class MyCubit extends Cubit<MyState> {
  MyCubit() : super(MyInitial());
  List<AddProductModel> cartproducts = [];
  static MyCubit get(context) =>BlocProvider.of(context);
  double TotalPrice =0.0;
  // void totalPrice(){
  //   TotalPrice =0.0;
  //   for(int i=0; i<cartproducts.length;i++){
  //     TotalPrice += double.parse(cartproducts[i].ProductPrice)*cartproducts[i].quantity;
  //   }
  //   emit(CalculatTotalPrice());
  // }
}
