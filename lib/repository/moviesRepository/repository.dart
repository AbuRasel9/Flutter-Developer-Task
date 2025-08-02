
import 'package:bloc_clean_architecture/config/utils/api_url.dart';
import 'package:bloc_clean_architecture/data/network/base_api_services.dart';
import 'package:bloc_clean_architecture/model/moviesModel/movies_model.dart';
import 'package:bloc_clean_architecture/repository/moviesRepository/repository_impl.dart';
import 'package:bloc_clean_architecture/services/diServices/injection.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MovieRepository)
class repository extends MovieRepository{
  @override
  Future<Model> getMovieList() async {
   final response=await _api.getRequest(ApiUrl.movieApi);
   return Model.fromJson(response);

  }






}