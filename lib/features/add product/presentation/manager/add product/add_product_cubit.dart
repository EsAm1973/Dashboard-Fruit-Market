import 'package:bloc/bloc.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo.dart';
import 'package:fruit_market_dashboard/features/add%20product/domain/entities/add_product_input_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.imagesRepo, this.productsRepo)
    : super(AddProductInitial());

  final ImageRepo imagesRepo;
  final ProductRepo productsRepo;

  Future<void> addProduct(AddProductInputEntity addProductInputEntity) async {
    emit(AddProductLoading());
    var result = await imagesRepo.uploadImage(addProductInputEntity.fileImage);
    result.fold(
      (f) {
        emit(AddProductError(error: f.message));
      },
      (url) async {
        addProductInputEntity.imageUrl = url;
        var result = await productsRepo.addProduct(addProductInputEntity);
        result.fold(
          (f) {
            emit(AddProductError(error: f.message));
          },
          (r) {
            emit(AddProductSuccess());
          },
        );
      },
    );
  }
}
