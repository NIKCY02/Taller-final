Feature: Insertar un nuevo producto usando la api /api/v1/product/ y CSV
	Background:
	* url 'http://localhost:8081'
	* def ruta_crear = '/api/v1/product/'
	
Scenario Outline: Insertar un nuevo producto con exito usando CSV
	Given path ruta_crear,"/"
	And request {name:<name>, description:<description>, price:<price>}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match responseType == 'json'
	And match $ == {"sku":"#notnull","status":true,"message":"El producto fue creado con éxito!"}
	Examples:
	|read("productos.csv")|
	
Scenario Outline: Insertar un producto de forma exitosa, path, response usando examples con json
	Given path ruta_crear,"/"
	And request {name:<name>, description:<description>, price:<price>}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match responseType == 'json'
	And match $ == {"sku":'#string',"status":'#boolean',"message":"El producto fue creado con éxito!"}
	Examples:
	|read("productos.json")|