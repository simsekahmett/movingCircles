// hareket eden circle objemiz için yazdığımız ayrı class
// circle'ın hareketi ile ilgili tüm method ve değerleri bulunduruyor

class movingCircle {
  // circle'ın koordinat değerleri
  float x; 
  float y;
  
  // circle'ın hareketi için x ve y koordinat değerlerine yapılacak artış değerleri
  // yani circle'ın hareketindeki step değeri
  // örn: circle 10x10 koordinatındaysa ve hareket sonrası
  //      yeni koordinatları 15x18 olduysa step'te x 5 artmış, y 8 artmış
  float xSpeed; 
  float ySpeed; 

  // circle'ımızın çap değeri
  float circleSize; 

  // circle'ımızın RGB formatındaki renginin R, G ve B değerleri
  float colorR;
  float colorG;
  float colorB;

  // circle'ımızın x ve y koordinatları üzerinden merkeze uzaklığı
  // örn: 1000x1000 bir tablo için merkezimiz 500x500 koordinatları
  //      circle'ımızın o anki x ve y koordinatları da 150x200 olduğunu varsayarsak,
  //      x olarak merkeze uzaklığı 350
  //      y olarak merkeze uzaklığı 300
  float xDistanceToCenter;
  float yDistanceToCenter;

  // class'ımızın constructor'ı
  // main class'ımızda oluşturduğumuz myCircleArray objesinin içine eklediğimiz movingCircle objesinin
  // değerleri bu methoda geliyor ve gönderilen değerlerle circle objesi bu methodda oluşturuluyor
  movingCircle(float xPos, float yPos, float csize, float _colorR, float _colorG, float  _colorB) {
    
    // constructor'a gönderilen değerleri circle için burada set ediyoruz
    // main class'taki a,b,c,d,e ve f olarak açıkladığım kısım
    x = xPos;
    y = yPos; 
    
    circleSize = csize;

    colorR = _colorR;
    colorG = _colorG;
    colorB = _colorB;

    // circle'ımızın hareketi için x ve y koordinat değerlerine yapılacak artış değerleri
    // -10 ve 10 sayıları arasından random olarak oluşturuyoruz,
    // (-) değeri de koymamızın sebebi X ve Y koordinatları üzerinde yapacağımız azalışlar
    // örn: 800x900 koordinatındaki bir circle'ın yukarı yönde gitmesi;
    //      y koordinatındaki azalışla, sola doğru gitmesi ise 
    //      x koordinatındaki azalışla olur
    xSpeed = random(-10, 10); 
    ySpeed = random(-10, 10);
  }

  // circle'ımızın hareketi için mevcut x ve y koordinatlarımıza step değerlerimizi ekliyoruz
  // böylelikle elde edeceğimiz yeni koordinatlar circle'ımızın yeni yerini belirleyecek
  void move() {
    x += xSpeed; 
    y += ySpeed;
  }

  // circle'ımızın tablo'nun kenarlarına değip değmeyeceğini kontrol eden method
  void checkCollision() {
    // circle'ımızın yarıçap değeri, temas kontrolü için kullanacaz
    float r = circleSize/2; 

    // eğer mevcut x koordinatımız yarıçap değerimizden küçükse (ekranın sol kenarı için)
    // ya da tablomuzun genişlik(width) değerinden yarıçapımızı çıkarttığımızdan büyükse 
    //                 (ekranın sağ kenarı için, yarıçap kullanmamızın sebebi de kenarlardan taşmasını engellemek için)
    // step değerimizi (-) değer ile değiştiriyoruz, tersine yön için
    if ( (x<r) || (x>width-r)) { 
      xSpeed = -xSpeed;
    }  

    // yukarda açıkladığım şeyin y koordinatı ve tablonun yükseklik(height) değeri için yapılan kontrolü 
    if ( (y<r) || (y>height-r)) { 
      ySpeed = -ySpeed;
    }
  }

  // circle'ımızı ekranda çizdiğimiz method,
  // colorR, colorG ve colorB değerleri RGB renk kodumuzun R,G ve B değerleri
  // x, y değerleri koordinatlarımız
  // circleSize değerleri circle'ımızın boyu için 
  // ellipse'in içerisine size'ları aynı verirsek tam yuvarlak, farklı verirsek elips olur
  void drawCircle() { 
    fill(colorR, colorG, colorB); 
    ellipse(x, y, circleSize, circleSize);
  }

  // circle'ımızı ekranın ortasına yani center'a getirecek olan method
  void moveToCenter() {
    // eğer mevcut koordinatımız genişlik değerimizin yarısından(1000/2=500 bizim tablomuz için) küçük ise*
    // x değerimizi 3 arttırıyoruz (merkeze götürmek için step değerimiz 3, daha yavaş gitmesini sağlıyor bu şekilde)
    if (x < (width/2))
      x += 3;
    else if (x > (width/2)) // *büyük ise x değerimizi 3 azaltıyoruz 
      x -= 3;

    // x koordinatı için yaptığımız arttırma/azaltma işlemini y koordinatı için de yapıyoruz
    if (y < (height/2))
      y += 3;
    else if (y > (height/2))
      y -= 3;

    // arttırma işlemi sonrası circle'ımızın x ve y değerlerinin merkeze olan uzaklığını ölçüyoruz
    xDistanceToCenter = (width/2) - x;
    yDistanceToCenter = (height/2) - y;

    // merkeze olan uzaklığımız -3 ya da 3 arasında ise direk merkezde konumlandırıyoruz
    // merkeze doğru giderken step değerimizi yukarıda "3" olarak belirlemiştik, o yüzden
    // -3 ve 3 arasında kontroller yapıyoruz, 
    // eğer 3 yerine farklı sayılar verseydik; merkeze yerleşme hareketinde keskin bir geçiş olacaktı
    if (xDistanceToCenter > -3 && xDistanceToCenter < 3)
      x = (width/2);
    if (yDistanceToCenter > -3 && yDistanceToCenter < 3)
      y = (height/2);
  }

  // circle'ımız merkezde mi değil mi onun kontrolünü yaptığımız method,
  // eğer mevcut koordinatlarımız merkez koordinatlarımıza eşitse true,
  // değilse false gönderiyor
  // bu methodu ses çalıp çalmama kararını vermek için kullanıyoruz
  boolean isCentered() {
    if (x == (width/2) && y == (height/2))
      return true;
    else
      return false;
  }
}
