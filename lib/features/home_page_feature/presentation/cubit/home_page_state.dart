part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomePageState {
  final List<WaiterTable> restList;
  String selectedTableId;

  HomePageLoaded({
    required this.restList,
    this.selectedTableId = '',
  });

  @override
  List<Object> get props => [restList, selectedTableId];

  HomePageLoaded copyWith({
    List<WaiterTable>? restList,
    String? selectedTableId,
  }) {
    return HomePageLoaded(
      restList: restList ?? this.restList,
      selectedTableId: selectedTableId ?? this.selectedTableId,
    );
  }
}
