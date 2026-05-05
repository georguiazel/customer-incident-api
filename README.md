# customer-incident-api

API REST para el registro y consulta de incidentes tecnológicos internos
---

## Descripción de la solución 

Sistema Backend desarrollado con **Spring Boot** que expone una 
API REST para gestionar incidentes tecnológicos. 
Permite registrar nuevos incidentes, listarlos y consultarlos por ID. 
La solución está completamente contenerizada con Docker y lista para ejecutarse con el comando `docker compose up --build` o `docker compose up --build -d`

---

## Tecnologías utilizadas

| Tecnología | Versión |
|---|--|
| Java | `java 11.0.24 2024-07-16 LTS` |
| Spring Boot | `4.0.6` |
| Spring Data JPA | 
| Hibernate |  | 
| PostgreSQL | 16 | 
| Gradle | `9.4.1` | 
| Docker | `29.3.0-1` |

---

## Instrucciones de ejecución

### Requisitos previos

- Docker Desktop instalado con el plugin de Docker-Compose
- Puerto `8080` y `5432` disponibles en la máquina
- Java instalado en su version `11`

### Levantar toda la solución

```bash
docker-compose up --build -d
```

### Detener los servicios

```bash
docker-compose down
```

### Detener y eliminar volúmenes

```bash
`docker-compose down --volumes`
docker-compose up --build
```

> Al eliminar el volumen, el script `db/init-data.sql` vuelve a ejecutarse y recarga los 10 incidentes de ejemplo.

---

## Variables requeridas

Definidas en `docker-compose.yml` bajo el servicio `app`:

| Variable de entorno | Valor por defecto                         | Descripción |
|---|-------------------------------------------|---|
| `SPRING_DATASOURCE_URL` | `jdbc:postgresql://db:5432/incidents_db`  | URL de conexión a PostgreSQL |
| `SPRING_DATASOURCE_USERNAME` | `postgres`                                | Usuario de la base de datos |
| `SPRING_DATASOURCE_PASSWORD` | `a9@br@H56*3GrzH123SED`                   | Contraseña de la base de datos |
| `SPRING_DATASOURCE_DRIVER_CLASS_NAME` | `org.postgresql.Driver`                   | Driver JDBC |
| `SPRING_JPA_DATABASE_PLATFORM` | `org.hibernate.dialect.PostgreSQLDialect` | Dialecto Hibernate |
| `SPRING_JPA_HIBERNATE_DDL_AUTO` | `update`                                  | Estrategia de esquema |
| `SPRING_JPA_SHOW_SQL` | `true`                                    | Muestra SQL en consola |

Variables del servicio `db`:

| Variable de entorno | Valor | Descripción |
|---|---|---|
| `POSTGRES_DB` | `incidents_db` | Nombre de la base de datos |
| `POSTGRES_USER` | `postgres` | Usuario administrador |
| `POSTGRES_PASSWORD` | `a9@br@H56*3GrzH123SED` | Contraseña administrador |

---

## Endpoints disponibles

Base URL: `http://localhost:8080`

### Registrar incidente

```
POST /incidents
```

**Body (JSON):**
```json
{
  "title": "Servidor caido",
  "description": "El servidor principal no responde desde las 08:00",
  "status": "OPEN"
}
```

- `title` es obligatorio
- `status` es opcional, valor por defecto: `OPEN`
- Valores válidos para `status`: `OPEN`, `IN_PROGRESS`, `RESOLVED`

**Respuesta exitosa `201 Created`:**
```json
{
  "id": 1,
  "title": "Servidor caido",
  "description": "El servidor principal no responde desde las 08:00",
  "status": "OPEN",
  "createdAt": "2026-05-04T10:30:00"
}
```

---

### Listar todos los incidentes

```
GET /incidents
```

**Respuesta exitosa `200 OK`:**
```json
[
  {
    "id": 1,
    "title": "Servidor caido",
    "description": "El servidor principal no responde desde las 08:00",
    "status": "OPEN",
    "createdAt": "2026-05-04T10:30:00"
  }
]
```

---

### Consultar incidente por ID

```
GET /incidents/{id}
```

**Ejemplo:** `GET /incidents/1`

**Respuesta exitosa `200 OK`:**
```json
{
  "id": 1,
  "title": "Servidor caido",
  "description": "El servidor principal no responde desde las 08:00",
  "status": "OPEN",
  "createdAt": "2026-05-04T10:30:00"
}
```

**Respuesta si no existe `404 Not Found`:**
```
Incidente no encontrado con id: 1
```

---

## Estructura del proyecto

```
customer-incident-api/
├── db/
│   └── init-data.sql                  # Script SQL con datos iniciales
├── src/main/java/com/customer/api/
│   ├── controller/
│   │   └── IncidentController.java    # Endpoints REST
│   ├── model/
│   │   └── Incident.java              # Entidad JPA
│   ├── repository/
│   │   └── IncidentRepository.java    # Acceso a datos
│   ├── service/
│   │   └── IncidentService.java       # Lógica de negocio
│   └── CustomerIncidentApiApplication.java
├── src/main/resources/
│   └── application.properties
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
└── build.gradle
```

---

## Supuestos y limitaciones

- **API REST Sin autenticación:** No implementa seguridad ni autenticación con servicios como JWT.
- **Sin paginación:** El endpoint `GET /incidents` retorna todos los registros sin paginación. Para volúmenes grandes de datos se normalmente se usa la clase `Pageable`.
- Solo se implementaron los endpoints requeridos (`POST`, `GET` , `GET` por ID).
- **Validación mínima:** Solo se valida que el campo `title` no sea vacío.
- El script `db/init-data.sql` aplica únicamente cuando se usa Docker Compose con volumen vacío. Para conectarse a un entorno de base de datos en production se usan secrets o configuracion en`application.properties`
