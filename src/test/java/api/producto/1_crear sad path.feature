Feature: SAD PATH - Crear un nuevo producto usando la api /api/v1/product/
  Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    
Scenario: Intentar crear un producto sin nombre
	  Given url 'http://localhost:8081/api/v1/product/'  
	  And request {description:"Marca Apple", price:1500}
	  And header Accept = 'application/json'
	  And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	  When method post
	  Then status 400

Scenario: Intentar crear un producto con datos incompletos (Sin descripción ni precio)
	  Given url 'http://localhost:8081/api/v1/product/'
	  And request {name:"Iphone"}
	  And header Accept = 'application/json'
	  And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	  When method post
	  Then status 400
	  And match $ contains {"sku":"","status":false,"message":"La descripción del producto no fue proporcionada"}
	  
Scenario: Intentar crear un producto con datos incompletos (Sin precio)
	  Given url 'http://localhost:8081/api/v1/product/'
	  And request {name:"Iphone",description:"Celular moderno"}
	  And header Accept = 'application/json'
	  And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	  When method post
	  Then status 400
	  And match $ contains  {"sku":"","status":false,"message":"El precio del producto no fue proporcionado"}
	  
Scenario: Crear un producto de forma no exitosa con json como texto (Sin Authorization)
    * def producto =
      """
      {
        "name": "Iphone 14",
        "description": "Este es un smartphone de alta gama",
        "price": 1400,
      }
      """
    Given url 'http://localhost:8081/api/v1/product/'
    And request producto
    And header Accept = 'application/json'
    When method post
    Then status 400