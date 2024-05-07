
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
## 1. Kullanıcılar (Users)
### Kullanıcı Oluşturma

```bash
curl -X POST http://localhost:3000/users \
     -H "Content-Type: application/json" \
     -d '{"user": {"username": "example_user", "password": "example_password"}}'
```
### Oturum Açma

```bash
curl -X POST \
  http://localhost:3000/login \
  -H 'Content-Type: application/json' \
  -d '{
    "username": "testuser",
    "password": "testpassword"
  }
```

### Oturum Kapatma
**Endpoint:**  
* DELETE /logout

**Açıklama:** Kullanıcının oturumunu sonlandırır.  

## 2. Kitaplar (Books)
### Tüm Kitapları Listeleme

```bash
curl -X GET http://localhost:3000/books
```
### Yeni Kitap Ekleme

```bash
curl -X POST http://localhost:3000/books \
-H 'Content-Type: application/json' \
-d '{"book": {"title": "Yeni Kitap", "description": "Açıklama", "price": 29.99, "stock": 100}}'
```  
### Kitap Silme

```bash
curl -X DELETE http://localhost:3000/books/{id}
```  

### Belirli Bir Kitabı Görüntüleme

```bash
curl -X GET http://localhost:3000/books/{id} \
  -H 'Authorization: Bearer YOUR_JWT_TOKEN'

```  

### Kitap Güncelleme

```bash
curl -X PUT http://localhost:3000/books/{id} \
-H 'Content-Type: application/json' \
-d '{"book": {"title": "Güncellenmiş Kitap", "description": "Güncellenmiş açıklama", "price": 39.99, "stock": 50}
``` 
## 2. Sepet İşlemleri (Cart)
### Sepeti Görüntüleme:

```bash
curl -X GET http://localhost:3000/cart \
-H 'Authorization: Bearer {token}'
```
### Sepete Kitap Ekleme

```bash
curl -X POST http://localhost:3000/cart/cart_items \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer {token}' \
-d '{"book_id": {book_id}, "quantity": 3}'
```  
### Sepetten Kitap Kaldırma

```bash
curl -X DELETE http://localhost:3000/cart/cart_items/{cart_item_id} \
-H 'Authorization: Bearer {token

```  
### Sepeti Temizleme

```bash
curl -X POST http://localhost:3000/cart/clear \
-H 'Authorization: Bearer {token}'
```  
## 4. Ödeme İşlemleri (Payments)

```bash
curl -X POST http://localhost:3000/cart/checkout \
-H 'Authorization: Bearer {token}
```





























