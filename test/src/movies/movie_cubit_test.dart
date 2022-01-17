import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as Mocktail;
import 'package:movie_app/domain/movies/movie.cubit.dart';
import 'package:movie_app/domain/movies/movie.model.dart';
import 'package:movie_app/domain/movies/movie.repository.dart';
import 'package:movie_app/domain/movies/movie.state.dart';

class MockRepository extends Mocktail.Mock implements MovieRepository {}

void main() {
  late MockRepository movieRepository;
  late MoviesCubit moviesCubit;

  final movies = [
    MovieModel(title: 'title 01', urlImage: 'url 01'),
    MovieModel(title: 'title 02', urlImage: 'url 02'),
  ];

  setUp(() {
    movieRepository = MockRepository();
    Mocktail.when(() => movieRepository.getMovies()).thenAnswer(
      (_) async => movies,
    );
  });

  test('Emits movies when repository answer correctly', () async {
    moviesCubit = MoviesCubit(repository: movieRepository);

    await expectLater(
      moviesCubit.stream,
      emits(
        LoadedState(movies),
      ),
    );
  });
}
