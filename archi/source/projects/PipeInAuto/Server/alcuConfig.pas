unit alcuConfig;

{ Модуль для хранения настроек программы }

{ $Id: alcuConfig.pas,v 1.46 2016/06/03 09:28:30 fireton Exp $ }

// $Log: alcuConfig.pas,v $
// Revision 1.46  2016/06/03 09:28:30  fireton
// - вычищаем старую интеграцию с Гардоком
//
// Revision 1.45  2016/06/02 15:28:03  fireton
// - синхронизация с Гардоком журнала импортов
//
// Revision 1.44  2016/05/27 08:27:40  fireton
// - синхронизация этапов в Гардок
//
// Revision 1.43  2016/04/15 11:54:29  lukyanets
// Чистим протухший код
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.42  2016/03/29 13:10:37  lukyanets
// Cleanup
//
// Revision 1.41  2016/03/16 09:15:34  lukyanets
// Заменяем условную компиляцию на настройку
//
// Revision 1.40  2016/03/16 08:59:08  lukyanets
// Заменяем условную компиляцию на настройку
//
// Revision 1.39  2016/02/17 12:57:53  lukyanets
// Cleanup
//
// Revision 1.38  2016/02/10 10:58:37  fireton
// - галка "Выливать только подключённые" в автоэкспорте полных групп доступа
//
// Revision 1.37  2016/02/10 08:38:55  lukyanets
// Подкрутил уровень логов
//
// Revision 1.36  2016/01/21 10:47:18  lukyanets
// Не учитывали условную компиляцию.
//
// Revision 1.35  2015/10/12 11:01:58  lukyanets
// Задаем пользователя для импорта из Гардок
//
// Revision 1.34  2015/10/09 13:01:52  lukyanets
// Пишем в лог от чьего имени выполняется задача
//
// Revision 1.33  2015/10/05 11:45:32  lukyanets
// Причесываем название
//
// Revision 1.32  2015/09/11 10:41:56  lukyanets
// Причесываем директивы
//
// Revision 1.31  2015/09/09 13:26:27  lukyanets
// Заготовки импорта документов
//
// Revision 1.30  2015/09/08 09:14:52  lukyanets
// Заготовки импорта документов
//
// Revision 1.29  2015/09/07 14:21:34  lukyanets
// Синхронизация ОГВ
//
// Revision 1.28  2015/09/03 14:09:08  lukyanets
// Заготовки синхронизации словарей - почти пишем файл
//
// Revision 1.27  2015/07/02 11:40:59  lukyanets
// Описываем словари
//
// Revision 1.26  2015/07/02 07:34:39  lukyanets
// Описываем словари
//
// Revision 1.25  2015/05/28 11:13:40  fireton
// - добавляем параметр ExpandEditions
//
// Revision 1.24  2015/05/08 07:52:49  lukyanets
// Cleanup
//
// Revision 1.23  2015/03/27 09:21:01  lukyanets
// Отучаем параметры сервера от знания про HT
//
// Revision 1.22  2015/03/17 12:06:34  lukyanets
// Готовимся читать из разных мест
//
// Revision 1.21  2015/02/20 10:36:26  fireton
// - отделяем экспорт аннотаций в еж. дельту в отдельное задание
//
// Revision 1.20  2015/02/16 13:48:22  lukyanets
// Перепосылаем почту при проблемах с сервером.
//
// Revision 1.19  2014/12/23 08:42:46  fireton
// - настройка полного копирования базы по дням недели
//
// Revision 1.18  2014/10/21 10:54:04  lukyanets
// Запрещаем ссылаться "под ноги" серверу
//
// Revision 1.17  2014/10/14 10:01:36  lukyanets
// Пишем/читаем еще параметры
//
// Revision 1.16  2014/10/14 08:17:12  lukyanets
// Пишем/читаем еще параметры
//
// Revision 1.15  2014/10/13 10:31:48  lukyanets
// Убираем дублирующиеся параметры
//
// Revision 1.14  2014/09/26 07:24:50  lukyanets
// {RequestLink:565502566}
//
// Revision 1.13  2014/09/23 08:01:15  lukyanets
// {RequestLink:565487518} - Поддержка SSL
//
// Revision 1.12  2014/09/15 12:36:19  lukyanets
// Красивей даем заводить -1
//
// Revision 1.11  2014/09/11 12:45:39  lukyanets
// В инишник пишем типы задач которые *можно* отцеплять
//
// Revision 1.10  2014/09/08 07:29:29  lukyanets
// Настраиваем каталог и скро хранения логов импорта
//
// Revision 1.9  2014/09/05 12:38:57  lukyanets
// Рожаем RegionImportTask
//
// Revision 1.8  2014/09/04 07:44:58  lukyanets
// Кладем отправленные дельты в здаваемый каталог
//
// Revision 1.7  2014/09/01 13:46:44  lukyanets
// По умолчанию выключаем асинхронную обработку
//
// Revision 1.6  2014/08/25 12:02:09  lukyanets
// Хороним экспорт для ФНС
//
// Revision 1.5  2014/08/13 11:12:10  fireton
// - корректируем источник постановлений АС (К 561547565)
//
// Revision 1.4  2014/08/07 14:02:20  lukyanets
// {Requestlink:556143119}. Вытащили ручки для отключения конкретных типов задач
//
// Revision 1.3  2014/08/04 09:33:42  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - MisspellCorrect
//
// Revision 1.2  2014/08/04 06:39:00  lukyanets
// {Requestlink:558466572}. Чистим протухшие хвосты - ddDossierMaker
//
// Revision 1.1  2014/07/28 15:18:17  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.125  2014/07/28 11:45:23  lukyanets
// {Requestlink:557844282}. Прикручиваем серверный ddAppConfig
//
// Revision 1.124  2014/07/16 15:35:48  lulin
// - вычищаем ненужное.
//
// Revision 1.123  2014/07/07 10:07:48  lukyanets
// {Requestlink:552022662}. Пул рабочих пользователей
//
// Revision 1.122  2014/02/10 07:54:05  GarikNet
// K:516189258
//
// Revision 1.121  2013/11/07 06:58:40  fireton
// - очищаем директорию с архивом импортированных данных
//
// Revision 1.120  2013/09/12 06:51:34  kostitsin
// [$476838236] - ddAppConfigVersions
//
// Revision 1.119  2013/09/05 09:27:32  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.118  2013/09/05 09:22:59  kostitsin
// [$476838236] - закончил c ddAppConfigTypes
//
// Revision 1.117  2013/08/28 05:15:03  fireton
// - не собиралось
//
// Revision 1.116  2013/04/16 13:06:40  narry
// Обновление
//
// Revision 1.115  2013/04/09 07:35:27  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.114  2013/04/08 07:04:59  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.113  2013/04/05 12:41:51  narry
// Автоматический экспорт анонсированных (447390002)
//
// Revision 1.112  2013/04/04 11:22:27  narry
// Вычисление даты анонсирования (447388742)
//
// Revision 1.111  2013/03/26 11:42:28  narry
// Не выливать Hang-документы для Прайма на сайт  (443842617)
//
// Revision 1.110  2013/02/12 11:35:46  narry
// Возможность настраивать Автоэкспорт с последнего успешного экспорта
//
// Revision 1.109  2013/01/28 11:41:26  narry
// Уточнение Автовыливки  (425270949)
//
// Revision 1.108  2013/01/23 10:41:19  fireton
// - шаблоны уведомлений
//
// Revision 1.107  2013/01/11 12:14:40  narry
// * автоматическая упаковка результатов экспорта Хаванского (ЭХ)
// * автоматическое копироване ЭХ на FTP
// * дельта экспорта МЦФР
//
// Revision 1.106  2012/12/06 06:24:00  narry
// Опечатка
//
// Revision 1.105  2012/10/18 07:37:18  narry
// Обновление
//
// Revision 1.104  2012/10/02 07:38:44  narry
// Поддержка экспортов Хаванского и МЦФР
//
// Revision 1.103  2012/09/07 13:36:43  narry
// Экспорт для Хаванского
//
// Revision 1.102  2012/08/02 13:18:15  narry
// Ограничение импорта по количеству документов (380619133)
//
// Revision 1.101  2012/07/13 11:29:10  narry
// Исправление опечаток из Арчи
//
// Revision 1.100  2012/07/10 11:03:38  narry
// Удаленный запуск run2 (375424291)
//
// Revision 1.99  2012/06/14 11:45:37  narry
// Возможность сжатия старых лог-файлов
//
// Revision 1.98  2012/06/14 11:00:35  narry
// Для регионов всегда копируем системной функцией
//
// Revision 1.97  2012/05/24 04:43:14  narry
// Обновление
//
// Revision 1.96  2012/04/19 09:28:49  narry
// Оптимизация выливки справок (356073078)
//
// Revision 1.95  2012/04/17 13:23:15  narry
// Оптимизация выливки справок (356073078)
//
// Revision 1.94  2012/04/16 10:00:43  narry
// Копирование файлов с помощью l3FileUtils.CopyFile
//
// Revision 1.93  2012/03/06 12:11:10  narry
// Не собиралось
//
// Revision 1.92  2012/01/30 09:09:00  narry
// - Автоэкспорт неподключенных
//
// Revision 1.91  2011/11/23 12:47:10  fireton
// - парень теперь не управляет временем последнего импорта из MDP
//
// Revision 1.90  2011/11/16 10:17:36  narry
// Интеграция импорта из К в сервер автоматизации (298682480)
//
// Revision 1.89  2011/11/02 08:09:09  narry
// Свободное место на диске измеряется в базах
//
// Revision 1.88  2011/11/02 06:11:43  narry
// Минимальный размер лог-файла был 5000 Мбайт
//
// Revision 1.87  2011/11/01 05:22:02  narry
// НИР Расстановка меток в ФАСах (147489953)
//
// Revision 1.86  2011/10/14 05:34:01  narry
// Не собиралось
//
// Revision 1.85  2011/09/15 07:20:10  narry
// - Избавление от ненужных параметров
//
// Revision 1.84  2011/09/13 12:26:53  narry
// Простановка меток в документах ВАС (283613768)
//
// Revision 1.83  2011/08/09 09:28:01  narry
// Заливка информации в справки каждую ночь (266422146)
//
// Revision 1.82  2011/07/06 13:22:06  narry
// Сделать выбор нескольких типов (273583007)
//
// Revision 1.81  2011/07/04 06:00:55  narry
// Дополнительный спискок органов для проверки ФАСов
//
// Revision 1.80  2011/06/20 13:07:46  narry
// Пересборка для регионов
//
// Revision 1.79  2011/06/20 11:17:31  narry
// Пересборка для регионов
//
// Revision 1.78  2011/06/20 07:26:47  narry
// Не работает простановка меток 20005 и 30005 (269080331)
//
// Revision 1.77  2011/06/14 07:36:15  narry
// Реализовать автоэкспорт документов (268338975)
//
// Revision 1.76  2011/06/02 13:21:05  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266406580)
//
// Revision 1.75  2011/05/12 05:21:21  narry
// Проверка орфографии в выборке (сервер) (260447428)
//
// Revision 1.74  2011/05/05 13:19:19  narry
// Обновление базы внешней утилитой (265408970)
//
// Revision 1.73  2011/04/22 11:44:09  narry
// Реакция на кнопку (262636470)
//
// Revision 1.72  2011/03/23 11:56:56  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.71  2011/03/16 10:41:55  narry
// K255979048. Преобразование типов судебных документов
//
// Revision 1.70  2011/01/19 08:19:09  narry
// Незначительные изменения
//
// Revision 1.69  2010/11/01 11:39:05  narry
// К238947202. Заменить раздел "Информационные документы" на "Все документы"
//
// Revision 1.68  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.67  2010/09/24 04:48:30  narry
// k235056975. Пересборка из-за изменения простановщика ссылок
//
// Revision 1.66  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//
// Revision 1.65  2010/07/20 12:28:39  narry
// К226003904
//
// Revision 1.64  2010/07/19 09:53:01  narry
// К227477456. Экспортировались только справки, не очищалась папка перед экспортом
//
// Revision 1.63  2010/04/20 09:36:34  narry
// - настройка внешних дельт с помощью запроса
//
// Revision 1.62  2010/04/02 12:11:26  narry
// - получение от клиента поискового запроса
//
// Revision 1.61  2010/03/19 14:01:58  narry
// - криво читались, писались элементы вложенных списков
// - обработка заданий в соответствии с приоритетами
//
// Revision 1.60  2010/03/16 14:14:07  narry
// - очитска инишника от мусора
// - использование только одной библиотеки упаковки
// - корректное сохранения вложенных заданий
//
// Revision 1.59  2010/03/04 07:47:16  narry
// - обновление списка пользователей
// - одно окно для отправки сообщений и закрытия базы
//
// Revision 1.58  2010/02/27 12:22:59  narry
// - сохранение новых сообщений
//
// Revision 1.57  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.56  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.55  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.54  2009/03/17 09:27:20  narry
// - подгонка окна конфигурации под 800х600
//
// Revision 1.53  2009/02/20 13:27:50  narry
// - процедура обновления настроек
//
// Revision 1.52  2009/01/26 07:39:35  narry
// - неправильно преобразоывался день недели
//
// Revision 1.51  2009/01/23 16:21:19  narry
// - переделки в сторону службы
// - версии настроек
//
// Revision 1.50  2008/11/24 15:05:23  narry
// - обновление
//
// Revision 1.49  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.48  2008/08/20 14:42:20  narry
// - обновление
//
// Revision 1.47  2008/07/24 15:16:29  narry
// - изменение настроек Автоэкспорта
//
// Revision 1.46  2008/07/22 11:13:35  narry
// - изменение настроек Автоэкспорта
//
// Revision 1.45  2008/07/16 16:14:04  narry
// - реализация Автовыливки
//
// Revision 1.44  2008/06/24 07:41:55  narry
// - воможность автокспортировать и неподключенные документы
//
// Revision 1.43  2008/06/23 12:26:03  narry
// - опечатка
//
// Revision 1.42  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.41  2008/05/16 13:30:53  narry
// - обновление
//
// Revision 1.40  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.39  2008/04/23 10:43:15  narry
// - обновление
//
// Revision 1.38  2008/03/24 09:37:43  narry
// - исправление подсказки
//
// Revision 1.37  2008/03/13 13:57:56  narry
// - выключение ведения списка удаленных документов
// - изменение настроек ФНС
// - автоматический экспорт аннотаций
//
// Revision 1.36  2008/03/04 11:34:04  narry
// - расширение функционала экспорта аннотаций для Прайм
//
// Revision 1.35  2008/02/27 15:55:22  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
// - время в смс
// - условия компиляции
// - другое
//
// Revision 1.34  2008/02/19 15:52:19  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.33  2008/02/06 09:27:11  narry
// - не компилировалось
// - новый параметр в конфигруации (файл архива кс)
//
// Revision 1.32  2008/01/23 08:09:44  narry
// - включение настроек Автоклассификации
//
// Revision 1.31  2008/01/17 13:01:02  narry
// - мелкие исправления
//
// Revision 1.30  2007/12/25 12:04:20  narry
// - корректная установка времени окончания процедур обновления
// - переименование Еженедельного обновления
//
// Revision 1.29  2007/12/06 11:10:29  narry
// - поддержка автоклассификации
//
// Revision 1.28  2007/12/06 09:38:32  narry
// - поддержка автоклассификации
//
// Revision 1.27  2007/11/28 11:30:09  narry
// - дополнение окна "О программе"
// - незначительное изменение окна конфигурации
//
// Revision 1.26  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.25  2007/09/11 12:22:39  narry
// - Расстановка меток 30005 и 20005. Уточненная
//
// Revision 1.24  2007/09/06 06:21:12  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - Расстановка меток 30005 и 20005
// - Удаленое изменение словарей
//
// Revision 1.23  2007/07/25 10:44:19  narry
// - различные ошибки и упущения
//
// Revision 1.22  2007/07/24 12:33:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.21  2007/07/04 09:28:37  narry
// - обновление
//
// Revision 1.20  2007/03/27 12:21:12  narry
// - обновление
//
// Revision 1.19  2006/09/12 11:41:23  narry
// - исправлена ошибка экспорта ФНС
// - обновление таблиц перед импортом
//
// Revision 1.18  2006/06/05 15:05:33  narry
// - новое: перевод на новый механизм рассылки нотификаций
//
// Revision 1.17  2006/03/07 12:28:08  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.16  2005/11/02 16:39:27  narry
// - исправления и улучшения
//
// Revision 1.15  2005/10/06 16:06:36  narry
// - обновление: улучшение логики определения готовности лога дельты
//
// Revision 1.14  2005/09/27 06:30:11  narry
// - обновление
//
// Revision 1.13  2005/09/14 12:54:00  narry
// - чистка кода
// - новое: максимальный возраст экспорта
// - новое: время начала рабочего дня
//
// Revision 1.12  2005/09/09 12:36:26  narry
// - update: перед началом обновлений резервное копирование выполняется в обязательном порядке
//
// Revision 1.11  2005/09/07 15:51:58  narry
// - new: индексация словарных статей
//
// Revision 1.10  2005/09/07 14:17:01  narry
// - New: флажок проверки готовности лога разницы документов
//
// Revision 1.9  2005/07/22 06:23:56  narry
// - update
//
// Revision 1.8  2005/04/20 11:48:46  narry
// - update: приоритеты заданий, логика определения подключения к базе по UNC-путям и что-то еще
//
// Revision 1.7  2005/03/14 12:15:42  narry
// - update: аннотации во всех их проявлениях
//
// Revision 1.6  2005/02/08 17:12:49  narry
// - update & cleanup
//
// Revision 1.5  2004/09/08 05:38:30  narry
// - update
//
// Revision 1.4  2004/08/25 12:50:22  narry
// - update: добавление параметра UpdateText - обновление текстовой части
//
// Revision 1.3  2004/07/01 15:39:31  narry
// - update
//
// Revision 1.2  2004/05/19 07:03:49  narry
// - update: объединение с основной веткой
//
// Revision 1.1.2.1  2004/05/19 06:53:40  narry
// - prerelease
//
// Revision 1.1  2004/05/07 12:55:24  narry
// - first upload
//

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface
Uses
 ddAppConfig, ddConfigStorages, ddAppConfigDataAdapters;

function CreateConfigEx(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil): TddAppConfiguration;
procedure DestroyConfig;

procedure CreateConfig(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil);

implementation

Uses
 SysUtils, Classes, Controls, Forms,
 l3Base, l3String,
 ddUtils,
 alcuHelpConst,
 alcuConfigTypes,
 alcuTypes,
 daTypes,
 daDataProviderSuperFactory,
 dt_Const, dt_Types, dt_AttrSchema,
 DateUtils,
 ddAppConfigLists, ddAppConfigConst, ddAppConfigStrings, ddAppConfigTypes,
 ddScheduler, l3Bits, alcuMailServer, ddAppConfigDates, ddIniStorage,
 alcuUtils, Math, idStack;

var
 mailAdapter: TalcuEmailAdapter;

procedure ConvertFAS(aStorage: IddConfigStorage; const aPrefix, aIndex, aCaption: String);
var
 i: Integer;
 l_Count: Integer;
 l_Enabled: Boolean;
 l_Source: Integer;
 l_Exclude: String;
 l_List: TStrings;
begin
 l_List:= TStringList.Create;
 try
  with aStorage do
  begin
   //Сделать проведуру, которая получает на входе раздел и префикс и считывает-записывает параметры
   Section:= aPrefix+'Court';
   l_Enabled:= ReadBool(aPrefix+'_Enabled', False);
   l_Source:= ReadInteger(aPrefix+'Court_Source', -1);
   l_Exclude:= l3Str(ReadString(aPrefix+'COurt_Exclude', ''));
   l_Count:= ReadInteger(aPrefix+'Court_BeforeCount', 0);
   for i:= 0 to Pred(l_Count) do
    l_List.Add(l3Str(ReadString(aPrefix+'Court_Before'+IntToStr(i), '')));

   Section:= 'CourtListI'+aIndex;
   WriteString('Caption', aCaption);
   WriteBool('Court_Work', l_Enabled);
   WriteInteger('Court_Source', l_Source);
   WriteInteger('Court_BeforeCount', l_List.Count);
   for i:= 0 to Pred(l_List.Count) do
    WriteString('Court_Before'+IntToStr(i), l_List.Strings[i]);
   WriteString('Court_Exclude', l_Exclude);
  end; // with aStorage;
 finally
  l3Free(l_List);
 end;
end;

procedure Upgrade1To2(const aStorage: IddConfigStorage);
var
 i, l_Count: Integer;
 l_ID: Integer;
 l_DateTime: TDateTime;
 l_DayOW: TddSchedulerDayOfWeek;
 l_Section: string;
 l_IsTime: Boolean;
 l_IsDate: Boolean;
 l_NumStr: string;
 l_TempTaskType: Integer;
 l_WrongDays: Integer;
 l_Caption: String;
 l_Day: Integer;
 l_Periodicity: integer;
begin
 // Изменилось описание задач шедулера
 with aStorage do
 begin
  Section:= 'Scheduler';
  l_Count:= ReadInteger('Count', 0); // Количество задач
  for i:= 0 to Pred(l_Count) do
  begin
   // Читаем старую информацию
   Section:= 'Scheduler';
   l_NumStr := IntToStr(i);
   l_TempTaskType := ReadInteger(l_NumStr+'.ID', -1);
   if l_TempTaskType < 0 then
    raise Exception.CreateFmt('Поврежденное задание №%d', [i]);
   l_Caption:= l3Str(ReadString(l_NumStr+'.Caption', ''));
   l_DateTime:= ReadDateTime(l_NumStr+'.DateTime', 0);
   l_Day:= ReadInteger(l_NumStr+'.Day', 0);
   l_Periodicity:= ReadInteger(l_NumStr+'.TaskType', -1);
   l_WrongDays := 0;
   for l_DayOW := Low(TddSchedulerDayOfWeek) to High(TddSchedulerDayOfWeek) do
    if ReadBool(l_NumStr+'.'+ IntToStr(Ord(l_DayOW)), False) then
     l3SetBit(l_WrongDays, Pred(Ord(l_DayOW)));
   // Записываем новую
   Section:= 'SchedulerTask'+IntToStr(i);
   WriteString('Caption', l_Caption);
   WriteInteger('Type', l_TempTaskType);
   WriteDateTime('Time', TimeOf(l_DateTime));
   WriteInteger('Pereodicity', l_Periodicity);

   case TddSchedulerTaskPeriodicity(l_Periodicity) of
    stOnce:
     WriteDateTime('Date', DateOf(l_DateTime));
    stEveryDay:
     WriteInteger('WrongDays', l_WrongDays);
    stEveryWeek:
     WriteInteger('WeekDay', Pred(l_Day));
    stEveryMonth:
     WriteInteger('MonthDay', DayOf(l_DateTime));
    stEveryYear:
     begin
      WriteInteger('YearDay', DayOf(l_DateTime));
      WriteInteger('YearMOnth', MonthOf(l_DateTime));
     end;
   end; // case
  end; // for i
 end; // with aStorage
 // Метки в ФАСах
 aStorage.Section:= 'CourtDecisions';
 aStorage.WriteInteger('CourtList.Count', 3);
 ConvertFAS(aStorage, 'RF', '0', 'Высший арбитражный суд РФ');
 ConvertFAS(aStorage, 'MO', '1', 'Федеральный арбитражный суд Московского округа');
 ConvertFAS(aStorage, 'WS', '2', 'Федеральный арбитражный суд Западно-сибирского округа');
end;

procedure Upgrade2To3(const aStorage: IddConfigStorage);
var
 l_AccGroups: String;
 l_FullAccGroups: String;
 l_Bases: String;
begin
 with aStorage do
 begin
  // Читаем
  Section:= 'AutoIncluded';
  l_AccGroups:= l3Str(ReadString('aiAccGroups', ''));
  l_FullAccGroups:= l3Str(ReadString('aiFullAccGroups', ''));
  l_Bases:= l3Str(ReadString('aiBases', ''));
  // Пишем
  Section:= 'aiDocuments';
  WriteString('aiAccGroups', l_AccGroups);
  WriteString('aiFullAccGroups', l_FullAccGroups);
  Section:= 'aiAnnotation';
  WriteString('aiBases', l_Bases);
 end; // aStorage
end;

procedure Upgrade3To4(const aStorage: IddConfigStorage);
var
 l_FullAccGroups: String;
 l_FileSize: String;
begin
 with aStorage do
 begin
  // Читаем
  Section:= 'aiDocuments';
  l_FileSize:= l3Str(ReadString('AutoIncludedSize', ''));
  l_FullAccGroups:= l3Str(ReadString('aiFullAccGroups', ''));
  // Пишем
  Section:= 'AutoIncluded';
  WriteString('AutoIncudedSize', l_FileSize);
  Section:= 'aiFullGroups';
  WriteString('aiFullAccGroups', l_FullAccGroups);
 end; // aStorage
end;

procedure Upgrade4To5(const aStorage: IddConfigStorage);
var
 l_FreeLimit: Int64;
 l_BaseSize: Int64;
 l_Delta: Int64;
begin
 with aStorage do
 begin
  Section:= 'Archi';
  l_FreeLimit:= ReadInteger('FreeSpaceLimit', 10000)* ddUtils.dd_KiloByte; // в килобайтах
  Section:= 'General';
  l_BaseSize:= GetFolderSize(l3Str(ReadString('UNCBasePath', '')));
  l_Delta:= l_FreeLimit div l_BaseSize;
  if l_Delta < 1 then
   l_Delta:= 1
  else
   l_Delta:= Max(3, l_delta);
  Section:= 'Archi';
  WriteInteger('FreeSpaceLimit', l_Delta);
 end;
end;

procedure Upgrade5To6(const aStorage: IddConfigStorage);
begin
 with aStorage do
 begin
  Section:= 'General';
  WriteString('ServerName', l3Str(ReadString('ServerIP', '')));
  WriteString('ServerIP', '');
 end;
end;

procedure AddMDPSyncChild(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
begin
 {$IFNDEF LUK}
 with aConfig do
 begin
  AddChild('mdpSync', 'Cинхронизация с Гардок');
   AddGroupItem('mdpDocSync', 'Импорт документов из Гардока');
    AddStringItem('mdpMail', 'Отправлять уведомления');
    AddStringItem('mdpErrorMail', 'Отправлять только ошибки');
    AddIntegerItem(l3CStr('mdpMaxCount'), l3CStr('Максимум документов за один раз'), 70);
    AddItem(TalcuUserListComboItem.Make('mdpImportUser', 'Пользователь для импорта'));
     Hint := 'Пользователь от чьего имени будут импортированы документы';
   CloseGroup;
   AddGroupItem('mdpDictSync', 'Cинхронизация словарей, этапов и журнала импорта в Гардок');
    LabelTop:= False;
    AddStringItem('dsURL', 'URL синхронизации','http://gardoc.garant.ru/plugins/servlet/gar-rest/ogv-synonyms');
    l_Item := AddBooleanItem(l3CStr('dsUseProxy'), l3CStr('Использовать прокси'));
    //Enabled := False;
     AddStringItem('dsProxyServer', 'Прокси сервер','',l_Item);
     AddIntegerItem(l3CStr('dsProxyPort'), l3CStr('Порт прокси'), 8080, l_Item);
      MinValue:= 1;
      MaxValue:= 65000;
     AddStringItem('dsProxyLogin', 'Логин', '', l_Item);
     AddStringItem('dsProxyPassword', 'Пароль', '', l_Item);
     PasswordChar:= '*';
    AddFolderNameItem('dsSyncFolder', 'Папка для передачи файлов', CorrectArchiveWarehousePath('', 'MDPSync'), nil, False);
     Hint := 'В этой папке хранятся временные файлы для передачи в Гардок';
     PathFill:= dd_ftFull;
   CloseGroup;
 end; // with
 {$ENDIF}
end;

procedure AddUserTasksChild(aConfig: TddAppConfiguration);
var
 l_Item: TalcuDictionaryTreeItem;
begin
 with aConfig do
 begin
  AddChild('UserTasks', 'Задания пользователей');
   HelpContext:= hcZadaniya_polzovatelej;
   LabelTop:= False;

   AddIntegerItem(l3CStr('WorkThreadCount'), l3CStr('Количество асинхронных заданий'), 0);
    Hint:= 'Количество одновременных асинхронных заданий.'#13#10' 0 - асинхронная обработка запрещена,'#13#10' -1 - оптимально доступное количество';
    MinValue := -1;
    MaxValue := 9999;

   AddItem(TalcuAsyncRunTaskItem.Make('AsyncRunTaskType', 'Типы асинхронных заданий', 6));
    Hint:= 'Типы заданий которые можно выполнять асинхронно.';

   AddFileNameItem('MessagesFileName', 'Файл с сообщениями пользователям', 'usersMessages.dat');
    Hint:= 'В этот файл будут сохраняться сообщения, неполученные пользователями';

   AddFolderNameItem('RootTaskFolder', 'Папка для хранения полученных заданий', 'TaskRoot', nil, False);
    Hint := 'В этой папке хранятся полученные задания до их обработки';
    PathFill:= dd_ftFull;

   AddIntegerItem(l3CStr('MaxExportAge'), l3CStr('Хранить выполненный экспорт|дней'), 7);
    Hint := 'Сколько дней будут храниться результаты экспорта, непереданные пользователю';
    MinValue := 3;
    MaxValue := 30;
   //AddItem(TalcuDictComboTreeItem.Make('utRegionID', 'Группа доступа "Передано в регионы"', da_dlAccGroups, False));
   l_Item:= TalcuDictionaryTreeItem.Make('utRegionID', 'Группа доступа "Передано в регионы"', da_dlAccGroups, True);
   AddItem(l_Item);
    Hint:= 'Одна из этих групп доступа будет присваиваться документам, "переданным на обработку в регионы"';
   AddDivider('Импорт');
    AddFolderNameItem('SafeDirName', 'Папка с импортированными данными', '', nil, False);
     Hint:= 'В эту папку будут копироваться файлы, отправленные пользователями на импорт';
    AddIntegerItem(l3CStr('MaxImportAge'), l3CStr('Хранить выполненный импорт|дней'), 7);
     Hint := 'Сколько дней будут храниться файлы импорта, выполненного пользователями';
     MinValue := 3;
     MaxValue := 30;
    AddFolderNameItem('BadImportDir', 'Папка с поврежденными заданиями', '', nil, False);
     Hint:= 'В эту папку будут копироваться файлы, отправленные пользователями на импорт и вызвавшие сбой';
   AddDivider('Орфография');
    AddStringItem('asNotify', 'Уведомление о проверке орфографии');
     Hint:= 'На указанные адреса будет отправлен отчет о найденных ошибках';
    AddFileNameItem('MisspellsFile', 'Словарь типовых опечаток'); // Нигде не используется
     Filter:= 'Текстовые файлы (*.txt)|*.txt';
     Hint:= 'Текстовый файл, содержащий список типовых опечаток. Используется для исправления опечаток';
  CloseChild;
 end;
end;

procedure AddAutoAnnoChild(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddChild('AutoAnno', 'Экспорт аннотаций в ежедневную дельту');
   LabelTop:= False;
   AddDateItem('aaStartDate', 'Аннотации, измененные с');
    Hint:= 'Будут экспортированы аннотации, измененные с указанной даты по дату выливки включительно';
   AddFolderNameItem('aaFolder', 'Папка для результатов экспорта', '', nil, False);
    Hint:= 'В эту папку производится автоматический экспорт';
   AddFileNameItem('aaExecute', 'Выполнить по окончании экспорта');
    Hint:= 'Выполнить указанный файл (<файл> <папка экспорта>) по окончании экспорта в папке с файлом.';
    Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
  CloseChild;
 end;
end;

procedure AddAutoExportNode(aConfig: TddAppConfiguration);
var
 l_C: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('AutoIncluded', 'Автоматический экспорт документов');
   LabelTop:= False;
   // Hint:= 'Вместе с подключенными будут экспортированы новые и изменившиеся доументы';
   AddDivider('Диапазон дат');
   l_C:= AddContainerGroup('aeStartDate', 'Экспорт|по сегодня') as TddContainerConfigItem;
    l_C.AddCase('с даты предыдущей компиляции');
    l_C.AddCase('со вчера');
    l_C.AddCase('с последнего экспорта');
     l_C.Add(TddDateConfigItem.Create('aeLastDate', '', MakeDateValue(IncDay(Now, -1))));
    l_C.AddCase('за последние два дня');
    l_C.AddCase('с произвольной даты');
     l_C.Add(TddDateConfigItem.Create('aeCustomStartDate', '', MakeDateValue(IncDay(Now, -1))));
   CloseGroup;

   AddDivider('Куда');
   AddFolderNameItem('AutoIncludedFolder', 'Папка для результатов экспорта', '', nil, False);
    Hint:= 'В эту папку производится автоматический экспорт';

   AddIntegerItem(l3CStr('AutoIncludedSize'), l3CStr('Максимальный размер файла|кбайт'), 4*1024);
    Hint:= 'При превышении этого размера будет создаваться новый файл';
    MinValue := 2*1024;
    MaxValue := 10*1024;
   {$IFNDEF AEByBelongs}
   AddStringItem('DoneFileName', 'Файл-флажок');
    Hint := 'Указанный файл создается в случае успешного окончания автоматического экспорта';
   {$ENDIF}
   AddDivider('Дополнительная обработка');
    {$IF Defined(SGC) or Defined(LUK)}
    AddFileNameItem('aiExecute', 'Компиляция базы Гарант');
    {$ELSE}
    AddFileNameItem('aiExecute', 'Выполнить по окончании экспорта');
    {$IFEND}
     Hint:= 'Выполнить указанный файл по окончании экспорта. В качестве рабочей папки используется папка с исполяемым файлом.';
     Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    AddStringItem('aiParams', 'Параметры запуска');
     Hint:= 'Параметры командной строки для запуска исполняемого файла';
    {$IF Defined(SGC) or Defined(LUK)}
    AddFileNameItem('aiExecute2', 'Обновление базы Гарант');
     Hint:= 'Выполнить указанный файл для обновления базы Гарант. В качестве рабочей папки используется папка с исполяемым файлом.';
     Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    {$IFEND}
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddDivider('Уведомление');
    AddStringItem('aiNotifyList', 'Адреса для отправки уведомления');
     Hint:= 'Почтовые адреса, разделенные ";", на которые будет выслано уведомление об окончании экспорта';
    {$IFDEF aiSMSNotify}
    AddstringItem('aiSMSNotify', 'Адреса для уведомления по СМС');
     Hint:= 'Только на телефоны операторов, поддерживающих услугу mail2sms. Формат задания адресов для Билайн: <номер_телефона Beeline>@sms.beemail.ru[;<номер_телефона Beeline>@sms.beemail.ru]';
    {$ENDIF}
    AddIntegerItem(l3CStr('aiTotalCount'), l3CStr('Допустимое количество документов'), 5000);
     Hint:= 'Если количество документов для экспорта превысит заданное число, будет отправлено уведомление';
   {$IFEND}
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddChild('aiDocuments', 'Новые и изменившиеся подключенные документы');
    LabelTop:= False;
    {$IFDEF AEByBelongs}
    AddItem(TalcuDictionaryTreeItem.Make('aiChangedBases', 'Группы документов', da_dlBases, True, 10));
     Hint:= 'Группы документов, документы которых участвуют в формировании списков';
    {$ELSE}
    AddItem(TalcuDictionaryTreeItem.Make('aiAccGroups', 'Группы доступа', da_dlAccGroups, True, 10));
     Hint:= 'Группы доступа, документы которых участвуют в формровании списков';
    {$ENDIF}
    AddDivider('Шаблоны имен файлов');
     AddStringItem('aiNewDocTemplate', 'Новые документы', 'new%main%~%date%');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiNewRelTemplate', 'Новые справки', 'rel%main%');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiChangedDocTemplate', 'Изменившиеся документы', '%main%~%number%');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiChangedRelTemplate', 'Изменившиеся справки', 'rel%main%2');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
    AddDivider('Дополнительно');
     AddBooleanItem(l3CStr('aiExpandEditions'), l3CStr('Экспортировать со всеми редакциями'));
      Hint := 'Будут экспортированы ВСЕ редакции новых и изменившихся документов';
   CloseChild;
   {$IFEND}
   AddChild('aiFullGroups', 'Все документы');
    LabelTop:= False;
    {$IFDEF AEByBelongs}
    AddItem(TalcuDictionaryTreeItem.Make('aiFullBases', 'Группы документов', da_dlBases, True, 10));
    {$ELSE}
    AddItem(TalcuDictionaryTreeItem.Make('aiFullAccGroups', 'Группы доступа', da_dlAccGroups, True, 10));
      Hint:= 'Необходимо выбрать из списка группу доступа "Справочная и техническая информация"';
    {$ENDIF}
    AddDivider('Шаблоны имен файлов');
     AddStringItem('aiAllDocTemplate', 'Документы', '%main%%number%');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiAllRelTemplate', 'Справки', 'rel_%main%');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
      LabelTop:= False;
    {$IF not Defined(LUK) and not Defined(SGC)}
    AddDivider('Другие настройки');
     AddBooleanItem(l3CStr('aiAllExportIncluded'), l3CStr('Экспортировать только подключенные документы'));
    {$IFEND}
   CloseChild;
   //AddIntegerItem(l3CStr('DeltaStartNumber'), l3CStr('Номер первого файла'), 1);
   // Hint:= 'Номер, с которого начинается нумерация файлов';
   // MinValue:= 1;
   // MaxValue:= 100;
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddChild('aiAnnotation', 'Аннотации');
    LabelTop:= False;
    AddItem(TalcuDictionaryTreeItem.Make('aiBases', 'Группы документов', da_dlBases, True, 10));
     Hint:= 'Группы документов, аннотации которых участвуют в формровании списков';
    AddDivider('Шаблон имени файла');
     AddStringItem('aiAnnoTemplate', 'Аннотации', 'monit');
      Hint:= 'В качестве подстановочных символов можно использовать %main% - короткое название группы доступа,'+
             '%number% - номер файла, %date% - текущая дата в формате YYYYMMDD';
   CloseChild;
   {$IFEND}
  CloseChild;
 end;
end;

{$IFDEF AutoSP}
procedure AddPublInRel(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('aiPublInRel', 'Пополнение справок');
   LabelTop:= False;
   AddFolderNameItem('aiRelFolder', 'Папка с данными о публикации', '', nil, False);
    Hint:= 'В этой папке должны находиться файлы с информацией о публикации';
   AddStringItem('aiRelNotifyList', 'Адреса для отправки уведомления');
    Hint:= 'Почтовые адреса, разделенные ";", на которые будет выслано уведомление об окончании исправления справок';
  CloseChild;
 end;
end;
{$ENDIF}

{$IFDEF Courts}
procedure AddCourtDesNode(aConfig: TddAppConfiguration);
var
 l_Main: TddBaseConfigItem;
 l_List: TddSimpleListConfigItem;
begin
 with aConfig do
 begin
  AddNode('CourtDecisions', 'Судебные решения');
   LabelTop:= False;
   AddItem(TalcuDictComboTreeItem.Make('DocType', 'Тип документа', da_dlTypes, False{, 'Постановление'}));
    Hint:= 'обрабатывать документы только с указанным типом. По умолчанию - "Постановление"';
   {$IFNDEF Region}
   AddDateItem('CD_FromDate', 'Дата последней обработки');
    Hint:= 'Будут обрабатываться документы с указанной даты по текущую';
   {$ENDIF}
   AddStringItem('CD_Email', 'Адреса для уведомления');
    Hint:= 'Почтовые адреса, разделенные ";", на которые будет выслано уведомление об окончании простановки меток';
   with TddSimpleListConfigItem(AddSimpleListItem('CourtList', 'Арбитражные суды')).Config do
   begin
    AddItem(TddBooleanConfigItem.Create('Court_Work', 'Обрабатывать документы', ddEmptyValue));
    AddItem(TalcuDictComboTreeItem.Make('Court_Source', 'Исходящий орган', da_dlSources, False, 6{, l_Main}));
    AddItem(TddStringListConfigItem.Make('Court_Before', 'Список поисковых выражений'{, l_Main}));
   end; // with TddSimpleListConfigItem(AddSimpleListItem('CourtList', 'Арбитражные суды')).Config
  CloseChild;
 end;
end;
{$ENDIF Courts}

procedure AddAutoClassNode(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('AutoClass', 'Автоклассификация');
   LabelTop:= False;
   //AddDivider('А');
   AddFileNameItem('ac_Builder', 'Запуск автоклассификации');
    Hint:= 'Полный путь к файлу, который обрабатывает исходные документы и выдает рекомендации по автоклассификации';
    Filter:= 'Командные файлы (*.cmd, *.bat)|*.cmd;*.bat';
   AddFolderNameItem('ac_Folder', 'Папка для исходных документов', '', nil, False);
    Hint:= 'Папка для экпорта исходных документов из Архивариуса';
   AddFileNameItem('ac_FileName', 'Результат автоклассификации');
    Hint:= 'Файл, содержащий рекомендации по расстановке классов в документах';
    Filter:= 'Результат автоклассификации (*.result)|*.result';
   AddFileNameItem('ac_LogFileName', 'Лог-файл автоклассификации');
    Hint:= 'Файл, отчет о выполненной автоклассификации';
    Filter:= 'Лог-файл автоклассификации (*.log)|*.log';
   AddStringItem('ac_email', 'Адреса для уведомления');
    Hint:= 'Почтовые адреса, разделенные ";", на которые будет выслано уведомление об окончании автоклассификации';
   AddDivider('Контрольная информация');
   AddStringItem('ac_iemail', 'Адрес для отправки');
    Required:= True;
    Hint:= 'На этот адрес будет выслан отчет о состоянии комплекса Автоклассификации';
  CloseChild;
 end;
end;

procedure AddArchiChild(aConfig: TddAppConfiguration);
var
 l_File: TddFileNameConfigItem;
 l_Folder: TddFolderNameConfigItem;
begin
 with aConfig do
 begin
  AddChild('Archi', '"Архивариус"');
   LabelTop:= False;
   AddFileNameItem('ArchiLogFileName', 'Файл лога "Архивариуса"');
    Filter:= 'Файлы лога работы (*.log)|*.log';
    Hint:= 'Полный путь к файлу, в который выводится отчет о работе "Архивариуса"';
   AddIntegerItem(l3CStr('MaxArchiLogFileSize'), l3CStr('Максимальный размер файла лога|Мбайт'));
    MinValue:= 5;
    MaxValue:= 10;
    Hint:= 'По превышении этого размера файл лога будет переименован и начнет заполняться заново.';
   AddBooleanItem(l3CStr('ZipLogFiles'), l3CStr('Сжимать для экономии дискового пространства'), True);
    Hint:= 'Для экономии места на диске лог-файл будет сжат в zip-архив';
   AddIntegerItem(l3CStr('FreeSpaceLimit'), l3CStr('Минимум свободного места на диске|размера базы'), 3);
    MinValue:= 1;
    Hint:= 'При уменьшении свободного места на диске с базой данных ниже указанного предела будет отправлено предупреждение';
   //AddFileNameItem('DeletedFileList', 'Файл списка удаленных NODOC');
   // Hint:= 'В этот файл заносятся номера удаленных документов с типом NoDoc, используется в сценариях обработки массива NSRC';
   AddDivider('Профилактика');
    AddIntegerItem(l3CStr('WaitTime'), l3CStr('Ожидание выхода|мин'), 15);
     MinValue:= 1;
     MaxValue:= 30;
     Hint:= 'Время ожидания выхода пользователей в минутах после начала профилактики';
    AddStringItem('NotifyAddress', 'Адрес нотификации'{, 'jurotd@garant.ru'});
     Hint:= 'Почтовый адрес, на который будет выслано уведомление об окончании профилактики';
     LabelTop:= False;

   AddIntegerItem(l3CStr('UpdateInterval'), l3CStr('Интервал обновления очереди заданий|секунд'), 10);
    MinValue := 10;
    maxValue := 120;
    Hint := 'Как часто будет отправляться пользователям информация об изменении очереди заданий';

   with TddSimpleListConfigItem(AddSimpleListItem('LogoList', 'Список экранов приветствия')).Config do
   begin
    l_File:= TddFileNameConfigItem.Make('logo_File', 'Файл изображения');
    l_File.FilterMask:= 'Все файлы изображений (*.jpg, *.png, *.bmp)|*.jpg;*.png;*.bmp|JPG (*.jpg)|*.jpg|PNG (*.png)|*.png|BMP (*.bmp)|*.bmp';
    AddItem(l_File);
    AddItem(TddDateConfigItem.Create('Logo_Start', 'Начало действия', ddEmptyDateValue));
    AddItem(TddDateConfigItem.Create('Logo_Finish', 'Окончание действия', ddEmptyDateValue));
    AddItem(TddBooleanConfigItem.Create('Logo_Once', 'Один раз', ddEmptyValue));
   end;
   {$IFDEF UserQuery}
   AddDivider('Поисковые запросы');
    l_Folder:= AddFolderNameItem('sqFolder', 'Папка для хранения запросов', 'UserQueries', nil, False) as TddFolderNameConfigItem;
     Required:= True;
     l_Folder.PathFill:= dd_ftFull;
     Hint:= 'Папка для хранения пользовательских поисковых запросов';
   CloseChild;
   {$ENDIF}
  CloseChild;
 end;
end;

procedure AddUserMessagesChild(aConfig: TddAppConfiguration);
var
 l_List: TddSimpleListConfigItem;
begin
 with aConfig do
 begin
  AddChild('UserMessages', 'Сообщения пользователям');
   LabelTop:= False;
   AddStringsItem('InfoMessages', 'Информационные сообщения');
    Hint:= 'Сообщения из данного списка используются в рассылке информационных сообщений';
   AddStringsItem('LockMessages', 'Сообщения о закрытии базы');
    Hint:= 'Сообщения из данного списка используются при закрытии базы';
   l_List:= TddSimpleListConfigItem(AddSimpleListItem('EmailNotifications', 'Уведомления пользователям'));
    l_List.TitleCaption := 'Заголовок сообщения';
    l_List.Config.AddItem(TddTextConfigItem.Make('Body', 'Сообщение'));
  CloseChild;
 end;
end;

procedure AddMainConfig(aConfig: TddAppConfiguration);
var
 l_Node: TddCustomConfigNode;
 l_Main: TddBaseConfigItem;
 l_Dict: TdaDictionaryType;
 l_S: String;
begin
 with aConfig do
 begin
  l_Node:= AddNode('General', 'Основные');
   LabelTop:= False;
   AddStringItem('BaseID', 'Описание базы данных', 'Сервер Автоматизации Архивариуса');
    Hint:= 'Текстовое описание базы данных используется в качестве автора письма в рассылках';
   AddDivider('База данных');
   TdaDataProviderSuperFactory.Instance.BuildConfig(aConfig);
   AddDivider('Коммуникации');
   TIdStack.IncUsage;
   l_S:= GStack.LocalAddress;
   TIdStack.DecUsage;
   AddStringItem('ServerName', 'Адрес сервера', l_S);
    Hint:= 'Адрес сервера';
    Required:= True;
   AddIntegerItem(l3CStr('ServerPort'), l3CStr('Порт сервера'), 32100);
    Hint:= 'Порт сервера';
    Required:= True;

   AddDivider('Разное');
    AddTimeItem('WorkDayStart', 'Рабочий день начинается в|часов', EncodeTime(8, 0, 0, 0));
     Hint:= 'До этого времени должно закончиться выполнение автоматизированных операций';
    AddBooleanItem(l3CStr('ExcludeWeekEnd'), l3CStr('Суббота и воскресенье нерабочие'), True);
     Hint:= 'Выходные будут считаться одним днем при расчете времени окончания процедур обновления.';
    {$IFDEF UseArchiCopyFile}
    AddBooleanItem(l3CStr('UseSystemCopy'), l3CStr('Системная функция копирования'), True);
     Hint:= 'Использовать для копирования функцию операционной системы';
    {$ENDIF}
    {$IFDEF UseCommandFile}
    AddFileNameItem('exUpdater', 'Внешний обновлятор базы');
     Hint:= 'Командный файл для обновления базы данных';
    {$ENDIF}
    AddIntegerItem(l3CStr('l3LogLevel'), l3CStr('Уровень логирования'), alcuMessageLevel);
     Hint:= 'Минимальный - 0, самый подробный - 10';
     MinValue := 0;
     MaxValue := 10;

   AddUserTasksChild(aConfig);

   AddArchiChild(aConfig);

   AddUserMessagesChild(aConfig);
 end;
end;

procedure AddPrimeConfig(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
  AddNode('Annotations', 'Аннотации для Прайм');
   LabelTop:= False;
   AddDivider('Экспортировать аннотации');
   AddDateItem('annoDate',  'Аннотации, подключенные с');
    Hint:= 'Начальная дата диапазона, за который экспортируются аннотации';
   l_Item:= AddComboBoxItem(l3CStr('annoEndDate'), l3CStr('По '), 0);
    Hint:= 'Ближайший следующий день недели. На его основании вычисляется конечная дата диапазона, за который экспортруются аннотации. ';
    with TddComboBoxConfigItem(l_Item) do
    begin
     AddMapValue('сегодня', 0);
     AddMapValue('понедельник', DayMonday);
     AddMapvalue('вторник', DayTuesday);
     AddMapValue('среда', DayWednesday);
     AddMapvalue('четверг', DayThursday);
     AddMapvalue('пятница', DayFriday);
     AddMapValue('суббота', DaySaturday);
     AddMapvalue('воскресенье', DaySunday);
    end;
   //CloseGroup;
   AddFolderNameItem('AnnoFolder', 'Папка для аннотаций', '', nil, False);
    Hint:= 'В эту папку будут сохраняться аннотации';
   AddStringItem('AnnoInfoList', 'Список рассылки');
    Hint:= 'Почтовые адреса, разделенные ";", на которые будет отправляться уведомление об окончании экспорта аннотаций';
   AddDivider('Дополнительно');
    AddItem(TalcuDictionaryTreeItem.Make('annoBelongs', 'Группы документов', da_dlBases, True));
     Hint:= 'Первая из выбранных групп документов используется в формировании имени файла';
    AddFileNameItem('annoExecute', 'Выполнить по окончании экспорта');
     Hint:= 'Выполнить указанный файл (<файл> <папка экспорта> <папка результата>) по окончании экспорта в папке с файлом.';
     Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    AddFolderNameItem('annoOutFolder', 'Папка для результата работы файла', 'out', nil, False);
     Hint:= 'В эту папку будут помещены результаты работы файла, которые будет нужно отправить по почте';
    l_Main:= AddBooleanItem(l3CStr('annoAnalyzeLog'), l3CStr('Анализировать лог-файл'), True);
     Hint:= 'Анализировать результаты работы файла. Наличие в папке экспорта непустого файла YYYY-MM-DD_BELONGS.nsr.log считается ошибкой';
    AddStringItem('annoPrimeEmail', 'Адрес робота Прайма', 'reganno_archi@garant.ru');
     Hint:= 'Если ошибок нет, результат экспорта будет отправлен на указанный адрес';
   AddChild('PrimeDocs','Документы от аннотаций');
   LabelTop:= False;
   l_Main:= AddBooleanItem(l3CStr('annoNeedDocs'), l3CStr('Экспортировать документы'), True);
    AddFolderNameItem('AnnoDocFolder', 'Папка для документов', '', l_Main, False);
     Hint := 'В эту папку будут сохраняться документы, относящиеся к аннотациям';
    AddStringItem('AnnoDocListFile', 'Файл со списком документов', '', l_Main);
     Hint := 'Файл, в который будет записан список сохраненных документов. Создается в папке для документов';
    // Фильтры документов
    // Комментарии
    AddGroupItem('annoCommentGroup', 'Исключать "Комментарии и разъяснения"', l_Main);
     AddItem(TalcuDictComboTreeItem.Make('annoProjects', 'Группа доступа', da_dlAccGroups, False, 6, l_Main));
      Hint:= 'документы из выбранной группы доступа экспортироваться не будут';
     AddItem(TalcuDictComboTreeItem.Make('annoComments', 'Тип', da_dlTypes, False, 6, l_Main));
      Hint:= 'Документы выбранных типов экспортироваться не будут';
    CloseGroup;
    // Проекты
    AddGroupItem('annoProjectsGroup', 'Исключать "Проекты законов"', l_Main);
     AddItem(TalcuDictComboTreeItem.Make('annoProjects2', 'Группа документов', da_dlBases, False, 6, l_Main));
      Hint:= 'Документы из выбранной группы документов экспортироваться не будут';
     AddItem(TalcuDictionaryTreeItem.Make('annoProjects3', 'Типы', da_dlTypes, True, 6, l_Main));
      Hint:= 'Документы выбранных типов экспортироваться не будут';
    CloseGroup;
    {$IFNDEF Region}
    AddItem(TalcuDictionaryTreeItem.Make('annoAccGroup', 'Исключать Группы доступа', da_dlAccGroups, True));
     Hint:= 'Документы из выбранных групп доступа экспортироваться не будут';
    {$ENDIF} 
  CloseChild;
 end;
end;

procedure AddAutoLinkNode(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddChild('alcAutoLink', 'Простановщик ссылок');
    AddRadioGroupItem('alcMode', 'Режим работы', 1);
     Add('Сервер');
     Add('Клиент');

     AddStringItem('alcFTPHost', 'FTP сервер', 'partner.garant.ru');
     LabelTop:= False;
    AddIntegerItem(l3CStr('alcFTPPort'), l3CStr('Порт'), 21);
     MinValue:= 1;
     MaxValue:= 65000;
    AddStringItem('alcFTPUser', 'Имя пользователя', '');
     LabelTop:= False;
    AddStringItem('alcFTPPassword', 'Пароль', '');
     PasswordChar:= '*';
     LabelTop:= False;
    AddStringItem('alcFTPFolder', 'Папка на сервере', '');
     LabelTop:= False;
    AddBooleanItem(l3CStr('alcFTPPassive'), l3CStr('Пассивный режим'));
     LabelTop:= False;
  CloseChild;
 end;
end;


procedure AddDailyConfig(aConfig: TddAppConfiguration; AutolinkEnabled: Boolean);
var
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
   AddNode('Everyday', 'Ежедневное обновление');
    LabelTop:= False;
    l_Main:= AddBooleanItem(l3CStr('DoEverydayUpdate'), l3CStr('Выполнять ежедневное обновление'));
    AddDivider('Резервное копирование');
     AddFolderNameItem('FamilyBackup', 'Папка для семейства', 'Yesterday', l_Main, False);
      Hint:= 'В указанную папку копируется только папка с документами и атрибутами';
     AddIntegerItem(l3CStr('EveryDayBackupCount'), l3CStr('Хранить|копий семейства'), 3, l_Main);
      MinValue:= 1;
      MaxValue:= 7;
     l_Item:= AddBooleanItem(l3CStr('DoFullBackup'), l3CStr('Выполнять полное копирование базы в папку'), False, l_Main);
     AddFolderNameItem('FullBackup', '', GetWindowsTempFolder, l_Item, False);
      Hint:= 'Копируются все папки базы. Новая копия затирает предыдущую';
     AddItem(TalcuWeekChecklineItem.Make('FullBackupAtDays', '', l_Item));
      Hint:= 'Выполнять копирование в следующие дни недели';

    AddDivider('Обновление');
    {$IFNDEF LUK}
    l_Item:= AddBooleanItem(l3CStr('DoImportKW'), l3CStr('Импортировать файл ключевых слов'), False, l_Main);
    AddFileNameItem('KWFileName', '', '', l_Item);
     Filter:= 'Файлы ключевых слов (*.kw)|*.kw';
    {$ENDIF}
    AddBooleanItem(l3CStr('DoUpdateBase'), l3CStr('Обновлять таблицы базы данных'), True, l_Main);
    AddBooleanItem(l3CStr('DoHeaderIndex'), l3CStr('Индексировать заголовки документов'), True, l_Main);
    {$IFNDEF LUK}
    AddBooleanItem(l3CStr('DoDictEntryIndex'), l3CStr('Индексировать словарные статьи'), True, l_Main);
    {$ENDIF}
    AddBooleanItem(l3CStr('DoUpdateIndex'), l3CStr('Обновлять текстовый индекс'), True, l_Main);
    AddBooleanItem(l3CStr('DoUpdateText'), l3CStr('Обновлять текстовую часть'), True, l_Main);
    {$IFDEF KWSending}
    AddChild('KWMailList', 'Рассылка файла ключевых слов');
     LabelTop:= False;
     //AddFilenameItem('KWArchiveMaker', 'Файл, создающий архив ключевых слов');
     //AddFileNameItem('KWArchivename', 'Файл с архивом ключевых слов');
     AddStringItem('KWRecepients', 'Получатели архива ключевых слов');
    CloseChild;
    {$ENDIF KWSending}

    {$IFDEF AAC}
    AddChild('Dossier', 'Создание досье для постановлений ААС');
     LabelTop:= False;
     AddItem(TalcuDictComboTreeItem.Make('dosType', 'Тип документов', da_dlTypes, False));
      Hint:= 'Необходимо выбрать из списка тип документа "Постановление"';  // Вроде нигде больше не используется
     AddItem(TalcuDictionaryTreeItem.Make('dosSource', 'Исходящие органы', da_dlSources, True));
      Hint:= 'Необходимо выбрать минимум один арбитражный суд';
     AddDateItem('dosDate', 'Дата последней обработки');
      Hint:= 'Досье будут созданы для постановлений, добавленных начиная с указанной даты';
    CloseChild;

    AddChild('CaseCodes', 'Создание номеров дел для постановлений ФАС');
     LabelTop:= False;
     AddItem(TalcuDictionaryTreeItem.Make('ccType', 'Тип документов', da_dlTypes, True));
      Hint:= 'Необходимо выбрать из списка тип документа "Постановление" и "Определение"';
     AddItem(TalcuDictionaryTreeItem.Make('ccSource', 'Исходящие органы', da_dlSources, True));
      Hint:= 'Необходимо выбрать минимум один арбитражный суд';
     AddDateItem('ccDate', 'Дата последней обработки');
      Hint:= 'Досье будут созданы для постановлений, добавленных начиная с указанной даты';
    CloseChild;

    AddChild('LawCaseUpdate', 'Обновление постановлений АС');
     LabelTop:= False;
     AddItem(TalcuDictionaryTreeItem.Make('lcType', 'Тип документов', da_dlTypes, True, 6));
      Hint:= 'Необходимо выбрать из списка тип документа "Постановление" и "Определение"';
     AddItem(TalcuDictionaryTreeItem.Make('lcSource', 'Исходящие органы', da_dlSources, True, 6));
      Hint:= 'Необходимо выбрать минимум один арбитражный суд. Документы этих Исходящих органов используются для поиска повторов.';
     AddItem(TalcuDictionaryTreeItem.Make('lcFASSource', 'Исходящие органы ФАС', da_dlSources, True, 6));
      Hint:= 'Необходимо выбрать минимум один Федеральный Арбитражный суд. Документы этих Исходящих органов используются для поиска повторов.';
     AddItem(TalcuDictComboTreeItem.Make('lcPublished', 'Источник опубликования', da_dlCorSources, False));
      Hint:= 'Необходимо указать источник опубликования документов. Обычно это "Получено по рассылке".';
     AddStringItem('lcNotify', 'Отправить отчет');

     AddChild('lcFiles', 'Файлы перекодировки');
      LabelTop:= False;
      AddFileNameItem('lcSourceFile', 'Исходящие органы');
       Filter:= 'Значения, разделенные запятыми|*.csv';
      AddFileNameItem('lcLinkDataFile', 'Данные для простановки ссылок');
       Filter:= 'Значения, разделенные запятыми|*.csv';
      AddFileNameItem('lcKeyThemes', 'Список Ключевых тем');
       Filter:= 'Значения, разделенные запятыми|*.csv';
      AddFileNameItem('lcMisspells', 'Список опечаток');
       Hint:= 'Файл с типовыми опечатками, для исправления во время импорта';
       Filter:= 'Значения, разделенные запятыми|*.csv';
      AddFileNameItem('lcTypeSyno', 'Список перекодировки Типов');
       Filter:= 'Значения, разделенные запятыми|*.csv';
      AddFileNameItem('lcSourceConvertFile', '"Решения и Постановления"');
       Filter:= 'Текстовые файлы|*.txt';
      AddFileNameItem('lcFASCorrect', 'Список коррекции органов ФАС');
       Filter:= 'Значения, разделенные запятыми|*.csv';
     CloseChild; //lcFiles

     AddChild('lcFolders', 'Настройки папок');
      LabelTop:= False;
      AddFolderNameItem('lcSourceFolder', 'Папка с исходными данными', '', nil, False);
       Hint:= 'В этой папке находятся постановления ААС в формате Эверест';
      AddIntegerItem(l3CStr('lcMaxFileCount'), l3CStr('Обрабатывать по|файлов'), 10000);
       Hint:= 'Найденные файлы будут обработаны за несколько проходов';
      AddFolderNameItem('lcDestFolder', 'Папка для обработанных файлов', '', nil, False);
       Hint:= 'В эту папку будут скопированы успешно обработанные файлы';
      AddFolderNameItem('lcDuplicateFolder', 'Папка для хранения дубликатов', '', nil, False);
       Hint:= 'В эту папку будут скопированы найденные дубликаты постановлений';
      AddFolderNameItem('lcArchive', 'Папка для хранения запакованных логов', CorrectArchiveWarehousePath('', 'AAC Update Logs'), nil, False);
       Hint := 'В этой папке хранятся запакованные логи';
       PathFill:= dd_ftFull;
      AddIntegerItem(l3CStr('lcMaxLogAge'), l3CStr('Хранить логи выполненного импорта|дней'), 0);
       Hint := 'Сколько дней будут храниться логи выполненного автоматического импорта';
       MinValue := 0;
       MaxValue := 1200;
     CloseChild; // lcfolders

     AddChild('lcRelated', 'Экспорт справок');
      LabelTop:= False;
      AddItem(TalcuDictionaryComboItem.Make('lcRelAccGroup', 'Группа доступа', da_dlAccGroups));
       Hint:= 'Необходимо выбрать Группу доступа, для которой будут экспортироваться справки';
      AddFolderNameItem('lcRelFolder', 'Папка для справок', '', nil, False);
       Hint:= 'В эту папку будут экспортированы изменившиеся справки';
      AddFileNameItem('lcRelDoneFile', 'Выполнить по окончании');
       Hint:= 'После окончания экспорта будет выполнен указанный файл';
     CloseChild;
    CloseChild; // CaseCodes
    {$ENDIF AAC}
    {$IFDEF SubDeletedNotify}
    AddChild('DictUpdate', 'Удаленные метки');
     LabelTop:= False;
     AddFileNameItem('DictUpdateFileName', 'Файл изменений меток', 'changed_anchors.txt');
      Hint:= 'В этот файл будет записана информация о удаленных метках с атрибутами. Должен быть UNC с возможностью записи с рабочих станций';
      Required:= True;
     AddStringItem('DictUpdateMail', 'Уведомление об удалении меток');
      Hint:= 'На этот адрес будут рассылаться списки удаленных меток с атрибутами';
    CloseChild;
    {$ENDIF}
    if AutolinkEnabled then
     AddAutoLinkNode(aConfig);
 end;
end;



procedure AddDeltaConfig(aConfig: TddAppConfiguration);
var
 l_Node: TddCustomConfigNode;
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
  l_Node:= AddNode('Everyweek', 'Импорт дельты документов');
   LabelTop:= False;
   l_Main:= AddBooleanItem(l3CStr('DoEveryweekUpdate'), l3CStr('Выполнять импорт дельты документов'));
    Hint:= 'Используется для импорта большого объема документов, обрабатываемых все "Архивариуса"';
   AddFolderNameItem('BackupRoot', 'Папка для хранения резервных копий', '', l_Main, False);
    Hint:= 'В этой папке будут создаваться резервные копии базы данных перед заливкой дельты документов';
   AddIntegerItem(l3CStr('BackupCount'), l3CStr('Хранить|резервные копии'), 3, l_Main);
    MinValue:= 1;
    MaxValue:= 8;
   AddFolderNameItem('SourceFolder', 'Папка с файлами "Дельты"', '', l_Main, False);
    Hint:= 'В этой папке будут находиться NSR-файлы новых и изменившихся документов';
   AddFolderNameItem('PictureFolder', 'Папка с графическими файлами', '', l_Main, False);
    Hint:= 'Папка с данными для объектных документов (!OBJTOPIC)';
 //  AddFolderNameItem('KWFileName2', 'Файл ключевых слов', '', l_Main, nil);
 //   Filter:= 'Файлы ключевых слов (*.kw)|*.kw';
   {$IFDEF CheckPriority}
   AddFileNameItem('PriorityFileName', 'Файл эталонной таблицы важности', '', l_Main);
    Filter:= 'Текстовые файлы (*.txt)|*.txt';
    Hint:= 'На основании данных из этого файла будет вычисляться важность (юридическая сила) документов';
   {$ENDIF}
   AddBooleanItem(l3CStr('DoUpdateTextIndex'), l3CStr('Обновлять текстовый индекс'), False, l_Main);
    Hint:= 'Обновление текстового индекса для импортированных документов';

   AddChild('Delta', 'Создание Дельты');
    LabelTop:= False;
    l_Item := AddBooleanItem(l3CStr('CheckLogFile'), l3CStr('Проверять готовность данных для Дельты'), True, l_Main);
     Hint := 'В почтовый ящик, указанный на странице "Получение почты" должно придти письмо с уведомлением';
    AddStringItem('DeltaPattern', 'Признак уведомления готовности', 'SX weekly delta ready', l_Item);
     Hint := 'Если указанный текст будет содержаться в тексте письма, считается, что это уведомление';
    AddIntegerItem(l3CStr('NotifyAge'), l3CStr('Учитывать письма не старше|часов'), 12, l_Item);
     MinValue  := 1;
     MaxValue  := 24;
     Hint := 'Письма, полученные раньше, чем за указанное число часов до проверки, из рассмотрения исключаются';
    l_Item:= AddBooleanItem(l3CStr('DoMakeDelta'), l3CStr('Подготавливать "Дельту" самостоятельно'), False, l_Main);
    AddFileNameItem('DeltaCreator', '', '', l_Item);
     Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
     Hint:= 'Файл, создающий дельту документов за неделю';
    AddFileNameItem('SpravkiFileName', 'Файл с пропущенными справками', '', l_Item);
     Hint:= 'В указаный файл записывается список справок, непопавших в "Дельту"';
   CloseChild;
  {$IFNDEF Region}
   AddChild('AddionalDelta', 'Дополнительно');
    //l_Item:= AddBooleanItem(l3CStr('DoHolidayBase'), l3CStr('Создавать базу "Выходного дня"'), False);
    //AddFolderNameItem('HolidayFolder', '', '', l_Item, nil);
    l_Main:= AddBooleanItem(l3CStr('DoAddionalDelta'), l3CStr('Создавать дополнительную "Дельту"'));
    AddFileNameItem('AddDeltaCreator', '', '', l_Main);
     Filter:= 'Исполняемые файлы (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
     Hint:= 'Файл, создающий дополнительную дельту документов';
    AddStringItem('AddEmailNotfy', 'Адрес уведомления готовности', '', l_Main);
     Hint := 'На указанный адрес будет отправлено письмо по окончании подготовки дополнительной дельты';
    AddStringItem('AddDeltaPattern', 'Текст уведомления', 'SX weekly delta ready', l_Main);
     Hint := 'Текст письма с уведомлением об окончании подготовки дополнительной дельты';
    AddFileNameItem('DiffList', 'Файл отличий', '\\archi3\archi\incoming\Spravki\diff.lst');
     Hint := 'Файл, содержащий разницу между дельтой и импортированными документами';
  {$ENDIF Region};   
   CloseChild;
 
 end;
end;

procedure AddNotifyConfig(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
begin
 with aConfig do
 begin
  AddNode('Notification', 'Уведомления');
  LabelTop:= False;
  AddStringItem('SMTPAddress', 'Обратный адрес');
  l_Item:= AddBooleanItem(l3CStr('SMTPReply'), l3CStr('Возможность ответа'));
   AddStringItem('SMTPForward', 'Адрес пересылки', '', l_Item);
  AddStringItem('SMTPHost', 'Сервер SMTP');
  LabelTop:= False;
  AddIntegerItem(l3CStr('SMTPPort'), l3CStr('Порт SMTP'), 25);
   MinValue:= 1;
   MaxValue:= 65000;
  l_Item:= AddBooleanItem(l3CStr('Authentication'), l3CStr('Требуется авторизация'));
  AddStringItem('SMTPLogin', 'Логин', '', l_Item);
   LabelTop:= False;
  AddStringItem('SMTPPassword', 'Пароль', '', l_Item);
   PasswordChar:= '*';
   LabelTop:= False;
  AddBooleanItem(l3CStr('SMTPRequireSSL'), l3CStr('Использовать шифрование SSL'));
  AddFolderNameItem('SmtpSendQueueFolder', 'Папка для хранения неотправленной почты', IncludeTrailingPathDelimiter(ChangeFileExt(ParamStr(0),'.mail')), nil, False);
  mailAdapter:= TalcuEmailAdapter.Create;
  try
   AddListItem('NotifyList', 'Список уведомлений', mailAdapter);
  finally
   l3Free(mailAdapter);
  end;
  l_Item:= AddBooleanItem(l3CStr('EnableSMS'), l3CStr('Отправлять смс'), False);
   Hint := 'В случае ошибок на перечисленные номера будет отправлено SMS с описанием ошибки';
   AddStringItem('SMSList', 'Адреса рассылки', ''{'6246622@sms.beemail.ru;1118255@sms.beemail.ru'}, l_Item);
    Hint := 'Только на телефоны операторов, поддерживающих услугу mail2sms. Формат задания адресов для Билайн: <номер_телефона Beeline>@sms.beemail.ru[;<номер_телефона Beeline>@sms.beemail.ru]';
  AddChild('RecieveMail', 'Получение почты');
   AddStringItem('POPHost', 'Сервер POP3');
   LabelTop:= False;
   AddIntegerItem(l3CStr('POPPort'), l3CStr('Порт POP3'), 110);
    MinValue:= 1;
    MaxValue:= 65000;
   AddStringItem('POPLogin', 'Логин');
    LabelTop:= False;
   AddStringItem('POPPassword', 'Пароль');
    PasswordChar:= '*';
    LabelTop:= False;
   AddBooleanItem(l3CStr('POPRequireSSL'), l3CStr('Использовать шифрование SSL'));

   AddIntegerItem(l3CStr('POPInterval'), l3CStr('Проверять почту каждые|минут'));
    MinValue := 0;
    MaxValue := 30;
    Hint := 'Если интервал проверки почты равен 0, проверка осуществляться не будет';

  CloseChild;
  CloseChild;
 end;
end;

{$IFDEF ExchangeDocs}
procedure AddExternalDeltas(aConfig: TddAppConfiguration);
var
 l_G: TddGroupConfigItem;
 l_List: TddSimpleListConfigItem;
 l_I: TddVisualConfigItem;
 l_C: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('ExtDeltas', 'Внешние дельты');
  // источники
   AddGroupItem('regSourcesGroup', 'Входяхие дельты');
    l_List:= TddSimpleListConfigItem(AddSimpleListItem('regSources', 'Источники дельт'));
    l_List.Config.LabelTop:= False;
    l_List.TitleCaption:= 'Описание источника';
    l_List.Config.AddItem(TddDividerConfigItem.Create('regFTP', 'Параметры FTP', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPServer', 'Сервер'));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPLogin', 'Пользователь'));
      l_I:= l_List.Config.AddItem(TddStringConfigItem.Make('FTPPassword', 'Пароль')) as TddVisualConfigItem;
      TddStringConfigItem(l_I).PasswordChar:= '*';
      l_List.Config.AddItem(TddBooleanConfigItem.Create('FTPPassive', 'Пассивный режим', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPFolder', 'Папка на сервере'));
     l_List.Config.AddItem(TddDividerConfigItem.Create('regDocs', 'Дополнительно', ddEmptyValue));
     l_List.Config.AddItem(TddStringConfigItem.Make('FileNameMask', 'Шаблон имени файла'));
     l_List.Config.AddItem(TddStringConfigItem.Make('NotifyAddress', 'Адрес уведомления'));
    AddFolderNameItem('regSourcesArchive', 'Папка для хранения принятых дельт', CorrectArchiveWarehousePath('', 'Region deltas\Import'), nil, False);
     Hint := 'В этой папке хранятся принятые архивы с дельтами';
     PathFill:= dd_ftFull;
   CloseGroup;
   // Потребители
   AddGroupItem('regDestinationsGroup', 'Исходящие дельты');
    l_List:= TddSimpleListConfigItem(AddSimpleListItem('regDestinations', 'Потребители дельт'));
    l_List.Config.LabelTop:= False;
    l_List.TitleCaption:= 'Описание потребителя';
     l_List.Config.AddItem(TddDividerConfigItem.Create('regFTPDest', 'Параметры FTP', ddEmptyValue));
     l_List.Config.AddItem(TddStringConfigItem.Make('FTPServerDest', 'Сервер'));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPLoginDest', 'Пользователь'));
      l_I:= l_List.Config.AddItem(TddStringConfigItem.Make('FTPPasswordDest', 'Пароль')) as TddVisualConfigItem;
      TddStringConfigItem(l_I).PasswordChar:= '*';
      l_List.Config.AddItem(TddBooleanConfigItem.Create('FTPPassiveDest', 'Пассивный режим', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPFolderDest', 'Папка на сервере'));
     l_List.Config.AddItem(TddDividerConfigItem.Create('regDocsDest', 'Параметры экспорта', ddEmptyValue));
     l_C:= TddContainerConfigItem(l_List.Config.AddItem(TddContainerConfigItem.SimpleCreate('DataTypeDest', 'Документы')));
      l_C.AddCase('По Группам Доступа');
       l_C.Add(TalcuDictionaryTreeItem.Make('AccGroupsDest', '', da_dlAccGroups, True));
      l_C.AddCase('Поиском');
       l_C.Add(TalcuQueryComboboxItem.make('QueryDest', ''));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withAnnoDest', 'Включать аннотации', makeBoolValue(True)));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withEditionDest', 'Включать редакции', makeBoolValue(False)));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withNotIncDest', 'Включать неподключенные', makeBoolValue(False)));
     l_List.Config.AddItem(TddStringConfigItem.Make('FileNameMaskDest', 'Шаблон имени файла'));
     l_List.Config.AddItem(TddStringConfigItem.Make('NotifyAddressDest', 'Адрес уведомления'));
    AddFolderNameItem('regDestinationsArchive', 'Папка для хранения отправленных дельт', CorrectArchiveWarehousePath('', 'Region deltas\Export'), nil, False);
     Hint := 'В этой папке хранятся отправленные архивы с дельтами';
     PathFill:= dd_ftFull;
   CloseGroup;
  CloseChild;
 end; // with ddAppConfiguration
end;
{$ENDIF ExchangeDocs}

procedure AddQueryExportNode(aConfig: TddAppConfiguration);
var
 l_Main: TddBaseConfigItem;
 l_List: TddSimpleListConfigItem;
 l_Item: TddBaseConfigItem;
begin
(*
 with aConfig do
 begin
  AddNode('QueriedExport', 'Экспорт по запросу');
   with TddSimpleListConfigItem(AddSimpleListItem('ExportList', 'Список заданий')).Config do
   begin
    //AddItem(TalcuDictComboTreeItem.Make('qe_Query', 'Поисковый запрос', da_dlSources, False, 6{, l_Main}));
   l_Item:= TddComboBoxConfigItem.Create(l3CStr('annoEndDate'), l3CStr('По '), 0);
    Hint:= 'Ближайший следующий день недели. На его основании вычисляется конечная дата диапазона, за который экспортруются аннотации. ';
    with TddComboBoxConfigItem(l_Item) do
    begin
     AddMapValue('сегодня', 0);
     AddMapValue('понедельник', DayMonday);
     AddMapvalue('вторник', DayTuesday);
     AddMapValue('среда', DayWednesday);
     AddMapvalue('четверг', DayThursday);
     AddMapvalue('пятница', DayFriday);
     AddMapValue('суббота', DaySaturday);
     AddMapvalue('воскресенье', DaySunday);
    end;

    AddItem(TddStringListConfigItem.Make('qe_Format', 'Формат файла'{, l_Main}));
    AddItem(TddStringConfigItem.Create('qe_Split', 'Размер файла', ddEmptyValue{, l_Main}));
    AddItem(TddFolderNameConfigItem.Create('qe_Folder', 'Папка назначения', ddEmptyValue));
   end;
  CloseChild;
 end;
*)
end;
(*
procedure AddSectionMakerNode(aConfig: TddAppConfiguration);
begin
 // TODO -cMM: AddSectionMakerNode необходимо написать реализацию
 with aConfig do
 begin
  AddNode('SectionMaker', 'Расстановка разделов');
   // Дата последней обработки
   AddDateItem('smLast', 'Дата последней обработки');
   // тип даты
   AddRadioGroupItem('smDates', 'Обрабатывать документы',1);
    Add('С даты последней обработки');
    Add('С даты компиляции');
   // адрес уведомления
   AddStringItem('smNotify', 'Об окончании уведомить');
  CloseChild;
 end;
end;
*)
procedure AddHavanskyExportChild(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('PikPress', 'Экспорт для Пик Пресс');
   LabelTop:= False;
  // Дата последней обработки
   AddDateItem('ppLast', 'Дата последней обработки');
   AddFolderNameItem('ppFolder', 'Папка', '', nil, False);
   AddDivider('Включать документы');
   AddItem(TalcuDictionaryTreeItem.Make('ppinSource', 'Исходящие органы', da_dlSources, True));
    Hint:= '';
   // Sources
   AddDivider('Исключать документы');
   AddItem(TalcuDictionaryTreeItem.Make('ppexSource', 'Исходящие органы', da_dlSources, True));
   AddItem(TalcuDictionaryTreeItem.Make('ppexType', 'Тип', da_dlTypes, True));
   AddItem(FTPParams('ppex', 'Параметры FTP'));
   CloseGroup;
  CloseChild;
 end;
end;

procedure AddAnoncedChild(aConfig: TddAppConfiguration);
var
 l_C, l_C2: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('Anonced', 'Анонсирование документов');
   LabelTop:= False;
   {$IFDEF AnoncedExport}
   AddDivider('Экспорт анонсированных');
   AddFolderNameItem('anonFolder', 'Папка для экспорта', '', nil, False);
   l_C:= AddContainerGroup('anonExport', 'Параметры экспорта') as TddContainerConfigItem;
    l_C.AddCase('Ежедневно, кроме четверга');
     l_C.Add(TalcuDictionaryTreeItem.Make('anonAccGroups', 'Группы доступа', da_dlAccGroups, True, 10));
    l_c.AddCase('В четверг');
     l_C.Add(TalcuDictionaryTreeItem.Make('anonAccGroupsEx', 'Группы доступа', da_dlAccGroups, True, 10));
     l_C.Add(TddStringConfigItem.Make('anonThuFileName', 'Имя файла', 'anonsm.nsr'));
   CloseGroup;
   (*
   AddItem(TalcuDictionaryTreeItem.Make('anonAccGroups', 'Группы доступа', da_dlAccGroups, True, 10));
    Hint:= 'Группы доступа, документы которых участвуют в формровании списков';
   AddItem(TalcuDictionaryTreeItem.Make('anonAccGroupsEx', 'Группы доступа по чтв', da_dlAccGroups, True, 10));
    Hint:= 'Группы доступа, документы которых участвуют в формровании списков';
   *)
   AddStringItem('anonEmail', 'Адрес для уведомления');
   
   AddDivider('Анонсирование');
   {$ENDIF}
   l_C:= AddContainerGroup('anonDate', 'Анонсировать датой') as TddContainerConfigItem;
    l_C.AddCase('Вычисляется автоматически');
     // Правила вычисления по дням недели - время-день
     //l_C2:= AddContainerGroup('anonDateRules', 'Правила вычисления') as TddContainerConfigItem;
     //l_C.Add(l_C2
    l_C.AddCase('Задается вручную');
     l_C.Add(TddDateConfigItem.Create('anonCustomDate', 'Дата', MakeDateValue(IncDay(Today))));
     (* Временно отключено
     l_C.Add(TddDateConfigItem.Create('anonFromDate',   'начиная с', MakeDateValue(IncDay(Today))));
     l_C.Add(TddTimeConfigItem.Create('anonFromTime',   'в', MakeDateValue(IncDay(Today))));
     l_C.Add(TddDateConfigItem.Create('anonToDate',     'заканчивая', MakeDateValue(IncDay(Today))));
     l_C.Add(TddTimeConfigItem.Create('anonToTime',     'в', MakeDateValue(IncDay(Today))));
     *)
   CloseGroup;
  CloseChild;
 end;
end;


function CreateConfigEx(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil): TddAppConfiguration;
var
 l_Node: TddCustomConfigNode;
 l_Item, l_Main: TddBaseConfigItem;
 l_Dict: TdaDictionaryType;
begin
 l_Main:= nil;
 Result:= TddAppConfiguration.Create(aStorage);
 with Result do
 begin
  AutoSize:= True;
{$IFDEF ServerAssistantSide}
  AutoSave:= False;
{$ELSE ServerAssistantSide}
  AutoSave:= True;
{$ENDIF ServerAssistantSide}
  LabelTop:= False;
  Version:= 6;
  AddVersionHandler(1, 2, Upgrade1To2);
  AddVersionHandler(2, 3, Upgrade2To3);
  AddVersionHandler(3, 4, Upgrade3To4);
  AddVersionHandler(4, 5, Upgrade4To5);
  AddVersionHandler(5, 6, Upgrade5To6);
  { Невизуальные параметры. Или пока не визуальные }
  AddBooleanItem(l3CStr('ShowSplash'), l3CStr('Показывать окно при подключении к базе'), False);
  AddBooleanItem(l3CStr('DictEnglish'), l3CStr('Использовать английские названия элементов словарей вместо русских'), False);
  AddBooleanItem(l3CStr('LegalShutdown'), l3CStr('Сессия закончилась корректно'), True);
  { основные параметры }
  AddMainConfig(Result);
  { Автоматический экспорт }
  AddAutoExportNode(Result);
  AddAutoAnnoChild(Result);
  {$IFDEF AutoSP}
  AddPublInRel(Result);
  {$ENDIF}
  AddAnoncedChild(Result);
  {$IFDEF AutoClass}
  { Автоклассификация }
  AddAutoClassNode(Result);
  {$ENDIF}
  {$IFDEF Prime}
  { Прайм }
  AddPrimeConfig(Result);
  {$ENDIF}
  {$IFDEF Courts}
  { ФАСы }
  AddCourtDesNode(Result);
  {$ENDIF Courts}
  { Ежедневное обновление }
  AddDailyConfig(Result, AutolinkEnabled);
  {$IFDEF EveryWeek}
  { Еженедельное обновление }
  AddDeltaConfig(Result);
  {$ENDIF}
  {$IFDEF ExchangeDocs}
  { Заливка региональных дельт }
  AddExternalDeltas(Result);
  {$ENDIF}
  {$IFDEF UserQuery}
  AddQueryExportNode(Result); // Произвольный экспорт
  {$ENDIF}
  {$IFDEF HavanskyExport}
  AddHavanskyExportChild(Result);
  {$ENDIF}
  {$IFDEF MakeSections}
  Выкинуто как устаревшее
//  AddSectionMakerNode(Result);
  {$ENDIF}
  { Уведомления о событиях }
  AddNotifyConfig(Result);
  {$IFDEF MDPSyncIntegrated}
  AddMDPSyncChild(Result);
  {$ENDIF MDPSyncIntegrated}
  { Список заданий }
  AddUserNode(TalcuSchedulerNode.Create('Scheduler', 'Запланированные задания'));
  Load;
 end;
end;

procedure DestroyConfig;
begin
 l3Free(ddAppConfiguration);
 l3Free(mailAdapter);
end;

procedure CreateConfig(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil);
var
 l_Storage: TddIniStorage;
begin
 ddAppConfiguration := CreateConfigEx(AutolinkEnabled, aStorage);
end;





end.
