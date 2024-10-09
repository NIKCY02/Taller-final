Feature: Crear un nuevo producto usando la api /api/v1/product/
	Background:
	* url 'http://localhost:8081'
	* def ruta_crear = '/api/v1/product/'
	* def nuevo_producto =
	"""
	{
	  "name": "Samsung Galaxy 25",
	  "description": "Ultimo modelo de Samsung",
	  "price": 1500
	}
	"""
	
	Scenario: Crear un nuevo producto con exito
	* def producto =
	"""
	{
	  "name": "Samsung Galaxy 25",
	  "description": "Ultimo modelo de Samsung",
	  "price": 1500
	}
	"""
	Given url 'http://localhost:8081/api/v1/product/'
	And request {name:"Iphone", description:"Marca Apple", price:1500}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201

	Scenario: Crear un nuevo producto con exito y validar el response
	Given url 'http://localhost:8081/api/v1/product/'
	And request {name:"Iphone", description:"Marca Apple", price:1500}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match $ == {"sku":"#notnull","status":true,"message":"El producto fue creado con éxito!"}

	Scenario: Crear un nuevo producto con exito usando background o antecedentes
	Given path ruta_crear,"/"
	And request {name:"Iphone", description:"Marca Apple", price:1500}
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match $ == {"sku":"#notnull","status":true,"message":"El producto fue creado con éxito!"}
	
	Scenario: Crear un nuevo producto con exito usando background, url, path y variable
	Given path ruta_crear,"/"
	And request nuevo_producto
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match $ == {"sku":"#notnull","status":true,"message":"El producto fue creado con éxito!"}
	
	Scenario Outline: Crear un nuevo producto con exito usando examples
	Given path ruta_crear,"/"
	And request <ejemplo_producto>
	And header Accept = 'application/json'
	And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	And match $ == {"sku":"#notnull","status":true,"message":"El producto fue creado con éxito!"}
	Examples:
	|ejemplo_producto|
	|{name:'Iphone1', description:'Marca Apple1', price:1000 }|
	|{name:'Iphone2', description:'Marca Apple2', price:2000 }|
	|{name:'Iphone3', description:'Marca Apple3', price:3000 }|
	