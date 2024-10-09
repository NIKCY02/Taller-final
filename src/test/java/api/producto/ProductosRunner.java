package api.producto;

import com.intuit.karate.junit5.Karate;

public class ProductosRunner {

	@Karate.Test
	Karate testProductos() {
		return Karate.run("insertar").relativeTo(getClass());
	}
}
