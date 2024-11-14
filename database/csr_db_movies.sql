-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-11-2024 a las 04:18:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `scr_db_movies`
--
CREATE DATABASE IF NOT EXISTS `scr_db_movies` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `scr_db_movies`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genre`
--

CREATE TABLE `genre` (
  `id_genre` int(11) NOT NULL,
  `main_genre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genre`
--

INSERT INTO `genre` (`id_genre`, `main_genre`) VALUES
(12, 'aventura'),
(14, 'fantasia'),
(16, 'animación'),
(18, 'drama'),
(27, 'terror'),
(28, 'acción'),
(35, 'comedia'),
(53, 'suspenso'),
(80, 'crimen'),
(878, 'ciencia ficción'),
(10749, 'romance');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movie`
--

CREATE TABLE `movie` (
  `id_movie` int(11) NOT NULL,
  `title` varchar(60) NOT NULL,
  `poster_path` varchar(60) NOT NULL,
  `release_date` date NOT NULL,
  `overview` text NOT NULL,
  `company` varchar(45) NOT NULL,
  `id_genre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movie`
--

INSERT INTO `movie` (`id_movie`, `title`, `poster_path`, `release_date`, `overview`, `company`, `id_genre`) VALUES
(7451, 'xXx', 'images/movies/67118e573214a7.10911447.jpg', '2002-08-09', 'Xander Cage es tu adicto a la adrenalina estándar sin miedo y con una actitud pésima. Cuando el gobierno de los Estados Unidos lo \\\"recluta\\\" para ir a una misión, no está precisamente emocionado. Su misión: recopilar información sobre una organización que puede estar planeando la destrucción del mundo, dirigida por el nihilista Yorgi.', 'Columbia Pictures', 12),
(365177, 'Borderlands', 'images/movies/jtEZi4eZxDjxcDIeMbkQ8HmvRs1.jpg', '2024-08-07', 'Borderlands se desarrolla en el planeta Pandora. Atraídas por las aparentemente vastos yacimientos minerales, muchas naves colonizadores de la Dahl Corporation (una de las muchas diversas megacorporaciones que aparentemente controlan y gobiernan planetas enteros) viajan al planeta para construir asentamientos. Las operaciones de minería son llevadas a cabo por una cantidad enorme de convictos llevados al planeta por la propia corporación.\r\n', 'Lionsgate', 28),
(519182, 'Mi villano favorito 4', 'images/movies/kqph8UWNOoYgTjYnkAx8dRlLLCq.jpg', '2024-06-20', 'Gru, Lucy y las niñas -Margo, Edith y Agnes- dan la bienvenida a un nuevo miembro en la familia: Gru Junior, que parece llegar con el propósito de ser un suplicio para su padre. Gru tendrá que enfrentarse en esta ocasión a su nueva némesis Maxime Le Mal y su sofisticada y malévola novia Valentina, lo que obligará a la familia a tener que darse a la fuga.\r\n', 'Universal Pictures', 16),
(533535, 'Deadpool y Wolverine', 'images/movies/9TFSqghEHrlBMRR63yTx80Orxva.jpg', '2024-07-24', 'Un Wade Wilson apático se esfuerza en la vida civil. Sus días como el mercenario moralmente flexible Deadpool quedaron atrás. Cuando su mundo natal se enfrenta a una amenaza existencial, Wade debe, a regañadientes, volver a la acción junto a un reacio Wolverine.\r\n', 'Marvel Studios', 28),
(573435, 'Bad Boys: Hasta la muerte', 'images/movies/zp0Y7Nsl4UnWiwX4LxXQXgDfXSz.jpg', '2024-06-05', 'Tras escuchar falsas acusaciones sobre su excapitán y mentor Mike y Marcus deciden investigar el asunto incluso volverse los más buscados de ser necesarios.', 'Sony Pictures Releasing', 28),
(646097, 'Rebel Ridge', 'images/movies/ymTgBQ8rCouE27oHpAUfgKEgRAj.jpg', '2024-08-27', 'Un exmarine debe enfrentarse a la corrupción en un pequeño pueblo cuando la policía le confisca injustamente la bolsa con el dinero para pagar la fianza de su primo.\r\n', 'Netflix', 80),
(726139, 'Project Silence', 'images/movies/7eYasyaCvfJRHdnYl24jqPhf9y0.jpg', '2024-07-11', 'Debido al repentino deterioro de las condiciones meteorológicas, la visibilidad en el puente del aeropuerto se ve gravemente afectada, lo que deja a las personas atrapadas y en riesgo de que el puente se derrumbe debido a una serie de colisiones en cadena y explosiones. En medio del caos, los sujetos caninos \"Echo\" del experimento militar \"Proyecto Silencio\", que estaban siendo transportados en secreto, se liberan y todos los supervivientes humanos se convierten en blanco de ataques implacables.', 'Blaad Studios', 878),
(823219, 'Flow', 'images/movies/enRimDhtFfb7hNTQlOjrgK8O8UO.jpg', '2024-08-30', 'El mundo parece estar llegando a su fin, repleto de vestigios de presencia humana. Gato es un animal solitario, pero como su hogar es arrasado por una gran inundación, encuentra refugio en un barco poblado por varias especies, y tendrá que hacer equipo con ellas a pesar de sus diferencias. En el solitario barco que navega por místicos paisajes desbordados, navegan por los desafíos y peligros de adaptarse a este nuevo mundo..', 'Dream Well Studio', 12),
(877817, 'Wolfs', 'images/movies/uNNVMzJg7NVqxRu8mDLEwIiQgDJ.jpg', '2024-09-20', 'Dos “solucionadores” rivales cruzan sus caminos cuando los llaman a ambos para ayudar a ocultar el desliz de una importante funcionaria de Nueva York. Durante una noche muy intensa, deberán dejar de lado sus pequeñas rencillas -y sus egos- para terminar el trabajo.', 'Smoke House Pictures', 53),
(889737, 'Joker: Folie à Deux', 'images/movies/tMMYwxrPwVPrxz3DqXs8DnVIOx0.jpg', '2024-10-01', 'Secuela de Joker (2019), de nuevo con Phoenix como Arthur Fleck, y que muestra su relación con el personaje de Harley Quinn, interpretado por Lady Gaga.', 'Warner Bros Pictures', 80),
(917496, 'Beetlejuice Beetlejuice', 'images/movies/kWJw7dCWHcfMLr0irTHAPIKrJ4I.jpg', '2024-09-04', 'Después de una tragedia familiar, tres generaciones de la familia Deetz regresan a su hogar en Winter River. La vida de Lydia, que aún sigue atormentada por Beetlejuice, da un vuelco cuando su hija adolescente, Astrid, abre accidentalmente el portal al más allá.\r\n', 'Warner Bros. Pictures', 35),
(933260, 'La sustancia', 'images/movies/uZXQExGj9YfVNH2XCS5yVjx0auh.jpg', '2024-09-09', '\"Tú, pero mejor en todos los sentidos\". Esa es la promesa de La Sustancia, un producto revolucionario basado en la división celular, que crea un alter ego más joven, más bello, más perfecto.', 'Working Title Films', 878),
(957452, 'El Cuervo', 'images/movies/X9iFHeIYgfqoZImvdidx8b9v4R.jpg', '2024-08-21', 'Un año después de que él y su prometida fueran asesinados, un cuervo místico devuelve a Eric a la vida para que pueda clamar su venganza.', 'Davis Films', 14),
(1022789, 'IntensaMente 2', 'images/movies/aQnbNiadeGzGSjWLaXyeNxpAUIx.jpg', '2024-06-11', 'Riley, ahora adolescente, enfrenta una reforma en la Central de sus emociones. Alegría, Tristeza, Ira, Miedo y Asco deben adaptarse a la llegada de nuevas emociones: Ansiedad, Vergüenza, Envidia y Ennui.', 'Pixar Animation Studios', 16),
(1034541, 'Terrifier 3', 'images/movies/5eECVdOWwbsUARVxLA7ENyBYx3H.jpg', '2024-10-09', 'Secuela de \"Terrifier 2\", ambientada en el periodo navideño.', 'Cineverse', 27),
(1079091, 'Romper el círculo', 'images/movies/2EH42blLQzgqwDWxn39RXkTgb91.jpg', '2024-08-07', 'Una mujer atraviesa las tumultuosas etapas de una relación abusiva. Tras mudarse a la ciudad de Boston después de la universidad, decide iniciar su propio negocio como florista y se enamora de un joven neurocirujano.', 'Wayfarer Studios', 10749),
(1114513, 'No hables con extraños', 'images/movies/rdGpSGWNnpHuouEJjXOkzbTyRJk.jpg', '2024-09-11', 'Cuando una familia estadounidense va invitada a pasar un fin de semana en la idílica finca campestre de una encantadora familia británica que conocieron en unas vacaciones, lo que comienza como una escapada de ensueño pronto se convierte en una retorcida pesadilla psicológica.', 'Blumhouse Productions', 27),
(1125510, 'El hoyo 2', 'images/movies/8cnfdskwEmS1HZhenEVYt9P0IYa.jpg', '2024-09-27', 'Un misterioso líder ha impuesto su ley en un brutal sistema de celdas verticales, pero la llegada de una residente desafía su dudoso método de distribución de comida.', 'Basque Films', 18),
(1184918, 'Robot salvaje', 'images/movies/sDoXpaKZmrzCSJH63zZvQQ9A7VK.jpg', '2024-09-12', 'Una robot (la unidad ROZZUM 7134 o «Roz») ha naufragado en una isla deshabitada y deberá aprender a adaptarse al duro entorno, forjando poco a poco relaciones con la fauna local y convirtiéndose en madre adoptiva de una cría de ganso huérfana.', 'DreamWorks Animation', 16),
(1215162, 'Mátalos a todos 2', 'images/movies/rWS8Wo9aN90GcokuvpMNjJYRijA.jpg', '2024-10-24', 'Philip y Suzanne, ahora agentes asociados por la CIA, se dirigen a Europa en una nueva misión.', 'Iervolino & Lady Bacardi Entertainment', 53),
(1329336, 'Los tipos malos: ¿Truco o atraco?', 'images/movies/4njXv4s77hq9VGMOquvRQDiu53W.jpg', '2024-10-02', 'La pícara banda de los tipos malos planea un arriesgadísimo atraco en Halloween de un valioso amuleto en una tenebrosa mansión. ¿Qué podría salir mal?', 'DreamWorks Animation Television', 35),
(1337309, 'Corrupción en Bangkok: Entre el cielo y el infierno', 'images/movies/45Yxq9aEfMgPEq6bGZG0BgbDQge.jpg', '2024-09-26', 'Un rescatista debe luchar por sobrevivir tras verse atrapado en un conflicto entre bandas rivales de los bajos fondos de Bangkok.', 'Kongkiat Production', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `review`
--

CREATE TABLE `review` (
  `id_review` int(11) NOT NULL,
  `main_review` text NOT NULL,
  `score` int(11) NOT NULL,
  `id_movie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `review`
--

INSERT INTO `review` (`id_review`, `main_review`, `score`, `id_movie`) VALUES
(2, 'Una película de acción trepidante con Vin Diesel en su mejor momento.', 8, 7451),
(3, 'Los efectos especiales son impresionantes, pero la trama es un poco predecible.', 7, 7451),
(4, 'Una película entretenida para pasar el rato, pero no es nada del otro mundo.', 6, 7451),
(5, 'Una adaptación fiel del videojuego, con mucha acción y humor negro. Los efectos visuales son impresionantes.', 8, 365177),
(6, 'La película captura la esencia del mundo de Borderlands, pero el guion podría haber sido más profundo. Aún así, es una buena opción para los fans del videojuego.', 7, 365177),
(7, 'Una decepción para los fans de la saga. La historia es predecible y los personajes carecen de carisma. Los efectos especiales no compensan la falta de contenido.', 5, 365177),
(8, 'La animación es espectacular y la historia mantiene la esencia de la franquicia. ¡Diversión asegurada para todas las edades!', 8, 519182),
(9, 'Los nuevos personajes aportan frescura a la saga. Las risas están garantizadas.', 9, 519182),
(10, 'Un poco predecible, pero igual me encantó. Los minions son lo mejor.', 7, 519182),
(11, 'La química entre Deadpool y Wolverine es explosiva. La acción es frenética y el humor negro está presente en cada escena.', 8, 533535),
(12, 'Una secuela digna de la saga. Los fans quedarán satisfechos con la cantidad de referencias y guiños a los cómics.', 9, 533535),
(13, 'La película logra encontrar un equilibrio perfecto entre acción, comedia y drama. Los personajes están muy bien desarrollados.', 10, 533535),
(14, 'Muy divertida, ideal para verla en familia.', 9, 573435),
(15, 'Acción trepidante y humor negro, ¡la dupla perfecta!', 8, 573435),
(16, 'Una secuela a la altura de las anteriores, ¡no te la puedes perder!', 10, 573435),
(17, 'Una película de acción trepidante con un mensaje social importante.', 8, 646097),
(18, 'La actuación de John Boyega es destacable, y la trama mantiene el interés hasta el final.', 7, 646097),
(19, 'A pesar de algunas escenas predecibles, es una buena opción para los amantes del cine de acción.', 6, 646097),
(20, 'Una película de suspenso muy bien lograda. Los efectos especiales son impresionantes y la trama mantiene la tensión hasta el final.', 8, 726139),
(21, 'Una película entretenida, pero con algunos clichés del género. Los perros son los verdaderos protagonistas.', 6, 726139),
(22, 'Historia predecible y personajes poco desarrollados. Los efectos especiales no compensan la falta de originalidad.', 4, 726139),
(23, 'Una animación conmovedora que nos invita a reflexionar sobre la importancia de la unión y el respeto por todas las especies.', 8, 823219),
(24, 'Una historia original y bien desarrollada, con personajes entrañables y paisajes impresionantes.', 9, 823219),
(25, 'Una película que te atrapa desde el principio hasta el final, con una banda sonora que complementa a la perfección la trama.', 10, 823219),
(26, 'Una película llena de acción y humor, con un final sorprendente.', 8, 877817),
(27, 'La química entre los protagonistas es innegable, haciendo de la película una experiencia entretenida.', 7, 877817),
(28, 'Una trama original con giros inesperados que mantienen al espectador atento de principio a fin.', 9, 877817),
(29, 'Una exploración profunda de la locura, con actuaciones sobresalientes de Phoenix y Gaga.', 8, 889737),
(30, 'Un musical oscuro y sorprendente, que redefine el género del cine de superhéroes.', 9, 889737),
(31, 'La química entre Phoenix y Gaga es electrizante, llevando la historia a otro nivel.', 10, 889737),
(35, 'Una película que te hace reflexionar sobre la naturaleza humana y los límites de la belleza.', 8, 933260),
(36, 'Efectos especiales impresionantes y una trama intrigante. ¡Muy recomendable!', 9, 933260),
(37, 'Una historia original con un final sorprendente. ¡Me encantó!', 10, 933260),
(38, 'Una adaptación oscura y violenta del clásico cómic. La actuación de Brandon Lee es impresionante.', 8, 957452),
(39, 'Una historia de venganza con una estética gótica muy llamativa. La banda sonora es perfecta para la atmósfera de la película.', 9, 957452),
(40, 'Un clásico del cine de culto que sigue siendo relevante hoy en día. La transformación de Eric Draven es impactante.', 10, 957452),
(41, 'Una secuela que no decepciona, con nuevos personajes y situaciones que emocionan tanto a niños como a adultos.', 8, 1022789),
(42, 'La animación es espectacular, como siempre en Pixar. La historia aborda temas complejos de una manera muy divertida y conmovedora.', 9, 1022789),
(43, 'Una película que te hace reflexionar sobre tus propias emociones y cómo estas influyen en tu vida diaria.', 7, 1022789),
(44, 'Una montaña rusa de terror, con efectos especiales impresionantes. No apta para corazones débiles.', 8, 1034541),
(45, 'La violencia gráfica es extrema, pero la atmósfera logra mantenerte al borde del asiento.', 7, 1034541),
(46, 'Una secuela que supera a la original en todos los aspectos. El payaso Art es aún más aterrador.', 10, 1034541),
(47, 'La película retrata de manera realista y conmovedora las complejidades de una relación tóxica. La actuación principal es excepcional.', 8, 1079091),
(48, 'Una historia de superación personal que te mantiene enganchado desde el principio hasta el final. La fotografía es hermosa y la banda sonora acompaña perfectamente la trama.', 9, 1079091),
(49, 'Aunque la temática es dura, la película logra transmitir esperanza y empoderamiento. Recomiendo esta película a quienes buscan historias conmovedoras y bien construidas.', 7, 1079091),
(50, 'Muy divertida, ideal para verla en familia.', 9, 1114513),
(51, 'Tensión constante y un final inesperado. Recomendada.', 8, 1114513),
(52, 'Historia original pero con algunos clichés. Buen entretenimiento.', 7, 1114513),
(56, 'Una animación conmovedora sobre la conexión entre humanos y máquinas. ¡Los efectos visuales son impresionantes!', 8, 1184918),
(57, 'Una historia original y divertida, perfecta para toda la familia. Los personajes son adorables.', 7, 1184918),
(58, 'Una película que te hará reflexionar sobre la inteligencia artificial y la naturaleza. ¡Muy recomendable!', 9, 1184918),
(59, 'Una secuela que supera a la original con más acción y humor.', 8, 1215162),
(60, 'La química entre los protagonistas sigue siendo excelente, pero la trama se siente un poco repetitiva.', 7, 1215162),
(61, 'Una película de acción entretenida, perfecta para pasar un rato agradable en el cine.', 9, 1215162),
(62, 'Muy divertida, ideal para verla en familia.', 9, 1329336),
(63, 'Una animación espectacular con un guion muy entretenido.', 8, 1329336),
(64, 'Los personajes son muy carismáticos y la trama es adictiva.', 7, 1329336),
(65, 'Una película de acción trepidante con giros inesperados. ¡La persecución final es impresionante!', 8, 1337309),
(66, 'La ambientación de Bangkok es increíble. Una historia oscura y realista sobre el crimen organizado.', 7, 1337309),
(67, 'Si te gustan las películas de acción con un toque de drama, esta es para ti. El protagonista es muy carismático.', 9, 1337309);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id_user`, `email`, `password`) VALUES
(1, 'web@admin.com', '$2y$10$th8zeOQxEIOTkYz4J0ePmuueSxKJWoCdn2P1MPWymyqZLPQSIf3h2');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id_genre`),
  ADD KEY `id_genre` (`id_genre`);

--
-- Indices de la tabla `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id_movie`),
  ADD KEY `id_genre` (`id_genre`),
  ADD KEY `id_movie` (`id_movie`);

--
-- Indices de la tabla `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id_review`),
  ADD KEY `id_review` (`id_review`),
  ADD KEY `id_movie` (`id_movie`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `genre`
--
ALTER TABLE `genre`
  MODIFY `id_genre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10752;

--
-- AUTO_INCREMENT de la tabla `movie`
--
ALTER TABLE `movie`
  MODIFY `id_movie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1337310;

--
-- AUTO_INCREMENT de la tabla `review`
--
ALTER TABLE `review`
  MODIFY `id_review` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`id_genre`) REFERENCES `genre` (`id_genre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`id_movie`) REFERENCES `movie` (`id_movie`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
