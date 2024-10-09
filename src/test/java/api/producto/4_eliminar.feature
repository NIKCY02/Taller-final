@eliminar
Feature: Eliminar un producto usando la API /api/v1/product/
	Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
		* def result = callonce read('nuevo.feature')
		* print result.response
      
	Scenario: Actualizar un producto de forma exitosa
    Given path ruta_crear,"/",result.response.sku,"/"
    And header Accept = 'application/json'
    When method delete
    Then status 200
    And match responseType == 'json'
    And match $ == {"count":'#number',"status":true,"message":"El producto fue eliminado con éxito"} 
