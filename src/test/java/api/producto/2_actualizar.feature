 @actualizar
Feature: Actualizar un producto previamente creado usando la API /api/v1/product/
	Background:
	* url 'http://localhost:8081'
	* def ruta_crear = '/api/v1/product/'
	Given path ruta_crear,"/"
	And request {name:"Producto original", description:"Descripcion", price:1000}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	* def sku_creado = response.sku
	* print sku_creado
	
Scenario Outline: Actualizar un producto previamente creado con exito
	Given path ruta_crear,"/",sku_creado,"/"
	And request <ejemplo_producto>
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method put
	Then status 200
	And match responseType == 'json'
    And match $ == {"sku":'#notnull',"status":true,"message":"El producto fue actualizado con éxito"} 
	Examples:
	|ejemplo_producto|
	|{ name: 'Iphone Actualizado', description: 'Marca Actualizado', price:150}|
	|{ name: 'Huawei', description: 'Marca Huawei', price:2500}|

	