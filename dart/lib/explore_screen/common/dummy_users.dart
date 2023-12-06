class DummyUsers {
  String name;
  Map<String, String> location = {};
  String userImage;
  DummyUsers({
    required this.name,
    required this.location,
    required this.userImage,
  });
}

List<DummyUsers> otherUsersData = [
  DummyUsers(
    name: "John Doe",
    location: {'latitude': "37.423070", 'longitude': "-122.084143"},
    userImage:
        "https://cdn.pixabay.com/photo/2018/04/27/03/50/portrait-3353699_1280.jpg",
  ),
  DummyUsers(
    name: "John Louis",
    location: {'latitude': "27.672572", 'longitude': "85.431990"},
    userImage:
        "https://cdn.pixabay.com/photo/2018/04/27/03/50/portrait-3353699_1280.jpg",
  ),
  DummyUsers(
    name: "Zayden Cruz",
    location: {'latitude': "27.674044", 'longitude': "85.372254"},
    userImage:
        "https://cdn.pixabay.com/photo/2016/11/29/05/11/adult-1867471_1280.jpg",
  ),
  DummyUsers(
    name: "Johnson",
    location: {'latitude': "27.670183", 'longitude': "85.437671"},
    userImage:
        "https://cdn.pixabay.com/photo/2020/12/16/04/15/man-5835659_1280.jpg",
  ),
  DummyUsers(
    name: "Steven",
    location: {'latitude': '27.670183', 'longitude': '85.43781'},
    userImage:
        "https://cdn.pixabay.com/photo/2019/10/22/13/43/man-4568761_1280.jpg",
  ),
  DummyUsers(
    name: "Hari",
    location: {'latitude': '27.670183', 'longitude': '85.4376'},
    userImage:
        "https://cdn.pixabay.com/photo/2020/12/16/04/15/man-5835659_1280.jpg",
  ),
  DummyUsers(
    name: "John",
    location: {'latitude': '27.661693', 'longitude': '85.342379'},
    userImage:
        "https://cdn.pixabay.com/photo/2020/12/16/04/15/man-5835659_1280.jpg",
  ),
  DummyUsers(
    name: "Tom cruise",
    location: {'latitude': '27.661693', 'longitude': '85.342379'},
    userImage:
        "https://cdn.pixabay.com/photo/2020/12/16/04/15/man-5835659_1280.jpg",
  ),
];
