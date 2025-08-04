
import 'package:bloc/bloc.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ImageRepo imageRepo;
  final ProductRepo productRepo;
  AddProductCubit(this.imageRepo, this.productRepo)
    : super(AddProductInitial());

  Future<void> addProduct(AddProductInputEntity addProductInputEntity) async {
    emit(AddProductLoading());
    var result=await imageRepo.uploadImage(addProductInputEntity.fileImage);
    result.fold((ifLeft) => emit(AddProductError(error: ifLeft.message)), (ifRight) {
      addProductInputEntity.imageUrl=ifRight;
      productRepo.addProduct(addProductInputEntity).then((value) => value.fold((ifLeft) => emit(AddProductError(error: ifLeft.message)), (ifRight) => emit(AddProductSuccess())));  
    });
  }
}
