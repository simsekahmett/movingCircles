import ddf.minim.*;

// ses çalma ile alakalı variable'lar//
Minim minim; //  sesi çalacak playerımızın kodlarını içeren kütüphane (import ettiğimiz kütüphane)
AudioPlayer player; // sesi çalacak playerımız 

// 3 movingCircle objeli boş bir array oluşturuyoruz
// oluşturacağımız her circle'ı arrayimizin içinde tutacağız
movingCircle[] myCircleArray = new movingCircle[3]; 

void setup () 
{
  // circle'larımızın içerisinde hareket edeceği tablomuzun boyutu 1000x1000
  size(1000, 1000);

  // minim kütüphanesinden Minim objesi oluşturuyoruz
  // ses çalmak için kullanacağımız obje
  minim = new Minim(this);
  
  // minim kütüphanesinin loadfile fonksiyonunu kullanarak ses dosyamızı playerımıza yüklüyoruz
  player = minim.loadFile(dataPath("ping.mp3")); //dataPath: kodlarımızın yanındaki data klasörümüzün yolunu veriyor

  // 10. satırda oluşturduğumuz myCircleArray objemizin içine 3 adet movingCircle objesi tanımlıyoruz

  // a: başlangıç koordinatımızın X değeri
  // b: başlangıç koordinatımızın Y değeri
  // c: oluşturacağımız circle'ın çap değeri
  // d: oluşturacağımız circle'ın RGB değerinden renk kodunun R kısmı
  // e: oluşturacağımız circle'ın RGB değerinden renk kodunun G kısmı
  // f: oluşturacağımız circle'ın RGB değerinden renk kodunun B kısmı
  // 1000x1000 tabloda orta nokta 500x500'dür,
  // bizim circle objelerimiz merkezden başlayacak şekilde oluşturuluyor, 
  // o yüzden a ve b değerleri 500
  //                                  (a ,  b , c ,  d , e, f)
  myCircleArray[0] = new movingCircle(500, 500, 50, 255, 0, 0); // kırmızı
  myCircleArray[1] = new movingCircle(500, 500, 50, 0, 255, 0); // yeşil
  myCircleArray[2] = new movingCircle(500, 500, 50, 0, 0, 255); // mavi
}

void draw () {  
  blendMode(SCREEN);
  background(0);

  // kaç tane circle merkeze geldi, onun değerini tutan variable
  // ses çalmak için kontrol yapmamıza yarayacak
  // örn: 3 adet circle'ımız var, 3'ü de merkezde olunca ses çalacağız,
  //      eğer 3'ü de merkezde değilse ses çalmayacağız
  int centeredCircleCount = 0;

  // myCircleArray arrayimizde bulunan 3 adet circle için tek tek işlem yapacak for döngümüz
  // for döngüsü içerisindeki kod, her bir circle objemiz için execute edilecek
  // i değeri index için, döngü kaçıncı seferde tekrarlanıyor onu tutuyor,
  // örn: i=1 ise 2. circle'ımız için kodlar execute edilecek
  // (arrayler'de ilk eleman 0. eleman olarak geçer yazılımda
  // myCircleArray[0] = 1. eleman
  // myCircleArray[1] = 2. eleman
  // myCircleArray[2] = 3. eleman
  for (int i=0; i<myCircleArray.length; i++) {

    // mouse basılıysa true, basılı değilse false
    if (mousePressed == true)
    {
      // eğer mouse basılıysa movingCircle class'ımızda moveToCenter komutunu
      // myCircleArray arrayimizdeki circle'ımız için execute edecek
      // yani o an döngünün o anki circle'ını merkeze götürecek
      myCircleArray[i].moveToCenter();

      // kaç tane circle merkeze gelmiş onun kontrolünü yapacak bir diğer döngü
      for (int r=0; r < myCircleArray.length; r++)
      {
        // bu döngü içerisinde her bir circle'ımızın merkezde olup olmadığını kontrol edecez ve
        // yukarıda tanımladığımız "centeredCircleCount" değerimizi 1 arttıracaz (eğer circle merkezde ise)
        // o değer 3 olduğu zaman 3'ü de merkezde demek oluyor
        if (myCircleArray[r].isCentered())
          centeredCircleCount++;
      }

      // centeredCircleCount değerimiz eğer array'imizin uzunluğuna eşit ise 
      // tüm circle'larımız merkezde toplanmış oluyor, 
      // 6. satırda; "sound" class'ımızdan oluşturduğumuz 
      // ping variable'ımız'ın play komutu ile ses dosyamızı çalacağız
      // eğer centeredCircleCount değerimiz array'imizin uzunluğuna eşit ise(!)
      // değil ise ping variable'ımızın rewind komutu ile ses dosyamızı başa sarıyoruz (tekrar çalabilmemiz için gerekli)
      if (centeredCircleCount == myCircleArray.length)
        player.play();
      if (centeredCircleCount < myCircleArray.length)
        player.rewind();
    } else // 62. satırdaki mouse basılıysa true, değilse false kontrolünü sağlayan if'in "değilse" kısmı
    {
      // buraya mouse basılı değilken geliyoruz,
      // circle'ımız move hareketiyle tablo üzerinde geziniyor
      myCircleArray[i].move();
    }

    // circle'ımız için checkCollision methodunu execute ediyoruz yani;
    // eğer tablo'nun kenarlarına değerse dışarı taşmaması için gerekli kontrolü yapacak ve
    // yönünü değiştirecek olan method
    myCircleArray[i].checkCollision();
    
    // circle'ımız ile alakalı tüm işlemlerimizi yaptıktan sonra circle'ımızı tablo üzerinde çiziyoruz
    myCircleArray[i].drawCircle();
    
    // merkez'de toplanan circle'larımızın sayısını tutan değerimizi sıfırlıyoruz,
    // döngü içerisinde tekrardan hesaplayıp güncel değeri tutacaz
    centeredCircleCount = 0;
  }
}
