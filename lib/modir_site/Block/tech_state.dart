
import 'package:equatable/equatable.dart';
import 'package:project/Get_X/Model/order.dart';


// Abstract class for Order states
abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoadingIndetator extends OrderState {}

class OrderFailureIndetator extends OrderState {
  final String message;

  OrderFailureIndetator(this.message);

  @override
  List<Object> get props => [message];
}

class OrderSuccessIndetator extends OrderState {
  final String message;

  OrderSuccessIndetator(this.message);

  @override
  List<Object> get props => [message];
}

class OrderLoaded extends OrderState {
  final List<OrderTwo> orders;

  OrderLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderSuccess extends OrderState {
  final String message;

  OrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderEmpty extends OrderState {
  final String message;

  OrderEmpty(this.message);

  @override
  List<Object> get props => [message];
}

// Auth states
abstract class AuthState extends OrderState {
  @override
  List<Object> get props => [];
}

class AuthInitial extends OrderState {}

class AuthLoading extends OrderState {}

class AuthAuthenticated extends OrderState {
  final Map<String, dynamic> user;

  AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends OrderState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}



// import 'model.dart';
//
// abstract class OrderState {}
//
// class OrderCreated extends OrderState {
//   final String message;
//   OrderCreated(this.message);
// }
//
// class OrderInitial extends OrderState {}
//
// class OrderLoading extends OrderState {}
//
// class OrderLoadingIndetator extends OrderState {}
//
// class OrderFailureIndetator extends OrderState {
//   final String message;
//   OrderFailureIndetator(this.message);
// }
//
// class OrderSuccessIndetator extends OrderState {
//   final String message;
//   OrderSuccessIndetator(this.message);
//   @override
//   List<Object> get props => [message];
// }
//
// class OrderLoaded extends OrderState {
//   final List<Order> orders;
//   OrderLoaded(this.orders);
// }
//
// class OrderSuccess extends OrderState {
//   final String message;
//   OrderSuccess(this.message);
// }
//
// class OrderError extends OrderState {
//   final String message;
//   OrderError(this.message);
// }
//
// class OrderEmpty extends OrderState {
//   final String message;
//   OrderEmpty(this.message);
// }
// ///////////////
//
//
//  class AuthState extends OrderState {
//   @override
//   List<Object> get props => [];
// }
//
// class AuthInitial extends OrderState {}
//
// class AuthLoading extends OrderState {}
//
// class AuthAuthenticated extends OrderState {
//   final Map<String, dynamic> user;
//
//   AuthAuthenticated(this.user);
//
//   @override
//   List<Object> get props => [user];
// }
//
// class AuthUnauthenticated extends OrderState {}
//
// class AuthFailure extends AuthState {
//   final String error;
//
//   AuthFailure(this.error);
//
//   @override
//   List<Object> get props => [error];
// }
