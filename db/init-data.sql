CREATE TABLE IF NOT EXISTS incidents (
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    status      VARCHAR(50)  NOT NULL DEFAULT 'OPEN',
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO incidents (title, description, status, created_at) VALUES
('Servidor de aplicaciones caido',       'El servidor principal no responde desde las 08:00. Afecta a todos los usuarios.', 'OPEN',        NOW() - INTERVAL '3 hours'),
('Base de datos lenta en produccion',    'Las consultas al modulo de creditos tardan mas de 30 segundos. Causa timeouts.', 'IN_PROGRESS',  NOW() - INTERVAL '2 hours'),
('Red interna inestable',                'Paquetes perdiendose intermitentemente en la sede central. Afecta VoIP y ERP.',   'IN_PROGRESS',  NOW() - INTERVAL '5 hours'),
('Fallo en autenticacion de usuarios',   'El servicio LDAP no valida credenciales. Usuarios bloqueados del sistema.',       'OPEN',         NOW() - INTERVAL '1 hour'),
('Servicio de pagos no responde',        'Las transacciones con tarjeta son rechazadas. Perdidas estimadas en curso.',      'OPEN',         NOW() - INTERVAL '30 minutes'),
('Error en backup nocturno',             'El job de backup automatico fallo a las 02:00. Sin respaldo desde ayer.',         'RESOLVED',     NOW() - INTERVAL '6 hours'),
('CPU al 100% en servidor de reportes',  'Proceso Java consume todos los recursos. Los reportes no cargan.',                'IN_PROGRESS',  NOW() - INTERVAL '4 hours'),
('Sin conectividad VPN sede Ica',        'Empleados de la sede Ica sin acceso remoto a los sistemas centrales.',            'OPEN',         NOW() - INTERVAL '2 hours'),
('Certificado SSL vencido en portal web','El certificado del portal expiro. Los navegadores muestran advertencia de riesgo.','OPEN',        NOW() - INTERVAL '45 minutes'),
('Disco lleno en servidor de archivos',  'El servidor NAS llego al 100% de capacidad. No se pueden guardar documentos.',   'RESOLVED',     NOW() - INTERVAL '7 hours');
