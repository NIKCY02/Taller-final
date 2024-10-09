@listar
Feature: Listar productos usando la API /api/v1/product/
	Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
		* def result = callonce read('nuevo.feature')
		* print result.response
      
	Scenario: Actualizar un producto de forma exitosa
    Given path ruta_crear,"/",result.response.sku,"/"
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match responseType == 'json'
    And match $ == {"products":'#array',"status":true,"message":"El producto fue encontrado"} 
    And match response.products[0].sku ==  result.response.sku