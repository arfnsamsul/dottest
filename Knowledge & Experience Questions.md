1. Apa saja library iOS yang sering atau biasa anda pakai? Jelaskan kegunaannya bagi anda.
- Alamofire, untuk pemanggilan API
- SwiftyJSON untuk serialize JSON ke primitive data. (mulai jarang saya gunakan semenjak menggunakan codable)
- SDWebImage untuk load image di main thread, asyncronously
- Charts untuk membuat grafik/chart
- PagingMenuController untuk membuat ui seperti view pager & tab android
dll

2. Apakah anda menggunakan prinsip clean code atau design pattern untuk project iOS anda? Jelaskan penerapan clean code atau design pattern yang biasa anda gunakan dan manfaatnya untuk anda
beberapa prinsip clean code yang sering saya terapkan:
- fungsi harus bertujuan untuk melakukan sesuatu atau menjawab sesuatu, bukan keduanya. jangan sampai fungsi isActive() melakukan operasi lain selain me-return boolean
- kode harus dipisahkan dengan blank lines untuk mengelompokkan satu kelompok logika agar lebih mudah membacanya
- satu fungsi harus melakukan satu hal saja dengan sangat baik, sehingga idealnya dalam satu fungsi tidak berisi terlalu banyak kode, dan harus bisa dibaca dalam satu layar (tanpa scroll)
- sebisa mungkin jangan return null/nil. jelas ini untuk menghindari NPE
- variabel harus dideklarasikan sedekat mungkin dengan penggunaannya. 
- jangan memberikan komentar untuk hal yang sudah jelas. misalkan function isActive(). tanpa komentar pun kita sudah tahu kalau fungsi ini untuk cek status active
- oleh karena itu, buat naming yang baik untuk readability yang baik
- jika fungsi A memanggil fungsi B, maka 2 fungsi tersebut harus berdekatan, dengan fungsi A berada di atas
dll

untuk design pattern hanya saya gunakan seperlunya. beberapa diantaranya juga sudah bawaan SWIFT.
- singleton : class yang hanya punya 1 object saja
- observer: digunakan untuk melakukan notify
- abstract: kalau di swift biasa disebut protocol, untuk membuat class yang harus overload method2 yang didefinisi di class abstract
