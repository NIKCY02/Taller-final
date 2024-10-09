Feature: SAD PATH - Insertar un nuevo producto usando la api /api/v1/product/ y CSV
	Background:
	* url 'http://localhost:8081'
	* def ruta_crear = '/api/v1/product/'
	
Scenario Outline: Insertar un producto con datos inválidos desde CSV
    Given path ruta_crear,"/"
    And request {name:<name>,description:<description>,price:<price>}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 400
    And match responseType == 'json'
    And match $ == {"sku":"","status":false,"message":"El nombre del producto no fue proporcionado"} 
    Examples:
        |read("productos_invalidos.csv")|
        
        
Scenario Outline: Intentar insertar un producto duplicado desde JSON
    Given path ruta_crear,"/"
    And request {name:<name>, description:<description>, price:<price>}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 400
    And match responseType == 'json'
    Examples:
        |read("productos_duplicados.json")|
        
        
 Scenario: Intentar insertar un producto sin Authorization
    Given path ruta_crear,"/"
    And request {name: "Xiaomi", description: "Descripción", price: 100}
    And header Accept = 'application/json'
	And header Authorization = "Bearer token_invalido" 
    When method post
    Then status 400
    And match response == {"sku":"","status":false,"message":"Invalid permissions"}
    
 Scenario: Intentar insertar un producto sin nombre
    Given path ruta_crear, "/"
    And request {description: "Descripción", price: 150}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 400
    And match response == {"sku":"","status": false,"message":"El nombre del producto no fue proporcionado"}

Scenario: Intentar insertar un producto sin precio
    Given path ruta_crear, "/"
    And request {name:"Producto01",description:"Descripción"}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 400
    And match response == {"sku":"","status":false,"message":"El precio del producto no fue proporcionado"} 
