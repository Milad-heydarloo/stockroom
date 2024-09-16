import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/listproductb.dart';
import 'package:project/Get_X/Model/order.dart';


import 'tech_event.dart';
import 'tech_state.dart';
import 'package:get/get.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final PocketBase pb;
  final String collectionName = 'order';

  String currentFilter = '';
  String currentSort = '';
  String currentSearch = '';
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  OrderBloc(this.pb) : super(OrderInitial()) {
    on<FetchOrders>(_onFetchOrders);
    on<CreateOrder>(_onCreateOrder);
    on<UpdateOrder>(_onUpdateOrder);
    on<IndetectorOrder>(_onIndetector);
    on<DeleteOrder>(_onDeleteOrder);
    on<FilterOrders>(_onFilterOrders);
    on<SortOrders>(_onSortOrders);
    on<SearchOrders>(_onSearchOrders);
    on<UpdateAllPriceAndDarsad>(_UpdateAllPrice);
    on<UpdatePriceAndDarsad>(_UpdatePrice);

    add(FetchOrders());
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _onFetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    await _fetchOrders(emit);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    await _createOrder(event.order, emit);
  }

  Future<void> _onUpdateOrder(UpdateOrder event, Emitter<OrderState> emit) async {
    await _updateOrder(event.order, emit);
  }

  Future<void> _onIndetector(IndetectorOrder event, Emitter<OrderState> emit) async {
    await updateOrderIndecator(event.orderID, event.winner, emit);
  }

  Future<void> _onDeleteOrder(DeleteOrder event, Emitter<OrderState> emit) async {
    await _deleteOrder(event.orderId, emit);
  }

  Future<void> _onFilterOrders(FilterOrders event, Emitter<OrderState> emit) async {
    currentFilter = event.filter;
    await _fetchOrders(emit);
  }

  Future<void> _onSortOrders(SortOrders event, Emitter<OrderState> emit) async {
    currentSort = event.sort;
    await _fetchOrders(emit);
  }

  Future<void> _onSearchOrders(SearchOrders event, Emitter<OrderState> emit) async {
    currentSearch = event.query;
    await _fetchOrders(emit);
  }

  Future<void> _UpdateAllPrice(UpdateAllPriceAndDarsad event, Emitter<OrderState> emit) async {

    await updateOrderDarsad_saleprice(event.ProductID,event.salePrice,event.percentText);


  }

  Future<void> _UpdatePrice(UpdatePriceAndDarsad event, Emitter<OrderState> emit) async {

    await updateOrderSaleprice_productA(event.ProductID,event.salePrice);
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> _fetchOrders(Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      // فیلتر ثابت برای type
      String filterQuery = 'type = "18zn54v3u6vfaqd"';

      // اضافه کردن فیلترهای پویا
      if (currentFilter.isNotEmpty) {
        filterQuery += ' && $currentFilter';
      }

      // اضافه کردن جستجو
      if (currentSearch.isNotEmpty) {
        if (filterQuery.isNotEmpty) {
          filterQuery += ' && ';
        }
        filterQuery += 'niyaz ~ "$currentSearch"';
      }

      int page = 1;
      List<OrderTwo> orders = [];

      while (true) {
        final resultList = await pb.collection(collectionName).getList(
          page: page,
          perPage: 50,
          filter: filterQuery.isNotEmpty ? filterQuery : null,
          sort: currentSort.isNotEmpty ? currentSort : null,
          expand: 'listproducta,listproductb',
        );

        if (resultList.items.isEmpty) {
          break;
        }

        for (var orderJson in resultList.items) {
          Map<String, dynamic> orderData = orderJson.toJson();
          List<ProductAtwo> listProductA =
              (orderData['expand']?['listproducta'] as List<dynamic>?)
                  ?.map((product) => ProductAtwo.fromJson(Map<String, dynamic>.from(product)))
                  .toList() ?? [];
          List<ProductBtwo> listProductB =
              (orderData['expand']?['listproductb'] as List<dynamic>?)
                  ?.map((product) => ProductBtwo.fromJson(Map<String, dynamic>.from(product)))
                  .toList() ?? [];
          OrderTwo order = OrderTwo.fromJson(
              Map<String, dynamic>.from(orderData), listProductA, listProductB);
          orders.add(order);
        }

        page++;
      }

      print('orders.length');
      print(orders.length);

      if (orders.isEmpty) {
        emit(OrderEmpty('اطلاعاتی پیدا نشد'));
      } else {
        emit(OrderLoaded(orders));
      }
    } catch (e) {
      emit(OrderError('خطا در دریافت اطلاعات از سرور '));
    }
  }
  final AuthController authController = Get.find<AuthController>();
//   Future<void> _fetchOrders(Emitter<OrderState> emit) async {
//     emit(OrderLoading());
//     try {
//       String filterQuery = '';
//       if (currentFilter.isNotEmpty) {
//         filterQuery = currentFilter;
//       }
//
//       if (currentSearch.isNotEmpty) {
//         if (filterQuery.isNotEmpty) {
//           filterQuery += ' && ';
//         }
//         filterQuery += 'niyaz ~ "$currentSearch"';
//       }
//
//       int page = 1;
//       List<Order> orders = [];
//
//       while (true) {
//         final resultList = await pb.collection(collectionName).getList(
//           page: page,
//           perPage: 50,
//           filter: filterQuery.isNotEmpty ? filterQuery : null,
//           sort: currentSort.isNotEmpty ? currentSort : null,
//           expand: 'listproducta,listproductb',
//         );
//
//         if (resultList.items.isEmpty) {
//           break;
//         }
//
//         for (var orderJson in resultList.items) {
//           Map<String, dynamic> orderData = orderJson.toJson();
//           List<ProductA> listProductA =
//               (orderData['expand']?['listproducta'] as List<dynamic>?)
//                   ?.map((product) => ProductA.fromJson(Map<String, dynamic>.from(product)))
//                   .toList() ?? [];
//           List<ProductB> listProductB =
//               (orderData['expand']?['listproductb'] as List<dynamic>?)
//                   ?.map((product) => ProductB.fromJson(Map<String, dynamic>.from(product)))
//                   .toList() ?? [];
//           Order order = Order.fromJson(
//               Map<String, dynamic>.from(orderData), listProductA, listProductB);
//           orders.add(order);
//         }
//
//         page++;
//       }
// print('orders.length');
// print(orders.length);
//       if (orders.isEmpty) {
//         emit(OrderEmpty('اطلاعاتی پیدا نشد'));
//       } else {
//         emit(OrderLoaded(orders));
//       }
//     } catch (e) {
//       emit(OrderError('خطا در دریافت اطلاعات از سرور '));
//     }
//   }
  Future<void> _createOrder(OrderTwo order, Emitter<OrderState> emit) async {

  final user=await  authController.getUser();
    emit(OrderLoading());

    try {
      final body = <String, dynamic>{
        "title": order.title,
        "niyaz": order.niyaz,
        "phonenumberit": order.phoneNumberIT,
        "datenow": order.dateNow,
        "datead": order.dateAd,
        "winner": '0.25',
        "callnumber": order.callNumber,
        "buy": bool.parse(order.buy!) ? 'فروش و اسمبل' : 'فروش',
        "address": order.address,
        "type": '18zn54v3u6vfaqd',
        "name": '${user!.name}',
        "family": '${user!.family}',
      };

      final record = await pb.collection(collectionName).create(body: body);
      if (record != null) {
        add(FetchOrders());
        emit(OrderSuccess('سفارش با موفقیت ثبت شد'));
      } else {
        emit(OrderError('${record.data.toString()}'));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  Future<void> _updateOrder(OrderTwo order, Emitter<OrderState> emit) async {
    final user=await  authController.getUser();
    emit(OrderLoading());
    try {
      final body = <String, dynamic>{
        "title": order.title,
        "callnumber": order.callNumber,
        "niyaz": order.niyaz,
        "phonenumberit": order.phoneNumberIT,
        "datenow": order.dateNow,
        "datead": order.dateAd,
        "buy": order.buy,
        "address": order.address,
        "winner": order.winner,
        "name": '${user!.name}',
        "family": '${user!.family}',
      };

      final record = await pb.collection(collectionName).update(order.id!, body: body);
      if (record != null) {
        add(FetchOrders());
        emit(OrderSuccess('Order updated successfully'));
      } else {
        emit(OrderError('Failed to update order.'));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  Future<void> _deleteOrder(String orderId, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final order = await pb.collection(collectionName).getOne(orderId);
      Map<String, dynamic> orderData = order.toJson();
      List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
      for (var productId in listProductAIds) {
        await pb.collection('listproducta').delete(productId.toString());
      }

      List<dynamic> listProductBIds = orderData['listproductb'] ?? [];
      for (var productId in listProductBIds) {
        await pb.collection('listproductb').delete(productId.toString());
      }

      await pb.collection('order').delete(orderId);
      add(FetchOrders());
      emit(OrderSuccess('Order deleted successfully'));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  Future<void> updateOrderIndecator(String id, String winner, Emitter<OrderState> emit) async {
    final user=await  authController.getUser();
    final body = <String, dynamic>{
      "winner": winner,
      "name": '${user!.name}',
      "family": '${user!.family}',
    };

    print('id: $id, winner: $winner');

    try {
      final RecordModel record = await pb.collection(collectionName).update(id, body: body);
      print('API Response: $record');

      if (record != null) {
        // دریافت مقدار winner از پاسخ با استفاده از toJson()
        Map<String, dynamic> recordMap = record.toJson();
        String updatedWinner = recordMap['winner'] ?? '';

        if (updatedWinner == winner) {
          print('Winner updated successfully and matches the input value.');
          emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
        } else {
          print('Winner updated successfully but does not match the input value.');
          emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
        }

        print('OrderSuccessIndetator emitted');
        add(FetchOrders());
      } else {
        emit(OrderFailureIndetator('با خطا مواجه شد'));
        print('OrderFailureIndetator error emitted');
      }
    } catch (error) {
      emit(OrderFailureIndetator('اینترنت را بررسی کنید => عدم دسترسی سرور: $error'));
      print('OrderFailureIndetator catch error emitted: $error');
    }
  }

  Future<void> updateOrderDarsad_saleprice(String id, String saleprice,String percent) async {
    // بدنه درخواست به‌روزرسانی که فقط شامل اطلاعات عنوان و شماره تلفن است
    final body = <String, dynamic>{
      "saleprice": saleprice,
      "percent": percent,
    };

    try {
      // به‌روزرسانی سفارش با استفاده از PocketBase API
      final record =
      await pb.collection('listproducta').update(id, body: body);
      if (record != null) {

      } else {
        print('Failed to update order.');
      }
    } catch (error) {
      print('Error updating order: $error');
    }
  }
  Future<void> updateOrderSaleprice_productA(String id, String saleprice) async {
    final body = <String, dynamic>{
      "saleprice": saleprice,
    };

    try {
      final record = await pb.collection('listproducta').update(id, body: body);
      if (record != null) {
        print('Order updated successfully');
      } else {
        print('Failed to update order.');
      }
    } catch (error) {
      print('Error updating order: $error');
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}


