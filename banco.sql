--
-- PostgreSQL database dump
--

\restrict JXzaNMr3bHsUzfFDvHPmUqjQUHaWrP7pK1uhr2MIRmyHOEdza4qBtu65mE1GLdU

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aluno_treinador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aluno_treinador (
    aluno_id integer NOT NULL,
    treinador_id integer
);


ALTER TABLE public.aluno_treinador OWNER TO postgres;

--
-- Name: aluno_treino; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aluno_treino (
    aluno_id integer NOT NULL,
    treino_id integer NOT NULL,
    dia_semana character varying(15),
    horario time without time zone,
    ativo boolean DEFAULT true,
    id integer NOT NULL
);


ALTER TABLE public.aluno_treino OWNER TO postgres;

--
-- Name: aluno_treino_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aluno_treino_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aluno_treino_id_seq OWNER TO postgres;

--
-- Name: aluno_treino_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aluno_treino_id_seq OWNED BY public.aluno_treino.id;


--
-- Name: exercicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercicios (
    exercicio_id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    descricao text NOT NULL,
    video_url text NOT NULL,
    treino_id integer NOT NULL
);


ALTER TABLE public.exercicios OWNER TO postgres;

--
-- Name: exercicios_exercicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercicios_exercicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercicios_exercicio_id_seq OWNER TO postgres;

--
-- Name: exercicios_exercicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercicios_exercicio_id_seq OWNED BY public.exercicios.exercicio_id;


--
-- Name: historico_treino; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico_treino (
    historico_id integer NOT NULL,
    aluno_id integer NOT NULL,
    treino_id integer NOT NULL,
    data date NOT NULL,
    tempo_minutos integer,
    calorias integer,
    estato character varying(20) DEFAULT 'Conclu¡do'::character varying
);


ALTER TABLE public.historico_treino OWNER TO postgres;

--
-- Name: historico_treino_historico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_treino_historico_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_treino_historico_id_seq OWNER TO postgres;

--
-- Name: historico_treino_historico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_treino_historico_id_seq OWNED BY public.historico_treino.historico_id;


--
-- Name: treinos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treinos (
    treino_id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    descricao text NOT NULL,
    treinador_id integer NOT NULL
);


ALTER TABLE public.treinos OWNER TO postgres;

--
-- Name: treinos_treino_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treinos_treino_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treinos_treino_id_seq OWNER TO postgres;

--
-- Name: treinos_treino_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treinos_treino_id_seq OWNED BY public.treinos.treino_id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    user_id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    senha_hash text NOT NULL,
    tipo_user character varying(20) NOT NULL,
    email_verificado boolean DEFAULT false,
    tokem_verifica character varying(255)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_user_id_seq OWNER TO postgres;

--
-- Name: usuarios_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_user_id_seq OWNED BY public.usuarios.user_id;


--
-- Name: aluno_treino id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treino ALTER COLUMN id SET DEFAULT nextval('public.aluno_treino_id_seq'::regclass);


--
-- Name: exercicios exercicio_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios ALTER COLUMN exercicio_id SET DEFAULT nextval('public.exercicios_exercicio_id_seq'::regclass);


--
-- Name: historico_treino historico_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_treino ALTER COLUMN historico_id SET DEFAULT nextval('public.historico_treino_historico_id_seq'::regclass);


--
-- Name: treinos treino_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos ALTER COLUMN treino_id SET DEFAULT nextval('public.treinos_treino_id_seq'::regclass);


--
-- Name: usuarios user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN user_id SET DEFAULT nextval('public.usuarios_user_id_seq'::regclass);


--
-- Data for Name: aluno_treinador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aluno_treinador (aluno_id, treinador_id) FROM stdin;
1	2
\.


--
-- Data for Name: aluno_treino; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aluno_treino (aluno_id, treino_id, dia_semana, horario, ativo, id) FROM stdin;
1	1	Segunda-feira	04:00:00	t	1
1	2	Terça-feira	04:00:00	t	2
1	4	Sábado	04:00:00	t	3
1	1	Quinta-feira	05:00:00	t	4
1	4	Sexta-feira	10:00:00	t	5
1	1	Segunda-feira	10:00:00	t	6
1	3	Domingo	15:45:00	t	8
1	3	Sexta-feira	18:08:00	t	9
\.


--
-- Data for Name: exercicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercicios (exercicio_id, titulo, descricao, video_url, treino_id) FROM stdin;
1	braçoteste	teste1	https://youtube.com/shorts/vtuH7lNA-Ro?si=ZhI09Ot7fdWEE0yu	1
2	teste1	braço	https://youtube.com/shorts/vtuH7lNA-Ro?si=ZhI09Ot7fdWEE0yu	1
3	testenumero3	aaa	https://youtube.com/shorts/vtuH7lNA-Ro?si=5T_OhA_XNMOoyGrd	1
4	titulo	lala	https://www.youtube.com/shorts/vtuH7lNA-Ro?si=ZhI09Ot7fdWEE0yu	4
\.


--
-- Data for Name: historico_treino; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_treino (historico_id, aluno_id, treino_id, data, tempo_minutos, calorias, estato) FROM stdin;
1	1	1	2026-07-29	50	400	Conclu¡do
\.


--
-- Data for Name: treinos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treinos (treino_id, titulo, descricao, treinador_id) FROM stdin;
1	testeBraço	Braço	2
2	braço2	teste2	2
3	treino3	teste treino numero 3\n	2
4	titulo	laala	2
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (user_id, nome, email, senha_hash, tipo_user, email_verificado, tokem_verifica) FROM stdin;
1	teste1	teste1@gmail.com	$2b$10$7FZiLd3xc/72r/5Jc0t5dOL8ert0jIEQcaIn8F0pxn54f1146aMQ6	aluno	t	\N
2	treinador00	teste2@gmail.com	$2b$10$32oIgqkVXGmyMe1/vL4jp.IZFm5oUPSUk2UbtIzZNQtUggpfVkCIe	treinador	t	\N
3	arton	artondelima123@gmail.com	$2b$10$/rudRII7aNYW9j7f5T48ZOFcvq3aUCSfEhkw0wYmkRyT3/GwwEzrm	treinador	t	\N
\.


--
-- Name: aluno_treino_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aluno_treino_id_seq', 9, true);


--
-- Name: exercicios_exercicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercicios_exercicio_id_seq', 8, true);


--
-- Name: historico_treino_historico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_treino_historico_id_seq', 1, true);


--
-- Name: treinos_treino_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treinos_treino_id_seq', 6, true);


--
-- Name: usuarios_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_user_id_seq', 3, true);


--
-- Name: aluno_treinador aluno_treinador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treinador
    ADD CONSTRAINT aluno_treinador_pkey PRIMARY KEY (aluno_id);


--
-- Name: aluno_treinador aluno_treinador_unico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treinador
    ADD CONSTRAINT aluno_treinador_unico UNIQUE (aluno_id, treinador_id);


--
-- Name: aluno_treino aluno_treino_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treino
    ADD CONSTRAINT aluno_treino_pkey PRIMARY KEY (id);


--
-- Name: exercicios exercicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios
    ADD CONSTRAINT exercicios_pkey PRIMARY KEY (exercicio_id);


--
-- Name: historico_treino historico_treino_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_treino
    ADD CONSTRAINT historico_treino_pkey PRIMARY KEY (historico_id);


--
-- Name: aluno_treino horario_aluno_unico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treino
    ADD CONSTRAINT horario_aluno_unico UNIQUE (aluno_id, dia_semana, horario);


--
-- Name: treinos treinos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos
    ADD CONSTRAINT treinos_pkey PRIMARY KEY (treino_id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (user_id);


--
-- Name: aluno_treinador aluno_treinador_aluno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treinador
    ADD CONSTRAINT aluno_treinador_aluno_id_fkey FOREIGN KEY (aluno_id) REFERENCES public.usuarios(user_id);


--
-- Name: aluno_treinador aluno_treinador_treinador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treinador
    ADD CONSTRAINT aluno_treinador_treinador_id_fkey FOREIGN KEY (treinador_id) REFERENCES public.usuarios(user_id);


--
-- Name: aluno_treino aluno_treino_aluno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treino
    ADD CONSTRAINT aluno_treino_aluno_id_fkey FOREIGN KEY (aluno_id) REFERENCES public.usuarios(user_id);


--
-- Name: aluno_treino aluno_treino_treino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_treino
    ADD CONSTRAINT aluno_treino_treino_id_fkey FOREIGN KEY (treino_id) REFERENCES public.treinos(treino_id);


--
-- Name: exercicios exercicios_treino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercicios
    ADD CONSTRAINT exercicios_treino_id_fkey FOREIGN KEY (treino_id) REFERENCES public.treinos(treino_id);


--
-- Name: historico_treino historico_treino_aluno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_treino
    ADD CONSTRAINT historico_treino_aluno_id_fkey FOREIGN KEY (aluno_id) REFERENCES public.usuarios(user_id);


--
-- Name: historico_treino historico_treino_treino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_treino
    ADD CONSTRAINT historico_treino_treino_id_fkey FOREIGN KEY (treino_id) REFERENCES public.treinos(treino_id);


--
-- Name: treinos treinos_treinador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treinos
    ADD CONSTRAINT treinos_treinador_id_fkey FOREIGN KEY (treinador_id) REFERENCES public.usuarios(user_id);


--
-- PostgreSQL database dump complete
--

\unrestrict JXzaNMr3bHsUzfFDvHPmUqjQUHaWrP7pK1uhr2MIRmyHOEdza4qBtu65mE1GLdU

