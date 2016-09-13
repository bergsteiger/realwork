unit alcuTaskManager;
{ $Id: alcuTaskManager.pas,v 1.164 2016/09/13 07:04:37 lukyanets Exp $ }

// $Log: alcuTaskManager.pas,v $
// Revision 1.164  2016/09/13 07:04:37  lukyanets
// Принимаем и сохраняем
//
// Revision 1.163  2016/09/12 12:27:53  lukyanets
// Принимаем и сохраняем
//
// Revision 1.162  2016/09/06 10:21:37  lukyanets
// Более правильно синхронизируемся.
//
// Revision 1.161  2016/09/05 12:58:24  lukyanets
// Расталкиваем очередь по приходу запроса
//
// Revision 1.160  2016/09/01 13:41:40  lukyanets
// Уменьшаем время реакции
//
// Revision 1.159  2016/08/31 10:30:09  lukyanets
// Первая доставка
//
// Revision 1.158  2016/08/29 12:51:28  lukyanets
// Принимаем запрос и готовимся отдавать файл
//
// Revision 1.157  2016/08/26 10:39:46  lukyanets
// Готовимся принимать запрос
//
// Revision 1.156  2016/08/11 10:41:54  lukyanets
// Полчищаем dt_user
//
// Revision 1.155  2016/06/16 05:38:38  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.154  2016/06/02 15:28:03  fireton
// - синхронизация с Гардоком журнала импортов
//
// Revision 1.153  2016/05/30 07:18:42  lukyanets
// Добавляем логи
//
// Revision 1.152  2016/05/27 11:16:45  fireton
// - синхронизация этапов в Гардок
//
// Revision 1.151  2016/05/20 09:49:32  lukyanets
// Вводим состояние "задача прерывается"
//
// Revision 1.150  2016/05/13 12:54:28  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.149  2016/05/12 11:34:14  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.148  2016/05/11 10:16:24  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.147  2016/04/28 13:17:47  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.146  2016/04/22 10:29:10  lukyanets
// Причесываем лог
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.145  2016/04/20 11:57:01  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.144  2016/04/15 11:54:29  lukyanets
// Чистим протухший код
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.143  2016/04/13 08:36:39  lukyanets
// Корректне закрываем сервер
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.142  2016/04/12 09:05:16  lukyanets
// Разрешаем задачу
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.141  2016/04/11 12:47:11  lukyanets
// Отлаживаем контейнерную задачу
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.140  2016/04/11 06:36:25  lukyanets
// Лажа при создании шедулерных задач
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.139  2016/04/07 13:56:39  lukyanets
// Заготовки прокси задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.138  2016/04/07 11:38:37  lukyanets
// Заготовки контейнерной задачи для шедулера
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.137  2016/04/06 09:45:45  lukyanets
// Заготовки контейнерной задачи для шедулера
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.136  2016/04/01 12:06:31  lukyanets
// Заготовки контейнерной задачи
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.135  2016/04/01 08:15:44  lukyanets
// Корректней отдаем дату следующей версии
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.134  2016/03/31 12:53:25  lukyanets
// Расчитываем даты версии/компиляции с учетом нескольких однотипных заданий
//
// Revision 1.133  2016/03/30 12:44:40  lukyanets
// Cleanup
//
// Revision 1.132  2016/03/09 10:07:23  lukyanets
// Функция не возвращала результат
//
// Revision 1.131  2016/03/04 09:34:32  lukyanets
// Отвалились вложенные задания
//
// Revision 1.130  2016/03/02 08:18:37  lukyanets
// Неверное условие
//
// Revision 1.129  2016/03/01 06:43:00  lukyanets
// Затыкаем маловероятные дыры
//
// Revision 1.128  2016/02/29 08:20:39  lukyanets
// Сериализуем удаление из списка
//
// Revision 1.127  2016/02/25 13:43:43  lukyanets
// Временный механизм откладывания выполнения
//
// Revision 1.126  2016/02/25 08:17:46  lukyanets
// Cleanup
//
// Revision 1.125  2016/02/17 12:58:47  lukyanets
// Убираем лишние логи
//
// Revision 1.124  2016/02/16 08:11:53  lukyanets
// Логи
//
// Revision 1.123  2016/02/15 13:37:48  lukyanets
// Ловушка для AF
//
// Revision 1.122  2016/02/15 12:53:58  lukyanets
// Подправил уровни логирования
//
// Revision 1.121  2015/11/26 08:45:27  lukyanets
// КОнстанты переехали
//
// Revision 1.120  2015/11/24 11:46:21  lukyanets
// Отладочные логи
//
// Revision 1.119  2015/11/12 10:36:30  lukyanets
// Вытаскиваем серверные команды на сервер
//
// Revision 1.118  2015/10/19 12:55:30  lukyanets
// Притормаживаем шедулер и очередь задач
//
// Revision 1.117  2015/10/19 11:13:53  lukyanets
// Не дублируем задачи и не останавливаемся при повторной загрузке очереди
//
// Revision 1.116  2015/10/13 14:10:55  lukyanets
// Останавливаем обработку на закрытой базе
//
// Revision 1.115  2015/10/13 09:02:29  lukyanets
// Cleanup
//
// Revision 1.114  2015/10/05 14:08:17  lukyanets
// Не то писали
//
// Revision 1.113  2015/09/11 08:31:27  lukyanets
// Скрываем неважные задачи
//
// Revision 1.112  2015/09/10 13:42:26  lukyanets
// Готовимся скрывать задачи на сервере
//
// Revision 1.111  2015/09/10 13:03:05  lukyanets
// Готовимся скрывать задачи на сервере
//
// Revision 1.110  2015/09/10 12:45:31  lukyanets
// Скрываем задачи в Арчи
//
// Revision 1.109  2015/09/08 14:38:11  lukyanets
// Заготовки импорта документов
//
// Revision 1.108  2015/09/08 06:46:13  lukyanets
// Синхронизация ОГВ
//
// Revision 1.107  2015/09/07 14:21:34  lukyanets
// Синхронизация ОГВ
//
// Revision 1.106  2015/07/02 07:34:39  lukyanets
// Описываем словари
//
// Revision 1.105  2015/05/08 07:52:49  lukyanets
// Cleanup
//
// Revision 1.104  2015/04/16 06:59:18  lukyanets
// Пишем в логи
//
// Revision 1.103  2015/04/15 13:56:11  lukyanets
// Даем клиенту возможность отменять свои задания
//
// Revision 1.102  2015/04/07 07:35:53  lukyanets
// Изолируем HT
//
// Revision 1.101  2015/03/10 11:12:21  lukyanets
// Не допускаем Assert
//
// Revision 1.100  2015/03/02 12:42:59  lukyanets
// Скидываем только у нужного
//
// Revision 1.99  2015/02/26 17:48:47  kostitsin
// Mult*y -> Multi
//
// Revision 1.98  2015/02/25 08:48:34  lukyanets
// MDPSync отправляет почту через сервер.
//
// Revision 1.97  2015/02/19 11:07:21  lukyanets
// Заготовки для проверки альтернативного подхода
//
// Revision 1.96  2015/02/19 09:40:12  lukyanets
// Заготовки для проверки альтернативного подхода
//
// Revision 1.95  2015/02/18 17:17:10  lulin
// - bug fix: не собиралось.
//
// Revision 1.94  2015/02/18 14:44:04  lukyanets
// Заготовки для проверки альтернативного подхода
//
// Revision 1.93  2015/01/30 12:58:44  lukyanets
// Забыл подписаться
//
// Revision 1.92  2015/01/30 12:10:10  lukyanets
// Делаем нотификацию об изменении списка задач
//
// Revision 1.91  2015/01/23 13:18:46  lukyanets
// Пишем в логи
//
// Revision 1.90  2015/01/22 14:31:12  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.89  2015/01/21 12:10:24  lukyanets
// Развязали deadlock
//
// Revision 1.88  2015/01/20 15:18:44  lukyanets
// Готовимся разруливать Deadlock
//
// Revision 1.87  2014/12/24 14:35:47  lukyanets
// Принимаем сообщение о корректировке каталога
//
// Revision 1.86  2014/12/19 14:24:26  lukyanets
// Выводим время
//
// Revision 1.85  2014/12/19 12:36:36  lukyanets
// Нарушался порядок обработки сообщений
//
// Revision 1.84  2014/12/19 11:48:52  lukyanets
// Нарушался порядок обработки сообщений
//
// Revision 1.83  2014/12/18 15:02:37  lukyanets
// Разводим пишуший и читающий сокет
//
// Revision 1.82  2014/12/17 11:02:54  lukyanets
// При удалении выводим еще и внешний номер
//
// Revision 1.81  2014/12/12 12:13:23  lukyanets
// Ускоряемся в 2 раза и профилируем
//
// Revision 1.80  2014/12/08 15:02:26  lukyanets
// Заготовки
//
// Revision 1.79  2014/12/02 13:07:14  lukyanets
// Доставляем прогресс до пользователя
//
// Revision 1.78  2014/12/02 07:30:27  lukyanets
// Меняем приоритет
//
// Revision 1.77  2014/11/28 15:18:43  lukyanets
// Пытаемся доставлять
//
// Revision 1.76  2014/11/27 14:00:13  lukyanets
// Правильней ждем прихода данных
//
// Revision 1.75  2014/11/26 14:40:54  lukyanets
// Боремся с обрывами связи
//
// Revision 1.74  2014/11/26 12:26:33  lukyanets
// К взлету готов
//
// Revision 1.73  2014/11/25 15:36:58  lukyanets
// Принимаем прогрес
//
// Revision 1.72  2014/11/19 07:49:21  lukyanets
// Получаем заготовку описания доставки
//
// Revision 1.71  2014/11/14 14:20:09  lukyanets
// Очищаем недоставленное
//
// Revision 1.70  2014/11/14 12:42:44  lukyanets
// Получаем список задач для забора результата
//
// Revision 1.69  2014/11/14 10:21:36  lukyanets
// Перетряхиваем код
//
// Revision 1.68  2014/11/14 09:12:48  lukyanets
// Перетряхиваем код
//
// Revision 1.67  2014/11/13 15:08:14  lukyanets
// Обрабатываем незарегестрированные сообщения
//
// Revision 1.66  2014/11/07 14:07:21  lukyanets
// Принимаем соединение
//
// Revision 1.65  2014/10/23 11:40:24  lukyanets
// Адекватное название состояния
//
// Revision 1.64  2014/10/22 07:01:57  lukyanets
// Cleanup
//
// Revision 1.63  2014/10/22 06:50:40  lukyanets
// Аккуратней захватываем задачу
//
// Revision 1.62  2014/10/21 13:32:50  lukyanets
// Пробуем не блокировать очередь на время выполнения задачи
//
// Revision 1.61  2014/10/02 07:45:58  lukyanets
// Не всегда сохраняли очередь задач
//
// Revision 1.60  2014/09/24 07:16:22  lukyanets
// {RequestLink:565271071}
//
// Revision 1.59  2014/09/23 11:04:44  lukyanets
// Cleanup
//
// Revision 1.58  2014/09/18 13:37:41  lukyanets
// {RequestLink:565271071} - уточнение логирования
//
// Revision 1.57  2014/09/18 10:05:58  lukyanets
// {RequestLink:565263723}
//
// Revision 1.56  2014/09/15 12:36:19  lukyanets
// Красивей даем заводить -1
//
// Revision 1.55  2014/09/15 11:56:16  lukyanets
// Изменение количества утилит не требует перезапуска сервера
//
// Revision 1.54  2014/09/15 09:32:43  lukyanets
// Cleanup
//
// Revision 1.53  2014/09/11 12:45:39  lukyanets
// В инишник пишем типы задач которые *можно* отцеплять
//
// Revision 1.52  2014/09/11 12:16:56  lukyanets
// Отцепляем/доставляем на фоне работающей синхронной задачи.
//
// Revision 1.51  2014/09/11 10:32:47  lukyanets
// Вводим скобки вмето флажка
//
// Revision 1.50  2014/09/10 06:38:21  lukyanets
// Забыл диагностику + растим ручку для параллельного AACImport
//
// Revision 1.49  2014/09/10 06:18:38  lukyanets
// Более адекватное название метода
//
// Revision 1.48  2014/09/09 08:19:01  lukyanets
// Cleanup
//
// Revision 1.47  2014/09/04 08:15:41  lukyanets
// Cleanup
//
// Revision 1.46  2014/09/02 12:14:29  lukyanets
// Не нотифицировали о завершении задачи
//
// Revision 1.45  2014/09/02 07:48:05  lukyanets
// Отцепляем экспорт в регионы
//
// Revision 1.44  2014/09/01 08:17:36  lukyanets
// Cleanup
//
// Revision 1.43  2014/08/29 13:03:18  lukyanets
// Cleanup
//
// Revision 1.42  2014/08/29 12:47:00  lukyanets
// Превращаем таск в реквест
//
// Revision 1.41  2014/08/29 12:25:05  lukyanets
// При убивании сервера морозим отцепленные задачи, чтобы они перестартовали
//
// Revision 1.40  2014/08/29 10:07:41  lukyanets
// Cleanup
//
// Revision 1.39  2014/08/27 12:05:47  lukyanets
// Переносим логику с сервера в таск alcuAutoExport
//
// Revision 1.38  2014/08/27 09:41:45  lukyanets
// Cleanup
//
// Revision 1.37  2014/08/25 13:38:50  lukyanets
// Переносим логику в таск
//
// Revision 1.36  2014/08/25 12:02:09  lukyanets
// Хороним экспорт для ФНС
//
// Revision 1.35  2014/08/22 12:54:27  lukyanets
// {Requestlink:563199760}. Отцепляем экспорт прайма
//
// Revision 1.34  2014/08/21 12:23:31  lukyanets
// {Requestlink:563199760}. Переносим логику cs_ttAnnoExport в таск
//
// Revision 1.33  2014/08/21 10:17:55  lukyanets
// Разгружаем сервер от излишних знаний.
//
// Revision 1.32  2014/08/21 09:24:28  lukyanets
// {Requestlink:563199760}. Спрямляем наследование
//
// Revision 1.31  2014/08/21 07:05:46  lukyanets
// Cleanup
//
// Revision 1.30  2014/08/20 13:45:11  lukyanets
// {Requestlink:558466572}. Расставляем возможность одноврменной работы
//
// Revision 1.29  2014/08/19 14:29:54  lukyanets
// {Requestlink:558466572}. Превращаем alcuMDP в НЕтаск
//
// Revision 1.28  2014/08/19 12:20:32  lukyanets
// Cleanup
//
// Revision 1.27  2014/08/19 11:57:28  lukyanets
// Подчищаем неадекватные cs_tsFrozenRun
//
// Revision 1.26  2014/08/19 11:11:20  lukyanets
// Cleanup
//
// Revision 1.25  2014/08/19 07:55:03  lukyanets
// {Requestlink:560730919}. Избавились от TaskWithCustomRun
//
// Revision 1.24  2014/08/18 10:56:03  lukyanets
// {Requestlink:562611471}. Вертаем взад
//
// Revision 1.23  2014/08/15 11:55:40  fireton
// - не сохранялись запросы на сервере
//
// Revision 1.22  2014/08/14 07:09:06  lukyanets
// {Requestlink:560730919}. Корректней проверяем измененность очереди задач
//
// Revision 1.21  2014/08/11 09:26:28  lukyanets
// Чистим
//
// Revision 1.20  2014/08/08 12:09:42  lukyanets
// {Requestlink:560730919}. Отцепили Progressor от сервера
//
// Revision 1.19  2014/08/07 14:02:20  lukyanets
// {Requestlink:556143119}. Вытащили ручки для отключения конкретных типов задач
//
// Revision 1.18  2014/08/07 06:40:11  lukyanets
// {Requestlink:556143119}. Готовимся к рулению асинхронного запуска от AppConfig
//
// Revision 1.17  2014/08/06 12:35:59  lukyanets
// {Requestlink:556143119}. Отцепили импорт
//
// Revision 1.16  2014/08/06 11:29:11  lukyanets
// {Requestlink:556143119}. Передаем результаты по сети
//
// Revision 1.15  2014/08/06 10:28:27  lukyanets
// {Requestlink:556143119}. Рапортуем в правильном месте
//
// Revision 1.14  2014/08/06 07:55:22  lukyanets
// {Requestlink:556143119}. Готовим TaskResult
//
// Revision 1.13  2014/08/05 07:38:13  lukyanets
// Cleanup
//
// Revision 1.12  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.11  2014/08/04 14:29:43  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - PrimeLite
//
// Revision 1.10  2014/08/04 13:12:39  lukyanets
// {Requestlink:558466572}. Отцепляем HavanskyExport
//
// Revision 1.9  2014/08/04 09:33:42  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - MisspellCorrect
//
// Revision 1.8  2014/08/04 06:39:00  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - ddDossierMaker
//
// Revision 1.7  2014/08/01 10:22:38  lukyanets
// {Requestlink:558466572}. Отцепляем ddAppConfiguration
//
// Revision 1.6  2014/07/31 14:05:07  lukyanets
// {Requestlink:558466572}. Отцепляем ddAppConfiguration
//
// Revision 1.5  2014/07/31 10:16:13  lukyanets
// Регестрируем более правильный тип таска
//
// Revision 1.4  2014/07/30 13:29:18  lukyanets
// {Requestlink:556143119}. Отцепляем TalcuAutoAnnoExport
//
// Revision 1.3  2014/07/30 06:43:42  lukyanets
// {Requestlink:556143119}. Нормализуем расстановку приоритетов
//
// Revision 1.2  2014/07/29 08:14:34  lukyanets
// {Requestlink:557844282}. Цель достигнута
//
// Revision 1.1  2014/07/28 15:18:17  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.216  2014/07/25 09:45:28  lukyanets
// {Requestlink:557844282}. Подружили dt_mail с ассистентом
//
// Revision 1.215  2014/07/25 07:33:53  lukyanets
// {Requestlink:557844282}. Оказалось dt_mail впоне умеет перепихивать сообщения через сервер
//
// Revision 1.214  2014/07/24 12:05:17  lukyanets
// {Requestlink:556730516}. Нотификация о завершении задачи
//
// Revision 1.213  2014/07/24 11:15:50  lulin
// - bug fix: не собиралось.
//
// Revision 1.212  2014/07/24 10:06:08  lukyanets
// {Requestlink:556730516}. Более правильное название
//
// Revision 1.211  2014/07/24 08:15:53  lukyanets
// {Requestlink:556730516}. Блокируем одновременное исполнение от одного UserID
//
// Revision 1.210  2014/07/23 12:49:20  lukyanets
// {Requestlink:556730516}. Настраиваем асинхронную обработку
//
// Revision 1.209  2014/07/23 12:11:57  lukyanets
// {Requestlink:556730516}. Ждем отцепленных на пуле
//
// Revision 1.208  2014/07/23 07:57:29  lukyanets
// {Requestlink:556730516}. Заготовка пула
//
// Revision 1.207  2014/07/21 09:26:36  lulin
// - спрямляем модель.
//
// Revision 1.206  2014/07/21 06:23:36  lulin
// - комментируем пока.
//
// Revision 1.205  2014/07/21 06:03:05  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.204  2014/07/18 13:46:15  lukyanets
// {Requestlink:556730516}. Поток для отцепления процесса
//
// Revision 1.203  2014/07/17 13:11:56  lukyanets
// {Requestlink:555415882}. В тестах дожидаемся завершения отцепленных задач
//
// Revision 1.202  2014/07/17 13:02:16  lukyanets
// {Requestlink:555415882}. Дожидаемся в тестах асинхронного завершения
//
// Revision 1.201  2014/07/16 15:35:48  lulin
// - вычищаем ненужное.
//
// Revision 1.200  2014/07/16 14:13:02  lulin
// - залечиваем "невыполнение" экспорта.
//
// Revision 1.199  2014/07/16 13:29:11  lulin
// - подключаем "асинхронный экспорт".
// - чиним езду по памяти в очистке тасков.
//
// Revision 1.198  2014/07/16 10:39:48  lukyanets
// {Requestlink:553422280}. Упрощаем условия
//
// Revision 1.197  2014/07/16 10:16:24  lukyanets
// {Requestlink:553422280}. Не нотифицируем лишний раз клиента
//
// Revision 1.196  2014/07/16 07:48:08  lukyanets
// {Requestlink:553422280}. Притормаживаем отцепленное выполнение
//
// Revision 1.195  2014/07/15 07:23:39  lukyanets
// {Requestlink:553422280}. Перепихиваем ошибки по трубе
//
// Revision 1.194  2014/07/14 11:47:06  lukyanets
// {Requestlink:553422280}. Ждем отцепленных при приостановке обработки задач
//
// Revision 1.193  2014/07/11 10:14:40  lukyanets
// {Requestlink:553422280}. Корректней реагируем на заморозку задачи
//
// Revision 1.192  2014/07/11 08:03:33  lukyanets
// {Requestlink:553422280}. Не пускались таски после аборта
//
// Revision 1.191  2014/07/10 13:09:32  lukyanets
// {Requestlink:553422280}. Прокидываем прогресс
//
// Revision 1.190  2014/07/09 13:13:05  lulin
// - заворачиваем список номеров документов в теги.
//
// Revision 1.189  2014/07/09 10:42:28  lukyanets
// {Requestlink:553422280}. Переносим градусник в таблицу.
//
// Revision 1.188  2014/07/09 08:45:35  lukyanets
// {Requestlink:553422280}. Абортируем отцепленные таски.
//
// Revision 1.187  2014/07/09 08:00:06  lukyanets
// {Requestlink:553422280}. Не вышло.
//
// Revision 1.186  2014/07/09 07:04:29  lukyanets
// {Requestlink:553422280}. Ищем где используется свойство.
//
// Revision 1.185  2014/07/09 06:53:04  lukyanets
// {Requestlink:553422280}. Более адекватное название.
//
// Revision 1.184  2014/07/08 13:57:49  lukyanets
// {Requestlink:553422280}. Разбираемся с ошибочными статусами
//
// Revision 1.183  2014/07/08 11:51:16  lukyanets
// {Requestlink:552022662}. Взлетели.
//
// Revision 1.182  2014/07/08 09:44:33  lukyanets
// {Requestlink:552022662}. Блокируем одновременное выполнение задач одного пользователя
//
// Revision 1.181  2014/07/08 07:06:25  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.180  2014/07/08 07:02:52  lukyanets
// {Requestlink:552022662}. Полный цикл
//
// Revision 1.179  2014/07/07 12:10:47  lulin
// - движемся к константности TaskType.
//
// Revision 1.178  2014/07/04 09:01:13  lukyanets
// {Requestlink:552022662}. Рулим приоритетами
//
// Revision 1.177  2014/07/03 15:25:22  lulin
// - чистим код.
//
// Revision 1.176  2014/07/03 13:47:22  lukyanets
// {Requestlink:552022662}. Макет выливки
//
// Revision 1.175  2014/07/02 17:13:07  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.174  2014/07/02 14:51:00  lukyanets
// {Requestlink:552022662}. Заглушка запуска
//
// Revision 1.173  2014/07/02 13:15:44  lukyanets
// {Requestlink:552022662}. Новый статус задачи
//
// Revision 1.172  2014/07/01 11:53:48  lulin
// - не падаем когда пришёл запрос уже при завершении.
//
// Revision 1.171  2014/06/25 14:19:51  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.170  2014/06/24 14:41:07  lulin
// - изменяем порядок обработки очереди и проверки недоставленных сообщений.
//
// Revision 1.169  2014/06/24 12:35:12  lulin
// - увеличиваем интервал проверки недоставленных заданий.
//
// Revision 1.168  2014/06/23 11:36:00  lulin
// - убираем лишний захват ресурсов.
//
// Revision 1.166  2014/06/23 10:58:00  lulin
// - пробуем избавится от излишней переотправки результатов.
//
// Revision 1.165  2014/06/23 10:20:59  lulin
// - пробуем избавится от излишней нотификации.
//
// Revision 1.164  2014/06/23 09:48:05  lulin
// - чистим код.
//
// Revision 1.163  2014/06/20 14:10:11  lulin
// - чистим код.
//
// Revision 1.160  2014/06/20 12:32:54  lulin
// - чистим код.
//
// Revision 1.159  2014/06/20 12:12:43  lulin
// - убираем критическую секцию из доставки результатов.
//
// Revision 1.158  2014/06/20 11:33:11  lulin
// - всё же правильнее перепосылаем сообщение - пусть уж лучше будут дубликаты, но забираются.
//
// Revision 1.157  2014/06/20 11:24:17  lulin
// - время от времени всё же вываливаемся из обработки очереди.
//
// Revision 1.156  2014/06/20 10:47:47  lulin
// - боремся с deadlock'ами.
//
// Revision 1.155  2014/06/19 17:32:22  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.154  2014/06/19 16:22:27  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.153  2014/06/19 12:07:00  lulin
// - делаем потокозащищённые списки пользователей.
//
// Revision 1.152  2014/06/18 16:01:38  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.151  2014/06/18 15:54:24  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.150  2014/06/18 15:09:02  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.149  2014/06/18 14:59:46  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.148  2014/06/18 14:35:09  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.147  2014/06/18 14:09:17  lulin
// - продолжаем рефакторинг списков заданий.
//
// Revision 1.146  2014/06/18 12:47:21  lulin
// - рисуем список заданий на модели.
//
// Revision 1.145  2014/06/18 12:36:02  lulin
// - рисуем список заданий на модели.
//
// Revision 1.144  2014/06/18 12:29:52  lulin
// - рисуем список заданий на модели.
//
// Revision 1.143  2014/06/18 11:57:43  lulin
// - разбираемся с ситуацией, когда статус заданий не обновлялся.
//
// Revision 1.142  2014/06/18 11:44:57  lulin
// - избавляем списки заданий от излишних знаний.
//
// Revision 1.141  2014/06/18 10:02:15  lulin
// - убираем ненужную критическую секцию.
//
// Revision 1.140  2014/06/17 17:49:33  lulin
// - реализуем потокозащищённые списки заданий.
//
// Revision 1.139  2014/06/17 17:12:52  lulin
// - реализуем потокозащищённые списки заданий.
//
// Revision 1.138  2014/06/17 17:01:09  lulin
// - реализуем потокозащищённые списки заданий.
//
// Revision 1.137  2014/06/17 12:32:50  lulin
// - чистим код.
//
// Revision 1.135  2014/06/17 11:50:59  lulin
// - убираем ненужный параметр, он и так потом из потока читается.
//
// Revision 1.134  2014/06/17 10:33:23  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.133  2014/06/16 15:53:16  lulin
// - чистим код.
//
// Revision 1.132  2014/06/16 13:45:09  lulin
// - чистим код.
//
// Revision 1.129  2014/06/11 08:59:33  lulin
// - чистим код.
//
// Revision 1.128  2014/06/11 07:22:31  lulin
// - используем запомненную активную задачу, а не перерассчитываем её.
//
// Revision 1.127  2014/06/11 07:09:13  lulin
// - запоминаем активную задачу, а не только её пользователя.
//
// Revision 1.126  2014/06/11 07:01:06  lulin
// - чистим код.
//
// Revision 1.125  2014/06/10 17:57:45  lulin
// - синхронизируем "узорчик" критических секций.
//
// Revision 1.124  2014/06/10 16:55:37  lulin
// - чистим код и улучшаем диагностику.
//
// Revision 1.123  2014/06/09 12:05:58  lulin
// - выводим в лог папку с результатами.
//
// Revision 1.122  2014/06/06 15:58:53  lulin
// - улучшаем диагностику.
//
// Revision 1.121  2014/06/06 11:27:26  lulin
// - Доставляем результаты всегда, когда нас об этом попросил пользователь.
//
// Revision 1.120  2014/06/06 11:20:01  lulin
// - чистим код.
// - исправляем ошибки.
//
// Revision 1.119  2014/06/05 14:59:00  lulin
// - чистим код.
// - улучшаем диагностику.
//
// Revision 1.118  2014/06/05 12:09:12  lulin
// - чистим код.
//
// Revision 1.117  2014/06/05 12:01:12  lulin
// - разбираемся с недоставкой сообщений в тестовом сервере.
//
// Revision 1.116  2014/06/04 16:03:17  lulin
// [$540613122]
//
// Revision 1.115  2014/06/03 15:34:10  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.114  2014/06/02 10:16:16  lulin
// - вычищаем мусор.
//
// Revision 1.113  2014/05/30 17:28:02  lulin
// - рефакторим обработку команд.
//
// Revision 1.112  2014/05/29 17:08:59  lulin
// - чистим код.
//
// Revision 1.111  2014/05/29 16:39:59  lulin
// - переименовываем безликое свойство.
//
// Revision 1.110  2014/05/29 09:22:51  lulin
// - чистим код.
//
// Revision 1.108  2014/05/29 08:19:04  lulin
// - чистим код.
//
// Revision 1.107  2014/05/29 07:47:59  lulin
// - избавляемся от "атак на лог".
//
// Revision 1.106  2014/05/28 12:45:49  lulin
// - переделываем нотификацию об изменении состояния задания.
//
// Revision 1.105  2014/05/28 07:58:50  lulin
// - чистим код.
//
// Revision 1.104  2014/05/28 07:38:19  lulin
// - убираем странные проверки числа активных заданий.
//
// Revision 1.103  2014/05/27 09:50:35  lulin
// - чистка кода.
//
// Revision 1.102  2014/05/15 17:52:45  lulin
// {RequestLink:517789752}.
//
// Revision 1.101  2014/05/14 13:56:33  lulin
// {RequestLink:517789752}.
//
// Revision 1.100  2014/05/13 12:35:17  lulin
// - рефакторинг добавления заданий.
//
// Revision 1.99  2014/04/17 13:07:50  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.98  2014/02/17 13:03:46  GarikNet
// K:516544010
//
// Revision 1.97  2014/02/17 12:24:11  GarikNet
// K:516544010
//
// Revision 1.96  2014/02/17 10:28:42  GarikNet
// K:516544010
//
// Revision 1.95  2014/02/14 17:45:49  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.94  2014/02/14 17:42:37  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.93  2014/02/14 10:57:21  GarikNet
// K:516544010
//
// Revision 1.92  2014/02/12 15:32:12  lulin
// - переделываем эмуляцию прихода нового задания на более правильный механизм.
//
// Revision 1.91  2014/02/12 14:55:22  lulin
// - меняем тип потока.
//
// Revision 1.90  2014/02/12 12:39:12  lulin
// - рефакторим списки заданий.
//
// Revision 1.89  2014/02/12 10:15:35  GarikNet
// K:515862135
//
// Revision 1.88  2014/02/12 06:04:38  GarikNet
// K:516544010
//
// Revision 1.87  2014/02/11 15:46:10  lulin
// {RequestLink:516544329}
//
// Revision 1.86  2014/02/10 16:27:59  lulin
// {RequestLink:516533785}.
// - правильнее выпиливаем тестовую обвязку для {RequestLink:515862135}.
//
// Revision 1.85  2014/02/10 14:50:35  lulin
// {RequestLink:516533785}.
//
// Revision 1.84  2014/02/10 11:00:00  GarikNet
// K:515862135
//
// Revision 1.83  2014/02/10 07:54:06  GarikNet
// K:516189258
//
// Revision 1.82  2014/02/10 06:27:07  GarikNet
// K:515862135
//
// Revision 1.81  2014/02/04 11:29:17  GarikNet
// Откатили измения
//
// Revision 1.80  2014/02/03 12:13:41  GarikNet
// K:515529250
// Ошибка обращение к списку активных задач при их сохранении
// на локальный диск (конфликт обращения асинхронных потоков
// к общему объекту)
//
// Revision 1.79  2013/04/04 11:22:27  narry
// Вычисление даты анонсирования (447388742)
//
// Revision 1.78  2013/04/03 09:50:41  fireton
// - логика простановки VANONCED
//
// Revision 1.77  2013/02/21 07:35:01  narry
// Принудительное сохранение настроек
//
// Revision 1.76  2013/02/12 11:35:46  narry
// Возможность настраивать Автоэкспорт с последнего успешного экспорта
//
// Revision 1.75  2013/02/05 10:13:46  narry
// Не отсылаем сообщения сами себе (они остаются мертвым грузом в списке)
//
// Revision 1.74  2013/01/28 11:41:26  narry
// Уточнение Автовыливки  (425270949)
//
// Revision 1.73  2013/01/11 12:14:40  narry
// * автоматическая упаковка результатов экспорта Хаванского (ЭХ)
// * автоматическое копироване ЭХ на FTP
// * дельта экспорта МЦФР
//
// Revision 1.72  2012/10/18 07:15:27  narry
// Версия pipeout2, умеющая строить списки новых и измененных (383583730)
//
// Revision 1.71  2012/10/02 07:39:35  narry
// Поддержка экспортов Хаванского и МЦФР
//
// Revision 1.70  2012/08/28 10:07:09  narry
// Больше не отправляем письма про выключение заданий и падение импорта
//
// Revision 1.69  2012/08/13 12:46:08  narry
// Обновление
//
// Revision 1.68  2012/08/02 13:16:28  narry
// Ограничение импорта по количеству документов (380619133)
//
// Revision 1.67  2012/07/13 11:29:10  narry
// Исправление опечаток из Арчи
//
// Revision 1.66  2012/07/10 11:01:36  narry
// Автоэкспорт по группам документа (375424179)
//
// Revision 1.65  2012/07/10 09:31:08  narry
// Разобраться с папками пользовательских заданий (274847170)
//
// Revision 1.64  2012/05/28 10:58:56  narry
// Обновление
//
// Revision 1.63  2012/05/14 09:28:41  narry
// Автодополнение справок (269063217)
//
// Revision 1.62  2012/05/12 12:21:05  narry
// Не присваивался _MessageManager
//
// Revision 1.61  2012/05/11 13:05:14  narry
// Не форматируются документы Югры (363566409)
//
// Revision 1.60  2012/04/17 13:23:15  narry
// Оптимизация выливки справок (356073078)
//
// Revision 1.59  2012/03/06 09:16:40  narry
// Получать с сервера список групп доступа Переданные в регион (273581950)
//
// Revision 1.58  2012/02/10 11:33:49  narry
// Не сохраняется очередь при перезапуске (336665219)
//
// Revision 1.57  2011/12/08 11:15:52  narry
// ошибки приоритета
//
// Revision 1.56  2011/11/23 09:21:36  narry
// Удалять документы пачкой (302744313)
//
// Revision 1.55  2011/11/17 05:11:28  narry
// Не собиралось
//
// Revision 1.54  2011/11/16 10:17:36  narry
// Интеграция импорта из К в сервер автоматизации (298682480)
//
// Revision 1.53  2011/10/10 10:43:25  narry
// Не работала проверка орфографии в выборке
//
// Revision 1.52  2011/05/16 13:37:00  narry
// Обработка запроса на импорт "подготовленных" постановлений (266409024)
//
// Revision 1.51  2011/05/13 09:28:45  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.50  2011/05/12 08:55:57  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.49  2011/05/12 05:21:21  narry
// Проверка орфографии в выборке (сервер) (260447428)
//
// Revision 1.48  2011/04/22 11:44:09  narry
// Реакция на кнопку (262636470)
//
// Revision 1.47  2011/04/08 07:04:15  narry
// К260442621. Сделать импорт постановлений ААС заданием
//
// Revision 1.46  2011/03/11 11:18:54  narry
// K255975299. Не импортируется дельта
//
// Revision 1.45  2011/01/19 08:18:41  narry
// Зацикливался вывод в лог после ошибки выполнения задания
// Выключение только тех типов заданий, что вызвали ошибку
//
// Revision 1.44  2010/09/24 12:41:08  voba
// - k : 235046326
//
// Revision 1.43  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//
// Revision 1.42  2010/07/27 06:49:59  narry
// К228690493
//
// Revision 1.41  2010/07/21 09:14:53  narry
// К91850862
//
// Revision 1.40  2010/07/20 14:21:25  narry
// К214599203
//
// Revision 1.39  2010/07/15 14:21:09  narry
// - K226005135. Повторная рассылка уведомлений о результатах экспорта
//
// Revision 1.38  2010/07/06 12:27:02  narry
// - К222759027
//
// Revision 1.36  2010/05/19 10:59:30  narry
// - K211878089
//
// Revision 1.35  2010/05/17 10:37:25  narry
// - K211878122
//
// Revision 1.34  2010/05/14 13:18:05  narry
// - K211878137
// - настройка для ААС
//
// Revision 1.33  2010/04/20 09:49:29  narry
// - обновление
//
// Revision 1.32  2010/04/02 12:11:26  narry
// - получение от клиента поискового запроса
//
// Revision 1.31  2010/03/24 05:57:02  narry
// - не распознавалось задание Экспорт для Прайм
//
// Revision 1.30  2010/03/19 14:01:58  narry
// - криво читались, писались элементы вложенных списков
// - обработка заданий в соответствии с приоритетами
//
// Revision 1.29  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.28  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.27  2009/06/24 13:12:59  narry
// - переделки под новый LinkServer
//
// Revision 1.26  2009/06/16 13:20:53  narry
// - если экспорт Прайма завершился неудачей, экпорт аннотаций для компиляции не выполняется
//
// Revision 1.25  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.24  2009/03/17 09:30:01  narry
// - процедуры записи в файл информации об удалении меток с атрибутами
//
// Revision 1.23  2009/02/20 13:29:35  narry
// - обновление
//
// Revision 1.22  2009/02/16 14:33:13  narry
// - обновление
//
// Revision 1.21  2009/01/30 10:04:35  narry
// - обновление
//
// Revision 1.20  2009/01/26 08:59:44  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.19  2009/01/23 16:27:47  narry
// - рефакторинг
//
// Revision 1.18.2.1  2009/01/23 14:07:40  fireton
// - перенос Парня на Query
//
// Revision 1.18  2008/11/24 15:09:58  narry
// - дельта для регионов как задание в очереди
//
// Revision 1.17  2008/10/30 12:56:59  narry
// - Единый КВ
// - Обновление
//
// Revision 1.16  2008/10/29 10:03:25  narry
// - перевод простановки "Передано в регионы" на ISab
//
// Revision 1.15  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.14  2008/09/25 08:25:11  narry
// - корректное вычисление даты версии, отталкиваясь от даты компиляции
//
// Revision 1.13  2008/08/20 14:43:36  narry
// - борьба с "Синдромом Наххас"
//
// Revision 1.12  2008/07/24 11:50:46  fireton
// - уведомление клиента об изменениях заданий в планировщике
//
// Revision 1.11  2008/07/21 11:46:09  fireton
// - КалеСо (версии и компиляции)
//
// Revision 1.10  2008/07/16 16:14:04  narry
// - реализация Автовыливки
//
// Revision 1.9  2008/07/14 08:08:42  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.8  2008/07/10 13:01:13  fireton
// - refactoring: типы календарных событий переехали "наверх"
//
// Revision 1.7  2008/06/06 15:08:03  narry
// - обновление
//
// Revision 1.6  2008/05/27 06:55:20  narry
// - несоответствие типов
//
// Revision 1.5  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.4  2008/04/23 10:43:15  narry
// - обновление
//
// Revision 1.3  2008/03/24 09:41:51  narry
// - при отправке аннотаций в Прайм не выливались аннотации для компиляции
//
// Revision 1.2  2008/03/13 14:02:24  narry
// - рефакторинг
//
// Revision 1.1  2008/03/04 12:09:52  narry
// - перенес ddServerTaskManager в проект
//
// Revision 1.58  2008/03/04 11:43:58  narry
// - выделил обработку аннотаций в отдельный модуль
//
// Revision 1.57  2008/02/27 15:46:55  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
//
// Revision 1.56  2008/02/19 16:01:51  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.55  2008/02/06 09:27:36  narry
// - не компилировалось
//
// Revision 1.54  2008/02/01 16:41:32  lulin
// - используем кошерные потоки.
//
// Revision 1.53  2008/02/01 13:38:21  narry
// - не компилировалось
//
// Revision 1.52  2008/01/30 09:20:35  narry
// - по окончании Автоклассификации уведомление посылается и через Арчи
//
// Revision 1.51  2007/12/25 12:03:21  narry
// - обновление
//
// Revision 1.50  2007/12/07 08:44:57  narry
// - запись в лог об изменении статуса задачи стала более информативной
//
// Revision 1.49  2007/12/06 11:11:58  narry
// - поддержка автоклассификации
//

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
 Windows, Classes, SyncObjs, SysUtils, Messages, ExtCtrls,
 {$IFNDEf Service}Forms,{$ENDIF}
 l3Base, l3Date, l3LongintList, l3Interfaces,
 daTypes,
 dt_Types,
 //dt_Tasks,
 dt_Doc, dt_Mail, l3BaseStream, l3Memory,
 dt_TblCacheDef,
 ht_Const, CsQueryTypes,
 csProcessTask, ddImportPipe, ExportPipe, ddProgressObj,
 l3IniFile, l3ObjectRefList,
 CSDataPipe, csMessageManager,
 ddServerTaskList, ddScheduler, dtIntf, dt_Sab, alcuTypes,
 csServerCommandsManager, csTaskTypes, ddServerTask, DT_AskList, alcuTaskList,

 l3ProtoObject,
 alcuTaskListPrim,
 ddServerTaskManagerPrim,
 alcuNotSortedTaskList,
 alcuTaskListBase,
 l3MultiThreadSortedIntegerList,
 dtUserIDList,
 l3Types,
 alcuSubmitterWorkPool,
 alcuBaseEngineHolder,
 alcuServerAsyncExecutionInterfaces,
 ncsServerTransporterPool,
 ncsMessageInterfaces,
 alcuImmidiateRequestInterfaces,
 ncsMessage, csCommon, alcuDeliveryInterfaces,
 alcuDetachedExecutorPool
 ;

type
 TddServerTaskManager = class(TddServerTaskManagerPrim, IalcuAsyncTaskFinishedNotifier, IcsRunTaskServices,
                              IncsMessageExecutorFactory, IalcuTaskFinisher, Il3ChangeRecipient)
 private
    f_Actions: TcsServerCommandsManager; // список указателей на методы обработки заданий
    f_ActiveTaskList: TalcuTaskList; // список заданий, ожидающих выполнения
    f_ActiveTask: TddProcessTask;
    f_Busy: Boolean;
    f_CommonDataList: TalcuNotSortedTaskList;
    f_TasksToPurgeList: TalcuNotSortedTaskList;
    f_BaseEngineHolder: TalcuBaseEngineHolder; // сервер
    f_DelayedList: TalcuTaskList;
    f_EnabledTaskTypes: TcsTaskTypes; // типы задач которые могут выполяться
    f_TaskExecutionEnabled: Boolean; // разрешение "из вне" выполнять все задания
    f_LastUpdate: TDateTime;
    f_LastChangedTask: TddProcessTask;
    f_LastChangedStatus: TcsTaskStatus;
    f_LastDelivering: TDateTime;
    f_LockProcessingCounter: Integer; // очередь обработки заданий заблокирована при f_LockProcessingCounter > 0
    f_MessageManager: TcsMessageManager;
    f_MonitorUsers: Tl3MultiThreadSortedIntegerList;
    f_PrivateMonitorUsers: Tl3MultiThreadSortedIntegerList;
    {$IFNDEF Service}
    f_OnException: TExceptionEvent;
    {$ENDIF}
    f_OnSendEmail: TSendEmailNotify;
    f_OnStatusChanged: TalcuStatusNotify;
    f_OnTaskListChanged: TddTaskListChangedEvent; // событие изменение статуса задания или его добавление
    f_Processing: Boolean; // признак обработки одного задания из очереди заданий
    f_Progressor: TddProgressObject;
    f_IncomingTasks : TddServerTaskList; // список новых заданий которые требуется переместить в f_ActiveTaskList
    f_ChangedTasks : TddServerTaskList;
    f_NeedUpdateAllTask: Boolean;
    f_RequestList: TddServerTaskList;
    f_RootTaskFolder: string; // папка с задачами
    f_StartDate: TDateTime;
    f_Status: TalcuStatus;
    f_TaskList: TalcuNotSortedTaskList; // стисок для отображения всех задач на главной форме
    f_UpdatePeriod: LongInt;
    f_UserQueries: TQueryList;
    f_WorkPool: TalcuSubmitterWorkPool;
    f_WorkPoolManager: IalcuAsyncSubmitterManager;
    f_AddedActiveTaskCount: Integer;
    f_TransporterPool: TncsServerTransporterPool;
    f_DetachedExecutorPool: TalcuDetachedExecutorPool;
    f_LockTaskExecution: Integer;
    f_ServerStarted: Boolean;

    f_SerachActiveTaskCounter: Integer;// Отладочная ловушка - потом можно грохнуть.
    f_SpeedupRequestHandle: Windows.THandle;
    procedure AddDelayedTask(aTask: TddProcessTask);
    procedure ChangeServerStatus(atask: TddProcessTask);
    procedure CheckDeliveringTasks;
    procedure ClearTask(aTask: TddProcessTask);
    procedure DoCommand(aTask: TddProcessTask);
    procedure DoChangeDictItem(aTask: TddProcessTask);
    procedure DoChangeUserItem(aTask: TddProcessTask);
    procedure DoSaveUserDefinedExport(aTask: TddProcessTask);
    procedure DoDeleteDocs(aTask: TddProcessTask);
    procedure DoRunRequest(aTask: TddProcessTask);
    procedure SpeedupRequestWndProc(var Msg: TMessage);
    function pm_GetActiveTaskListCount: Integer; // количества задач ожидающих выполнения
    function pm_GetCurrentUserName: string;
    function pm_GetLineLen: Integer;
    function pm_GetProcessingLocked: Boolean; // TRUE - обработка очереди заданий заблокирована
    procedure pm_SetTaskExecutionEnabled(const Value: Boolean); // установка разрешение выполнять все задания
    procedure pm_SetEnabledTaskTypes(const Value: TcsTaskTypes);
    procedure pm_SetRootTaskFolder(const Value: string); // установка папки с задачами f_RootTaskFolder
    procedure pm_SetStatus(const Value: TalcuStatus);
    procedure RunTask(aTask: TddProcessTask);
    procedure SaveQuery;
    procedure pm_SetProgressor(const Value: TddProgressObject);
    procedure pm_SetMessageManager(const Value: TcsMessageManager);
    function pm_GetWorkThreadCount: Integer;
    procedure pm_SetWorkThreadCount(const Value: Integer);
  protected
    procedure TaskDone(aTask: TddProcessTask); // удаление задачи из списка f_ActiveTaskList
    procedure DoTaskChanged(aTask: TddTaskItem; PrevStatus: TcsTaskStatus); override;
  private
    procedure TaskListUpdated(aTask: TddProcessTask);
    procedure WorkupRequests;
    procedure SubmitAsyncTasks;
    procedure CancelDelivering(aCLientID: TcsClientID);
  {$IFDEF InsiderTest}
    procedure TrySimulateTaskDone(const aTask: TddProcessTask);
  {$ENDIF InsiderTest}
    function AllowTaskExecution: Boolean;
    function NeedProcessTask(const aTask: TddProcessTask): Boolean;
    procedure DoAddRequest(const aRequest: TddProcessTask);
    procedure DoAddActiveTask(const aTask: TddProcessTask);
    procedure evntOnEraseAttrRecords(aAttrType : TCacheType; aDictID : TDictID; aDocID : TDocID; aSubID : TSubID);
 protected
    procedure AbortTask(const aTask: TddProcessTask);
    procedure FreezeTask(const aTask: TddProcessTask);
    procedure CalculatePriority(aTask: TddProcessTask);
    procedure Cleanup; override;
    procedure Exception2Log(E: Exception);
    function AllowAsyncRunTask(const aTask: TddProcessTask): Boolean;
 public
    function WorkupTaskByIDF(const ID: String; anAction: alcuTasksIterator_ForOneF_Action): Boolean;
 protected
    function MakeTaskFileName(aTask: TddProcessTask): string;
 protected
   // IalcuAsyncTaskFinishedNotifier
   procedure TaskFinished(const aTask: TddProcessTask);
   // IcsRunTaskServices
   procedure SendTextMessage(anUserID: TdaUserID;
    const aMessage: AnsiString);
   // IncsMessageExecutorFactory
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
   // Il3ChangeRecipient
   procedure Changing;
     {* началось изменение. }
   procedure Changed;
     {* закончилось изменение. }
     {$If defined(InsiderTest)}
 public
   CanSimulateTaskDone : Boolean;
 protected
   procedure SimulateTaskDone(aTask: TddProcessTask); virtual;
     {* имитирует отправку результата пользователю после выполнения задания }
     {$IfEnd} //InsiderTest
     {$If defined(InsiderTest)}
   procedure BeforeSaveQuery; virtual;
     {* Сигнатура метода BeforeSaveQuery }
     {$IfEnd} //InsiderTest
     {$If defined(InsiderTest)}
   function NeedRaiseInProcessQuery: Boolean; virtual;
     {$IfEnd} //InsiderTest
 public
    constructor Create(const aRootTaskFolder: String; const aBaseEngineHolder: TalcuBaseEngineHolder);
    procedure AddUserInMonitor(Stream: Tl3Stream);
    procedure AddUserInPrivateMonitor(Stream: Tl3Stream);
    procedure DeleteUserOfMonitorS(Stream: Tl3Stream);
    function AddTaskFromStreamToIncoming(Stream: Tl3Stream; const aRootTaskFolder: String; aisPipe: Boolean): integer;
    function AddTaskToIncoming(const aTask: TddProcessTask): integer;
    procedure AddRequest(const aRequest: TddProcessTask);
    procedure AddActiveTask(const aTask: TddProcessTask);
    procedure ForceExecuteTask(const aTask: TddProcessTask);
    procedure FreezeQueryQueue(WaitForFreeze: Boolean);
    procedure FreezeRunningSyncTask;
    procedure cs_ExecuteCommand(aPipe: TCSDataPipe);
    procedure cs_GetActiveUsers(aPipe: TCSDataPipe);
    procedure cs_GetNextVersionDate(aPipe: TCSDataPipe);
    procedure cs_GetCommonData(aPipe: TCSDataPipe);
    procedure cs_GetTime(aPipe: TCSDataPipe);
    procedure cs_LineRequestReply(aPipe: TCSDataPipe);
    procedure cs_ReturnTask(aPipe: TCSDataPipe);
    procedure cs_SendMail(aPipe: TCSDataPipe);
    procedure cs_ServerTaskReply(aPipe: TCSDataPipe);
    procedure cs_StartMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_StartMyMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_StopMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_AsyncProgress(aPipe: TCSDataPipe);
    procedure cs_ReceiveTaskResult(aPipe: TCSDataPipe);
    procedure cs_RequestDeliveryTaskList(aPipe: TCSDataPipe);
    procedure cs_ExportResultProcessing(aPipe: TCSDataPipe);
    procedure cs_TransporterHandshake(aPipe: TCSDataPipe);
    procedure cs_TaskSend(aPipe: TCSDataPipe);
    procedure cs_TerminateTask(aPipe: TCSDataPipe);
    procedure cs_CustomMessageProcessing(aPipe: TCSDataPipe);
    procedure DeleteTask(aTask: TddProcessTask; aSendMessage: Boolean);
    procedure LoadQuery; // загрузить заданий из файла
    procedure LockProcessing; // inc(f_LockProcessingCounter) - блокировка разбора очереди заданий
    procedure ProcessQuery; // запускает механизм обработки заданий
    procedure ProcessIncomingTasks;
    procedure WaitForAsyncRunningTasks;
    procedure cs_GetExecuteStatus(aPipe: TcsDataPipe);
    procedure cs_GetDictChangeFileName(aPipe: TCSDataPipe);
    procedure cs_GetCompileDate(aPipe: TCSDataPipe);
    procedure cs_GetToRegionList(aPipe: TcsDataPipe);
    procedure ExcludeTaskType(aTaskType: TcsTaskType);
    procedure IncludeTaskType(aTaskType: TcsTaskType);
    procedure MakeCaseCodeGenerateTask;
    procedure StopProcessQuery(aTask: TddProcessTask);
    procedure UnLockProcessing; // dec(f_LockProcessingCounter). При f_LockProcessingCounter = 0 разбор очереди заданий РАЗБЛОКИРОВАН
    procedure WorkupDelayed(ForceRun: Boolean);
    procedure NotifyProgress(TotalPercent: Long; const TotalCaption: AnsiString);
    procedure LockAsyncRun;
    procedure UnLockAsyncRun;
    procedure LockTaskExecution;
    procedure UnlockTaskExecution;
    function TaskExecutionLocked: Boolean;
    function ExecutingTask(CountAbortingTask: Boolean): Boolean;
    procedure SignalServerStarted;
    procedure SignalServerStopping;
    procedure RequestExecuteCommand(aUser: TdaUserID; aCommandID: Integer);
    function HasActiveTask(aTaskType: TcsTaskType): Boolean;
    procedure SpeedupRequest;
    property Actions: TcsServerCommandsManager read f_Actions write f_Actions;
    property ActiveTaskList: TalcuTaskList read f_ActiveTaskList;
    property ActiveTaskListCount: Integer read pm_GetActiveTaskListCount; // количества задач ожидающих выполнения
    property CurrentUserName: string read pm_GetCurrentUserName;
    property TaskExecutionEnabled: Boolean read f_TaskExecutionEnabled write pm_SetTaskExecutionEnabled; // разрешение "из вне" выполнять все задания
    property EnabledTaskTypes: TcsTaskTypes read f_EnabledTaskTypes write pm_SetEnabledTaskTypes;
    property LineLen: Integer read pm_GetLineLen;
    property MessageManager: TcsMessageManager read f_MessageManager write pm_SetMessageManager;
    property Processing: Boolean read f_Processing;
    property Progressor: TddProgressObject read f_Progressor write pm_SetProgressor;
    property ProcessingLocked: Boolean read pm_GetProcessingLocked;  // TRUE - обработка очереди заданий заблокирована
    property RootTaskFolder: string read f_RootTaskFolder write pm_SetRootTaskFolder;
    property Status: TalcuStatus read f_Status write pm_SetStatus;
    property TaskList: TalcuNotSortedTaskList read f_TaskList;
    property UpdatePeriod: LongInt read f_UpdatePeriod write f_UpdatePeriod;
    property UserQueries: TQueryList read f_UserQueries;
    property AddedActiveTaskCount: Integer read f_AddedActiveTaskCount;
    property WorkThreadCount: Integer read pm_GetWorkThreadCount write pm_SetWorkThreadCount;
    {$IFNDEF Service}
    property OnException: TExceptionEvent read f_OnException write f_OnException;
    {$ENDIF}
    property OnSendEmail: TSendEmailNotify read f_OnSendEmail write f_OnSendEmail;
    property OnStatusChanged: TalcuStatusNotify read f_OnStatusChanged write
        f_OnStatusChanged;
    property OnTaskListChanged: TddTaskListChangedEvent read
            f_OnTaskListChanged write f_OnTaskListChanged;
  end;//TddServerTaskManager

(*var
 ddEnableMonitoring: Boolean = False;*)

const
 alcuAllTaskTypes = [cs_ttImport, cs_ttExport, {$IFDEF AutoClass}cs_ttAutoClass,{$ENDIF AutoClass}
   cs_ttAnnoExport, cs_ttAExportAnno, cs_ttAExportDoc, cs_ttRegionAutoExport, cs_ttRegionImport,
   cs_ttDossierMake, cs_ttCaseCode, cs_ttSpellCheck, cs_ttAutoSpellCheck,
   cs_ttAACImport, cs_ttUnregistered, cs_ttRelPublish, cs_ttAnoncedExport,
   cs_ttHavanskyExport, cs_ttMdpSyncDicts, cs_ttMdpImportDocs, cs_ttContainer,
   cs_ttSchedulerProxy, cs_ttMdpSyncStages, cs_ttMdpSyncImport];
 alcuRequests = [cs_ttUserEdit, cs_ttDictEdit, cs_ttDeleteDocs, cs_ttRunCommand,
   cs_ttUserDefinedExport, cs_ttDownloadDoc, cs_ttUploadDoc];

implementation
Uses
 ht_Dll, l3StopWatch, ncsProfile,
 DateUtils, Math, {$IFNDEF Service}Dialogs,{$ENDIF} Controls, Types,
 ddAppConfig, ddKW_r, ddUtils, ddProgressTypes, ddCalendarEvents,
 Base_CFG,
 daInterfaces,
 daSchemeConsts,
 daDataProvider,
 dt_Const, dt_AttrSchema, dt_IFltr, dt_Serv,  dt_Stage,
 dt_Dict, dt_Table, dt_Link, dt_Lock, dt_Query, DT_SrchQueries,
 l3Filer, l3FileUtils, l3Stream, l3String, l3TempMemoryStream,
 l3ProcessingEnabledService, l3Utils,
 CSNotification, csActiveClients, CsNotifier,
 alcuMailServer, alcuUtils, alcuAutoClassifier, rxStrUtils, l3ShellUtils, vtLogFile, alcuPrime,
 alcuStrings, StrUtils, alcuAutoExport, ddAppConfigDataAdapters,
 ddAppConfigTypes, l3LongintListPrim, dt_DictTypes,
 dt_LinkServ, DT_DictConst, ddCaseCodeMaker, csImport, csServerTaskTypes, DT_Utils,
 dt_DictSup,
 csUserDefinedExport,
 alcuSpellCorrectTask,
 alcuExport,
 csCommandsTypes, m3StorageElementIDList, alcuSpellChecker,
 ncsServerTransporter,
 TypInfo,
 alcuRelCorrector,
 l3MultiThreadIntegerList,
 l3CardinalList,

 ddProcessTaskPrim,
 alcuAsyncSubmitterManager,
 l3Variant,
 TaskResult_Const,
 csTasksHelpers,
 evdTaskTypes,
 csTaskResult,
 csContainerTask,
 ncsFileTransferReg,
 ncsMessageExecutorFactory,
 ncsGetReadyToDeliveryTasks,
 alcuGetReadyToDeliveryTasksExecutor,
 ncsGetTaskDescription,
 alcuGetTaskDescriptionExecutor,
 ncsTaskProgress,
 alcuTaskProgressExecutor,
 ncsGetFilePart,
 alcuGetFilePartExecutor,
 ncsDeliveryResult,
 alcuDeliveryResultExecutor,
 csDownloadDocStream,
 alcuDownloadDocStreamExecutor,
 csUploadDocStream,
 alcuUploadDocStreamExecutor,
 ncsDocStorageTransferReg,
 ncsTaskSendReg,
 ncsSendTask,
 alcuSendTaskExecutor,
 ncsCorrectFolder,
 alcuCorrectFolderExecutor,
 alcuDetachedExecutor,
 ncsSynchroServerTransporter
 ;             //

const
 cNoActiveTask = 'Нет активной задачи';
var
 msg_SpeedupRequest: Windows.THandle = 0;

{
***************************** TddServerTaskManager *****************************
}
constructor TddServerTaskManager.Create(const aRootTaskFolder: String; const aBaseEngineHolder: TalcuBaseEngineHolder);
begin
  inherited Create;
  f_AddedActiveTaskCount := 0;
  Assert(Assigned(aBaseEngineHolder));
  aBaseEngineHolder.SetRefTo(f_BaseEngineHolder);
  RootTaskFolder := aRootTaskFolder;
  f_IncomingTasks := TddServerTaskList.Create;
  f_ChangedTasks := TddServerTaskList.Create;
  f_TaskList := TalcuNotSortedTaskList.Create;
  (f_TaskList as Il3ChangeNotifier).Subscribe(Self as Il3ChangeRecipient);
  f_ActiveTaskList := TalcuTaskList.Create{MakeSorted(l3_dupIgnore)};
  f_ActiveTaskList.FileName:= ConcatDirName(RootTaskFolder, 'UserTasks.dat');
  f_MonitorUsers := Tl3MultiThreadSortedIntegerList.Create;
  f_PrivateMonitorUsers := Tl3MultiThreadSortedIntegerList.Create;
  f_CommonDataList:= TalcuNotSortedTaskList.Create;
  f_TasksToPurgeList := TalcuNotSortedTaskList.Create;
  f_RequestList:= TddServerTaskList.Create;
  f_DelayedList:= TalcuTaskList.Create;
  f_DelayedList.Filename:= ConcatDirName(RootTaskFolder, 'DelayedTasks.dat');
  {$IFDEF UserQuery}
  f_UserQueries := TQueryList.Create();
  f_UserQueries.QueriesPath:= ddAppConfiguration.AsString['sqFolder'];
  f_UserQueries.LoadAsksList;
  {$ENDIF}
  f_Busy := False;
  f_LockProcessingCounter:= 0;
  f_WorkPoolManager := TalcuAsyncSubmitterManager.Make(f_BaseEngineHolder);
  f_WorkPool := TalcuSubmitterWorkPool.Create(f_WorkPoolManager);
  f_WorkPool.RegisterNotifier(Self);
  f_TransporterPool := TncsServerTransporterPool.Create;
  f_DetachedExecutorPool := TalcuDetachedExecutorPool.Create;

  f_SpeedupRequestHandle := Classes.AllocateHWnd(SpeedupRequestWndProc);

  ncsFileTransferReg.ncsServerRegister;
  ncsTaskSendReg.ncsServerRegister;
  ncsDocStorageTransferReg.ncsServerRegister;
  TncsMessageExecutorFactory.Instance.Register(Self);
end;

procedure TddServerTaskManager.AbortTask(const aTask: TddProcessTask);
begin
 if (f_ActiveTask = aTask) and (aTask.Status <> cs_tsAsyncRun) then
  f_ActiveTask.Abort
 else
  if aTask.CanAsyncRun and (aTask.Status = cs_tsAsyncRun) then
   aTask.Abort;
end;

procedure TddServerTaskManager.AddDelayedTask(aTask: TddProcessTask);
begin
 f_DelayedList.AddTask(aTask);
end;

procedure TddServerTaskManager.AddRequest(const aRequest: TddProcessTask);
begin
 DoAddRequest(aRequest);
 SpeedupRequest;
end;

procedure TddServerTaskManager.AddActiveTask(const aTask: TddProcessTask);
begin
 DoAddActiveTask(aTask);
 SpeedupRequest;
end;

procedure TddServerTaskManager.CalculatePriority(aTask: TddProcessTask);
var
 l_AU: IdaArchiUser;
begin
 l_AU := GlobalDataProvider.UserManager.UserByID(aTask.UserID);
 if l_AU <> nil then
 begin
  case aTask.TaskType of
   cs_ttImport : aTask.Priority := CorrectPriorities[l_AU.ImportPriority];
   cs_ttExport : aTask.Priority := CorrectPriorities[l_AU.ExportPriority];
   cs_ttAnnoExport: aTask.Priority := dd_tpHighest;
   cs_ttRelPublish: aTask.Priority := dd_tpHigh;
  end; // case
 end; // l_AU <> nil
end;

procedure TddServerTaskManager.ChangeServerStatus(atask: TddProcessTask);
begin
 case aTask.Status of
  cs_tsRun,
  cs_tsAsyncRun:
   Status := dd_apsProcessQuery;         { выполняется }
  cs_tsDelivering:
   Status:= dd_apsDelivering;
  cs_tsDone:
   Status:= dd_apsRevert;       { обработано }
  else
   Status:= dd_apsIdle
 end;//case aTask.Status
end;

procedure TddServerTaskManager.CheckDeliveringTasks;
var
 l_List: TdtUserIDList;


 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) then
   if l_List.IndexOf(anItem.UserID) = -1 then
    l_List.Add(anItem.UserID);
 end;

 function DoSend(anUserID: PdaUserID; Index: Integer): Boolean;
 begin//AddLineDelta
  MessageManager.SendNotify(anUserID^, ntResultsReadyForDelivery, 0, '', usServerService);
  Result := True;
 end;//AddLineDelta

begin
 // Проверяем очередь на предмет недоставленных заданий и перепосылаем уведомление
 if (SecondsBetween(f_LastDelivering, Now) > UpdatePeriod * 3) then
 begin
  f_LastDelivering := Now;
  l_List := TdtUserIDList.Make;
  try
   f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   l_List.IterateAllF(l3L2IA(@DoSend));
  finally
   FreeAndNil(l_List);
  end;
 end;//SecondsBetween(f_LastDelivering, Now) > UpdatePeriod
end;

procedure TddServerTaskManager.Cleanup;
begin
 TncsMessageExecutorFactory.Instance.UnRegister(Self);
 SaveQuery;
 FreeAndNil(f_DelayedList);
 {$IFDEF UserQuery}
 FreeAndNil(f_UserQueries);
 {$ENDIF}
 l3Free(f_RequestList);
 l3Free(f_CommonDataList);
 l3Free(f_TasksToPurgeList);
 l3Free(f_MonitorUsers);
 l3Free(f_PrivateMonitorUsers);
 l3Free(f_ActiveTaskList);
 l3Free(f_IncomingTasks);
 FreeAndNil(f_ChangedTasks);
 (f_TaskList as Il3ChangeNotifier).UnSubscribe(Self as Il3ChangeRecipient);
 l3Free(f_TaskList);
 f_WorkPoolManager := nil;
 f_WorkPool.UnRegisterNotifier(Self);
 l3Free(f_WorkPool);
 l3Free(f_BaseEngineHolder);
 l3Free(f_TransporterPool);
 l3Free(f_DetachedExecutorPool);
 Classes.DeallocateHWnd(f_SpeedUpRequestHandle);
 inherited;
end;

procedure TddServerTaskManager.ClearTask(aTask: TddProcessTask);
begin
 DeleteFile(MakeTaskFileName(aTask));
// f_QueryFile.Section := rsSavedTaskList;
// f_QueryFile.WriteParamStr(aTask.TaskID, '');
// aTask.Clear;
end;

procedure TddServerTaskManager.cs_ExecuteCommand(aPipe: TCSDataPipe);
var
 l_CommandID: Integer;
 l_User: TdaUserID;
begin
 try
  l_User:= aPipe.ReadCardinal;
  { Прочитать ID и создать запрос для выполнения в основной нити }
  l_CommandID:= aPipe.ReadInteger;
 except
  l_CommandID:= 0;
 end;
 RequestExecuteCommand(l_User, l_CommandID);
end;

procedure TddServerTaskManager.cs_GetActiveUsers(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_List: TdtUserIDList;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  l_List:= TdtUserIDList.Make;
  try
   f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.AllClientIds(l_List);
   l_List.Save(l_Stream);
   l_Stream.Seek(0, 0);
   aPipe.WriteStream(l_Stream);
  finally
   l3Free(l_List);
  end;
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.cs_GetNextVersionDate(aPipe: TCSDataPipe);
var
 l_Date, l_NextDate: TDateTime;
 l_CompileDate: TDateTime;

(*
 l_Date2, l_NextDate2: TDateTime;
 l_TaskC, l_TaskV: TddSchedulerTask;
*)
begin
 if (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetFullDateTime(ctCompilation, Now, l_CompileDate) then
 begin
  if not (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetFullDateTime(ctVersion, l_CompileDate, l_Date) then
   Assert(False, 'SCHEDUL DATES - Не нашли дату следующей версии');
  if not (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetFullDateTime(ctVersion, IncDay(l_Date), l_NextDate) then
   Assert(False, 'SCHEDUL DATES - Не нашли дату после следующей версии');
 end
 else
  Assert(False, 'SCHEDUL DATES - Не нашли дату следующей компиляции');

(*
 l3System.Msg2Log('COMPILE %s', [FormatDateTime('dd.mm.yyyy hh:nn:ss', l_CompileDate)]);
 l3System.Msg2Log('DATE %s', [FormatDateTime('dd.mm.yyyy hh:nn:ss', l_Date)]);
 l3System.Msg2Log('NEXTDATE %s', [FormatDateTime('dd.mm.yyyy hh:nn:ss', l_NextDate)]);

 l_TaskC := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctCompilation);
 Assert(l_TaskC <> nil);
 l_TaskV := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctVersion);
 Assert(l_TaskV <> nil);
 l_Date2 := l_TaskV.FullDateTime[l_TaskC.FullDateTime[Now]];
 l_NextDate2:= l_TaskV.FullDateTime[IncDay(l_Date)];

 If (l_Date2 <> l_Date) or (l_NextDate2 <> l_NextDate) then
  Assert(False);
*)
 aPipe.WriteDateTime(l_Date);
 aPipe.WriteDateTime(l_NextDate);
end;

procedure TddServerTaskManager.cs_GetCommonData(aPipe: TCSDataPipe);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  anItem.SaveTaskToPipe(aPipe);
 end;

var
 l_Index: Integer;
begin
  l_Index:= aPipe.ReadInteger;
  f_CommonDataList.ForOneF(L2AlcuTasksIteratorForOneFAction(@DoIt), l_Index);
end;

procedure TddServerTaskManager.cs_GetTime(aPipe: TCSDataPipe);
begin
 aPipe.WriteDateTime(Now);
end;

procedure TddServerTaskManager.cs_LineRequestReply(aPipe: TCSDataPipe);

var
 l_Stream: Tl3MemoryStream;
 l_Count: Integer;

 function CalcCount(anItem: TddProcessTask): Boolean;
 var
  l_TaskSize: Integer;
  l_Pos: Integer;
 begin
  Result := true;
  if not anItem.IsHiddenFromUser then
   inc(l_Count);
 end;

 function WriteTask(anItem: TddProcessTask): Boolean;
 var
  l_TaskSize: Integer;
  l_Pos: Integer;
 begin
  Result := true;
  if anItem.IsHiddenFromUser then
   Exit;
  l_Pos := l_Stream.Position;
  anItem.SaveTo(l_Stream, False);
  l_TaskSize := l_Stream.Size - l_Pos;
  aPipe.WriteInteger(l_TaskSize);
 end;

begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  f_TaskList.Lock;
  try
   l_Count := 0;
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@CalcCount));

   aPipe.WriteInteger(l_Count); // Количество задач
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@WriteTask));
   aPipe.WriteStream(l_Stream);
  finally
   f_TaskList.Unlock;
  end;//try..finally
 finally
  l3Free(l_Stream);
 end;//try..finally
end;

procedure TddServerTaskManager.cs_ReturnTask(aPipe: TCSDataPipe);

  function DoIt(anItem: TddProcessTask): Boolean;
  var
   l_Stream: Tl3MemoryStream;
  begin
   Result := true;
   l3System.Msg2Log('Задача от пользователя: ' + UserNameByID(anItem.UserID));
   l_Stream := Tl3MemoryStream.Create;
   try
    anItem.SaveTo(l_Stream, False);
    l_Stream.Seek(0, 0);
    aPipe.WriteStream(l_Stream);
   finally
    l3Free(l_Stream);
   end;//try..finally
  end;

var
 l_TaskID : String;
begin
 l3System.Msg2Log('Передача пользователю информации о задаче');
 // Читаем идентификатор задачи, находим задачу и записываем ее в трубу
 l_TaskID := aPipe.ReadLn;
 if not WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt)) then
  l3System.Msg2Log('Задача с идентификатором ' + l_TaskID + ' не найдена (передача результатов)');
 l3System.Msg2Log('Передача информации завершена');
end;

procedure TddServerTaskManager.cs_SendMail(aPipe: TCSDataPipe);
var
 l_Recepient: Integer;
 l_MailNumber: Integer;
begin
 l_Recepient := aPipe.ReadInteger;
 l_MailNumber := aPipe.ReadInteger;
 MessageManager.SendNotify(l_Recepient, ntMailArrived, l_MailNumber, '', usServerService);
end;

procedure TddServerTaskManager.cs_ServerTaskReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_Index : Integer;
begin
 Assert(aPipe <> nil, 'Отсутствуют данные для обработки');
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Index := AddTaskFromStreamToIncoming(l_Stream, RootTaskFolder{GetUniqFileName(RootTaskFolder, 'Task', '')}, True);
 finally
  l3Free(l_Stream);
 end;//try..finally
 aPipe.WriteInteger(l_Index);
end;

procedure TddServerTaskManager.cs_StartMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  AddUserInMonitor(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.cs_StartMyMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  AddUserInPrivateMonitor(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.cs_StopMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  DeleteUserOfMonitorS(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.DeleteTask(aTask: TddProcessTask; aSendMessage: Boolean);
begin
 aTask.Use;
 try
  l3System.Msg2Log('Задача с идентификатором %s удаляется из активных - удаление', [aTask.TaskID]);
  AbortTask(aTask);
 (* if not aSendMessage then
   aTask.OnChange:= nil;*)
  if not aSendMessage then
   aTask.CanNotifyChange := false;
  aTask.RequestDelete;
  ClearTask(aTask);
//  f_TasksToPurgeList.Add(aTask);
  TaskListUpdated(aTask);
 finally
  aTask.Free;
 end;//try..finally
end;

procedure TddServerTaskManager.DoChangeDictItem(aTask: TddProcessTask);
var
 l_Rec: TDictMessageRec;
begin
 aTask.RequestRun;
 with (aTask as TDictEditQuery){.DictInfo} do
 begin
  l_Rec.Family := Word(Family);
  l_rec.DictType := TdaDictionaryType(DictType);
  l_Rec.Operation:= TOperActionType(Operation);
  l_Rec.ID := ID;
  l_Rec.NextID := NextID;
  l_Rec.ParentID := ParentID;
 end;
 DictServer(CurrentFamily).ProcessDictEdit(l_Rec, aTask.UserID);
end;

procedure TddServerTaskManager.DoChangeUserItem(aTask: TddProcessTask);
begin
 with (aTask as TUserEditQuery) do
  GlobalDataProvider.UserManager.UpdateUserInfo(ID, IsGroup);
 aTask.Done;
end;

procedure TddServerTaskManager.DoDeleteDocs(aTask: TddProcessTask);
var
 l_Index: Integer;
 l_Sab: ISab;
begin
 // Удалить у себя
 DocumentServer.Family:= CurrentFamily;
 l_Sab:= MakeValueSet(DocumentServer.FileTbl, fId_fld, aTask.DocumentIDList);
 try
  DocumentServer.DelDocs(l_Sab);
  l3System.Msg2Log('Пользователь %s удалил документы (внешние (#внутренние) номера):', [GlobalDataProvider.UserManager.GetUserName(aTask.UserID)]);
  for l_Index:= 0 to Pred(aTask.DocumentIDList.Count) do
   l3System.Msg2Log('%d (#%d)', [LinkServer(CurrentFamily).ReNum.GetExtDocID(aTask.DocumentIDList.Items[l_Index]), aTask.DocumentIDList.Items[l_Index]]); 
  // Разослать всем пользователям информацию об удаленных документах
  l_Index:= f_CommonDataList.Add(aTask);
  MessageManager.SendNotify(c_AllClients, ntDelDoc, l_Index, '', aTask.UserID);
 except
  on E: Exception do
  begin
   Exception2Log(E);
   alcuMail.SendEmailNotify(eventDeleteDocuments, True, E.Message, dd_apsDeleteDocs);
  end;
 end;
end;

procedure TddServerTaskManager.Exception2Log(E: Exception);
begin
 {$IFNDEF Service}
 if Assigned(f_OnException) then
  f_OnException(Self, E)
 else
 {$ENDIF}
  l3System.Exception2Log(E);
end;

function TddServerTaskManager.WorkupTaskByIDF(const ID: String; anAction: alcuTasksIterator_ForOneF_Action): Boolean{: TddProcessTask};

var
 l_Found : TddProcessTask;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  if anItem.TaskID = ID then
  begin
   anItem.SetRefTo(l_Found);
   //anAction(anItem);
   WorkupTaskByIDF := true;
   Result := false;
  end//anItem.TaskID = aTaskID
  else
   Result := true;
 end;

var
 Hack : Pointer absolute anAction;
begin
 Result := false;
 l_Found := nil;
 try
 // Result := nil;
  try
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   if (l_Found <> nil) then
    anAction(l_Found);
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 finally
  FreeAndNil(l_Found);
 end;//try..finally
end;

procedure TddServerTaskManager.LoadQuery;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  anItem.CanNotifyChange := true;
  if not f_TaskList.Has(anItem) then
    f_TaskList.Add(anItem);
 end;//DoIt

begin
 f_ActiveTaskList.Lock;
 try
  f_ActiveTaskList.Load;
  f_TaskList.LockNotification;
  try
   f_TaskList.Lock;
   try
    f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   finally
    f_TaskList.Unlock;
   end;//try..finally
  finally
   f_TaskList.UnlockNotification;
  end;

  if not f_ServerStarted then
    TaskExecutionEnabled := (ActiveTaskListCount = 0);
  f_DelayedList.Load;
 finally
  f_ActiveTaskList.Unlock;
 end;//try..finally
end;

procedure TddServerTaskManager.LockProcessing;
begin
 inc(f_LockProcessingCounter);
 if f_LockProcessingCounter = 1 then
  WaitForAsyncRunningTasks;
end;

function TddServerTaskManager.MakeTaskFileName(aTask: TddProcessTask): string;
begin
 if not DirExists(RootTaskFolder) then
 begin
  l3System.Msg2Log('Куда-то пропала папка для сохранения заданий', l3_msgLevel1);
  ForceDirectories(RootTaskFolder);
 end; // not DirExists(RootTaskFolder)
 Result := ConcatDirName(RootTaskFolder, aTask.TaskID + '.query');
end;

function TddServerTaskManager.pm_GetActiveTaskListCount: Integer;
begin
 Result:= ActiveTaskList.ActiveTaskCount(EnabledTaskTypes);
end;

function TddServerTaskManager.pm_GetCurrentUserName: string;
begin
 if (f_ActiveTask = nil) or AllowAsyncRunTask(f_ActiveTask) then
  Result := cNoActiveTask
 else
  Result := UserNameByID(f_ActiveTask.UserID);
end;

function TddServerTaskManager.pm_GetLineLen: Integer;
begin
  Result := f_ActiveTaskList.Count;
end;

function TddServerTaskManager.pm_GetProcessingLocked: Boolean;
begin
 Result := (f_LockProcessingCounter > 0) and Tl3ProcessingEnabledService.Instance.Enabled;
end;

procedure TddServerTaskManager.pm_SetTaskExecutionEnabled(const Value: Boolean);
begin
 if f_TaskExecutionEnabled <> Value then
 begin
  f_TaskExecutionEnabled := Value;
  if f_TaskExecutionEnabled and not Processing then
   ProcessQuery;
 end;
end;

procedure TddServerTaskManager.pm_SetEnabledTaskTypes(const Value: TcsTaskTypes);
begin
  if f_EnabledTaskTypes <> Value then
  begin
   f_EnabledTaskTypes := Value;
  end;
end;

procedure TddServerTaskManager.pm_SetRootTaskFolder(const Value: string);
begin
 if f_RootTaskFolder <> Value then
 begin
  f_RootTaskFolder := ExpandFileName(Value);
  if f_RootTaskFolder <> '' then
   ForceDirectories(f_RootTaskFolder);
 end;
end;

procedure TddServerTaskManager.pm_SetStatus(const Value: TalcuStatus);
begin
 f_Status:= Value;
 if Assigned(f_OnStatusChanged) then
  f_OnStatusChanged(Value{, LineLen});
end;

{$If defined(InsiderTest)}
procedure TddServerTaskManager.SimulateTaskDone(aTask: TddProcessTask);
 {* имитирует отправку результата пользователю после выполнения задания }
begin
end;
{$IfEnd} //InsiderTest

{$If defined(InsiderTest)}
procedure TddServerTaskManager.BeforeSaveQuery;
 {* Сигнатура метода BeforeSaveQuery }
begin
end;
{$IfEnd} //InsiderTest

{$If defined(InsiderTest)}
function TddServerTaskManager.NeedRaiseInProcessQuery: Boolean;
begin
 Result := false;
end;
{$IfEnd} //InsiderTest

procedure TddServerTaskManager.ProcessQuery;

var
 l_NeedRepeat : Boolean;
 l_DoneCount  : Integer;
 l_TaskToRun: TddProcessTask;

 procedure lp_DoSyncRun(const anItem: TddProcessTask);
 begin//DoIt
  {$IFNDEF Service}
  Application.ProcessMessages;
  {$ENDIF}
  if AllowTaskExecution then // Обработку могут выключить извне
   try
    if NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes) and not (f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem)) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then
      try
        l3System.Msg2Log('Выполняю синхронную задачу %s (%s)', [anItem.Description, anItem.TaskID], l3_msgLevel10);
        try
         RunTask(anItem);
         TaskFinished(anItem);
        finally
         l3System.Msg2Log('Закончил синхронную задачу %s (%s)', [anItem.Description, anItem.TaskID], l3_msgLevel10);
        end;
        if not (anItem.Status in [cs_tsQuery, cs_tsAsyncRun]) then
        begin
          l_NeedRepeat := true;
          Inc(l_DoneCount);
        end;
      finally
        f_WorkPoolManager.LeaveTaskExecution(anItem);
      end;// try
    end; // NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end;
  WorkupRequests;
 end;//DoSyncRun

 function DoSearch(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  if (l3System.MessageLevel >= 10) and (anItem = nil) or (anItem.TaggedData = nil) then
  begin
   l3System.Msg2Log(Format('AF TRAP - found empty TaggedData task %p. See K-617777268', [Pointer(anItem)]), l3_msgLevel3);
   Exit;
  end;
  if AllowTaskExecution then // Обработку могут выключить извне
   try
    if NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes) and not (f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem)) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then  // Leave будет снаружи
     begin
      anItem.SetRefTo(l_TaskToRun);
      Result := False;
      Exit;
     end;
    end; // NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end;
  WorkupRequests;
 end;//DoSyncRun

 function DoPurgeTask(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  f_ActiveTaskList.RemoveTask(anItem);
  TaskListUpdated(anItem);
 end; // DoPurgeTask

begin
 f_DetachedExecutorPool.Pack;
 f_TaskList.PackUnimportant;
 f_WorkPool.CheckExecution(Self);
 f_TasksToPurgeList.Lock;
 try
  f_TasksToPurgeList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoPurgeTask));
  f_TasksToPurgeList.Clear;
 finally
  f_TasksToPurgeList.Unlock;
 end;
 if not ProcessingLocked then
 begin
  if AllowTaskExecution then
  begin
   WorkupRequests;
   CheckDeliveringTasks;
   SubmitAsyncTasks;
   if not f_Processing then
   begin
    f_Processing := True;
    try
     WorkupRequests;
     l_DoneCount := 0;
     l_TaskToRun := nil;
     while true do
     begin
      {$IFNDEF Service}
      Application.ProcessMessages;
      {$ENDIF}
      f_ActiveTaskList.Sort;
      l_NeedRepeat := false;
      try
       Inc(f_SerachActiveTaskCounter);
       try
        f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoSearch));
       finally
        Dec(f_SerachActiveTaskCounter);
       end;
       if Assigned(l_TaskToRun) then
        lp_DoSyncRun(l_TaskToRun);
      finally
       if Assigned(l_TaskToRun) then
        f_WorkPoolManager.LeaveTaskExecution(l_TaskToRun);
       FreeAndNil(l_TaskToRun);
      end;
      if not l_NeedRepeat then
       break;
      if (l_DoneCount > 5) then
      // - время от времени надо бы прерывать обработку
       break;
     end;//while true
    finally
     f_Processing := False;
    end; // try..finally
   end;
  end;
 end; // not ProcessingLocked
end;

procedure TddServerTaskManager.ProcessIncomingTasks;
var
 l_HasRequest: Boolean;
 l_HasTask: Boolean;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  l3System.Msg2Log('Получен запрос %s', [anItem.Description], alcuMessageLevel);
  if (anItem.TaskType in alcuRequests) then
  begin
   DoAddRequest(anItem);
   l_HasRequest := True;
  end
  else
  begin
   if anItem.Delayed then
    AddDelayedTask(anItem)
   else
   begin
    DoAddActiveTask(anItem);
    l_HasTask := True;
   end;
  end;//anItem.TaskType in alcuRequests
 end;//DoIt

 function DoChanged(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  TaskListUpdated(anItem);
 end;

begin
 if (GetCurrentThreadID = MainThreadID) then
 begin
  f_ChangedTasks.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoChanged));
  if f_NeedUpdateAllTask then
   TaskListUpdated(nil);
  f_NeedUpdateAllTask := False;
 end;
 // Разобрать весь список черновых заданий
 l_HasRequest := False;
 l_HasTask := False;

 f_IncomingTasks.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoIt));

 if (GetCurrentThreadID = MainThreadID) then
 begin
  if l_HasRequest and not l_HasTask then
   WorkupRequests
  else
   ProcessQuery;
 end;
end;

procedure TddServerTaskManager.RunTask(aTask: TddProcessTask);
begin
 aTask.SetRefTo(f_ActiveTask);
 //f_UserID := aTask.UserID;
 try
  aTask.Run(TddRunContext_C(Progressor));
  aTask.RunSuccessfullyFinished(Self);
  {$IFDEF InsiderTest}
  TrySimulateTaskDone(aTask);
  {$ENDIF InsiderTest}
 finally
  aTask.RunEnded(Self);
  FreeAndNil(f_ActiveTask);
  //f_UserID := 0;
 end;//try..finally
 if not (aTask.Status in cs_tsErrorStatuses) then
 begin
  {$IFDEF InsiderTest}
  BeforeSaveQuery;
  {$ENDIF}
  SaveQuery;
 end//not (aTask.Status in cs_tsErrorStatuses)
 else
  if aTask.Status = cs_tsError then
    ExcludeTaskType(aTask.TaskType);
end;

procedure TddServerTaskManager.cs_GetExecuteStatus(aPipe: TcsDataPipe);
var
 i: TcsTaskType;
begin
 with aPipe do
 begin
  WriteSmallInt(SmallInt(Ord(TaskExecutionEnabled)));
  for i:= Low(TcsTaskType) to High(TcsTaskType) do
   WriteSmallInt(SmallInt(Ord(i in EnabledTaskTypes)));
 end;
end;

procedure TddServerTaskManager.cs_GetDictChangeFileName(aPipe: TCSDataPipe);
begin
 aPipe.WriteLn(ddAppConfiguration.AsString['DictUpdateFileName']);
end;

procedure TddServerTaskManager.cs_GetCompileDate(aPipe: TCSDataPipe);
var
 l_Date: TDateTime;
begin
 if not (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetFullDateTime(ctCompilation, Now, l_Date) then
  Assert(False);
(*
 l_TaskC := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctCompilation);
 Assert(Assigned(l_TaskC));
 l_Date := l_TaskC.FullDateTime[Now];
*)
 aPipe.WriteDateTime(l_Date);
end;

procedure TddServerTaskManager.cs_GetToRegionList(aPipe: TcsDataPipe);
var
 i: Integer;
begin
 with Tl3LongintList(ddAppConfiguration.AsObject['utRegionID']) do
 begin
  aPipe.WriteInteger(Count);
  for i:= 0 to Hi do
   aPipe.WriteInteger(Items[i]);
 end;
end;

procedure TddServerTaskManager.DoCommand(aTask: TddProcessTask);
begin
 l3System.Msg2Log('Выполнение команды (%d)', [GetCurrentThreadId]);
 aTask.Run(TddRunContext_C(f_Progressor));
end;

procedure TddServerTaskManager.ExcludeTaskType(aTaskType: TcsTaskType);
begin
 Exclude(f_EnabledTaskTypes, aTaskType);
end;

procedure TddServerTaskManager.IncludeTaskType(aTaskType: TcsTaskType);
begin
 Include(f_EnabledTaskTypes, aTaskType);
end;

procedure TddServerTaskManager.MakeCaseCodeGenerateTask;
var
 l_Task: TddCaseCodeTask;
 lDocSab : ISab;
 lDossSab : ISab;
 lSab    : ISab;
 lSabWOSpr    : ISab;
 l_ResQuery: TdtAndQuery;
 l_Q       : TdtQuery;
 l_StartDate, l_EndDate: TDateTime;
 l_List: Tl3LongintList;
 lValue : Integer;
 lCCSab : ISab;

const
 cCaseCodeType : TDNType = dnLawCaseNum;
begin

 l3System.Msg2Log('Формирование задания на создание номеров дел для постановлений ФАС');
 l_StartDate:= ddAppConfiguration.AsDateTime['ccDate'];
 l_EndDate:= Now;

 l_ResQuery := TdtAndQuery.Create;
 try
  (*
  l_Q := SQChangedDocsFromLog(StDateToDemon(DateTimeToStDate(l_StartDate)),
                              StDateToDemon(DateTimeToStDate(l_EndDate)),
                              0
                             );

  l_ResQuery.AddQueryF(l_Q);
    *)
  l_List := Tl3LongintList(ddAppConfiguration.AsObject['ccSource']); // Выбранные группы документов
  l_Q := TdtDictQuery.Create(da_dlSources, l_List, False, True {WithSubTree});
  l_ResQuery.AddQueryF(l_Q);

   l_List := Tl3LongintList(ddAppConfiguration.AsObject['ccType']);
   l_Q := TdtDictQuery.Create(da_dlTypes, l_List, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);
  lDocSab:= l_ResQuery.FoundList;
 finally
  l3Free(l_ResQuery);
 end;
 if lDocSab.Count > 0 then
 begin
  // lDocSab - это список постановлений, измененных за период
  // Нужно найти среди них те, что без номеров дел


  //найдем доки с кейскодами
  lCCSab := MakeSab(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lCCSab.Select(dnTypFld, cCaseCodeType);
  lCCSab.ValuesOfKey(dnIDFld);
  lCCSab.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  lCCSab.ValuesOfKey(lnkDocIDFld);
  lCCSab.TransferToPhoto(fId_Fld, lDocSab);


  lDocSab.ValuesOfKey(fId_Fld);
  lDocSab.SubtractSab(lCCSab);

  if not lDocSab.IsEmpty then
  begin

   l_Task:= TddCaseCodeTask.Create({nil,} usServerService);
   try
    dtOutSabToStream(lDocSab, l_Task.SABStream);
    AddActiveTask(l_Task);
   finally
    l3Free(l_Task);
   end;
   l3System.Msg2Log('Задание сформировано (%d Постановлений)', [lDocSab.Count]);

  end // not l_ResQuery.IsEmpty
  else
   l3System.Msg2Log('Не найдено постановлений без номеров дел');
 end
 else
  l3System.Msg2Log('Не найдено постановлений без номеров дел');
 ddAppConfiguration.AsDateTime['ccDate']:= l_EndDate;
end;

procedure TddServerTaskManager.SaveQuery;
begin
  ActiveTaskList.Save;
end;

procedure TddServerTaskManager.StopProcessQuery(aTask: TddProcessTask);
begin
 if (aTask <> nil) then
 begin
  if (aTask.Status = cs_tsFrozen) then
   aTask.RequestQuery
  else
  begin
   AbortTask(aTask);
   aTask.RequestFrozen;
  end;//aTask.Status = cs_tsFrozen
 end//aTask <> nil
end;

procedure TddServerTaskManager.TaskDone(aTask: TddProcessTask);
begin
 aTask.Use;
 try
  if f_TaskList.Has(aTask) then
   l3System.Msg2Log('Задача с идентификатором %s удаляется из активных - успех', [aTask.TaskID]);
  aTask.Done;
  // Посылать ли заказчику уведомление об окончании? По-моему, он и так его получит... Или только в случае наблюдения за очередью?
  // aTask.OnChange := nil;
  aTask.CanNotifyChange := false;
  if (l3System.MessageLevel >= 10) and (f_SerachActiveTaskCounter > 0) then
   l3System.Stack2Log(Format('AF TRAP - delete task %p. See K-617777268', [Pointer(aTask)]));
  ClearTask(aTask);
  f_TasksToPurgeList.Add(aTask);
  TaskListUpdated(aTask);
 finally
  FreeAndNil(aTask);
 end;
end;

procedure TddServerTaskManager.TaskListUpdated(aTask: TddProcessTask);
begin
 if (GetCurrentThreadID = MainThreadID) then
 begin
  if Assigned(f_OnTaskListChanged) then
   f_OnTaskListChanged(aTask);
 end//GetCurrentThreadID = MainThreadID
 else
 begin
  if Assigned(aTask) then
   f_ChangedTasks.Push(aTask)
  else
   f_NeedUpdateAllTask := True;
 end;
end;

procedure TddServerTaskManager.DoTaskChanged(aTask: TddTaskItem; PrevStatus: TcsTaskStatus);

var
 l_Task : TddProcessTask;

 function SendTaskProgress(anItem: Integer): Boolean;
 begin
  Result := true;
  MessageManager.SendNotify(anItem, ntTaskProgress, l_Task.RunProgress, l_Task.TaskID, usServerService);
 end;

 function SendTaskChanged(anItem: Integer): Boolean;
 begin
  Result := true;
  MessageManager.SendNotify(anItem, ntTaskChanged, Ord(l_Task.Status), l_Task.TaskID, usServerService);
 end;

begin
 if (aTask is TddProcesstask) then
 begin
  l_Task := TddProcesstask(aTask);
  ChangeServerStatus(l_task);

  if (l_Task.Status <> cs_tsDelivering) then
  begin
   if (l_Task.Status <> cs_tsReadyToDelivery) then
   begin
    WorkupRequests; // Обработка запросов в процессе обновления статуса задачи
    //f_ActiveTaskList.Sort;
    //f_ActiveTaskList.Save; <- Не работает в мнопоточном режиме
   end;//l_Task.Status <> cs_tsReadyToDelivery
   TaskListUpdated(l_Task);

   // По идее любое изменение статуса должно передаваться клиенту...
   if (l_Task.Status <> PrevStatus) then
   begin
    if (l_Task.Status = cs_tsReadyToDelivery) then
    begin
     f_LastDelivering := Now;
     MessageManager.SendNotify(l_Task.UserID, ntResultsReadyForDelivery, 0, '', usServerService);
    end;

    MessageManager.SendNotify(l_Task.UserID, ntTaskChanged, Ord(l_Task.Status), l_Task.TaskID, usServerService);
    if (l_Task.Status = cs_tsReadyToDelivery) then
     // - пробуем доставить недоставленное
     MessageManager.SendNotify(l_Task.UserID, ntResultsReadyForDelivery, 0, '', usServerService);

   end;//l_Task.Status <> PrevStatus
  end // (l_Task.Status <> cs_tsDelivering)
  else
   TaskListUpdated(l_Task);

  if (SecondsBetween(f_LastUpdate, Now) > UpdatePeriod) or (f_LastChangedTask <> l_Task) or (f_LastChangedStatus <> l_Task.Status) then
  begin
   f_LastUpdate := Now;
   f_LastChangedTask := l_Task;
   if not l_Task.IsHiddenFromUser then
   begin
    if (l_Task.Status in cs_tsStatusesWithProgress) then
    begin
     f_MonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskProgress));
     f_PrivateMonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskProgress));
    end; // (l_Task.Status in cs_tsRunningStatuses) then
    if not (l_Task.Status in cs_tsStatusesWithProgress) or (l_Task.Status <> f_LastChangedStatus) then
    begin
     f_MonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskChanged));
     f_PrivateMonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskChanged));
    end; // not (l_Task.Status in cs_tsStatusesWithProgress) or (l_Task.Status <> PrevStatus)
   end;
   f_LastChangedStatus := l_Task.Status;
  end; // (SecondsBetween(f_LastUpdate, Now) > UpdatePeriod) or (f_LastChangedTask <> l_Task)
 end; // Sende is Task
end;

procedure TddServerTaskManager.UnLockProcessing;
begin
 Dec(f_LockProcessingCounter);
 if f_LockProcessingCounter < 0 then
  f_LockProcessingCounter := 0;
end;

procedure TddServerTaskManager.WorkupDelayed;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if ForceRun then
  begin
   ForceExecuteTask(anItem);
   while not (anItem.Status in cs_tsFinishedStatuses) do
   begin
    Application.ProcessMessages;
    Sleep(0);
   end;
  end 
  else
   AddActiveTask(anItem);
 end;

begin
 f_ActiveTaskList.Lock;
 try
  f_DelayedList.Lock;
  try
   f_DelayedList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   f_DelayedList.Clear;
  finally
   f_DelayedList.Unlock;
  end;//try..finally
 finally
  f_ActiveTaskList.Unlock;
 end;//try..finally
end;

procedure TddServerTaskManager.WorkupRequests;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  case anItem.TaskType of
   cs_ttDictEdit:
    DoChangeDictItem(anItem);
   cs_ttUserEdit:
    DoChangeUserItem(anItem);
   cs_ttDeleteDocs:
    DoDeleteDocs(anItem);
   cs_ttRunCommand:
    DoCommand(anItem);
   cs_ttUserDefinedExport:
    DoSaveUserDefinedExport(anItem);
   cs_ttDownloadDoc,
   cs_ttUploadDoc:
    DoRunRequest(anItem);
   else
    Assert(false, 'WorkupRequests. Неизвестный тип задачи: ' + GetEnumName(TypeInfo(TcsTaskType), Ord(anItem.TaskType)));
  end;//case anItem.TaskType
 end;//DoIt

begin
 if (not f_Busy) and not ProcessingLocked then
 begin
  f_Busy := True;
  try
   f_RequestList.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoIt));
  finally
   f_Busy := False;
  end;//try..finally
 end;//not f_Busy
end;

function TddServerTaskManager.AddTaskToIncoming(const aTask: TddProcessTask): integer;
begin
 Assert(aTask <> nil);
 Result := f_IncomingTasks.Push(aTask)
end;

function TddServerTaskManager.AddTaskFromStreamToIncoming(Stream: Tl3Stream; const aRootTaskFolder: String; aisPipe: Boolean): integer;
var
 l_Task: TddTaskItem;
begin
 Assert(Stream <> nil, 'Отсутствуют данные задания для его добавления в RawList');
 Result := 0;
 Stream.Seek(0, 0);
 l_Task := TddTaskItem.MakeFrom(Stream, aRootTaskFolder, aisPipe);
 try
  if (l_Task <> nil) then
   Result := AddTaskToIncoming(l_Task as TddProcessTask)
  else
   l3System.Msg2Log('Неизвестная задача');
 finally
  l3Free(l_Task);
 end;
end;

procedure TddServerTaskManager.AddUserInMonitor(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_MonitorUsers.Add(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.AddUserInPrivateMonitor(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_PrivateMonitorUsers.Add(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.DeleteUserOfMonitorS(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_MonitorUsers.Remove(l_task.UserID);
   f_PrivateMonitorUsers.Remove(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.pm_SetProgressor(
  const Value: TddProgressObject);
begin
  f_Progressor := Value;
end;

procedure TddServerTaskManager.NotifyProgress(TotalPercent: Long;
  const TotalCaption: AnsiString);
begin
  if Assigned(f_ActiveTask) and not AllowAsyncRunTask(f_ActiveTask) then
  begin
    f_ActiveTask.SetProgress(TotalPercent, TotalCaption);
  end;
end;

procedure TddServerTaskManager.cs_AsyncProgress(aPipe: TCSDataPipe);
var
  l_TaskID: AnsiString;
  l_Progress: Long;
  l_Message: AnsiString;

  function DoIt(anItem: TddProcessTask): Boolean;
  begin
   Result := true;
   anItem.SetProgress(l_Progress, l_Message);
  end;

begin
  l_TaskID := aPipe.ReadLn;
  l_Progress := aPipe.ReadCardinal;
  l_Message := aPipe.ReadLn;
  WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt))
end;

procedure TddServerTaskManager.WaitForAsyncRunningTasks;
begin
  while f_WorkPool.HasRunningTask(Self, True) do
  begin
   {$IFNDEF Service}
    Application.ProcessMessages;
   {$ENDIF Service}
   Sleep(10);
  end;
end;

{$IFDEF InsiderTest}
procedure TddServerTaskManager.TrySimulateTaskDone(
  const aTask: TddProcessTask);
begin
  if CanSimulateTaskDone then
  begin
   while aTask.Status = cs_tsAsyncRun do
   begin
    f_WorkPool.CheckExecution(Self);
 {$IFNDEF Service}
    Application.ProcessMessages;
 {$ENDIF Service}
    Sleep(10);
   end;
   SimulateTaskDone(aTask);
  end;
  CanSimulateTaskDone := false;
end;
{$ENDIF}

procedure TddServerTaskManager.TaskFinished(const aTask: TddProcessTask);
begin
 if not (aTask.Status in cs_tsKeepProcessingStatuses) then
  TaskDone(aTask);
end;

procedure TddServerTaskManager.pm_SetMessageManager(
  const Value: TcsMessageManager);
begin
  f_MessageManager := Value;
end;

procedure TddServerTaskManager.cs_ReceiveTaskResult(aPipe: TCSDataPipe);
var
  l_Stream: TStream;
  l_Tag: Tl3Tag;

  function DoIt(anItem: TddProcessTask): Boolean;
  begin
   Result := true;
   anItem.TaskResult.SetTaggedData(l_Tag);
  end;

begin
  l_Stream := Tl3TempMemoryStream.Create;
  try
    aPipe.ReadStream(l_Stream);
    l_Stream.Seek(0, soFromBeginning);
    l_Tag := TcsTaskResult.CreateTaggedDataFromEVD(l_Stream);
    try
      Assert(l_Tag.IsKindOf(k2_typTaskResult));
      WorkupTaskByIDF(l_Tag.StrA[TaskResult_Const.k2_attrTaskID], L2AlcuTasksIteratorForOneFAction(@DoIt))
    finally
      FreeAndNil(l_Tag);
    end;
  finally
    FreeAndNil(l_Stream);
  end;
end;

function TddServerTaskManager.AllowAsyncRunTask(const aTask: TddProcessTask): Boolean;
begin
  Result := aTask.CanAsyncRun and (Tl3LongintList(ddAppConfiguration.AsObject['AsyncRunTaskType']).IndexOf(aTask.TaskTaggedDataType.ID) <> -1);
end;

procedure TddServerTaskManager.SendTextMessage(anUserID: TdaUserID;
  const aMessage: AnsiString);
begin
  MessageManager.SendTextMessage(anUserID, aMessage);
end;

procedure TddServerTaskManager.FreezeQueryQueue(WaitForFreeze: Boolean);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  FreezeTask(anItem);
 end;

begin
 Changing;
 try
  FreezeRunningSyncTask;
  f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
  if WaitForFreeze then
   WaitForAsyncRunningTasks;
  f_TransporterPool.TerminateAll;
 finally
  Changed;
 end;
 f_OnTaskListChanged := nil;
end;

procedure TddServerTaskManager.DoSaveUserDefinedExport(
  aTask: TddProcessTask);
var
 l_Source, l_Dest: String;
begin
 try
  l_Source := TcsUserDefinedExport(aTask).QueryFile;
  l_Dest := GetUniqFileName(ddAppConfiguration.AsString['sqFolder'],'q','.sqr');
  CopyFile(l_Source, l_Dest);
  f_UserQueries.LoadAsksList;
 except
  l3System.Msg2Log('Ошибка копирования файла запроса');
 end;//try..except
 aTask.Done;
end;

procedure TddServerTaskManager.LockAsyncRun;
begin
  f_WorkPool.LockSubmitTask;
end;

procedure TddServerTaskManager.UnLockAsyncRun;
begin
  f_WorkPool.UnLockSubmitTask;
end;

procedure TddServerTaskManager.SubmitAsyncTasks;

 function DoAsyncRun(anItem: TddProcessTask): Boolean;
 begin//DoIt
  if not AllowTaskExecution then
   Result := false
  else
  begin
   Result := true;
 //     l3System.Msg2Log(rsNaaloobrabotkioeredizadaniy);
   try
    if NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes) and f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then
       try
        Result := f_WorkPool.SubmitTask(anItem);
{$IFDEF InsiderTest}
        if Result then
          TrySimulateTaskDone(anItem);
{$ENDIF InsiderTest}
       finally
         f_WorkPoolManager.LeaveTaskExecution(anItem);
       end;// try
    end; // NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
//     Inc(l_CurTaskIndex); // Иначе зацикливается вывод в лог
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end; // except
  end; // not AllowTaskExecution
 end;//DoAsyncRun

begin
  if f_WorkPool.HasWorkThreads then
  begin
   f_ActiveTaskList.Sort;
   f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoAsyncRun));
  end;
end;

function TddServerTaskManager.pm_GetWorkThreadCount: Integer;
begin
 Result := f_WorkPool.WorkThreadCount
end;

procedure TddServerTaskManager.pm_SetWorkThreadCount(const Value: Integer);
var
 l_RealCount: Integer;
 l_Info: TSystemInfo;
begin
 if Value < 0 then
 begin
   GetSystemInfo(l_Info);
   l_RealCount := l_Info.dwNumberOfProcessors * 2;
 end
 else
  l_RealCount := Value;
 if f_WorkPool.WorkThreadCount <> l_RealCount then
 begin
  LockProcessing;
  try
   f_WorkPool.WorkThreadCount := l_RealCount
  finally
   UnLockProcessing;
  end;
 end; 
end;

function TddServerTaskManager.ExecutingTask(CountAbortingTask: Boolean): Boolean;
begin
  if CountAbortingTask then
    Result := Assigned(f_ActiveTask) and (f_ActiveTask.Status in (cs_tsRunningStatuses + [cs_tsAborting])) or
      f_WorkPool.HasRunningTask(Self, CountAbortingTask)
  else
    Result := Assigned(f_ActiveTask) and (f_ActiveTask.Status in cs_tsRunningStatuses) or
      f_WorkPool.HasRunningTask(Self, CountAbortingTask);
end;

procedure TddServerTaskManager.FreezeRunningSyncTask;
begin
 if Assigned(f_ActiveTask) then
   FreezeTask(f_ActiveTask);
end;

procedure TddServerTaskManager.FreezeTask(const aTask: TddProcessTask);
begin
 if (aTask.Status in cs_tsRunningStatuses) then
 begin
  aTask.CanNotifyChange := false;
  AbortTask(aTask);
  aTask.RequestFrozenRun;
 end;
end;

procedure TddServerTaskManager.cs_RequestDeliveryTaskList(
  aPipe: TCSDataPipe);
var
 l_UserID: TdaUserID;
 l_List: TStringList;
 l_IDX: Integer;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) and (anItem.UserID = l_UserID) then
   l_List.Add(anItem.TaskID);
 end;

begin
 l_UserID := aPipe.ReadCardinal;
 l_List := TStringList.Create;
 try
  f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
  aPipe.WriteInteger(l_List.Count);
  for l_IDX := 0 to l_List.Count - 1 do
   aPipe.WRiteLn(l_List[l_IDX]);
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TddServerTaskManager.cs_ExportResultProcessing(
  aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
 l_Watch: Tl3StopWatch;
begin
 l_Watch.Reset;

 g_SaveMessage.ReSet;
 g_LoadMessage.ReSet;
 g_SendMessage.ReSet;
 g_ReveiveMessage.ReSet;
 g_WaitFile.ReSet;
 g_ReceivePartFile.ReSet;
 g_SaveControl.ReSet;
 g_WriteFile.ReSet;
 g_SaveControl.ReSet;

 l_Watch.Start;
 try
{$IFDEF csSynchroTransport}
  l_Transporter := TncsSynchroServerTransporter.Make(aPipe.IOHandler);
  l_IsMainSocket := True;
{$ELSE csSynchroTransport}
  l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
{$ENDIF csSynchroTransport}
  try
   Assert(l_IsMainSocket);
   f_TransporterPool.Register(l_Transporter);
   try
    l_Transporter.ProcessMessages(l_IsMainSocket);
   finally
    CancelDelivering(l_Transporter.ClientID);
    f_TransporterPool.UnRegister(l_Transporter);
   end;
  finally
   l_Transporter := nil;
  end;
 finally
  l_Watch.Stop;
 end;

 l3System.Msg2Log('Затраченное время - %s ms', [FormatFloat('0,###.000', l_Watch.Time * 1000)]);
{$IFDEF ncsProfile}
 l3System.Msg2Log('SAVE MESSAGE = %s', [FormatFloat('0,###.000', g_SaveMessage.Time * 1000)]);
 l3System.Msg2Log('SEND MESSAGE = %s', [FormatFloat('0,###.000', g_SendMessage.Time * 1000)]);
 l3System.Msg2Log('SEND MESSAGE FLUSH = %s', [FormatFloat('0,###.000', g_SaveControl.Time * 1000)]);
 l3System.Msg2Log('LOAD MESSAGE = %s', [FormatFloat('0,###.000', g_LoadMessage.Time * 1000)]);
 l3System.Msg2Log('RECEIVE MESSAGE = %s', [FormatFloat('0,###.000', g_ReveiveMessage.Time * 1000)]);
 l3System.Msg2Log('WAIT FILE = %s', [FormatFloat('0,###.000', g_WaitFile.Time * 1000)]);
 l3System.Msg2Log('SEND FILE = %s', [FormatFloat('0,###.000', g_ReceivePartFile.Time * 1000)]);
 l3System.Msg2Log('WRITE FILE = %s', [FormatFloat('0,###.000', g_WriteFile.Time * 1000)]);
 l3System.Msg2Log('TOTAL = %s', [FormatFloat('0,###.000', l_Watch.Time * 1000)]);
{$ENDIF ncsProfile}
end;

function TddServerTaskManager.MakeExecutor(
  aMessage: TncsMessage): IncsExecutor;
begin
 if aMessage is TncsGetReadyToDeliveryTasks then
  Result := TalcuGetReadyToDeliveryTasksExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsGetTaskDescription then
  Result := TalcuGetTaskDescriptionExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsTaskProgress then
  Result := TalcuTaskProgressExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsGetFilePart then
  Result := TalcuGetFilePartExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsDeliveryResult then
  Result := TalcuDeliveryResultExecutor.Make(f_ActiveTaskList, Self)
 else if aMessage is TncsSendTask then
{$IFDEF csSynchroTransport}
  Result := TalcuSendTaskExecutor.Make(f_IncomingTasks, RootTaskFolder, SpeedupRequest)
{$ELSE csSynchroTransport}
  Result := TalcuDetachedExecutor.Make(f_DetachedExecutorPool, TalcuSendTaskExecutor.Make(f_IncomingTasks, RootTaskFolder, SpeedupRequest))
{$ENDIF csSynchroTransport}
 else if aMessage is TncsCorrectFolder then
  Result := TalcuCorrectFolderExecutor.Make(f_ActiveTaskList)
 else if aMessage is TcsDownloadDocStream then
  Result := TalcuDownloadDocStreamExecutor.Make(f_IncomingTasks, SpeedupRequest)
 else if aMessage is TcsUploadDocStream then
  Result := TalcuUploadDocStreamExecutor.Make(f_IncomingTasks, SpeedupRequest, evntOnEraseAttrRecords)
 else
  Result := nil;
end;

procedure TddServerTaskManager.CancelDelivering(aCLientID: TcsClientID);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsDelivering) and (anItem.UserID = aClientID) then
   anItem.CorrectStatus;
 end;

begin
 f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
end;

procedure TddServerTaskManager.cs_TaskSend(aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
begin
{$IFDEF csSynchroTransport}
 l_Transporter := TncsSynchroServerTransporter.Make(aPipe.IOHandler);
 l_IsMainSocket := True;
{$ELSE csSynchroTransport}
 l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
{$ENDIF csSynchroTransport}
 try
  Assert(l_IsMainSocket);
  f_TransporterPool.Register(l_Transporter);
  try
   l_Transporter.ProcessMessages(l_IsMainSocket);
  finally
   f_TransporterPool.UnRegister(l_Transporter);
   f_DetachedExecutorPool.Pack;
  end;
 finally
  l_Transporter := nil;
 end;
end;

procedure TddServerTaskManager.cs_TransporterHandshake(aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
begin
{$IFDEF csSynchroTransport}
 Assert(False);
{$ENDIF csSynchroTransport}
 l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
 try
  Assert(not l_IsMainSocket);
  l_Transporter.ProcessMessages(l_IsMainSocket);
 finally
  l_Transporter := nil;
 end;
end;

procedure TddServerTaskManager.Changed;
begin
 TaskListUpdated(nil);
end;

procedure TddServerTaskManager.Changing;
begin
// DoNothing;
end;

procedure TddServerTaskManager.cs_TerminateTask(aPipe: TCSDataPipe);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status in cs_tsCanDeleteStatuses) and (aPipe.ClientID = anItem.UserID) then
  begin
   DeleteTask(anItem, True);
   l3System.Msg2Log('Задача с идентификатором ' + anItem.TaskID + ' отменена пользователем');
  end
  else
   l3System.Msg2Log('Задача с идентификатором ' + anItem.TaskID + ' не может быть удалена');
 end;

var
 l_TaskID: AnsiString;

begin
 l_TaskID := aPipe.ReadLn;
 if not WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt)) then
  l3System.Msg2Log('Задача с идентификатором ' + l_TaskID + ' не найдена (удаление)');
end;

procedure TddServerTaskManager.LockTaskExecution;
begin
 Inc(f_LockTaskExecution);
end;

function TddServerTaskManager.TaskExecutionLocked: Boolean;
begin
 Result := f_LockTaskExecution > 0;
end;

procedure TddServerTaskManager.UnlockTaskExecution;
begin
 Dec(f_LockTaskExecution);
 if f_LockTaskExecution < 0 then
  f_LockTaskExecution := 0;
end;

function TddServerTaskManager.AllowTaskExecution: Boolean;
begin
 Result := TaskExecutionEnabled and not TaskExecutionLocked and Tl3ProcessingEnabledService.Instance.Enabled; 
end;

procedure TddServerTaskManager.SignalServerStarted;
begin
  f_ServerStarted := True;
end;

procedure TddServerTaskManager.RequestExecuteCommand(aUser: TdaUserID; aCommandID: Integer);
var
 l_Command: TcsCommand;
 l_Task: TddRunCommandTask;
begin
 if Actions.CommandExists(aCommandID, l_Command) then
 begin
  l_Task:= TddRunCommandTask.Create(aUser, l_Command);
  try
   AddRequest(l_Task);
  finally
   FreeAndNil(l_Task);
  end;//try..finally
 end;//Actions.CommandExists(l_CommandID, l_Command)
end;

function TddServerTaskManager.NeedProcessTask(
  const aTask: TddProcessTask): Boolean;
begin
  Result := aTask.NeedProcess and not f_TasksToPurgeList.Has(aTask);
end;

function TddServerTaskManager.HasActiveTask(
  aTaskType: TcsTaskType): Boolean;

var
 l_Result: Boolean;

 function DoIt(anItem: TddProcessTask): Boolean;
 var
  l_TasksList: TasksListHelper;
  l_IDX: Integer;
  l_Task: TddProcessTask;
 begin
  Result := true;
  if anItem.Status in cs_tsFinishedStatuses then
   Exit;
  if (anItem.TaskType = aTaskType) then
  begin
   Result := False;
   l_Result := True;
  end
  else
   if anItem is TcsContainerTask then
   begin
    l_TasksList := TcsContainerTask(anItem).TasksList;
    try
     for l_IDX := 0 to l_TasksList.Count - 1 do
     begin
      l_Task := l_TasksList.MakeTask(l_IDX, '');
      try
       DoIt(l_Task);
       if l_Result then
       begin
        Result := False;
        Exit
       end;
      finally
       FreeANdNil(l_Task);
      end;
     end;
    finally
     l_TasksList := nil;
    end;
   end;
 end;

begin
 l_Result := False;
 f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
 Result := l_Result;
end;

procedure TddServerTaskManager.ForceExecuteTask(
  const aTask: TddProcessTask);
begin
 if NeedProcessTask(aTask) then
 begin
  while not f_WorkPoolManager.EnterTaskExecution(aTask) do
   Application.ProcessMessages;
  try
   if not (f_WorkPool.HasWorkThreads and AllowAsyncRunTask(aTask)) then
   begin
    l3System.Msg2Log('Выполняю подзадачу %s (%s)', [aTask.Description, aTask.TaskID]);
    try
     RunTask(aTask);
     TaskFinished(aTask);
    finally
     l3System.Msg2Log('Закончили подзадачу %s (%s)', [aTask.Description, aTask.TaskID]);
    end; 
   end
   else
   begin
    l3System.Msg2Log('Отцепляю подзадачу %s (%s)', [aTask.Description, aTask.TaskID]);
    while not f_WorkPool.SubmitTask(aTask) do
     Application.ProcessMessages;
   end;
  finally
    f_WorkPoolManager.LeaveTaskExecution(aTask);
  end;// try
 end; // NeedProcessTask(anItem) and (anItem.TaskType in EnabledTaskTypes)
end;

procedure TddServerTaskManager.cs_CustomMessageProcessing(
  aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
 l_Watch: Tl3StopWatch;
begin
{$IFDEF csSynchroTransport}
 l_Transporter := TncsSynchroServerTransporter.Make(aPipe.IOHandler);
 l_IsMainSocket := True;
{$ELSE csSynchroTransport}
 l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
{$ENDIF csSynchroTransport}
 try
  Assert(l_IsMainSocket);
  f_TransporterPool.Register(l_Transporter);
  try
   l_Transporter.ProcessMessages(l_IsMainSocket);
  finally
   f_TransporterPool.UnRegister(l_Transporter);
  end;
 finally
  l_Transporter := nil;
 end;
end;

procedure TddServerTaskManager.DoRunRequest(aTask: TddProcessTask);
begin
 aTask.Run(TddRunContext_C(f_Progressor));
 aTask.Done;
end;

procedure TddServerTaskManager.SignalServerStopping;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  anItem.Abort;
  Result := true;
 end;//DoIt

begin
 if f_Busy then
  l3System.Msg2Log('WARNING - Попытка загаситься в ходе обработки запросов');
 f_RequestList.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoIt));
end;

procedure TddServerTaskManager.DoAddActiveTask(
  const aTask: TddProcessTask);
begin
// Сюда можно попасть двумя путями - получив новую задачу или загрузив старые
 if (aTask <> nil) then
 begin
  l3System.Msg2Log('Добавление %s задачи: %s', [IfThen(true{aIsNew}, 'новой', 'загруженной'), atask.Description]);
  ActiveTaskList.Lock;
  try
    CalculatePriority(aTask);
    //aTask.OnChange := TaskStatusChanged;
    aTask.SetupServerSideConfigParams;
    f_TaskList.Add(aTask); // для отображения визуальной частью
    aTask.CanNotifyChange := true;
    aTask.RequestQuery;
    ActiveTaskList.AddTask(aTask); // список заданий, ожидающих выполнения
    Inc(f_AddedActiveTaskCount);
    MessageManager.SendNotify(aTask.UserID, ntTaskAdded, 0{aTask.TaskIndex}, aTask.TaskID, usServerService);
  finally
   ActiveTaskList.Unlock;
  end;//try..finally
  l3System.Msg2Log('Задача добавлена');
 end;//aTask <> nil
end;

procedure TddServerTaskManager.DoAddRequest(
  const aRequest: TddProcessTask);
begin
 f_RequestList.Push(aRequest);
end;

procedure TddServerTaskManager.SpeedupRequestWndProc(var Msg: TMessage);
begin
 if Msg.Msg = msg_SpeedupRequest then
 begin
  ProcessIncomingTasks;
  Msg.Result := 1;
 end
 else
  Msg.Result := DefWindowProc(f_SpeedupRequestHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TddServerTaskManager.SpeedupRequest;
begin
 PostMessage(f_SpeedupRequestHandle, msg_SpeedupRequest, 0, 0);
end;

procedure TddServerTaskManager.evntOnEraseAttrRecords(
  aAttrType: TCacheType; aDictID: TDictID; aDocID: TDocID; aSubID: TSubID);
begin
 dictChangeToLogFile(aAttrType, aDictID, aDocID, aSubID);
end;

initialization
 msg_SpeedupRequest := RegisterWindowMessage(PChar(l3CreateStringGUID));

end.

