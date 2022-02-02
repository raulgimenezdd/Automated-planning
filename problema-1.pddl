(define (problem pacientes_trivial)
    (:domain pacientes)
    (:objects  
        hora0 hora1 hora2 hora3 hora4 - Hora
        base enfermeria hab0 hab1 puerta0 puerta1 - Lugar
        paciente0 paciente1 - Paciente
    )
    (:init
        (robot_en base)
        (carga_en base)
        (lugar_desinfeccion enfermeria)
        (hora_actual hora0)
        (hora_siguiente hora0 hora1)
        (hora_siguiente hora1 hora2)
        (hora_siguiente hora2 hora3)
        (hora_siguiente hora3 hora4)
        (paciente_en paciente0 hab0)
        (paciente_en paciente1 hab1)
        (videollamada_pendiente paciente0 hora1)
        (videollamada_pendiente paciente1 hora3)
        (puerta_habitacion puerta0 hab0)
        (puerta_habitacion puerta1 hab1)
        (es_habitacion hab0)
        (es_habitacion hab1)
    )
    (:goal
        (and
            (videollamada_terminada paciente1 hora3)
            (robot_en base)
        )
    )
)