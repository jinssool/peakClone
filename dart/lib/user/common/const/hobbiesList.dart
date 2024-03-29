import 'package:flutter/material.dart';

class Category {
  String name;
  List<String> hobbies;
  Category(this.name, this.hobbies);
}

List<Category> hobbiesCategories = [
  Category('🏊‍♂️ Outdoors', [
    'Air sports',
    'Board sports',
    'Cycling',
    'Freerunning',
    'Jogging',
    'Kayaking',
    'Motor sports',
    'Mountain biking',
    'Machining',
    'Parkour',
    'Playing with a pet',
    'Photography',
    'Rock climbing',
    'Running',
    'Sailing',
    'Sand castle building',
    'Sculling or Rowing',
    'Surfing',
    'Swimming',
    'Tai chi chuan',
    'Vehicle restoration',
    'Water sports',
    'Yoga',
  ]),
  Category('🏡 Indoors', [
    'Amateur radio',
    'Audiophilia',
    'Aquarium keeping',
    'Baking',
    'Bonsai',
    'Computer programming',
    'Cooking',
    'Creative writing',
    'Dance',
    'Drawing',
    'Basketball',
    'Gardening',
    'Genealogy',
    'Home automation',
    'Jewelry making',
    'Knapping',
    'Lapidary',
    'Locksport',
    'Musical instruments',
    'Painting',
    'Knitting',
    'Scrapbooking',
    'Sculpting',
    'Sewing',
    'Singing',
    'Watching movies',
    'Watching television',
    'Woodworking',
  ]),
  Category('💎 Collections', [
    'Antiquing',
    'Art collecting',
    'Coin collecting',
    'Element collecting',
    'Stamp collecting',
    'Vintage books',
    'Vintage car',
    'Vintage clothing',
    'Record collecting',
    'Card collecting',
    'Antiquities',
    'Auto audiophilia',
    'Fossil hunting',
    'Insect collecting',
    'Leaf collecting and pressing',
    'Metal detecting',
    'Mineral collecting',
    'Petal collecting and pressing',
    'Rock collecting',
    'Seaglass collecting',
    'Seashell collecting',
  ]),
  Category('🏓 Competition Indoors', [
    'Bowling',
    'Boxing',
    'Chess',
    'Cheerleading',
    'Cubing',
    'Bridge',
    'Billiards',
    'Darts',
    'Fencing',
    'Gaming',
    'Handball',
    'Martial arts',
    'Table football',
  ]),
  Category('⚽️ Competition Outdoors', [
    'Airsoft',
    'American football',
    'Archery',
    'Association football',
    'Auto racing',
    'Badminton',
    'Baseball',
    'Basketball',
    'Climbing',
    'Cricket',
    'Cycling',
    'Disc golf',
    'Equestrianism',
    'Figure skating',
    'Fishing',
    'Footbag',
    'Golfing',
    'Gymnastics',
    'Ice hockey',
    'Kart racing',
    'Netball',
    'Paintball',
    'Planking',
    'Racquetball',
    'Rugby league football',
    'Running',
    'Shooting',
    'Squash',
    'Surfing',
    'Table tennis',
    'Tennis',
    'Volleyball',
  ]),
  Category('🔭 Observation', [
    'Audiophilia',
    'Microscopy',
    'Reading',
    'Shortwave listening',
    'Amateur astronomy',
    'Amateur geology',
    'Bird watching',
    'College football',
    'Geocaching',
    'Meteorology',
    'Parkour',
    'People watching',
    'Travel',
  ]),
];

List<String> allHobbies = hobbiesCategories[0].hobbies +
    hobbiesCategories[1].hobbies +
    hobbiesCategories[2].hobbies +
    hobbiesCategories[3].hobbies +
    hobbiesCategories[4].hobbies +
    hobbiesCategories[5].hobbies;






// List<String> outdoorHobbies = [
//   'Air sports',
//   'Board sports',
//   'Cycling',
//   'Freerunning',
//   'Jogging',
//   'Kayaking',
//   'Motor sports',
//   'Mountain biking',
//   'Machining',
//   'Parkour',
//   'Playing with a pet',
//   'Photography',
//   'Rock climbing',
//   'Running',
//   'Sailing',
//   'Sand castle building',
//   'Sculling or Rowing',
//   'Surfing',
//   'Swimming',
//   'Tai chi chuan',
//   'Vehicle restoration',
//   'Water sports',
//   'Yoga',
// ];

// List<String> indoorHobbies = [
//   'Amateur radio',
//   'Audiophilia',
//   'Aquarium keeping',
//   'Baking',
//   'Bonsai',
//   'Computer programming',
//   'Cooking',
//   'Creative writing',
//   'Dance',
//   'Drawing',
//   'Basketball',
//   'Gardening',
//   'Genealogy',
//   'Home automation',
//   'Jewelry making',
//   'Knapping',
//   'Lapidary',
//   'Locksport',
//   'Musical instruments',
//   'Painting',
//   'Knitting',
//   'Scrapbooking',
//   'Sculpting',
//   'Sewing',
//   'Singing',
//   'Watching movies',
//   'Watching television',
//   'Woodworking',
// ];

// List<String> collectionHobbies = [
//   'Antiquing',
//   'Art collecting',
//   'Coin collecting',
//   'Element collecting',
//   'Stamp collecting',
//   'Vintage books',
//   'Vintage car',
//   'Vintage clothing',
//   'Record collecting',
//   'Card collecting',
//   'Antiquities',
//   'Auto audiophilia',
//   'Fossil hunting',
//   'Insect collecting',
//   'Leaf collecting and pressing',
//   'Metal detecting',
//   'Mineral collecting',
//   'Petal collecting and pressing',
//   'Rock collecting',
//   'Seaglass collecting',
//   'Seashell collecting',
// ];

// List<String> competitionIndoorHobbies = [
//   'Bowling',
//   'Boxing',
//   'Chess',
//   'Cheerleading',
//   'Cubing',
//   'Bridge',
//   'Billiards',
//   'Darts',
//   'Fencing',
//   'Gaming',
//   'Handball',
//   'Martial arts',
//   'Table football',
// ];

// List<String> competitionOutdoorHobbies = [
//   'Airsoft',
//   'American football',
//   'Archery',
//   'Association football',
//   'Auto racing',
//   'Badminton',
//   'Baseball',
//   'Basketball',
//   'Climbing',
//   'Cricket',
//   'Cycling',
//   'Disc golf',
//   'Equestrianism',
//   'Figure skating',
//   'Fishing',
//   'Footbag',
//   'Golfing',
//   'Gymnastics',
//   'Ice hockey',
//   'Kart racing',
//   'Netball',
//   'Paintball',
//   'Planking',
//   'Racquetball',
//   'Rugby league football',
//   'Running',
//   'Shooting',
//   'Squash',
//   'Surfing',
//   'Swimming',
//   'Table tennis',
//   'Tennis',
//   'Volleyball',
// ];

// List<String> observationHobbies = [
//   'Audiophilia',
//   'Microscopy',
//   'Reading',
//   'Shortwave listening',
//   'Amateur astronomy',
//   'Amateur geology',
//   'Bird watching',
//   'College football',
//   'Geocaching',
//   'Meteorology',
//   'Parkour',
//   'People watching',
//   'Travel',
// ];
