class CheckBoxItem {
  CheckBoxItem(this.name);

  //name displayed on item
  final String name;
  //is checked or not
  bool checked = true;

  //TODO maybe use function in header item not this one? because if type radio button we have a problem
  //select or deselect item
  void itemPressed(){
    checked = !checked;
  }

}
