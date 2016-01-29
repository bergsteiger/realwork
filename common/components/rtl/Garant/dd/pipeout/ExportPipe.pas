Unit ExportPipe;

{ $Id: ExportPipe.pas,v 1.225 2015/10/14 10:18:46 fireton Exp $ }

// $Log: ExportPipe.pas,v $
// Revision 1.225  2015/10/14 10:18:46  fireton
// - cleanup
//
// Revision 1.224  2015/10/13 12:55:56  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223.4.5  2015/10/13 12:48:53  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223.4.4  2015/10/12 14:01:54  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223.4.3  2015/10/09 13:24:26  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223.4.2  2015/10/08 13:08:14  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223.4.1  2015/10/07 13:28:52  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.223  2015/09/24 14:37:44  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.222  2015/06/30 13:02:44  fireton
// - перезатирались файлы справок, если в имени файла использовался %main%
//
// Revision 1.221  2015/04/22 10:45:23  fireton
// - фиксируем дату экспорта (для имён файлов)
//
// Revision 1.220  2015/04/06 09:38:47  lukyanets
// Изолируем язык базы
//
// Revision 1.219  2015/03/31 14:09:12  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.218  2015/01/22 14:31:42  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.217  2014/09/09 05:29:06  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.216  2014/09/04 12:12:15  dinishev
// {Requestlink:564750095}. Перенес интерфейсы листнетов в ddTypes
//
// Revision 1.215  2014/09/04 11:02:50  dinishev
// {Requestlink:564750095}
//
// Revision 1.214  2014/08/29 12:24:48  lulin
// - вычищаем ненужную директиву.
//
// Revision 1.213  2014/08/01 11:15:15  fireton
// - ускоряем экспорт образов
//
// Revision 1.212  2014/07/29 10:52:49  fireton
// - ускоряем экспорт образов документов
//
// Revision 1.211  2014/07/16 15:56:59  lulin
// - чистим код и упрощаем наследование.
//
// Revision 1.210  2014/07/08 11:18:05  lukyanets
// Assert на нерабочий код
//
// Revision 1.209  2014/07/01 10:41:31  voba
// - вставил логирование выгрузки образов
//
// Revision 1.208  2014/05/08 12:43:47  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.207  2014/05/08 11:48:19  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.206  2014/04/17 13:04:58  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.205  2014/02/24 11:29:32  fireton
// - передаём атрибуты для выливки через property
//
// Revision 1.204  2014/02/21 17:02:36  lulin
// - избавляемся от обёрток над тегами.
//
// Revision 1.203  2014/02/14 15:33:56  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.202  2013/07/22 11:03:02  fireton
// - не-TIFF не должны попадать в csv (K 454525700)
//
// Revision 1.201  2013/04/19 13:10:48  lulin
// - портируем.
//
// Revision 1.200  2013/04/11 16:46:52  lulin
// - отлаживаем под XE3.
//
// Revision 1.199  2013/03/13 12:14:45  narry
// Не режется на куски, если в маске есть дата (435460677)
//
// Revision 1.198  2013/03/11 08:43:42  narry
// Не работало деление по размеру в сочетании с другими типами разделения файлов
//
// Revision 1.197  2013/02/07 13:18:49  narry
// Обновление (лишнее свойство)
//
// Revision 1.196  2013/02/05 12:11:33  narry
// Сделать возможность выливать EVD БЕЗ KeyWords (426675759)
//
// Revision 1.195  2012/12/10 10:06:53  narry
// Чистка мусора
//
// Revision 1.194  2012/12/07 13:12:39  narry
// Неверный путь к файлам
//
// Revision 1.193  2012/12/05 13:36:18  narry
// AV при инициализации экспорта
//
// Revision 1.192  2012/11/01 09:43:28  lulin
// - забыл точку с запятой.
//
// Revision 1.191  2012/11/01 07:45:54  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.190  2012/10/19 12:38:33  narry
// Экспорт формул как картинок (404947393)
//
// Revision 1.189  2012/10/19 11:15:38  narry
// Экспорт формул как картинок (404947393)
//
// Revision 1.188  2012/10/18 06:58:17  narry
// Обновление
//
// Revision 1.187  2012/10/02 08:11:20  narry
// Начало перехода на ISab вместо SAB
//
// Revision 1.186  2012/09/03 09:10:25  narry
// Борьба с подвисанием АК при отсутствии документов
//
// Revision 1.185  2012/08/30 13:55:26  narry
// Экспорт для Хаванского
//
// Revision 1.184  2012/08/29 10:00:26  voba
// - доточка фильтров для вывода в XML
//
// Revision 1.183  2012/08/23 11:09:09  fireton
// - при ошибке образа не прекращаем выливку (K 229214222)
//
// Revision 1.182  2012/07/27 10:17:38  voba
// - XML support
//
// Revision 1.181  2012/07/10 10:02:52  narry
// Отчет о результатах экспорта (375424204)
//
// Revision 1.180  2012/07/02 09:43:26  narry
// Не экспортировались образы
//
// Revision 1.179  2012/07/02 08:05:44  narry
// Обновление
//
// Revision 1.178  2012/06/29 08:14:29  narry
// Execute возвращает False, если ничего не было экспортировано
//
// Revision 1.177  2012/03/29 07:17:48  narry
// Экпортировать только справки (352453562)
//
// Revision 1.176  2012/01/19 10:48:02  fireton
// - не выливались образы, если не было краткого кода издания (K 327825561)
//
// Revision 1.175  2012/01/19 10:01:09  fireton
// - неверно формировалось имя файла образа документа (K 327823137)
//
// Revision 1.174  2012/01/11 10:12:16  narry
// - неправильный источник опубликования создавал мусорную информацию
//
// Revision 1.173  2011/12/19 09:14:59  fireton
// - экспортируем образы одним файлом (К 316113066)
//
// Revision 1.172  2011/12/06 08:24:06  narry
// Не выливается zip (312445573)
//
// Revision 1.171  2011/10/28 06:43:27  narry
// Не режется по размеру (296096189)
//
// Revision 1.170  2011/10/21 13:12:01  narry
// Накопившиеся изменения
//
// Revision 1.169  2011/10/13 08:43:33  narry
// Накопившиеся изменения
//
// Revision 1.168  2011/10/06 08:26:42  fireton
// - попытки заставить progress работать правильно
//
// Revision 1.167  2011/10/05 11:01:38  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.166  2011/09/13 10:43:31  narry
// Не собиралось
//
// Revision 1.165  2011/09/13 05:28:23  narry
// Размноженные номера размножают хронологию (265410470)
//
// Revision 1.164  2011/09/07 13:01:45  narry
// Исправление градусника
//
// Revision 1.163  2011/08/08 12:51:34  narry
// Отвалился фильтр QQQ (278827615)
//
// Revision 1.162  2011/07/19 09:05:14  narry
// Первый шаг к использованию SetTo
//
// Revision 1.161  2011/06/14 13:18:18  narry
// Реализовать автоэкспорт документов (268338975)
//
// Revision 1.160  2011/06/10 12:49:05  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.159  2011/03/03 11:51:54  narry
// K197497438. Вынести создание RangeManager за цикл
//
// Revision 1.158  2011/01/13 12:53:56  narry
// K250086166.
//
// Revision 1.157  2010/12/03 12:45:07  lulin
// {RequestLink:244195248}.
//
// Revision 1.156  2010/09/24 12:11:01  voba
// - k : 235046326
//
// Revision 1.155  2010/08/04 08:30:25  voba
// - k: 229672814
//
// Revision 1.154  2010/07/19 09:53:49  narry
// К227477456. Экспортировались только справки, не очищалась папка перед экспортом
//
// Revision 1.153  2010/07/09 11:51:17  narry
// - К172985568
//
// Revision 1.152  2010/06/22 07:16:10  narry
// - K219123030. Неправильно формировалось имя файла
//
// Revision 1.151  2010/05/27 06:57:08  narry
// - K184287805
//
// Revision 1.150  2010/04/20 08:51:23  narry
// - экспорт поискового запроса
//
// Revision 1.149  2010/04/07 12:40:52  narry
// - в качестве списка документов можно передавать поисковый запрос
//
// Revision 1.148  2010/02/24 11:57:48  narry
// - удаление зависимости проектов от парня
//
// Revision 1.147  2009/11/10 09:12:35  narry
// - обновление
//
// Revision 1.146  2009/09/08 09:02:58  narry
// - промежуточное обновление
//
// Revision 1.145  2009/07/22 11:27:29  narry
// - изменение доступа к DictServer
//
// Revision 1.144  2009/07/20 12:39:10  voba
// - Засунул renum в атрибуты
//
// Revision 1.143  2009/05/27 12:39:26  narry
// - расширение списка параметров
//
// Revision 1.142  2009/04/21 11:02:00  fireton
// - [$142607395]. Уменьшаем GIF только если высота картинки >= 2000.
//
// Revision 1.141  2009/04/13 07:12:44  narry
// - разделение определения типов и реализации
//
// Revision 1.140  2009/04/09 15:08:20  lulin
// [$140280550]. Выкидываем мусор.
//
// Revision 1.139  2009/02/05 10:26:00  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.138  2009/01/26 08:06:19  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.137  2009/01/14 14:06:55  narry
// - татары
//
// Revision 1.136  2009/01/13 16:21:15  narry
// - татары
//
// Revision 1.135.2.1  2008/12/26 15:22:06  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.135  2008/10/15 09:07:02  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.134  2008/10/03 10:24:39  fireton
// - образом документа теперь может быть не только TIFF
//
// Revision 1.133  2008/09/18 11:15:36  narry
// - не выливались документы в один файл
//
// Revision 1.132  2008/09/11 14:43:38  narry
// - ошибка экспорта в evd с разделением по группам доступа
// - рефакторинг
//
// Revision 1.131  2008/08/11 08:46:28  voba
// - "Получено по рассылке" сливаем вместе с другими. Там все равно работало не корректно и Соловьев сказал что это не нужно
//
// Revision 1.130  2008/07/24 15:06:45  narry
// - исправление ошибок автовыливки
//
// Revision 1.129  2008/05/26 14:46:56  narry
// - поддержка _evNSRCPlus
//
// Revision 1.128  2008/05/07 16:07:00  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.127  2008/04/11 16:06:20  narry
// - ошибка добавления пустой строки в конец документа
//
// Revision 1.126  2008/04/03 07:55:54  voba
// - перетащил все из DocImgSup в dt_DocImages
//
// Revision 1.125  2008/03/21 14:09:24  lulin
// - cleanup.
//
// Revision 1.124  2008/03/13 14:48:24  narry
// - рефакторинг
//
// Revision 1.123  2008/03/04 11:43:02  narry
// - перенес ExtractPattern в ddUtils
//
// Revision 1.122  2008/03/03 20:06:03  lulin
// - <K>: 85721135.
//
// Revision 1.121  2008/02/27 15:48:23  narry
// - возможность встроить дополнительный фильтр перед Writer
//
// Revision 1.120  2008/02/20 17:23:01  lulin
// - упрощаем строки.
//
// Revision 1.119  2008/02/14 09:40:36  lulin
// - удалён ненужный класс.
//
// Revision 1.118  2008/02/13 20:20:09  lulin
// - <TDN>: 73.
//
// Revision 1.117  2008/02/06 15:37:02  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.116  2008/02/05 09:58:02  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.115  2008/02/01 15:14:46  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.114  2007/11/22 10:31:53  narry
// - ошибка экспорта обазов пустой выборки
// - неполный список документов для Прайма
// - фильтр экспорта закладок
//
// Revision 1.113  2007/11/16 09:32:36  narry
// - экспорт заголовков образов без картинок
//
// Revision 1.112  2007/10/09 08:54:13  voba
// - merge with b_archi_export_refact2
//
// Revision 1.111.10.1  2007/09/21 14:03:19  voba
// no message
//
// Revision 1.111  2007/07/04 08:51:39  narry
// - уменьшение количества отладочной информации, выводимой в лог
//
// Revision 1.110  2007/06/28 11:19:57  narry
// - ошибочный диапазон страниц останавливал экспорт образов
//
// Revision 1.109  2007/04/18 11:37:55  narry
// - косметика
//
// Revision 1.108  2007/04/10 14:07:21  narry
// - новый формат задания
// - режим экспорта "Передать в регионы"
//
// Revision 1.107  2007/03/14 15:15:34  narry
// - удвление файла с выборкой по окончании обработки задания на экспорт
//
// Revision 1.106  2006/12/11 10:41:33  fireton
// - bug fix: поднимаем и обрабатываем exception при чтении битого TIFFa
//
// Revision 1.105  2006/12/07 14:43:46  voba
// - кодирование имен файлов - страниц образов
//
// Revision 1.104  2006/12/07 11:22:17  narry
// - экспорт одного документа из выборки
//
// Revision 1.103  2006/11/27 15:57:12  narry
// - экспорт в XML для nalog.ru
//
// Revision 1.102  2006/07/20 05:52:25  narry
// - убраны лишние модули из uses
//
// Revision 1.101  2006/03/07 12:27:39  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.100  2006/01/05 15:01:49  narry
// - исправление: более правильное формирование имени файла
//
// Revision 1.99  2005/12/01 11:47:44  narry
// - обновление
//
// Revision 1.98  2005/11/29 13:43:29  narry
// - обновление: переход на новый способ передачи задач
//
// Revision 1.97  2005/11/25 13:33:44  voba
// no message
//
// Revision 1.96  2005/11/11 12:29:54  fireton
// - change: строки вынесены в resourcestring (чтобы профилировать можно было)
//
// Revision 1.95  2005/11/09 16:22:21  narry
// - новое: возможность прервать экспорт графических образов
// - исправление: задание папки для экспорта ключевых слов
//
// Revision 1.94  2005/11/02 16:31:37  narry
// - новое: шаблоны в именах файлов и папок
// - изменение: алгоритм разрезания на куски
//
// Revision 1.93  2005/10/20 05:54:30  voba
// - change IsImageExists param type (PPublishDataRec)
//
// Revision 1.92  2005/10/17 13:26:06  step
// переименование LinkComent --> LinkComment
//
// Revision 1.91  2005/07/26 10:46:19  narry
// - update: расширение функциональности экспорта - только структура документа
//
// Revision 1.90  2005/07/25 13:07:23  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.89  2005/07/21 11:15:06  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.88  2005/07/14 15:54:11  narry
// - bug fix
//
// Revision 1.87  2005/04/28 13:01:31  narry
// - update: расчет размера доументов
//
// Revision 1.86  2005/04/25 13:12:27  fireton
// - change: перевел выливки картинок на iebitmap и memory-mapped files
//
// Revision 1.85  2005/04/25 12:16:16  fireton
// - bug fix: ошибка в ресайзе картинки для GIF
//
// Revision 1.84  2005/04/19 15:41:47  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.83  2005/03/29 14:00:16  voba
// - bug fix
//
// Revision 1.82  2005/03/28 13:34:12  narry
// - update
//
// Revision 1.81  2005/03/18 12:45:13  voba
// - bug fix
//
// Revision 1.80  2005/03/11 16:41:30  narry
// - update: поддержка экспорта специальных аннотаций
//
// Revision 1.79  2005/02/18 12:00:59  narry
// - update: поддержка Аннотаций
//
// Revision 1.78  2005/02/16 17:11:17  narry
// - update: поддержка Аннотаций
//
// Revision 1.77  2005/01/17 15:45:10  narry
// - update;
// - bug fix: раздельное формирование csv-файлов для нормальных и ненормальных источников опубликования
//
// Revision 1.76  2004/09/21 12:21:14  lulin
// - Release заменил на Cleanup.
//
// Revision 1.75  2004/09/14 15:58:10  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.74  2004/09/02 13:52:57  fireton
// - bug fix: "серость" в гифах и некорректный размер их же
//
// Revision 1.73  2004/08/17 15:17:17  fireton
// - bug fix: членораздельное сообщение в лог при неверном диапазоне страниц
//
// Revision 1.72  2004/08/17 13:39:18  narry
// - update
//
// Revision 1.71  2004/06/17 12:05:58  voba
// - вернул : для источник ДСП все равно создавались гр. образы
//
// Revision 1.70  2004/06/17 10:12:50  narry
// - bug fix: не создаются графические образы для всех страниц источника
// - bu fix: для источник ДСП все равно создавались гр. образы
//
// Revision 1.69  2004/06/01 17:04:26  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.68  2004/06/01 14:10:53  narry
// - update: расширение списка параметров задания на экспорт
//
// Revision 1.67  2004/05/14 16:08:05  law
// - new units: evFileGenerator, evPlainTextGenerator.
//
// Revision 1.66  2004/04/15 14:38:43  narry
// - new property: _OneStep - генерация внешних форматов в один проход
//
// Revision 1.65  2004/03/10 14:52:17  fireton
// - change: при экспорте картинок gif теперь получается меньше
//
// Revision 1.64  2004/03/05 17:05:15  step
// чистка кода
//
// Revision 1.63  2004/02/27 15:38:16  fireton
// - bugfix: не устанавливались процедуры компрессии/декомпрессии изображений
//
// Revision 1.62  2004/02/27 15:03:16  fireton
// - добавлена поддержка '_' (нижняя часть граф. образа)
//
// Revision 1.61  2004/02/27 11:16:47  voba
// no message
//
// Revision 1.60  2004/02/27 10:28:53  voba
// - merge with adding_field_shname
//
// Revision 1.59  2004/02/18 12:11:37  narry
// - bug fix: неправильное разрезание на куски
//
// Revision 1.58  2004/02/17 10:29:41  narry
// - new: проверка переданных имен файлов на пустую строку
//
// Revision 1.57.8.4  2004/02/26 12:57:36  fireton
// - add: экспорт графического образа (в tif и gif)
//
// Revision 1.57.8.3  2004/02/25 12:38:01  voba
// no message
//
// Revision 1.57.8.2  2004/02/24 10:17:11  voba
// no message
//
// Revision 1.57.8.1  2004/02/18 14:32:20  voba
// no message
//
// Revision 1.57  2003/09/22 15:42:50  narry
// - bug fix: AV при f_Progressor = nil
//
// Revision 1.56  2003/09/15 14:37:08  narry
// - bug fix: отсутствие Progressor приводило к AV
//
// Revision 1.55  2003/07/18 14:44:29  narry
// - change: изменение логики отображения информации о прогрессе выполения импорта
//
// Revision 1.54  2003/06/03 14:35:47  narry
// - update: расширение функциональности для автоклассификатора
//
// Revision 1.53  2003/01/17 10:23:16  narry
// - new begavior: возможность прервать экспорт
//
// Revision 1.52  2003/01/04 10:26:33  narry
// - update: замена типа поля записи задания на экспорт
//
// Revision 1.51  2002/09/24 15:22:39  voba
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.50  2002/08/28 08:16:17  narry
// - update
//
// Revision 1.49  2002/07/24 12:46:42  narry
// - bug fix: при нарезке на куски первый кусок содержал в себе всю выборку
//
// Revision 1.48  2002/07/23 15:38:49  narry
// - bug fix: попытка открыть файл два раза при выливке в Эверест и разделении на топики
//
// Revision 1.47  2002/06/14 07:39:25  narry
// - bug fix: Integer overflow
//
// Revision 1.46  2002/06/06 11:13:18  narry
// - bug fix: ошибка выливки форматов, отличных от NSRC
//
// Revision 1.45  2002/06/05 13:24:02  narry
// - update: замороженная реализация списка "лишних" данных
//
// Revision 1.44  2002/02/28 15:07:04  narry
// - bug fix: пустая строка в начале файла при разрезании результирущих файлов на части
//
// Revision 1.43  2002/02/15 10:33:42  narry
// - update
//
// Revision 1.42  2002/01/21 09:11:40  narry
// - bug fix and update
//
// Revision 1.41  2001/12/27 13:46:12  narry
// - update: реализация выливки по AccGroups
//
// Revision 1.40  2001/11/22 13:58:44  narry
// - update : начало реализации Групп доступа
//
// Revision 1.39  2001/10/25 12:01:25  narry
// - bug fix : именование файлов при разрезании на куски
//
// Revision 1.38  2001/10/24 15:07:00  narry
// - new behavior: разделение файла на куски, новый прогресс-объект
//
// Revision 1.37  2001/10/22 12:51:28  narry
// - new behavior: измение формата сообщения для удаленного экспорта
//
// Revision 1.36  2001/09/19 12:50:56  narry
// - update - вместо TComponent наследуется от Tl3InterfacedComnonent
//
// Revision 1.35  2001/09/04 13:58:59  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.34  2001/06/04 11:47:22  narry
// -new behavior - изменение логики экспорта через сервер
//
// Revision 1.33  2001/03/28 13:46:12  narry
// Добавлен флажок, управляющий выливкой RTF файл
//
// Revision 1.32  2000/12/27 13:03:00  law
// - вставлена директива Log.
//

{$I ddDefine.inc}
{$DEFINE Bend}

interface

Uses
  Classes,

  l3Interfaces,
  l3Types,
  l3Filer,
  l3Memory,
  l3Chars,
  l3Base,
  l3InterfacedComponent,
  l3RangeManager,
  l3RecList,

  k2FileGenerator,

  ddTypes,

  dt_Types, dt_Const,
  dt_AttrSchema,
  dtIntf, dt_Sab,
  {$IFDEF Bend}ddNSRCPipeBend,{$ENDIF}

  evdXMLWriter,

  SewerPipe, ddProgressObj,
  l3ObjectRefList,
  l3StringList
  , k2TagFilter, k2TagGen, k2Prim, DT_Query, ddDocTypeDetector,
  ddTiffProcessor,
  k2Interfaces,
  l3ProtoObject,
  ddPipeOutInterfaces,
  ddExportFilerDispatcher
  ;

type
  TepCalculationDone = procedure (Sender: TObject; Value: Int64; EmptyCount: Integer) of object;
  TepPatternType     = (patAccGroup, patNumber, patDate);
  TepPatternsArray   = array[TepPatternType] of AnsiString;

  PImgCountRec = ^TImgCountRec;
  TImgCountRec = packed record
   rDocID: TDocID;
   rCount: Integer;
  end;

  TexpClearAttributes = (attrNone, attrLevel1, attrLevel2);

  TExportPipe = class(Tl3ProtoObject, IddDocumentListner, IddSaveObjectPath)
  private
    fAttributes: TdtAttributeSet;
    FExportDirectory: ShortString;
    FObjTopicFileName: AnsiString;
    FOnCalculationDone: TepCalculationDone;
    f_Pipe: TSewerPipe;
    f_Writer: Tk2CustomFileGenerator;
    f_Running: Boolean;
    f_ErrorList: TStrings;
    f_OutFileType: TepSupportFileType;
    {$IFDEF Bend}
    f_Bend: TddPipeBend;
    {$ENDIF}

    f_ExportKW: Boolean;
    f_ExportDocImage: Boolean;
    f_ExportEmpty: Boolean;
    f_Family: TFamilyID;
    f_ExportDoc: Boolean;
    f_MultiUser: Boolean;

    f_FilerDispatcher: TddExportFilerDispatcher;
    f_CreateDirs: Boolean;
    f_Dicts: TdtAttributeSet;
    f_TotalProgressProc : Tl3ProgressProc;
    f_WorkVAnonced      : Boolean;
    f_InternalFormat    : Boolean;
    f_ExportRTFBody     : Boolean;
    f_SeparateByGroup   : Boolean;
    f_TaskPriority      : Integer;
    f_UnnecessaryDataList: Tl3StringList;
    f_ErrorFound        : Boolean;
    FProgressor         : TddProgressObject;
    f_Attributes: TdtAttributeSet;
    f_ClearAttributes: TexpClearAttributes;
    f_FormulaAsPicture: Boolean;
    f_ImagesByPages: Boolean;
    f_ImgCounters: Tl3RecList;
    f_InBend: Tk2TagFilter;
    f_OnlyDocImagesHeader: Boolean;
    f_OnlyStructure: Boolean;
    f_OutBend: Ik2TagGenerator;
    f_ObjectList: Tl3StringList;
    function GetExportAnnotation: Boolean;
    function pm_GetDocSab: ISab;
    function pm_GetExportEditions: Boolean;
    function pm_GetExportReferences: Boolean;
    function pm_GetTotalDone: Int64;
    procedure pm_SetDocSab(const Value: ISab);
    procedure pm_SetExportEditions(const Value: Boolean);
    procedure pm_SetExportReferences(const Value: Boolean);
    procedure pm_SetOnlyStructure(const aValue: Boolean);
    procedure pm_SetQuery(const Value: TdtQuery);
    procedure SetProgressor(const Value: TddProgressObject);
    procedure SetExportAnnotation(const Value: Boolean);
    procedure SetExportDirectory(const Value: ShortString);
    procedure SetObjTopicFileName(const Value: AnsiString);
    procedure WriteImages(aRangeManager: Tl3RangeManager; var theTIFFProcessor: TddTiffProcessor;
           aTopic, aImageFileName, aShortName : AnsiString; aImageCount: Integer);
    function WriteOnePubl(aPublRec: PPublishDataRec; aRangeManager: Tl3RangeManager; var aCSVElem:
        AnsiString): Boolean;
    procedure _OnCalcDone(Sender: TObject);
    procedure ClearObjPathList;
    procedure ClearExternalObjects;
    function pm_GetCodePage: Long;
    function pm_GetDivideBy(aPart: TddExportDocPart): TddExportDivideBySet;
    function pm_GetExportDate: TDateTime;
    function pm_GetLowcaseNames: Boolean;
    function pm_GetFileMask(aPart: TddExportDocPart): Il3CString;
    function pm_GetOutputFileSize: Longint;
    function pm_GetUpdateFiles: Boolean;
    procedure pm_SetCodePage(const Value: Long);
    procedure pm_SetDivideBy(aPart: TddExportDocPart; const Value: TddExportDivideBySet);
    procedure pm_SetExportDate(const Value: TDateTime);
    procedure pm_SetLowcaseNames(const Value: Boolean);
    procedure pm_SetFileMask(aPart: TddExportDocPart; const Value: Il3CString);
    procedure pm_SetOutputFileSize(const Value: Longint);
    procedure pm_SetUpdateFiles(const Value: Boolean);
  protected
    procedure SaveObjectPath(const aFileName: AnsiString);
    procedure NeedDeleteFileData;
    function DoInternalExport: Boolean;
    procedure Export2EVD(Binary: Boolean);
    procedure Export2NSRC;
    procedure Export2RTF;
    procedure Export2HTML;
    procedure Export2XML;
    procedure Export2TXT;
    function DoExportDocImages: Boolean;
    procedure SetOutFileType(Value: TepSupportFileType);
    procedure NewDocument(aSender: TObject; aTopicNo: Longint; aDocPart: TddExportDocPart; aMainGroup: ShortString);
    procedure UnnecessaryData(aDocID : TDocID; aMessage : AnsiString);
    function GetKWFileName: ShortString;
    procedure SetKWFileName(Value: ShortString);
    function GetTotalSizeDone: ShortString;
    procedure Cleanup; override;
    procedure ErrorEvent(const aMsg: AnsiString; aCategory: Integer = 0);
  public
    constructor Create;
    function Execute: Boolean;
    procedure AbortExport;
    procedure AddBend(InBend: Tk2TagFilter; OutBend: Ik2TagGenerator = nil);
    procedure AllPartsDivideBy(aDivideBy: TddExportDivideBySet);
    procedure MakeSingleDocSab(aDocID: TDocID; aIsExternal: Boolean);
  public
   { Свойство регулирует состав атрибутов, которые будут прочитаны из базы для
     текущего документа.
     По умолчанию из базы можно читать любые атрибуты - AllAttributes. }
    property Attributes: TdtAttributeSet read f_Attributes write f_Attributes;
    property ClearAttributes: TexpClearAttributes
     read f_ClearAttributes
     write f_ClearAttributes;
   property Progressor : TddProgressObject
    read FProgressor
    write SetProgressor;

   property Dicts: TdtAttributeSet
      read f_Dicts write f_Dicts;

    property TotalProgressProc: Tl3ProgressProc
      read f_TotalProgressProc write f_TotalProgressProc;
    property TotalSizeDone: ShortString
      read GetTotalSizeDone;
    property CodePage: Long read pm_GetCodePage write pm_SetCodePage;
    property DivideBy[aPart: TddExportDocPart]: TddExportDivideBySet read pm_GetDivideBy write pm_SetDivideBy;
    property DocSab: ISab read pm_GetDocSab write pm_SetDocSab;
    property ErrorFound: Boolean
     read f_ErrorFound;
   property ErrorList: TStrings
    read f_ErrorList;
    property ExportDate: TDateTime read pm_GetExportDate write pm_SetExportDate;
    property ExportEditions: Boolean read pm_GetExportEditions write pm_SetExportEditions;
    property FormulaAsPicture: Boolean read f_FormulaAsPicture write
        f_FormulaAsPicture;
    property ImagesByPages: Boolean read f_ImagesByPages write f_ImagesByPages;
    property LowcaseNames: Boolean read pm_GetLowcaseNames write pm_SetLowcaseNames;
    property FileMask[aPart: TddExportDocPart]: Il3CString read pm_GetFileMask write pm_SetFileMask;
    property OnlyDocImagesHeader: Boolean read f_OnlyDocImagesHeader write f_OnlyDocImagesHeader;
    property OnlyStructure: Boolean read f_OnlyStructure write pm_SetOnlyStructure;
    property Query: TdtQuery write pm_SetQuery;
    property TotalDone: Int64 read pm_GetTotalDone;
  published
    property ExportAnnotation: Boolean read GetExportAnnotation write
        SetExportAnnotation;
    property ObjTopicFileName: AnsiString read FObjTopicFileName write
        SetObjTopicFileName;
    property ExportEmpty: Boolean
      read f_ExportEmpty write f_ExportEmpty;

    property ExportDocument: Boolean
      read f_ExportDoc write f_ExportDoc;

    property ExportRTFBody: Boolean
      read f_ExportRTFBody write f_ExportRTFBody;

    property ExportKW: Boolean
      read f_ExportKW write f_ExportKW;

    property ExportDocImage: Boolean
      read f_ExportDocImage write f_ExportDocImage;

    property MultiUser: Boolean
      read f_MultiUser write f_Multiuser;

    property Family: TFamilyID
      read f_Family write f_Family;

    property InternalFormat: Boolean
      read f_InternalFormat write f_InternalFormat;

    property OutFileType: TepSupportFileType
      read f_OutFileType write SetOutFileType default outNSRC;

    property ExportDirectory: ShortString read FExportDirectory write
        SetExportDirectory;

    property KWFileName: ShortString
      read GetKWFileName write SetKWFileName;

    property UpdateFiles: Boolean read pm_GetUpdateFiles write pm_SetUpdateFiles;

    property OnCalculationDone: TepCalculationDone read FOnCalculationDone write
        FOnCalculationDone;

    property ExportReferences: Boolean read pm_GetExportReferences write pm_SetExportReferences;
    property OutputFileSize: Longint read pm_GetOutputFileSize write pm_SetOutputFileSize;
    property TaskPriority : Integer
     read f_TaskPriority
     write f_TaskPriority;

  end;

const
 epFindNext = False;
 epFindCurrent = True;

implementation

uses
  SysUtils, Forms, StrUtils, Graphics,

  l3String, l3Date, l3Math, l3languages,
  l3FileUtils, l3Stream, l3DatLst,

  afwFacade,

  daDataProvider,
  Ht_Const, ht_Dll,
  dt_Doc, dt_User, dt_Dict, dt_DocImages, dt_LinkServ,

  {ddFormula2PictureFilter,} npbAttributesFilter, npbHyperlinkFilter, evdCommentFilter,
  evCustomTextFormatter, evSimpleTextPainter, evTextFormatter, evEmptyTableEliminator,
  evdWriter, evNSRWrt, evdPlainTextWriter, evdEmptyRowFilter, evdBufferedFilter,

  hyieutils, imageenio, iemio, ImageEnproc, hyiedefs, TIFLZW, GIFLZW,
  ddNSRC_w,  ddRTFWriter, ddHTMLWriter, ddServerTask, //csUserRequestManager,

  ddUtils,  {$IFDEF AAC}dd_lcDossierDecorator,{$ENDIF}

  Document_Const, DT_ImgContainer, l3ProtoPtrRecListPrim;

resourcestring
 epsArticleSubstring = 'СТАТЬЯ ';
 epsErrorWrongRange4 = '", количество страниц в файле - ';
 epsErrorWrongRange3 = ' Ошибка экспорта граф. образа - диапазон страниц: "';
 epsErrorWrongRange2 = 'Топик:';
 epsErrorWrongPagesRange = 'Топик %s: Ошибка экспорта граф. образа - неправильный диапазон страниц: %s';
 epsErrorFileCorrupted = 'Топик %s: Ошибка экспорта граф. образа - файл испорчен (%s)';
 epsOfDocuments = 'документ(ов)';
  rsExportData = 'ExportData';

function MakeImgRec(aDocID: TDocID): TImgCountRec;
begin
 Result.rDocID := aDocID;
 Result.rCount := 1;
end;


constructor TExportPipe.Create;
begin
  inherited;
  f_Pipe:= TSewerPipe.Create;
  f_Pipe.LinkListner(Self);
  f_Pipe.OnNewDocument := NewDocument;
  f_PIpe.OnCalculateDone := _OnCalcDone;
  f_Pipe.OnError:= ErrorEvent;
  f_Attributes:= cdtAllAttributes;
  //f_Pipe.OnUnnecessaryData:= UnnecessaryData;
  f_Running:= False;
  f_FilerDispatcher := TddExportFilerDispatcher.Create;
  f_CreateDirs:= True;
  f_ExportDoc:= True;
  ExportReferences:= True;
  fExportDirectory:= '';
  OutFileType:= outNSRC;
  f_MultiUser:= False;
  CodePage:= cp_OEMLite;
  f_WorkVAnonced:= False;

  fObjTopicFileName:= 'objectopic.nsr';
  f_InternalFormat:= False;

  f_UnnecessaryDataList:= Tl3StringList.Create;
  f_ErrorList:= TStringList.Create;
  f_ExportRTFBody:= False;
  OutPutFileSize := 0;
  f_OnlyDocImagesHeader:= False;
  f_ImagesByPages:= False;
end;


procedure TExportPipe.Cleanup;
begin
 ClearObjPathList;
 l3Free(f_UnnecessaryDataList);
 l3Free(f_ErrorList);
 l3Free(f_ObjectList);
 if f_Pipe <> nil then
  f_Pipe.UnLinkListner(Self);
 l3Free(f_Pipe);
 FreeAndNil(f_FilerDispatcher);
 FreeAndNil(f_ImgCounters); 
 inherited;
end;

procedure TExportPipe.SetOutFileType(Value: TepSupportFileType);
begin
  if (f_OutFileType <> Value) and not f_Running then
  begin
    f_OutFileType:= Value;
    if not (f_OutFileType in [outNSRC, outEVD, outEVDText, outTxt]) then
    begin
      DivideBy[edpDocument] := [edbTopic];
      DivideBy[edpReference] := [edbTopic];
      DivideBy[edpAnnotation] := [edbTopic];
    end;
  end;
  case OutFileType of
    outEVD,
    outEVDtext : f_FilerDispatcher.FileExt := '.evd';
    outTXT     : f_FilerDispatcher.FileExt := '.txt';
    outNSRC    : f_FilerDispatcher.FileExt := '.nsr';
    outRTF     : f_FilerDispatcher.FileExt := '.rtf';
    outHTML    : f_FilerDispatcher.FileExt := '.html';
    outXML     : f_FilerDispatcher.FileExt := '.xml';
  end;
end;

function TExportPipe.DoInternalExport: Boolean;
 {$IFDEF AAC}
var
 l_RenumBuffered: Boolean;
{$ENDIF}
begin
 Result:= False;
 if ExportDocument or ExportAnnotation or ExportReferences or ExportKW or ExportDocImage then
 try
  f_FilerDispatcher.Start;
  {$IFDEF AAC}
  l_RenumBuffered:= LinkServer(family).Renum.Buffered;
  LinkServer(family).Renum.Buffered:= True;
  {$ENDIF}
  f_Pipe.InternalFormat:= InternalFormat;
  f_Pipe.Family:= Family;
  if fProgressor <> nil then
   f_Pipe.Progressor:= fProgressor
  else
   f_Pipe.TotalProgressProc:= f_TotalProgressProc;
  f_Pipe.Dicts:= Dicts;
  f_Pipe.ExportDirectory:= ExportDirectory;
  // f_Pipe.FileSize:= OutputFileSize; // ????
  f_Pipe.OnlyStructure := OnlyStructure;
  f_Pipe.ExportDocTypes := dtAll;
  f_Pipe.FormulaAsPicture:= FormulaAsPicture;
  if not ExportDocument then
  begin
   f_pipe.ExportDocTypes:= f_pipe.ExportDocTypes - [dtText, {dtRelText,} dtObject, dtFlash, dtShortCut, dtNone];
   //ExportReferences:= False;
  end; // not ExportDocument
  if not ExportAnnotation then
   f_pipe.ExportDocTypes:= f_pipe.ExportDocTypes - [dtAnnotation];
  if not ExportReferences then
   f_pipe.ExportDocTypes:= f_pipe.ExportDocTypes - [dtRelText]
  {else
   ExportDocument:= True};
  f_Pipe.ExportKW:= ExportKW;
  f_Pipe.ExportEmpty:= ExportEmpty;
  f_Pipe.MultiUser:= MultiUser;
  f_Pipe.KWFileName:= KWFileName;
  if f_Pipe.KWFileName = '' then
   f_Pipe.KWFileName:= 'keywords.kw';
  CodePage:= l3CodePageFromLangID(GlobalDataProvider.BaseLanguage[Family].LanguageID, OutFileType = outNSRC);
  case OutFileType of
   outEVD : Export2EVD(True);
   outEVDtext: Export2EVD(False);
   outTXT : Export2TXT;
   outNSRC: Export2NSRC;
   outRTF : Export2RTF;
   outHTML: Export2HTML;
   outXML : Export2XML;
  end;
  Result:= f_Pipe.TopicDone > 0;
  if ExportDocImage then
   Result:= DoExportDocImages and Result;
 finally
  {!!!!!!!
  if Assigned(f_TotalProgressProc) then
   f_TotalProgressProc(2, 0, 'Вот и все, ребята!');
  }
  {$IFDEF AAC}
  LinkServer(family).Renum.Buffered:= l_RenumBuffered;
  {$ENDIF}
  f_FilerDispatcher.Finish;
  f_Running:= False;
 end;
end;

function TExportPipe.Execute: Boolean;
begin
 f_ErrorFound:= False;
 f_UnnecessaryDataList.Clear;
 f_Running:= True;
 try
  Result:= False;
  ErrorList.Clear;
  if not (f_OutFileType in [outNSRC, outEVD, outEVDText, outTxt]) then
   AllPartsDivideBy([edbTopic]); // только NSRC/EVD/TXT умеют выливаться иначе, кроме как по топикам
  Result:= DoInternalExport;
 finally
  f_Running:= False;
 end;
end;

procedure TExportPipe.NewDocument(aSender: TObject; aTopicNo: Longint; aDocPart: TddExportDocPart; aMainGroup:
 ShortString);
var
 l_Folder: AnsiString;
begin
 f_Writer.Filer := f_FilerDispatcher.GetFiler(aTopicNo, aDocPart, l3CStr(aMainGroup));
 if f_FilerDispatcher.IsDirByMain then
 begin
  l_Folder := f_FilerDispatcher.GetActualDir(aMainGroup);
  if f_Writer is TddNSRCGenerator then
   TddNSRCGenerator(f_Writer).ExportDirectory := l_Folder;
  {$IFDEF Bend}
  if f_Bend <> nil then
   f_Bend.ExportDir := l_Folder;
  {$ENDIF}
 end;
end;

procedure TExportPipe.AbortExport;
begin
 f_Pipe.Aborted:= True;
end;

procedure TExportPipe.AddBend(InBend: Tk2TagFilter; OutBend: Ik2TagGenerator =
    nil);
begin
 // Если выходное колено равно nil, то используется InBend.Generator
 f_InBend:= InBend;
 if OutBend = nil then
   f_OutBend:= InBend.Generator
 else
  f_OutBend:= OutBend;
end;

function TExportPipe.DoExportDocImages: Boolean;
var
 l_PublInDataList : ISabCursor;
 I               : Integer;
 l_TextF         : TextFile;
 l_RangeManager  : Tl3RangeManager;
 l_Units         : AnsiString;
 l_s             : AnsiString;
begin
 //Получим lPublInDataList
 Result:= False;
 //l_PublInDataList := DictServer(f_Family).GetPublishData(MakeSab(DocumentServer(f_Family).FileTbl, Diapason.List));
 l_PublInDataList := DictServer(f_Family).GetPublishData(f_Pipe.DocSab);
 if l_PublInDataList <> nil then
 begin
  ForceDirectories(ExportDirectory);
  if f_ImgCounters = nil then
   f_ImgCounters := Tl3RecList.Create(SizeOf(TImgCountRec));
  f_ImgCounters.Clear;
  if f_ImagesByPages then
  begin
   AssignFile(l_TextF, ExportDirectory+'\images.csv');
   Rewrite(l_TextF);
  end;
  try
   if FProgressor <> nil then
    FProgressor.Start(l_PublInDataList.Count, 'Экспорт образов документов', False);

   l3System.Msg2Log('Экспорт образов %D документов', [l_PublInDataList.Count], l3_msgLevel2);
   l_RangeManager:= Tl3RangeManager.Create;
   try
    for I:= 0 to pred(l_PublInDataList.Count) do
    begin
     if WriteOnePubl(PPublishDataRec(l_PublInDataList.GetItem(I)), l_RangeManager, l_S) and f_ImagesByPages then
     begin
      l_S := l_S + '1'#9 + IntToStr(l_RangeManager.Count) + #9;
      if l_RangeManager.BottomSide then
       l_S := l_S + '1'
      else
       l_S := l_S + '0';
      Writeln(l_TextF, l_S);
     end; // WriteOnPubl
     if FProgressor <> nil then
      FProgressor.ProcessUpdate(i)
     else
      afw.ProcessMessages;
     if f_Pipe.Aborted then
      break;
    end; // for i
   finally
    l_RangeManager.Free;
   end; // try..finally
   Result:= True;
  finally
   if f_ImagesByPages then
    CloseFile(l_TextF);
   if FProgressor <> nil then
    FProgressor.Stop;
   l3System.Msg2Log('Экспорт образов закончен', l3_msgLevel2);
  end; // try..finally
 end; // <> nil
end;

procedure TExportPipe.ErrorEvent(const aMsg: AnsiString; aCategory: Integer = 0);
begin
 f_ErrorList.Add(aMsg);
end;

procedure TExportPipe.Export2NSRC;
var
 l_G, l_G4Free : Tk2tagGenerator;
 l_ObjFN: AnsiString;
begin
 l_G:= nil;
 try
  f_Writer:= TddNSRCGenerator.SetTo(l_G);
  TddNSRCGenerator(f_Writer).CodePage:= CodePage;
  TddNSRCGenerator(f_Writer).ExportDirectory:= ExportDirectory;
  TddNSRCGenerator(f_Writer).OnError:= ErrorEvent;
  TddNSRCGenerator(f_Writer).LinkPathListner(Self);
  TevSimpleTextPainter.SetTo(l_G);
  TevCustomTextFormatter(l_G).CodePage:= CodePage;
  TevdEmptyRowFilter.SetTo(l_G);
  {$IFDEF Bend}
  f_Bend:= TddPipeBend.SetTo(l_G);
  TddPipeBend(l_G).ExportDir:= ExportDirectory;
  TddPipeBend(l_G).ObjTopicFileName:= ObjTopicFilename;
  {$ENDIF}
  {$IFDEF AAC}
  if ExportReferences then
   TlcDossierDecorator.SetTo(l_G); // если справки не выливаем, то и хронология не нужна
  {$ENDIF}
  TevEmptyTableEliminator.SetTo(l_G);
  f_Pipe.Convert2OEM:= True;
  f_Pipe.ExportDocument:= ExportDocument;
  if not UpdateFiles then
  begin
   l_ObjFN:= ConcatDirName(ExportDirectory, ObjTopicFilename);
   if FileExists(l_ObjFN) then
    DeleteFile(l_ObjFN);
  end; // not UpdateFiles

  l_G4Free:= l_G;

  if f_InBend <> nil then
  begin
   f_InBend.Generator:= l_G;
   l_G:= f_InBend;
  end;

  f_Pipe.Writer:= l_G;
  f_Pipe.Attributes := Attributes;
  f_Pipe.Execute;
  TddNSRCGenerator(f_Writer).UnLinkPathListner(Self);
 finally
  f_Writer := nil;
  FreeAndNil(l_G4Free);
 end;
end;

procedure TExportPipe.Export2RTF;
begin
  f_Writer:= TevRTFObjectGenerator.Create;
  try
   if f_InBend <> nil then
   begin
    f_Pipe.Writer := f_InBend;
    f_OutBend:= f_Writer;
   end
   else
    f_Pipe.Writer:= f_Writer;
   f_Pipe.Convert2OEM:= False;
   f_Pipe.ExportDocument:= ExportDocument;
   f_Pipe.Execute;
  finally
   l3Free(f_Writer);
  end; { Writer.Create }
end;

procedure TExportPipe.Export2XML;
var
 l_G : Tk2tagGenerator;
begin
 l_G:= nil;
 try
  TevdXMLWriter.SetTo(l_G);
  f_Writer:= TevdXMLWriter(l_G);
  if ClearAttributes <> attrNone then
  begin
   f_Pipe.FormulaAsPicture:= true;
   //TddFormula2PictureFilter.SetTo(l_G); // ddFormula2PictureFilter
   if ClearAttributes = attrLevel1 then
    TnpbAttributesFilter.SetTo(l_G)  // npbAttributesFilter
   else
   if ClearAttributes = attrLevel2 then
   begin
    TnpbAttributesFilterEx.SetTo(l_G);  // npbAttributesFilter
    TnpbHyperlinkFilter.SetTo(l_G);  // evdHyperlinkEliminator
   end; // ClearAttributes = attrLevel2
   TevdCommentFilter.SetTo(l_G); // evdCommentFilter
  end; // ClearAttributes <> attrNone

  if f_InBend <> nil then
  begin
   f_Pipe.Writer := f_InBend;
   f_OutBend:= l_G;
  end
  else
   f_Pipe.Writer:= l_G;
  f_Pipe.Convert2OEM:= False;
  f_Pipe.ExportDocument:= ExportDocument;
  f_Pipe.Execute;
 finally
  FreeAndNil(l_G);
 end; { Writer.Create }
end;

procedure TExportPipe.Export2HTML;
begin
  f_Writer:= TddHTMLGenerator.Create;
  try
   if f_InBend <> nil then
   begin
    f_Pipe.Writer := f_InBend;
    f_OutBend:= f_Writer;
   end
   else
    f_Pipe.Writer:= f_Writer;
   f_Pipe.Convert2OEM:= False;
   f_Pipe.ExportDocument:= ExportDocument;
   f_Pipe.Execute;
  finally
    l3Free(f_Writer);
  end; { Writer.Create }
end;

procedure TExportPipe.Export2TXT;
var
 Formatter: TevTextFormatter;
begin
 Formatter:= TevTextFormatter.Create(nil);
 try
  Formatter.CodePage:= CodePage;
  f_Writer:= TevdPlainTextWriter.Create(nil);
  try
   if f_InBend <> nil then
   begin
    f_Pipe.Writer := f_InBend;
    f_OutBend:= Formatter;
   end
   else
    f_Pipe.Writer:= Formatter;
   Formatter.Generator:= f_Writer;
   f_Pipe.Convert2OEM:= (CodePage <> cp_OEM) and (CodePage <> cp_OEMLite);
   f_Pipe.ExportDocument:= ExportDocument;
   f_Pipe.Execute;
  finally
   l3Free(f_Writer);
  end; { Writer.Create }
 finally
  l3Free(Formatter);
 end; //
end;

procedure TExportPipe.Export2EVD(Binary: Boolean);
 {$IFDEF AAC}
var
 l_DM: TlcDossierDecorator;
 {$ENDIF}
begin
 {$IFDEF AAC}
 l_DM:= TlcDossierDecorator.Create(nil);
 try
 {$ENDIF}
  f_Writer:= TevdNativeWriter.Create(nil);
  try
   TevdNativeWriter(f_Writer).Binary:= Binary;
   {$IFDEF AAC}
   f_Pipe.Writer:= l_DM;
   if f_InBend <> nil then
   begin
    l_DM.Generator := f_InBend;
    if f_InBend.Generator = nil then
     f_InBend.Generator:= f_Writer
    else
     f_OutBend:= f_Writer;
   end
   else
    l_DM.Generator:= f_Writer;
   {$ELSE}
   if f_InBend <> nil then
   begin
    f_Pipe.Writer := f_InBend;
    if f_InBend.Generator = nil then
     f_InBend.Generator:= f_Writer
    else
     f_OutBend:= f_Writer;
   end
   else
    f_Pipe.Writer:= f_Writer;
   {$ENDIF}
   f_Pipe.Convert2OEM:= False;
   f_Pipe.ExportDocument:= ExportDocument;
   f_Pipe.Attributes := Attributes - [atKeyWords];
   f_Pipe.Execute;
  finally
    l3Free(f_Writer);
  end; { Writer.Create }
 {$IFDEF AAC}
 finally
  l3Free(l_DM);
 end;
 {$ENDIF}
end;

function TExportPipe.GetKWFileName: ShortString;
begin
  Result:= f_Pipe.KWFileName;
end;

procedure TExportPipe.SetKWFileName(Value: ShortString);
begin
  f_Pipe.KWFileName:= Value;
end;

function TExportPipe.GetTotalSizeDone: ShortString;
begin
  Result:= f_Pipe.TotalSizeDone;
end;


function TExportPipe.GetExportAnnotation: Boolean;
begin
  Result := f_Pipe.ExportAnnotation;
end;

procedure TExportPipe.MakeSingleDocSab(aDocID: TDocID; aIsExternal: Boolean);
begin
 f_Pipe.MakeSingleDocSab(aDocID, aIsExternal);
end;

function TExportPipe.pm_GetDocSab: ISab;
begin
 Result := f_Pipe.DocSab;
end;

function TExportPipe.pm_GetExportEditions: Boolean;
begin
 Result := f_Pipe.ExportEditions;
end;

function TExportPipe.pm_GetExportReferences: Boolean;
begin
 Result := f_Pipe.ExportReferences;
end;

function TExportPipe.pm_GetTotalDone: Int64;
begin
 Result := f_Pipe.TotalDone;
end;

procedure TExportPipe.pm_SetDocSab(const Value: ISab);
begin
 f_Pipe.DocSab:= Value;
end;

procedure TExportPipe.pm_SetExportEditions(const Value: Boolean);
begin
 f_Pipe.ExportEditions:= Value;
end;

procedure TExportPipe.pm_SetExportReferences(const Value: Boolean);
begin
 f_Pipe.ExportReferences:= Value;
end;

procedure TExportPipe.pm_SetOnlyStructure(const aValue: Boolean);
begin
 f_OnlyStructure := aValue;
 {!!!! Ловушка для Слонопотама !!!!}
 if f_OnlyStructure then
  l3System.Stack2Log('Запрос экспорта только структуры документов');
end;

procedure TExportPipe.pm_SetQuery(const Value: TdtQuery);
var
 l_Sab: ISab;
begin
 l_Sab:= Value.GetDocIdList;
 DocSab := l_Sab;
end;

procedure TExportPipe.UnnecessaryData(aDocID : TDocID; aMessage : AnsiString);
begin
 f_ErrorFound:= True;
 { TODO -oNarry -cРазвитие : На будущее - добавить более толковую обработку сообщения }
 f_UnnecessaryDataList.Add(SysUtils.Format('%d %s', [aDocID, aMessage]));
end;

procedure TExportPipe.SetProgressor(const Value: TddProgressObject);
begin
  FProgressor := Value;
end;

procedure TExportPipe.SetExportAnnotation(const Value: Boolean);
begin
 f_Pipe.ExportAnnotation := Value;
end;

procedure TExportPipe.SetExportDirectory(const Value: ShortString);
begin
  if FExportDirectory <> Value then
  begin
    FExportDirectory := Value;
    f_FilerDispatcher.TargetFolder := Value;
  end;
end;

procedure TExportPipe.SetObjTopicFileName(const Value: AnsiString);
begin
 if Value <> '' then
  FObjTopicFileName := Value;
end;

procedure TExportPipe.WriteImages(aRangeManager: Tl3RangeManager; var theTIFFProcessor: TddTiffProcessor;
    aTopic, aImageFileName, aShortName : AnsiString; aImageCount: Integer);
{Имена файлов - страниц графических копий документа кодируются следующим образом:
[Pref]_[Num]_[Date]_[Topic]_[Page].gif, где
[Pref] - префикс издания
[Num] - номер издания (если нет, то может отсутствовать)
[Date] - дата издания (или первая дата периода) в формате DDMMYYYY, например, для журнала вышедшего в мае - 01052006  (если нет, то может отсутствовать)
[Topic] - номер документа, для которого выводятся страницы издания
[Page] - порядковый
все части разделены символом подчеркивания, если часть отсутствует, то и символ подчеркивания опускается
}
var
 j: Integer;
 l_ImageIO: TImageEnIO;
 l_ImageProc: TImageEnProc;
 l_BMP: TIEBitmap;
 l_FileName, l_FileNameEx : AnsiString;
 l_Height, l_Width : Integer;
 l_CurPage: Integer;
begin
 // Немного о том, зачем theTiffProcessor создаётся вовне и подаётся в эту процедуру.
 // Это сделано для минимизации обращения к файлу образа, т.к. парсинг страниц TIFF по сети -
 // самая дорогая процедура в выливке образов, особенно если страниц много, а выливать надо всего несколько
 // из них.
 try
  l_FileName:= ExportDirectory + '\' + aShortName + '_' + aTopic;
  l_FileNameEx := ExportDirectory + '\' + aTopic + '_' + IntToStr(aImageCount) + '.tif';
  if not f_ImagesByPages then
   // Процессор вынимает уже распарсенные ранее страницы из исходного файла и складывает в новый
   theTiffProcessor.ExtractPages(l_FileNameEx, aRangeManager)
  else
  begin
   // TIFF процессор надо грохнуть, чтобы он не держал файл
   FreeAndNil(theTiffProcessor);
   l_ImageIO:= TImageEnIO.Create(nil);
   try
    l_ImageProc:= TImageEnProc.Create(nil);
    try
     l_BMP:= TIEBitmap.Create;
     l_BMP.Location := ieFile;
     try
      if Progressor <> nil then
       Progressor.ProcessUpdate(0, aRangeManager.Count, 'Запись образов к документу ' + aTopic);
      for J:= 1 to aRangeManager.Count do
      begin
       if f_Pipe.Aborted then
        break;
       l_ImageIO.IEBitmap := l_BMP;
       l_CurPage := Pred(aRangeManager.Pages[J]);
       l_ImageIO.Params.TIFF_ImageIndex := l_CurPage;
       try
        l3System.Msg2Log('страница %D/%D ', [J, aRangeManager.Count], l3_msgLevel2);

        l_ImageIO.LoadFromFileTIFF(aImageFileName);
        l_ImageIO.Params.TIFF_Compression := ioTIFF_G4FAX;

        l_FileNameEx := l_FileName + '_' + IntToStr(J) + '.tif';
        l_ImageIO.SaveToFileTIFF(l_FileNameEx);
        l_FileNameEx := l_FileName + '_' + IntToStr(J) + '.gif';
        l_ImageProc.AttachedIEBitmap := l_ImageIO.IEBitmap;

        if (l_ImageIO.IEBitmap.Height >= 2000) then {[$142607395]}
        begin
         // в GIF выливаем по размеру 32% от исходного
         l_Width := l3MulDiv(l_ImageIO.IEBitmap.Width, 32, 100);
         l_Height := l3MulDiv(l_ImageIO.IEBitmap.Height, 32, 100);
         l_ImageProc.Resample(l_Width, l_Height, rfBicubic);
        end;

        l_ImageIO.Params.GIF_Interlaced := False;
        l_ImageIO.Params.BitsPerSample := 2;
        l_ImageIO.Params.SamplesPerPixel := 1;
        l_ImageIO.SaveToFileGIF(l_FileNameEx);
       except
        on EieImageReadError do
         l3System.Msg2Log(SysUtils.Format(epsErrorFileCorrupted, [aTopic, aImageFileName]))
        else
         raise;
       end;
       if Progressor <> nil then
        Progressor.ProcessUpdate(1, j, Format('Стр. %d', [J]))
       else
        afw.ProcessMessages;
      end; // for j
      if Progressor <> nil then
       Progressor.ProcessUpdate(2, aRangeManager.Count, '');
     finally
      FreeAndNil(l_BMP);
     end; // try..finally
    finally
     FreeAndNil(l_ImageProc);
    end; // try..finally
   finally
    FreeAndNil(l_ImageIO);
   end; // try..finally;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка при выливке образа (файл %s). %s: %s', [aImageFileName, E.ClassName, E.Message]);
 end;
end;

function TExportPipe.WriteOnePubl(aPublRec: PPublishDataRec; aRangeManager: Tl3RangeManager; var
    aCSVElem: AnsiString): Boolean;
var
 l_Msg: AnsiString;
 l_SrcRange: AnsiString;
 l_NumOfImages: Integer;
 l_ShName: AnsiString;
 l_Topic: AnsiString;
 l_ImageFileName: AnsiString;
 l_ImageIO: TImageEnIO;
 X: Integer;
 l_Num: AnsiString;
 l_TmpS: AnsiString;
 I: Integer;
 l_TextF: TextFile;
 l_Date: AnsiString;
 l_ImgContainer : TdtImgContainerFile;
 l_ImgCount: Integer;
 l_ICRec: TImgCountRec;
 l_PICRec: PImgCountRec;
 l_Idx: Integer;
 l_IsPicture: Boolean;
 l_TP: TddTiffProcessor;

 procedure AddToCSV(const aStr: string);
 begin
  if f_ImagesByPages and l_IsPicture then
   aCSVElem := aCSVElem + aStr;
 end;

begin
 Result:= False;
 with aPublRec^ do
 begin
  l_ShName:= l3ArrayToString(ShName, SizeOf(ShName));
  l_ImageFileName := DocImageServer.GetImageFileName(aPublRec);
  l_IsPicture := IsTIFF(l_ImageFileName);

  if ((SourId = 0) and (l_ShName <> '@')) or
     (f_ImagesByPages and  (l_ShName = '')) or // если выливаем постранично, то краткий код издательства обязателен
     not FileExists(l_ImageFileName) then
  begin
   l3System.Msg2Log(IfThen(FileExists(l_ImageFileName),
                           'Неправильный источник опубликования "'+ l_ShName + '"',
                           'Неправильное имя файла "'+ l_ImageFileName +'"'));
   exit;
  end; // ((SourId = 0) and (l_ShName <> '@')) or (l_ShName = '') or not DocImageServer.IsImageExists(l_PublRec)
  l3System.Msg2Log('Выливаем образ '+l_ImageFileName, l3_msgLevel2);
  l_Num  := l3ArrayToString(Num, SizeOf(Num));
  aCSVElem := '';
  AddToCSV(l_ShName + #9 + l_Num + #9#9);
  if Length(l_Num) > 0 then
   l_ShName := l_ShName +'_'+l_Num;

  l_Date := FormatDateTime('ddmmyyyy',StDateToDateTime(SDate));
  if SDate > 0 then
   l_ShName := l_ShName +'_'+l_Date;
  AddToCSV(l_Date + #9);
  l_Topic := IntToStr(LinkServer(Family).Renum.GetExtDocID(DocID));
  AddToCSV(l_Topic + #9);
  l_TmpS:= l3ArrayToString(LinkComment, SizeOf(LinkComment));
  l_Num:= '';
  X:= Pos(epsArticleSubstring, AnsiUpperCase(l_TmpS));
  if X <> 0 then
  begin
   Inc(X, 7);
   while (X <= Length(l_TmpS)) and ((l_TmpS[X] in cc_ANSILetter) or (l_TmpS[X] in cc_Digits)) do
   begin
    l_Num := l_Num + l_TmpS[X];
    Inc(X);
   end;
  end;
  AddToCSV(l_Num + #9);

  if f_ImgCounters.FindPart(DocID, SizeOf(TDocID), l_Idx) then
  begin
   l_PICRec := PImgCountRec(f_ImgCounters.ItemSlot(l_Idx));
   l_PICRec^.rCount := l_PICRec^.rCount + 1;
   l_ImgCount := l_PICRec^.rCount;
  end
  else
  begin
   l_ICRec := MakeImgRec(DocID);
   f_ImgCounters.Add(l_ICRec);
   l_ImgCount := 1;
  end;

  if l_IsPicture then // выливаем только TIFF'ы
  begin
   l_TP := TddTiffProcessor.Create(l_ImageFileName);
   try
    l_NumOfImages := l_TP.PageCount;
    l_SrcRange := l3ArrayToString(Pages, SizeOf(Pages));
    if aRangeManager.CheckSource(l_SrcRange) <> 0 then
    begin
     l_Msg:= SysUtils.Format(epsErrorWrongPagesRange, [l_Topic, l_SrcRange]);
     l3System.Msg2Log(l_Msg);
     f_ErrorList.Add(l_Msg);
     exit;
    end;
    aRangeManager.SrcString := l_SrcRange;
    aRangeManager.Confine(1, l_NumOfImages);
    if aRangeManager.Count = 0 then
    begin
     if l_SrcRange <> '' then
     begin
      l3System.Msg2Log('Документ %s: указан диапазон %s, на самом деле %d страниц - пропущен', [l_Topic, l_SrcRange, l_NumOfImages]);
      Exit;
     end;
     if l_TP.PageCount > 0 then
      aRangeManager.SrcString := '1-' + IntToStr(l_TP.PageCount) // если диапазон пуст - выливаем все страницы
     else
     begin
      l3System.Msg2Log(SysUtils.Format(epsErrorFileCorrupted, [l_Topic, l_ImageFileName]));
      exit;
     end;
    end; // RM.Count = 0
    // начинаем собственно экспорт
    if (not f_OnlyDocImagesHeader) or (not f_ImagesByPages) then
     // если количество страниц совпадает с количеством страниц в файле, то нет нужды перекодировать исходный файл
     if (aRangeManager.Count = l_NumOfImages) and (not f_ImagesByPages) then
     begin
      FreeAndNil(l_TP); // иначе он не даст скопировать файл
      CopyFile(l_ImageFileName, ConcatDirName(ExportDirectory, l_Topic + '_' + IntToStr(l_ImgCount) + '.tif'))
     end
     else
      WriteImages(aRangeManager, l_TP, l_Topic, l_ImageFileName, l_ShName, l_ImgCount);
    Result:= True;
   finally
    FreeAndNil(l_TP);
   end;
  end // IsTIFF
  else
   if not f_ImagesByPages then
   begin
    // просто скопировать с изменением имени и расширения
    l_ImgContainer := TdtImgContainerFile.Create(l_ImageFileName);
    try
     l_ImgContainer.UnWrapFile(ConcatDirName(ExportDirectory, l_Topic + '_' + IntToStr(l_ImgCount) + '.zip'));
    finally
     l3Free(l_ImgContainer);
    end;
   end; // if not f_ImagesByPages then
 end; // with PPublishDataRec(lPublInDataList.Data[I])^
end;

procedure TExportPipe._OnCalcDone(Sender: TObject);
begin
 if Assigned(FOnCalculationDone) then
  FOnCalculationDone(Self, TSewerPipe(Sender).AllTopicsSize, TSewerPipe(Sender).EmptyCount);
end;

procedure TExportPipe.NeedDeleteFileData;
begin
 f_FilerDispatcher.RollBack;
 ClearExternalObjects;
end;

procedure TExportPipe.SaveObjectPath(const aFileName: AnsiString);
begin
 if f_ObjectList = nil then
  f_ObjectList := Tl3StringList.Make;
 f_ObjectList.Add(aFileName);
end;

procedure TExportPipe.ClearObjPathList;
begin
 l3Free(f_ObjectList);
end;

procedure TExportPipe.ClearExternalObjects;
var
 i         : Integer;
 l_FileName: TFileName;
begin
 if f_ObjectList <> nil then
  for i := 0 to f_ObjectList.Count - 1 do
  begin
   l_FileName := f_ObjectList[i].AsString;
   if FileExists(l_FileName) then
    DeleteFile(l_FileName);
  end; // for i := 0 to f_ObjectList.Count - 1 do
end;

procedure TExportPipe.AllPartsDivideBy(aDivideBy: TddExportDivideBySet);
var
 l_Part: TddExportDocPart;
begin
 for l_Part := edpDocument to edpAnnotation do
  DivideBy[l_Part] := aDivideBy;
end;

function TExportPipe.pm_GetCodePage: Long;
begin
 Result := f_FilerDispatcher.CodePage;
end;

function TExportPipe.pm_GetDivideBy(aPart: TddExportDocPart): TddExportDivideBySet;
begin
 Result := f_FilerDispatcher.DivideBy[aPart];
end;

function TExportPipe.pm_GetExportDate: TDateTime;
begin
 Result := f_FilerDispatcher.ExportDate;
end;

function TExportPipe.pm_GetLowcaseNames: Boolean;
begin
 Result := f_FilerDispatcher.LowcaseFilenames;
end;

function TExportPipe.pm_GetFileMask(aPart: TddExportDocPart): Il3CString;
begin
 Result := f_FilerDispatcher.FileMask[aPart];
end;

function TExportPipe.pm_GetOutputFileSize: Longint;
begin
 Result := f_FilerDispatcher.FilePartSize;
end;

function TExportPipe.pm_GetUpdateFiles: Boolean;
begin
 Result := f_FilerDispatcher.UpdateFiles;
end;

procedure TExportPipe.pm_SetCodePage(const Value: Long);
begin
 f_FilerDispatcher.CodePage := Value;
end;

procedure TExportPipe.pm_SetDivideBy(aPart: TddExportDocPart; const Value: TddExportDivideBySet);
begin
 if not f_Running then
  f_FilerDispatcher.DivideBy[aPart] := Value;
end;

procedure TExportPipe.pm_SetExportDate(const Value: TDateTime);
begin
 f_FilerDispatcher.ExportDate := Value;
end;

procedure TExportPipe.pm_SetLowcaseNames(const Value: Boolean);
begin
 f_FilerDispatcher.LowcaseFilenames := Value;
end;

procedure TExportPipe.pm_SetFileMask(aPart: TddExportDocPart; const Value: Il3CString);
begin
 f_FilerDispatcher.FileMask[aPart] := Value;
end;

procedure TExportPipe.pm_SetOutputFileSize(const Value: Longint);
begin
 f_FilerDispatcher.FilePartSize := Value;
end;

procedure TExportPipe.pm_SetUpdateFiles(const Value: Boolean);
begin
 if not f_Running then
  f_FilerDispatcher.UpdateFiles := Value;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\pipeout\ExportPipe.pas initialization enter'); {$EndIf}
 DefTIFF_LZWDECOMPFUNC:=TIFFLZWDecompress;
 DefTIFF_LZWCOMPFUNC:=TIFFLZWCompress;
 DefGIF_LZWDECOMPFUNC:= GIFLZWDecompress;
 DefGIF_LZWCOMPFUNC:= GIFLZWCompress;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\pipeout\ExportPipe.pas initialization leave'); {$EndIf}
end.

