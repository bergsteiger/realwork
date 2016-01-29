unit m3NewStorage;
{* Реализация _IStorage, библиотеки m3. }

// $Id: m3NewStorage.pas,v 1.95 2014/12/08 13:07:44 lulin Exp $

// $Log: m3NewStorage.pas,v $
// Revision 1.95  2014/12/08 13:07:44  lulin
// - рисуем на модели.
//
// Revision 1.94  2014/12/08 12:10:54  lulin
// - рисуем на модели.
//
// Revision 1.93  2014/12/05 12:34:00  lulin
// - рисуем на модели.
//
// Revision 1.92  2014/12/04 16:15:43  lulin
// - рисуем на модели буферизованный поток.
//
// Revision 1.91  2014/11/06 17:05:10  lulin
// - перетряхиваем код.
//
// Revision 1.90  2014/11/06 16:09:53  lulin
// - перетряхиваем код.
//
// Revision 1.89  2014/11/06 13:33:17  lulin
// - перетряхиваем код.
//
// Revision 1.88  2014/10/31 17:42:58  lulin
// - перетряхиваем код.
//
// Revision 1.87  2014/10/31 14:14:30  lulin
// - перетряхиваем код.
//
// Revision 1.86  2014/10/30 17:11:08  lulin
// - перетряхиваем код.
//
// Revision 1.85  2014/10/30 16:37:12  lulin
// - перетряхиваем код.
//
// Revision 1.84  2014/10/30 15:11:12  lulin
// - перетряхиваем код.
//
// Revision 1.83  2014/10/30 14:14:48  lulin
// - перетряхиваем код.
// - убираем утечки памяти.
//
// Revision 1.82  2014/10/30 13:43:54  lulin
// - перетряхиваем код.
//
// Revision 1.81  2014/10/30 08:34:54  lulin
// - перетряхиваем код.
//
// Revision 1.80  2014/10/30 08:07:00  lulin
// - перетряхиваем код.
//
// Revision 1.79  2014/10/30 07:52:31  lulin
// - перетряхиваем код.
//
// Revision 1.78  2014/10/30 07:49:12  lulin
// - перетряхиваем код.
//
// Revision 1.77  2014/10/29 17:55:09  lulin
// - перетряхиваем код.
//
// Revision 1.76  2014/10/29 17:44:02  lulin
// - перетряхиваем код.
//
// Revision 1.75  2014/10/29 17:32:19  lulin
// - перетряхиваем код.
//
// Revision 1.74  2014/10/28 14:53:47  lulin
// - добавляем диагностику.
//
// Revision 1.73  2014/10/24 11:32:42  lulin
// - тонкая настройка.
//
// Revision 1.72  2014/10/24 11:12:21  lulin
// - тонкая настройка.
//
// Revision 1.71  2014/10/23 16:38:29  lulin
// - переносим на модель.
//
// Revision 1.69  2014/10/23 15:12:32  lulin
// - переносим на модель.
//
// Revision 1.68  2014/10/23 14:15:28  lulin
// - переносим на модель.
//
// Revision 1.67  2014/10/23 13:55:29  lulin
// - переносим на модель.
//
// Revision 1.66  2014/10/23 11:39:17  lulin
// - добавляем диагностику.
//
// Revision 1.65  2014/10/22 15:24:02  lulin
// - чистим код.
//
// Revision 1.64  2014/10/22 15:12:51  lulin
// - чистим код.
//
// Revision 1.63  2014/10/22 12:10:17  lulin
// - оптимизируем Seek назад.
//
// Revision 1.62  2014/10/22 11:26:27  lulin
// - оптимизируем Seek вперёд и Seek на первый блок.
//
// Revision 1.61  2014/10/22 09:24:38  lulin
// - перераспределяем ответственности.
//
// Revision 1.59  2014/10/22 08:40:11  lulin
// - вставляем диагностику.
//
// Revision 1.58  2014/10/22 08:22:25  lulin
// - перераспределяем ответственности.
//
// Revision 1.57  2014/10/21 15:55:35  lulin
// - перераспределяем ответственности.
//
// Revision 1.56  2014/10/21 15:08:04  lulin
// - перераспределяем ответственности.
//
// Revision 1.55  2014/10/21 13:19:32  lulin
// - перераспределяем ответственности.
//
// Revision 1.54  2014/10/21 12:43:05  lulin
// - перераспределяем ответственности.
//
// Revision 1.53  2014/10/21 12:35:20  lulin
// - перераспределяем ответственности.
//
// Revision 1.52  2014/10/21 11:56:45  lulin
// - при открытии не из кеша тоже делаем менеджер на чтение.
//
// Revision 1.51  2014/10/20 16:41:17  lulin
// - причёсываем код.
//
// Revision 1.50  2014/10/20 16:10:38  lulin
// - причёсываем код.
//
// Revision 1.49  2014/10/20 15:27:36  lulin
// - причёсываем код.
//
// Revision 1.48  2014/10/20 14:56:46  lulin
// - причёсываем код.
//
// Revision 1.47  2014/10/20 13:14:02  lulin
// - причёсываем код.
//
// Revision 1.46  2014/10/17 13:13:26  lulin
// - делаем прокси-мнеджер только на запись.
//
// Revision 1.44  2014/10/17 12:42:11  lulin
// - делаем прокси-мнеджер только на запись.
//
// Revision 1.43  2014/10/17 12:18:28  lulin
// - перетряхиваем код.
//
// Revision 1.42  2014/10/16 15:54:37  lulin
// - убираем уже ненужную диагностику.
//
// Revision 1.41  2014/10/16 13:48:13  lulin
// - перетряхиваем зависимости между классами.
//
// Revision 1.40  2014/10/16 13:31:28  lulin
// - перетряхиваем зависимости между классами.
//
// Revision 1.39  2014/10/16 13:06:04  lulin
// - перетряхиваем зависимости между классами.
//
// Revision 1.38  2014/10/16 10:22:10  lulin
// - прячем кишки.
//
// Revision 1.37  2014/10/16 09:02:51  lulin
// - очередной раз удаляем "совсем старое хранилище".
//
// Revision 1.36  2014/10/14 12:36:30  lulin
// - добавляем диагностику.
//
// Revision 1.35  2014/10/14 11:14:49  lulin
// - добавляем диагностику.
//
// Revision 1.34  2014/10/13 14:40:05  lulin
// - правим диагностику.
//
// Revision 1.33  2014/10/13 14:14:51  lulin
// - добавляем диагностику.
//
// Revision 1.32  2014/10/13 13:56:29  lulin
// - добавляем диагностику перезаписи рутового хранилища.
//
// Revision 1.31  2014/10/03 15:19:29  lulin
// - правильнее диагностируем проблемы с залочками.
//
// Revision 1.30  2014/10/03 12:03:21  lulin
// - готовимся к кешированию хранилищ, а точнее - менеджеров блоков и связанных с ними потоков.
//
// Revision 1.29  2014/10/03 09:44:33  lulin
// - готовимся к кешированию хранилищ, а точнее - менеджеров блоков и связанных с ними потоков.
//
// Revision 1.28  2014/09/29 08:33:50  lulin
// - перетряхиваем код.
//
// Revision 1.27  2014/09/26 13:07:49  lulin
// - упрощаем код.
//
// Revision 1.26  2014/09/26 12:29:54  lulin
// - обобщаем код.
//
// Revision 1.25  2014/09/26 12:06:35  lulin
// - даём более вменяемое название.
//
// Revision 1.24  2014/09/26 11:34:38  lulin
// - упрощаем код.
//
// Revision 1.23  2014/09/26 10:38:50  lulin
// - даём более вменяемое название.
//
// Revision 1.22  2014/09/26 10:31:03  lulin
// - даём более вменяемое название.
//
// Revision 1.21  2014/09/24 15:52:05  lulin
// - для корневого потока сразу распределяем индекс.
//
// Revision 1.20  2014/09/24 14:54:03  lulin
// - выделяем общий код.
//
// Revision 1.19  2014/09/24 12:20:52  lulin
// - чистим код.
//
// Revision 1.18  2014/09/24 10:56:18  lulin
// - даём более вменяемые названия.
//
// Revision 1.16  2014/09/24 10:12:17  lulin
// - чистим код.
//
// Revision 1.15  2014/09/23 16:59:33  lulin
// - переносим на модель.
//
// Revision 1.14  2014/09/23 16:20:31  lulin
// - переносим на модель.
//
// Revision 1.13  2014/09/23 14:54:44  lulin
// - выделяем базового предка.
//
// Revision 1.12  2014/09/19 11:31:03  lulin
// - добавляем диагностику.
//
// Revision 1.11  2014/09/18 16:34:26  lulin
// - используем более кошерные функции.
//
// Revision 1.10  2014/09/18 08:51:48  lulin
// - правильнее конвертируем имена.
//
// Revision 1.9  2014/09/17 15:23:38  lulin
// - добавляем диагностику.
// - аккуратнее обращаемся с многопоточностью.
//
// Revision 1.8  2014/09/17 12:58:24  lulin
// - для рутового потока сразу распределяем место под индекс.
// - добавляем диагностику.
//
// Revision 1.7  2014/09/16 15:36:36  lulin
// - логируем открытие потоков на запись.
//
// Revision 1.6  2014/09/16 15:13:12  lulin
// - выделяем потоки для работы с оглавлением в отдельный класс.
//
// Revision 1.5  2014/09/16 14:56:34  lulin
// - выделяем потоки для работы с оглавлением в отдельный класс.
//
// Revision 1.4  2014/09/16 14:28:15  lulin
// - чистим код.
//
// Revision 1.3  2014/09/16 12:47:17  lulin
// - переименовываем классы.
//
// Revision 1.2  2014/09/16 12:33:41  lulin
// - чистим код.
//
// Revision 1.1  2014/09/16 10:43:22  lulin
// - возвращаем старую реализацию хранилища.
//
// Revision 1.250  2014/09/16 07:53:28  lulin
// - чистим код.
//
// Revision 1.249  2014/09/16 06:48:54  lulin
// - добавляем диагностику.
//
// Revision 1.248  2014/09/15 16:49:19  lulin
// - добавляем диагностику.
//
// Revision 1.247  2014/09/15 16:08:00  lulin
// - чистим код.
//
// Revision 1.246  2014/09/15 13:07:58  lulin
// - вставляем диагностику.
//
// Revision 1.245  2014/09/15 13:00:18  lulin
// - чистим код.
//
// Revision 1.244  2014/09/15 12:52:56  lulin
// - чистим код.
//
// Revision 1.243  2014/09/15 12:36:24  lulin
// - если файл открывается на запись, то не буферизуем его.
// - более правильно передаём флажок Exclusive.
//
// Revision 1.242  2014/09/15 12:07:06  lulin
// - переносим на модель.
// - чистим код.
// - вставляем диагностику.
//
// Revision 1.241  2014/09/12 15:07:26  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.240  2014/09/12 09:56:22  lulin
// - информационный поток открываем в том же режиме, что и все остальные.
//
// Revision 1.239  2014/09/11 17:10:24  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.238  2014/09/11 16:51:11  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.237  2014/09/11 16:30:16  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.235  2014/09/11 15:45:24  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.234  2014/09/11 15:25:03  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.233  2014/09/11 15:16:32  lulin
// - чистим код.
//
// Revision 1.232  2014/09/11 15:11:42  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.231  2014/09/11 14:46:10  lulin
// - чистим код.
//
// Revision 1.230  2014/09/11 14:42:00  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.229  2014/09/11 14:07:32  lulin
// - постоянную часть теперь открывваем в режиме на чтение БЕЗ залочек.
//
// Revision 1.228  2014/09/11 11:51:24  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.227  2014/09/11 11:28:19  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.226  2014/09/11 08:50:15  lulin
// - насильно всё не лочим.
//
// Revision 1.225  2014/09/10 15:11:02  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.224  2014/09/10 13:49:43  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.223  2014/09/10 13:42:40  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.222  2014/09/10 12:59:37  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.221  2014/09/10 11:48:22  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.220  2014/09/10 10:55:13  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.219  2014/09/09 16:55:56  lulin
// - логируем залочки.
// - основательно перетряхиваем архитектуру.
//
// Revision 1.218  2014/09/08 16:00:19  lulin
// - прячем "кишочки".
//
// Revision 1.217  2014/09/08 15:33:16  lulin
// - прячем "кишочки".
//
// Revision 1.216  2014/09/08 15:17:31  lulin
// - прячем "кишочки".
//
// Revision 1.215  2014/09/08 13:40:55  lulin
// - чистим код.
//
// Revision 1.214  2014/09/08 13:08:36  lulin
// - выделяем класс потоков для индекса хранилища.
//
// Revision 1.213  2014/09/08 11:56:27  lulin
// - прячем "кишочки".
//
// Revision 1.212  2014/09/08 10:57:39  lulin
// - прячем "кишочки".
//
// Revision 1.211  2014/09/05 15:07:22  lulin
// - чистим код.
//
// Revision 1.210  2014/09/05 13:29:32  lulin
// - чистим код.
//
// Revision 1.209  2014/09/05 13:11:15  lulin
// - восстанавливаем "вилку".
//
// Revision 1.208  2014/09/05 12:32:56  lulin
// - чистим код.
//
// Revision 1.207  2014/09/05 12:26:00  lulin
// - наконец избавился от части хакерства.
//
// Revision 1.206  2014/09/05 12:03:05  lulin
// - чистим код.
//
// Revision 1.204  2014/09/05 11:43:13  lulin
// - чистим код.
//
// Revision 1.203  2014/09/05 11:33:55  lulin
// - читаем кластер в два приёма.
//
// Revision 1.202  2014/09/05 11:24:37  lulin
// - пишем кластер в два приёма.
//
// Revision 1.201  2014/09/05 11:17:17  lulin
// - чистим код.
//
// Revision 1.199  2014/09/05 10:45:32  lulin
// - чистим код.
//
// Revision 1.198  2014/09/05 10:32:45  lulin
// - чистим код.
//
// Revision 1.197  2014/09/05 10:06:13  lulin
// - чистим код.
//
// Revision 1.196  2014/09/05 09:06:38  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.194  2014/09/04 16:34:57  lulin
// - чистим код.
//
// Revision 1.193  2014/09/04 16:24:41  lulin
// - чистим код.
//
// Revision 1.192  2014/09/04 15:00:07  lulin
// - выделяем новый тип блоков - "без мусора".
//
// Revision 1.191  2014/09/04 11:59:37  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.190  2014/09/04 10:49:39  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.188  2014/09/04 10:14:46  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.187  2014/09/03 16:47:28  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.186  2014/09/03 16:34:11  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.185  2014/09/03 16:15:46  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.184  2014/09/03 15:24:22  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.183  2014/09/03 15:19:03  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.182  2014/09/03 14:58:34  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.181  2014/09/03 14:46:14  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.180  2014/09/03 14:37:24  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.179  2014/09/03 14:16:10  lulin
// - выделяем блоки заголовков в отдельный класс.
//
// Revision 1.178  2014/09/03 13:23:35  lulin
// - чистим код.
//
// Revision 1.177  2014/09/03 13:16:08  lulin
// - чистим код.
//
// Revision 1.176  2014/09/03 12:33:28  lulin
// - чистим код.
//
// Revision 1.175  2014/09/03 11:59:20  lulin
// - чистим код.
//
// Revision 1.174  2014/09/03 11:51:55  lulin
// - чистим код.
//
// Revision 1.173  2014/09/03 11:35:03  lulin
// - чистим код.
//
// Revision 1.172  2014/09/03 11:23:34  lulin
// - чистим код.
//
// Revision 1.171  2014/09/03 10:48:12  lulin
// - чистим код.
//
// Revision 1.169  2014/09/03 10:17:11  lulin
// - чистим код.
//
// Revision 1.167  2014/09/02 16:31:23  lulin
// - чистим код.
//
// Revision 1.166  2014/09/02 16:23:53  lulin
// - чистим код.
//
// Revision 1.165  2014/09/02 16:10:20  lulin
// - чистим код.
//
// Revision 1.164  2014/09/02 15:45:04  lulin
// - пишем оглавление сразу после создания индекса.
//
// Revision 1.162  2014/09/02 15:00:08  lulin
// - добавляем диагностику.
//
// Revision 1.161  2014/09/02 14:26:54  lulin
// - чистим код.
//
// Revision 1.160  2014/09/02 09:09:43  lulin
// - увеличиваем время залочки рутового потока.
//
// Revision 1.159  2014/09/01 16:31:19  lulin
// - вычищаем мусор.
//
// Revision 1.158  2014/09/01 16:08:39  lulin
// - вычищаем мусор.
//
// Revision 1.157  2014/09/01 15:45:06  lulin
// - вычищаем мусор.
//
// Revision 1.156  2014/09/01 15:33:48  lulin
// - вычищаем мусор.
//
// Revision 1.155  2014/09/01 14:57:01  lulin
// - вычищаем мусор.
//
// Revision 1.154  2014/09/01 14:20:33  lulin
// - вычищаем мусор.
//
// Revision 1.153  2014/09/01 11:27:47  lulin
// - вставляем диагностику чтения.
//
// Revision 1.152  2014/08/29 15:08:56  lulin
// - чистим код.
//
// Revision 1.150  2014/08/29 14:11:05  lulin
// - bug fix: поторопился я с отключением залочек.
//
// Revision 1.149  2014/08/29 13:48:33  lulin
// - не лочим корень хранилища, если оно открыто только на чтение.
//
// Revision 1.148  2014/08/29 13:39:55  lulin
// - чистим код.
//
// Revision 1.147  2014/08/29 13:33:30  lulin
// - чистим код.
//
// Revision 1.146  2014/08/29 13:17:41  lulin
// - чистим код.
//
// Revision 1.145  2014/08/28 16:52:03  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.144  2014/08/28 15:51:03  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.143  2014/08/28 10:30:01  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.142  2014/08/27 14:40:19  lulin
// - выпиливаем _Tm3RootStream в отдельный файл.
//
// Revision 1.141  2014/08/27 13:27:48  lulin
// - выпиливаем Tm3CustomHeaderStream в отдельный файл.
//
// Revision 1.140  2014/08/27 11:28:25  lulin
// - чистим код.
//
// Revision 1.139  2014/08/27 11:18:44  lulin
// - вставляем дополнительную проверку записи.
//
// Revision 1.138  2014/08/26 14:14:52  lulin
// - улучшаем диагностику.
//
// Revision 1.137  2014/08/26 12:19:38  lulin
// - вставляем диагностику правильности позиции.
//
// Revision 1.136  2014/08/26 10:57:28  lulin
// - причёсываем код.
//
// Revision 1.135  2014/08/25 15:27:25  lulin
// - чистим код.
//
// Revision 1.134  2014/08/25 15:14:28  lulin
// - чистим код.
//
// Revision 1.133  2014/08/25 15:01:10  lulin
// - чистим код.
//
// Revision 1.132  2014/08/25 14:49:33  lulin
// - чистим код.
//
// Revision 1.131  2014/08/25 14:23:14  lulin
// - чистим код.
//
// Revision 1.130  2014/08/25 14:14:54  lulin
// - чистим код.
//
// Revision 1.129  2014/08/25 12:45:29  lulin
// - bug fix: поднимали исключение неверного типа.
//
// Revision 1.128  2014/08/25 12:23:21  lulin
// - причёсываем код.
//
// Revision 1.127  2014/08/25 11:53:24  lulin
// - причёсываем код.
//
// Revision 1.126  2014/08/25 11:36:40  lulin
// - улучшаем диагностику.
//
// Revision 1.125  2014/08/25 11:12:32  lulin
// - причёсываем код.
//
// Revision 1.124  2014/08/25 10:34:04  lulin
// - причёсываем код.
//
// Revision 1.123  2014/08/25 09:32:00  lulin
// - причёсываем код.
//
// Revision 1.122  2014/08/22 15:16:14  lulin
// - причёсываем код.
//
// Revision 1.121  2014/08/22 15:04:39  lulin
// - причёсываем код.
//
// Revision 1.120  2014/08/22 14:51:40  lulin
// - причёсываем код.
//
// Revision 1.119  2014/08/22 14:18:28  lulin
// - причёсываем код.
//
// Revision 1.118  2014/08/22 13:45:01  lulin
// - причёсываем код.
//
// Revision 1.116  2014/08/22 13:07:04  lulin
// - причёсываем код.
//
// Revision 1.114  2014/08/22 12:03:19  lulin
// - причёсываем код.
//
// Revision 1.113  2014/08/22 11:42:18  lulin
// - причёсываем код.
//
// Revision 1.112  2014/08/22 11:17:27  lulin
// - причёсываем код.
//
// Revision 1.110  2014/08/21 15:06:15  lulin
// - прикручиваем ещё валидацию данных.
//
// Revision 1.108  2014/08/21 14:43:33  lulin
// - прикручиваем ещё валидацию данных.
//
// Revision 1.107  2014/08/21 12:34:27  lulin
// - чистим код.
//
// Revision 1.105  2014/08/21 11:39:12  lulin
// - убираем чтение заголовка в локальную процедуру.
//
// Revision 1.102  2014/08/21 10:02:12  lulin
// - пишем заголовок, только если его удалось залочить.
//
// Revision 1.101  2014/08/21 09:39:36  lulin
// - чистим код.
//
// Revision 1.100  2014/08/21 09:11:22  lulin
// - чистим код.
//
// Revision 1.98  2014/08/21 08:47:06  lulin
// - прикручиваем ещё валидацию данных.
//
// Revision 1.97  2014/08/21 08:33:08  lulin
// - если что-то пошло не так, то пытаемся сначала покоммитеть поток, а потом только читать его размер.
//
// Revision 1.96  2014/08/21 08:01:45  lulin
// - рефакторим возбуждение исключений.
//
// Revision 1.94  2014/08/21 07:51:50  lulin
// - рефакторим возбуждение исключений.
//
// Revision 1.93  2014/08/21 07:45:09  lulin
// - рефакторим возбуждение исключений.
//
// Revision 1.92  2014/08/21 07:15:08  lulin
// - чистим код.
//
// Revision 1.89  2014/08/21 06:13:03  lulin
// - улучшаем диагностику.
//
// Revision 1.88  2014/08/20 13:21:48  lulin
// - пишем более правильный модификатор.
//
// Revision 1.87  2014/08/20 13:05:47  lulin
// - вручиваем контроль записи.
//
// Revision 1.86  2014/08/20 12:52:26  lulin
// - переименовываем метод, более правильным именем.
//
// Revision 1.85  2014/08/20 12:34:19  lulin
// - вручиваем контроль записи.
//
// Revision 1.84  2014/08/20 12:22:18  lulin
// - вручиваем контроль записи.
//
// Revision 1.82  2014/08/19 17:39:46  lulin
// - чистим код.
//
// Revision 1.81  2014/08/19 17:36:03  lulin
// - чистим код.
//
// Revision 1.80  2014/08/19 17:23:38  lulin
// - пораньше защищаем ресурс.
//
// Revision 1.78  2014/08/19 17:06:02  lulin
// - нашел место, где запись в поток не защищалась.
//
// Revision 1.77  2014/08/19 16:53:01  lulin
// - выводим стек.
//
// Revision 1.76  2014/08/19 16:44:43  lulin
// - ещё раз полагаемся на случай.
//
// Revision 1.75  2014/08/19 16:20:05  lulin
// - более вменяемая диагностика.
//
// Revision 1.74  2014/08/19 16:06:12  lulin
// - стараемся не падать на "малых расхождениях".
//
// Revision 1.73  2014/08/19 15:50:34  lulin
// - пытаемся восстановить битую переменную часть путём удаления неправильного элемента.
//
// Revision 1.72  2014/08/19 14:50:26  lulin
// - чистим код.
//
// Revision 1.71  2014/08/19 14:25:53  lulin
// - чистим код.
//
// Revision 1.70  2014/08/19 14:14:30  lulin
// - чистим код.
//
// Revision 1.68  2014/08/19 14:00:45  lulin
// - чистим код.
//
// Revision 1.66  2014/08/19 13:22:23  lulin
// - чистим код.
//
// Revision 1.65  2014/08/19 13:14:07  lulin
// - пораньше защищаем ресурс.
//
// Revision 1.63  2014/08/19 12:59:36  lulin
// - добавляем диагностику данных при записи.
//
// Revision 1.60  2014/08/19 11:41:20  lulin
// - рефакторинг.
//
// Revision 1.59  2014/08/19 11:25:46  lulin
// - рефакторинг.
//
// Revision 1.57  2014/05/28 07:06:55  lulin
// - чистим код.
//
// Revision 1.56  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.55  2012/11/01 09:43:31  lulin
// - забыл точку с запятой.
//
// Revision 1.54  2012/11/01 07:45:58  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.53  2012/11/01 07:09:33  lulin
// - вычищаем мусор.
//
// Revision 1.52  2012/10/10 09:29:30  lulin
// - включаем костыль.
//
// Revision 1.51  2012/10/10 09:27:23  lulin
// - чистим код.
// - временно выключил костыль.
//
// Revision 1.50  2012/10/10 09:00:20  lulin
// - чистим код.
//
// Revision 1.49  2012/10/09 13:26:05  lulin
// - вставляем костыль.
//
// Revision 1.48  2012/09/12 14:15:26  lulin
// {RequestLink:392696007}
//
// Revision 1.47  2012/05/30 13:21:24  voba
// - bug fix : обработка некорректной ситуации недописанного файла в хранилище
//
// Revision 1.46  2012/05/25 13:43:52  lulin
// - чистка кода.
//
// Revision 1.45  2012/05/04 19:42:49  lulin
// {RequestLink:361038156}
//
// Revision 1.44  2012/05/04 10:04:36  lulin
// {RequestLink:361038156}
//
// Revision 1.43  2012/05/04 08:31:15  lulin
// {RequestLink:361038156}
//
// Revision 1.42  2012/01/20 13:16:24  dinishev
// {Requestlink:327822716}
//
// Revision 1.41  2011/12/28 16:14:37  lulin
// {RequestLink:325257155}
// - не храним вычисляемую константу.
//
// Revision 1.40  2011/12/28 15:53:06  lulin
// {RequestLink:325257155}
// - переходим от указателей к переменным.
//
// Revision 1.37  2011/12/28 09:29:10  lulin
// {RequestLink:325257155}
// - чистим код.
//
// Revision 1.36  2011/12/27 15:36:29  lulin
// {RequestLink:324571064}
// - аккуратнее чистим данные перед положением объекта в кеш.
//
// Revision 1.35  2011/10/05 11:12:11  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.34  2010/12/06 14:52:10  voba
// no message
//
// Revision 1.33  2009/11/27 12:54:08  lulin
// {RequestLink:172365087}.
//
// Revision 1.32  2009/07/20 11:22:23  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.31  2009/06/10 16:30:48  lulin
// - не записывали оглавление на новом месте, после создания индексной части, в результате имели битое хранилище.
//
// Revision 1.30  2009/06/09 06:21:25  oman
// Не собиралась библиотека
//
// Revision 1.29  2009/06/08 11:37:13  lulin
// - исправляем неправильные элементы каталога.
// - выводим отладочную информацию.
//
// Revision 1.28  2009/03/23 08:33:11  lulin
// - не записываем заголовок хранилища, если не читали его.
//
// Revision 1.27  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.26  2009/03/18 12:07:44  lulin
// - после успешной записи потока переименовываем его в то название по которому пытаемся его писать.
//
// Revision 1.25  2009/03/12 19:11:57  lulin
// - <K>: 138969458. Чистка устаревшего кода.
//
// Revision 1.23  2008/06/05 12:07:39  narry
// - отключение мусора
//
// Revision 1.22  2008/06/04 12:33:14  fireton
// - лог залочек root'а
//
// Revision 1.21  2007/12/21 10:02:19  lulin
// - модуль m3StorageInterfaces полностью перенесен на модель.
//
// Revision 1.20  2007/08/24 20:28:41  lulin
// - cleanup.
//
// Revision 1.19  2007/08/24 19:04:05  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.18  2007/08/24 18:57:39  lulin
// - избавляемся от "неправильного" перемещения памяти.
//
// Revision 1.17  2007/08/20 14:45:29  lulin
// - выводим исключение в log.
//
// Revision 1.16  2007/08/14 19:32:06  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.15  2007/04/19 10:51:37  voba
// - спасение тверских данных
//
// Revision 1.14  2007/03/22 10:12:07  lulin
// - cleanup.
//
// Revision 1.13  2007/03/22 10:09:28  lulin
// - bug fix: некорректно проверяли неюникодные имена.
//
// Revision 1.12  2007/02/13 16:36:49  lulin
// - используем более простые функции сравнения.
//
// Revision 1.11  2005/05/24 11:07:42  lulin
// - cleanup.
//
// Revision 1.10  2005/02/16 07:55:55  lulin
// - bug fix: был AV при удалении директории в хранилище.
//
// Revision 1.9  2005/02/14 15:12:01  lulin
// - изменены сигнатуры методов.
//
// Revision 1.8  2005/01/18 10:23:38  lulin
// - уменьшен размер временных файлов для Немезиса.
//
// Revision 1.7  2004/09/24 09:36:58  lulin
// - выводим в лог сообщения об ошибках.
//
// Revision 1.6  2004/09/24 08:25:46  lulin
// - bug fix: не очищались поля.
//
// Revision 1.5  2004/09/21 11:22:28  lulin
// - Release заменил на Cleanup.
//
// Revision 1.4  2004/09/16 09:25:23  lulin
// - bug fix: наследники от evCtrl убивались в DesignTime произвольным образом.
//
// Revision 1.3  2004/09/09 16:29:57  lulin
// - отключил директиву m3LogLocks.
//
// Revision 1.2  2004/09/09 14:53:53  lulin
// - small fix.
// - сделан вывод в лог информации и залочках в новом хранилище.
//
// Revision 1.1  2004/09/02 08:09:49  law
// - cleanup.
//
// Revision 1.80  2004/09/01 16:23:32  voba
// - bug fix не отпускался элемент хранилища, перед освобождением цепочки блоков.
//
// Revision 1.79  2004/09/01 16:17:40  law
// - bug fix: был перепутан порядок параметров.
//
// Revision 1.78  2004/08/31 15:42:07  law
// - bug fix: в PlugIn'е для Far'а не перезаписывались отредактированные файлы.
//
// Revision 1.77  2004/08/31 15:11:14  law
// - bug fix: заточка для выливки в NSRC псевдографики странным образом сказалась на работоспособности хранилища (не опознавались индексные файлы).
// - bug fix: неправильно удалялись документы из индекса.
//
// Revision 1.76  2004/08/31 13:02:12  law
// - доделано удаление элементов из индексированного хранилища.
//
// Revision 1.75  2004/08/27 13:48:03  law
// - сделано получение документа из реальной базы.
//
// Revision 1.74  2004/08/27 09:25:19  law
// - даем индексным потокам более осмысленные имена.
//
// Revision 1.73  2004/08/26 16:04:17  law
// - проверка валидности считанных данных перенесена в более подходящее место.
//
// Revision 1.72  2004/08/23 14:55:03  law
// - bug fix: нельзя было открывать потоки внутри итератора.
//
// Revision 1.71  2004/05/27 14:32:18  law
// - new methods: _Tl3_CBase._IsCacheable, _NeedStoreInPool.
//
// Revision 1.70  2004/05/11 13:06:43  law
// - change: используем "свои" константы вместо констант Windows.
//
// Revision 1.69  2004/05/11 12:48:40  law
// - сделан более вразумительный тип входных параметров.
//
// Revision 1.68  2004/05/11 12:39:34  law
// no message
//
// Revision 1.67  2004/05/11 12:38:58  law
// - new directive: m3StorageHasGarbage.
//
// Revision 1.66  2004/05/11 12:28:41  law
// - change: вернул размер кластера 256.
//
// Revision 1.65  2004/05/07 15:45:38  law
// - поправлено форматирование.
// - добавлены директивы, выключающие ненужные данные в хранилище.
//
// Revision 1.64  2003/05/12 09:20:25  law
// - rename proc: ev_plIsNil -> l3IsNil.
//
// Revision 1.63  2002/10/16 14:13:31  narry
// - change: добавлена возможность открытия/создания потока без сжатия.
//
// Revision 1.62  2002/09/03 15:43:27  law
// - bug fix: не всегда правильно работала функция _IsValidName.
//
// Revision 1.61  2002/06/17 14:24:16  law
// - new method: _OpenStore.
//
// Revision 1.60  2002/06/17 13:44:46  law
// - new const: m3_saRead, m3_saReadWrite, m3_saCreate.
//
// Revision 1.59  2002/04/26 16:01:04  law
// - change: вставлена диагностика ошибки размера потока.
//
// Revision 1.58  2002/04/26 13:17:12  law
// - bug fix: пытаемся корректировать битые элементы каталога.
//
// Revision 1.57  2002/04/18 15:09:03  law
// - new behavior: _CopyTo копирует теперь и индексные элементы.
//
// Revision 1.56  2002/04/18 14:05:42  law
// - bug fix: неправильно копировались пакованные потоки.
//
// Revision 1.55  2002/04/18 13:28:43  law
// - bug fix: неправильно копировались пакованные потоки.
//
// Revision 1.54  2002/04/06 10:29:57  law
// - optimization: убрано чтение/запись CRC.
//
// Revision 1.53  2002/04/05 12:53:07  law
// - change: расширен интерфейс Im3IndexedStorage.
//
// Revision 1.52  2002/03/12 14:07:40  law
// - new behavior: в списках убран контроль CRC.
//
// Revision 1.51  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.50  2002/02/22 10:30:53  law
// - optimization: используем интерфейс Im3IndexedStorage.
//
// Revision 1.49  2002/02/21 15:58:17  law
// - optimization.
//
// Revision 1.48  2002/01/30 16:03:05  law
// - bug fix: не всегда работал PlugIn.
//
// Revision 1.47  2002/01/30 14:24:04  law
// - new interface: Im3IndexedStorage.
//
// Revision 1.46  2002/01/30 13:37:21  law
// - new methods: _Tm3Storage.CreateOpenStorage & CheckIndex.
//
// Revision 1.45  2002/01/30 12:35:01  law
// - new behavior: сделан перебор элементов индекса.
//
// Revision 1.44  2002/01/29 12:51:28  law
// - new behavior: немного изменена схема доступа к индексным потокам.
//
// Revision 1.43  2002/01/29 09:13:48  law
// - new behavior: подготавливаем объект _Tm3StorageStream к кешируемости.
//
// Revision 1.42  2002/01/28 13:02:34  law
// - new behavior: подготавливаем объект _Tm3StorageStream к кешируемости.
//
// Revision 1.41  2002/01/24 16:30:25  law
// - new behavior: сделан доступ по индексу к элементам хранилища.
//
// Revision 1.40  2002/01/22 09:50:36  law
// - cleanup: число 20 заменил на соответствующую константу SizeOf(..).
//
// Revision 1.39  2002/01/21 16:56:31  law
// no message
//
// Revision 1.38  2002/01/21 16:44:22  law
// - temporary _save: заготовки для использования целочисленного индекса.
//
// Revision 1.37  2002/01/21 13:22:59  law
// - cleanup.
//
// Revision 1.36  2002/01/18 17:51:48  law
// - cleanup.
//
// Revision 1.35  2002/01/18 17:32:23  law
// - new prop: Tm3TOCItemData._TOCListPosition.
//
// Revision 1.34  2002/01/18 16:44:24  law
// - cleanup.
//
// Revision 1.33  2002/01/18 14:54:16  law
// - change: процедуры *Storage и *Stream объединены в *Store.
//
// Revision 1.32  2002/01/17 18:41:33  law
// - new behavior: сделал логику _Tm3BaseHandleList более похожей на Tl3VList.
//
// Revision 1.31  2002/01/17 16:00:47  law
// - optimization: убраны ненужные поля.
//
// Revision 1.30  2002/01/17 13:22:06  law
// - change _data struct: Tl3PCharLen -> Tl3String.
// - optimization: убрана двойная буферизация.
//
// Revision 1.29  2002/01/17 12:37:51  law
// - optimizing: убраны ненужные поля.
//
// Revision 1.28  2002/01/17 11:46:03  law
// - reformatting & optimizing.
//
// Revision 1.27  2002/01/16 18:00:40  law
// - change: у TOCItem убивается строка при положении в кеш - во избежании коллизий при Shared-строках.
//
// Revision 1.26  2002/01/10 16:29:18  law
// - try to optimize: получение размера потока без _Seek.
//
// Revision 1.25  2002/01/10 14:08:41  law
// - change _data struct: Tl3PCharLen -> Tl3String.
//
// Revision 1.24  2002/01/10 13:18:26  law
// - change _data struct: _PWideChar -> Tl3PCharLen.
//
// Revision 1.23  2002/01/10 09:52:20  law
// - change _data struct: _PWideChar -> Tl3PCharLen.
//
// Revision 1.22  2002/01/10 08:55:39  law
// - change _data struct: WideString -> Tl3String.
//
// Revision 1.21  2002/01/10 08:27:30  law
// - new behavior: WideString -> Tl3String.
//
// Revision 1.20  2002/01/10 07:15:54  law
// - reformatting.
//
// Revision 1.19  2002/01/09 14:45:34  law
// - new behavior: сделана буферизация при чтении/записи оглавления.
//
// Revision 1.18  2002/01/09 13:51:24  law
// - reformatting.
//
// Revision 1.17  2002/01/09 13:16:06  law
// - new behavior: для зачитывания имени элемента каталога используем Tl3String, а не WideString.
//
// Revision 1.16  2001/12/27 14:53:56  law
// - reformatting.
//
// Revision 1.15  2001/12/26 18:26:22  law
// - bug fix: заточка под баг Delphi 5.
//
// Revision 1.14  2001/12/26 15:34:52  law
// - reformatting.
//
// Revision 1.13  2001/12/26 15:03:52  law
// - reformatting.
//
// Revision 1.12  2001/11/29 17:02:43  law
// - new directive: _m3NeedStorageFixer.
//
// Revision 1.11  2001/11/29 15:46:17  law
// - bug fix: исправляем некорректное поведение индексатора после прикручивания архивирования потоков. Временная копия. Пока не работает.
//
// Revision 1.10  2001/11/28 15:10:02  law
// - bug fix: поправлен PlugIn для Far'а - не читал архивированные хранилища.
//
// Revision 1.9  2001/11/28 14:19:32  law
// - new behavior: сделано создание хранилищ с автоматической паковкой.
//
// Revision 1.8  2001/11/02 08:06:16  law
// - new proc: l3NewMemoryChain.
//
// Revision 1.7  2001/11/01 17:56:25  law
// - optimization: на основе Tl3MemoryChain.
//
// Revision 1.6  2001/11/01 14:57:24  law
// - change: изменен формат вызова метода _Seek.
//
// Revision 1.5  2001/10/30 11:51:13  law
// - comments: xHelpGen.
// - optimize: учитываем режим _ReadOnly.
//

{$I m3Define.inc}

interface

uses
  Windows,
  SysUtils,
  SyncObjs,

  Classes,

  ActiveX,
  COMObj,

  l3Interfaces,
  l3Types,
  l3Base,
  l3CProtoObject,
  l3Logger,

  m2AddDbg,
  m2AddPrc,
  m2S32Lib,
  m2S64Lib,
  m2MEMLib,
  m2HASLib,
  m2COMLib,

  m3StorageInterfaces,
  m3RootStream,
  m3RootStreamNew,
  m3StoreHeaderDataPrim,
  m3StoreHeaderData,
  m3StoreHeaderDataNew,
  m3RootStreamManagerPrimPrim,
  m3RootStreamManagerPrim,
  m3RootStreamManager,
  m3StoragePrim,
  m3StoreHeader,
  m3StorageBlock,
  m3NewRootStreamManager,
  m3CommonStorage,
  m3TOCHandle,
  m3TOCHandleList,
  m3NewStoragePrim,
  m3CustomNewStorage
  ;

type
  Tm3NewStorage = class(Tm3CustomNewStorage)
   {* Реализация _IStorage, библиотеки m3. }
    protected
    // internal methods
      procedure         CopyTo              (const AExcludeCount: LongInt;
                                             const AExcludeArray: PIID;
                                             const AExcludeSNB: TSNB;
                                             const AStorage: IStorage;
                                             var   AReturn: HRESULT
                                            );
        override;
        {-}
      procedure MoveElementTo(const ASrcName : Tl3WString;
                              const AStorage : IStorage;
                              const ADstName : PWideChar;
                              const AFlags   : LongInt;
                              var   AReturn  : HRESULT);
        override;
        {-}
           procedure         DoEnumElements        (var   AEnumStatStg: IEnumStatStg;
                                                  var   AReturn: HRESULT
                                                 ); override;


     procedure DoDestroyElement(const AName   : Tl3WString;
                              var   AReturn : HRESULT);
       override;
       {-}
     procedure RenameElement(const AOldName : Tl3WString;
                             const ANewName : Tl3WString;
                             var   AReturn  : HRESULT);
       override;
       {-}
  end;//Tm3NewStorage

implementation

uses
  Math,

  l3Chars,
  l3Const,
  l3Memory,
  l3String,
  l3StringEx,
  l3ExceptionsLog,

  m3Const,
  m3StorageTools,
  m3Exceptions,
  m3CommonStorageStream,
  m3ReadOnlyRootStreamManager,
  m3NewStorageStream,
  m3StorageIndexStream,
  m3StorageIndexStreamForIterate,
  m3StorageTableOfContentsStream,
  m3BuffStream,
  m3TempStream,
  m3TempEnumStatStg
  ;

procedure __CopyStorage(const anInStorage          : Im3IndexedStorage;
                        const aStoreInfo           : Tm3StorageElementInfo;
                        const AStorage             : IStorage;
                        const ADstName             : PWideChar);
begin
 m2COMCopyData(m2COMCreateStorage(AStorage, ADstName, m3_saReadWrite, True),
               anInStorage.OpenStore(aStoreInfo, m3_saRead, true).AsIStorage);
end;

procedure   __CopyStream(const anInStorage          : Im3IndexedStorage;
                         const aStoreInfo           : Tm3StorageElementInfo;
                         const AStorage             : IStorage;
                         const ADstName             : PWideChar
                        );
begin
 m2COMCopyData(m2COMCreateStream(AStorage, ADstName, m3_saCreate, False),
               anInStorage.OpenStore(aStoreInfo, m3_saRead, true).rStream);
end;

procedure Tm3NewStorage.CopyTo(const AExcludeCount : LongInt;
                            const AExcludeArray : PIID;
                            const AExcludeSNB   : TSNB;
                            const AStorage      : IStorage;
                            var   AReturn       : HRESULT);

 function _CopyElement(const aStoreInfo : Tm3StorageElementInfo): Boolean;
 begin
  Result := true;
  case aStoreInfo.rInfo.rStoreType of
   m3_stStorage:
    __CopyStorage(Self, aStoreInfo, AStorage, PWideChar(l3DStr(aStoreInfo.rName)));
   m3_stStream:
    __CopyStream(Self, aStoreInfo, AStorage, PWideChar(l3DStr(aStoreInfo.rName)));
   else
    OleError(E_UNEXPECTED);
  end;//case HandleType
 end;

begin//CopyTo
 if SUCCEEDED(AReturn) then
 begin
  if ((AExcludeCount <> 0) or
      (AExcludeArray <> nil) or
      (AExcludeSNB <> nil)) then
   AReturn := STG_E_INVALIDPARAMETER
  else
  begin
   Lock;
   try
    IterateAllF(L2Mm3StorageIteratorsIterateAllFAction(@_CopyElement));
   finally
    Unlock;
   end;//try..finally
  end;
 end;//SUCCEEDED(AReturn)
end;//CopyTo

procedure Tm3NewStorage.MoveElementTo(const ASrcName : Tl3WString;
                                   const AStorage : IStorage;
                                   const ADstName : PWideChar;
                                   const AFlags   : LongInt;
                                   var   AReturn  : HRESULT);
var
 LIndex : LongInt;
begin
 if SUCCEEDED(AReturn) then
 begin
  if (IsValidName(ASrcName) and
      IsValidName(ADstName)) then
  begin
   Lock;
   try
    //with f_TableOfContents do
    begin
     if f_TableOfContents.FindItemByKey(aSrcName,LIndex) then
     begin
      with f_TableOfContents.Items[LIndex] do
      begin
       case StoreInfo.rStoreType of
        m3_stStorage:
         __CopyStorage(Self, Tm3StorageElementInfo_C(StoreInfo, HandleName.AsPCharLen), AStorage, ADstName);
        m3_stStream:
         __CopyStream(Self, Tm3StorageElementInfo_C(StoreInfo, HandleName.AsPCharLen), AStorage, ADstName);
        else
         OleError(E_UNEXPECTED);
       end;//case HandleType
      end;//with Items[LIndex]
      if (AFlags = STGMOVE_MOVE) then
       RemoveElementByTOCIndex(LIndex);
     end else
      AReturn := STG_E_FILENOTFOUND;
    end;//with f_TableOfContents
   finally
    Unlock;
   end;//try..finally
  end//IsValidName(ASrcName)
  else
   AReturn := STG_E_INVALIDNAME;
 end;//SUCCEEDED(AReturn)
end;

procedure Tm3NewStorage.DoEnumElements(var AEnumStatStg : IEnumStatStg;
                                  var AReturn      : HRESULT);

 function    __SaveToStream(const AStream: IStream;
                            var   AItemsCount: LongInt): IStream;

  type
    TStatStgInfo = packed record
      RSize      : Int64;
      RStateBits : LongInt;
    end;//TStatStgInfo

     function    __StorageStatStgInfo(const AStorage: Im3IndexedStorage
                                     ): TStatStgInfo; overload;
     var
         LStatStg:                 TStatStg;
     begin

      OleCheck(AStorage.Stat(LStatStg, STATFLAG_NONAME));

      with LStatStg do
       begin

        with Result do
         begin

          RSize := cbSize;
          RStateBits := grfStateBits;

         end;

       end;

     end;

     function __StorageStatStgInfo(const AEntryName           : Tl3String;
                                   const ATOCItemDataPosition : Int64): TStatStgInfo;
       overload;
     begin
      Result:=__StorageStatStgInfo(SubStorageClass.Make(m3_saRead,
                                                        AEntryName,
                                                        Header.RootStreamManager,
                                                        ATOCItemDataPosition));
     end;

     function __StreamStatStgInfo(const AStream: IStream): TStatStgInfo;
       overload;
     var
         LStatStg:                 TStatStg;
     begin

      OleCheck(AStream.Stat(LStatStg, STATFLAG_NONAME));

      with LStatStg do
       begin

        with Result do
         begin

          RSize := cbSize;
          RStateBits := grfStateBits;

         end;

       end;

     end;

     function __StreamStatStgInfo(const AEntryName           : Tl3String;
                                  const ATOCItemDataPosition : Int64): TStatStgInfo;
       overload;
     begin
      Result := __StreamStatStgInfo(Tm3NewStorageStream.Make(m3_saRead{_Access},
                                                             AEntryName,
                                                             Header.RootStreamManager,
                                                             ATOCItemDataPosition));
     end;

     procedure   __SaveBuff(const AStream: IStream;
                            const ABuff: Pointer;
                            const ASize: LongInt
                           );
     begin

      m2COMWriteBuffer(AStream,ABuff^,ASize);

     end;

     procedure   __SaveName(const AStream: IStream;
                            const AString: WideString
                           );
     var
         LSize:                    LongInt;
     begin

      LSize:=Length(AString)*SizeOf(WideChar);

      __SaveBuff(AStream,@LSize,SizeOf(LSize));
      __SaveBuff(AStream,PWideChar(AString),LSize);

     end;

     procedure   __SaveStatStgInfo(const AStream: IStream;
                                   const AStatStgInfo: TStatStgInfo
                                  );
     begin

      __SaveBuff(AStream,@AStatStgInfo,SizeOf(AStatStgInfo));

     end;

     procedure   __SaveType(const AStream: IStream;
                            const AType: LongInt
                           );
     begin

      __SaveBuff(AStream,@AType,SizeOf(AType));

     end;

 var
  l_Name : Tl3String;

  function _IndexElement(const aStoreInfo: Tm3StorageElementInfo): Boolean;
  begin//_IndexElement
   Result := true;
   l_Name.AsWStr := aStoreInfo.rName;
   with aStoreInfo.rInfo do
    case rStoreType of
     m3_stStorage:
     begin
      __SaveName(AStream, l_Name.AsWideString);
      __SaveType(AStream, rStoreType);
      __SaveStatStgInfo(AStream, __StorageStatStgInfo(l_Name, rPosition));
     end;//m3_stStorage
     m3_stStream:
     begin
      __SaveName(AStream, l_Name.AsWideString);
      __SaveType(AStream, rStoreType);
      __SaveStatStgInfo(AStream, __StreamStatStgInfo(l_Name, rPosition));
     end;//m3_stStream
     else
      OleError(E_UNEXPECTED);
    end;//case rStoreType
   Inc(aItemsCount);
  end;//_IndexElement

 begin//__SaveToStream
  l_Name := Tl3String.Create;
  try
   IterateAllF(L2Mm3StorageIteratorsIterateAllFAction(@_IndexElement));
  finally
   l3Free(l_Name);
  end;//try..finally
  Result := AStream;
 end;//__SaveToStream

var
 LItemsCount: LongInt;
begin
 if SUCCEEDED(AReturn) then
 begin
  Lock;
  try
   LItemsCount := 0;
   AEnumStatStg := Tm3TempEnumStatStg.Make(
                     m2COMSetPosition(0,__SaveToStream(
                                      Tm3BuffStream.Make(
                                       Tm3TempStream.Make),
                                      LItemsCount)),
                     LItemsCount);

  finally
   Unlock;
  end;//try..finally
 end;//SUCCEEDED(AReturn)
end;

procedure Tm3NewStorage.DoDestroyElement(const aName   : Tl3WString;
                                    var   aReturn : HRESULT);
var
 l_Index     : LongInt;
 l_StoreInfo : Tm3StoreInfo;
 l_Name      : Tl3String;
begin
 if SUCCEEDED(aReturn) then
 begin
  if IsValidName(aName) then
  begin
   Lock;
   try
    if f_TableOfContents.FindItemByKey(aName, l_Index) then
     RemoveElementByTOCIndex(l_Index)
    else
    if FindItemByName(aName, m3_soDelete, l_StoreInfo) then
    begin
     l_Name := Tl3String.Make(aName);
     try
      RemoveElementByName(l_Name, l_StoreInfo)
     finally
      FreeAndNil(l_Name);
     end;//try..finalyl
    end
    else
     AReturn := STG_E_FILENOTFOUND;
   finally
    Unlock;
   end;//try..finally
  end//IsValidName(aName)
  else
   aReturn := STG_E_INVALIDNAME;
 end;//SUCCEEDED(AReturn)
end;

procedure Tm3NewStorage.RenameElement(const AOldName : Tl3WString;
                                   const ANewName : Tl3WString;
                                   var   AReturn  : HRESULT);
var
 LNewIndex : LongInt;
 LOldIndex : LongInt;
begin
 if SUCCEEDED(AReturn) then
 begin
  if (IsValidName(AOldName) and IsValidName(ANewName)) then
  begin
   Lock;
   try
    if not l3Same(aOldName, aNewName) then
    begin
     //with f_TableOfContents do
     begin
      if f_TableOfContents.FindItemByKey(aOldName,LOldIndex) then
      begin
       if f_TableOfContents.FindItemByKey(aNewName,LNewIndex) then
        AReturn := STG_E_FILEALREADYEXISTS
       else
       begin
        f_TableOfContents.Items[LOldIndex].HandleName.AsWStr := aNewName;
        if ((LNewIndex <> LOldIndex) AND (LNewIndex <> Succ(LOldIndex))) then
         f_TableOfContents.Move(LOldIndex, LNewIndex);
        f_TableOfContents.Modified := True;
       end;//FindTOCItem(aNewName,LNewIndex)
      end//FindTOCItem(aOldName,LOldIndex)
      else
       AReturn := STG_E_FILENOTFOUND;
     end;//with f_TableOfContents
    end;//aOldName <> aNewName
   finally
    Unlock;
   end;//try..finally
  end else
   AReturn:=STG_E_INVALIDNAME;
 end;//SUCCEEDED(AReturn)
end;

end.

