/// Khái niệm singleton parten
/// ****** Tìm hiểu về Singleton Pattern*******
/// 1. Singleton Pattern là gì ?
/// - Là 1 trong 5 design pattern thuộc nhóm Creational Design Pattern
/// - Đảm bảo 1 class chỉ có 1 intance
/// - Cung cấp global để truy cập tới instance đó.
/// 2. Why use Singleton Pattern
/// - Có nhiều đối tượng có nhiệm vụ ảnh hưởng rộng hơn, chẳng hạn quản lý các tài nguyên bị giới hạn hoặc theo dõi
/// toàn bộ trạng thái của hệ thống.
/// VD: Có rất nhiều máy in trong hệ thống nhưng chỉ tồn tại 1 Sprinter Spooler(Quản lý máy in)
/// - Hay vd chức năng mở tắt nhạc nền khi vào app. Để tắt phải vào setting. Trong TH chỉ cần 1 instance để tắt mở
/// không cần 2 instance vì nó sẽ không liên qua đến nhau.
/// 3. How to implement singleton Pattern
/// * Làm sao để 1 class chỉ có duy nhất 1 instance?
/// - Private constructor của class để đảm bảo rằng class lớp khác ko thể truy cập vào constructor và tạo instance mới
/// - Tạo 1 private static là instance của class đó và duy nhất
/// * Cung cấp global truy cập tới instance đó.
/// - Tạo một public static method trả về instance vừa khởi tạo trên.
/// 4. Những cách để implement singleton pattern
/// a. Eager initialization
class EagerInitializedSingleton {
  static final EagerInitializedSingleton instance = EagerInitializedSingleton();
  EagerInitializedSingleton() {}
  static EagerInitializedSingleton getInstance() {
    return instance;
  }
}

/// Nhược điểm: tạo nhưng có thể không dùng tới.
/// b. Layzy initializition
class LayzyInitiallizedSingleton {
  static LayzyInitiallizedSingleton? instance;
  LayzyInitiallizedSingleton() {}
  static LayzyInitiallizedSingleton? getInstance() {
    if (instance == null) {
      instance = LayzyInitiallizedSingleton();
      return instance;
    }
    return instance;
  }
}
/// Ưu điểm: cách này khắc phục được khi nào cần thì có thể khởi tạo.
/// Nhược điểm: Nó chỉ tốt trong TH đơn lường , nếu có 2 luồng cùng chạy và cùng gọi hàm getInstance tại 
/// cùng 1 thời điểm 