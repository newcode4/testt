class Note {
  int _id;
  String _title;
  String _price;
  String _volume;
  String _total;
  String _description;
  String _date;
  String _monthtotal;

  Note(this._title, this._date, this._volume, this._price, this._total,this._monthtotal,
      [this._description]);

  Note.withId(
      this._id, this._title, this._date, this._volume, this._price, this._total,this._monthtotal,
      [this._description]);

  int get id => _id;

  String get title => _title;
  String get price => _price;
  String get volume => _volume;
  String get total => _total;
  String get description => _description;
  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set volume(String newVolume) {
    if (newVolume.length <= 255) {
      this._volume = newVolume;
    }
  }

  set price(String newPrice) {
    if (newPrice.length <= 255) {
      this._price = newPrice;
    }
  }

  set total(String newTotal) {
    if (newTotal.length <= 255) {
      this._total = newTotal;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['price'] = _price;
    map['volume'] = _volume;
    map['total'] = _total;
    map['description'] = _description;
    map['monthtotal'] = _monthtotal;

    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._volume = map['volume'];
    this._total = map['total'];
    this._monthtotal =map['monthtotal'];
    this._description = map['description'];
    this._date = map['date'];
  }
}
