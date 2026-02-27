class ChangePasswordResponse {
  final bool status;
  final String message;
  final dynamic data;

  ChangePasswordResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      status: json["Status"] ?? false,
      message: json["Message"] ?? "",
      data: json["Data"],
    );
  }
}
