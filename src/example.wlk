/** First Wollok example */
class Habitante {
	var property valentia
	var property inteligencia
	
	method poder(){
		return valentia + inteligencia
	}
	
	
}

class Soldado inherits Habitante{
	var property equipamiento = []
	
	override method poder(){
		return super() + self.potenciaEquipamiento()
	}
	method potenciaEquipamiento(){
		return equipamiento.sum{arma => arma.potencia()}
		
	}
}

class Arma{
	var property potencia
}


class Maestros inherits Habitante{
	var property midclorianos
	var property fuerza
	var sableLuz
	override method poder(){
		return super() + midclorianos/1000 + fuerza.potenciaDeSable(sableLuz)
	}
	
	method viveSuceso(suceso){
		fuerza.vivirSuceso(suceso,self)
	}
}

class Fuerza{
	var antiguedad = 1
	
	method pasarTiempo(){
		antiguedad += 1
	}
	method afectoSuceso(suceso, maestro)	
	
	method vivirSuceso(suceso, maestro){
		self.pasarTiempo()
		self.afectoSuceso(suceso, maestro)
	}
}

class LadoOscuro inherits Fuerza{
	var property odioInterno = 10
	
	method alterarOdio(){
		odioInterno += odioInterno*0.1
	}
	
	override method afectoSuceso(suceso, maestro){
		if (suceso.cargaEmocional() > odioInterno)
			maestro.fuerza(new LadoLuz())
		else
			self.alterarOdio()
	}
	method potenciaDeSable(sable){
		return sable.potencia()*2 + antiguedad
	}
		
	
}
class LadoLuz inherits Fuerza{
	var property pazInterior = 100
	
	method alterarPaz(valor){
		pazInterior = pazInterior + valor
	}
	method noTienePaz(){
		return pazInterior <= 0
	}
	override method afectoSuceso(suceso, maestro){
		self.alterarPaz(suceso.cargaEmocional())
		if (self.noTienePaz())
			maestro.fuerza(new LadoOscuro())		
	}
	method potenciaDeSable(sable){
		return sable.potencia() * antiguedad
	}
}

class Suceso{
	var property cargaEmocional
}


class Planeta{
	var property habitantes
	
	method poderPlaneta(){
		return self.obtenerPoder(habitantes)
	}
	
	method obtenerPoder(personas){
		return personas.sum{persona => persona.poder()}
	}
	method masPoderosos() {
		return habitantes.sortedBy({ primerHabitante, segundoHabitante =>
			primerHabitante.poder() > segundoHabitante.poder()
		}).take(3)
	}
	method poderDeLosMasPoderosos(){
		return self.obtenerPoder(self.masPoderosos())
	}
	method tieneOrden(){
		return self.poderDeLosMasPoderosos() >= self.poderPlaneta()/2
	}
}
