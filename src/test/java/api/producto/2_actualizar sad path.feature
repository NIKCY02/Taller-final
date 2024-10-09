@actualizar
Feature: SAD PATH - Actualizar un producto previamente creado usando la API /api/v1/product/
  	Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
    Given path ruta_crear,"/"
    * header Accept = 'application/json'
	And request {name:"Producto original", description:"Descripcion original", price:1000}
	* header Accept = 'application/json'
	* header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
	When method post
	Then status 201
	* def sku_creado = response.sku
	* print sku_creado
    
Scenario: Intentar actualizar un producto sin autenticación 
	* def producto =
      """
      {
        "name": "Iphone 123",
        "description": "Smartphone de alta gama",
        "price": 1400,
      }
      """
    Given path ruta_crear,"/",sku_creado
    And request producto
    And header Accept = 'application/json'
    When method put
    Then status 404

Scenario: Intentar actualizar un producto con autenticación invalida
    * def producto =
      """
      {
        "name": "Iphone 123",
        "description": "Este es un smartphone de alta gama",
        "price": 1400
      }
      """
    Given path ruta_crear,"/", sku_creado
    And header Accept = 'application/json'
    And request producto
    And header Authorization = "Bearer token_invalido" 
    When method put
    Then status 404

Scenario: Intentar actualizar un producto inexistente
    Given path ruta_crear,"/","sku_invalido","/"
    And request {name:"ProductoF", description:"Inexistente", price:1500}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method put
    Then status 400
    And match $ contains {"status":false, "message":"El producto no fue encontrado"}
 
Scenario: Intentar actualizar un producto sin nombre
    Given path ruta_crear,"/", sku_creado,"/"
    And request {description:"Sin nombre", price:1500}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method put
    Then status 400
    And match $ contains {"status":false, "message":"El nombre del producto no fue proporcionado"}

Scenario: Intentar actualizar un producto sin descripción
    Given path ruta_crear,"/", sku_creado,"/"
    And request {name:"Product sin descripción", price:1500}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method put
    Then status 400
    And match $ contains {"status":false, "message":"La descripción del producto no fue proporcionada"}

Scenario: Intentar actualizar un producto sin precio
    Given path ruta_crear,"/", sku_creado,"/"
    And request {name:"Iphone20",description:"Celular moderno"}
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method put
    Then status 400
    And match $ contains {"status":false, "message":"El precio del producto no fue proporcionado"}

Scenario: Intentar actualizar un producto con nombre duplicado
    * def producto_duplicado = 
    """
    {
      "name": "Iphone2050",
      "description": "Prueba de duplicación",
      "price": 2000
    }
    """
    Given path ruta_crear,"/"
    And request producto_duplicado
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 201
    * def sku_temporal = "b5b4e8f5-e385-4af2-b2af-ecc90497c09a"
    * print sku_temporal

    Given path ruta_crear,"/",sku_temporal,"/"
    And request {name:"Iphone2050", description:"Prueba de duplicación", price:1500}
    And header Accept = 'application/json'
    When method put
    Then status 400
    And match $ == {"sku":"#(sku_temporal)","status":false, "message":"El producto no fue encontrado"}
