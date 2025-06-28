import 'data.dart';

class BestSeller {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BestSeller({this.data, this.message, this.error, this.status});

  factory BestSeller.fromJson(Map<String, dynamic> json) => BestSeller(
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String?,
    error: json['error'] as List<dynamic>?,
    status: json['status'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'message': message,
    'error': error,
    'status': status,
  };
}
