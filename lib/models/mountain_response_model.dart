class MountainResponseModel {
  String? message;
  int? code;
  List<Data>? data;

  MountainResponseModel({this.message, this.code, this.data});

  MountainResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? nama;
  String? jenis;
  int? ketinggianMeter;
  String? lokasi;

  Data({this.nama, this.jenis, this.ketinggianMeter, this.lokasi});

  Data.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jenis = json['jenis'];
    ketinggianMeter = json['ketinggian_meter'];
    lokasi = json['lokasi'];
  }

  get imageUrl => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['jenis'] = jenis;
    data['ketinggian_meter'] = ketinggianMeter;
    data['lokasi'] = lokasi;
    return data;
  }
}
