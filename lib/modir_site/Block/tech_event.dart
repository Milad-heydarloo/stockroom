
import 'package:equatable/equatable.dart';
import 'package:project/Get_X/Model/order.dart';


// Abstract class for Order events
abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final OrderTwo order;

  CreateOrder(this.order);

  @override
  List<Object> get props => [order];
}

class UpdateOrder extends OrderEvent {
  final OrderTwo order;

  UpdateOrder(this.order);

  @override
  List<Object> get props => [order];
}

class IndetectorOrder extends OrderEvent {
  final String winner;
  final String orderID;

  IndetectorOrder(this.orderID, this.winner);

  @override
  List<Object> get props => [orderID, winner];
}

class UpdateAllPriceAndDarsad extends OrderEvent {
  final String ProductID;
  final String salePrice;
  final String percentText;

  UpdateAllPriceAndDarsad(this.ProductID, this.salePrice, this.percentText);

  @override
  List<Object> get props => [ProductID, salePrice, percentText];
}

class UpdatePriceAndDarsad extends OrderEvent {
  final String ProductID;
  final String salePrice;

  UpdatePriceAndDarsad(this.ProductID, this.salePrice);

  @override
  List<Object> get props => [ProductID, salePrice];
}

class DeleteOrder extends OrderEvent {
  final String orderId;

  DeleteOrder(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class FilterOrders extends OrderEvent {
  final String filter;

  FilterOrders(this.filter);

  @override
  List<Object> get props => [filter];
}

class SortOrders extends OrderEvent {
  final String sort;

  SortOrders(this.sort);

  @override
  List<Object> get props => [sort];
}

class SearchOrders extends OrderEvent {
  final String query;

  SearchOrders(this.query);

  @override
  List<Object> get props => [query];
}

// Auth events
abstract class AuthEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class AppStarted extends OrderEvent {}

class LoggedIn extends OrderEvent {
  final String email;
  final String password;

  LoggedIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LoggedOut extends OrderEvent {}





// import 'package:equatable/equatable.dart';
// import 'model.dart';
//
// abstract class OrderEvent extends Equatable {
//   const OrderEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FetchOrders extends OrderEvent {}
//
// class CreateOrder extends OrderEvent {
//   final Order order;
//
//   CreateOrder(this.order);
//
//   @override
//   List<Object> get props => [order];
// }
//
// class UpdateOrder extends OrderEvent {
//   final Order order;
//
//   UpdateOrder(this.order);
//
//   @override
//   List<Object> get props => [order];
// }
//
// class IndetectorOrder extends OrderEvent {
//   final String winner;
//   final String orderID;
//
//   IndetectorOrder(this.orderID, this.winner);
//
//   @override
//   List<Object> get props => [orderID, winner];
// }
//
// class UpdateAllPriceAndDarsad extends OrderEvent {
//   final String ProductID;
//   final String salePrice;
//   final String percentText;
//
//   UpdateAllPriceAndDarsad(this.ProductID, this.salePrice, this.percentText);
//
//   @override
//   List<Object> get props => [ProductID, salePrice, percentText];
// }
//
// class UpdatePriceAndDarsad extends OrderEvent {
//   final String ProductID;
//   final String salePrice;
//
//   UpdatePriceAndDarsad(this.ProductID, this.salePrice);
//
//   @override
//   List<Object> get props => [ProductID, salePrice];
// }
//
// class DeleteOrder extends OrderEvent {
//   final String orderId;
//
//   DeleteOrder(this.orderId);
//
//   @override
//   List<Object> get props => [orderId];
// }
//
// class FilterOrders extends OrderEvent {
//   final String filter;
//
//   FilterOrders(this.filter);
//
//   @override
//   List<Object> get props => [filter];
// }
//
// class SortOrders extends OrderEvent {
//   final String sort;
//
//   SortOrders(this.sort);
//
//   @override
//   List<Object> get props => [sort];
// }
//
// class SearchOrders extends OrderEvent {
//   final String query;
//
//   SearchOrders(this.query);
//
//   @override
//   List<Object> get props => [query];
// }
//  class AuthEvent extends OrderEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class AppStarted extends OrderEvent {}
//
// class LoggedIn extends OrderEvent {
//   final String email;
//   final String password;
//
//   LoggedIn(this.email, this.password);
//
//   @override
//   List<Object> get props => [email, password];
// }
//
// class LoggedOut extends OrderEvent {}
