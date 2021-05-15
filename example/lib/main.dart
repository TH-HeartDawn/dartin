import 'package:dartin/dartin.dart';
import 'dummy.dart';

const other = DartInScope('other');
const params = DartInScope('params');


final dummy1 = new Dummy(1);
final dummy2 = new Dummy(2);

final m = Module([
  single(({params}) => dummy1),
])
    ..withScope(other, [
      single<Dummy>(({params}) => dummy2)
    ])
    ..withScope(params, [
      factory<Dummy>(({params}) => Dummy(params!.get(0))),
    ]);


main() {

  startDartIn([m]);

  final value1 = inject<Dummy>();
  final value2 = inject<Dummy>(scope: other);
  final value3 = inject<Dummy>(scope: params, params: [3]);

  print(value1);
  print(value2);
  print(value3);
}