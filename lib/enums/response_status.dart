import 'package:equatable/equatable.dart';
import 'package:shortify/models/shortify.dart';

abstract class ResponseStatus extends Equatable {
  const ResponseStatus();

  @override
  List<Object?> get props => [];
}

class ResponseSuccess extends ResponseStatus{
  final Shortify data;
  const ResponseSuccess(this.data);

}

class ResponseFailure extends ResponseStatus {

  final String message;

  const ResponseFailure(this.message);

}