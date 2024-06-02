-- public.comuna definition

-- Drop table

-- DROP TABLE public.comuna;

CREATE TABLE public.comuna (
	id_comuna serial4 NOT NULL,
	objeto varchar NULL,
	comuna int4 NULL,
	barrios varchar NULL,
	perimetro numeric(16, 7) NULL,
	area numeric(16, 7) NULL,
	CONSTRAINT comuna_pkey PRIMARY KEY (id_comuna)
);


-- public.tipo_acusado definition

-- Drop table

-- DROP TABLE public.tipo_acusado;

CREATE TABLE public.tipo_acusado (
	tipo_acusado varchar NULL,
	id_tipoacusado serial4 NOT NULL,
	CONSTRAINT tipo_acusado_pkey PRIMARY KEY (id_tipoacusado)
);


-- public.tipo_calle definition

-- Drop table

-- DROP TABLE public.tipo_calle;

CREATE TABLE public.tipo_calle (
	tipo_calle varchar NULL,
	id_tipocalle serial4 NOT NULL,
	CONSTRAINT tipo_calle_pkey PRIMARY KEY (id_tipocalle)
);


-- public.tipo_participante definition

-- Drop table

-- DROP TABLE public.tipo_participante;

CREATE TABLE public.tipo_participante (
	tipo_participantes varchar NULL,
	id_tipoparticipante serial4 NOT NULL,
	CONSTRAINT tipo_participante_pkey PRIMARY KEY (id_tipoparticipante)
);


-- public.tipo_rol definition

-- Drop table

-- DROP TABLE public.tipo_rol;

CREATE TABLE public.tipo_rol (
	rol varchar NULL,
	id_tiporol serial4 NOT NULL,
	CONSTRAINT tipo_rol_pkey PRIMARY KEY (id_tiporol)
);


-- public.tipo_victima definition

-- Drop table

-- DROP TABLE public.tipo_victima;

CREATE TABLE public.tipo_victima (
	tipo_victima varchar NULL,
	id_tipovictima serial4 NOT NULL,
	CONSTRAINT tipo_victima_pkey PRIMARY KEY (id_tipovictima)
);


-- public.victimas definition

-- Drop table

-- DROP TABLE public.victimas;

CREATE TABLE public.victimas (
	codigo_siniestro varchar NULL,
	fecha date NULL,
	sexo_victima varchar NULL,
	edad_victima varchar NULL,
	fecha_fallecimiento varchar NULL,
	id_tiporol int4 DEFAULT 0 NULL,
	id_victima serial4 NOT NULL,
	CONSTRAINT homicidios_victimas_pkey PRIMARY KEY (id_victima),
	CONSTRAINT fk_victimas_tipo_rol FOREIGN KEY (id_tiporol) REFERENCES public.tipo_rol(id_tiporol)
);


-- public.siniestros definition

-- Drop table

-- DROP TABLE public.siniestros;

CREATE TABLE public.siniestros (
	cantidad_victimas int4 NULL,
	fecha date NULL,
	hora varchar NULL,
	lugar_hecho varchar NULL,
	direccion_siniestro varchar NULL,
	id_comuna int4 NULL,
	longitud varchar NULL,
	latitud varchar NULL,
	id_tipocalle int4 DEFAULT 0 NULL,
	id_tipoparticipante int4 DEFAULT 0 NULL,
	id_tipovictima int4 DEFAULT 0 NULL,
	id_tipoacusado int4 DEFAULT 0 NULL,
	id_siniestro int4 DEFAULT nextval('public.homicidios_hechos_id_siniestro_seq'::regclass) NOT NULL,
	id_victima int4 DEFAULT 0 NULL,
	edad_etaria varchar DEFAULT '-'::character varying NULL,
	CONSTRAINT homicidios_hechos_pkey PRIMARY KEY (id_siniestro),
	CONSTRAINT fk_siniestro_tipo_acusado FOREIGN KEY (id_tipoacusado) REFERENCES public.tipo_acusado(id_tipoacusado),
	CONSTRAINT fk_siniestro_tipo_participante FOREIGN KEY (id_tipoparticipante) REFERENCES public.tipo_participante(id_tipoparticipante),
	CONSTRAINT fk_siniestro_tipo_victima FOREIGN KEY (id_tipovictima) REFERENCES public.tipo_victima(id_tipovictima),
	CONSTRAINT fk_siniestro_tipocalle FOREIGN KEY (id_tipocalle) REFERENCES public.tipo_calle(id_tipocalle),
	CONSTRAINT fk_siniestros_comuna FOREIGN KEY (id_comuna) REFERENCES public.comuna(id_comuna),
	CONSTRAINT fk_siniestros_victimas FOREIGN KEY (id_victima) REFERENCES public.victimas(id_victima)
);