@ignore
	Feature: Escenario reutilizable para crear un nuevo producto
	Scenario: Crear un producto de forma exitosa
    Given url 'http://localhost:8081/api/v1/product/'
    And request { name: 'Iphone 12', description: 'Este es un smartphone de alta gama', price: 1200 }
    And header Accept = 'application/json'
    And header Authorization = 'Bearer aGFzaGRzZnNkZnNkZnNkZnNk'
    When method post
    Then status 201