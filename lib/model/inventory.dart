class Inventory {
  int? id;
  double? receivedMcQty;
  double? onHandMcQty;
  double? preFulfilledMcQty;
  double? fulfilledMcQty;
  double? receivedUnitQty;
  double? onHandUnitQty;
  double? preFulfilledUnitQty;
  double? fulfilledUnitQty;

  Inventory(
      {this.id,
        this.receivedMcQty,
        this.onHandMcQty,
        this.preFulfilledMcQty,
        this.fulfilledMcQty,
        this.receivedUnitQty,
        this.onHandUnitQty,
        this.preFulfilledUnitQty,
        this.fulfilledUnitQty});

  Inventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receivedMcQty = json['receivedMcQty'];
    onHandMcQty = json['onHandMcQty'];
    preFulfilledMcQty = json['preFulfilledMcQty'];
    fulfilledMcQty = json['fulfilledMcQty'];
    receivedUnitQty = json['receivedUnitQty'];
    onHandUnitQty = json['onHandUnitQty'];
    preFulfilledUnitQty = json['preFulfilledUnitQty'];
    fulfilledUnitQty = json['fulfilledUnitQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receivedMcQty'] = this.receivedMcQty;
    data['onHandMcQty'] = this.onHandMcQty;
    data['preFulfilledMcQty'] = this.preFulfilledMcQty;
    data['fulfilledMcQty'] = this.fulfilledMcQty;
    data['receivedUnitQty'] = this.receivedUnitQty;
    data['onHandUnitQty'] = this.onHandUnitQty;
    data['preFulfilledUnitQty'] = this.preFulfilledUnitQty;
    data['fulfilledUnitQty'] = this.fulfilledUnitQty;
    return data;
  }
}