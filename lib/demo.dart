// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// void main() async {
//   // var callApi = await fetchPosts();
//   // var l=[];
//   // for(var a=0; a<callApi.length;a++){
//   //   l.add(callApi[a]['id']);
//   //   l.shuffle();
//   // }
//   // print(l);
// }
//
// Future<List<dynamic>> fetchPosts() async {
//
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=15'));
//
//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.toList();
//   } else {
//     throw Exception('Failed to load posts');
//   }
// }

// void palindrome() {
//   var arr = [];
//   for (var i = 1; i <= 100; i++) {
//     var num = i;
//     var result = 0;
//     var temp = num;
//     while (num != 0) {
//       var rem = num % 10;
//       result = result * 10 + rem;
//       num ~/= 10;
//     }
//     if (result == temp) {
//       arr.add('$temp is palindrome.');
//     }
//   }
//   print(arr);
// }
//
// void main() {
//   palindrome();
// }

// void minMax(List<int> arr) {
//   var max = arr[0];
//   var min = arr[0];
//
//   for (var i = 1; i < arr.length; i++) {
//     if (arr[i] > max) {
//       max = arr[i];
//     }
//   }
//   for (var i = 1; i < arr.length; i++) {
//     if (arr[i] < min) {
//       min = arr[i];
//     }
//   }
//
//   print('Max number: $max');
//   print('Min number: $min');
// }
//
// void main() {
//   var arr = [15, 12, -13, 27, 5, 18];
//   minMax(arr);
// }

// void main() {
//   var list = [153, 371, 245, 313, 49];
//   print(armstrong(list));
// }
//
// List<int> armstrong(List<int> a) {
//   var empty = <int>[];
//
//   for (var num in a) {
//     var org = num;
//     var result = 0;
//
//     while (num != 0) {
//       var rem = num % 10;
//       result += rem*rem*rem;
//       num ~/= 10;
//     }
//
//     if (result == org) {
//       empty.add(org);
//     }
//   }
//   return empty;
// }

// void main() {
//   var q = [12, 15, -13, 18, 19, -5, 13];
//   print(ascending(q,'assending'));
// }
//
// List<dynamic> ascending(List<dynamic> aa,String type) {
//   var empty=['dont pass any charter'];
//
//   for (var i = 0; i < aa.length; i++) {
//     for (var j = i + 1; j < aa.length; j++) {
//
//       if(type=='assending'){
//       if (aa[i] > aa[j]) {
//         var temp = aa[i];
//         aa[i] = aa[j];
//         aa[j] = temp;
//       }}
//       else if(type=='dessending'){
//       if (aa[i] < aa[j]) {
//         var temp = aa[i];
//         aa[i] = aa[j];
//         aa[j] = temp;
//       }
//       }
//       else{
//         return empty;
//       }
//     }
//   }
//
//   return aa;
// }

// List<dynamic> findDuplicates({required List<dynamic> arr}) {
//   List<dynamic> duplicates = [];
//
//
//   for(int i=0; i<arr.length; i++){
//     for(int j=i+1; j<arr.length; j++){
//       if(arr[i]==arr[j] && !duplicates.contains(arr[i])){
//         duplicates.add(arr[i]);
//       }
//     }
//   }
//
//   return duplicates;
// }
//
// void main() {
//   List<dynamic> arr1 = [13, 17, 19, 212, 12, 11, 13, 7, 19, 2];
//   print("Duplicate values: ${findDuplicates(arr: arr1)}");
// }

// 1 name show accenting and descending use fun
// List<String> sortStores(List<String> stores, bool ascending) {
//
//   for (int i = 0; i < stores.length - 1; i++) {
//     for (int j = 0; j < stores.length - i - 1; j++) {
//       if (ascending) {
//         if (stores[j].compareTo(stores[j + 1]) > 0) {
//           String temp = stores[j];
//           stores[j] = stores[j + 1];
//           stores[j + 1] = temp;
//         }
//       }
//       else {
//         if (stores[j].compareTo(stores[j + 1]) < 0) {
//           String temp = stores[j];
//           stores[j] = stores[j + 1];
//           stores[j + 1] = temp;
//         }
//       }
//     }
//   }
//   return stores;
// }
//
// void main() {
//
//   List<String> names = ['ram', 'ahmad', 'jahid', 'bipul', 'promod'];
//
//   List<String> ascendingOrder = sortStores(List<String>.from(names), true);
//   print('Ascending: $ascendingOrder');
//
//   List<String> descendingOrder = sortStores(List<String>.from(names), false);
//   print('Descending: $descendingOrder');
// }

// 2
// void main() {
//
//   List<Map<String, dynamic>> stores = [
//     {
//       'id': 1,
//       'name': 'Ahmad',
//       'price': 100.0,
//       'quantity': 50,
//       'description': 'A store selling various items.',
//       'rating': 4.5,
//       'wishlist': true,
//       'like': false,
//     },
//     {
//       'id': 2,
//       'name': 'Bipul',
//       'price': 150.0,
//       'quantity': 30,
//       'description': 'Best deals on electronics.',
//       'rating': 4.8,
//       'wishlist': false,
//       'like': true,
//     },
//     {
//       'id': 3,
//       'name': 'Chhotu',
//       'price': 120.0,
//       'quantity': 40,
//       'description': 'Quality home appliances.',
//       'rating': 4.2,
//       'wishlist': true,
//       'like': true,
//     },
//     {
//       'id': 4,
//       'name': 'Dheeraj',
//       'price': 90.0,
//       'quantity': 60,
//       'description': 'Affordable clothing and accessories.',
//       'rating': 4.0,
//       'wishlist': false,
//       'like': false,
//     },
//     {
//       'id': 5,
//       'name': 'Rohit',
//       'price': 110.0,
//       'quantity': 25,
//       'description': 'Organic and fresh groceries.',
//       'rating': 4.6,
//       'wishlist': true,
//       'like': false,
//     },
//   ];
//
//   for (var store in stores) {
//
//     print('Store ID: ${store['id']}');
//     print('Name: ${store['name']}');
//     print('Price: \$${store['price']}');
//     print('Quantity: ${store['quantity']}');
//     print('Description: ${store['description']}');
//     print('Rating: ${store['rating']}');
//     print('Wishlist: ${store['wishlist'] ? 'Yes' : 'No'}');
//     print('Like: ${store['like'] ? 'Yes' : 'No'}');
//
//   }
// }

// 3
// void main() {
//   List<Map<String, dynamic>> individuals = [
//     {
//       'id': 1,
//       'name': 'ahmad',
//       'age': 30,
//       'email': 'ahmad@gmail.com',
//     },
//     {
//       'id': 2,
//       'name': 'bipul',
//       'age': 25,
//       'email': 'bipul@gmail.com',
//     },
//     {
//       'id': 3,
//       'name': 'kohli',
//       'age': 35,
//       'email': 'kohli@gmail.com',
//     },
//     {
//       'id': 4,
//       'name': 'raja',
//       'age': 28,
//       'email': 'raja@gmail.com',
//     },
//     {
//       'id': 5,
//       'name': 'sanjay',
//       'age': 22,
//       'email': 'sanjay@gmail.com',
//     },
//     {
//       'id': 6,
//       'name': 'pawan',
//       'age': 40,
//       'email': 'pawan@gmail.com',
//     },
//     {
//       'id': 7,
//       'name': 'goldi',
//       'age': 32,
//       'email': 'goldi@gmail.com',
//     },
//     {
//       'id': 8,
//       'name': 'sharma',
//       'age': 27,
//       'email': 'sharma@gmail.com',
//     },
//   ];
//
//   for (int i = 0; i < individuals.length - 1; i++) {
//     for (int j = 0; j < individuals.length - i - 1; j++) {
//       if (individuals[j]['name'].compareTo(individuals[j + 1]['name']) > 0) {
//         Map<String, dynamic> temp = individuals[j];
//         individuals[j] = individuals[j + 1];
//         individuals[j + 1] = temp;
//       }
//     }
//   }
//
//   for (var individual in individuals) {
//     print('ID: ${individual['id']}');
//     print('Name: ${individual['name']}');
//     print('Age: ${individual['age']}');
//     print('Email: ${individual['email']}');
//   }
// }

// 4
// void main() {
//
//   Set<int> numberSet = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//
//   Map<int, String> numberMap = {
//     1: 'A',
//     2: 'B',
//     3: 'C',
//     4: 'D',
//     5: 'E',
//     6: 'F',
//     7: 'G',
//     8: 'H',
//     9: 'I',
//     10: 'J'
//   };
//
//   print('Set: $numberSet');
//   print('Map: $numberMap');
// }

// void main() {
//
//   Set<int> uniqueSalaries = {};
//
//   List<Map<String, dynamic>> employees = [
//     {'id': 1, 'name': 'Alice', 'salary': 50000},
//     {'id': 2, 'name': 'Bob', 'salary': 60000},
//     {'id': 3, 'name': 'Charlie', 'salary': 50000},
//     {'id': 4, 'name': 'Diana', 'salary': 70000},
//     {'id': 5, 'name': 'Eve', 'salary': 60000},
//     {'id': 6, 'name': 'Frank', 'salary': 80000},
//     {'id': 7, 'name': 'Grace', 'salary': 90000},
//     {'id': 8, 'name': 'Hank', 'salary': 80000},
//   ];
//
//   for (var employee in employees) {
//     uniqueSalaries.add(employee['salary']);
//   }
//   print('Unique Salaries: $uniqueSalaries');
// }

// max num

// void main(){
//    var a=[20,11,2,5,09];
//    var b=a[0];
//
//    for(var i=0; i<a.length;i++){
//      if(a[i]>b){
//        b=a[i];
//      }
//    }
//    print(b);
// }

// duplicate num

// void main(){
//   var a=[20,11,2,5,9,20,11];
//   var duplicate=[];
//
//   for(var i=1; i<a.length;i++){
//     for(var j=i+1; j<a.length;j++){
//       if(a[i]==a[j] && !duplicate.contains(a[i])){
//         duplicate.add(a[i]);
//       }
//     }
//   }
//   print(duplicate);
// }

// ascending order

// void main() {
//   var a = [2, 5, 9, 0, 20, 11,3];
//
//   for (var i = 0; i < a.length; i++) {
//     for (var j = i + 1; j < a.length; j++) {
//       if (a[i] > a[j]) {
//         var store = a[j];
//         a[j] = a[i];
//         a[i] = store;
//       }
//     }
//   }
//   print(a);
// }

// polyndrome and armstrome

// void main(){
//
//   for(var i=1; i<=1000;i++){
//     var num=i;
//     var org= num;
//     var result=0;
//
//     while(num!=0){
//       var rem= num%10;
//       var rem2=1;
//       for(var k=1;k<rem2.toString().length;k++){
//         rem2*=rem;
//       }
//       result+=rem2;
//       num~/=10;
//     }
//     if(org==result){
//       print('$i is arm..');
//     }
//   }
//
// }
//
// 1 list in 5 map

// 1 map data - name ram , age 18
// 2 map data - name mohan , age 48
// 3 map data - name sohan , age 28
// 4 map data - name suraj , age 38
// 5 map data - name rohit , age 19

// new empty list
// new list 80 data store in list after usme se jiska age top 3 jiska age kam ho uske bad map print
// use safal


// void main() {
//
//   var arr=[];
//
//   List<Map<String, dynamic>> userDataList = [
//
//     {'name': 'ram', 'age': '18'},
//     {'name': 'rohan', 'age': '28'},
//     {'name': 'sohan', 'age': '38'},
//     {'name': 'ahmad', 'age': '48'},
//     {'name': 'raja', 'age': '58'},
//
//   ];
//
//   for(var i=1; i<=16; i++){
//     arr.addAll(userDataList);
//   }
//
//   userDataList.shuffle();
//
//   print(arr.length);
//   print(arr);
//
// }

  
// void main() {
//   List<Map<String, dynamic>> userDataList = [
//
//     {'name': 'ram', 'age': '18'},
//     {'name': 'rohan', 'age': '28'},
//     {'name': 'sohan', 'age': '38'},
//     {'name': 'ahmad', 'age': '48'},
//     {'name': 'raja', 'age': '58'},
//
//   ];
//
//   List<Map<String, dynamic>> shuffledData = userData(userDataList, 27);
//
//   print(shuffledData.length);
//   print(shuffledData);
// }
//
//
// List<Map<String, dynamic>> userData(
//
//     List<Map<String, dynamic>> userDataList, int count) {
//     List<Map<String, dynamic>> arr = [];
//
//   for (var i = 0; i < count/5; i++) {
//     arr.addAll(userDataList);
//   }
//
//   arr.shuffle();
//
//   return arr;
// }

void main() {

  var a = [12, 17, 27, 29, 52];
  var b = [-17, -27, -29, -52, 51, 13];
  var c = [0, -1, 13, 27, -27];

  var results = [];

  for (var list in [a, b, c]) {
    for (var num in list) {
      if (num > 0) {
        results.add('$num is positive');
      } else if (num < 0) {
        results.add('$num is negative');
      } else {
        results.add('$num is zero');
      }
    }
  }

  for (var result in results) {
    print(result);
  }
}






