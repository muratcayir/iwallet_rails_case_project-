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

### CURL Örneği
```bash
curl -X POST http://localhost:3000/users \
     -H "Content-Type: application/json" \
     -d '{"user": {"username": "example_user", "password": "example_password"}}'
```

*Bu metin italik*
**Bu metin kalın**
`Bu metin italik`  
veya 
 _Bu metin italik_