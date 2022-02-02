(define (domain pacientes)
  (:types  
    lugar
    hora
    paciente
	)

  (:predicates
    (robot_en ?l - lugar)
    (carga_en ?l - lugar)
    (lugar_desinfeccion ?l - lugar)
    (robot_desinfectado)
    (hora_actual ?h - hora)
    (hora_siguiente ?ha - hora ?hs - hora)
    (videollamada_pendiente ?p - paciente ?hora - hora)
    (videollamada_cancelada ?p - paciente ?hora - hora ?hora_c - hora)
    (videollamada_terminada ?p - paciente ?hora - hora)
    (paciente_en ?p - paciente ?l - lugar)
    (paciente_saludado ?p - paciente)
    (puerta_habitacion ?p - lugar ?h - lugar)
    (puerta_abierta ?p - lugar)
    (es_habitacion ?l - lugar)
    (obstaculo_en ?l - lugar)
    (necesita_desinfeccion)
  )

(:action desinfectar
  :parameters (?p - paciente ?h - hora ?l - lugar)
  :precondition (and 
        (robot_en ?l)
        (lugar_desinfeccion ?l)
        (videollamada_pendiente ?p ?h)
        (hora_actual ?h)
        (not (robot_desinfectado))
        (not (obstaculo_en ?l))
		)
  :effect (and  
		(robot_desinfectado)
		)
)

(:action pasa_tiempo
  :parameters (?h - hora ?hs - hora ?l - lugar)
  :precondition (and 
        (robot_en ?l)
        (carga_en ?l)
        (hora_actual ?h)
		(hora_siguiente ?h ?hs)
		)
  :effect (and  
		(not (hora_actual ?h))
		(hora_actual ?hs)
		)
)

(:action mover
  :parameters (?l1 - lugar ?l2 - lugar)
  :precondition (and
        (not (necesita_desinfeccion))
        (not (obstaculo_en ?l1))
        (robot_en ?l1)
        (not (es_habitacion ?l2))
        (not (es_habitacion ?l1))
		)
  :effect (and  
		(not (robot_en ?l1))
		(robot_en ?l2)
		)
)

(:action entrar_habitacion
  :parameters (?p - lugar ?h - lugar)
  :precondition (and 
        (not (obstaculo_en ?p))
        (robot_en ?p)
        (puerta_abierta ?p)
        (puerta_habitacion ?p ?h)
		)
  :effect (and  
		(not (robot_en ?p))
		(robot_en ?h)
		)
)

(:action salir_habitacion
  :parameters (?h - lugar ?p - lugar)
  :precondition (and 
        (robot_en ?h)
        (es_habitacion ?h)
        (puerta_habitacion ?p ?h)
		)
  :effect (and  
		(not (robot_en ?h))
		(robot_en ?p)
		(necesita_desinfeccion)
		(not (puerta_abierta ?p))
		)
)

(:action solicitar_desinfeccion
  :parameters ()
  :precondition (and 
        (necesita_desinfeccion)
		)
  :effect (and  
		(not (necesita_desinfeccion))
		(robot_desinfectado)
		)
)

(:action solicitar_puerta
  :parameters (?p - lugar ?h - hora ?pac - paciente ?hab - lugar)
  :precondition (and 
        (not (obstaculo_en ?p))
        (robot_desinfectado)
        (robot_en ?p)
        (hora_actual ?h)    
        (paciente_en ?pac ?hab)
        (puerta_habitacion ?p ?hab)
        (videollamada_pendiente ?pac ?h)
        (not (puerta_abierta ?p))
		)
  :effect (and  
		(puerta_abierta ?p)
		)
)

(:action solicitar_obstaculo
  :parameters (?p - lugar)
  :precondition (and 
        (robot_en ?p)
        (obstaculo_en ?p)
		)
  :effect (and  
		(not (obstaculo_en ?p))
		)
)


(:action saludar_paciente
  :parameters (?hab - lugar ?p - paciente ?h - hora)
  :precondition (and 
        (not (obstaculo_en ?hab))
        (robot_desinfectado)
        (robot_en ?hab)
        (paciente_en ?p ?hab)
        (videollamada_pendiente ?p ?h)
        (hora_actual ?h)
        (not (paciente_saludado ?p))
		)
  :effect (and  
		(paciente_saludado ?p)
		)
)

(:action cancelar_videollamada
  :parameters (?p - paciente ?h - hora ?hc - hora)
  :precondition (and 
        (videollamada_cancelada ?p ?h ?hc)
        (videollamada_pendiente ?p ?h)
        (hora_actual ?hc)
		)
  :effect (and  
		(not (videollamada_pendiente ?p ?h))
		(videollamada_terminada ?p ?h)
		)
)

(:action atender_paciente
  :parameters (?hab - lugar ?p - paciente ?h - hora ?hora_s - hora)
  :precondition (and 
        (not (obstaculo_en ?hab))
        (paciente_saludado ?p)
        (robot_desinfectado)
        (robot_en ?hab)
        (paciente_en ?p ?hab)
        (videollamada_pendiente ?p ?h)
        (hora_actual ?h)
        (hora_siguiente ?h ?hora_s)
		)
  :effect (and  
		(not (videollamada_pendiente ?p ?h))
		(videollamada_terminada ?p ?h)
        (not (robot_desinfectado))
        (not (hora_actual ?h))
		(hora_actual ?hora_s)
		)
)

)
