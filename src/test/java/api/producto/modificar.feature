@actualizar
Feature: Actualizar un producto usando la API /api/v1/product/

	Background:
    * url 'http://localhost:8081'
    * def ruta_crear = '/api/v1/product/'
		* def result = callonce read('nuevo.feature')
		* print result.response
      
	Scenario Outline: Actualizar un producto de forma exitosa
    Given path ruta_crear,"/",result.response.sku,"/"
    And request <producto>
    And header Accept = 'application/json'
    When method put
    Then status 200
    And match responseType == 'json'
    And match $ == {"sku":'#notnull',"status":true,"message":"El producto fue actualizado con éxito"} 
	Examples:
	| producto   |
	| { name: 'Iphone Actualizado', description: 'Este es un smartphone de alta gama', price: 9999 } |
	| { name: 'Iphone 99', description: 'Descripcion Actualizada', price: 9999 }  |
	| { name: 'Iphone 99', description: 'Este es un smartphone de alta gama', price: 90000 } |