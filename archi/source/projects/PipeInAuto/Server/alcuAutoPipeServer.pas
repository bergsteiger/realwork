unit alcuAutoPipeServer;

interface

{* Собственно парень (с нимбом)
  <TITLE Введение>

  AutoPipeServer, в просторечии называемый "парнем" - это
  сервисная программа, выполняющаяся на сервере и
  предназначенная для взаимодействия с пользователями и
  обслуживания базы данных.                               }


// Revision 1.288  2014/02/11 14:49:23  lulin
// - применяем технику Dependency Injection для параметризации класса менеджера заданий.
//
// Revision 1.287  2014/02/11 12:11:34  lulin
// Добиваемся более менее устоучивого повторения ошибки {RequestLink:515529250}.
//
// Revision 1.286  2014/02/11 08:14:47  GarikNet
// K:516533773
//
// Revision 1.285  2014/02/11 07:08:22  GarikNet
// K:516533773
//
// Revision 1.284  2014/02/10 16:27:59  lulin
// {RequestLink:516533785}.
// - правильнее выпиливаем тестовую обвязку для {RequestLink:515862135}.
//
// Revision 1.283  2014/02/10 14:50:35  lulin
// {RequestLink:516533785}.
//
// Revision 1.282  2014/02/10 13:03:03  lulin
// {RequestLink:516533785}.
//
// Revision 1.281  2014/02/10 07:54:05  GarikNet
// K:516189258
//
// Revision 1.280  2014/02/03 12:13:41  GarikNet
// K:515529250
// Ошибка обращение к списку активных задач при их сохранении
// на локальный диск (конфликт обращения асинхронных потоков
// к общему объекту)
//
// Revision 1.279  2014/01/15 09:37:30  fireton
// - более корректно получаем дату версии с сервера
//
// Revision 1.278  2013/11/21 09:48:17  voba
// - Вычищаем Gardoc
//
// Revision 1.277  2013/11/07 06:58:40  fireton
// - очищаем директорию с архивом импортированных данных
//
// Revision 1.276  2013/09/05 09:22:59  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.275  2013/08/28 05:15:03  fireton
// - не собиралось
//
// Revision 1.274  2013/06/20 08:58:43  fireton
// - возвращаем проверку свободного места
//
// Revision 1.273  2013/06/20 08:08:14  fireton
// - отключаем проверку свободного места пока не разберёмся, почему она вызывает физическую перезагрузку сервера
//
// Revision 1.272  2013/06/17 10:52:24  fireton
// - логи для диагностики перезагрузок сервера
//
// Revision 1.271  2013/06/17 10:01:03  fireton
// - логи для диагностики перезагрузок сервера
//
// Revision 1.270  2013/06/10 08:39:50  fireton
// - отключаем отстреливание сессий
//
// Revision 1.269  2013/05/22 14:01:35  voba
// -K:457094554
//
// Revision 1.268  2013/05/07 08:24:11  voba
// - K:453162928
//
// Revision 1.267  2013/04/30 10:11:48  fireton
// - заставляем клиент запрашивать дату анонсирования при подключении к серверу
//
// Revision 1.266  2013/04/26 09:08:22  fireton
// - некорректный порядок вычисления даты
//
// Revision 1.265  2013/04/26 04:50:20  fireton
// - bugfix: интервал таймера не вмещался в Cardinal
//
// Revision 1.264  2013/04/17 07:13:52  narry
// Обновление
//
// Revision 1.263  2013/04/16 13:05:10  narry
// В регионах другой график переключения дат
//
// Revision 1.262  2013/04/15 12:49:23  narry
// Обновление
//
// Revision 1.261  2013/04/11 07:19:58  narry
// Не правильно задавался каталог экспорта
//
// Revision 1.260  2013/04/09 07:35:27  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.259  2013/04/05 12:41:51  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.258  2013/04/04 12:07:31  narry
// Вычисление даты анонсирования (447388742)
//
// Revision 1.257  2013/04/04 11:22:27  narry
// Вычисление даты анонсирования (447388742)
//
// Revision 1.256  2013/04/03 09:50:41  fireton
// - логика простановки VANONCED
//
// Revision 1.255  2013/03/05 11:45:38  narry
// Задание планировщика "Обновление удаленной базы"
//
// Revision 1.254  2013/02/05 10:13:46  narry
// Не отсылаем сообщения сами себе (они остаются мертвым грузом в списке)
//
// Revision 1.253  2013/01/21 11:14:25  fireton
// - [$362978911]
//
// Revision 1.252  2013/01/14 13:19:28  narry
// Ограничения на использование кнопки (пока костыль) (423604654)
//
// Revision 1.251  2013/01/10 13:42:18  narry
// Кнопка Автоэкспорт (423598302)
//
// Revision 1.250  2013/01/10 13:28:56  narry
// Кнопка Автоэкспорт (423598302)
//
// Revision 1.249  2012/11/27 04:25:31  fireton
// - обновляем таблицы кэша автопростановщика
//
// Revision 1.248  2012/11/27 04:24:13  fireton
// - обновляем таблицы кэша автопростановщика
//
// Revision 1.247  2012/11/09 10:55:12  fireton
// - чистим старую почту
//
// Revision 1.246  2012/10/18 07:15:08  narry
// Версия pipeout2, умеющая строить списки новых и измененных (383583730)
//
// Revision 1.245  2012/10/02 07:37:23  narry
// Обновление
//
// Revision 1.244  2012/09/07 13:33:54  narry
// Закрытие файловых сессий
//
// Revision 1.243  2012/08/30 13:58:47  narry
// Экспорт для Хаванского
//
// Revision 1.242  2012/08/13 12:45:22  narry
// Включение создания списка образов
//
// Revision 1.241  2012/08/13 12:26:11  narry
// Флажок "выгонять"пользователей для функции обновления базы
//
// Revision 1.240  2012/08/02 13:16:51  narry
// Ограничение импорта по количеству документов (380619133)
//
// Revision 1.239  2012/07/13 09:11:30  narry
// Ручка на стороне клиента для пополнения справок
//
// Revision 1.238  2012/07/10 11:03:38  narry
// Удаленный запуск run2 (375424291)
//
// Revision 1.237  2012/06/29 08:17:22  narry
// Обновление
//
// Revision 1.236  2012/06/22 08:42:36  narry
// Сброс лога после переключения на локальную базу
//
// Revision 1.235  2012/06/14 14:13:44  narry
// Не удалялись старые резервные копии
//
// Revision 1.234  2012/06/14 11:45:37  narry
// Возможность сжатия старых лог-файлов
//
// Revision 1.233  2012/06/14 10:59:18  narry
// Параметры для ResetSelfLog - размер файла, сжатие
//
// Revision 1.232  2012/05/28 10:38:00  narry
// Обновление
//
// Revision 1.231  2012/05/28 10:04:28  narry
// Обновление
//
// Revision 1.230  2012/05/15 10:51:16  narry
// Неправильно вычисляллось количество резервных копий
//
// Revision 1.229  2012/05/14 09:28:41  narry
// Автодополнение справок (269063217)
//
// Revision 1.228  2012/04/27 08:28:42  narry
// Исправление ошибок при сравнении копий
// Корректное удаление предыдущих копий
//
// Revision 1.227  2012/04/17 13:23:15  narry
// Оптимизация выливки справок (356073078)
//
// Revision 1.226  2012/04/16 10:00:42  narry
// Копирование файлов с помощью l3FileUtils.CopyFile
//
// Revision 1.225  2012/04/12 10:29:48  narry
// Копирование файлов с помощью l3FileUtils.CopyFile
//
// Revision 1.224  2012/03/12 13:52:39  narry
// Корректное сообщение о лимите свободного места на диске
// Инициализация окончаний
//
// Revision 1.223  2012/03/06 09:16:40  narry
// Получать с сервера список групп доступа Переданные в регион (273581950)
//
// Revision 1.222  2012/01/31 12:51:31  narry
// Обмен данными с Ovga
//
// Revision 1.221  2012/01/30 11:15:22  narry
// - Автоэкспорт неподключенных
//
// Revision 1.220  2012/01/30 09:05:55  narry
// - Автоэкспорт неподключенных
//
// Revision 1.219  2011/12/16 12:31:26  narry
// Управление из Парня (319488062)
//
// Revision 1.217  2011/12/14 09:51:48  narry
// Добавление поля в таблицу Sub001 (303171256)
//
// Revision 1.216  2011/12/08 13:07:51  narry
// AV при получении информации о пользователе (316506483)
//
// Revision 1.215  2011/12/08 12:29:23  narry
// Отображается не вся очередь заданий (304874341)
//
// Revision 1.214  2011/12/08 09:32:41  narry
// Таблица не открыта (316506248)
//
// Revision 1.213  2011/11/28 07:47:01  narry
// Отображается не вся очередь заданий (304874341)
//
// Revision 1.212  2011/11/16 10:17:36  narry
// Интеграция импорта из К в сервер автоматизации (298682480)
//
// Revision 1.211  2011/11/11 12:26:15  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.210  2011/11/07 06:51:41  narry
// Обращение к несуществующему свойству
//
// Revision 1.209  2011/11/02 08:09:09  narry
// Свободное место на диске измеряется в базах
//
// Revision 1.208  2011/11/02 06:22:38  narry
// Обновление
//
// Revision 1.207  2011/11/01 05:22:02  narry
// НИР Расстановка меток в ФАСах (147489953)
//
// Revision 1.206  2011/10/14 06:11:21  narry
// Не собиралось
//
// Revision 1.205  2011/10/13 09:21:59  narry
// Накопившиеся изменения
//
// Revision 1.204  2011/10/10 07:21:14  narry
// Простановка сабов 20005 и 30005 - перенос на этап заливки
//
// Revision 1.203  2011/09/20 05:42:56  narry
// Обновление
//
// Revision 1.202  2011/09/15 07:19:36  narry
// - Избавление от ненужных параметров
//
// Revision 1.201  2011/09/13 12:26:53  narry
// Простановка меток в документах ВАС (283613768)
//
// Revision 1.200  2011/09/08 08:03:05  fireton
// - поменялось название метода (Update -> ProcessUpdate)
//
// Revision 1.199  2011/08/09 10:32:49  narry
// Заливка информации в справки каждую ночь (266422146)
//
// Revision 1.198  2011/06/20 13:07:46  narry
// Пересборка для регионов
//
// Revision 1.197  2011/06/20 07:26:47  narry
// Не работает простановка меток 20005 и 30005 (269080331)
//
// Revision 1.196  2011/06/15 09:19:22  narry
// Пользователь 0 (269071514)
//
// Revision 1.195  2011/06/07 14:27:20  narry
// В постановлениях ФАС в заголовках отсутствует номер постановления (268350079)
//
// Revision 1.194  2011/06/03 11:57:14  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266406580)
//
// Revision 1.193  2011/06/02 13:21:05  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266406580)
//
// Revision 1.192  2011/05/17 12:59:34  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266410319)
//
// Revision 1.191  2011/05/16 13:37:00  narry
// Обработка запроса на импорт "подготовленных" постановлений (266409024)
//
// Revision 1.190  2011/05/05 13:19:19  narry
// Обновление базы внешней утилитой (265408970)
//
// Revision 1.189  2011/04/22 11:44:09  narry
// Реакция на кнопку (262636470)
//
// Revision 1.188  2011/04/13 10:08:39  narry
// При заливке судебных документов сразу проводить автоклассификацию (257821581)
//
// Revision 1.187  2011/04/08 07:04:15  narry
// К260442621. Сделать импорт постановлений ААС заданием
//
// Revision 1.186  2011/04/06 11:31:50  narry
// К259893094. Поправить название темы для этапа обновления
//
// Revision 1.185  2011/03/23 11:56:56  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.184  2011/03/11 11:18:53  narry
// K255975299. Не импортируется дельта                            
//
// Revision 1.183  2011/02/02 09:32:56  narry
// 250904861. Перейти на ZipForge
//
// Revision 1.182  2011/01/19 07:53:07  narry
// K250904840. Создавать архив ключей "под ногами"
//
// Revision 1.181  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.180  2010/09/03 06:55:14  narry
// - AV при выполнении вложенных задач
//
// Revision 1.179  2010/08/27 09:00:36  narry
// - Не отбработали задачи, вложенные в Компиляцию
//
// Revision 1.178  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//
// Revision 1.177  2010/07/20 12:28:39  narry
// К226003904
//
// Revision 1.176  2010/07/06 12:27:02  narry
// - К222759027
//
// Revision 1.174  2010/05/19 10:59:30  narry
// - K211878089
//
// Revision 1.173  2010/05/14 13:18:05  narry
// - K211878137
// - настройка для ААС
//
// Revision 1.172  2010/04/20 09:47:12  narry
// - отправка словарей Типов и Предупреждений вместе с Ключевыми словами
// - формирование полного списка заданий импорта внешних дельт перед их выполнением
//
// Revision 1.171  2010/03/16 14:14:07  narry
// - очитска инишника от мусора
// - использование только одной библиотеки упаковки
// - корректное сохранения вложенных заданий
//
// Revision 1.170  2010/03/04 07:47:16  narry
// - обновление списка пользователей
// - одно окно для отправки сообщений и закрытия базы
//
// Revision 1.169  2010/03/02 08:23:22  narry
// - изменения splash
//
// Revision 1.168  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.167  2009/11/10 08:25:17  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.166  2009/09/17 11:44:16  lulin
// {RequestLink:163065542}.
//
// Revision 1.165  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.164  2009/03/17 09:26:42  narry
// - процедуры записи в файл информации об удалении меток с атрибутами
//
// Revision 1.163  2009/02/20 13:27:10  narry
// - обновление
//
// Revision 1.162  2009/02/16 14:22:27  narry
// - индикация начала и завершения проверки базы
//
// Revision 1.161  2009/01/30 10:00:00  narry
// - специфические обработчики каждого типа заданий
//
// Revision 1.160  2009/01/28 15:33:54  narry
// - функция применения дельты словарей
//
// Revision 1.159  2009/01/26 08:59:44  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.158  2009/01/23 16:20:10  narry
// - переделки в сторону службы
//
// Revision 1.157.2.1  2009/01/23 14:07:40  fireton
// - перенос Парня на Query
//
// Revision 1.157  2008/11/24 15:03:56  narry
// - рефакторинг, обнуление собственного лога
//
// Revision 1.156  2008/11/13 09:11:29  narry
// - не работала АК
//
// Revision 1.155  2008/10/29 10:09:06  narry
// - Обновление
//
// Revision 1.154  2008/10/28 08:51:08  narry
// - отключение вывода сообщений в режиме сервиса
//
// Revision 1.153  2008/10/15 09:08:33  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.152  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.151  2008/07/25 07:55:46  narry
// - обновление
//
// Revision 1.150  2008/07/24 15:17:18  narry
// - обновление
//
// Revision 1.149  2008/07/24 11:50:46  fireton
// - уведомление клиента об изменениях заданий в планировщике
//
// Revision 1.148  2008/07/21 11:46:09  fireton
// - КалеСо (версии и компиляции)
//
// Revision 1.147  2008/07/16 16:14:04  narry
// - реализация Автовыливки
//
// Revision 1.146  2008/07/10 13:01:13  fireton
// - refactoring: типы календарных событий переехали "наверх"
//
// Revision 1.145  2008/07/09 07:15:26  narry
// - косметика
//
// Revision 1.144  2008/07/09 06:38:43  fireton
// - переводим расписание с единичного события на подписку по типам заданий
//
// Revision 1.143  2008/06/24 07:41:35  narry
// - проверка почты по времени
// - воможность автокспортировать и неподключенные документы
//
// Revision 1.142  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.141  2008/06/06 15:07:05  narry
// - обновление
//
// Revision 1.140  2008/06/04 08:36:20  narry
// - ошибки обращения к элементам конфигурации
//
// Revision 1.139  2008/05/14 10:50:34  narry
// - уменьшение объема выоводимой в лог инфы для регионов
//
// Revision 1.138  2008/04/23 10:43:15  narry
// - обновление
//
// Revision 1.137  2008/03/24 09:41:51  narry
// - при отправке аннотаций в Прайм не выливались аннотации для компиляции
//
// Revision 1.136  2008/03/13 13:56:24  narry
// - задел для превращения Парня в сервис
// - рефакторинг
// - задел для починки базы
//
// Revision 1.135  2008/03/04 12:09:52  narry
// - перенес ddServerTaskManager в проект
//
// Revision 1.134  2008/03/04 11:33:25  narry
// - обновление
//
// Revision 1.133  2008/03/04 08:27:29  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.132  2008/02/27 15:55:21  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
// - время в смс
// - условия компиляции
// - другое
//
// Revision 1.131  2008/02/19 15:52:19  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.130  2008/02/19 15:05:32  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.129  2008/02/06 09:27:11  narry
// - не компилировалось
// - новый параметр в конфигруации (файл архива кс)
//
// Revision 1.128  2008/02/04 12:25:24  narry
// - не компилировалось
//
// Revision 1.127  2008/01/30 09:42:03  narry
// - по окончании Автоклассификации уведомление посылается и через Арчи
// - изменение механизма проверки доступности дельты
//
// Revision 1.126  2008/01/21 13:24:58  narry
// - некорректно работало ожидание файла дельты
//
// Revision 1.125  2008/01/16 10:54:51  narry
// - ошибка в имени параметра конфигурации
//
// Revision 1.124  2007/12/25 12:04:20  narry
// - корректная установка времени окончания процедур обновления
// - переименование Еженедельного обновления
//
// Revision 1.123  2007/12/07 11:10:48  narry
// - обновление
//
// Revision 1.122  2007/12/06 11:41:12  lulin
// - собрал "парня".
//
// Revision 1.121  2007/12/06 09:39:35  narry
// - поддержка автоклассификации
//
// Revision 1.120  2007/12/03 07:54:57  narry
// - запрос папки для ручной полной копии базы
//
// Revision 1.119  2007/11/30 08:04:38  narry
// - исправлена опечатка
//
// Revision 1.118  2007/11/28 11:30:09  narry
// - дополнение окна "О программе"
// - незначительное изменение окна конфигурации
//
// Revision 1.117  2007/11/27 10:41:55  fireton
// - Integer -> TDictID
//
// Revision 1.116  2007/11/16 09:37:27  narry
// - обновление
//
// Revision 1.115  2007/11/12 09:10:57  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.114  2007/09/11 12:22:39  narry
// - Расстановка меток 30005 и 20005. Уточненная
//
// Revision 1.113  2007/09/06 06:21:12  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - Расстановка меток 30005 и 20005
// - Удаленое изменение словарей
//
// Revision 1.112  2007/08/21 06:40:27  narry
// - обновление
//
// Revision 1.111  2007/08/20 18:43:30  lulin
// - поправлено удаление второй копии базы.
//
// Revision 1.110  2007/07/27 11:21:07  narry
// - улучшение алгоритма установки статусов
// - исправление выявленных ошибок
//
// Revision 1.109  2007/07/25 10:44:19  narry
// - различные ошибки и упущения
//
// Revision 1.108  2007/07/24 12:33:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.107  2007/07/04 09:28:37  narry
// - обновление
//
// Revision 1.106  2007/03/27 12:21:12  narry
// - обновление
//
// Revision 1.105  2006/12/11 14:19:07  narry
// - Обновление
//
// Revision 1.104  2006/12/01 15:06:25  narry
// - борьба с range check
//
// Revision 1.103  2006/11/22 16:25:10  fireton
// - подготовка к большому UserID
//
// Revision 1.102  2006/11/15 10:11:18  narry
// - Обновление
//
// Revision 1.101  2006/10/12 12:01:48  narry
// - обновление
//
// Revision 1.100  2006/09/15 07:37:43  narry
// - исправление ошибок в обмене между сревером и клиентом
//
// Revision 1.99  2006/09/12 11:41:23  narry
// - исправлена ошибка экспорта ФНС
// - обновление таблиц перед импортом
//
// Revision 1.98  2006/08/30 08:41:06  narry
// - различные исправления и нововведения
//
// Revision 1.97  2006/07/28 12:33:45  narry
// - не присваивалось ключевое поле
//
// Revision 1.96  2006/07/13 11:01:06  narry
// - после заливки дельты не обновлялись таблицы
//
// Revision 1.95  2006/06/08 15:55:52  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.94.2.1  2006/06/08 09:26:53  fireton
// - перевод User ID на Longword
//
// Revision 1.94  2006/06/05 15:05:33  narry
// - новое: перевод на новый механизм рассылки нотификаций
//
// Revision 1.93  2006/04/25 09:33:22  lulin
// - cleanup.
//
// Revision 1.92  2006/03/31 12:42:24  narry
// - улучшения
//
// Revision 1.91  2006/03/21 08:26:21  narry
// - исправление:
//
// Revision 1.90  2006/03/07 12:28:09  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.89  2006/01/05 16:39:39  narry
// - исправления и улучшения
//
// Revision 1.88  2005/11/29 13:45:26  narry
// - обновление: переход на новый способ передачи задач
//
// Revision 1.87  2005/11/02 16:39:08  narry
// - исправления и улучшения
//
// Revision 1.86  2005/09/27 13:42:45  narry
// - исправление ошибки: не создавался список графических образов
//
// Revision 1.85  2005/09/27 11:50:01  narry
// - чистка кода
//
// Revision 1.84  2005/09/27 06:29:44  narry
// - обновление: замена строк на ресурсные константы
//
// Revision 1.83  2005/09/14 12:50:30  narry
// - чистка кода
// - обновление: замена константы на настраиваемый параметр
// - обновление: удаление индексов в позавчерашних копиях
// - новое: удаление старых результатов экспорта
//
// Revision 1.82  2005/09/09 12:36:26  narry
// - update: перед началом обновлений резервное копирование выполняется в обязательном порядке
//
// Revision 1.81  2005/09/08 08:00:02  narry
// - update
//
// Revision 1.80  2005/09/07 15:51:58  narry
// - new: индексация словарных статей
//
// Revision 1.79  2005/09/07 14:12:27  narry
// - update: суета с копированием базы
//
// Revision 1.78  2005/08/31 16:03:50  narry
// - Обновление: отдельный флажок для проверки наличия лог-файла, избавление от лишней записи в лог при ошибке копирования базы
//
// Revision 1.77  2005/07/22 06:20:13  narry
// - new: процедура построения списка графических образов
//
// Revision 1.76  2005/06/29 16:22:41  narry
// - update: возможность обновить текствовую часть без обновления текстового индекса
//
// Revision 1.75  2005/06/16 12:33:58  step
// слияние с веткой b_use_net_comm
//
// Revision 1.74.2.1  2005/06/03 13:14:37  step
// отказ от использования dt_Comm
//
// Revision 1.74  2005/05/30 13:20:38  narry
// - update: улучшения, исправления...
//
// Revision 1.73  2005/05/11 15:12:24  step
// TddAutoPipeServer использует TCommServer
//
// Revision 1.72  2005/04/20 11:48:46  narry
// - update: приоритеты заданий, логика определения подключения к базе по UNC-путям и что-то еще
//
// Revision 1.71  2005/03/14 12:15:42  narry
// - update: аннотации во всех их проявлениях
//
// Revision 1.70  2005/03/04 16:20:52  narry
// - обновление
//
// Revision 1.69  2005/02/08 17:12:49  narry
// - update & cleanup
//
// Revision 1.68  2005/02/03 13:06:01  narry
// - update: Из уважения к Шуре и порядка для.
//
// Revision 1.67  2004/12/23 11:47:13  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.66  2004/09/20 07:57:55  narry
// - update:
//
// Revision 1.65  2004/09/08 05:38:30  narry
// - update
//
// Revision 1.64  2004/08/25 12:49:27  narry
// - update: переход на новый индексатор
//
// Revision 1.63  2004/08/23 12:16:17  narry
// - bug fix: захват таблицы пользоватлей
// - update: подготовка перехода на новый индексатор
//
// Revision 1.62  2004/07/30 16:07:05  narry
// - update
//
// Revision 1.61  2004/07/21 16:23:58  narry
// - update, bug fix etc
//
// Revision 1.60  2004/07/02 12:13:54  narry
// - bug fix: Range check error после выполнения еженедельного обновления
//
// Revision 1.59  2004/07/01 15:39:31  narry
// - update
//
// Revision 1.58  2004/05/19 12:32:16  narry
// - bug fix
// - update
//
// Revision 1.57  2004/05/19 07:03:49  narry
// - update: объединение с основной веткой
//
// Revision 1.47.2.8  2004/05/19 06:53:40  narry
// - prerelease
//
// Revision 1.47.2.7  2004/05/07 12:43:21  narry
// - update
//
// Revision 1.47.2.6  2004/05/05 06:42:14  narry
// - update
//
// Revision 1.47.2.5  2004/04/30 04:13:38  narry
// - update and bug fix
//
// Revision 1.47.2.4  2004/04/28 12:26:53  narry
// - update
//
// Revision 1.53  2004/04/28 09:41:19  narry
// - update
//
// Revision 1.52  2004/04/16 09:11:06  narry
// - bug fix: отключался не тот пользователь, на которого указывало выделение
//
// Revision 1.51  2004/04/07 10:22:20  narry
// - new: возможность отключить конкретного пользователя
//
// Revision 1.50  2004/03/26 11:00:48  narry
// - Обновление, улучшение, задел на будущее
//
// Revision 1.49  2004/02/17 10:53:30  narry
// - update
//
// Revision 1.48  2004/01/30 13:29:16  narry
// - update: повышение отказоустойчивости
//
// Revision 1.47  2004/01/23 11:42:12  narry
// - new: начало реализации "вышибания" "мертвых" пользователей
//
// Revision 1.46  2004/01/21 07:44:44  narry
// - update
//
// Revision 1.45  2004/01/06 10:21:47  narry
// - cleanup
// - new: опциональная поддержка splash при загрузке
//
// Revision 1.44  2003/12/24 09:28:35  narry
// - bug fix: резервное хранилище удалялось перед сравнением
//
// Revision 1.43  2003/12/11 15:08:30  narry
// - update: визуальное отображение и редактирование списка заданий
//
// Revision 1.42  2003/12/02 14:11:39  narry
// - new: компиляция словарей
//
// Revision 1.41  2003/11/24 13:27:53  narry
// - new: автоматическое обнаружение и исправление перекрестных ссылок в переменной части
//
// Revision 1.40  2003/11/19 17:46:57  narry
// - add: автоматическое отключение пользователей
// - add: самостоятельная подготовка дополнительной"дельты"
// - add: обновление статуса действий во время ожидания
//
// Revision 1.39  2003/09/08 10:22:03  narry
// - change: новая версия трубы импорта
//
// Revision 1.38.2.2  2003/09/08 10:19:54  narry
// - update
//
// Revision 1.38.2.1  2003/09/02 15:54:52  narry
// - update: rc1
//
// Revision 1.38  2003/08/26 08:21:41  narry
// - update: отладка автоклассификации и переключения на локальную базу
//
// Revision 1.37  2003/08/01 13:00:54  narry
// - update
//
// Revision 1.36  2003/07/30 09:49:47  narry
// - update: поддержка аварийного останова
//
// Revision 1.35  2003/07/29 09:46:34  narry
// - update: возможность редактировать локальный путь к базе данных
//
// Revision 1.34  2003/07/25 11:07:51  narry
// - update, bug fix etc.
//
// Revision 1.33  2003/07/07 08:53:15  narry
// - bug fix: синтаксис
//
// Revision 1.32.2.3  2003/07/17 16:24:24  narry
// - update: установка имени файла этапов
//
// Revision 1.32.2.2  2003/07/09 07:00:09  narry
// - update
//
// Revision 1.32.2.1  2003/07/07 08:43:30  narry
// - cleanup
//
// Revision 1.32  2003/07/03 09:21:30  narry
// - update: поддержка функции автоклассификации, отказ от использования библиотеки Synapse
// - change: при возникновении Exception обработка очереди заданий прекращается
//
// Revision 1.31  2003/06/25 07:38:44  narry
// - bug fix: не запускалась автоматическая заливка "дельты"
//
// Revision 1.30  2003/06/06 13:08:25  narry
// - new: поддержка автоклассификации
// - bug fix: некорректное удаление заданий из очереди
// - update: использование единой с TddRequestManager структуры для хранения заданий пользователей
//
// Revision 1.29  2003/05/28 12:46:44  narry
// - update
//
// Revision 1.28  2003/04/16 07:25:06  narry
// - bug fix: оставался объект TMailServer
//
// Revision 1.27  2003/04/15 12:49:01  narry
// - bug fix: невозможность отправить письмо с пустой выборкой
//
// Revision 1.26  2003/04/10 13:57:54  narry
// - cleanup
//
// Revision 1.25  2003/04/08 14:20:10  narry
// - update
//
// Revision 1.24  2003/03/21 14:25:17  narry
// - bug fix: слишком длинное сообещние не передавалось пользователю
// - add: контроль попадания всех справок в дельту
//
// Revision 1.23  2003/03/07 12:50:54  narry
// - update
//
// Revision 1.22  2002/12/20 09:03:18  narry
// - update:
//
// Revision 1.21  2002/12/19 13:12:43  narry
// - update
//
// Revision 1.20  2002/11/05 12:04:43  narry
// - update & cleanup
//
// Revision 1.19  2002/11/05 09:11:18  narry
// - update
//
// Revision 1.18  2002/10/31 14:52:16  narry
// - update
//
// Revision 1.17  2002/08/28 13:44:25  narry
// - update
//
// Revision 1.16  2002/08/28 07:41:04  narry
// - new behavior: Отправка сообщения при невозможности запустить ежедневное обновление
//
// Revision 1.15  2002/08/22 13:14:12  narry
// - update and cleanup
//
// Revision 1.14  2002/08/19 12:23:02  narry
// - update
//
// Revision 1.13  2002/07/12 10:05:10  narry
// - bug fix: после перезапуска базы данных не принимались сообщения на экспорт и импорт
//
// Revision 1.12  2002/07/10 08:26:09  narry
// - update & new behavior: поддержка работы обновлений через локальные пути, организация диалога с пользователем
//

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
  Windows,
  alcuTypes, alcuCommands,
  l3Base, l3Types, l3LongintList,
  daInterfaces,
  daTypes,
  dt_Types, dt_Serv,
  ddProgressObj, ddScheduler, alcuBaseEngine,
  ddCalendarEvents, alcuTaskManager, ddAppConfigTypes,
  Classes, {$IFDEF Service}SvcMgr{$ELSE}Forms{$ENDIF}, SysUtils,
  Graphics, ExtCtrls, SyncObjs,
  m4DBInterfaces, alcuMessageDlg, alcuShowMessage,
  csServerCommandsManager, CsDataPipe, csMessageManager, csActiveClients,
  csProcessTask,

  ddServerTask,

  l3ProtoObject,
  alcuBaseEngineHolder
{$IFDEF MDPSyncIntegrated}
  , alcuDictChangeMDPSynchronizator
  , alcuMdpDocImporter
{$ENDIF MDPSyncIntegrated}
  ;


type
 TalcuShutdownMode = (alcu_smUnknown, alcu_smWait, alcu_smTerminate);

 TCheckConfigResult = (alcu_ccrValid, alcu_ccrEdited, alcu_ccrCalcelled, alcu_ccrRefused);

 TalcuServerPrim = class(Tl3ProtoObject, IdaLongProcessSubscriber, IdaUserStatusChangedSubscriber)
 private
    f_Stopped : Boolean;
    f_ShutdownMode: TalcuShutdownMode;
    f_Actions: TcsServerCommandsManager; // список указателей на методы обработки заданий
    f_AnonceDate: TDateTime;
    f_AnoncedTimer: TTimer;
    f_BackupDone: Boolean;
    f_BaseEngineHolder: TalcuBaseEngineHolder;
    f_Busy: Boolean;
    f_CanClose: Boolean;
    f_CheckAtStartup: Boolean; // при старте проверить базу на наличие ошибок
    f_CommentList: TStrings;
    f_CS: TCriticalSection;
    f_CurPath: string; // путь к папке GARANT
    f_DB: Im4DB;
    f_DeltaLogFileName: string;
    f_EnableUndoBackup: Boolean;
    f_Error: TddAutoPipeError;
    f_FileProc: Tl3ProgressProc; // утст.знач.кол-во вып.заданий(в % + текст) на панели [1] статуса главной формы
    {$IFDEF Service}
    f_Service: TService;
    {$ENDIF}
    f_ServerLongProc: TdaOnLongProcessEvent; // для долгих процессов вызов Application.ProcessMessages
    f_ImportList: Tl3LongintList;
    f_LockLog: Boolean; // блок.отображения списка польз.на главной форме
    f_LogMessages: Boolean;
    {$IFNDEF Service}
    f_MainForm: TForm; // указатель на главную форму
    f_OriginalOnException: TExceptionEvent;
    {$ENDIF}
    f_MessageManager: TcsMessageManager;
    f_OldFamilyPath: string;
    f_OnSendSMS: TddSendSMSNotify;
    f_OnStatusChanged: TalcuStatusNotify; // вывод вып.задания на панели [1] статуса главной формы
    f_OnUserListUpdated: TddUserListNotify; // событие изменения статуса пользователя вход/выход
    f_OnYeld: TNotifyEvent; // вызывается прото Application.ProcessMessages
    f_PrevUsers: Tl3LongintList;
    f_Processing: Boolean; // f_Processing = TRUE признак обработки задания
    f_Progressor: TddProgressObject;
    f_RealStopTime: TDateTime;
    f_RefreshTimer: TTimer; // таймер обновления списка заданий сервера
    f_Report: TStrings;
    f_StatusStack: TalcuStatusList;
    f_TaskProcessor: TddServerTaskManager; // управление выполнением задач сервера
    f_TotalProc: Tl3ProgressProc; // утст.знач.кол-во вып.заданий(в % + текст) на панели [0] статуса главной формы
    f_TryCount: Byte;
    f_Updated: Boolean;
{$IFDEF MDPSyncIntegrated}
    f_DictSynchronizator: TalcuDictChangeMDPSynchronizator;
    f_MDPImporter: TalcuMdpDocImporter;
{$ENDIF MDPSyncIntegrated}
    f_UpdateRequestListCounter: Integer;
    f_LastMemoryReport: TDateTime;
    f_AutolinkEnabled: Boolean;
    procedure AppException(Sender: TObject; E: Exception);
    procedure CalculateAnonceDate;
    procedure CheckImagesBase;
    procedure CheckPriority;
    procedure CheckUNCPath;
    procedure ClearOldBackup;
    function CorrectMessageFileName(aFileName: string): string;
    procedure CreateActionList; // создает список указателей на методы обработки заданий сервера
    procedure CreateTaskProcessor; // создает объект f_TaskProcessor
    procedure CSServerEvent(aEventId: Integer; aData: Integer); // событие при входе и выходе польз.(вызывает UserStatusChanged)
    procedure cs_GetAEParamsReply(aPipe: TCsDataPipe);
    procedure cs_GetLogoReply(aPipe: TCsDataPipe);
    procedure cs_ServerStatusReply(aPipe: TCsDataPipe);
    procedure cs_GetServerUser(aPipe: TCsDataPipe);
    procedure cs_GetUsersList(aPipe: TcsDataPipe);
    function WaitForFreeBase(aTimeOut: Integer = 60000): Boolean;
    procedure DestroyActionList; // уничтожает список указателей на методы обработки заданий
    function GetAnnoExportEnabled: Boolean;
    function GetAutoClassEnabled: Boolean;
    function GetCurrentUserName: string; // имя поль-ля чья задача выполняется в текущий момент
    function GetTaskExecutionEnabled: Boolean;
    function GetExportEnabled: Boolean;
    function GetImportEnabled: Boolean;
    function GetStopTime: TDateTime;
    function GetTaskEnabled(const TaskID: ShortString): Boolean;
    function GetUndoRestorePath(const aLast: Boolean = False): string;
    function ImportDocuments: Boolean;
    function ImportKeywords: Boolean;
    function pm_GetBaseDescription: string;
    function pm_GetStatus: TalcuStatus;
    procedure pm_SetLogMessages(const Value: Boolean);
    procedure pm_SetStatus(const Value: TalcuStatus);
    function PrepareKWFile: Boolean;
    procedure ProgressorUpdate(Sender: TObject; aPercent: Integer);
    procedure RegisterReplyProcedures; // рег.проц.обработки ответов на запросы польз.
    procedure RegisterSchedulerTasks;
    procedure RequiredEvent(aNode: TddCustomConfigNode; var Resolved: Boolean);
    procedure ScheduledAutoClassifyTask(const aTask: TddSchedulerTask);
    procedure ScheduledAutoExportTask(const aTask: TddSchedulerTask);
    {$IFDEF AAC}
    procedure ScheduledAutoSubsTask(const aTask: TddSchedulerTask);
    {$ENDIF}
    procedure SchedulerTaskColor(aTaskType: TddCalendarTaskType; out aColor: TColor);
    procedure ScheduledUpdateTask(const aTask: TddSchedulerTask);
    procedure ScheduledDeltaTask(const aTask: TddSchedulerTask);
    procedure ScheduledBirthdayTask(const aTask: TddSchedulerTask);
    procedure ScheduledHolidayTask(const aTask: TddSchedulerTask);
    procedure ScheduledLoadRegionsTask(const aTask: TddSchedulerTask);
    procedure ScheduledPreventiveTask(const aTask: TddSchedulerTask);
    procedure ScheduledUploadRegionsTask(const aTask: TddSchedulerTask);
    procedure SchedulerDefaultTask(const aTask: TddSchedulerTask);
//    procedure SchedulerMakeDivisions(const aTask: TddSchedulerTask); deprecated;
{$IFNDEF RunSchedulerAsTask}
    procedure SchedulerCanRunWithoutRunningTask(const aTask: TddSchedulerTask; var CanRunTask: Boolean);
{$ENDIF RunSchedulerAsTask}
    procedure SendBirthdayGreeting(const UserName: String);
    procedure SchedulerClientNotify(const aTask: TddSchedulerTask);
    procedure SchedulerTaskExecutor(const aTask: TddSchedulerTask);
    procedure sendErrorReport(Missed: TalcuMissedTasks);
    procedure SetAnnoExportEnabled(const Value: Boolean);
    procedure SetAutoClassEnabled(const Value: Boolean);
    procedure SetTaskExecutionEnabled(Value: Boolean);
    procedure SetExportEnabled(const Value: Boolean);
    procedure SetImportEnabled(const Value: Boolean);
    procedure SetRealStopTime(MinDelta : Integer);
    procedure SetStopTime(const Value: TDateTime);
    function FindPublInfoFile: String;
    procedure MakeFolderCopy(const aFromFolder, aToFolder: string);
    procedure MakeOvgaExport;
    procedure ScheduledExportAnonced(const aTask: TddSchedulerTask);
    procedure ScheduledExportAnoncedEx(const aTask: TddSchedulerTask);
    procedure ScheduledAnnoExport(const aTask: TddSchedulerTask);
    procedure ScheduledHavansky(const aTask: TddSchedulerTask);
    procedure ScheduledCloneBase(const aTask: TddSchedulerTask);
    procedure ScheduledRelPublish(const aTask: TddSchedulerTask);
    procedure ScheduledMdpSyncDicts(const aTask: TddSchedulerTask);
    procedure ScheduledMdpSyncDocs(const aTask: TddSchedulerTask);
//    procedure UserStatusChange(UserId : TdaUserID; Active : Boolean); // событие при входе и выходе польз.
    function ValidTime: Boolean;
    procedure _PrepareTimer(Sender: TObject);
    procedure _TaskManagerStatusChange(aStatus: TalcuStatus{; aQueryLen: Integer});
    procedure _TimerEvent(Sender: TObject);
    procedure _AnoncedTimerEvent(Sender: TObject);
    procedure _YeldProcess(Sender: TObject);
    function pm_GetServerHostName: String;
    function pm_GetServerPort: Integer;
    procedure CheckUserLogined(UserID: TdaUserID; var isLogined: Boolean); deprecated;
    function AllowPurgeDir(const aDir: TFileName): Boolean;
    procedure cs_AACNeedTerminate(aPipe: TCSDataPipe);
    procedure cs_GetBaseStatus(aPipe: TCSDataPipe);
    procedure ResetExecutorLog(aMaxSize: Integer; aCompress: Boolean = False);
    procedure DoExecuteCommand(aCommandID: Integer);
    procedure CheckReportMemoryUsage;
    procedure InitAutoLinkEnabled;
    function CreateSchedulerTask(aType: TddCalendarTaskType; out theTask: TddProcessTask; aUserID: TdaUserID = usServerService): Boolean;
    function MakeLoadRegionsTask: TddProcessTask;
    function MakeUpLoadRegionsTask: TddProcessTask;
    function MakeOvgaExportTask: TddProcessTask;
    function MakeAutomaticAnoncedExportTask(anOnThursdayMode: Boolean; aUserID: TdaUserID = usServerService): TddProcessTask;
 protected
    // IdaLongProcessSubscriber
    function DoLongProcessNotify(aState: TdaProcessState): Boolean;
    // IdaUserStatusChangedSubscriber
    procedure UserStatusChanged(UserID: TdaUserID; Active: Boolean);

    procedure Cleanup; override;
    procedure DoYeld;
    // список процедур которые могут выполнять задачи поль-лей
    procedure csAutoLogoff(Sender: TddTaskItem);
    procedure csBuildTextIndex(Sender: TddTaskItem);
    procedure csCheckBases(Sender: TddTaskItem);
    procedure csDoExportPrime(Sender: TddTaskItem);
    procedure csDoAutoClassify(Sender: TddTaskItem);
    procedure csDoAnoncedExport(Sender: TddTaskItem);
    procedure csDoCorrectRel(Sender: TddTaskItem);
    procedure csDoPrepareGarant(Sender: TddTaskItem);
    procedure csDoUpdateGarant(Sender: TddTaskItem);
(*    procedure csGetTaskLine(Sender: TObject);*)
    procedure csEverydayUpdate(Sender: TddTaskItem);
    procedure csLockBase(Sender: TddTaskItem);
    procedure csSendMessage(Sender: TddTaskItem);
    procedure csUnlockBase(Sender: TddTaskItem);
    procedure csUpdateBases(Sender: TddTaskItem);
    procedure csUpdateIndex(Sender: TddTaskItem);
    procedure csUpdateText(Sender: TddTaskItem);
 public
    constructor Create{(aOwner: TObject); override};
    procedure ApplyDictionaryModifyFile(aFileName: String; aManual: Boolean);
    procedure CheckBases(aManual: Boolean);
    function CheckDeltaReady: Boolean;
    procedure CheckFreeSpace(aManual: Boolean = False);
    procedure ChecksSetup; // проверка настроек системы
    function CheckConfigAtStartupCrash: TCheckConfigResult;
    procedure CheckSubTable;
    procedure ClearSafeFolder;
    procedure ClearExportFolders;
{$IFDEF ExchangeDocs}
    procedure ClearDeltasFolders;
{$ENDIF ExchangeDocs}
{$IFDEF AAC}
    procedure ClearAACLogFolder;
{$ENDIF AAC}
    procedure cs_GetAnouncedDate(aPipe: TCSDataPipe);
    procedure DeleteTask(aTask: TddProcessTask);
    procedure DoAutoClassify(aUserID: TdaUserID = usServerService);
    procedure DoAutomaticExport;
    procedure DoAutomaticAnoncedExport(anOnThursdayMode: Boolean; aUserID: TdaUserID = usServerService);
    procedure DoBuildTextIndex;
    function DoEveryDayUpdate(theManual: Boolean = False): TddSchedulerTaskResult;
    function DoEveryWeekUpdate(aManual: Boolean = False): TddDeltaResult;
    procedure DoLoadEQClasses(aFileName: String);
    function DoLoadKW(aIsDelta: Boolean = False): Boolean;
    procedure DoLoadRegions;
    function DoMakeFamilyBackup: Boolean;
    function DoMakeFullBackup(const aDestination: String): Boolean;
    function DoPrepareDelta: Boolean;
    procedure DoPreventiveUpdate(const aManual: Boolean = False);
    function DoUpdate(aLogoffUsers: Boolean): Boolean;
    procedure DoUpdateDictEntryIndex;
    procedure DoUpdateHeaderIndex;
    function DoUpdateIndex(aUpdateText, aUpdateIndex : Boolean): Boolean;
    procedure DoUploadRegions;
(*    procedure Execute;*)
    function ExecuteConfigDialog: Boolean;
    procedure ExportSpecialAnnotation;
    procedure ImportPriorityTable;
    procedure Initialize;
    function IsBaseFree(aLogoffUsers: Boolean): Boolean;
    function IsBaseLocked: Boolean;
    function LoadDeltaFiles: Boolean;
(*    procedure LoadDictChangeFile;*)
    procedure LockBase(const aMsg: String); overload;
    procedure LockBase(const aMsg: String; const aLockTime, aUnlockTime:
            TDateTime); overload;
    procedure LogoffUsers(aManual: Boolean; theUser: IdaArchiUser = nil);
    function MakeAndLoadDelta(aManual: Boolean): TddDeltaResult;
    procedure MakeRelPublishTask;
(*    function Pause: Boolean;*)
    procedure ProcessDelayedTasks;
    procedure ReindexTables;
    function RestartBaseEngine: Boolean;
    procedure SendEmailNotify;
    function SendKWToRegions: Boolean;
    procedure SendMessage(theUser: IdaArchiUser; theMessage: String; theLockBase:
        Boolean; theStartLock, theStopLock: TDateTime);
    function Start: Boolean; // доступ к БД и запуск планеровщика
    function StartBaseEngine: Boolean; // Запуск механизма доступа к БД и прочие
 private
    function Stop: Boolean;
 public
    procedure InitiateShutdownWithWait;
    procedure InitiateShutdownWithAbort;
    function IsShutdowning: Boolean;
    function CanCloseWithWait: Boolean;
    procedure ShutDown;
    procedure StopAndGoQuery(aTask: TddProcessTask);
    function StopBaseEngine(const aPermanent: Boolean = True): Boolean;
    function SwitchToRealBase: Boolean;
    function SwitchToTemporaryBase: Boolean;
    function UndoMakeBackup(const AskUser: Boolean = False): Boolean;
    procedure UndoRestoreBackup;
    procedure UnlockBase;
    {$IFDEF AAC}
    procedure UpdateAAC(const aFolder: String; aManual: Boolean);
    {$EndIF AAC}
    function AACNeedTerminate(aPrevTaskCount: Integer; MaxAllowedClients: Integer = 0): Boolean;
    procedure UpdateAutoLinkCache;
    procedure UpdateRequestLists; // просмотр списка новых заданий от польз.
    procedure UpdateUserList;
    function CopyVersionToBackup: TddSchedulerTaskResult;
    function CopyBackupToVersion: TddSchedulerTaskResult;
    procedure DisableProcessing;
    procedure DoAnnoExport;
    function DoCommitImgCache: Boolean;
    procedure EnableProcessing;
    function IsImgCacheCommitable: Boolean;
    function ProcessingEnabled: Boolean;
    function Scheduler: TddScheduler;
    procedure LockTaskExecution;
    procedure UnlockTaskExecution;
    procedure ReportMemoryUsage;
    property Actions: TcsServerCommandsManager read f_Actions write f_Actions;
    property AnnoExportEnabled: Boolean read GetAnnoExportEnabled write
        SetAnnoExportEnabled;
    property AutoClassEnabled: Boolean read GetAutoClassEnabled write
        SetAutoClassEnabled;
    property BaseDescription: string read pm_GetBaseDescription;
    property CanClose: Boolean read f_CanClose;
    property CheckAtStartup: Boolean read f_CheckAtStartup write f_CheckAtStartup;
    property CurrentUserName: string read GetCurrentUserName; // имя поль-ля чья задача выполняется в текущий момент
    property TaskExecutionEnabled: Boolean read GetTaskExecutionEnabled write
            SetTaskExecutionEnabled;
    property Error: TddAutoPipeError read f_Error write f_Error;
    property ExportEnabled: Boolean read GetExportEnabled write SetExportEnabled;
    property FileProc: Tl3ProgressProc read f_FileProc write f_FileProc;
    {$IFDEF Service}
    property Service: TService read f_Service write f_Service;
    {$ELSE}
    property MainForm: TForm read f_MainForm write f_MainForm;
    {$ENDIF}
    property OnServerLongProc: TdaOnLongProcessEvent read f_ServerLongProc write f_ServerLongProc;
    property ImportEnabled: Boolean read GetImportEnabled write SetImportEnabled;
    property LogMessages: Boolean read f_LogMessages write pm_SetLogMessages;
    property Progressor: TddProgressObject read f_Progressor;
    property Status: TalcuStatus read pm_GetStatus write pm_SetStatus;
    property StopTime: TDateTime read GetStopTime write SetStopTime;
    property TaskEnabled[const TaskID: ShortString]: Boolean read
            GetTaskEnabled;
    property TaskProcessor: TddServerTaskManager read f_TaskProcessor;
    property ServerHostName: String read pm_GetServerHostName;
    property ServerPort: Integer read pm_GetServerPort;
    property TotalProc: Tl3ProgressProc read f_TotalProc write f_TotalProc;
    property OnSendSMS: TddSendSMSNotify read f_OnSendSMS write f_OnSendSMS;
    property OnStatusChanged: TalcuStatusNotify read f_OnStatusChanged write
        f_OnStatusChanged;
    property OnUserListUpdated: TddUserListNotify read f_OnUserListUpdated
            write f_OnUserListUpdated;
    property OnYeld: TNotifyEvent read f_OnYeld write f_OnYeld;
(*    property MessageManager: TcsMessageManager read f_MessageManager;*)
  end;


implementation

uses
  TypInfo,
  l3MemoryUtils,
  daDataProvider,
  daProgressProcHolder,
  daSchemeConsts,
  dt_Const, dt_AttrSchema, dt_ImpExpTypes, dt_IFltr, dt_Doc, dt_Mail, dt_DocImages, dt_Query, dt_SrchQueries,
  ht_Const, ht_Dll, dt_Dict,  dt_Prior, dt_Sab,
  {GarDocBridge,}  Base_Cfg, m3DB,
  ddConst, ddUtils, ddProgressTypes, ddKW_r,
  ddUNC2Local, alcuUtils, alcuMailServer, ddAppConfig, ddImportPipe, ddAutolinkServer,
  alcuConfig, alcuEmailMessage, alcuRegionImportTask, alcuSchedulerProxyTask,
  {$IFDEF Courts}
  alcuCourtDecision,
  {$ENDIF}
  alcuStrings,
  IdFTP, IdFTPCommon,
  stDateSt, stFileOp, StStrS, l3Date, l3Utils,
  l3IniFile, dt_IndexSupport, m3BackupTools,
  l3ExceptionsLog, m4DB, m3StorageInterfaces,
  l3FileUtils, l3Stream, l3Bits,
  {$IFDEF Synapse}
  SynaChar, MimeInLn,
  {$ENDIF}
  ShellAPI, Messages, {$IFNDef Service}alcuMsgDlg, Dialogs,{$ENDIF} DateUtils, Types, Controls, Math, IdWinSock2,
  l3DatLst, StrUtils,
  CsQueryTypes, CSEventsProcessor, CsServer, CSCommon, csNotifier, csNotification, csConst,
  l3ShellUtils, ddAppConfigDataAdapters, alcuRegionAutoExportTask, ddProcessDlg, dt_DictModifier,
  dt_DictSup, dt_DictImport, dt_DictConst, alcuAutoClassifier,
  {$IFDEF AAC}alcuCourtDecisionSubChecker, csCourtDecisionSabCheckerParams, {$ENDIF}
  csServerTaskTypes, alcuExport, {alcuSectionMaker,}
  alcuBackup, alcuZipUtils, csCommandsConst,
  csCommandsTypes,
  ncsDataAccessServices, htDataProviderParams,
  daDataProviderSuperFactory,
  alcuAutolinkUpdater,
  alcuFTPUtils,
  {$IFDEF AutoSP}alcuRelCorrector,{$ENDIF}
  {$IFDEF HavanskyExport}alcuHavanskyExportTask,{$ENDIF}
  dtSubTableMiscUpdate, m3Endings,
  alcuImport, ddFileIterator, csImport,
  csNetSupport, l3Memory, ddMailTools, ddAutolinkCache, alcuAnoncedExport,
  alcuAutoExportTask, alcuContainerTask, csTasksHelpers, 

{$IFDEF AAC}
  alcuAACImport,
{$ENDIF AAC}
{$IFDEF Prime}
  alcuAnnotationTask,
{$ENDIF Prime}
  alcuAutoAnnoExportTask,

  alcuServerTaskManagerFactory,
  alcuTaskListBase,

  csReplyProcedures,
  csClientInfo,
  m3StorageHolderList
{$IFDEF MDPSyncIntegrated}
  , alcuMdpSyncStages
  , alcuMdpSyncImport
{$ENDIF MDPSyncIntegrated}
  , csTaskTypes;

const
 cExternalDeltaMaxAge = 31;

function _CheckDir(aDir: String): String;
begin
 if ExtractFileDrive(aDir) = '' then
  Result:= ConcatDirName(ExtractFileDir(ParamStr(0)), aDir)
 else
  Result:= aDir;
end;

{
****************************** TddAutoPipeServer *******************************
}
constructor TalcuServerPrim.Create{(aOwner: TObject)};
var
 l_Ok: Boolean;
begin
  inherited;
  TncsDataAccessServices.Instance.InitServer;
  f_BaseEngineHolder := TalcuBaseEngineHolder.Create;
  f_Stopped := false;
  f_CS:= TCriticalSection.Create;
  f_PrevUsers:= Tl3LongintList.Create;
  InitAutoLinkEnabled;
  CreateConfig(f_AutolinkEnabled);
  ddAppConfiguration.OnRequiredEvent:= RequiredEvent;
  CreateActionList;
  with ddAppConfiguration do
   ResetSelfLog(AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
  f_Progressor:= TddProgressObject.Create(nil);
  f_Progressor.OnUpdate:= ProgressorUpdate;
  CreateTaskProcessor;
  f_MessageManager := TcsMessageManager.Create({nil, }CorrectMessageFileName(ddAppConfiguration.AsString['MessagesFilename']));
  f_Report:= TStringList.Create;
  f_CanClose:= True;
  f_ShutdownMode:= alcu_smUnknown;
  f_StatusStack:= TalcuStatusList.Create;
  Status:= dd_apsIdle;
  f_ServerLongProc := nil;
  f_FileProc   := nil;
  f_TotalProc  := nil;
  {$IFNDEF Service}
  f_OriginalOnException:= Application.OnException;
  Application.OnException:= AppException;
  {$ENDIF}
  f_BackupDone := False;
  RegisterSchedulerTasks;
  f_RefreshTimer := TTimer.Create(nil);
  f_RefreshTimer.Interval := 2500;
  f_RefreshTimer.OnTimer := _TimerEvent;
  f_RefreshTimer.Enabled := False;
  CheckAtStartup:= False;
  l3System.MessageLevel:= ddAppConfiguration.AsInteger['l3LogLevel'];
  alcuMail.CheckInterval := ddAppConfiguration.AsInteger['POPInterval'];
  {$IFDEF SubDeletedNotify}
  DictChangeFileName:= ddAppConfiguration.AsString['DictUpdateFileName'];
  {$ENDIF}
{$IFDEF MDPSyncIntegrated}                                                                  
 f_DictSynchronizator := TalcuDictChangeMDPSynchronizator.Create;
 f_MDPImporter := TalcuMdpDocImporter.Create;
{$ENDIF MDPSyncIntegrated}
 f_AnoncedTimer := TTimer.Create(nil);
 f_AnoncedTimer.OnTimer:= _AnoncedTimerEvent;
 f_AnoncedTimer.Enabled := False;
 f_LastMemoryReport := 0;
end;

procedure TalcuServerPrim.MakeOvgaExport;
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctCloneBase, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TalcuServerPrim.AppException(Sender: TObject; E: Exception);
begin
  alcuUtils.Exception2Log(E, Status);
  //AbortProcess:= True; Иначе останавливается обработка других типов задач... Может быть и правильно?
  //Status:= dd_apsRevert; // ?
end;

procedure TalcuServerPrim.ApplyDictionaryModifyFile(aFileName: String; aManual: Boolean);
begin
 try
  TaskProcessor.LockProcessing;
  try
   DisableProcessing;
   try
    gApplyDictModifyFile(aFileName);
   finally
    EnableProcessing;
   end;
  finally
   TaskProcessor.UnLockProcessing;
  end;
 except
  on E: Exception do
  begin
   l3System.Msg2log(E.Message);
   {$IFNDEF Service}
   if aManual then
    alcuShowMsg('Во время внесения изменений в словари произошла ошибка.'^M+E.Message);
   {$ENDIF}
  end;
 end;
end;

 type
  TAnnoSwitchRec = record
   rAnnoDayOfWeek : word;
   rSwitchTime : TDateTime;
   rNextSwitchDayOfWeek : word;
  end;

 const
  cNoSwitchTime = 1;

 var
  gAnnoSwitchData : array[DayMonday .. DaySunday] of TAnnoSwitchRec;


  (* наше
 с 13.56 четверга по 16.45 пятницы, дата ставится равной воскресенью текущей недели
 с 16.45 пятницы по 16.14 понедельника, дата ставится равной понедельнику
 с 16.15 понедельника по 16.14 вторника, дата ставится равной вторнику
 с 16.15 вторника по 16.14 среды, дата ставится равной среде
 с 16.15 среды по 13.55 четверга, дата ставится равной четвергу
  *)

 (* Region
 Этап закрыт с 10.00 четверга по 15.50 пятницы, дата ставится равной воскресенью текущей недели
 Этап закрыт с 15.51 пятницы по 15.20 понедельника, дата ставится равной понедельнику
 Этап закрыт с 15.21 понедельника по 15.20 вторника, дата ставится равной вторнику
 Этап закрыт с 15.21 вторника по 15.20 среды, дата ставится равной среде
 Этап закрыт с 15.21 среды по 9.59 четверга, дата ставится равной четвергу
 *)


 procedure MakeAnnoSwitchData;
 begin
  {пн}
  with gAnnoSwitchData[DayMonday] do
  begin
   rAnnoDayOfWeek := DayTuesday;
   rSwitchTime    := {$IfNDef Region} EncodeTime(16,15,0,0);  {$else} EncodeTime(15,20,0,0); {$EndIf Region}
   rNextSwitchDayOfWeek := DayTuesday;
  end;

  {вт}
  with gAnnoSwitchData[DayTuesday] do
  begin
   rAnnoDayOfWeek := DayWednesday;
   rSwitchTime    := {$IfNDef Region} EncodeTime(16,15,0,0);  {$else} EncodeTime(15,20,0,0); {$EndIf Region}
   rNextSwitchDayOfWeek := DayWednesday;
  end;

  {ср}
  with gAnnoSwitchData[DayWednesday] do
  begin
   rAnnoDayOfWeek := DayThursday;
   rSwitchTime    := {$IfNDef Region} EncodeTime(16,15,0,0);  {$else} EncodeTime(15,20,0,0); {$EndIf Region}
   rNextSwitchDayOfWeek := DayThursday;
  end;

  {чт}
  with gAnnoSwitchData[DayThursday] do
  begin
   rAnnoDayOfWeek := DaySunday;
   rSwitchTime    := {$IfNDef Region} EncodeTime(13,55,0,0);  {$else} EncodeTime(10,00,0,0); {$EndIf Region}
   rNextSwitchDayOfWeek := DayFriday;
  end;

  {пт}
  with gAnnoSwitchData[DayFriday] do
  begin
   rAnnoDayOfWeek := DayMonday;
   rSwitchTime    := {$IfNDef Region} EncodeTime(16,45,0,0);  {$else} EncodeTime(15,50,0,0); {$EndIf Region}
   rNextSwitchDayOfWeek := DayMonday;
  end;

  {сб}
  with gAnnoSwitchData[DaySaturday] do
  begin
   rAnnoDayOfWeek := DayMonday;
   rSwitchTime    := cNoSwitchTime;
   rNextSwitchDayOfWeek := DayMonday;
  end;

  {вс}
  with gAnnoSwitchData[DaySunday] do
  begin
   rAnnoDayOfWeek := DayMonday;
   rSwitchTime    := cNoSwitchTime;
   rNextSwitchDayOfWeek := DayMonday;
  end;
 end;

procedure TalcuServerPrim.CalculateAnonceDate;
var
 l_Interval: Int64;
 l_Today: TDateTime;
 l_Time: TDateTime;
 l_NextCheckDate: TDateTime;
 l_SaveAnonceDate: TDateTime;
 l_DayOfWeekToday : word;
 l_DayOfWeekPred : word;
begin
 l_SaveAnonceDate := f_AnonceDate;

 if ddAppConfiguration.AsInteger['anonDate'] = 0 then
 begin
  l_Today:= SysUtils.Date;
  l_DayOfWeekToday := DayOfTheWeek(l_Today);
  l_Time := Time;

  if (gAnnoSwitchData[l_DayOfWeekToday].rSwitchTime <> cNoSwitchTime) and
     (gAnnoSwitchData[l_DayOfWeekToday].rSwitchTime > l_Time) then // rAnnoDayOfWeek смотрим по предыдущему дню
  begin
   l_DayOfWeekPred := 1 + (5 + l_DayOfWeekToday) mod 7;
   f_AnonceDate := GetNearestDay(l_Today, gAnnoSwitchData[l_DayOfWeekPred].rAnnoDayOfWeek);
   l_NextCheckDate := GetNearestDay(l_Today, gAnnoSwitchData[l_DayOfWeekPred].rNextSwitchDayOfWeek) +
                      gAnnoSwitchData[gAnnoSwitchData[l_DayOfWeekPred].rNextSwitchDayOfWeek].rSwitchTime;
  end
  else
  begin
   f_AnonceDate := GetNearestDay(l_Today, gAnnoSwitchData[l_DayOfWeekToday].rAnnoDayOfWeek);
   l_NextCheckDate := GetNearestDay(l_Today, gAnnoSwitchData[l_DayOfWeekToday].rNextSwitchDayOfWeek) +
                                             gAnnoSwitchData[gAnnoSwitchData[l_DayOfWeekToday].rNextSwitchDayOfWeek].rSwitchTime;
  end;

  l3System.Msg2Log('Set AnnoDate to %s', [Datetimetostr(f_AnonceDate)]);
  l3System.Msg2Log('NextCheckDate is %s', [Datetimetostr(l_NextCheckDate)]);

  l_Interval := MilliSecondsBetween(Now, l_NextCheckDate);
  if l_Interval < High(Cardinal) then  // таймер на ~50 суток выставлять не будем
  begin
   f_AnoncedTimer.Interval:= Cardinal(l_Interval);
   f_AnoncedTimer.Enabled:= True;
  end;
 end
 else
 begin
  f_AnoncedTimer.Enabled:= False;
  f_AnonceDate:= ddAppConfiguration.AsDateTime['anonCustomDate'];
 end;
 if not SameDate(l_SaveAnonceDate, f_AnonceDate) then
  f_MessageManager.SendNotify(c_AllClients, ntAnouncedDateChanged, 0, 'Обновление даты анонсирования');
end;

procedure TalcuServerPrim.CheckBases(aManual: Boolean);
var
 l_ErrorFoundMain: Boolean;
 l_Msg: String;
 l_MsgMain: String;
 l_ErrorFoundGarant: Boolean;
 l_MsgGarant: String;
 l_Dlg: TddProcessDialog;
 l_i: Integer;
 l_Ok: Boolean;

 procedure _ds;
 begin
  if l_Dlg <> nil then
   l_Dlg.Start;
 end;
 procedure _du;
 begin
  if l_Dlg <> nil then
   l_Dlg.Update;
 end;
 procedure _df(aError: Boolean = False; const aMsg: String = '');
 begin
  if l_Dlg <> nil then
   l_Dlg.Finish(aError, aMsg);
 end;
 procedure _da(aAll: Boolean);
 begin
  if l_Dlg <> nil then
   l_Dlg.Abort(aAll);
 end;

var
 l_Progress: IdaProgressSubscriber;
 
begin
 l3System.Msg2Log('Проверка таблиц базы данных');
  {$IFNDEF Service}
  if Application.MainForm = nil then
  begin
   l_Dlg:= MakeProcessDialog('Проверка базы данных',
             NewProcess('Закрытие открытых таблиц', 2,
             NewProcess('Захват базы данных', -1,
             NewProcess('Проверка Административной базы', -1,
             NewProcess('Проверка Базы документов', -1,
             NewProcess('Открытие таблиц', -1, nil))))));
   l_Progress := TdaProgressProcHolder.Make(l_Dlg.ProgressProc);
  end
  else
  {$ENDIF}
  begin
   l_Progress := TdaProgressProcHolder.Make(f_Progressor.ProcessUpdate);
   l_Dlg:= nil;
  end;
  try
   GlobalDataProvider.SubscribeProgress(l_Progress);
   try
    with GlobalHTServer do
    begin
     _ds;
     CloseAllTbls(0);
     _du;
     CloseAllTbls(1);
     _df;
     _ds;
     l_Ok:= IsBaseFree(True);
     _df(not l_Ok);
     if l_Ok then
     try
      l_i:= 0;
      GLobalHtServer.PhisicalVerifyAllTbl(0, l_ErrorFoundMain, l_MsgMain);
      Inc(l_i);
      GLobalHtServer.PhisicalVerifyAllTbl(1, l_ErrorFoundGarant, l_MsgGarant);
      Inc(l_i);
     except
      on E: Exception do
      begin
       l3System.Exception2Log(E);
       l_ErrorFoundMain:= True;
       l_MsgMain:= 'Не удалось проверить базу данных. Возможно, с базой работают пользователи.';
       l_MsgGarant:= '';
       while l_i <> 2 do
       begin
        _da(False);
        Inc(l_i);
       end;
      end; // on E
     end // try..except
     else
     begin
      _da(False);
      _da(False);
     end;
     _ds;
     OpenClosedTbls;
     _df(False, l_MsgMain + ' ' + l_MsgGarant);

     if (l_Dlg = nil) then
     begin
      if (l_ErrorFoundMain or l_ErrorFoundGarant) then
       {$IFDEF Service}
       l3System.Msg2Log(l_MsgMain + ' ' + l_MsgGarant)
       {$ELSE}
       alcuMsgDialog(l_MsgMain + ' ' + l_MsgGarant, mtError, [mbOk], 0)
      else
      if aManual then
       alcuMsgDialog('Проверка завершена. Ошибки не найдены.', mtInformation, [mbOk], 0)
       {$ENDIF}
     end;
     l3Free(l_Dlg);
    end; // with GlobalHTServer
   finally
    GlobalDataProvider.UnSubscribeProgress(l_Progress);
   end;
  finally
   l_Progress := nil;
  end;
 l3System.Msg2Log('Проверка таблиц базы данных завершена');
end;

function TalcuServerPrim.CheckDeltaReady: Boolean;
begin
 if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_CheckLogFile] then
  Result:= alcuMail.IsDeltaReady(f_DeltaLogFileName)
 else
  Result := False;
end;

procedure TalcuServerPrim.CheckFreeSpace(aManual: Boolean = False);
var
 l_DiskDrive, l_Msg: String;
 l_DiskFree, l_Delta,
 l_BaseSize: Int64;
 {$IFNDEF Service}
 l_DlgType: TMsgDlgType;
 {$ENDIF}
begin
 l_DiskDrive:= ExtractFileDrive(ddAppConfiguration.AsString[SalcuAutoPipeServer_LocalBasePath]);
 if l_DiskDrive <> '' then
  l_DiskFree:= DiskFree(Ord(Upcase(l_DiskDrive[1]))-32)
 else
  l_DiskFree:= -1;
 if l_DiskFree <> -1 then
 begin
  l_BaseSize:= GetFolderSize(ddAppConfiguration.AsString['UNCBasePath']);
  l_Delta:= l_DiskFree - (l_BaseSize * ddAppConfiguration.AsInteger[SalcuAutoPipeServer_FreeSpaceLimit]);
  l_Msg:= SysUtils.Format(rsNotEnoughSpace, [Bytes2Str(l_DiskFree)]);
  if l_Delta < 0 then
  begin
   {$IFNDEF Service}
   l_DlgType:= mtWarning;
   {$ENDIF}
   l_Msg:= SysUtils.Format(SalcuAutoPipeServer_prevysheniepredelanaMbayt, [l_Msg, Bytes2Str(Abs(l_Delta))]);
   alcuMail.SendEmailNotify(eventLimitReached, True, l_Msg, Status);
  end
  else
  begin
   {$IFNDEF Service}
   l_DlgType:= mtInformation;
   {$ENDIF}
   l_Msg:= SysUtils.Format(SalcuAutoPipeServer_doprevysheniepredelaostalos_Mbay, [l_Msg, Bytes2Str(Abs(l_Delta))]);
  end;
 end
 else
 begin
  l_Msg:= SalcuAutoPipeServer_Neudalos_opredelit_svobodnoemest+
          SalcuAutoPipeServer_Prover_teparametrLokal_nyyput_kb;
  l3System.Msg2Log(l_Msg);
  {$IFNDEF Service}
  l_DlgType:= mtError;
  {$ENDIF}
 end;
 {$IFNDEF Service}
 if aManual then
  alcuMsgDialog(l_Msg, l_DlgType, [mbOk], 0);
 {$ENDIF}
end;

procedure TalcuServerPrim.CheckImagesBase;
var
 l_ImageBase, l_S,
 l_FileName, l_CmdFilename: String;
 l_Res : Integer;
 l_File : TFileStream;
begin
 {$IFNDEF Service}
 l3System.Msg2Log('Создание списка файлов базы графических образов');
 try
  l_ImageBase := ddAppConfiguration.AsString['ImageStoragePath'];
  if l_ImageBase <> '' then
  begin
   l_CmdFileName := ConcatDirName(ExtractFileDir(Application.ExeName), SalcuAutoPipeServer_ImageBaseListCmd);
   DeleteFile(l_CMDFileName);
   l_File := TFileStream.Create(l_CmdFileName, fmCreate);
   try
    l_FileName := ChangeFileExt(ConcatDirName(l_ImageBase, FormatDateTime('yyyy-mm-dd', SysUtils.Date)), '.lst');
    l_S := SalcuAutoPipeServer_Dir + ConcatDirName(l_ImageBase, '*.*')+SalcuAutoPipeServer_BS+ l_FileName;
    l_File.Write(l_S[1], Length(l_S));
   finally
    l_File.Free;
   end;
   l_Res := FileExecute{Wait}(l_CmdFileName, '', '', esHidden);
  end // l_ImageBase <> ''
  else
   l3System.Msg2Log('Не задана папка для хранения графических образов');
 except
  on E : Exception do
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Oshibkasozdaniyafaylasspiskomgra);
   l3System.Exception2Log(E);
  end; // On E
 end;
 l3System.Msg2Log('Создание списка файлов базы графических образов завершено');
 {$ENDIF}
end;

procedure TalcuServerPrim.CheckPriority;
begin
 l3System.Msg2Log(SalcuAutoPipeServer_Rasetvazhnostidokumentov);
 DocumentServer.Family:= 1;
 DocumentServer.CheckDocPriority(True, f_Progressor.ProcessUpdate);
 DocumentServer.Update;
 l3System.Msg2Log(SalcuAutoPipeServer_Rasetvazhnostidokumentovzakonen);
end;

procedure TalcuServerPrim.ChecksSetup;
var
 l_Ok: Boolean;
begin
 f_Processing:= False;
 {$IFNDEF Service}
 if f_TaskProcessor.ActiveTaskListCount > 0 then
 { TODO 1 -oДмитрий Дудко -cнедоделка : С какого перепуга вызывается окно?!!! }
  TaskExecutionEnabled := alcuMsgDialog(SalcuAutoPipeServer_Naydenyzadaniyaostavshiesyaspros,
                                       mtConfirmation, [mbYes, mbNo], 0) = mrYes;
 {$ELSE}
 TaskExecutionEnabled := True;
 {$ENDIF}
  l_Ok:= True;
  while (not ddAppConfiguration.IsValid) and l_Ok do
  begin
   if l_Ok then
   {$IFDEF Service}
   begin
    l3System.Msg2Log(ddAppconfiguration.RequiredMessage);
    l_Ok:= True;
    break;
    { TODO : нужно как-то сигнализировать об этом! }
   end
   {$ELSE}
    if alcuMsgDialog(ddAppconfiguration.RequiredMessage +'. Хотите задать сейчас?', mtError, [mbYes, mbNo], 0) = mrYes then
     l_Ok:= ddAppConfiguration.ShowDialog('Необходимо задать ключевые параметры', True)
   {$ENDIF}
    else
    begin
     l_Ok := False;
     break;
    end
  end;
  {$IFNDEF Service}
  if not l_Ok then
   Application.Terminate;
  {$ENDIF}
 f_TaskProcessor.SignalServerStarted;
end;

procedure TalcuServerPrim.CheckSubTable;
begin
 AddKeyToSubTable(f_BaseEngineHolder.BaseEngine.DataParams.DocStoragePath);
end;

procedure TalcuServerPrim.CheckUNCPath;
begin
 with ddAppConfiguration do
 begin
  {$IFNDEF Service}
  if AsBoolean[SalcuAutoPipeServer_IsLocalBase] then
    if alcuMsgDialog(SalcuAutoPipeServer_Programmanastroenanarabotuslokal, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  {$ENDIF}
    begin
     AsBoolean[SalcuAutoPipeServer_IsLocalBase] := False;
     Save;
    end;
 end; // with ddAppConfiguration
end;

procedure TalcuServerPrim.ShutDown;
begin
 if f_TaskProcessor = nil then
   Exit;
 DestroyActionList;
 if (f_TaskProcessor <> nil) then
   f_TaskProcessor.FreezeQueryQueue(True);
 {$IFNDEF Service}
 Application.OnException:= f_OriginalOnException;
 {$ENDIF}
 if Assigned(f_BaseEngineHolder.BaseEngine) then
  f_BaseEngineHolder.BaseEngine.CSServer.DropReplyProcedures;
// FreeAndNil(alcuRegions);
 f_TaskProcessor.SignalServerStopping;
 FreeAndNil(f_TaskProcessor);
 FreeAndNil(f_MessageManager);
 FreeAndNil(f_StatusStack);
 FreeAndNil(f_Report);
 FreeAndNil(f_Progressor);
 FreeAndNil(f_PrevUsers);
 Stop;
 f_Stopped := true;
 FreeAndNil(f_AnoncedTimer);
 FreeAndNil(f_RefreshTimer);
 DestroyConfig;
 FreeAndNil(f_CS);
 FreeDictServer;
end;

procedure TalcuServerPrim.Cleanup;
begin
 ShutDown;
 FreeAndNil(f_BaseEngineHolder);
{$IFDEF MDPSyncIntegrated}
 FreeAndNil(f_DictSynchronizator);
 FreeAndNil(f_MDPImporter);
{$ENDIF MDPSyncIntegrated}
 inherited;
end;

procedure TalcuServerPrim.ClearExportFolders;
 procedure _ProcessOneExportFolder(const aFolder : AnsiString);
 var
  l_SR: TSearchRec;
 begin
  if FindFirst(ConcatDirName(aFolder, '*.*'), faDirectory, l_SR) = 0 then
  begin
   repeat
    if l_SR.Name[1] <> '.' then
    begin
     if DaysBetween(Now, FileDateToDateTime(l_SR.Time)) > ddAppConfiguration.AsInteger[SalcuAutoPipeServer_MaxExportAge] then
     begin
      if AllowPurgeDir(ConcatDirName(aFolder, l_SR.Name)) then
       DelDir(ConcatDirName(aFolder, l_SR.Name))
      else
       l3System.Msg2Log('Не удалось очистить папку - она совпадает с папкой сервера');
     end;
    end;
   until FindNext(l_SR) <> 0;
   FindClose(l_SR);
  end;
 end; // _ProcessOneExportFolder

 procedure _ProcessOneUserFolder(const aUserFolder: AnsiString);
 var
  l_Folder: AnsiString;
 begin
  l_Folder := ConcatDirName(aUserFolder, SalcuAutoPipeServer_Export);
  _ProcessOneExportFolder(l_Folder);
  // из-за ошибки создаются вложенные папки Export, их тоже надо почистить
  l_Folder := ConcatDirName(l_Folder, SalcuAutoPipeServer_Export);
  _ProcessOneExportFolder(l_Folder);
 end;

var
 l_SR: TSearchRec;
 l_HomeFolder : String;
begin
 l3System.Msg2Log(SalcuAutoPipeServer_PurgingExportsFolder);

 l_HomeFolder := GlobalDataProvider.GlobalHomePath;
 if FindFirst(ConcatDirName(l_HomeFolder, SalcuAutoPipeServer_Usr), faDirectory, l_SR) = 0 then
 begin
  repeat
   if l_SR.Name[1] <> '.' then
    _ProcessOneUserFolder(ConcatDirName(l_HomeFolder, l_SR.Name));
  until FindNext(l_SR) <> 0;
  FindClose(l_SR);
 end; // FindFirst

 l3System.Msg2Log(SalcuAutoPipeServer_PurgingExportsFolderComplete);
end;

procedure TalcuServerPrim.ClearOldBackup;
var
 l_dir: string;
 l_FileIterator: TddFileIterator;
 i: Integer;
begin
 l3System.Msg2Log(SalcuAutoPipeServer_Udaleniestaryhrezervnyhkopiy);
 with ddAppConfiguration do
 begin
  l_FileIterator:= TddFileIterator.MakeFolders(AsString[SalcuAutoPipeServer_BackupRoot], '????-??-??*', f_Progressor.ProcessUpdate);
  try
   if l_FileIterator.Count > AsInteger[SalcuAutoPipeServer_BackupCount] then
   begin
    for i:= 0 to l_FileIterator.Count-AsInteger[SalcuAutoPipeServer_BackupCount] do
    begin
     l_Dir:= l_FileIterator.FileList[i];
     l3System.Msg2Log(SalcuAutoPipeServer_Udalenie + l_Dir);
     if AllowPurgeDir(l_Dir) then
      DelDir(l_Dir)
     else
      l3System.Msg2Log('Не удалось очистить папку - она совпадает с папкой сервера');
    end; // for i
   end;
  finally
   FreeAndnil(l_FileIterator);
  end;
  // удаление индексных файлов для экономии места
  DeleteFilesByMaskRecur(AsString[SalcuAutoPipeServer_BackupRoot], SalcuAutoPipeServer_Idx);
 end; // with ddAppConfiguration
end;

procedure TalcuServerPrim.ClearSafeFolder;
var
 l_Days: Integer;
 l_SafeDir: AnsiString;
begin
 with ddAppConfiguration do
 begin
  l_SafeDir := AsString[SalcuAutoPipeServer_SafeDirName];
  if l_SafeDir <> '' then
  try
   l_Days := AsInteger[SalcuAutoPipeServer_MaxImportAge];
   if AllowPurgeDir(l_SafeDir) then
     PureDirAged(l_SafeDir, l_Days, True)
   else
     l3System.Msg2Log('Не удалось очистить папку импортированных данных - она совпадает с папкой сервера')
  except
   l3System.Msg2Log('Не удалось очистить папку импортированных данных')
  end;
 end;
end;

function TalcuServerPrim.CorrectMessageFileName(aFileName: string): string;
begin
 Result := ConcatDirName(SafeValidFolder(ExtractFilePath(aFileName)), ExtractFileName(aFileName));
end;

procedure TalcuServerPrim.CreateActionList;
begin
 f_Actions:= TcsServerCommandsManager.Create{(nil)};
 // Заполнить его действиями
 with f_Actions do
 begin
  AddCommand(acmdCheckTables, c_CommandNames[acmdCheckTables], csCheckBases);
  AddCommand(acmdUpdateTables, c_CommandNames[acmdUpdateTables], csUpdateBases);
  AddCommand(acmdLockBase, c_CommandNames[acmdLockBase], csLockBase);
  AddCommand(acmdUnlockBase, c_CommandNames[acmdUnlockBase], csUnlockBase);
  AddCommand(acmdSendMessage, c_CommandNames[acmdSendMessage], csSendMessage);
  AddCommand(acmdAutoLogoff, c_CommandNames[acmdAutoLogoff], csAutoLogoff);
  AddCommand(acmdUpdateText, c_CommandNames[acmdUpdateText], csUpdateText);
  AddCommand(acmdDoEverydayUpdate, c_CommandNames[acmdDoEverydayUpdate], csEverydayUpdate);
  (*  AddCommand(acmdStopAndGoAll, c_CommandNames[acmdStopAndGoAll], );
  AddCommand(acmdDeleteTask, c_CommandNames[acmdDelettask], );
  AddCommand(acmdConfig, c_CommandNames[acmdConfig], );
  AddCommand(acmdLogMessages, c_CommandNames[acmdLogMessages], );

*)
  //AddCommand(acmdBuildTextIndex, c_CommandNames[acmdBuildTextIndex], csBuildTextIndex);
  AddCommand(acmdUpdateIndex, c_CommandNames[acmdUpdateIndex], csUpdateIndex);
  AddCommand(acmdBuildTextIndex, c_CommandNames[acmdBuildTextIndex], csBuildTextIndex);
  // Произвольные (в качестве идентификатора используется порядковый номер)

  {$IF Defined(LUK) or Defined(SGC)}
  AddCommand('Подготовить базу', true, csDoPrepareGarant, True);
  AddCommand('Обновить базу', true, csDoUpdateGarant, True);
  {$ELSE}
  AddCommand('Выполнить Автоэкспорт', true, csDoPrepareGarant, True);
  {$IFEND}
  {$IFDEF Prime}
  AddCommand('Экспортировать Прайм', true, csDoExportPrime);
  {$ENDIF}
  {$IFDEF AutoClass}
  AddCommand('Выполнить Автоклассификацию', true, csDoAutoClassify);
  {$ENDIF}
  //AddCommand('Получить очередь заданий...', false, csGetTaskLine); // Не всплывает окно
  {$IFDEF AutoSP}
  AddCommand('Дополнить справки', true, csDoCorrectRel);
  {$ENDIF}
  {$IFDEF AnoncedExport}
  AddCommand('Экспорт Анонсированных', true, csDoAnoncedExport);
  {$ENDIF}
 end;
 f_Actions.OnExecuteServerCommand := DoExecuteCommand;
end;

procedure TalcuServerPrim.CreateTaskProcessor;
begin
 f_TaskProcessor := TalcuServerTaskManagerFactory.Make(ddAppConfiguration.AsString['RootTaskFolder'], f_BaseEngineHolder);
 f_TaskProcessor.EnabledTaskTypes := alcuAllTaskTypes;
 f_TaskProcessor.Progressor := f_Progressor;
 f_TaskProcessor.Actions:= f_Actions;
 f_TaskProcessor.OnSendEmail := alcuMail.SendEmail;
 f_TaskProcessor.OnStatusChanged := _TaskManagerStatusChange;
 {$IFNDEF Service}
 f_TaskProcessor.OnException := AppException;
 {$ENDIF}
 f_TaskProcessor.UpdatePeriod := ddAppConfiguration.AsInteger['UpdateInterval'];
end;

procedure TalcuServerPrim.csAutoLogoff(Sender: TddTaskItem);
begin
 LogoffUsers(False);
end;

procedure TalcuServerPrim.csBuildTextIndex(Sender: TddTaskItem);
begin
 DoBuildTextIndex;
end;

procedure TalcuServerPrim.csCheckBases(Sender: TddTaskItem);
begin
 CheckBases(False);
end;

procedure TalcuServerPrim.csDoExportPrime(Sender: TddTaskItem);
begin
 ExportSpecialAnnotation;
end;

procedure TalcuServerPrim.csDoAutoClassify(Sender: TddTaskItem);
begin
 DoAutoClassify(sender.UserID)
end;

procedure TalcuServerPrim.csDoAnoncedExport(Sender: TddTaskItem);
begin
 DoAutomaticAnoncedExport(False, sender.UserID);
end;

procedure TalcuServerPrim.csDoCorrectRel(Sender: TddTaskItem);
begin
 {$IFDEF AutoSP}
 if Scheduler.ScheduleEnabled then
  MakeRelPublishTask;
 {$ENDIF}
end;

procedure TalcuServerPrim.csDoPrepareGarant(Sender: TddTaskItem);
var
 l_User: IdaArchiUser;
begin
 {$IF Defined(LUK) or Defined(SGC)}
 DoAutomaticExport;
 {$ELSE}
 {$IfNDef InsiderTest}
 l_User := GlobalDataProvider.UserManager.UserByID(Sender.UserID);
 Assert(Assigned(l_User));
 if (Sender.UserID = usServerService) or l_User.HasAdminRights then
  DoAutomaticExport
 else
  l3System.Msg2Log('У пользоватля %s (%d) нет административных прав. Запуск "%s" запрещен.', [l_User.UserName, l_User.ID, Sender.Description]);
 {$Else InsiderTest}
  DoAutomaticExport;
 {$ENDIF InsiderTest}
 {$IFEND Defined(LUK) or Defined(SGC)}
end;

procedure TalcuServerPrim.csDoUpdateGarant(Sender: TddTaskItem);
var
 l_Ok: Boolean;
begin
 // выполнить батник и сообщить пользователю об окончании
 l_Ok:= False;
 if FileExists(ddAppConfiguration.AsString['aiExecute2']) then
   l_Ok:= FileExecuteWait(ddAppConfiguration.AsString['aiExecute2'], '', ExtractFileDir(ddAppConfiguration.AsString['aiExecute2']), esNormal) = 0;
 f_MessageManager.SendTextMessage(sender.UserID, IfThen(l_ok, 'База обновлена Гаранта успешно', 'Не удалось обновить базу Гаранта'));
end;

(*procedure TalcuServerPrim.csGetTaskLine(Sender: TObject);
begin
 TaskProcessor.addMonitoringUser(sender.UserID);
end;*)

procedure TalcuServerPrim.csEverydayUpdate(Sender: TddTaskItem);
begin
 DoEveryDayUpdate(False);
end;

procedure TalcuServerPrim.csLockBase(Sender: TddTaskItem);
begin
 LockBase('База данных закрыта на техническое обслуживание');
end;

procedure TalcuServerPrim.csSendMessage(Sender: TddTaskItem);
begin
 // TODO -cMM: TalcuServerPrim.csSendMessage default body inserted
end;

procedure TalcuServerPrim.csUpdateBases(Sender: TddTaskItem);
begin
 DoUpdate(True);
end;

procedure TalcuServerPrim.CSServerEvent(aEventId: Integer; aData: Integer);
begin
 case aEventID of
  c_ClientLogedInEvent : UserStatusChanged(TdaUserID(aData), True);
  c_ClientLogedOutEvent: UserStatusChanged(TdaUserID(aData), False);
 end;
end;

procedure TalcuServerPrim.csUnlockBase(Sender: TddTaskItem);
begin
 UnlockBase;
end;

procedure TalcuServerPrim.csUpdateIndex(Sender: TddTaskItem);
begin
 DoUpdateIndex(False, True)
end;

procedure TalcuServerPrim.csUpdateText(Sender: TddTaskItem);
begin
 DoUpdateIndex(True, False);
end;

procedure TalcuServerPrim.cs_GetLogoReply(aPipe: TCsDataPipe);
var
 i: Integer;
 l_LogoFile: String;
 l_Logomanager: TddSimpleListDataAdapter;
 l_Start, l_Finish: TDateTime;
 l_Once: Boolean;
 l_Stream: TStream;
begin
 // перебрать список экранов и вернуть текущий
 f_CS.Acquire;
 try
  l_LogoManager:= ddAppConfiguration.AsObject['LogoList'] as TddSimpleListDataAdapter;
  l_LogoFile:= '';
  for i:= 0 to l_LogoManager.Count - 1 do
  begin
   l_Start:= l_LogoManager.Values[i, 'logo_Start'].AsDateTime;
   l_Finish:= l_LogoManager.Values[i, 'logo_Finish'].AsDateTime;
   l_Once:= l_LogoManager.Values[i, 'logo_Once'].AsBoolean;
   if not l_Once then
   begin
    l_Start:= RecodeYear(l_Start, YearOf(SysUtils.Date));
    l_Finish:= RecodeYear(l_Finish, YearOf(SysUtils.Date));
    if CompareDate(l_Start, l_Finish) = GreaterThanValue then
     l_Finish:= IncYear(l_Finish);
   end; // not l_Once
   if (CompareDate(SysUtils.Date, IncDay(l_Start,-1)) = GreaterThanValue) and
      (CompareDate(SysUtils.Date, IncDay(l_Finish)) = LessThanValue) then
   begin
    l_LogoFile:= l_LogoManager.Values[i, 'logo_File'].AsString;
    break
   end; // if (CompareDate(Date, l_Start) = GreaterThanValue) and (CompareDate(l_Finish) = LesserThanValue)
  end; // for i
  aPipe.WriteLn(l_LogoFile);
  if FileExists(l_LogoFile) then
  begin
   l_Stream:= TFileStream.Create(l_LogoFile, fmOpenRead);
   try
    aPipe.WriteStream(l_Stream);
   finally
    FreeAndNil(l_Stream);
   end;
  end;
 finally
  f_CS.Release;
 end;
end;

procedure TalcuServerPrim.DeleteTask(aTask: TddProcessTask);
begin
  f_TaskProcessor.DeleteTask(aTask, true);
end;

procedure TalcuServerPrim.DestroyActionList;
begin
 FreeAndNil(f_Actions);
end;

procedure TalcuServerPrim.DoAutoClassify(aUserID: TdaUserID = usServerService);
{$IFDEF AutoClass}
var
 l_Task: TddProcessTask;
{$ENDIF}
begin
 {$IFDEF AutoClass}
 if CreateSchedulerTask(ctAutoclassify, l_Task, aUserID) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  l3Free(l_Task);
 end;
 {$ENDIF}
end;

procedure TalcuServerPrim.DoAutomaticExport;
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctAutoExportTask, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  l3Free(l_Task);
 end;
end;

procedure TalcuServerPrim.DoBuildTextIndex;
begin
 TaskProcessor.LockProcessing;
 try
  DisableProcessing;
  try
   l3System.Msg2Log(rsStartBuildTextIndex);
   f_DB:= Tm4DB.Make(ConcatDirName(f_CurPath, SalcuAutoPipeServer_Bserv001), nil, f_FileProc, f_TotalProc);
    try
     f_DB.BuildIndex;
    finally
     f_DB:= nil;
    end;
   l3System.Msg2Log(rsTextIndexBuilded);
  finally
   EnableProcessing;
  end;
 finally
  TaskProcessor.UnLockProcessing;
 end;
end;

function TalcuServerPrim.DoEveryDayUpdate(theManual: Boolean = False): TddSchedulerTaskResult;
var
 l_StartCopy: TDateTime;
 l_S: string;
 l_Error, l_UnlockBase: Boolean;
 i: Integer;
 l_Task: TddTaskItem;
 //l_Params: TExpQueryRec;
 l_Missed: TalcuMissedTasks;
 l_NeedCommitImages: Boolean;
begin
{ if TaskProcessor.Processing then
 begin
  Result:= strRequestDelay;
  l3System.Msg2Log('Ежедневное обновление не может быть запущено - выполняется другая задача');
  Exit;
 end;}

 l3System.Msg2Log('EO - starting', l3_msgLevel10);
 Result := strFailed;
 l_Error := False;
 TaskProcessor.LockAsyncRun;
 try
  l3System.Msg2Log('EO - Async run locked', l3_msgLevel10);
  DisableProcessing;
  try
   l3System.Msg2Log('EO - Processing disabled', l3_msgLevel10);
   TaskProcessor.LockProcessing;
   try
    l3System.Msg2Log('EO - Processing locked', l3_msgLevel10);
    if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoEverydayUpdate] or theManual{and not IsBaseLocked} then
    begin
     LockBase(rsEveryDayUpdate);
     l3System.Msg2Log('EO - base locked', l3_msgLevel10);
     l_UnlockBase:= True;
     //CheckImagesBase; // <- занимает полтора часа, а ценность сомнительна
     l_Missed := [taskBackup];
     {$IFDEF DailyImportKW}
     if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoImportKW] then
      Include(l_Missed, taskKW);
     {$ENDIF}

     l_NeedCommitImages := IsImgCacheCommitable;
     if l_NeedCommitImages then
      Include(l_Missed, taskCommitImg);

     if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateBase] then
      Include(l_Missed, taskUpdateBase);
     if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoHeaderIndex] then
      Include(l_Missed, taskHeaderIndex);
     //if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoDictEntryIndex] then
     // Include(l_Missed, taskDictEntry);
     if (ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateIndex] or
                ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateText]) then
      Include(l_Missed, taskTextIndex);

     ProcessDelayedTasks;
     ddPurgeOldMailInHomes(GlobalDataProvider.GlobalHomePath, 180);
     Status:= dd_apsEverydayUpdate;
     try
      if IsBaseFree(True) then
      begin
       f_Report.Clear;
       begin
        l3System.Msg2Log(rsEveryDayUpdate);
        l3System.Msg2Log('* упаковка нотификаций');
        f_MessageManager.PackMessages(True);
        f_MessageManager.SaveMessages;
        l3System.Msg2Log('* проверка свободного места');
        CheckFreeSpace;
        l3System.Msg2Log('* переключение на временную базу');
        SwitchToTemporaryBase;
        try
         try
          f_Updated:= True; f_TryCount:= 0; l_UnlockBase:= True;
          ImportPriorityTable;
          with ddAppConfiguration do
          begin
           l3System.Msg2Log('* сбрасываем лог');
           ResetSelfLog(AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
           l3System.Msg2Log('* сбрасываем лог Арчи');
           ResetArchiLog(AsBoolean['ZipLogFiles']);
   {$IFDEF MDPSyncStandAlone}
           l3System.Msg2Log('* сбрасываем лог mdpSync');
           ResetLogFile('mdpSyncPrj.log', AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
   {$ENDIF MDPSyncStandAlone}
           ResetExecutorLog(AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
          end; // with ddAppConfiguration
          if l_NeedCommitImages then
          begin
           if DoCommitImgCache then
            Exclude(l_Missed, taskCommitImg);
          end;
          l3System.Msg2Log('* очистка папок экспорта');
          ClearExportFolders;
          l3System.Msg2Log('* очистка импортированных данных');
          ClearSafeFolder;
          {$IFDEF ExchangeDocs}
          l3System.Msg2Log('* очистка внешних дельт');
          ClearDeltasFolders;
          {$ENDIF ExchangeDocs}
          {$IFDEF AAC}
          l3System.Msg2Log('* очистка логов AAC');
          ClearAACLogFolder;
          {$ENDIF AAC}
          l_StartCopy:= Now;
          if DoMakeFamilyBackup then
           begin
            if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoFullBackup] and
              (ddAppConfiguration.AsString[SalcuAutoPipeServer_FullBackup] <> '') and
              IsDayOfWeekByMask(Now, ddAppConfiguration.AsInteger[SalcuAutoPipeServer_FullBackupAtDays]) then
             DoMakeFullBackup(ddAppConfiguration.AsString[SalcuAutoPipeServer_FullBackup]);
            Exclude(l_Missed, taskBackup);

            // Не забыть потом удалить (когда все регионы перейдут)
            l3System.Msg2Log('* проверка таблицы SUB');
            CheckSubTable;
            l_Error:= False;
            SetRealStopTime(1);
            if ValidTime then
            begin
             {$IFDEF DailyImportKW}
             if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoImportKW] then
              if not DoLoadKW then
              begin
               l_UnlockBase:= UndoMakeBackup;
               l_Error:= True;
               f_Report.Add('ОШИБКА - Не удалось загрузить KW');
               l3System.Msg2Log('ОШИБКА - Не удалось загрузить KW');
              end // DoLoadKW
              else
               Exclude(l_Missed, taskKW);
             {$ENDIF}
             if f_AutolinkEnabled then
              UpdateAutoLinkCache;
             if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateBase] and ValidTime and not l_Error then
              if not DoUpdate(False) then
              begin
               l_UnlockBase:= UndoMakeBackup;
               l_Error:= True;
               f_Report.Add('ОШИБКА - Не удалось обновить таблицы базы данных');
               l3System.Msg2Log('ОШИБКА - Не удалось обновить таблицы базы данных');
              end
              else
               Exclude(l_Missed, taskUpdateBase);
             if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoHeaderIndex] and ValidTime and not l_Error then
             begin
              DoUpdateHeaderIndex;
              Exclude(l_Missed, taskHeaderIndex);
             end;
             {$IFNDEF LUK}
             if ValidTime and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoDictEntryIndex] and not l_Error then
             begin
              DoUpdateDictEntryIndex;
              //Exclude(l_Missed, taskDictEntryIndex);
             end; // ValidTime and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoDictEntryIndex] and not l_Error
             {$ENDIF}
             if ValidTime and not l_Error then
             begin
              DoUpdateIndex(ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateText],
                            ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateIndex]);
              Exclude(l_Missed, taskTextIndex);
             end; // ValidTime and not l_Error
             if l_UnlockBase then
              UnlockBase;
            end
            else
             l3System.Msg2Log(SalcuAutoPipeServer_Vremyaisteklo); // Time < StopTime
           end // DoMakebackup
           else
           begin
            l_Error:= True;
            f_Report.Add('ОШИБКА - Не удалось создать резервную копию');
            l3System.Msg2Log('ОШИБКА - Не удалось создать резервную копию');
           end;
          if not l_Error then
           Result := strOk;
         except
          on E: Exception do
          begin
           l_Error := True;
           f_Report.Add(Format('ОШИБКА - %s', [E.Message]));
           l3System.Msg2Log('ОШИБКА обновления "%s". Детали см. ниже', [E.Message]);
           l3System.Exception2Log(E);
           raise;
          end;
         end;
        finally
         SwitchToRealBase;
         SendErrorReport(l_Missed);
         alcuMail.SendEmailNotify(eventEveryday, l_Error, f_Report, Status);
         l3System.Msg2Log(SalcuAutoPipeServer_Ezhednevnayaproceduraobnovleniya);
        end; // try..finally
        {$IFDEF MDPSyncStandAlone}
        FileExecute(GetAppFolderFileName('mdpSyncPrj.exe'), '', '', esHidden);
        {$ENDIF}
        {$IFDEF MDPSyncIntegrated}
        f_DictSynchronizator.PrepareAllDicts;
        {$ENDIF MDPSyncIntegrated}
        {$IFDEF AAC}
        // Создание задачи для Импорта постановлений. Выполнение начнется по окончании ЕО
        UpdateAAC(ddAppConfiguration.AsString['lcSourceFolder'], False);
        {$ENDIF}
       end;
      end // IsBaseFree
      else
       SendErrorReport(l_Missed);
     finally
      if l_UnlockBase then
       UnlockBase;
     end;
     Status:= dd_apsRevert;
    end // if DoEverydayTask and not IsBaseLocked
    {$IFNDEF Service}
    else
    if f_BaseEngineHolder.BaseEngine.IsBaseLocked(l_S) then
     alcuShowMsg(l_S);
    {$ENDIF}
   finally
    TaskProcessor.UnLockProcessing;
   end;
  finally
   EnableProcessing;
  end;
 finally  
  TaskProcessor.UnLockAsyncRun;
 end;
end;

function TalcuServerPrim.DoEveryWeekUpdate(aManual: Boolean = False): TddDeltaResult;
{$IFDEF EveryWeek}
var
  l_StartDate, l_StopDate: TDateTime;
  l_Size: LongInt;
  l_Attach, l_Msg: string;
  l_CanWork: Boolean;
{$ENDIF}
begin
{$IFDEF EveryWeek}
{
 if TaskProcessor.Processing then
 begin
  Result:= drDelayed;
  l3System.Msg2Log('Еженедельное обновление не может быть запущено - выполняется другая задача');
  exit;
 end; // TaskProcessor.Processing
} 
 TaskProcessor.LockAsyncRun;
 DisableProcessing;
 try
  // Ждем остановки выполнения заданий
  if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoEveryweekUpdate] or aManual then
  begin
   l3System.Msg2Log('Start weekly update');
   begin
    TaskProcessor.LockProcessing;
    try
      LockBase(SalcuAutoPipeServer_importezhenedel_noyraznicydokume);
      try
        if IsBaseFree(True) then
        begin
         with ddAppConfiguration do
         begin
          ResetSelfLog(AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
          ResetArchiLog(AsBoolean['ZipLogFiles']);
{$IFDEF MDPSyncStandAlone}
          ResetLogFile('mdpSyncPrj.log', AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
{$ENDIF MDPSyncStandAlone}
          ResetLogFile('alcuExecutor.log', AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega], AsBoolean['ZipLogFiles']);
         end;
         try
          if f_BackupDone then
           l_CanWork := True
          else
          begin
           // Выполняем действия, несвязанные с импортом документов
           l3System.Msg2Log('Выполняем действия, не связанные с импортом документов', l3_msgLevel1);
           Status:= dd_apsLoadDelta;
           f_Report.Clear;
           SwitchToTemporaryBase;
           ClearOldBackup;
           l_CanWork := DoMakeFullBackup(ConcatDirName(ddAppConfiguration.AsString[SalcuAutoPipeServer_BackupRoot],
                                            StDateToDateString(SalcuAutoPipeServer_YyyyMmDd, CurrentDate, True)));
           if not l_CanWork then
            Result := drBackupError
          end; // not f_BackupDone
          if l_CanWork then
          begin
           f_BackupDone := True;
           f_Busy:= True;
           SetRealStopTime(0);
           Result:= MakeAndLoadDelta(aManual);
           if not (Result in [drDelayed, drImportError]) then
           begin
            ClearSafeFolder;
            ImportPriorityTable;
            DoUpdate(False);
            if f_AutolinkEnabled then
             UpdateAutoLinkCache;
            if ValidTime then
             DoUpdateHeaderIndex;
            if ValidTime then
             DoUpdateIndex(True, ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateTextIndex]);
            f_Busy:= False;
           end // Result = drOk
           else
           begin
            if not ValidTime then
            begin
             l3System.Msg2Log(SalcuAutoPipeServer_VremyavyshloDerzhat_syabol_shene);
             alcuMail.SendSMSNotify(eventCheckDeltaReady, Status);
             Result := drPrepareError;
            end;
           end; // MakeAndLoadDelta
           if Result <> drDelayed then
            f_BackupDone := False;
          end; // l_CanWork
          if Result in [drOk, drPrepareError, drBackupError] then
          begin
          UnlockBase;
          SwitchToRealBase;
          end; // Result in [drOk, drPrepareError]
          alcuMail.SendEmailNotify(eventDelta, Result <> drOk, f_Report, Status, l_Attach);
          l3System.Msg2Log(SalcuAutoPipeServer_Ezhenedel_noeobnovleniezavershen);
          {$IFDEF MDPSyncStandAlone}
          FileExecute(GetAppFolderFileName('mdpSyncPrj.exe'), '', '', esHidden);
          {$ENDIF}
         finally
          Status:= dd_apsRevert;
         end;
        end // IsBaseFree
        else
        begin
         // На базе есть пользователи
         l_Msg:= SalcuAutoPipeServer_DeltaNotStarted;
         f_Report.Add(l_Msg);
         alcuMail.SendEmailNotify(eventDelta, True, f_Report, Status);
        end; // not IsBaseFree
      finally
        UnlockBase;
      end;
    finally
      TaskProcessor.UnLockProcessing;
    end;
   end; // not BaseSupport.IsBaseLocked
  end // ddAppConfiguration.AsBoolean['DoEveryweekUpdate'] or aManual
  else
   l3System.Msg2Log('Нет причин выполнять обновление');
 finally
  EnableProcessing;
  TaskProcessor.UnLockAsyncRun;
 end;
{$ENDIF}
end;

procedure TalcuServerPrim.DoLoadEQClasses(aFileName: String);
begin
  l3System.Msg2Log(SalcuAutoPipeServer_importekvivalentnyhklassov);
  try
   LoadEqualClasses(1, aFileName, '\');
   l3System.Msg2Log(SalcuAutoPipeServer_importekvivalentnyhklassovzavers)
  except
   on E: Exception do
   begin
    {$IFNDEF Service}
    alcuShowMsg(SalcuAutoPipeServer_Vovremyaimportaproizoshlaoshibka);
    {$ENDIF}
    l3System.Msg2Log(SalcuAutoPipeServer_Oshibkaimportaekvivalentnyhklass, [aFileName]);
    Exception2Log(E);
   end;
  end;
end;

function TalcuServerPrim.DoLoadKW(aIsDelta: Boolean = False): Boolean;
var
  l_KWFileName: string;
  l_FileSize: LongInt;
  l_Mask: string;
  l_Error: Boolean;
begin
  l3System.Msg2Log('* загрузка KW');
  Status:= dd_apsLoadKW;
  if PrepareKWFile then
  begin
   Result:= ImportKeywords;
   l_Error:= not Result;
   if l_Error then
    l_Mask:= SalcuAutoPipeServer_Faylklyuevyhslovneimportirovanin
   {$IFDEF KWSending}
   else
   begin
    l_Mask:= SalcuAutoPipeServer_Faylklyuevyhslovuspeshnoimportir;
    if SendKWToRegions then
     l_Mask:= l_Mask + #13#10 + SalcuAutoPipeServer_FaylotpravlenvTver_
    else
     l_Mask:= l_Mask + #13#10 + SalcuAutoPipeServer_FaylneotpravlenvTver_;
   end{$ENDIF};
  end
  else
  begin
   l_Mask:= SysUtils.Format(SalcuAutoPipeServer_Faylklyuevyhslovnenayden, [ddAppConfiguration.AsString[SalcuAutoPipeServer_KWFileName]]);
   l3System.Msg2Log(l_Mask);
   l_Error:= True;
   Result:= True
  end;
  f_Report.Add(l_Mask);
  alcuMail.SendEmailNotify(eventKeywords, l_Error, l_Mask, Status);
  Status:= dd_apsRevert;
end;

procedure TalcuServerPrim.DoLoadRegions;
var
 l_Task: TddProcessTask;
 l_TasksList: TasksListHelper;
 l_IDX: Integer;
 l_InnerTask: TddProcessTask;
begin
 l_Task := MakeLoadRegionsTask;
 try
  if l_Task is TalcuContainerTask then
  begin
   l_TasksList := TalcuContainerTask(l_Task).TasksList;
   try
    for l_IDX := 0 to l_TasksList.Count - 1 do
    begin
     l_InnerTask := l_TasksList.MakeTask(l_IDX, '');
     try
      TaskProcessor.AddActiveTask(l_InnerTask);
     finally
      FreeAndNil(l_InnerTask);
     end;
    end;
   finally
    l_TasksList := nil;
   end;
  end;
 finally
  FreeAndNil(l_Task);
 end;
end;

function TalcuServerPrim.DoMakeFamilyBackup: Boolean;
var
  S, l_Msg, l_YesterdayPath: string;
  l_suffix: Integer;
  l_Handle: Integer;
begin
 if not f_Busy then
 try
  f_Busy:= True;
  TaskProcessor.LockProcessing;
  try
   DisableProcessing;
   try
    l3System.Msg2Log(SalcuAutoPipeServer_Naalokopirovaniyabazy);
    Status:= dd_apsBackup;
    ClearYesterdayBases;
    l_YesterdayPath:= ExpandFileName(GetYesterdayPath);
    // Создание файла даты базы
    S:= StDateToDateString(SalcuAutoPipeServer_DdNnnnnnnnnnnnYyyy, CurrentDate, True);
    l_Handle:= FileCreate(ConcatDirName(l_YesterdayPath, SalcuAutoPipeServer_DateOfBaseTxt));
    try
     FileWrite(l_Handle, S[1], Length(S));
    finally
     FileClose(l_Handle);
    end;
    l_YesterdayPath:= ConcatDirName(l_YesterdayPath, GlobalHtServer.FamilyTbl.GetFamilyName(1));
    PureDir(l_YesterdayPath); // Очистка предыдущей копии
    StopBaseEngine(False);
    try
     MakeFolderCopy(f_CurPath, l_YesterdayPath);
     l3System.Msg2Log(SalcuAutoPipeServer_Proverkatonostikopii);
     Result:= CheckBackup(f_CurPath, l_YesterdayPath);
     if Result then
     begin
      l3System.Msg2Log('Копии совпали');
      l_Msg:= SalcuAutoPipeServer_Kopirovaniebazyzaversheno;
      Error:= dd_apeNoError;
      Status:= dd_apsRevert;
     end; // result
    finally
     StartBaseEngine;
    end;
   finally
    EnableProcessing;
   end;
  finally
   TaskProcessor.UnLockProcessing;
  end;
 except
  on E: Exception do
  begin
   l_Msg:= SalcuAutoPipeServer_Oshibkakopirovaniyabazy;
   Error:= dd_apeCreateBackup;
   Result:= False;
   Exception2Log(E);
  end;
 end
 else
 begin
  Result:= False;
  l_Msg:= '';
 end;
 if l_Msg <> '' then
  f_Report.Add(l_Msg);
 f_Busy:= False;
end;

function TalcuServerPrim.DoMakeFullBackup(const aDestination: String):
    Boolean;
var
  S, l_Msg,
  l_SourFolder, l_DestFolder: string;
  i: Integer;
begin
  l3System.Msg2Log(SalcuAutoPipeServer_Naalopolnogokopirovaniyabazy);
  Status:= dd_apsFullBackup;
  try
   l_DestFolder:= ExpandFileName(JustPathNameS(AddBackSlashS(aDestination)));
   l_SourFolder := IfThen(ddAppConfiguration.AsString['LocalBasePath'] = '',
                          ddAppConfiguration.AsString['UNCBasePath'], ddAppConfiguration.AsString['LocalBasePath']);
   PureDir(l_DestFolder); // Очистка предыдущей копии
   if l_SourFolder <> '' then
   begin
    try
     Scheduler.DisableSchedule;
     TaskProcessor.LockProcessing;
     try
      StopBaseEngine(False);
      MakeFolderCopy(l_SourFolder, l_DestFolder);
      l3System.Msg2Log(SalcuAutoPipeServer_Proverkatonostikopii);
      Result:= CheckBackup(l_SourFolder, l_DestFolder);
     finally
      TaskProcessor.UnLockProcessing;
      Scheduler.EnableSchedule;
     end;
    except
      on E: Exception do
      begin
       l_Msg:= SysUtils.Format(SalcuAutoPipeServer_Oshibkasozdaniyapolnoykopiibazy, [l_DestFolder]);
       l3System.Msg2Log(l_Msg);
       Exception2Log(E);
       f_Report.Add(l_Msg);
       Error:= dd_apeCreateFullBackup;
       Result:= False;
       exit;
      end;
    end; // try except
    StartBaseEngine;
    Status:= dd_apsRevert;
    l_Msg:= SalcuAutoPipeServer_Sozdaniepolnoykopiibazyzavershen;
    l3System.Msg2Log(l_Msg);
    f_Report.Add(l_Msg);
   end; // l_SourFolder <> ''
   Error:= dd_apeNoError;
  except
   on E: Exception do
   begin
    l_Msg:= SalcuAutoPipeServer_Oshibkakopirovaniyabazy;
    l3System.Msg2Log(l_Msg);
    Exception2Log(E);
    f_Report.Add(l_Msg);
    Result:= False;
   end;
  end;
end;

function TalcuServerPrim.DoPrepareDelta: Boolean;
{$IFDEF EveryWeek}
var
  l_Result: Cardinal;
  l_Msg: string;
  l_Timer: TTimer;
{$ENDIF}
begin
{$IFDEF EveryWeek}
 if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoMakeDelta] then
 begin
  l_Msg:= rsPrepareDelta;
  l3System.Msg2Log(l_Msg);
  l_Timer:= TTimer.Create(nil);
  try
   l_Timer.OnTimer:= _PrepareTimer;
   l_Timer.Interval:= 120*60*1000; // время ожидания - 2 часа
   l_Timer.Enabled:= True;
   try
    l_Result:= FileExecuteWait(ddAppConfiguration.AsString[SalcuAutoPipeServer_DeltaCreator],
                               f_DeltaLogFileName, ExtractFileDir(ddAppConfiguration.AsString[SalcuAutoPipeServer_DeltaCreator]), esMinimized);
   except
    // Не дождались окончания подготовки
    l_Result:= Cardinal(-1);
   end;
   l_Timer.Enabled:= False;
  finally
   FreeAndNil(l_Timer);
  end; // try..finally
  if l_Result <> 0 then
  begin
   l_Msg:= SysUtils.Format(rsDeltaCreateError, [l_Result]);
   alcuMail.SendEmailNotify(eventMakeDelta, True, rsSpravki, Status);
   Result:= False;
  end
  else
  begin
   Result:= True;
   l_Msg:= rsDeltaCreated;
   if SizeOfFile(ddAppConfiguration.AsString['SpravkiFileName']) > 0 then
    alcuMail.SendEmailNotify(eventMissedDocuments, True, rsSpravki, Status, ddAppConfiguration.AsString['SpravkiFileName']);
  end;
  l3System.Msg2Log(l_Msg);
  f_Report.Add(l_Msg);
 end
 else
  Result:= True;
{$ENDIF}
end;

procedure TalcuServerPrim.DoPreventiveUpdate(const aManual: Boolean = False);
var
 i: Integer;
 l_BaseExclusiveLocked: Boolean;
 l_UpdateSucceed: Boolean;
begin
 TaskProcessor.LockAsyncRun;
 try
  {
    1. Рассылаем всем пользователям предупреждение о начале профилактики
    2. Закрываем базу
    3. Прекращаем выполнение всех заданий
    4. Ждем 15 минут
    5. Отстреливаем оставшихся пользователей
    6. Выполняем обновление базы
    7. Открываем базу
    8. Разрешаем выполнение заданий
    9. Рассылаем письмо на jurotd@garant.ru (или любой другой) с приглашением зайти
  }
  l3System.Msg2Log(SalcuAutoPipeServer_Naalovypolneniyaprofilaktieskogo);
  l_BaseExclusiveLocked := False;
  l_UpdateSucceed := False;
  Status:= dd_apsPreventiveUpdate;
  {1.}
  f_BaseEngineHolder.BaseEngine.CSServer.Notifier.SendNotify(c_AllClients, ntInformation, 0,
                         SysUtils.Format(SalcuAutoPipeServer_Vnimanieerezminutnanutsyaprofila+
                                         SalcuAutoPipeServer_Vsepol_zovatelibudutotklyuenyZav,
                                         [ddAppConfiguration.AsInteger[SalcuAutoPipeServer_WaitTime], ddAppConfiguration.AsInteger[SalcuAutoPipeServer_WaitTime]]));
  {3.}
  LockTaskExecution;
  try
    {2.}
    f_BaseEngineHolder.BaseEngine.LockBase(SalcuAutoPipeServer_Bazazakrytanavremyavypolneniyapr);
    try
      {4.}
      WaitForFreeBase(ddAppConfiguration.AsInteger[SalcuAutoPipeServer_WaitTime] * 60000);
//      for i:= 1 to ddAppConfiguration.AsInteger[SalcuAutoPipeServer_WaitTime] do
//       Delay(60);
      TaskProcessor.LockProcessing;
      try
        {5.}
        if IsbaseFree(True) then
        begin
         l_BaseExclusiveLocked := True;
         {6.}
         if DoUpdate(False) then
         begin
          l_UpdateSucceed := True;
         end // DoUpdate
         else
         begin
          l3System.Msg2Log(SalcuAutoPipeServer_Obnovlenietabliczakonilos_soshib);
          exit;
         end;
        end // IsBaseFree
        else
        begin
         l3System.Msg2Log(SalcuAutoPipeServer_Nevsepol_zovatelipokinuliArhivar);
        end; // not IsBaseFree
      finally
        TaskProcessor.UnLockProcessing;
      end;
    finally
      {7.}
      f_BaseEngineHolder.BaseEngine.UnlockBase;
    end;
  finally
    {8.}
    UnLockTaskExecution;
  end;
 finally
   TaskProcessor.UnLockAsyncRun;
 end;
 if l_BaseExclusiveLocked then
 begin
  {9.}
  if l_UpdateSucceed then
    alcuMail.SendEmail(ddAppConfiguration.AsString[SalcuAutoPipeServer_NotifyAddress], SalcuAutoPipeServer_BazaArhivariusaotkrytadlyaraboty, SalcuAutoPipeServer_Dobropozhalovat_vArhivarius)
  else
  begin
   {$IFNDEF service}
   if aManual then
    alcuMsgDialog(SalcuAutoPipeServer_Obnovlenietabliczakonilos_soshib, mtError, [mbOk], 0);
   {$ENDIF}
  end
 end
 else
 begin
  {$IFNDEF Service}
  if aManual then
   alcuMsgDialog(SalcuAutoPipeServer_Nevsepol_zovatelipokinuliArhivar, mtWarning, [mbOk], 0);
  {$ENDIF}
 end;
 l3System.Msg2Log(SalcuAutoPipeServer_Profilaktieskoeobnovleniezaversh);
 {$IFNDEF Service}
 if aManual then
  alcuMsgDialog(SalcuAutoPipeServer_Profilaktieskoeobnovleniezaversh, mtInformation, [mbOk], 0);
 {$ENDIF}
 Status:= dd_apsRevert;
end;

function TalcuServerPrim.DoUpdate(aLogoffUsers: Boolean): Boolean;
var
 l_Locked: Boolean;
 l_Progress: IdaProgressSubscriber;
begin
 Status := dd_apsUpdateTables;
 f_CanClose:= False;
 Result:= False;
 if IsBaseFree(aLogoffUsers) then
  try
   TaskProcessor.LockProcessing;
   try
    DisableProcessing;
    try
     l3System.Msg2Log(SalcuAutoPipeServer_Naaloobnovleniyabazy);
     try
       l_Locked:= IsBaseLocked;
       try
        if not l_Locked then
         f_BaseEngineHolder.BaseEngine.LockBase;
        {$IFDEF UseCommandFile}
        if StopBaseEngine(False) then
         with ddAppConfiguration do
          Result:= FileExecuteWait(AsString['exUpdater'], AsString['UNCBasePath'], ExtractFilePath(AsString['exUpdater']), esHidden) = 0;
        StartBaseEngine;
        {$ELSE}
        l_Progress := TdaProgressProcHolder.Make(f_Progressor.ProcessUpdate);
        try
         GlobalDataProvider.SubscribeProgress(l_Progress);
         try
          f_Progressor.Start(2, 'Обновление базы данных', False);
          GlobalHTServer.UpdateAllTbl(0);
          f_Progressor.ProcessUpdate(1);
          GlobalHTServer.UpdateAllTbl(1);
          f_Progressor.ProcessUpdate(2);
          f_Progressor.Stop;
         finally
          GlobalDataProvider.UnSubscribeProgress(l_Progress);
         end;
        finally
         l_Progress := nil;
        end;
        {$ENDIF}
       finally
        if not l_Locked then
         f_BaseEngineHolder.BaseEngine.UnlockBase;
       end;
     finally
      l3System.Msg2Log(SalcuAutoPipeServer_Obnovleniebazyzaversheno);
      Result:= True;
     end;
    finally
     EnableProcessing;
    end;
   finally
    TaskProcessor.UnLockProcessing;
   end;
  except
   on E: Exception do
   begin
    l3System.Msg2Log(SalcuAutoPipeServer_Oshibkaobnovleniyabazy);
    Exception2Log(E);
   end;
  end; // Try..Except
 Status := dd_apsRevert;
 f_CanClose:= True;
end;

procedure TalcuServerPrim.DoUpdateDictEntryIndex;
var
  l_Msg: string;
begin
 TaskProcessor.LockProcessing;
 try
  DisableProcessing;
  try
   Status:= dd_apsIndexHeaders;
   l3System.Msg2Log(SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey);
   try
    BuildTextIndexbyDictEntry(1);
    l_Msg:= SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey1;
   except
    on E: Exception do
    begin
     l_Msg:= SalcuAutoPipeServer_Oshibkapostroeniyaindeksaslovarn;
     Exception2Log(E);
    end; // on E
   end; // try except
   l3System.Msg2Log(l_Msg);
   f_Report.Add(l_Msg);
  finally
   EnableProcessing;
  end;
 finally
  TaskProcessor.UnLockProcessing;
  Status:= dd_apsRevert;
 end;
end;

procedure TalcuServerPrim.DoUpdateHeaderIndex;
var
  l_Msg: string;
begin
 Status:= dd_apsIndexHeaders;
 TaskProcessor.LockProcessing;
 try
  DisableProcessing;
  try
   l3System.Msg2Log(SalcuAutoPipeServer_Postroenieindeksazagolovkov);
   try
    BuildTextIndexbyHeader(CurrentFamily, f_Progressor.ProcessUpdate);
    l_Msg:= SalcuAutoPipeServer_Postroenieindeksazagolovkovzaver;
   except
    on E: Exception do
    begin
     l_Msg:= SalcuAutoPipeServer_Oshibkapostroeniyaindeksazagolov;
     Exception2Log(E);
    end; // on E
   end; // try except
   l3System.Msg2Log(l_Msg);
   f_Report.Add(l_Msg);
  finally
   EnableProcessing;
  end;
 finally
  TaskProcessor.UnLockProcessing;
  Status:= dd_apsRevert;
 end;
end;

function TalcuServerPrim.DoUpdateIndex(aUpdateText, aUpdateIndex : Boolean):
    Boolean;
var
  l_Msg, l_BasePath, l_FamilyName: string;
  l_EraseSAV, l_UpdateBase: Boolean;
begin
 if aUpdateText or aUpdateIndex then
 begin
  Status:= dd_apsBuildTextIndex;
  try
   l_EraseSAV:= False;
   TaskProcessor.LockProcessing;
   try
    DisableProcessing;
    try
     l3System.Msg2Log(rsStartTextUpdate);
     l_BasePath:= ConcatDirName(f_CurPath, SalcuAutoPipeServer_Bserv001);
     f_DB:= Tm4DB.Make(l_BasePath, _YeldProcess, f_FileProc, f_TotalProc);
     try
      f_DB.Start(m3_saReadWrite);
      try
       if aUpdateIndex then
       begin
        l3System.Msg2Log(SalcuAutoPipeServer_Naaloobnovleniyatekstovogoindeks);
        f_DB.UpdateIndex;
        l3System.Msg2Log(SalcuAutoPipeServer_Obnovlenietekstovogoindeksazaver);
       end; // ddAppConfiguration.AsBoolean['DoUpdateIndex']
       if aUpdateText and not IsShutdowning then
       begin
        l3System.Msg2Log(SalcuAutoPipeServer_Naaloobnovleniyatekstovoyasti);
        if f_DB.Update then
        begin
         if not IsShutdowning then
          l_EraseSAV:= True;
        end;
        l3System.Msg2Log(SysUtils.Format(SalcuAutoPipeServer_Unitozhenoudalennyhdokumentov, [f_DB.Purge]));
        l3System.Msg2Log(SalcuAutoPipeServer_Obnovlenietekstovoyastizavershen);
       end; // l_UpdateBase
      finally
       f_DB.Finish;
      end;
      if aUpdateText and l_EraseSAV then
       f_DB.DeleteVersion;
      f_CanClose := True;
     finally
      f_DB:= nil;
     end;
     l_Msg:= rsTextUpdateDone;
     Error:= dd_apeNoError;
     except
      on E: Exception do
      begin
       l_Msg:= rsUpdateTextBaseError;
       Error:= dd_apeIndex;
       Exception2Log(E);
      end; // On E
     end; // try..except
     l3System.Msg2Log(l_Msg);
     f_Report.Add(l_Msg);
     alcuMail.SendEmailNotify(eventTextIndex, Error <> dd_apeNoError, l_Msg, Status);
    finally
     EnableProcessing;
    end;
  finally
   TaskProcessor.UnLockProcessing;
  end;
  Status:= dd_apsRevert;
 end; // aUpdateText or aUpdateIndex
end;

procedure TalcuServerPrim.DoUploadRegions;
var
 l_Task: TddProcessTask;
 l_TasksList: TasksListHelper;
 l_IDX: Integer;
 l_InnerTask: TddProcessTask;
begin
 l_Task := MakeUpLoadRegionsTask;
 try
  if l_Task is TalcuContainerTask then
  begin
   l_TasksList := TalcuContainerTask(l_Task).TasksList;
   try
    for l_IDX := 0 to l_TasksList.Count - 1 do
    begin
     l_InnerTask := l_TasksList.MakeTask(l_IDX, '');
     try
      TaskProcessor.AddActiveTask(l_InnerTask);
     finally
      FreeAndNil(l_InnerTask);
     end;
    end;
   finally
    l_TasksList := nil;
   end;
  end;
 finally
  FreeAndNil(l_Task);
 end;
end;

function TalcuServerPrim.ExecuteConfigDialog: Boolean;
var
 l_LocalBase, l_Silent: Boolean;
 l_BasePath, l_LocalPath, l_IP: String;
 l_Port: Word;
 l_General: TddBaseConfigItem;
begin
 with ddAppConfiguration do
 begin
  HasValue('General', l_General);
  l_LocalBase := AsBoolean[SalcuAutoPipeServer_IsLocalBase];
  l_BasePath  := AsString['UNCBasePath'];
  l_LocalPath := AsString['LocalBasePath'];
  Result:= ddAppConfiguration.ShowDialog('', True);
  if Result then
  begin
   { TODO -oДмитрий Дудко -cРазвитие : Реакция на изменение ключевых параметров }
   (*
      * пути к базам и образам
      * состав удаленноредактируемых словарей и статус (клиент-сервер)
   *)

   AsString[SalcuAutoPipeServer_FamilyBackup]:= _CheckDir(AsString[SalcuAutoPipeServer_FamilyBackup]);
   AsString[SalcuAutoPipeServer_BadImportDir]:= _CheckDir(AsString[SalcuAutoPipeServer_BadImportDir]);
   AsString[SalcuAutoPipeServer_FullBackup]:= _CheckDir(AsString[SalcuAutoPipeServer_FullBackup]);
   AsString[SalcuAutoPipeServer_SafeDirName]:= _CheckDir(AsString[SalcuAutoPipeServer_SafeDirName]);
   (* Нужно перезапустить движок, если:
         - поменялся путь к базе
         - поменялся локальный путь к базе и работаем по локальным путям
         - сняли/установили флажок "Локальная база"
   *)
   //if (l_General.Changed) then
   // RestartBaseEngine;
   CalculateAnonceDate;
   alcuMail.CheckInterval := AsInteger['POPInterval'];
   {$IFDEF SubDeletedNotify}
   DictChangeFileName:= ddAppConfiguration.AsString['DictUpdateFileName'];
   {$ENDIF}
   TaskProcessor.WorkThreadCount := ddAppConfiguration.AsInteger['WorkThreadCount'];
{$IFDEF MDPSyncIntegrated}
   f_DictSynchronizator.UpdateSyncFolder;
{$ENDIF MDPSyncIntegrated}
   l3System.MessageLevel:= ddAppConfiguration.AsInteger['l3LogLevel'];
  end;
 end;// with ddAppConfiguration;
end;

procedure TalcuServerPrim.ExportSpecialAnnotation;
{$IFDEF Prime}
var
 l_T: TalcuAnnotationTask;
{$ENDIF}
begin
{$IFDEF Prime}
  l_T:= TalcuAnnotationTask.Create(GlobalDataProvider.UserID);
  try
   l_T.TaskFolder := '';
   f_TaskProcessor.AddActiveTask(l_T);
  finally
   l3Free(l_T);
  end;
{$ENDIF}
end;

function TalcuServerPrim.GetAnnoExportEnabled: Boolean;
begin
 Result := cs_ttAnnoExport in f_TaskProcessor.EnabledTaskTypes
end;

function TalcuServerPrim.GetAutoClassEnabled: Boolean;
begin
 Result := cs_ttAutoClass in f_TaskProcessor.EnabledTaskTypes
end;

function TalcuServerPrim.GetCurrentUserName: string;
begin
  Result:= f_TaskProcessor.CurrentUserName;
end;

function TalcuServerPrim.GetTaskExecutionEnabled: Boolean;
begin
  Result:= f_TaskProcessor.TaskExecutionEnabled;
end;

function TalcuServerPrim.GetExportEnabled: Boolean;
begin
 Result := cs_ttExport in f_TaskProcessor.EnabledTaskTypes
end;

function TalcuServerPrim.GetImportEnabled: Boolean;
begin
 Result := cs_ttImport in f_TaskProcessor.EnabledTaskTypes
end;

function TalcuServerPrim.GetStopTime: TDateTime;
begin
  Result := ddAppConfiguration.AsDateTime['WorkDayStart'];
end;

function TalcuServerPrim.GetTaskEnabled(const TaskID: ShortString): Boolean;

  function DoIt(anItem: TddProcessTask): Boolean;
  begin
   Result := true;
   GetTaskEnabled := anItem.Enabled;
  end;

begin
  Result := false;
  f_TaskProcessor.WorkupTaskByIDF(TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt));
end;

function TalcuServerPrim.GetUndoRestorePath(const aLast: Boolean = False):
        string;
begin
  Result:= MakeUniqueFolderName(ConcatDirName(ddAppConfiguration.AsString[SalcuAutoPipeServer_FamilyBackup],
                                SalcuAutoPipeServer_UndoRestore), aLast);
end;

function TalcuServerPrim.ImportDocuments: Boolean;
var
  l_Pipe: TddImportPipe;
  l_StartDate: TDateTime;
  l_StopDate: TDateTime;
  l_Size: LongInt;
  l_Attach: string;
  l_Msg: string;
begin
 Result := False;
  l_Pipe:= TddImportPipe.Create(CurrentFamily);
  try
   { Присваиваем общие свойства }
   l_Pipe.InputFileType:= dd_itAutoDetect; //dd_itGarant;    Исправлено для заливки FASMO
   l_Pipe.SameDocuments:= sdrDelete;
   l_Pipe.CheckDocuments:= True;
//   l_Pipe.Family:= 1;
   l_Pipe.MoveFiles:= True;
   l_Pipe.DoneDir:= ConcatDirName(ddAppConfiguration.AsString[SalcuAutoPipeServer_BackupRoot],
                                   StDateToDateString(SalcuAutoPipeServer_YyyyMmDd,
                                                      CurrentDate, True));
   //l_Pipe.Updatedoc:= True;
   l_Pipe.PictureDir:= ddAppConfiguration.AsString[SalcuAutoPipeServer_PictureFolder];
   l_Size:= 0;
   l_Pipe.ClearLog:= False;
   l_Pipe.LoadDict:= True;
   l_Pipe.NotUpdatableDicts:= ddAllDicts;
   l_Pipe.WorkDir:= ddAppConfiguration.AsString[SalcuAutoPipeServer_SourceFolder];
   {$IFNDEF UseCommandFile}
   l_Pipe.FinalUpdate:= True;
   {$ENDIF}
   l_Pipe.Progressor := f_Progressor;
   try
    l_Pipe.Execute;
    if l_Pipe.ErrorLog.Count > 0 then // Самостоятельно сохраняем файл ошибок
    try
     l_Attach:= ConcatDirName(ExtractFilePath(ParamStr(0)),
                              SysUtils.FormatDateTime(SalcuAutoPipeServer_ErrorsYYYYMMDDLog,
                              SysUtils.Date));
     l_Pipe.ErrorLog.SaveToFile(l_Attach);
    except
     on E: Exception do
     begin
      l_Msg:= SalcuAutoPipeServer_Oshibkazapisilogaoshibokimporta;
      f_Report.Add(l_msg);
      l3System.Msg2Log(l_Msg);
      Exception2Log(E);
     end; //on E
    end; // try..except
    CheckPriority;
    Result := True;
   except
    on E: Exception do
    begin
     l_Msg:= SalcuAutoPipeServer_OshibkaimportaNSRCfaylov;
     l3System.Msg2Log(l_Msg);
     f_Report.Add(l_Msg);
     Exception2Log(E);
     end; // On E
    end; // try..except
   finally
    l3Free(l_Pipe);
   end; // l_Pipe;
end;

function TalcuServerPrim.ImportKeywords: Boolean;
var
 l_KWPipe: TddDictLinkPipe;
begin
 Result := False;
 if PrepareKWFile then
 begin
  l3System.Msg2Log('Начало импорта ключевых слов');
  Result:= ImportDictLink(ConcatDirName(ExtractFileDir(ParamStr(0)), SalcuAutoPipeServer_ComKw),
                          CurrentFamily, da_dlKeywords, True, True, True, f_Progressor.ProcessUpdate);
  l3System.Msg2Log('Импорт ключевых слов завершен');
 end;
end;

procedure TalcuServerPrim.ImportPriorityTable;
begin
{$IFDEF CheckPriority}
 try
  BaseConfig.Section := 'PriorityImport';
  if FileExists(ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName]) and
    (not SameText(ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName], BaseConfig.ReadParamStrDef('ImportedPriorityFileName', '')) or
    (FileAge(ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName]) <> BaseConfig.ReadParamIntDef('ImportedPriorityFileAge', 0)))
    then
  begin
   with TPriorTbl.Create(CurrentFamily) do
   try
    ImportPriorityFromFile(ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName], True, True);
    BaseConfig.WriteParamStr('ImportedPriorityFileName', ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName]);
    BaseConfig.WriteParamInt('ImportedPriorityFileAge', FileAge(ddAppConfiguration.AsString[SalcuAutoPipeServer_PriorityFileName]));
   finally
    Free
   end;
  end;
 except
  on E: Exception do
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Oshibkaimportaetalonnoytablicyva);
   l3System.Exception2Log(E);
  end;
 end;
{$ENDIF}
end;

procedure TalcuServerPrim.Initialize;
begin
 CheckUNCPath;
 alcuMail.CheckSSLLibraries;
 alcuMail.CheckUnsendedMail;
 //CheckBackupDir;
end;

function TalcuServerPrim.IsBaseFree(aLogoffUsers: Boolean): Boolean;
var
 l_Msg: String;
begin
 f_Progressor.StartInfinity;
 try
  l3System.Msg2Log('Проверка доступности базы...');
  if aLogoffUsers then
  begin
   l3System.Msg2Log('* попытка выгнать пользователей');
   LogoffUsers(False);
   Assert(ddAppConfiguration.AsString[SalcuAutoPipeServer_LocalBasePath] <> '');
   NetLogoffUsers(f_BaseEngineHolder.BaseEngine.ServerHostName, ddAppConfiguration.AsString[SalcuAutoPipeServer_LocalBasePath]);
  end;
  Result:= f_BaseEngineHolder.BaseEngine.IsBaseFree(l_msg);
  l3System.Msg2Log(l_Msg);
 finally
  f_Progressor.StopInfinity;
 end;
end;

function TalcuServerPrim.IsBaseLocked: Boolean;
begin
 Result := f_BaseEngineHolder.IsBaseLocked;
end;

function TalcuServerPrim.LoadDeltaFiles: Boolean;
begin
{$IFDEF EveryWeek}
 l3System.Msg2Log(SalcuAutoPipeServer_NaaloimportaNSRCfaylovifaylaklyu);
 Status:= dd_apsLoadNSRC;
 Result:= False;
 if ImportDocuments then
  Result := DoLoadKW;
 Status:= dd_apsRevert;
 l3System.Msg2Log(SalcuAutoPipeServer_importNSRCfaylovifaylaklyuevyhsl);
{$ENDIF}
end;

(*procedure TalcuServerPrim.LoadDictChangeFile;
{$IFDEF SubDeletedNotify}
var
 l_Text: String;
{$ENDIF}
begin
{$IFDEF SubDeletedNotify}
 l_Text:= dictLogFileToText;
 if l_Text <> '' then
 begin
  if alcuMail.SendEmail(ddAppConfiguration.AsString['DictUpdateMail'], l_Text, 'Удаленные атрибуты меток') then
   DeleteFile(DictChangeFileName);
 end;
{$ENDIF}
end;*)

procedure TalcuServerPrim.LockBase(const aMsg: String);
begin
 f_BaseEngineHolder.BaseEngine.LockBase(aMsg);
end;

procedure TalcuServerPrim.LockBase(const aMsg: String; const aLockTime,
        aUnlockTime: TDateTime);
begin
  f_BaseEngineHolder.BaseEngine.LockBase(aMsg, aLockTime, aUnlockTime);
end;

procedure TalcuServerPrim.LogoffUsers(aManual: Boolean; theUser: IdaArchiUser = nil);
begin
 f_BaseEngineHolder.BaseEngine.LogoffUsers(theUser);
 if not aManual then
  WaitForFreeBase;
//  Delay(30);
end;

function TalcuServerPrim.MakeAndLoadDelta(aManual: Boolean): TddDeltaResult;
{$IFDEF EveryWeek}
var
 l_CanWork : Boolean;
{$ENDIF}
begin
{$IFDEF EveryWeek}
 Result := drOk;
 // Проверить наличие лог-файла
 if ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_CheckLogFile] then
  l_CanWork:= CheckDeltaReady
 else
  l_CanWork := True;
 if not l_CanWork then
 begin
  {$IFNDEF service}
  if aManual then
   l_CanWork:= alcuMsgDialog(SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg,
                          mtWarning, mbOkCancel, 0) = mrOk
  else // aManual
  {$ENDIF}
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg1);
   Result := drDelayed;
   exit;
  end; // not aManual
 end; // not l_CanWork

 // Подготовить файлы
 if l_CanWork then
 begin
  if DoPrepareDelta then
  begin
 // Импортировать документы
   if not LoadDeltaFiles then
    Result := drImportError;
  end // DoPrepareDelta
  else
   Result := drPrepareError;
 end; // l_CanWork
{$ENDIF}
end;

function TalcuServerPrim.pm_GetBaseDescription: string;
begin
 if f_BaseEngineHolder.BaseEngine = nil then
  Result:= 'Информация о базе недоступна'
 else
  Result := Format('Версия базы данных: %d%s'#13#10+
                  'Версия протокола сообщений: %d'#13#10+
                  'Расположение семейства: %s'#13#10+
                  'Работа по %s путям'#13#10+
                  'База %s для работы пользователей',
                  [f_BaseEngineHolder.BaseEngine.DataParams.DocBaseVersion, IfThen(ddAppConfiguration.AsBoolean['DictEnglish'], ' (Английская)', ''),
                   c_CsVersion,
                   f_BaseEngineHolder.BaseEngine.DataParams.DocStoragePath,
                   IfThen(ddAppConfiguration.AsBoolean['IsLocalBase'], 'локальным', 'глобальным'),
                   IfThen(f_BaseEngineHolder.BaseEngine.IsBaseLocked, 'закрыта', 'открыта')]);
end;

function TalcuServerPrim.pm_GetStatus: TalcuStatus;
begin
 Result:= f_StatusStack.Peek;
end;

procedure TalcuServerPrim.pm_SetLogMessages(const Value: Boolean);
begin
 if f_LogMessages <> Value then
 begin
  f_LogMessages := Value;
  f_BaseEngineHolder.BaseEngine.CSServer.LogMessages := f_LogMessages;
  f_MessageManager.LogMessages:= f_LogMessages;
 end;
end;

procedure TalcuServerPrim.pm_SetStatus(const Value: TalcuStatus);
begin
  if Value = dd_apsRevert then
   f_StatusStack.Pop
  else
   f_StatusStack.Push(Value);
  if Assigned(f_OnStatusChanged) then
   f_OnStatusChanged(Status{, f_QueryLen});
end;

function TalcuServerPrim.PrepareKWFile: Boolean;
var
  l_KWFileName: string;
  l_FileSize: LongInt;
begin
  if FileExists(ddAppConfiguration.AsString[SalcuAutoPipeServer_KWFileName]) then
  begin
   l_FileSize:= SizeOfFile(ddAppConfiguration.AsString[SalcuAutoPipeServer_KWFileName]);
   l_KWFileName:= ConcatDirName(ExtractFileDir(ParamStr(0)), SalcuAutoPipeServer_ComKw);
   try
    l3FileUtils.CopyFile(ddAppConfiguration.AsString[SalcuAutoPipeServer_KWFileName], l_KWFileName);
    if l_FileSize <> SizeOfFile(l_KWFileName) then
     EFilerError.Create(SalcuAutoPipeServer_KWfaylskopirovanneverno);
    Result:= True;
   except
    on E: Exception do
    begin
     Result:= False;
     l3System.Exception2Log(E);
     alcuMail.SendEmailNotify(eventPrepareKWFile, True, SalcuAutoPipeServer_Neudalos_skopirovat_faylklyuevyh, dd_apsPrepareKWFile);
    end;
   end
  end
  else
   Result:= False;
end;

procedure TalcuServerPrim.ProcessDelayedTasks;
begin
 if TaskProcessor.Processing then
  TaskProcessor.WorkupDelayed(True)
 else
 begin
  TaskProcessor.WorkupDelayed(False);
  while TaskProcessor.Processing do;
 end;
end;

procedure TalcuServerPrim.ProgressorUpdate(Sender: TObject; aPercent: Integer);
var
 l_Prg: TddProgressObject;

 function lp_GetState(aPercent: Integer): Byte;
 begin
  Result:= ifThen(aPercent  = 100, 2, 1);
 end;

begin
 l_Prg:= Sender as TddProgressObject;

 if Assigned(f_FileProc) and not l_Prg.SingleProcess then
  f_FileProc(lp_GetState(l_Prg.Percent), l_Prg.Percent, l_Prg.Caption);

 if Assigned(f_TotalProc) then
  f_TotalProc(lp_GetState(l_Prg.TotalPercent), l_Prg.TotalPercent, l_Prg.TotalCaption);
 f_TaskProcessor.NotifyProgress(l_Prg.TotalPercent, l_Prg.TotalCaption);
end;

procedure TalcuServerPrim.RegisterReplyProcedures;
begin
 with f_BaseEngineHolder.BaseEngine.CSServer do
 begin
  // Регистрация процедур обработки запросов
  RegisterReplyProcedure(qtTask, TaskProcessor.cs_ServerTaskReply);
  RegisterReplyProcedure(qtServerStatus, cs_ServerStatusReply);
  RegisterReplyProcedure(qtAllLine, TaskProcessor.cs_LineRequestReply);
  RegisterReplyProcedure(qtStartMonitoring, TaskProcessor.cs_StartMonitoringReply);
  RegisterReplyProcedure(qtStartMyMonitoring, TaskProcessor.cs_StartMyMonitoringReply);
  RegisterReplyProcedure(qtEndMonitoring, TaskProcessor.cs_StopMonitoringReply);
  RegisterReplyProcedure(qtGettask, TaskProcessor.cs_ReturnTask);
  RegisterReplyProcedure(qtGetActiveUsersList, TaskProcessor.cs_GetActiveUsers);
  RegisterReplyProcedure(qtSendMail, TaskProcessor.cs_SendMail);
  RegisterReplyProcedure(qtGetTime, TaskProcessor.cs_GetTime);
  RegisterReplyProcedure(qtGetCommonData, TaskProcessor.cs_GetCommonData);
  RegisterReplyProcedure(qtGetDictEdit, DictServer(CurrentFamily).cs_GetDictEdit);
  RegisterReplyProcedure(qtGetCommands, f_Actions.cs_GetCommands);
  RegisterReplyProcedure(qtExecuteCommand, TaskProcessor.cs_ExecuteCommand);
  RegisterReplyProcedure(qtGetVersionDate, TaskProcessor.cs_GetNextVersionDate);
  RegisterReplyProcedure(qtGetAnouncedDate, cs_GetAnouncedDate);
  RegisterReplyProcedure(qtGetBaseStatus, cs_GetBaseStatus);
  RegisterReplyProcedure(qtGetAllUsersList, cs_GetUsersList);
  RegisterReplyProcedure(qtGetExecuteStatus, TaskProcessor.cs_GetExecuteStatus);
  RegisterReplyProcedure(qtGetToRegionList, TaskProcessor.cs_GetToRegionList);
  {$IFDEF SubDeletedNotify}
  RegisterReplyProcedure(qtGetDictChangeFileName, TaskProcessor.cs_GetDictChangeFileName);
  {$ENDIF}
  RegisterReplyProcedure(qtGetLogo, cs_GetLogoReply);
  RegisterReplyProcedure(qtGetAEParams, cs_GetAEParamsReply);
  RegisterReplyProcedure(qtGetCompileDate, TaskProcessor.cs_GetCompileDate);
  RegisterReplyProcedure(qtAsyncProgress, TaskProcessor.cs_AsyncProgress);
  RegisterReplyProcedure(qtalcuGetServerUser, cs_GetServerUser);
  RegisterReplyProcedure(qtalcuSendEMail, alcuMail.cs_SendEMail);
  RegisterReplyProcedure(qtalcuSendEMailNotify, alcuMail.cs_SendEMailNotify);
  RegisterReplyProcedure(qtalcuSendSMSNotify, alcuMail.cs_SendSMSNotify);
  RegisterReplyProcedure(qtalcuSendTaskResult, TaskProcessor.cs_ReceiveTaskResult);
  RegisterReplyProcedure(qtRequestDelivery, TaskProcessor.cs_RequestDelivery);
  RegisterReplyProcedure(qtalcuAACNeedTerminate, cs_AACNeedTerminate);
  RegisterReplyProcedure(qtalcuExportResultProcessing, TaskProcessor.cs_ExportResultProcessing);
  RegisterReplyProcedure(qtalcuHandShake, TaskProcessor.cs_TransporterHandshake);
  RegisterReplyProcedure(qtalcuSendTask, TaskProcessor.cs_TaskSend);
  RegisterReplyProcedure(qtalcuTerminateTask, TaskProcessor.cs_TerminateTask);
  RegisterReplyProcedure(qtalcuSendCustomMessage, TaskProcessor.cs_CustomMessageProcessing);
 end;
end;

procedure TalcuServerPrim.RegisterSchedulerTasks;
begin
 with Scheduler do
 begin
  SetExecuteHandler(ctDeltaTask, ScheduledDeltaTask);
  SetExecuteHandler(ctUpdateTask, ScheduledUpdateTask);
  SetExecuteHandler(ctBirthdayTask, ScheduledBirthdayTask);
  SetExecuteHandler(ctHolidayTask, ScheduledHolidayTask);
  SetExecuteHandler(ctPreventiveTask, ScheduledPreventiveTask);
  SetExecuteHandler(ctAutoExportTask, ScheduledAutoExportTask);
  SetExecuteHandler(ctLoadRegions, ScheduledLoadRegionsTask);
  {$IFDEF AAC}
  SetExecuteHandler(ctAutoSubs, ScheduledAutoSubsTask);
  {$ENDIF}
  SetExecuteHandler(ctAutoclassify, ScheduledAutoClassifyTask);
  SetExecuteHandler(ctCompilation, SchedulerClientNotify);
  SetExecuteHandler(ctVersion, SchedulerClientNotify);
  SetChangeHandler(ctVersion, SchedulerClientNotify);

  SetExecuteHandler(ctUploadRegions, ScheduledUploadRegionsTask);
//  SetExecuteHandler(ctMakeDivisions_DEPRECATED, SchedulerMakeDivisions);
  SetExecuteHandler(ctRelPublish, ScheduledRelPublish);
  SetExecuteHandler(ctHavansky, ScheduledHavansky);
  SetExecuteHandler(ctCloneBase, ScheduledCloneBase);
  SetExecuteHandler(ctExportAnonced, ScheduledExportAnonced);
  SetExecuteHandler(ctExportAnoncedEx, ScheduledExportAnoncedEx);
  SetExecuteHandler(ctAnnoExport, ScheduledAnnoExport);
  {$IFDEF MDPSyncIntegrated}
  SetExecuteHandler(ctMdpSyncDicts, ScheduledMdpSyncDicts);
  SetExecuteHandler(ctMdpSyncDocs, ScheduledMdpSyncDocs);
  {$ENDIF MDPSyncIntegrated}
  SetExecuteHandler(ctContainer, SchedulerDefaultTask);

{$IFDEF RunSchedulerAsTask}
  OnTaskExecute := SchedulerTaskExecutor;
{$ELSE  RunSchedulerAsTask}
  SetCanRunHandler(ctUpdateTask, SchedulerCanRunWithoutRunningTask);
  SetCanRunHandler(ctDeltaTask, SchedulerCanRunWithoutRunningTask);
{$ENDIF RunSchedulerAsTask}
 end; // with Scheduler;
end;

procedure TalcuServerPrim.ReindexTables;
begin
end;

procedure TalcuServerPrim.RequiredEvent(aNode: TddCustomConfigNode; var Resolved: Boolean);
var
 l_S: TddScheduler;
 l_T: TddSchedulerTask;
begin
 if aNode.Value.AsObject is TddScheduler then
 begin
  Resolved:= True;
  l_S:= TddScheduler(aNode.Value.AsObject);
  // Ежедневное обновление
  if not l_S.HasTaskByType(ctUpdateTask) then
  begin
   l_T:= TddSchedulerTask.Create;
   try
    l_T.TaskType:= ctUpdateTask;
    l_T.Periodicity:= stEveryDay;
    l_T.TaskTime:= EncodeTime(0, 1, 0, 0);
    l_S.AddTask(l_T);
   finally
    FreeAndNil(l_T);
   end;
  end;
  // Компиляция
  if not l_S.HasTaskByType(ctCompilation) then
  begin
   l_T:= TddSchedulerTask.Create;
   try
    l_T.TaskType:= ctCompilation;
    l_T.Periodicity:= stEveryWeek;
    l_T.Day:= Ord(st_dowThursday);
    l_T.TaskTime:= EncodeTime(21, 0, 0, 0);
    l_S.AddTask(l_T);
   finally
    FreeAndNil(l_T);
   end;
  end;
  // Версия
  if not l_S.HasTaskByType(ctVersion) then
  begin
   l_T:= TddSchedulerTask.Create;
   try
    l_T.TaskType:= ctVersion;
    l_T.Periodicity:= stEveryWeek;
    l_T.Day:= Ord(st_dowSaturday);
    l_T.TaskTime:= EncodeTime(12, 0, 0, 0);
    l_S.AddTask(l_T);
   finally
    FreeAndNil(l_T);
   end;
  end;
 end;
end;

function TalcuServerPrim.RestartBaseEngine: Boolean;
begin
 StopBaseEngine(False);
 Result:= StartBaseEngine;
 f_BaseEngineHolder.BaseEngine.CSServer.Start(ddAppConfiguration.AsString['ServerName'], ddAppConfiguration.AsInteger['ServerPort']);
end;

procedure TalcuServerPrim.ScheduledAutoClassifyTask(const aTask: TddSchedulerTask);
begin
 DoAutoClassify;
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledAutoExportTask(const aTask: TddSchedulerTask);
begin
 DoAutomaticExport;
 aTask.ExecuteResult := strOk;
end;

{$IFDEF AAC}
procedure TalcuServerPrim.ScheduledAutoSubsTask(const aTask: TddSchedulerTask);
var
 l_Params: TcsCourtDecisionSabCheckerParams;
begin
 l_Params := MakeCourtDecisionSabCheckerParams;
 try
  TalcuCourtDecisionSubChecker.CheckByDate(l_Params);
  {$IFNDEF Region}
  ddAppConfiguration.AsDateTime['CD_FromDate']:= l_Params.LastUpdateDate;
  ddAppConfiguration.Save;
  {$ENDIF}
 finally
  FreeAndNil(l_Params);
 end;
 aTask.ExecuteResult := strOk;
end;
{$ENDIF}

procedure TalcuServerPrim.SchedulerTaskColor(aTaskType: TddCalendarTaskType; out aColor: TColor);
begin
  aColor:= ddCalendarEventArray[aTaskType].Color;
end;

procedure TalcuServerPrim.ScheduledUpdateTask(const aTask: TddSchedulerTask);
begin
 aTask.ExecuteResult := DoEveryDayUpdate;
end;

procedure TalcuServerPrim.ScheduledDeltaTask(const aTask: TddSchedulerTask);
begin
 case DoEveryWeekUpdate of
  drOk: aTask.ExecuteResult := strOk;
  drDelayed: aTask.ExecuteResult := strOk;
 else
  aTask.ExecuteResult := strFailed;
 end;
end;

procedure TalcuServerPrim.ScheduledBirthdayTask(const aTask: TddSchedulerTask);
begin
 SendBirthdayGreeting(aTask.Caption);
end;

procedure TalcuServerPrim.ScheduledHolidayTask(const aTask: TddSchedulerTask);
begin
 f_BaseEngineHolder.BaseEngine.CSServer.Notifier.SendNotify(c_AllClients, ntInformation, 0, SysUtils.Format(rsHolidayMask, [aTask.Caption]));
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledLoadRegionsTask(const aTask: TddSchedulerTask);
begin
 DoLoadRegions;
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledPreventiveTask(const aTask: TddSchedulerTask);
begin
 DoPreventiveUpdate(False);
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledUploadRegionsTask(const aTask: TddSchedulerTask);
begin
 DoUploadRegions;
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.SchedulerDefaultTask(const aTask: TddSchedulerTask);
begin
 aTask.ExecuteResult := strOk;
end;
(*
procedure TalcuServerPrim.SchedulerMakeDivisions(const aTask: TddSchedulerTask);
begin
 with TalcuSectionMaker.Create do
 try
  Execute(f_Progressor);
 finally
  Free;
 end;
 aTask.ExecuteResult := strOk;
end;
*)
procedure TalcuServerPrim.SendBirthdayGreeting(const UserName: String);
begin
 // Послать всем пользователям сообщение о том, что сегодня день рождения UserName
 // Добавить сообщение в список Сообщение дня (сообщения из этого списка отправляются всем входящим в Арчи
end;

procedure TalcuServerPrim.SendEmailNotify;
var
 l_Address, l_Subject, l_Body: String;
begin
 l_Address := ddAppConfiguration.AsString[SalcuAutoPipeServer_NotifyAddress];
 l_Subject := '';
 l_Body := '';
 with TEmailMessage.Create(Application) do
 try
  if Execute(l_Address, l_Subject, l_Body) then
   alcuMail.SendEmail(l_Address, l_Body, l_Subject);
 finally
  Free;
 end;
end;

procedure TalcuServerPrim.sendErrorReport(Missed: TalcuMissedTasks);
var
 l_S: String;
begin
 if Missed <> [] then
 begin
  if (taskBackup in Missed) then
  begin
   l_S:= SalcuAutoPipeServer_Faylklyuevyhslovneimportirovan;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventEveryDay, True, l_S, Status);
  end; // LoadKW
  {$IFDEF DailyImportKW}
  if (taskKW in Missed) and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoImportKW] then
  begin
   l_S:= SalcuAutoPipeServer_Faylklyuevyhslovneimportirovan;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventKeywords, True, l_S, Status);
  end; // LoadKW
  {$ENDIF}
  if (taskUpdateBase in Missed) and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateBase] then
  begin
   l_S:= SalcuAutoPipeServer_Obnovleniebazydannyhnevypoleneno;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventEveryDay, True, l_S, Status);
  end; // UpdateBase

  if (taskHeaderIndex in Missed) and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoHeaderIndex] then
  begin
   l_S:= SalcuAutoPipeServer_Obnovlenieindeksazagolovkovnevyp;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventEveryDay, True, l_S, Status);
  end; // HeaderIndex

  if (taskTextIndex in Missed) and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_DoUpdateIndex] then
  begin
   l_S:= SalcuAutoPipeServer_Obnovlenietekstovogoindeksanevyp;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventTextIndex, True, l_S, Status);
  end; // UpdateIndex

  if (taskCommitImg in Missed) then
  begin
   l_S:= SalcuAutoPipeServer_NoImgCacheIsUpdated;
   f_Report.Add(l_S);
   alcuMail.SendEmailNotify(eventEveryDay, True, l_S, Status);
  end; // UpdateIndex
 end; // Missed <> []
end;

function TalcuServerPrim.SendKWToRegions: Boolean;
{$IFDEF KWSending}
var
 l_Result: Integer;
 l_FileName, l_Address, l_Msg: string;
 l_A: TStrings;
{$ENDIF}
begin
{$IFDEF KWSending}
  Result:= False;
  with ddAppConfiguration do
  begin
   l_Address:= AsString['KWRecepients'];
  end;
  if (l_Address <> '') then
  begin
   {$IFDEF Service}
   l_FileName:= ConcatDirName(GetWindowsTempFolder, 'keywords.zip');
   {$ELSE}
   l_FileName:= ConcatDirName(ExtractFileDir(Application.ExeName), 'keywords.zip');
   {$ENDIF}
   l_A:= TStringList.Create;
   try
    l_A.Add(ddAppConfiguration.AsString['KWFileName']);
    { TODO -oДмитрий Дудко -cУлучшение : Добавляем таблички... Желательно, не зашивая в код, а выбирая из настроек }
    l_A.Add(ConcatDirName(f_BaseEngineHolder.BaseEngine.GetFamilyPath(CurrentFamily), 'dt#1*.*'));
    l_A.Add(ConcatDirName(f_BaseEngineHolder.BaseEngine.GetFamilyPath(CurrentFamily), 'dt#2*.*'));
    l_A.Add(ConcatDirName(f_BaseEngineHolder.BaseEngine.GetFamilyPath(CurrentFamily), 'dt#8*.*'));
    ZipFiles(l_FileName, l_A);
   finally
    FreeAndNil(l_A);
   end;
   l_Msg:= SalcuAutoPipeServer_Arhivsklyuamisozdan;
   l3System.Msg2Log(l_Msg);
   l_A:= TStringList.Create;
   try
    l_A.Add(l_FileName);
    alcuMail.SendEMail(l_Address,
                      SalcuAutoPipeServer_Oerednayaversiyafaylaklyuevyhslo,
                      SalcuAutoPipeServer_Faylklyuevyhslov, False, l_A);
    {$IFDEF Service}
    DeleteFile(l_FileName);
    {$ENDIF}
   finally
    l3Free(l_A);
   end;
   Result:= True;
  end;
{$ELSE}
 Result:= True
{$ENDIF}
end;

procedure TalcuServerPrim.SendMessage(theUser: IdaArchiUser; theMessage:
    String; theLockBase: Boolean; theStartLock, theStopLock: TDateTime);
var
  l_ID: TcsClientID;
begin
 if theUser = nil then
  l_ID:= c_AllClients
 else
  l_ID := theUser.ID;
 f_Messagemanager.SendTextMessage(l_ID, theMessage, 1);
 if theLockBase then
  f_BaseEngineHolder.BaseEngine.LockBase(theMessage, theStartLock, theStopLock);
end;

procedure TalcuServerPrim.cs_ServerStatusReply(aPipe: TCsDataPipe);
begin
 with aPipe do
 begin
  WriteLn(TalcuStatusNames[f_TaskProcessor.Status]);//Status
  WriteInteger(f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.ClientsCount);//UsersCount
  WriteInteger(f_TaskProcessor.LineLen);//LineLength
 end;
end;

procedure TalcuServerPrim.InitiateShutdownWithAbort;
begin
 if f_ShutdownMode = alcu_smUnknown then
 begin
  l3System.Msg2Log(SalcuAutoPipeServer_AbortProcessing);
  TaskExecutionEnabled := False;
  f_TaskProcessor.FreezeQueryQueue(False);
  Scheduler.DisableSchedule;
  if (f_DB <> nil) then
  begin
   f_DB.Stop;
   f_CanClose := False;
  end;
  f_ShutdownMode := alcu_smTerminate;
 end;
end;

procedure TalcuServerPrim.SetAnnoExportEnabled(const Value: Boolean);
begin
 if Value then
  f_TaskProcessor.IncludeTaskType(cs_ttAnnoExport)
 else
  f_TaskProcessor.ExcludeTaskType(cs_ttAnnoExport);
 if not f_TaskProcessor.Processing then
   f_TaskProcessor.ProcessQuery;
end;

procedure TalcuServerPrim.SetAutoClassEnabled(const Value: Boolean);
begin
 if Value then
  f_TaskProcessor.IncludeTaskType(cs_ttAutoClass)
 else
  f_TaskProcessor.ExcludeTaskType(cs_ttAutoClass);
 if not f_TaskProcessor.Processing then
  f_TaskProcessor.ProcessQuery;
end;

procedure TalcuServerPrim.SetTaskExecutionEnabled(Value: Boolean);
begin
 if not IsShutdowning then
  f_TaskProcessor.TaskExecutionEnabled := Value;
end;

procedure TalcuServerPrim.SetExportEnabled(const Value: Boolean);
begin
 if Value then
  f_TaskProcessor.IncludeTaskType(cs_ttExport)
 else
  f_TaskProcessor.ExcludeTaskType(cs_ttExport);
 if not f_TaskProcessor.Processing then
  f_TaskProcessor.ProcessQuery;
end;

procedure TalcuServerPrim.SetImportEnabled(const Value: Boolean);
begin
 if Value then
  f_TaskProcessor.IncludeTaskTYpe(cs_ttImport)
 else
  f_TaskProcessor.ExcludeTaskType(cs_ttImport);
  if not f_TaskProcessor.Processing then
  f_TaskProcessor.ProcessQuery;
end;

procedure TalcuServerPrim.SetRealStopTime(MinDelta : Integer);
begin
{
  StopTime     - время, до которого все процессы должны закончиться
  MinDelta     - минимальный запас до финального срока
  RealStopTime - реальное время, не позднее которого все должно закончиться
}
  // Учли допуск
  f_RealStopTime := IncHour(StopTime, -MinDelta);
  // Подставили время в текущую дату
  ReplaceDate(f_RealStopTime, Today);
  // Время имеет смысл только для рабочих дней
  if ddAppConfiguration.AsBoolean['ExcludeWeekend'] then
   while DateUtils.DayOfTheWeek(f_RealStopTime) in [DaySaturday, DaySunday] do
    f_RealStopTime:= IncDay(f_RealStopTime);

  if CompareDateTime(Now, f_RealStopTime) = GreaterThanValue then
  // если сегодня время останова уже прошло, увеличиваем день
   f_RealStopTime:= IncDay(f_RealStopTime);
 l3System.Msg2Log('Крайний срок окончания %s', [DateTimeToStr(f_RealStopTime)]);
end;

procedure TalcuServerPrim.SetStopTime(const Value: TDateTime);
begin
 ddAppConfiguration.AsDateTime['WorkDayStart'] := Value;
end;

function TalcuServerPrim.Start: Boolean;
begin
 if StartBaseEngine then
 begin
  Scheduler.Run;
  CalculateAnonceDate;
  Result:= True;
{$IFDEF MDPSyncIntegrated}
  f_DictSynchronizator.Start;
{$ENDIF MDPSyncIntegrated}
 end
 else
  Result:= False;
end;

function TalcuServerPrim.StartBaseEngine: Boolean;
var
 l_BaseEngine: TalcuBaseEngine;
 l_DataParams: ThtDataProviderParams;
 l_BaseRoot: String;

begin
 l3System.Msg2Log(SalcuAutoPipeServer_Zapuskmehanizmadostupakbazedanny);
 Status:= dd_apsStartBaseEngine;
 Result:= False;

 l_DataParams := TdaDataProviderSuperFactory.Instance.MakeFromConfig as ThtDataProviderParams;
 try
  l_DataParams.UserID := usServerService;
  l_BaseEngine:= TalcuBaseEngine.Make(l_DataParams, ddAppConfiguration.AsString['ServerName'], ddAppConfiguration.AsInteger['ServerPort'], f_AutolinkEnabled);
  try
    f_BaseEngineHolder.BaseEngine := l_BaseEngine;
  finally
    l3Free(l_BaseEngine);
  end;
 finally
  FreeAndNil(l_DataParams);
 end;

 if f_BaseEngineHolder.BaseEngine.Start then
 begin
  if CheckAtStartup then CheckBases(False);
  CheckAtStartup:= False;
  InitEndings(f_BaseEngineHolder.BaseEngine.GetFamilyPath(CurrentFamily));
//  UserManager.OnUserActiveChange := UserStatusChange;
  GlobalDataProvider.UserManager.RegisterUserStatusChangedSubscriber(Self);
  f_BaseEngineHolder.BaseEngine.CSServer.OnEvent := CSServerEvent;
  RegisterReplyProcedures;

  f_CurPath:= ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily));
  GlobalDataProvider.SubscribeLongProcess(Self);
  if MailServer = nil then
  begin
   MailServer:= TMailServer.Create;
   MailServer.MessageManager := f_MessageManager;
  end;

  f_MessageManager.CSServer := f_BaseEngineHolder.BaseEngine.CSServer;
  TaskProcessor.MessageManager := f_MessageManager;
  GlobalDataProvider.UserManager.MakeFullArchiUsersList;
  TaskProcessor.WorkThreadCount := ddAppConfiguration.AsInteger['WorkThreadCount'];
  DictServer(CurrentFamily).MessageManager := f_MessageManager;
  DictServer(CurrentFamily).BiLingual := ddAppConfiguration.AsBoolean['DictEnglish'];
  // Запуск сервера после того, как все процедуры зарегистрированы
  f_BaseEngineHolder.BaseEngine.CSServer.Start(ddAppConfiguration.AsString['ServerName'], ddAppConfiguration.AsInteger['ServerPort']);
  f_TaskProcessor.LoadQuery;
  f_RefreshTimer.Enabled := True;
  Result:= True;
 end;
 Status:= dd_apsRevert;
end;

function TalcuServerPrim.Stop: Boolean;
begin
 if f_Stopped then
  Result := true
 else
 begin
  f_CS.Acquire;
  try
   if GlobalDataProvider <> nil then
    GlobalDataProvider.UserManager.UnRegisterUserStatusChangedSubscriber(Self);
   Scheduler.Stop;
{$IFDEF MDPSyncIntegrated}
   f_DictSynchronizator.Stop;
{$ENDIF MDPSyncIntegrated}
   Result := StopBaseEngine(True);
  finally
   f_CS.Release;
  end;//try..finally
 end;//f_Stopped
end;

procedure TalcuServerPrim.StopAndGoQuery(aTask: TddProcessTask);
begin
  f_TaskProcessor.StopProcessQuery(aTask);
end;

function TalcuServerPrim.StopBaseEngine(const aPermanent: Boolean = True): Boolean;
var
 l_S: String;
begin
 Result:= True; { TODO -cРазвитие : Для сервиса нужно возвращать значение }
 if (f_BaseEngineHolder.BaseEngine <> nil) and f_BaseEngineHolder.BaseEngine.IsStarted then
 begin
 { TODO : Предусмотреть возможно останавливать без уничтожения }
  f_RefreshTimer.Enabled:= False;
  if aPermanent then
   l_S := SalcuAutoPipeServer_Polnaya
  else
   l_S := SalcuAutoPipeServer_Vremennaya;
  l3System.Msg2Log(l_S + SalcuAutoPipeServer_ostanovkamehanizmadostupakbazeda);
   if aPermanent then
   begin
    l3Free(MailServer);
   end; // if aPermanent
   if GlobalDataProvider <> nil then
   begin
    GlobalDataProvider.UnSubscribeLongProcess(Self);
   end;
   f_BaseEngineHolder.BaseEngine.Stop; //(aPermanent, aPermanent and ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_ShowSplash]);
   f_BaseEngineHolder.BaseEngine := nil;
  l3System.Msg2Log('Механизм остановлен');
 end;// (f_BaseEngine <> nil) and f_BaseEngine.IsStarted
end;

function TalcuServerPrim.SwitchToRealBase: Boolean;
begin
 Status:= dd_apsStopBaseEngine;
  if ddAppConfiguration.AsString[SalcuAutoPipeServer_LocalBasePath] <> '' then
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Pereklyuenienapostoyannuyubazu);
   ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_IsLocalBase] := False;
   ddAppConfiguration.Save;
   RestartBaseEngine;
   l3System.Msg2Log(SalcuAutoPipeServer_Pereklyuenienapostoyannuyubazu+' done');
  end
  else
   Result:= True;
  UnlockBase;
  Status:= dd_apsRevert;
  l3System.Msg2Log(SalcuAutoPipeServer_Pereklyuenienapostoyannuyubazu+' UnlockBase done');
end;

function TalcuServerPrim.SwitchToTemporaryBase: Boolean;
begin
  if (ddAppConfiguration.AsString[SalcuAutoPipeServer_LocalBasePath] <> '') and
     not ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_IsLocalBase] then
  begin
   l3System.Msg2Log(SalcuAutoPipeServer_Pereklyuenienavremennuyubazu);
   LockBase('База используется в монопольном режиме');
   ddAppConfiguration.AsBoolean[SalcuAutoPipeServer_IsLocalBase] := True;
   ddAppConfiguration.Save;
   RestartBaseEngine;
   l3System.Msg2Log(SalcuAutoPipeServer_Pereklyuenienavremennuyubazu+' done');
  end
  else
   Result:= True;
end;

function TalcuServerPrim.UndoMakeBackup(const AskUser: Boolean = False):
        Boolean;
var
  l_FileOp: TStFileOperation;
  l_YesterdayPath: string;
  l_DayOfWeek: Integer;
  SR: TSearchRec;
  l_Do: Boolean;
begin
  Result:= True;
  if f_Busy then Exit;
  try
   f_Busy:= True;
   TaskProcessor.LockProcessing;
   try
    DisableProcessing;
    try
     l3System.Msg2Log(SalcuAutoPipeServer_Naalovosstanovleniyabazy);
     Status:= dd_apsUndoBackup;

     { Здесь лучше предложить список баз, на которые можно откатиться}
     // Добавляем день недели к каталогу для многодневного копирования
     l_DayOfWeek:= SysUtils.DayOfWeek(SysUtils.Date)-1;
     if l_DayOfWeek < 0 then
      l_DayOfWeek:= 6;

     l_YesterdayPath:= GetYesterdayPath(True);
     if DirectoryExists(l_YesterdayPath) then
     begin
      {$IFNDEF Service}
      if AskUser then
       l_Do:= alcuMsgDialog(SalcuAutoPipeServer_Vydeystvitel_nohotitevosstanovit+
                    SalcuAutoPipeServer_PotomVysmozheteotmenit_vosstanov,
         mtConfirmation, [mbYes, mbNo], 0) = mrYes
      else
      {$ENDIF}
       l_Do:= True;

      if l_Do then
      begin
       StopBaseEngine(False);
       // Нужно сделать резервную копию текущего состояния на всякий случай
       l_FileOp  := TStFileOperation.Create({$IFDEF Service}nil{$ELSE}f_MainForm{$ENDIF});
       try
        l_FileOp.ConfirmFiles:= False;
        l_FileOp.Options:= l_FileOp.Options+
                           [foNoConfirmMkDir, foNoConfirmation, foNoErrorUI]-
                           [foRenameCollision, foAllowUndo];
        l_FileOp.Destination:= GetUndoRestorePath;
        l_FileOp.SourceFiles.Add(f_CurPath);
        l_FileOp.Execute;
       finally
        l_FileOp.Free;
       end; // l_FileOp

       PureDir(f_CurPath); // Очистка предыдущей копии


       l_FileOp  := TStFileOperation.Create({$IFDEF Service}nil{$ELSE}f_MainForm{$ENDIF});
       try
        l_FileOp.ConfirmFiles:= False;
        l_FileOp.Options:= l_FileOp.Options+
                           [foNoConfirmMkDir, foNoConfirmation, foFilesOnly]-
                           [foAllowUndo];
        l_FileOp.Destination:= f_CurPath;
        // Видимо, здесь нужно собрать список файлов
        if FindFirst(l_YesterdayPath+SalcuAutoPipeServer_Garant, faAnyFile and not faDirectory, sr) = 0 then
        try
         l_FileOp.SourceFiles.Add(ConcatDirName(l_YesterdayPath+SalcuAutoPipeServer_Garant1, SR.Name));
         while FindNext(sr) = 0 do
          l_FileOp.SourceFiles.Add(ConcatDirName(l_YesterdayPath+SalcuAutoPipeServer_Garant1, SR.Name));
         finally
          SysUtils.FindClose(sr);
         end; // FindFirst
         l_FileOp.Execute;
        finally
         l_FileOp.Free;
         f_Busy:= False;
        end;
        if CheckBackup(l_YesterdayPath+SalcuAutoPipeServer_Garant2, f_CurPath) then
        begin
         StartBaseEngine;
         l3System.Msg2Log(SalcuAutoPipeServer_Vosstanovleniebazyzaversheno);
        end
        else
         LockBase('');
      end;
     end
     {$IFNDEF Service}
     else
      alcuShowMsg(SalcuAutoPipeServer_Verashnyayakopiyaneobnaruzhena);
     {$ENDIF}
    finally
     EnableProcessing;
    end;
   finally
    TaskProcessor.UnLockProcessing;
   end;
  except
   on E: Exception do
   begin
    l3System.Msg2Log(SalcuAutoPipeServer_Oshibkavosstanovleniyabazy);
    Exception2Log(E);
    Result:= False;
   end;
  end;
  f_Busy:= False;
  Status:= dd_apsRevert;
end;

procedure TalcuServerPrim.UndoRestoreBackup;
var
  l_FileOp: TStFileOperation;
  SR: TSearchRec;
begin
  if DirectoryExists(GetUndoRestorePath) then
   {$IFNDEF Service}
   if alcuMsgDialog(SalcuAutoPipeServer_Vydeystvitel_nohotiteotmenit_vos,
       mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   {$ENDIF}
   begin
    TaskProcessor.LockProcessing;
    try
     DisableProcessing;
     try
      StopBaseEngine(False);

      l_FileOp  := TStFileOperation.Create({$IFDEF Service}nil{$ELSE}f_MainForm{$ENDIF});
      try
       l_FileOp.ConfirmFiles:= False;
       l_FileOp.Options:= l_FileOp.Options+
                                [foNoConfirmMkDir, foNoConfirmation, foFilesOnly]-
                                [foAllowUndo];
       l_FileOp.Destination:= f_CurPath;
       // Видимо, здесь нужно собрать список файлов
       if FindFirst(GetUndoRestorePath+'\*.*', faAnyFile and not faDirectory, sr) = 0 then
       try
        l_FileOp.SourceFiles.Add(ConcatDirName(GetUndoRestorePath, SR.Name));
        while FindNext(sr) = 0 do
         l_FileOp.SourceFiles.Add(ConcatDirName(GetUndoRestorePath, SR.Name));
       finally
        SysUtils.FindClose(sr);
       end; // FindFirst
       l_FileOp.Execute;
      finally
       l_FileOp.Free;
       f_Busy:= False;
      end;
      if CheckBackup(GetUndoRestorePath, f_CurPath) then
      begin
       if AllowPurgeDir(GetUndoRestorePath) then
        DelDir(GetUndoRestorePath)
       else
        l3System.Msg2Log('Не удалось очистить папку UndoRestorePath - она совпадает с папкой сервера');
       StartBaseEngine;
       l3System.Msg2Log(SalcuAutoPipeServer_Vosstanovleniebazyzaversheno);
      end
      else
       LockBase('');
     finally
      EnableProcessing;
     end;
    finally
     TaskProcessor.UnLockProcessing;
    end;
   end;
end;

procedure TalcuServerPrim.UnlockBase;
begin
 f_BaseEngineHolder.BaseEngine.UnlockBase;
end;

{$IFDEF AAC}
procedure TalcuServerPrim.UpdateAAC(const aFolder: String; aManual: Boolean);
var
 l_Task: TalcuAACImport;
begin
 l_Task := TalcuAACImport.Create(usServerService, aManual);
  try
   l_Task.TaskFolder := TaskProcessor.RootTaskFolder;
   l_Task.SourceDir := aFolder;
   TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end
end;
{$EndIF AAC}

procedure TalcuServerPrim.DoYeld;
begin
 if Assigned(f_OnYeld) then f_OnYeld(Self);
end;

function TalcuServerPrim.FindPublInfoFile: String;
var
 l_Y, l_M, l_D: Word;
begin
 Result := '';
 if DirectoryExists(ddAppConfiguration.AsString['aiRelFolder']) then
 begin
  // дата_месяц_год _AUTOSP.CFG
  //DecodeDate(SysUtils.date, l_Y, l_M, l_D);
  //Result:= ConcatDirName(ddAppConfiguration.AsString['aiRelFolder'], Format('%.2d_%.2d_%.4d_autosp.cfg', [l_D, l_M, l_Y]));
  Result:= ConcatDirName(ddAppConfiguration.AsString['aiRelFolder'], 'autosp.cfg');
 end;
end;

procedure TalcuServerPrim.MakeFolderCopy(const aFromFolder, aToFolder: string);
begin
 {$IFDEF UseArchiCopyFile}
 if ddAppConfiguration.AsBoolean['UseSystemCopy'] then
  CopyFolder(aFromFolder, aToFolder)
 else
  CopyDirEx(aFromFolder, aToFolder, Progressor.ProcessUpdate);
 {$ELSE}
 CopyFolder(aFromFolder, aToFolder)
 {$ENDIF}
end;

procedure TalcuServerPrim.MakeRelPublishTask;
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctRelPublish, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TalcuServerPrim.ScheduledHavansky(const aTask: TddSchedulerTask);
var
 l_Task : TddProcessTask;
begin
 {$IFDEF HavanskyExport}
 if CreateSchedulerTask(ctHavansky, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
 {$ENDIF}
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledRelPublish(const aTask: TddSchedulerTask);
begin
 {$IFDEF AutoSP}
 if Scheduler.ScheduleEnabled then
  MakeRelPublishTask;
 {$ENDIF}
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.cs_GetAEParamsReply(aPipe: TCsDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 with aPipe do
 begin
  l_Stream:= Tl3MemoryStream.Make;
  try
  //Записать в трубу параметры АЭ
   Tl3LongintList(ddAppConfiguration.AsObject['aiAccGroups']).Save(l_Stream);
   Tl3LongintList(ddAppConfiguration.AsObject['aiBases']).Save(l_Stream);
   Tl3LongintList(ddAppConfiguration.AsObject['aiFullAccGroups']).Save(l_Stream);
   l_Stream.Seek(0, 0);
   WriteStream(l_Stream);
  finally
   FreeAndNil(l_Stream);
  end;
 end;
end;

procedure TalcuServerPrim.cs_GetAnouncedDate(aPipe: TCSDataPipe);
var
 l_Date: TDateTime;
begin
 f_CS.Acquire;
 try
  l_Date := f_AnonceDate;
  aPipe.WriteDateTime(l_Date);
 finally
  f_CS.Leave;
 end;
end;

procedure TalcuServerPrim.DoAutomaticAnoncedExport(anOnThursdayMode: Boolean; aUserID: TdaUserID = usServerService);
var
 l_Task: TddProcessTask;
begin
 l_Task:= MakeAutomaticAnoncedExportTask(anOnThursdayMode, aUserID);
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  l3Free(l_Task);
 end;
end;

procedure TalcuServerPrim.ScheduledExportAnonced(const aTask: TddSchedulerTask);
begin
 DoAutomaticAnoncedExport(False);
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledExportAnoncedEx(const aTask: TddSchedulerTask);
begin
 DoAutomaticAnoncedExport(True);
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledCloneBase(const aTask: TddSchedulerTask);
begin
 {$IFDEF OvgaExport}
 if Scheduler.ScheduleEnabled then
  MakeOvgaExport;
 {$ENDIF}
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.UpdateAutoLinkCache;
begin
 if f_AutolinkEnabled then
 begin
  alcuAutoLinkUpdater.UpdateAutoLinkCache(f_Progressor);
  if ddAppConfiguration.AsInteger['alcMode'] = 0 then
   ExportAutoLinkCache
  else
   ImportAutoLinkCache(f_Progressor);
 end;
end;

procedure TalcuServerPrim.UpdateRequestLists;
begin
 Inc(f_UpdateRequestListCounter);
 try
  CheckReportMemoryUsage;
  TaskProcessor.ProcessIncomingTasks;
  f_MessageManager.ProcessList;
  Scheduler.CheckDelayedTasks;
 finally
  Dec(f_UpdateRequestListCounter);
 end;
end;

procedure TalcuServerPrim.UpdateUserList;
begin
 if f_BaseEngineHolder.BaseEngine <> nil then
  f_BaseEngineHolder.BaseEngine.UpdateUserList;
end;
(*
procedure TalcuServerPrim.UserStatusChange(UserId : TdaUserID; Active : Boolean);
var
  l_Index: Integer;
  l_User: IdaArchiUser;
  l_Info: TcsClientInfo;
begin
 if UserID <> usServerService then
 begin
  l_User := GlobalDataProvider.UserManager.UserByID(UserID);
  if l_User <> nil then
  begin
   f_MessageManager.DropAllMessagesForUser(UserId);
   if Active then
   begin
    f_Updated:= False;
    l_Info := f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.ClientInfoOf(UserID);
    if Assigned(l_Info) then
    begin
      l_User.IP:= l_Info.ListenIp;
      f_MessageManager.SendNotify(UserID, ntAnouncedDateChanged, 0, 'Обновление даты анонсирования');
      f_MessageManager.SendNotify(UserID, ntCalendar, Ord(ctVersion), 'Обновление даты версии');
    end;
   end;
   {$IFNDEF Service}
   if not f_LockLog then // Индикация входа-выхода
   begin
    if Assigned(f_OnUserListUpdated) then
     f_OnUserListUpdated(l_User, Active);
    Application.ProcessMessages;
   end; // if not f_LockLog
   {$ENDIF}
  end;
 end;
end;
*)
function TalcuServerPrim.ValidTime: Boolean;
begin
  Result:= CompareDateTime(Now, f_RealStopTime) = LessThanValue;
end;

procedure TalcuServerPrim._PrepareTimer(Sender: TObject);
begin
 raise Exception.Create(SalcuAutoPipeServer_VremyapodgotovkiDel_tyisteklo);
end;

procedure TalcuServerPrim._TaskManagerStatusChange(aStatus: TalcuStatus{; aQueryLen:
    Integer});
begin
 Status:= aStatus;
end;

procedure TalcuServerPrim._TimerEvent(Sender: TObject);
begin
 UpdateRequestLists;
end;

procedure TalcuServerPrim._AnoncedTimerEvent(Sender: TObject);
begin
 CalculateAnonceDate;
end;

procedure TalcuServerPrim._YeldProcess(Sender: TObject);
begin
 DoYeld
end;

function TalcuServerPrim.pm_GetServerHostName: String;
begin
  Result := f_BaseEngineHolder.BaseEngine.ServerHostName;
end;

function TalcuServerPrim.pm_GetServerPort: Integer;
begin
  Result := f_BaseEngineHolder.BaseEngine.ServerPort;
end;

procedure TalcuServerPrim.CheckUserLogined(UserID: TdaUserID;
  var isLogined: Boolean);
begin
  isLogined := f_BaseEngineHolder.BaseEngine.CSServer.ActiveCLients.IsLogged(UserID);
end;

procedure TalcuServerPrim.cs_GetServerUser(aPipe: TCsDataPipe);
begin
  aPipe.WriteCardinal(GlobalDataProvider.UserID);
end;

{$IFDEF ExchangeDocs}
procedure TalcuServerPrim.ClearDeltasFolders;
begin
 l3System.Msg2Log('Очистка папок внешних дельт');
 if AllowPurgeDir(ddAppConfiguration.AsString['regDestinationsArchive']) and AllowPurgeDir(ddAppConfiguration.AsString['regSourcesArchive']) then
 begin
  PureDirAged(ddAppConfiguration.AsString['regDestinationsArchive'], cExternalDeltaMaxAge);
  PureDirAged(ddAppConfiguration.AsString['regSourcesArchive'], cExternalDeltaMaxAge);
 end
 else
  l3System.Msg2Log('Не удалось очистить папки внешних дельт - они совпадает с папкой сервера');
 l3System.Msg2Log('Очистка папок внешних дельт завершена');
end;
{$ENDIF ExchangeDocs}

{$IFDEF AAC}
procedure TalcuServerPrim.ClearAACLogFolder;
var
 l_Days: Integer;
begin
 l_Days := ddAppConfiguration.AsInteger['lcMaxLogAge'];
 if l_Days <= 0 then
 begin
  l3System.Msg2Log('Логи AAC не удаляются (как указано в настройках)');
  Exit;
 end;
 l3System.Msg2Log('Очистка логов AAC');
 if AllowPurgeDir(ddAppConfiguration.AsString['regDestinationsArchive']) and AllowPurgeDir(ddAppConfiguration.AsString['regSourcesArchive']) then
  PureDirAged(ddAppConfiguration.AsString['lcArchive'], l_Days)
 else
  l3System.Msg2Log('Не удалось очистить папку логов AAC - она совпадает с папкой сервера');

 l3System.Msg2Log('Очистка логов AAC завершена');
end;
{$ENDIF AAC}

procedure TalcuServerPrim.InitiateShutdownWithWait;
begin
 if f_ShutdownMode = alcu_smUnknown then
 begin
  l3System.Msg2Log(SalcuAutoPipeServer_StopProcessing);
  TaskExecutionEnabled := False;
  Scheduler.DisableSchedule;
  f_ShutdownMode := alcu_smWait;
 end;
end;

function TalcuServerPrim.IsShutdowning: Boolean;
begin
 Result := f_ShutdownMode <> alcu_smUnknown;
end;

function TalcuServerPrim.CanCloseWithWait: Boolean;
begin
 Result := CanClose;
 if Assigned(f_TaskProcessor) then
  Result := Result and not f_TaskProcessor.ExecutingTask(True);
end;

function TalcuServerPrim.CopyBackupToVersion: TddSchedulerTaskResult;
begin
 if TaskProcessor.Processing then
 begin
  Result := strRequestDelay;
  l3System.Msg2Log('Копирование версии не может быть запущено - выполняется другая задача');
  Exit;
 end;
 Result := strFailed;
 TaskProcessor.LockAsyncRun;
 DisableProcessing;
 TaskProcessor.LockProcessing;
 Status:= dd_apsCopyBackupToVersion;
 try
  LockBase(rsEveryDayUpdate);
  try
   if IsBaseFree(True) then
   begin
    Tm3DB.MakeExclusive(ConcatDirName(f_CurPath, SalcuAutoPipeServer_Bserv001)).CopyBackupToVersion;
    l3System.Msg2Log('Версия скопирована из бэкапа');
    Result := strOk;
   end
   else
    l3System.Msg2Log('Версия НЕ скопирована из бэкапа. На базе пользователи.');
  finally
   UnlockBase;
  end;
 finally
  Status:= dd_apsRevert;
  TaskProcessor.UnLockProcessing;
  EnableProcessing;
  TaskProcessor.UnLockAsyncRun;
 end;
end;

function TalcuServerPrim.CopyVersionToBackup: TddSchedulerTaskResult;
begin
 if TaskProcessor.Processing then
 begin
  Result := strRequestDelay;
  l3System.Msg2Log('Копирование версии не может быть запущено - выполняется другая задача');
  Exit;
 end;
 Result := strFailed;
 TaskProcessor.LockAsyncRun;
 DisableProcessing;
 TaskProcessor.LockProcessing;
 Status:= dd_apsCopyVersionToBackup;
 try
  LockBase(rsEveryDayUpdate);
  try
   if IsBaseFree(True) then
   begin
    Tm3DB.MakeExclusive(ConcatDirName(f_CurPath, SalcuAutoPipeServer_Bserv001)).CopyVersionToBackup;
    l3System.Msg2Log('Версия скопирована в бэкап');
    Result := strOk;
   end
   else
    l3System.Msg2Log('Версия НЕ скопирована в бэкап. На базе пользователи.');
  finally
   UnlockBase;
  end;
 finally
  Status:= dd_apsRevert;
  TaskProcessor.UnLockProcessing;
  EnableProcessing;
  TaskProcessor.UnLockAsyncRun;
 end;
end;

function TalcuServerPrim.WaitForFreeBase(aTimeOut: Integer): Boolean;
var
 l_TickCountStart: Cardinal;
begin
 Result := False;
 repeat
  l_TickCountStart := GetTickCount;
  Result := not f_BaseEngineHolder.BaseEngine.HasActiveUsers;
  if not Result then
  begin
   Sleep(100);
   {$IFNDEF Service}
   Application.ProcessMessages;
   {$ENDIF}
   Dec(aTimeOut, GetTickCount - l_TickCountStart);
  end;
 until (aTimeOut < 0) or Result;
end;

function TalcuServerPrim.AllowPurgeDir(const aDir: TFileName): Boolean;
begin
 Result := not l3IsProcessFolder(aDir);
end;

procedure TalcuServerPrim.cs_AACNeedTerminate(aPipe: TCSDataPipe);
var
 l_TaskCount: Integer;
begin
 l_TaskCount := aPipe.ReadInteger;
 aPipe.WriteInteger(IfThen(AACNeedTerminate(l_TaskCount, 1), 1, 0));
end;

function TalcuServerPrim.AACNeedTerminate(
  aPrevTaskCount: Integer; MaxAllowedClients: Integer = 0): Boolean;
begin
 {$IFDEF UseCommandFile}
 Result := (f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.ClientsCount > MaxAllowedClients) or
  (TaskProcessor.AddedActiveTaskCount <> aPrevTaskCount);
 {$ELSE}
 Result := True;
 {$ENDIF}
end;

procedure TalcuServerPrim.DisableProcessing;
begin
 LockTaskExecution;
 Scheduler.DisableSchedule;
end;

procedure TalcuServerPrim.DoAnnoExport;
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctAnnoExport, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  l3Free(l_Task);
 end;
end;

procedure TalcuServerPrim.EnableProcessing;
begin
 UnLockTaskExecution;
 Scheduler.EnableSchedule;
end;

function TalcuServerPrim.ProcessingEnabled: Boolean;
begin
 Result := TaskExecutionEnabled and not TaskProcessor.TaskExecutionLocked and not TaskProcessor.ProcessingLocked;
end;

procedure TalcuServerPrim.ScheduledAnnoExport(const aTask: TddSchedulerTask);
begin
 DoAnnoExport;
 aTask.ExecuteResult := strOk;
end;

function TalcuServerPrim.Scheduler: TddScheduler;
begin
  Result := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddScheduler);
end;

function TalcuServerPrim.DoLongProcessNotify(
  aState: TdaProcessState): Boolean;
begin
 if Assigned(f_ServerLongProc) then
   Result:= f_ServerLongProc(aState)
 else
 begin
  Result:= False;
  {$IFNDEF Service}
  Application.ProcessMessages;
  {$ENDIF}
 end;
end;

procedure TalcuServerPrim.ScheduledMdpSyncDicts(const aTask: TddSchedulerTask);
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctMdpSyncDicts, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ScheduledMdpSyncDocs(const aTask: TddSchedulerTask);
var
 l_Task: TddProcessTask;
begin
 if CreateSchedulerTask(ctMdpSyncDocs, l_Task) then
 try
  TaskProcessor.AddActiveTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.ResetExecutorLog(aMaxSize: Integer; aCompress: Boolean = False);
var
 l_FileIterator: TddFileIterator;
 l_IDX: Integer;
begin
 l3System.Msg2Log('* сбрасываем логи alcuTaskExecutor');
 ResetLogFile('alcuTaskExecutor.log', aMaxSize, aCompress);

 l3System.Msg2Log(SalcuAutoPipeServer_Udaleniestaryhrezervnyhkopiy);
 l_FileIterator := TddFileIterator.Make(ExtractFileDir(ParamStr(0)), Format(cExecutorLogName, ['*']));
 try
  for l_IDX := 0 to l_FileIterator.FileList.Count - 1 do
   ResetLogFile(ExtractFileName(l_FileIterator.FileList[l_IDX]), aMaxSize, aCompress);
 finally
  FreeAndNil(l_FileIterator);
 end;
end;

procedure TalcuServerPrim.LockTaskExecution;
begin
 if not IsShutdowning then
  TaskProcessor.LockTaskExecution;
end;

procedure TalcuServerPrim.UnlockTaskExecution;
begin
 if not IsShutdowning then
  TaskProcessor.UnLockTaskExecution;
end;

procedure TalcuServerPrim.DoExecuteCommand(aCommandID: Integer);
begin
 TaskProcessor.RequestExecuteCommand(GlobalDataProvider.UserID, aCommandID);
end;

procedure TalcuServerPrim.CheckReportMemoryUsage;
const
 cMemoryReportInterval = 5;
begin
 if (f_LastMemoryReport = 0) or (MinutesBetween(Now, f_LastMemoryReport) > cMemoryReportInterval) then
 begin
  ReportMemoryUsage;
  f_LastMemoryReport := Now;
 end;
end;

procedure TalcuServerPrim.ReportMemoryUsage;
var
 l_Msg: String;
 l_Status: TMemoryStatus;
 l_Max: LongWord;
 l_All: LongWord;
begin
 if (f_UpdateRequestListCounter = 1) and Scheduler.ScheduleEnabled then
  l_Msg := 'Periodically'
 else
  l_Msg := 'Dirty periodically';
 l3System.MemUsage2Log(False, False, True, l_Msg, l3_msgLevel3);
 l_Status.dwLength := SizeOf(l_Status);
 GlobalMemoryStatus(l_Status);
 L3GetMemoryAvail(l3_mkFree, l_Max, l_All);
 l3System.Msg2Log('Free mem avail %s / %s (%s)',
  [FormatFloat('#,###', l_Max), FormatFloat('#,###', l_All), FormatFloat('#,###', l_Status.dwAvailVirtual)], l3_msgLevel3);
 L3GetMemoryAvail(l3_mkReserved, l_Max, l_All);
 l3System.Msg2Log('Reserved mem avail %s / %s', [FormatFloat('#,###', l_Max), FormatFloat('#,###', l_All)], l3_msgLevel3);
end;

{$IFNDEF RunSchedulerAsTask}
procedure TalcuServerPrim.SchedulerCanRunWithoutRunningTask(
  const aTask: TddSchedulerTask; var CanRunTask: Boolean);
begin
 if TaskProcessor.Processing then
  CanRunTask := False;
end;
{$ENDIF RunSchedulerAsTask}

procedure TalcuServerPrim.cs_GetBaseStatus(aPipe: TCSDataPipe);
begin
 Assert(Assigned(f_BaseEngineHolder.BaseEngine));
 f_BaseEngineHolder.BaseEngine.cs_GetBaseStatus(aPipe);
end;

procedure TalcuServerPrim.InitAutoLinkEnabled;
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'General';
  f_AutolinkEnabled := l_Ini.ReadParamBoolDef(sEnableAutolinkParam, False);
 finally
  FreeAndNil(l_Ini);
 end;
end;

procedure TalcuServerPrim.SchedulerClientNotify(
  const aTask: TddSchedulerTask);
begin
 f_MessageManager.SendNotify(c_AllClients, ntCalendar, Ord(aTask.TaskType), '', usServerService);
 aTask.ExecuteResult := strOk;
end;

procedure TalcuServerPrim.SchedulerTaskExecutor(
  const aTask: TddSchedulerTask);

 procedure lp_AddProxyTaskToExecute(aTaskType: TddCalendarTaskType);
 var
  l_Task: TalcuSchedulerProxyTask;
 begin
  l_Task := TalcuSchedulerProxyTask.Create(usServerService);
  try
   l_Task.SchedulerTaskType := Ord(aTaskType);
   l_Task.Description := ddCalendarEventArray[aTaskType].Caption;
   l_Task.ParentTask := aTask;
   TaskProcessor.AddActiveTask(l_Task);
  finally
   FreeAndNil(l_Task);
  end;
 end;

 procedure lp_AddProxyTaskToList(const aList: TasksListHelper; aTaskType: TddCalendarTaskType);
 var
  l_Task: TalcuSchedulerProxyTask;
 begin
  l_Task := TalcuSchedulerProxyTask.Create(usServerService);
  try
   l_Task.SchedulerTaskType := Ord(aTaskType);
   l_Task.ParentTask := aTask;
   l_Task.Description := ddCalendarEventArray[aTaskType].Caption;
   l_Task.RequestQuery;
   aList.Add(l_Task);
  finally
   FreeAndNil(l_Task);
  end;
 end;

var
 l_Task: TddProcessTask;
 l_Container: TalcuContainerTask;
 l_TaskList: TasksListHelper;
 l_IDX: Integer;
begin
 if aTask.SubTaskCount = 0 then
 begin
  if CreateSchedulerTask(aTask.TaskType, l_Task) then
  try
   if Assigned(l_Task) then
   begin
    l_Task.Description := Format('Задание планировщика: %s', [aTask.Caption]);
    l_Task.Priority := dd_tpHighest;
    TaskProcessor.AddActiveTask(l_Task);
   end;
   aTask.ExecuteResult := strOk;
  finally
   FreeAndNil(l_Task);
  end
  else
   lp_AddProxyTaskToExecute(aTask.TaskType);
 end
 else
 begin
  if TaskProcessor.Processing then
  begin
   aTask.ExecuteResult := strRequestDelay;
   Exit;
  end;
  l_Container := TalcuContainerTask.Create(usServerService);
  try
   l_Container.Description := Format('Задание планировщика: %s', [aTask.Caption]);
   l_Container.ParallelExecutionMode := False;
   l_Container.Priority := dd_tpHighest;
   l_TaskList := l_Container.TasksList;
   try
    if CreateSchedulerTask(aTask.TaskType, l_Task) then
    try
     if Assigned(l_Task) then
     begin
       l_Task.RequestQuery;
       l_TaskList.Add(l_Task);
     end;
    finally
     FreeAndNil(l_Task);
    end
    else
     lp_AddProxyTaskToList(l_TaskList, aTask.TaskType);
    for l_IDX := 0 to aTask.SubTaskCount - 1 do
    begin
     if CreateSchedulerTask(aTask.SubTaskType[l_IDX], l_Task) then
     try
      if Assigned(l_Task) then
      begin
       l_Task.RequestQuery;
       l_TaskList.Add(l_Task);
      end;
     finally
      FreeAndNil(l_Task);
     end
     else
      lp_AddProxyTaskToList(l_TaskList, aTask.SubTaskType[l_IDX]);
    end;
   finally
    l_TaskList := nil;
   end;
   TaskProcessor.AddActiveTask(l_Container);
   aTask.ExecuteResult := strOk;
   aTask.ExecuteSubTasks := False;
  finally
   FreeAndNil(l_Container);
  end;
 end;
end;

function TalcuServerPrim.CreateSchedulerTask(
  aType: TddCalendarTaskType; out theTask: TddProcessTask; aUserID: TdaUserID = usServerService): Boolean;
begin
 Result := True;
 theTask := nil;
 case aType of
(*
  ctDeltaTask: Assert(False);
  ctUpdateTask: Assert(False);
  ctBirthdayTask: Assert(False);
  ctHolidayTask: Assert(False);
  ctPreventiveTask: Assert(False);
*)
  ctAutoExportTask:
   begin
    theTask := TalcuAutoExportTask.Create(usServerService);
    theTask.Priority:= dd_tpHighest;
    theTask.Description := ddCalendarEventArray[aType].Caption;
   end;
  ctLoadRegions:
   theTask := MakeLoadRegionsTask;
//  ctAutoSubs: ;
  ctAutoclassify:
   begin
{$IFDEF AutoClass}
    theTask := TalcuAutoClassTask.Create(aUserID);
    theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF AutoClass}
   end;
//  ctVersion: ;
//  ctCompilation: ;
  ctUploadRegions:
   theTask := MakeUpLoadRegionsTask;
  ctRelPublish:
{$IFDEF AutoSP}
    if not TaskProcessor.HasActiveTask(cs_ttRelPublish) then
    begin
     theTask := TalcuRelPublishTask.Create(usServerService);
     TalcuRelPublishTask(theTask).SourceFiles.Add(FindPublInfoFile);
    end
{$ENDIF}
    ;
  ctHavansky:
   begin
{$IFDEF HavanskyExport}
    theTask := TalcuHavanskyExportTask.Create;
    theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF}
   end;
  ctCloneBase:
   begin
    theTask := MakeOvgaExportTask;
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
   end;
  ctExportAnonced:
   begin
    theTask := MakeAutomaticAnoncedExportTask(False);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
   end;
  ctExportAnoncedEx:
   begin
    theTask := MakeAutomaticAnoncedExportTask(True);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
   end;
  ctAnnoExport:
   begin
    theTask := TalcuAutoAnnoExportTask.Create(usServerService);
    if Assigned(theTask) then
    begin
     theTask.Priority:= dd_tpHighest;
     theTask.Description := ddCalendarEventArray[aType].Caption;
    end;
   end;
  ctMdpSyncDicts:
   begin
{$IFDEF MDPSyncIntegrated}
    theTask := f_DictSynchronizator.MakeTask;
    if Assigned(theTask) and TaskProcessor.HasActiveTask(theTask.TaskType) then
     FreeAndNil(theTask);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF MDPSyncIntegrated}
   end;
  ctMdpSyncDocs:
   begin
{$IFDEF MDPSyncIntegrated}
    theTask := f_MDPImporter.MakeTask;
    if Assigned(theTask) and TaskProcessor.HasActiveTask(theTask.TaskType) then
     FreeAndNil(theTask);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF MDPSyncIntegrated}
   end;
  ctMdpSyncStages:
   begin
{$IFDEF MDPSyncIntegrated}
    theTask := TalcuMdpSyncStages.Create(TdaUserID(ddAppConfiguration.asInteger['mdpImportUser']));
    if Assigned(theTask) and TaskProcessor.HasActiveTask(theTask.TaskType) then
     FreeAndNil(theTask);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF MDPSyncIntegrated}
   end;
    ctMdpSyncImport:
   begin
{$IFDEF MDPSyncIntegrated}
    theTask := TalcuMdpSyncImport.Create(TdaUserID(ddAppConfiguration.asInteger['mdpImportUser']));
    if Assigned(theTask) and TaskProcessor.HasActiveTask(theTask.TaskType) then
     FreeAndNil(theTask);
    if Assigned(theTask) then
     theTask.Description := ddCalendarEventArray[aType].Caption;
{$ENDIF MDPSyncIntegrated}
   end;

  ctContainer:
  { Do nothing };
 else
  Result := False;
 end;
 if not Result then
  l3System.Msg2Log('warning - не найдена задача для задания типа %s - используем proxy', [GetEnumName(TypeInfo(TddCalendarTaskType), Ord(aType))], l3_msgLevel10);
end;

function TalcuServerPrim.MakeLoadRegionsTask: TddProcessTask;
{$IFDEF ExchangeDocs}
var
 l_TaskList: TasksListHelper;
 l_IDX: Integer;
 l_Task: TalcuRegionImportTask;
{$ENDIF ExchangeDocs}
begin
{$IFDEF ExchangeDocs}
 Result := TalcuContainerTask.Create(usServerService);
 TalcuContainerTask(Result).ParallelExecutionMode := True;
 l_TaskList := TalcuContainerTask(Result).TasksList;
 try
  for l_IDX := 0 to TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regSources']).Count - 1 do
  begin
   l_Task := TalcuRegionImportTask.Create(usServerService);
   try
    l_Task.RegionIndex := l_IDX;
    l_Task.Description:= Format('Импорт документов из %s',
                    [TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regSources']).Values[l_IDX, 'Caption'].AsString]);
    l_TaskList.Add(l_Task);
   finally
    FreeAndNil(l_Task);
   end;
  end;
 finally
  l_TaskList := nil;
 end;
{$ELSE ExchangeDocs}
 Result := nil;
{$ENDIF ExchangeDocs}
end;

function TalcuServerPrim.MakeUpLoadRegionsTask: TddProcessTask;
{$IFDEF ExchangeDocs}
var
 l_TaskList: TasksListHelper;
 l_IDX: Integer;
 l_Task: TalcuRegionAutoExportTask;
{$ENDIF ExchangeDocs}
begin
{$IFDEF ExchangeDocs}
 Result := TalcuContainerTask.Create(usServerService);
 TalcuContainerTask(Result).ParallelExecutionMode := True;
 l_TaskList := TalcuContainerTask(Result).TasksList;
 try
  for l_IDX := 0 to TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Count-1 do
  begin
   {$IFDEF OvgaExport}
   if not AnsiSameText(TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Values[l_IDX, 'Caption'].AsString, 'ovga') then
   {$ENDIF}
   begin
    l_Task:= TalcuRegionAutoExportTask.Create(usServerService);
    try
     l_Task.RegionIndex:= l_IDX;
     l_Task.Description:= Format('Экспорт документов для %s',
                     [TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Values[l_IDX, 'Caption'].AsString]);
     l_TaskList.Add(l_Task);
    finally
     l3Free(l_Task);
    end;
   end;
  end;
 finally
  l_TaskList := nil;
 end;
{$ELSE ExchangeDocs}
 Result := nil;
{$ENDIF ExchangeDocs}
end;

function TalcuServerPrim.MakeOvgaExportTask: TddProcessTask;
{$IFDEF ManualExchangeDocs}
var
 l_Item: TddVisualConfigItem;
 i, l_Index: Integer;
 l_Task: TalcuRegionAutoExportTask;
{$ENDIF}
begin
 Result := nil;
 {$IFDEF ManualExchangeDocs}
 l_Index:= -1;
 for i:= 0 to TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Count-1 do
  if AnsiSameText(TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Values[i, 'Caption'].AsString, 'ovga') then
  begin
   l_Index:= i;
   break;
  end;

 if l_Index <> -1 then
 begin
  l_Task:= TalcuRegionAutoExportTask.Create(usServerService);
  l_Task.RegionIndex:= l_Index;
  l_Task.Today:= Now;
  l_Task.CompileDate:= Yesterday;
 end; // ExecuteNodeDialog
 Result := l_Task;
 {$ENDIF}
end;

function TalcuServerPrim.MakeAutomaticAnoncedExportTask(
  anOnThursdayMode: Boolean; aUserID: TdaUserID): TddProcessTask;
var
 l_Task: TalcuAnoncedExport;
begin
 l_Task:= TalcuAnoncedExport.Create(aUserID);
 l_Task.Priority:= dd_tpHighest;
 l_Task.OnThursdayMode := anOnThursdayMode;
 if DayOfTheWeek(Today) = DayFriday then
  l_Task.AnoncedDate:= DateTimeToStDate(GetNearestDay(Today, DaySunday))
 else
  l_Task.AnoncedDate:= l3Date.CurrentDate;
 Result := l_Task;
end;

procedure TalcuServerPrim.cs_GetUsersList(aPipe: TcsDataPipe);

var
 l_Stream: Tstream;

 function DoSave(const anUser: IdaArchiUser): Boolean;
 begin
  Result := True;
  anUser.Save(l_Stream);
 end;

begin
 aPipe.WriteInteger(GlobalDataProvider.UserManager.ArchiUsersCount);
 l_Stream:= Tl3MemoryStream.Make;
 try
  GlobalDataProvider.UserManager.IterateArchiUsersF(L2ArchiUsersIteratorIterateArchiUsersFAction(@DoSave));
  aPipe.WriteStream(l_Stream);
 finally
  l3Free(l_Stream);
 end
end;

function TalcuServerPrim.DoCommitImgCache: Boolean;
begin
 Result := False;
 TaskProcessor.LockProcessing;
 try
  DisableProcessing;
  try
   l3System.Msg2Log('* переливка кэша образов в постоянное хранилище');
   try
    Result := DocImageServer.CommitImageCache(f_Progressor.ProcessUpdate);
   except
    on E: Exception do
    begin
     l3System.Msg2Log('ОШИБКА при переливке кэша образов!');
     Exception2Log(E);
    end;
   end; // try..except
  finally
   EnableProcessing;
  end;
 finally
  TaskProcessor.UnLockProcessing;
 end;
end;

function TalcuServerPrim.IsImgCacheCommitable: Boolean;
var
 l_ImgCachePath: AnsiString;
 l_ImgStoragePath: AnsiString;
begin
 l_ImgStoragePath := UpperCase(ExcludeTrailingPathDelimiter(ddAppConfiguration.AsString['ImageStoragePath']));
 l_ImgCachePath   := UpperCase(ExcludeTrailingPathDelimiter(ddAppConfiguration.AsString['ImageCachePath']));
 Result := (l_ImgStoragePath <> '') and (l_ImgCachePath <> '') and (l_ImgCachePath <> l_ImgStoragePath);
end;

procedure TalcuServerPrim.UserStatusChanged(UserID: TdaUserID;
  Active: Boolean);
var
  l_Index: Integer;
  l_User: IdaArchiUser;
  l_Info: TcsClientInfo;
begin
 if UserID <> usServerService then
 begin
  l_User := GlobalDataProvider.UserManager.UserByID(UserID);
  if l_User <> nil then
  begin
   f_MessageManager.DropAllMessagesForUser(UserId);
   if Active then
   begin
    f_Updated:= False;
    l_Info := f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.ClientInfoOf(UserID);
    if Assigned(l_Info) then
    begin
      l_User.IP:= l_Info.ListenIp;
      f_MessageManager.SendNotify(UserID, ntAnouncedDateChanged, 0, 'Обновление даты анонсирования');
      f_MessageManager.SendNotify(UserID, ntCalendar, Ord(ctVersion), 'Обновление даты версии');
    end;
   end;
   {$IFNDEF Service}
   if not f_LockLog then // Индикация входа-выхода
   begin
    if Assigned(f_OnUserListUpdated) then
     f_OnUserListUpdated(l_User, Active);
    Application.ProcessMessages;
   end; // if not f_LockLog
   {$ENDIF}
  end;
 end;
end;

function TalcuServerPrim.CheckConfigAtStartupCrash: TCheckConfigResult;
begin
 if ddAppConfiguration.IsValid then
  Result := alcu_ccrValid
 else
 begin
  repeat
   if alcuMsgDialog(ddAppconfiguration.RequiredMessage +'. Хотите задать сейчас?', mtError, [mbYes, mbNo], 0) <> mrYes then
   begin
    Result := alcu_ccrRefused;
    Break;
   end;
   if ddAppConfiguration.ShowDialog('Необходимо задать ключевые параметры', True) then
   begin
    ddAppConfiguration.Save;
    Result := alcu_ccrEdited;
   end
   else
   begin
    Result := alcu_ccrCalcelled;
    Break;
   end;
  until ddAppConfiguration.IsValid;
 end;
end;

initialization
 MakeAnnoSwitchData;
end.
