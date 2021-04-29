##Proje iki kısımdan oluşmaktadır,
*İlk kısımda Coucbase Server ve Clusterları oluşturulmuştur
*İkinci kısımdaysa rest api kullanılarak python üzerinden veri çekilmiştir.


## Prerequisites
* Docker Engine
* Docker Compose
* Python 3.6 
* Python3 Couchbase Modulu https://docs.couchbase.com/python-sdk/3.0/hello-world/start-using-sdk.html  

## Quick Start
* 3 Node Çalışmaktadır
* Ana Node:couchbase-node1 Data-Query- Index hizmetleri sağlamaktaadır
* couchbase-node2:Query
* couchbase-node3: Data 
* Dağıtık bir şekilde tercih edilmesinin nedeni scale edebilmektir
* Gerekli ortamlar kurulduktan sonra
* Çalıştır `docker-compose up` ve localhost:8091' gidilerek cluster'a erisilebilir
* username: Administrator password:somepassword


## Yeni Node Ekleme - Scale


* adding_nodes_to_cluster.sh dosyası konfigure edilerek cluster'a yeni server nodelar eklenebilir

```
sh adding_nodes_to_cluster.sh

```

## Rest Python

* python_rest_case2 klasoru altında python kodları bulunabilir
* Calistirilabilmesi icin `requests` ve `couchbase` modulunun varlıgından emin olun
* Calisma sonucu bir sorgu ve requestin çıktılarını goruntuleyebilirsiniz

