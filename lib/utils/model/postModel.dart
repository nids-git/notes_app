class PostModel {
  String? tab1;
  String? tab2;
  List<String>? item1;
  List<String>? item2;

  PostModel({this.tab1, this.tab2, this.item1, this.item2});

  PostModel.fromJson(Map<String, dynamic> json) {
    tab1 = json['tab1'];
    tab2 = json['tab2'];
    item1 = json['item1'].cast<String>();
    item2 = json['item2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tab1'] = this.tab1;
    data['tab2'] = this.tab2;
    data['item1'] = this.item1;
    data['item2'] = this.item2;
    return data;
  }
}