
# Ruby On Rails Rails Case Project 

* Bu proje, kullanıcıların kitapları listelemesine, kitap eklemesine, güncellemesine ve silmesine olanak tanıyan bir API sunar. Ayrıca kullanıcılar, kendi sepetlerini oluşturup kitapları sepetlerine ekleyebilir ve ödeme işlemi gerçekleştirebilirler.

### Önkoşullar

- [Ruby](https://www.ruby-lang.org/en/) yüklü olmalıdır.
- [Rails](https://rubyonrails.org/) yüklü olmalıdır.
- [Bundler](https://bundler.io/) yüklü olmalıdır.
- [Git](https://git-scm.com/) yüklü olmalıdır.
- [PostgreSQL](https://www.postgresql.org/download/) yüklü olmalıdır.


## Kurulum Adımları:

* Projeyi klonlayın veya indirin:

``` 
 git clone git@gitlab.com:muratcayir1/iwallet-rails-case-project.git
``` 

* Proje dizinine gidin:

``` 
 cd  iwallet-rails-case-project
``` 

* Gerekli bağımlılıkları yükleyin:

``` 
 bundle install
``` 

* Veritabanını oluşturun ve migrate işlemlerini yapın:

``` 
rails db:create
rails db:migrate
``` 

* Sunucuyu başlatın:

``` 
rails server
``` 

* Şimdi, http://localhost:3000 adresine giderek projeyi görebilirsiniz.

# Proje API'ları

Bu belge, projenin API'larını ve bu API'ları test etmek için CURL komutlarını içerir.  
## 1. Kullanıcılar (Users):
### Kullanıcı Oluşturma
**Endpoint:**  
* POST /users   

**Açıklama:**   Yeni bir kullanıcı oluşturur.  
**Parametreler:**  
* username (string): Kullanıcı adı
* password (string): Şifre  

**Başarılı Yanıt:** HTTP Status 201 Created 

**Başarısız Yanıtlar:** HTTP Status 422 Unprocessable Entity

#### CURL Örneği
```bash
curl -X POST http://localhost:3000/users \
     -H "Content-Type: application/json" \
     -d '{"user": {"username": "example_user", "password": "example_password"}}'
```
### Oturum Açma
**Endpoint:**  
* POST /login  

**Açıklama:**   Kullanıcıyı kimlik doğrulaması yaparak oturum açar. 
**Parametreler:**  
* username (string): Kullanıcı adı
* password (string): Şifre  

**Başarılı Yanıt:**HTTP Status 200 OK, oturum açma başarılı mesajı ve JWT belirteci

**Başarısız Yanıtlar:** HTTP Status 401 Unauthorized, hata mesajı

#### CURL Örneği
```bash
curl -X POST \
  http://localhost:3000/login \
  -H 'Content-Type: application/json' \
  -d '{
    "username": "testuser",
    "password": "testpassword"
  }'


```

### Oturum Kapatma
**Endpoint:**  
* DELETE /logout

**Açıklama:** Kullanıcının oturumunu sonlandırır.  

## 2. Kitaplar (Books):
### Tüm Kitapları Listeleme:
**Endpoint:**  
* GET /books

**Açıklama:**  Tüm kitapları listeler.
**Başarılı Yanıt:** Yanıt: HTTP Status 200 OK, tüm kitapların listesi

#### CURL Örneği
```bash
curl -X GET http://localhost:3000/books \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'
```
### Kitap Ekleme:
**Endpoint:**  
* POST /books

**Açıklama:** Yeni bir kitap ekler.
**Parametreler:**  
* book_id (integer): Eklenecek kitabın ID'si
* title (string): Kitap başlığı
* author (string): Kitabın yazarı
* publisher (string): Kitabın yayıncısı
* price (decimal): Kitabın fiyatı

**Başarılı Yanıt:** HTTP Status 201 Created, oluşturulan kitabın detayları
**Başarısız Yanıtlar:** HTTP Status 422 Unprocessable Entity, hata mesajları

#### CURL Örneği
```bash
curl -X POST http://localhost:3000/books \
     -H "Content-Type: application/json" \
     -d '{"book": {"title": "Example Book", "author": "Example Author", "publisher": "Example Publisher", "price": 19.99}}'
```  
### Kitap Silme:
**Endpoint:**  
* DELETE /books/:id
**Açıklama:**  Varolan bir kitabı siler.
**Başarılı Yanıt:** HTTP Status 200 OK, kitap silme başarılı mesajı


#### CURL Örneği
```bash
curl -X DELETE http://localhost:3000/cart/remove/1 \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'

```  

### Belirli Bir Kitabı Görüntüleme:
**Endpoint:**  
* GET /books/:id
**Açıklama:**  HTTP Status 200 OK, belirli kitabın detayları
**Başarılı Yanıt:** HTTP Status 200 OK, kitap silme başarılı mesajı
**Başarısız Yanıt:** HTTP Status 404 Not Found, kitap bulunamadı mesajı


#### CURL Örneği
```bash
curl -X DELETE http://localhost:3000/books/1 \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'

```  

### Kitap Güncelleme:
**Endpoint:**  
* PUT /books/:id

**Açıklama:** Varolan bir kitabı günceller.
**Parametreler:**  
* title (string): Kitap başlığı
* author (string): Kitabın yazarı
* publisher (string): Kitabın yayıncısı
* price (decimal): Kitabın fiyatı

**Başarılı Yanıt:** HTTP Status 200 OK, güncellenen kitabın detayları
**Başarısız Yanıtlar:** HTTP Status 422 Unprocessable Entity, hata mesajları

#### CURL Örneği
```bash
curl -X POST \
  http://localhost:3000/books/1 \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN' \
  -d '{
    "book_id": 1,
    "quantity": 2
  }'
``` 
## 2. Sepet İşlemleri (Cart):
### Sepeti Görüntüleme:
**Endpoint:**  
* GET /cart 

**Açıklama:**   Kullanıcının sepetini görüntüler.  
**Başarılı Yanıt:** HTTP Status 200 OK, kullanıcının sepetinin detayları

#### CURL Örneği
```bash
curl -X GET http://localhost:3000/cart \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'
```
### Sepete Kitap Ekleme
**Endpoint:**  
* POST /cart/add

**Açıklama:**   Kullanıcının sepetine kitap ekler.
**Parametreler:**  
* book_id (integer): Eklenecek kitabın ID'si
* quantity (integer): Eklenecek kitabın miktarı

**Başarılı Yanıt:** HTTP Status 200 OK, sepete kitap ekleme başarılı mesajı

**Başarısız Yanıtlar:** HTTP Status 404 Not Found, kitap bulunamadı mesajı veya HTTP Status 422 Unprocessable Entity, hata mesajları

#### CURL Örneği
```bash
curl -X POST \
  http://localhost:3000/cart/add \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN' \
  -d '{
    "book_id": 1,
    "quantity": 2
  }'

```  
### Sepetten Kitap Kaldırma
**Endpoint:**  
* DELETE /cart/remove/:id 

**Açıklama:** Kullanıcının sepetinden belirli bir kitabı kaldırır.
**Başarılı Yanıt:** HTTP Status 200 OK, kitap kaldırma başarılı mesajı
**Başarısız Yanıtlar:** HTTP Status 404 Not Found, kitap bulunamadı mesajı

#### CURL Örneği
```bash
curl -X DELETE http://localhost:3000/cart/remove/1 \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'

```  
### Sepeti Temizleme
**Endpoint:**  
*  DELETE /cart/clear 

**Açıklama:**Kullanıcının sepetini temizler.
**Başarılı Yanıt:** HTTP Status 200 OK, sepet temizleme başarılı mesajı

#### CURL Örneği
```bash
curl -X DELETE http://localhost:3000/cart/clear \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'
```  
## 4. Ödeme İşlemleri (Payments):
### Ödeme Yapma:  
**Endpoint:**  
*  POST /payment
**Açıklama:** Kullanıcının sepetindeki ürünleri ödemesini yapar.  
**Başarılı Yanıt:** HTTP Status 200 OK, ödeme başarılı mesajı  
**Başarısız Yanıt:**  HTTP Status 422 Unprocessable Entity, ödeme başarısız mesajı  

#### CURL Örneği
```bash
curl -X POST http://localhost:3000/payment \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'
```





























