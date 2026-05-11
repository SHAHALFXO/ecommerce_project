--
-- PostgreSQL database dump
--

\restrict ZjmBDKZSzdxt17DDru2KTyCwJ8s4cMmFPh2zm7uVmvvot0TkdviY21PCvvgljE9

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
    address_id bigint,
    created_at timestamp with time zone,
    razorpay_order_id character varying(100),
    razorpay_payment_id character varying(100),
    payment_status character varying(20) DEFAULT 'pending'::character varying
);


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
    reset_token text,
    reset_token_expiry timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
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



--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.carts VALUES (1, 21, 'active');
INSERT INTO public.carts VALUES (2, 24, 'active');
INSERT INTO public.carts VALUES (3, 15, 'active');
INSERT INTO public.carts VALUES (4, 22, 'active');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items VALUES (45, 23, 9, 1, 1599);
INSERT INTO public.order_items VALUES (46, 24, 4, 1, 1799);
INSERT INTO public.order_items VALUES (47, 25, 10, 1, 1099);
INSERT INTO public.order_items VALUES (48, 25, 1, 1, 499);
INSERT INTO public.order_items VALUES (49, 25, 12, 1, 1899);
INSERT INTO public.order_items VALUES (50, 26, 8, 1, 1199);
INSERT INTO public.order_items VALUES (51, 26, 3, 1, 1499);
INSERT INTO public.order_items VALUES (52, 27, 2, 1, 899);
INSERT INTO public.order_items VALUES (53, 28, 7, 1, 1399);
INSERT INTO public.order_items VALUES (54, 28, 6, 1, 1999);
INSERT INTO public.order_items VALUES (55, 29, 9, 1, 1599);
INSERT INTO public.order_items VALUES (56, 29, 8, 1, 1199);
INSERT INTO public.order_items VALUES (57, 30, 4, 1, 1799);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (5, 21, 'pending', 7996, 1, '2026-03-07 08:45:41.500587+00', '', '', 'pending');
INSERT INTO public.orders VALUES (6, 21, 'pending', 2698, 1, '2026-03-09 04:51:02.857287+00', '', '', 'pending');
INSERT INTO public.orders VALUES (8, 21, 'pending', 1798, 1, '2026-03-09 05:18:37.752785+00', '', '', 'pending');
INSERT INTO public.orders VALUES (9, 21, 'pending', 3098, 1, '2026-03-09 05:30:12.039686+00', '', '', 'pending');
INSERT INTO public.orders VALUES (10, 21, 'pending', 3898, 1, '2026-03-09 05:32:42.93928+00', '', '', 'pending');
INSERT INTO public.orders VALUES (11, 21, 'pending', 2198, 1, '2026-03-09 05:47:04.062614+00', '', '', 'pending');
INSERT INTO public.orders VALUES (12, 21, 'pending', 2698, 1, '2026-03-09 06:07:12.282177+00', 'order_SP1RuCaM6C9gUg', '', 'pending');
INSERT INTO public.orders VALUES (13, 21, 'paid', 2198, 1, '2026-03-09 06:07:56.579719+00', 'order_SP1SgKK5RqZ3G3', 'pay_SP1TIWlGGgUwYR', 'paid');
INSERT INTO public.orders VALUES (14, 21, 'paid', 1399, 1, '2026-03-09 06:15:19.393933+00', 'order_SP1aTmMHa0M86I', 'pay_SP1abHstmoVWUD', 'paid');
INSERT INTO public.orders VALUES (15, 21, 'paid', 3397, 1, '2026-03-10 03:55:40.897632+00', 'order_SPNk5rIcBqGnkX', 'pay_SPNkbx5zKipGL9', 'paid');
INSERT INTO public.orders VALUES (16, 21, 'paid', 1299, 1, '2026-03-10 04:44:15.200636+00', 'order_SPOZOw1Xn3B7aY', 'pay_SPOZVLaalzWZOk', 'paid');
INSERT INTO public.orders VALUES (17, 21, 'pending', 2798, 1, '2026-03-10 07:25:40.720396+00', 'order_SPRJvIRk902oLp', '', 'pending');
INSERT INTO public.orders VALUES (18, 24, 'paid', 5096, 3, '2026-03-10 08:06:13.424883+00', 'order_SPS0kWtJn43W9Q', 'pay_SPS0weHqCq7Bhk', 'paid');
INSERT INTO public.orders VALUES (19, 24, 'pending', 1499, 5, '2026-03-10 08:38:06.957262+00', 'order_SPSYRFMi4dc34h', '', 'pending');
INSERT INTO public.orders VALUES (20, 24, 'paid', 6395, 3, '2026-03-11 08:51:40.795046+00', 'order_SPrJsxWFWFZ53l', 'pay_SPrK1evro6LMZA', 'paid');
INSERT INTO public.orders VALUES (21, 24, 'paid', 7194, 7, '2026-03-14 05:09:07.884371+00', 'order_SQz8ADNgHOAaD2', 'pay_SQz8LjZmiCDrXz', 'paid');
INSERT INTO public.orders VALUES (22, 15, 'paid', 3398, 9, '2026-04-03 05:50:02.346142+00', 'order_SYuVmhIbDRouPd', 'pay_SYuWIwuDbaIR0D', 'paid');
INSERT INTO public.orders VALUES (23, 15, 'pending', 1599, 9, '2026-04-11 06:50:14.27746+00', '', '', 'pending');
INSERT INTO public.orders VALUES (24, 15, 'pending', 1799, 9, '2026-04-11 06:50:54.243861+00', '', '', 'pending');
INSERT INTO public.orders VALUES (25, 15, 'pending', 3497, 9, '2026-04-11 06:52:20.957844+00', '', '', 'pending');
INSERT INTO public.orders VALUES (26, 15, 'pending', 2698, 9, '2026-04-11 08:56:38.086858+00', '', '', 'pending');
INSERT INTO public.orders VALUES (27, 15, 'pending', 899, 9, '2026-04-11 09:04:05.667477+00', '', '', 'pending');
INSERT INTO public.orders VALUES (28, 15, 'pending', 3398, 9, '2026-04-11 10:12:25.439667+00', '', '', 'pending');
INSERT INTO public.orders VALUES (29, 15, 'paid', 2798, 9, '2026-04-14 07:12:19.19729+00', 'order_SdHn1iHoRaJ7DP', 'pay_SdHnDnSdRFlpX0', 'paid');
INSERT INTO public.orders VALUES (30, 22, 'paid', 1799, 10, '2026-04-14 10:46:04.395263+00', 'order_SdLQooXLU2Q5wT', 'pay_SdLQxPV1j5BfYU', 'paid');
INSERT INTO public.orders VALUES (1, 21, 'paid', 499, NULL, '2026-01-30 11:05:23.70269+00', 'order_SD8YDAdMZpqfu0', NULL, 'pending');
INSERT INTO public.orders VALUES (2, 21, 'paid', 10790, 1, '2026-03-07 07:24:18.765162+00', '', '', 'pending');
INSERT INTO public.orders VALUES (3, 21, 'paid', 5397, 1, '2026-03-07 08:26:46.861821+00', '', '', 'pending');
INSERT INTO public.orders VALUES (4, 21, 'paid', 2698, 1, '2026-03-07 08:31:37.25835+00', '', '', 'pending');
INSERT INTO public.orders VALUES (7, 21, 'paid', 1499, 1, '2026-03-09 05:17:59.505172+00', '', '', 'pending');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (5, 'Classic Checked Shirt', 1299, 14, 'Timeless checkered shirt inspired by old-school fashion.', 'clothing', '/uploads/products/product_5.jpg', '2026-02-14 08:04:30.193588+00', '2026-03-11 08:51:40.803394+00');
INSERT INTO public.products VALUES (11, 'Vintage Corduroy Shirt', 2299, 8, 'Soft corduroy shirt inspired by classic fashion.', 'clothing', '/uploads/products/product_11.jpg', '2026-02-14 08:04:30.193588+00', '2026-03-09 05:32:42.945454+00');
INSERT INTO public.products VALUES (10, 'Old School Half Sleeve Shirt', 1099, 19, 'Comfortable half sleeve shirt with retro vibes.', 'clothing', '/uploads/products/product_10.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-11 06:52:20.961811+00');
INSERT INTO public.products VALUES (1, 'Vintage Shirt', 499, 5, 'Classic 1950s design', 'clothing', '/uploads/products/product_1.jpg', '2025-12-13 14:50:40.029253+00', '2026-04-11 06:52:20.962849+00');
INSERT INTO public.products VALUES (12, 'Retro Flannel Shirt', 1899, 10, 'Warm flannel shirt with traditional vintage style.', 'clothing', '/uploads/products/product_12.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-11 06:52:20.963957+00');
INSERT INTO public.products VALUES (3, 'Vintage 1950s Cotton Shirt', 1499, 11, 'Classic 1950s inspired cotton shirt with relaxed fit.', 'clothing', '/uploads/products/product_3.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-11 08:56:38.095305+00');
INSERT INTO public.products VALUES (2, 'Retro Denim Shirt', 899, 5, 'Classic retro-style denim shirt with vintage wash.', 'clothing', '/uploads/products/product_2.jpg', '2026-02-12 15:08:41.351796+00', '2026-04-11 09:04:05.672622+00');
INSERT INTO public.products VALUES (7, 'Retro Striped Shirt', 1399, 7, 'Vertical striped shirt inspired by 1950s design.', 'clothing', '/uploads/products/product_7.webp', '2026-02-14 08:04:30.193588+00', '2026-04-11 10:12:25.448656+00');
INSERT INTO public.products VALUES (6, 'Vintage Linen Shirt', 1999, 7, 'Breathable linen shirt with retro elegance.', 'clothing', '/uploads/products/product_6.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-11 10:12:25.452337+00');
INSERT INTO public.products VALUES (9, 'Vintage Printed Shirt', 1599, 12, 'Retro printed shirt with unique vintage patterns.', 'clothing', '/uploads/products/product_9.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-14 07:12:19.205988+00');
INSERT INTO public.products VALUES (8, 'Classic White Formal Shirt', 1199, 25, 'Clean and classic white shirt with vintage cut.', 'clothing', '/uploads/products/product_8.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-14 07:12:19.209818+00');
INSERT INTO public.products VALUES (4, 'Retro Denim Shirt', 1799, 12, 'Vintage washed denim shirt with sturdy fabric.', 'clothing', '/uploads/products/product_4.jpg', '2026-02-14 08:04:30.193588+00', '2026-04-14 10:46:04.404966+00');


--
-- Data for Name: user_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_addresses VALUES (1, 21, 'New Street 45', 'Trivandrum', 'Kerala', '695001', 'India', false);
INSERT INTO public.user_addresses VALUES (2, 21, 'pallipparambath,pathiyarakkara', 'vadakara', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (3, 24, 'cuigyfdghkc', 'ejhkujgd', 'deuhkdij', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (4, 24, '', '', '', '', 'India', false);
INSERT INTO public.user_addresses VALUES (5, 24, 'iyutyftdrsewretyughj', 'ejhkujgd', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (6, 24, 'iyutyftdrsewretyughj', 'ejhkujgd', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (7, 24, 'iyutyftdrsewretyughj', 'ejhkujgd', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (8, 24, 'iyutyftdrsewretyughj', 'ejhkujgd', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (9, 15, 'iyutyftdrsewretyughj', 'ejhkujgd', 'Kerala', '673105', 'India', false);
INSERT INTO public.user_addresses VALUES (10, 22, 'edwerd house', 'washington', 'newyork', '673105', 'India', false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'nidan@gmail.com', '$2a$10$1MxiW5xj8EQbuouY0Fjn4OerqqaRZWp5vbSVFOCNBZY1P3nYEpxIG', 'customer', true, NULL, NULL, '2025-11-21 11:47:13.425546+00', '2025-11-21 11:47:13.425546+00');
INSERT INTO public.users VALUES (4, 'Shahal@gmail.com', '$2a$10$6VT.p.QLnYItVNU6aDjC2eTumHJ8I5lA4vC7pRjd517oeEC7Xe55W', 'customer', true, NULL, NULL, '2025-11-22 07:12:46.170851+00', '2025-11-22 07:12:46.170851+00');
INSERT INTO public.users VALUES (5, 'test@example.com', '$2a$10$B1ENneIonwUH/xv0lMMsFuV0Oms59hIIs8kXWX/KVqewPZGJzWJUK', 'customer', true, NULL, NULL, '2025-11-27 10:05:26.739598+00', '2025-11-27 10:05:26.739598+00');
INSERT INTO public.users VALUES (9, 'shahal@gmail.com', '$2a$10$WYmyP3NN46sNjbcqBfq6F.iWogdRFhfGxvXSf4dFhLg9CXtErwo/e', 'customer', true, NULL, NULL, '2025-11-28 05:46:03.468957+00', '2025-11-28 05:46:03.468957+00');
INSERT INTO public.users VALUES (16, 'rasal@gmail.com', '$2a$10$9gqhPKLwRcvtVS2/4HRtE.KMCxZMNaUod.H9jt92tZysYT.LsOoMG', 'customer', true, NULL, NULL, '2025-12-02 10:06:37.396693+00', '2025-12-02 10:06:37.396693+00');
INSERT INTO public.users VALUES (18, 'aasha@gmail.com', '$2a$10$g2Ps1O8qMQxCWlsnm3Hau.RsavQvd7VR8taRnga/RB2Zmnjg7M7A6', 'customer', true, NULL, NULL, '2026-01-05 09:41:34.105316+00', '2026-01-05 09:41:34.105316+00');
INSERT INTO public.users VALUES (20, 'shahalll@gmail.com', '$2a$10$XAOgonhozm/e1.RNCML70ex5ZafwsSGwIR0n2xq/KM3SsZMR1r8gm', 'customer', true, NULL, NULL, '2026-01-23 12:44:04.193873+00', '2026-01-23 12:44:04.193873+00');
INSERT INTO public.users VALUES (21, 'Shahalll@gmail.com', '$2a$10$SxJo8IJut6BLnnaDcT8gsuvAFcusTP4ZzvX8dZUCPlvu.oPgKcjg6', 'admin', true, NULL, NULL, '2026-01-23 13:09:16.111738+00', '2026-01-23 13:09:16.111738+00');
INSERT INTO public.users VALUES (15, 'rahul@gmail.com', '$2a$10$4lzXlBg4rSI5brzOjRlKpOv1/j02lH1erWnKjWekjjObmBeiZ.Cj6', 'customer', true, NULL, NULL, '2025-11-28 08:57:16.081026+00', '2025-11-28 08:57:16.081026+00');
INSERT INTO public.users VALUES (8, 'mhdsahalfxo2@gmail.com', '$2a$10$kG/GAeo0AChPuhWPmCtEyevJtlzaR8l5TI3rL2c3dsAh2Oma1BGTG', 'customer', true, '', NULL, '2025-11-28 05:42:25.738825+00', '2026-02-14 07:27:26.013568+00');
INSERT INTO public.users VALUES (24, 'arjun@gmail.com', '$2a$10$CBtebFsQ2QlkLyp1NfYE8.qfdmmxvSoU41rzd7FcvcIoLxR6Rfja6', 'customer', true, '', NULL, '2026-03-10 07:28:15.490807+00', '2026-03-10 07:28:15.490807+00');
INSERT INTO public.users VALUES (22, 'edwerdlivingston333@gmail.com', '$2a$10$WVdH/7i.VewL4xyUfe3ncuTMGC09iajrQ7hzNNuwFIFiFBCSjnkXu', 'admin', true, 'b8253210-ee87-4f78-8ee6-30224c92907b', '2026-04-14 10:59:30.420787+00', '2026-02-12 13:20:28.590341+00', '2026-04-14 10:44:30.423078+00');


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 71, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 4, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 57, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 30, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 12, true);


--
-- Name: user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_addresses_id_seq', 10, true);


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

\unrestrict ZjmBDKZSzdxt17DDru2KTyCwJ8s4cMmFPh2zm7uVmvvot0TkdviY21PCvvgljE9

