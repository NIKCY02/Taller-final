@eliminar
Feature: SAD PATH - Eliminar un producto usando la API /api/v1/product/
	Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
		* def result = callonce read('nuevo.feature')
		* print result.response
      
	Scenario: Intentar eliminar un producto
	* def sku_temporal = "b5b4e8f5-e385-4af2-b2af-ecc90497c09a"
    * print sku_temporal
    Given path ruta_crear,"/", sku_temporal,"/"
    And header Accept = 'application/json'
    When method delete
    Then status 404
    And match $ == {"count":'#number',"status":false,"message":"El producto no fue encontrado"} 

        
	Scenario: Intentar eliminar un producto que no existe
    Given path ruta_crear,"/","sku_inexistente","/"  
    And header Accept = 'application/json'
    When method delete
    Then status 404
    And match responseType == 'json'
    And match $ == {"count":'#number',"status": false, "message": "El producto no fue encontrado"}
    
    

    
    
    
    