--
-- PostgreSQL database dump
--

\restrict 4I1boBHPGOTBYyPKp3YOFHfqqSUWI6IKtYTl6nvNakj3TFS512L73XhPgDiePwt

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint,
    product_id bigint,
    quantity bigint,
    price numeric
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint,
    status text
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint,
    product_id bigint,
    quantity bigint,
    price numeric
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint,
    status text,
    total numeric,
    created_at timestamp with time zone,
    razorpay_order_id character varying(100),
    razorpay_payment_id character varying(100),
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    address_id bigint
)


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL,
    stock bigint NOT NULL,
    description text,
    category text,
    image_url text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: user_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_addresses (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    address1 text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    pincode text NOT NULL,
    country text DEFAULT 'India'::text,
    is_default boolean DEFAULT false
);


ALTER TABLE public.user_addresses OWNER TO postgres;

--
-- Name: user_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_addresses_id_seq OWNER TO postgres;

--
-- Name: user_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_addresses_id_seq OWNED BY public.user_addresses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    role text DEFAULT 'customer'::text NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    reset_token text,
    reset_token_expiry timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: user_addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_addresses ALTER COLUMN id SET DEFAULT nextval('public.user_addresses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, quantity, price) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, status) FROM stdin;
1	21	active
2	24	active
3	15	active
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, price) FROM stdin;
1	1	1	1	499
2	2	2	1	899
3	2	1	3	499
4	2	3	3	1499
5	2	5	3	1299
6	3	7	1	1399
7	3	6	2	1999
8	4	9	1	1599
9	4	10	1	1099
10	5	11	1	2299
11	5	12	3	1899
12	6	2	1	899
13	6	4	1	1799
14	7	3	1	1499
15	8	1	1	499
16	8	5	1	1299
17	9	6	1	1999
18	9	10	1	1099
19	10	11	1	2299
20	10	9	1	1599
21	11	2	1	899
22	11	5	1	1299
23	12	5	1	1299
24	12	7	1	1399
25	13	2	1	899
26	13	5	1	1299
27	14	7	1	1399
28	15	2	1	899
29	15	5	1	1299
30	15	8	1	1199
31	16	5	1	1299
32	17	5	1	1299
33	17	3	1	1499
34	18	7	3	1399
35	18	2	1	899
36	19	3	1	1499
37	20	2	1	899
38	20	7	3	1399
39	20	5	1	1299
40	21	8	2	1199
41	21	3	2	1499
42	21	2	2	899
43	22	7	1	1399
44	22	6	1	1999
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, status, total, created_at, razorpay_order_id, razorpay_payment_id, payment_status, address_id) FROM stdin;
1	21	delevered	499	2026-01-30 16:35:23.70269+05:30	order_SD8YDAdMZpqfu0	\N	pending	\N
2	21	pending	10790	2026-03-07 12:54:18.765162+05:30			pending	1
3	21	pending	5397	2026-03-07 13:56:46.861821+05:30			pending	1
4	21	pending	2698	2026-03-07 14:01:37.25835+05:30			pending	1
5	21	pending	7996	2026-03-07 14:15:41.500587+05:30			pending	1
6	21	pending	2698	2026-03-09 10:21:02.857287+05:30			pending	1
7	21	pending	1499	2026-03-09 10:47:59.505172+05:30			pending	1
8	21	pending	1798	2026-03-09 10:48:37.752785+05:30			pending	1
9	21	pending	3098	2026-03-09 11:00:12.039686+05:30			pending	1
10	21	pending	3898	2026-03-09 11:02:42.93928+05:30			pending	1
11	21	pending	2198	2026-03-09 11:17:04.062614+05:30			pending	1
12	21	pending	2698	2026-03-09 11:37:12.282177+05:30	order_SP1RuCaM6C9gUg		pending	1
13	21	paid	2198	2026-03-09 11:37:56.579719+05:30	order_SP1SgKK5RqZ3G3	pay_SP1TIWlGGgUwYR	paid	1
14	21	paid	1399	2026-03-09 11:45:19.393933+05:30	order_SP1aTmMHa0M86I	pay_SP1abHstmoVWUD	paid	1
15	21	paid	3397	2026-03-10 09:25:40.897632+05:30	order_SPNk5rIcBqGnkX	pay_SPNkbx5zKipGL9	paid	1
16	21	paid	1299	2026-03-10 10:14:15.200636+05:30	order_SPOZOw1Xn3B7aY	pay_SPOZVLaalzWZOk	paid	1
17	21	pending	2798	2026-03-10 12:55:40.720396+05:30	order_SPRJvIRk902oLp		pending	1
18	24	paid	5096	2026-03-10 13:36:13.424883+05:30	order_SPS0kWtJn43W9Q	pay_SPS0weHqCq7Bhk	paid	3
19	24	pending	1499	2026-03-10 14:08:06.957262+05:30	order_SPSYRFMi4dc34h		pending	5
20	24	paid	6395	2026-03-11 14:21:40.795046+05:30	order_SPrJsxWFWFZ53l	pay_SPrK1evro6LMZA	paid	3
21	24	paid	7194	2026-03-14 10:39:07.884371+05:30	order_SQz8ADNgHOAaD2	pay_SQz8LjZmiCDrXz	paid	7
22	15	paid	3398	2026-04-03 11:20:02.346142+05:30	order_SYuVmhIbDRouPd	pay_SYuWIwuDbaIR0D	paid	9
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price, stock, description, category, image_url, created_at, updated_at) FROM stdin;
5	Classic Checked Shirt	1299	14	Timeless checkered shirt inspired by old-school fashion.	clothing	/uploads/products/product_5.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-11 14:21:40.803394+05:30
12	Retro Flannel Shirt	1899	11	Warm flannel shirt with traditional vintage style.	clothing	/uploads/products/product_12.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-07 14:15:41.503913+05:30
4	Retro Denim Shirt	1799	14	Vintage washed denim shirt with sturdy fabric.	clothing	/uploads/products/product_4.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-09 10:21:02.866495+05:30
1	Vintage Shirt	499	6	Classic 1950s design	clothing	/uploads/products/product_1.jpg	2025-12-13 20:20:40.029253+05:30	2026-03-09 10:48:37.755999+05:30
10	Old School Half Sleeve Shirt	1099	20	Comfortable half sleeve shirt with retro vibes.	clothing	/uploads/products/product_10.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-09 11:00:12.047974+05:30
11	Vintage Corduroy Shirt	2299	8	Soft corduroy shirt inspired by classic fashion.	clothing	/uploads/products/product_11.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-09 11:02:42.945454+05:30
9	Vintage Printed Shirt	1599	14	Retro printed shirt with unique vintage patterns.	clothing	/uploads/products/product_9.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-09 11:02:42.947839+05:30
8	Classic White Formal Shirt	1199	27	Clean and classic white shirt with vintage cut.	clothing	/uploads/products/product_8.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-14 10:39:07.889065+05:30
3	Vintage 1950s Cotton Shirt	1499	12	Classic 1950s inspired cotton shirt with relaxed fit.	clothing	/uploads/products/product_3.jpg	2026-02-14 13:34:30.193588+05:30	2026-03-14 10:39:07.891623+05:30
2	Retro Denim Shirt	899	6	Classic retro-style denim shirt with vintage wash.	clothing	/uploads/products/product_2.jpg	2026-02-12 20:38:41.351796+05:30	2026-03-14 10:39:07.892059+05:30
7	Retro Striped Shirt	1399	8	Vertical striped shirt inspired by 1950s design.	clothing	/uploads/products/product_7.webp	2026-02-14 13:34:30.193588+05:30	2026-04-03 11:20:02.356562+05:30
6	Vintage Linen Shirt	1999	8	Breathable linen shirt with retro elegance.	clothing	/uploads/products/product_6.jpg	2026-02-14 13:34:30.193588+05:30	2026-04-03 11:20:02.36033+05:30
\.


--
-- Data for Name: user_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_addresses (id, user_id, address1, city, state, pincode, country, is_default) FROM stdin;
1	21	New Street 45	Trivandrum	Kerala	695001	India	f
2	21	pallipparambath,pathiyarakkara	vadakara	Kerala	673105	India	f
3	24	cuigyfdghkc	ejhkujgd	deuhkdij	673105	India	f
4	24					India	f
5	24	iyutyftdrsewretyughj	ejhkujgd	Kerala	673105	India	f
6	24	iyutyftdrsewretyughj	ejhkujgd	Kerala	673105	India	f
7	24	iyutyftdrsewretyughj	ejhkujgd	Kerala	673105	India	f
8	24	iyutyftdrsewretyughj	ejhkujgd	Kerala	673105	India	f
9	15	iyutyftdrsewretyughj	ejhkujgd	Kerala	673105	India	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, role, is_active, created_at, updated_at, reset_token, reset_token_expiry) FROM stdin;
1	nidan@gmail.com	$2a$10$1MxiW5xj8EQbuouY0Fjn4OerqqaRZWp5vbSVFOCNBZY1P3nYEpxIG	customer	t	2025-11-21 17:17:13.425546+05:30	2025-11-21 17:17:13.425546+05:30	\N	\N
4	Shahal@gmail.com	$2a$10$6VT.p.QLnYItVNU6aDjC2eTumHJ8I5lA4vC7pRjd517oeEC7Xe55W	customer	t	2025-11-22 12:42:46.170851+05:30	2025-11-22 12:42:46.170851+05:30	\N	\N
5	test@example.com	$2a$10$B1ENneIonwUH/xv0lMMsFuV0Oms59hIIs8kXWX/KVqewPZGJzWJUK	customer	t	2025-11-27 15:35:26.739598+05:30	2025-11-27 15:35:26.739598+05:30	\N	\N
9	shahal@gmail.com	$2a$10$WYmyP3NN46sNjbcqBfq6F.iWogdRFhfGxvXSf4dFhLg9CXtErwo/e	customer	t	2025-11-28 11:16:03.468957+05:30	2025-11-28 11:16:03.468957+05:30	\N	\N
16	rasal@gmail.com	$2a$10$9gqhPKLwRcvtVS2/4HRtE.KMCxZMNaUod.H9jt92tZysYT.LsOoMG	customer	t	2025-12-02 15:36:37.396693+05:30	2025-12-02 15:36:37.396693+05:30	\N	\N
18	aasha@gmail.com	$2a$10$g2Ps1O8qMQxCWlsnm3Hau.RsavQvd7VR8taRnga/RB2Zmnjg7M7A6	customer	t	2026-01-05 15:11:34.105316+05:30	2026-01-05 15:11:34.105316+05:30	\N	\N
20	shahalll@gmail.com	$2a$10$XAOgonhozm/e1.RNCML70ex5ZafwsSGwIR0n2xq/KM3SsZMR1r8gm	customer	t	2026-01-23 18:14:04.193873+05:30	2026-01-23 18:14:04.193873+05:30	\N	\N
21	Shahalll@gmail.com	$2a$10$SxJo8IJut6BLnnaDcT8gsuvAFcusTP4ZzvX8dZUCPlvu.oPgKcjg6	admin	t	2026-01-23 18:39:16.111738+05:30	2026-01-23 18:39:16.111738+05:30	\N	\N
15	rahul@gmail.com	$2a$10$4lzXlBg4rSI5brzOjRlKpOv1/j02lH1erWnKjWekjjObmBeiZ.Cj6	customer	t	2025-11-28 14:27:16.081026+05:30	2025-11-28 14:27:16.081026+05:30	\N	\N
22	edwerdlivingston333@gmail.com	$2a$10$WVdH/7i.VewL4xyUfe3ncuTMGC09iajrQ7hzNNuwFIFiFBCSjnkXu	admin	t	2026-02-12 18:50:28.590341+05:30	2026-02-12 18:50:28.590341+05:30		\N
8	mhdsahalfxo2@gmail.com	$2a$10$kG/GAeo0AChPuhWPmCtEyevJtlzaR8l5TI3rL2c3dsAh2Oma1BGTG	customer	t	2025-11-28 11:12:25.738825+05:30	2026-02-14 12:57:26.013568+05:30		\N
24	arjun@gmail.com	$2a$10$CBtebFsQ2QlkLyp1NfYE8.qfdmmxvSoU41rzd7FcvcIoLxR6Rfja6	customer	t	2026-03-10 12:58:15.490807+05:30	2026-03-10 12:58:15.490807+05:30		\N
\.


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 58, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 3, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 44, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 22, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 12, true);


--
-- Name: user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_addresses_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 24, true);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: user_addresses user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_addresses
    ADD CONSTRAINT user_addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_orders_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_address_id ON public.orders USING btree (address_id);


--
-- Name: idx_orders_razorpay_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_razorpay_order_id ON public.orders USING btree (razorpay_order_id);


--
-- Name: idx_orders_razorpay_payment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_razorpay_payment_id ON public.orders USING btree (razorpay_payment_id);


--
-- Name: idx_user_addresses_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_addresses_user_id ON public.user_addresses USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_reset_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_reset_token ON public.users USING btree (reset_token);


--
-- Name: idx_users_reset_token_expiry; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_reset_token_expiry ON public.users USING btree (reset_token_expiry);


--
-- Name: cart_items fk_cart_items_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_product FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: cart_items fk_carts_items; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_carts_items FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: order_items fk_orders_order_items; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_orders_order_items FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 4I1boBHPGOTBYyPKp3YOFHfqqSUWI6IKtYTl6nvNakj3TFS512L73XhPgDiePwt

