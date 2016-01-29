unit SewerPipe;


{ $Id: SewerPipe.pas,v 1.181 2015/10/13 12:55:56 fireton Exp $ }

// $Log: SewerPipe.pas,v $
// Revision 1.181  2015/10/13 12:55:56  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.180.4.2  2015/10/09 13:24:26  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.180.4.1  2015/10/08 13:08:14  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.180  2015/05/28 11:10:22  fireton
// - убираем неиспользующийся параметр из ExpandAllEdition
//
// Revision 1.179  2015/05/20 14:02:24  lulin
// - рисуем на модели.
//
// Revision 1.178  2015/04/07 07:37:12  lukyanets
// Изолируем HT
//
// Revision 1.177  2015/04/06 09:38:47  lukyanets
// Изолируем язык базы
//
// Revision 1.176  2014/09/04 12:12:15  dinishev
// {Requestlink:564750095}. Перенес интерфейсы листнетов в ddTypes
//
// Revision 1.175  2014/09/04 11:02:50  dinishev
// {Requestlink:564750095}
//
// Revision 1.174  2014/08/26 10:55:39  lukyanets
// Спрямляем Abort
//
// Revision 1.173  2014/08/26 07:18:42  lukyanets
// Cleanup
//
// Revision 1.172  2014/08/21 11:09:50  lulin
// - не дёргаемся лишний раз.
//
// Revision 1.171  2014/08/05 06:29:43  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.170  2014/07/11 13:33:46  lukyanets
// {Requestlink:553422280}. Рисуем проценты от количества топиков
//
// Revision 1.169  2014/05/21 14:34:05  voba
// - cc
//
// Revision 1.168  2014/05/08 11:48:19  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.167  2014/04/17 13:04:58  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.166  2014/04/04 06:59:49  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.165  2014/02/24 11:29:32  fireton
// - передаём атрибуты для выливки через property
//
// Revision 1.164  2014/02/14 15:33:56  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.163  2013/12/18 05:48:35  fireton
// - DIapason и DocSab не могут быть назначены одновременно (K 502979237)
//
// Revision 1.162  2013/10/21 17:31:13  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.161  2013/10/21 15:43:19  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.160  2013/10/21 10:31:07  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.159  2013/07/18 12:03:41  voba
// - bug fix. Ошибка с подсчетом количества документов для выливки 2
//
// Revision 1.158  2013/07/18 07:29:10  voba
// - bug fix. Ошибка с подсчетом количества документов для выливки
//
// Revision 1.157  2013/04/19 13:10:48  lulin
// - портируем.
//
// Revision 1.156  2013/04/11 16:46:52  lulin
// - отлаживаем под XE3.
//
// Revision 1.155  2013/03/22 04:38:49  fireton
// - по умолчанию экспортируем все типы документов
//
// Revision 1.154  2013/02/07 13:18:49  narry
// Обновление (лишнее свойство)
//
// Revision 1.153  2013/02/05 13:36:14  narry
// Обновление
//
// Revision 1.152  2013/02/05 12:11:33  narry
// Сделать возможность выливать EVD БЕЗ KeyWords (426675759)
//
// Revision 1.151  2012/12/10 10:06:53  narry
// Чистка мусора
//
// Revision 1.150  2012/10/26 07:27:24  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.149  2012/10/19 11:15:38  narry
// Экспорт формул как картинок (404947393)
//
// Revision 1.148  2012/10/18 07:01:13  narry
// Не вычисляем размер объектных топиков
//
// Revision 1.147  2012/10/02 08:09:16  narry
// Начало перехода на ISab вместо SAB
//
// Revision 1.146  2012/09/10 08:34:57  narry
// Изменение формата вывода в лог
//
// Revision 1.145  2012/09/03 09:10:25  narry
// Борьба с подвисанием АК при отсутствии документов
//
// Revision 1.144  2012/07/10 10:02:52  narry
// Отчет о результатах экспорта (375424204)
//
// Revision 1.143  2012/07/02 08:05:44  narry
// Обновление
//
// Revision 1.142  2012/06/28 13:09:28  narry
// Вывод в лог информации о пустых документах (во время подсчета размера или во время экспорта)
//
// Revision 1.141  2012/05/12 09:32:57  narry
// Неправильно указывалось количество справок для экспорта
//
// Revision 1.140  2012/04/11 12:34:59  narry
// Вывод в лог номеров справок
//
// Revision 1.139  2012/03/29 07:17:48  narry
// Экпортировать только справки (352453562)
//
// Revision 1.138  2012/01/30 09:11:24  narry
// - не уничтожался Progressor
//
// Revision 1.137  2011/10/13 08:43:33  narry
// Накопившиеся изменения
//
// Revision 1.136  2011/10/05 11:04:18  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.135  2011/09/16 12:57:41  narry
// - обновление
//
// Revision 1.134  2011/09/16 08:42:28  narry
// - Обновление
//
// Revision 1.133  2011/09/16 08:12:49  narry
// - Обновление
//
// Revision 1.132  2011/09/07 13:01:45  narry
// Исправление градусника
//
// Revision 1.131  2011/07/19 09:06:01  narry
// Не переключается имя файла (274825533)
//
// Revision 1.130  2011/07/06 11:29:17  narry
// Уточнения алгоритма вычисления объема экспорта
//
// Revision 1.129  2011/06/14 13:18:43  narry
// Реализовать автоэкспорт документов (268338975)
//
// Revision 1.128  2011/06/10 12:49:16  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.127  2011/04/11 10:25:05  narry
// Названия для ФАС (259885290)
//
// Revision 1.126  2011/02/14 13:49:13  narry
// K223609035. Список экспортированных аннотаций
//
// Revision 1.125  2011/01/28 12:25:18  narry
// K251345165.Фильтр преобразования сегментов с картинками в картинки
//
// Revision 1.124  2011/01/11 07:38:57  narry
// 249338187: Добавить в цепочку экспорта
//
// Revision 1.123  2010/09/24 12:11:01  voba
// - k : 235046326
//
// Revision 1.122  2010/07/12 08:48:27  narry
// - К204113447
//
// Revision 1.121  2010/07/09 11:51:17  narry
// - К172985568
//
// Revision 1.120  2010/04/20 08:51:23  narry
// - экспорт поискового запроса
//
// Revision 1.119  2010/03/10 13:57:28  narry
// - не собиралось
//
// Revision 1.118  2010/01/26 13:06:36  narry
// - не определялась группа доступа
//
// Revision 1.117  2009/12/02 08:31:35  fireton
// - автоматическая линковка документов
//
// Revision 1.116  2009/11/16 10:11:41  narry
// - обновление
//
// Revision 1.115  2009/11/10 09:12:35  narry
// - обновление
//
// Revision 1.114  2009/09/08 09:03:51  narry
// - промежуточное обновление
//
// Revision 1.113  2009/07/22 11:27:29  narry
// - изменение доступа к DictServer
//
// Revision 1.112  2009/07/20 12:39:10  voba
// - Засунул renum в атрибуты
//
// Revision 1.111  2009/05/27 12:39:26  narry
// - расширение списка параметров
//
// Revision 1.110  2009/03/16 16:19:17  narry
// - форматирование номера документа
//
// Revision 1.109  2009/03/04 16:26:01  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.108  2009/02/05 10:26:24  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.107  2009/01/29 08:41:23  fireton
// - bugfix: в диапазоне передавался список записей, а не список значений
//
// Revision 1.106  2009/01/26 08:06:19  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.105  2009/01/14 14:06:55  narry
// - татары
//
// Revision 1.104.2.1  2008/12/26 15:22:06  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.104  2008/10/23 10:56:07  fireton
// - избавляемся от пустых параграфов в objtopic'ах
//
// Revision 1.103  2008/09/25 10:23:29  fireton
// - bugfix: не уничтожался фильтр
//
// Revision 1.102  2008/09/23 12:17:50  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.101  2008/06/11 09:47:47  narry
// - фильтрация престижей
//
// Revision 1.100  2008/05/13 14:15:14  narry
// - пропали атрибуты документов
//
// Revision 1.99  2008/05/08 14:04:22  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.98  2008/04/22 12:43:58  voba
// - add корректор нулевых ссылок
//
// Revision 1.97  2008/04/22 08:59:40  narry
// - замена 0 в адресах ссылок на ID документа
//
// Revision 1.96  2008/03/20 09:48:33  lulin
// - cleanup.
//
// Revision 1.95  2008/02/12 13:23:14  voba
// - заточки для быстрой выливки справок без документов
//
// Revision 1.94  2008/02/07 14:44:39  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.93  2007/10/09 08:54:13  voba
// - merge with b_archi_export_refact2
//
// Revision 1.92.6.1  2007/09/14 15:52:58  voba
// no message
//
// Revision 1.92  2007/08/30 08:34:39  narry
// - Промежуточное сохранение
//
// Revision 1.91.2.1  2007/07/26 12:10:03  voba
// - refact. выкинул  ImportType, все равно он только ietMassive использовался
//
// Revision 1.91  2007/07/24 12:32:35  narry
// - рефакторинг системы сообщений
//
// Revision 1.90  2007/06/13 11:24:39  narry
// - мелкие исправления
//
// Revision 1.89  2007/04/02 10:39:43  voba
// - change Sab to ISab
//
// Revision 1.88.6.1  2007/03/29 09:05:41  voba
// no message
//
// Revision 1.88  2006/12/07 11:22:17  narry
// - экспорт одного документа из выборки
//
// Revision 1.87  2006/10/04 08:45:14  voba
// - remove tdSingle
//
// Revision 1.86  2006/02/14 08:40:23  voba
// - rename
//  Tm3DocumentStream   -> Tm3DocPartSelector
//  Tm3DocumentStreams  -> Tm3DocPartSet
//  m3_defDocStream     -> m3_defDocPart
//  m3_AllDocStreams    -> m3_AllDocParts
//
// Revision 1.85  2006/02/07 16:32:04  voba
// - new beh. абстрагирование Im3DB от структуры базы
//
// Revision 1.84  2006/02/06 14:56:16  narry
// - чистка кода
//
// Revision 1.83  2005/12/01 11:47:44  narry
// - обновление
//
// Revision 1.82  2005/11/25 13:33:25  voba
// no message
//
// Revision 1.81  2005/11/09 16:22:21  narry
// - новое: возможность прервать экспорт графических образов
// - исправление: задание папки для экспорта ключевых слов
//
// Revision 1.80  2005/11/02 16:34:14  narry
// - некоторые изменения
//
// Revision 1.79  2005/10/18 09:06:50  lulin
// - исправлено, то что не компилировалось в связи с переездом модулей.
//
// Revision 1.78  2005/07/26 10:46:19  narry
// - update: расширение функциональности экспорта - только структура документа
//
// Revision 1.77  2005/05/24 08:39:01  lulin
// - bug fix: не компилировалось.
//
// Revision 1.76  2005/04/28 13:01:31  narry
// - update: расчет размера доументов
//
// Revision 1.75  2005/04/19 15:41:47  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.74  2005/04/12 10:18:55  narry
// - update: борьба с залочками
//
// Revision 1.73  2005/03/24 18:39:27  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.72  2005/03/16 08:35:26  voba
// - убрал перекодировку строк в OEM, этим занимается файлер
//
// Revision 1.71  2005/03/11 16:40:50  narry
// - bug fix: не компилировалась труба автоклассификации
//
// Revision 1.70  2005/03/04 15:53:29  narry
// - новинка: реализация импорта Пучин-нср
//
// Revision 1.69  2005/02/24 15:05:26  lulin
// - new behavior: "труба экспорта" учитывает, то что у документа может быть несколько потоков.
//
// Revision 1.68  2005/02/24 13:50:47  narry
// - восстановление исходного состояния
//
// Revision 1.66  2005/02/21 15:22:14  narry
// - update: косметика
//
// Revision 1.65  2005/02/18 17:00:27  narry
// - update
//
// Revision 1.64  2005/02/18 14:54:00  narry
// - bug fix
//
// Revision 1.63  2005/02/18 12:16:28  narry
// - update: поддержка Аннотаций
//
// Revision 1.62  2005/02/18 12:00:59  narry
// - update: поддержка Аннотаций
//
// Revision 1.61  2005/02/16 17:11:17  narry
// - update: поддержка Аннотаций
//
// Revision 1.60  2005/01/17 15:45:10  narry
// - update;
// - bug fix: раздельное формирование csv-файлов для нормальных и ненормальных источников опубликования
//
// Revision 1.59  2004/09/21 12:21:14  lulin
// - Release заменил на Cleanup.
//
// Revision 1.58  2004/09/14 15:58:10  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.57  2004/08/27 15:13:49  voba
// - merge with B_New_Text_Base
//
// Revision 1.56.4.2  2004/08/25 16:36:27  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.56.4.1  2004/08/25 16:11:46  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.56  2004/05/14 17:27:08  law
// - remove unit: evStrGen.
//
// Revision 1.55  2004/05/14 15:17:05  law
// - remove unit: evTypesE.
//
// Revision 1.54  2004/02/18 12:11:37  narry
// - bug fix: неправильное разрезание на куски
//
// Revision 1.53  2004/02/17 10:30:26  narry
// - update
// - cleanup
//
// Revision 1.52  2003/12/23 17:03:57  narry
// - bug fix: пусто имя файла ключевых слов приводило к ошибке
//
// Revision 1.51  2003/09/22 15:42:50  narry
// - bug fix: AV при f_Progressor = nil
//
// Revision 1.50  2003/09/15 14:20:14  narry
// - update: прорисовка прогресса выполнения процесса
//
// Revision 1.49  2003/08/27 08:36:11  voba
// - bug fix: процедура слива KW падала на вызове прогрессиндикатора
//
// Revision 1.48  2003/07/23 10:13:13  narry
// - cleanup
// - bug fix: сломалась нарезка файлов по размеру
//
// Revision 1.47  2003/07/22 12:02:03  narry
// - bug fix: не обновлялась информация о процессе выполнения экспорта
//
// Revision 1.46  2003/07/18 14:44:29  narry
// - change: изменение логики отображения информации о прогрессе выполения импорта
//
// Revision 1.45  2003/07/16 10:36:35  narry
// - update: объект TddDocTypeDetector перенесен в отдельный модуль
//
// Revision 1.44  2003/07/10 08:15:49  narry
// - update: объединение с основной веткой
//
// Revision 1.43.2.1  2003/07/08 15:18:28  narry
// - update: возможность управлять прохождением документов различных типов через трубу
//
// Revision 1.43  2003/06/03 11:13:42  narry
// - bug fix: попытка создать папку с пустым именем
// - update: расширение функциональности для автоклассификатора
//
// Revision 1.42  2003/01/29 14:07:04  narry
// - update
//
// Revision 1.41  2003/01/27 13:21:59  narry
// - special
//
// Revision 1.40  2003/01/20 13:40:25  narry
// - new behavior: возможность регистрации нескольких фильтров экспорта
//
// Revision 1.39  2003/01/17 10:23:16  narry
// - new begavior: возможность прервать экспорт
//
// Revision 1.38  2002/09/19 13:09:16  narry
// - remove unit: ddHTML.
//
// Revision 1.37  2002/09/18 08:06:08  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.36  2002/07/30 15:59:37  narry
// - update
//
// Revision 1.35  2002/07/03 09:00:58  narry
// - update, cleanup и new behavior
//
// Revision 1.34  2002/06/11 12:15:47  narry
// - bug fix: начинало документа с таблицы приводило к Access violation
//
// Revision 1.33  2002/06/07 11:20:36  narry
// - update
//
// Revision 1.32.2.1  2002/06/06 15:09:23  narry
// - beta save.
//
// Revision 1.32  2002/04/17 09:21:21  narry
// - new behavor: подавление атрибутов, хранящихся в теле документа
//
// Revision 1.31  2001/12/27 13:46:12  narry
// - update: реализация выливки по AccGroups
//
// Revision 1.30  2001/11/22 13:58:44  narry
// - update : начало реализации Групп доступа
//
// Revision 1.29  2001/10/25 13:12:35  narry
// - update: доработка процедуры обсчета длинных процессов
//
// Revision 1.28  2001/10/24 15:07:00  narry
// - new behavior: разделение файла на куски, новый прогресс-объект
//
// Revision 1.27  2001/09/04 13:58:59  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.26  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.25  2001/08/23 14:28:34  voba
// no message
//
// Revision 1.24  2001/04/27 11:39:37  voba
// - bug fix: изменена обработка ошибок во время чтения файлов.
//
// Revision 1.23  2001/04/25 14:48:17  voba
// - new behavior: немного изменена логика работы цепочек генераторов.
//
// Revision 1.22  2001/03/16 14:59:31  voba
// fix Everest function name/format
//
// Revision 1.21  2001/02/28 10:12:39  law
// - процедуры Write и WriteEx объединены в одну - Write.
//
// Revision 1.20  2000/12/27 13:03:00  law
// - вставлена директива Log.
//

{.$DEFINE OnlyText}
{.$Undef ddLog}
{$I ddDefine.inc}

interface

Uses
  Classes,
  l3Types, l3Filer, l3Date, l3Base, m3DBInterfaces, l3LongintList,
  evExportGenerator, evEvdRd, evTagsListFilter,
  k2Types, k2TagGen, k2ForkGenerator,
  dt_EGen,
  dt_Types, dt_Const, dt_AttrSchema,
  dt_EFltr,
  ddFixFilter, ddProgressObj, ddDocTypeDetector, ddNameFilter, ddParaEliminator,
  m3DB,
  ddExtObjectSupport, ddPipeOutInterfaces,
  evdHyperlinkCorrector, evEmptyTableEliminator, ddPictureFilter, ddTypes, dtIntf, dt_Sab;

type
   TddObjTopicTextDeleterFilter = class(TddChildBiteOffFilter)
   protected
    procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
   public
    constructor Create;
   end;

  TSewerPipe = class(Tl3Base, IddDocumentListner)
  private
   f_Listner: Pointer;
   f_Attributes: TdtAttributeSet;
   f_Reader: TevEvdReader;
   f_Filer: Tl3CustomFiler;
   f_DemonDocGen: TDocExportGenerator;
   f_ExpGen: TevExportGenerator;
   f_Progressor: TddProgressObject;

   f_Writer: Tk2TagGenerator;
   f_TotalProgressProc: Tl3ProgressProc;

    f_Aborted: Boolean;

    f_Family: Longint;
    f_TopicNo: Longint;  { номер топика... но внешний или внутренний? Будет внешний}
    f_Running: Boolean;

    f_ExportDocument: Boolean;
    f_ExportKW: Boolean;
    f_ExportEmpty: Boolean;
    f_KWFileName: AnsiString;

    f_SeparateFiles: Boolean;

    f_TotalSizeDone: ShortString;
    f_Dicts: TdtAttributeSet;
    f_ExportDirectory: AnsiString;
    f_MultiUser: Boolean;
    f_Convert2OEM: Boolean;
    f_InternalFormat: Boolean;
    f_FileSize: Longint;
    f_OnUnnecessaryData: TExportUnnecessaryData;
   f_Filter: TExportFilter;
   f_FixFilter: TddWrongTagFixFilter;
   f_DocTypeDetector: TddDocTypeDetector;
   FExportAnnotation: Boolean;
   FOnCalculateDone: TNotifyEvent;
   FOnlyStructure: Boolean;
   FSpecialAnnotation: Boolean;
   FSpecialFiler: Tl3CustomFiler;
   f_AllTopicSize: Int64;
   f_CurDone: Int64;
   f_CurSize: Int64;
   f_DocSab: ISab;
   f_EmptyCount: Integer;
   f_EmptyTableElim: TevEmptytableEliminator;
   f_ExportDocTypes: TddExportDocTypes;
   f_ExportEditions: Boolean;
   f_ExportReferences: Boolean;
   f_ExtObjInserter: TddExtObjInserter;
   f_ObjTopicTextFilter: TddObjTopicTextDeleterFilter;
   f_Fork: Tk2ForkGenerator;
   f_FormulaAsPicture: Boolean;
   f_Generator: Tk2TagGenerator;
   f_HyperlinkCorrector: TevdHyperlinkCorrector;
   f_TopicsNeedDo: LongInt;
   f_TotalDone: Int64;
   f_NameWriter: TddNameWriter;
   f_NullFilter: TddNullDocFilter;
   f_OnError: TddErrorEvent;
   f_OnNewDocument: TNewDocumentEvent;
   f_PicFilter: TddPictureFilter;
   f_StartProgress: Boolean;
   f_UseDocSize: Boolean;
   f_StructureGenerator: TddParaEliminator;
   f_TopicsList: Tl3LongintList;
   procedure CalcWorkValue(What: Tm3DocPartSet);
   procedure CheckProgressor;
   procedure DoExportDictionaries;
   procedure DoExportKeywords;
   procedure ExpandEditions;
    function GetTotalDone: Int64;
   function OnlyReferences: Boolean;
   function pm_GetTopicDone: Longint;
   procedure pm_SetAttributes(const Value: TdtAttributeSet);
   procedure pm_SetProgressor(const Value: TddProgressObject);
    procedure pm_SetTotalProgressProc(const Value: Tl3ProgressProc);
   procedure StartProgress;
   procedure StopProgress;
   function CalcTotalTopicCount: Int64;
  protected
   procedure NeedDeleteFileData;
   procedure InnerTopicUpdate(aState: Byte; aValue: Long; const aMsg: AnsiString);
   procedure SetAborted(Value: Boolean);
   procedure SetFamily(aFamily: Longint);
   procedure CreatePipeBends;
   procedure DestroyPipeBends;
   procedure TopicSwitch(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
(*
   procedure SetBreakFlag(Value: Boolean);
   function GetBreakFlag: Boolean;
*)   
   procedure StartDocument(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart;
       MainGroup: ShortString);
   procedure TopicInit;
   procedure Cleanup; override;
   procedure Error(const aDescription: AnsiString; aCategory: Integer = 0);
   property ExportFilter: TExportFilter read f_Filter write f_Filter;
  public
   constructor Create; override;
   function Execute: Boolean; virtual;
   procedure MakeSingleDocSab(aDocID: TDocID; aIsExternal: Boolean);
   procedure WriteSpecialName;
   procedure LinkListner(const aListner: IddDocumentListner);
   procedure UnLinkListner(const aListner: IddDocumentListner);
  public
   property Aborted: Boolean
    read f_Aborted
    write SetAborted;
   property AllTopicsSize: Int64
    read f_AllTopicSize;
   property Attributes: TdtAttributeSet read f_Attributes write pm_SetAttributes;
   property Progressor: TddProgressObject read f_Progressor write pm_SetProgressor;
   property ExportDocTypes: TddExportDocTypes read f_ExportDocTypes write
       f_ExportDocTypes;

   property TopicDone: Longint read pm_GetTopicDone;
   property TopicsNeedDo: Longint
    read f_TopicsNeedDo;

   property Convert2OEM: Boolean
      read f_Convert2OEM write f_Convert2OEM;

   property InternalFormat: Boolean
      read f_InternalFormat write f_InternalFormat;

    property Family: Longint read f_Family write f_Family;

    property ExportKW: Boolean
      read f_ExportKW write f_ExportKW;

    property KWFileName: AnsiString
      read f_KWFileName write f_KWFileName;

    property Dicts: TdtAttributeSet
      read f_Dicts write f_Dicts;

    property ExportEmpty: Boolean
      read f_ExportEmpty write f_ExportEmpty;

    property ExportDirectory: AnsiString
      read f_ExportDirectory write f_ExportDirectory;

    property ExportDocument: Boolean
      read f_ExportDocument write f_ExportDocument;

    property SeparateFiles: Boolean
      read f_SeparateFiles write f_SeparateFiles;

   property DocSab: ISab read f_DocSab write f_DocSab;
   property EmptyCount: Integer read f_EmptyCount;
   property ExportAnnotation: Boolean read FExportAnnotation write
       FExportAnnotation;
   property ExportEditions: Boolean read f_ExportEditions write f_ExportEditions;

    property TotalProgressProc: Tl3ProgressProc read f_TotalProgressProc write
        pm_SetTotalProgressProc;
    property TotalDone: Int64
     read GetTotalDone;
    property TotalSizeDone: ShortString
      read f_TotalSizeDone write f_TotalSizeDone;
    property MultiUser: Boolean
      read f_Multiuser write f_MultiUser;
   {
    property FileSize: Longint
      read f_FileSize write f_FileSize;
   }   
   property FormulaAsPicture: Boolean read f_FormulaAsPicture write
       f_FormulaAsPicture;
   property OnlyStructure: Boolean read FOnlyStructure write FOnlyStructure;
   property SpecialAnnotation: Boolean read FSpecialAnnotation write
       FSpecialAnnotation;
   property SpecialFiler: Tl3CustomFiler read FSpecialFiler write FSpecialFiler;
   property OnError: TddErrorEvent read f_OnError write f_OnError;
  published
   property OnCalculateDone: TNotifyEvent
    read FOnCalculateDone
    write FOnCalculateDone;
    property OnNewDocument: TNewDocumentEvent read f_OnNewDocument write f_OnNewDocument;
    property OnUnnecessaryData: TExportUnnecessaryData
     read f_OnUnnecessaryData
     write f_OnUnnecessaryData;

   property ExportReferences: Boolean read f_ExportReferences write f_ExportReferences;
   property TopicsList: Tl3LongintList read f_TopicsList;
    property Writer: Tk2TagGenerator
      read f_Writer write f_Writer;
  end;



implementation

uses
  SysUtils, Forms,
  ddUtils,

  daDataProvider,

  dt_Dict,
  dt_Doc,
  dt_LinkServ,
  ht_Const, ht_dll,
  m3StorageInterfaces,
  m2COMLib,
  l3FileUtils, k2Tags, k2Base, l3Prg, l3Variant,

  DictsSup,
  afwFacade,

  k2StackGenerator, ddHeaderFilter, evdBufferedFilter, l3languages,
  evNestedDocumentEliminator,
  evdAllDocumentSubsEliminator,

  Document_Const,
  AnnoTopic_Const,
  TextPara_Const
  , l3DatLst, l3LongintListPrim,

  evdChildrenCountEliminator
  , Math, StrUtils, ddFormula2PictureFilter,

  m3DBFiler
  ;

const
 cEmptyDocSize = 150;


constructor TSewerPipe.Create;
begin
 inherited;
 f_Aborted:= False;
 f_Convert2OEM:= False;
 f_Family:= CurrentFamily;
 f_ExportEditions:= False;
 f_ExportDocTypes:= dtAll;
 f_Attributes := CdtAllAttributes;
 //CreatePipeBends;
 f_TopicsList := Tl3LongintList.MakeSorted(l3_dupAccept);
end;

procedure TSewerPipe.CalcWorkValue(What: Tm3DocPartSet);
var
 i, l_RelCount, l_AnnoCount: Integer;
 l_Storage: Im3DB;
 l_Stream : IStream;
 l_Doc : Im3DBDocument;
 l_Size: Integer;
 l_Rel: Boolean;
 l_Msg: AnsiString;
 l_DocCount : Integer;

const
 c_PartNames: array[Tm3DocPartSelector] of String = (
   'документа', 'аннотации', 'информации о документе', 'объекта'
     );

var
 lRAProcStub : TdtRecAccessProc;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  l_DocPart : Tm3DocPartSelector;
  l_ExtNumber: TDocID;
 begin
  Result := True;
  l_Doc := l_Storage.GetDocument(PDocID(aItemPtr)^);
   try
    for l_DocPart := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
    if l_DocPart in What then
    begin
     if (l_DocPart = m3_dsAnno) {and not DocumentServer.FileTbl.GetHasAnno(PDocID(aItemPtr)^)} then
      continue;
     try
        l_Stream := l_Doc.Open(m3_saRead, l_DocPart);
        try
         l_Size:= m2ComGetSize(l_Stream);
         if l_Size <= cEmptyDocSize then
         begin
          l_ExtNumber:= LinkServer(CurrentFamily).ReNum.GetExtDocID(l_Doc.ID);
          Error(Format('Отсутствует текст у %s # %-11d (%s)',
                           [c_PartNames[l_DocPart], IfThen(l_ExtNumber > 0, l_ExtNumber, l_Doc.ID), IfThen(l_ExtNumber > 0, 'внешний', 'внутренний')]));
          Inc(f_EmptyCount);
         end;
         Inc(f_AllTopicSize, l_Size);
        finally
         l_Stream := nil;
        end;
         Inc(f_TopicsNeedDo);
     except
      Error(Format('Ошибка чтения документа # %-11d (%d)', [LinkServer(CurrentFamily).ReNum.GetExtDocID(l_Doc.ID), l_Doc.ID]));
     end;
    end; // l_DocPart in What
  finally
   l_Doc := nil;
  end;
  if f_Progressor <> nil then
   f_Progressor.ProcessUpdate(1)
  else
   afw.ProcessMessages;
 end;

var
 l_TmpSab: ISab;
 l_Type: Byte;
begin
 f_AllTopicSize := 0;
 f_EmptyCount:= 0;
 f_TopicsNeedDo:= 0;
 l_AnnoCount:= 0;
 l_DocCount:= f_DemonDocGen.DocCount;
 if l_DocCount > 0 then
 begin
  f_UseDocSize := l_DocCount <= 10;
  l_RelCount:= f_DemonDocGen.RelatedCount(l_AnnoCount);
  if f_UseDocSize then
  begin
   l_Storage:= Tm3DB.Make(GlobalDataProvider.TextBase[CurrentFamily]);
   try
    if f_Progressor <> nil then
     f_Progressor.Start(l_DocCount, 'Подсчет объема документов');
    {$IFDEF ddLog}
    l3System.Msg2Log('Подсчет объема %d документов', [l_DocCount]);
    {$ENDIF}
    l_Storage.Start(m3_saRead);
    try
     lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
      l_TmpSab:= MakeSabCopy(f_DemonDocGen.DocIDList);
      try
       l_TmpSab.RecordsByKey;
       l_Type:= Ord(dtObject);
       l_TmpSab.SubSelect(fType_Fld, l_Type, NOT_EQUAL);
       l_TmpSab.ValuesOfKey(fID_Fld);
       l_TmpSab.IterateRecords(lRAProcStub);
      finally
       l_TmpSab:= nil;
      end;
     finally
      FreeRecAccessProc(lRAProcStub);
     end;
    finally
     l_Storage.Finish;
    end;
    if f_Progressor <> nil then
     f_Progressor.Stop;

   finally
    l_Storage:= nil;
   end;
  end
  else //if f_UseDocSize then
  begin
   f_TopicsNeedDo:= 0; f_AllTopicSize:= 0;
   if (m3_dsMain in What) then
   begin
    f_AllTopicSize:= l_DocCount + l_RelCount;
    f_TopicsNeedDo:= l_DocCount;
   end;
   if (m3_dsAnno in What) then
   begin
    Inc(f_AllTopicSize, l_AnnoCount);
   end
   else
    l_AnnoCount:= 0;
  end;
  {$IFDEF ddLog}
  l3System.Msg2Log('Подсчет завершен. Найдено:');
  if ExportDocument then
   l3System.Msg2Log(' %d документов', [f_TopicsNeedDo])
  else
   f_TopicsNeedDo:= 0;
  if ExportReferences then
  begin
   l3System.Msg2Log(' %d справок', [l_RelCount]);
   inc(f_TopicsNeedDo, l_RelCount);
  end;
  if ExportAnnotation then
  begin
   l3System.Msg2Log(' %d аннотаций', [l_AnnoCount]);
   Inc(f_TopicsNeedDo, l_AnnoCount);
  end;
  if f_EmptyCount > 0 then
   l3System.Msg2Log('Обнаружено пустых - %d', [f_EmptyCount]);
  if f_UseDocSize then
   l3System.Msg2Log('Объем экспорта %s', [Bytes2Str(f_AllTopicSize)]);
  {$endif}
 end; //if l_DocCount > 0 then

 if Assigned(FOnCalculateDone) then
  FOnCalculateDone(Self);
end;

procedure TSewerPipe.CheckProgressor;
begin
 if f_Progressor = nil then
  f_Progressor:= TddProgressObject.Create();
end;

procedure TSewerPipe.Cleanup;
begin
 f_Listner := nil;
 FreeAndNil(f_Progressor);
 FreeAndNil(f_TopicsList);
 DestroyPipeBends;
 inherited;
end;


procedure TSewerPipe.SetAborted(Value: Boolean);
begin
 f_Aborted:= Value;
 if f_DemonDocGen <> nil then
  f_DemonDocGen.BreakFlag:= Value;
end;

procedure TSewerPipe.CreatePipeBends;
var
 l_G :Tk2TagGenerator;
 lEliminator : TevNestedDocumentEliminator;
begin
 { Создание }
 { TODO : Надо бы переделать на SetTo }
 f_DemonDocGen:= TDocExportGenerator.Create(nil, Family);
 f_DemonDocGen.LinkListner(Self);
 f_DemonDocGen.AnsiCodePage:= GlobalDataProvider.BaseLanguage[Family].AnsiCodePage;
 f_Filter:= TExportFilter.Create(Family);
 f_Filter.AnsiCodePage:= GlobalDataProvider.BaseLanguage[Family].AnsiCodePage;
 f_Filter.Attributes := f_Attributes;
 DictServer(Family).AddDictChangeNotifiedObj(f_Filter);
 f_DocTypeDetector:= TddDocTypeDetector.Create(nil);
 f_DocTypeDetector.ExportTypes:= ExportDocTypes;
 f_ExpGen:= TevExportGenerator.Create(nil);
 f_ExpGen.OnInitTopic:= TopicSwitch;
 f_Reader:= TevEvdReader.Create(nil);
 f_FixFilter:= TddWrongTagFixFilter.Create(nil);
 f_FixFilter.Write2Log := False;
 f_ObjTopicTextFilter := TddObjTopicTextDeleterFilter.Create;
 f_ObjTopicTextFilter.IsActive := False;
 f_NullFilter:= TddNullDocFilter.Create(k2_idDocument);
 f_Filer := Tm3DBFiler.Create(Tm3DB.Make(GlobalDataProvider.TextBase[Family]));
 f_Fork:= Tk2ForkGenerator.Create(nil);
 f_StructureGenerator := TddParaEliminator.Create(nil);
 f_ExtObjInserter := TddExtObjInserter.Create(nil);
 f_EmptyTableElim:= TevEmptytableEliminator.Create(nil);
 f_PicFilter:= TddPictureFilter.Create;
 { Соединение }
 f_Reader.Filer:= f_Filer;
 f_Reader.Generator:= f_NullFilter;
 
 l_G := f_NullFilter.Use;
 try
  // - это самый конец трубы
  TevNestedDocumentEliminator.SetTo(l_G);
  TevdAllDocumentSubsEliminator.SetTo(l_G);
  TevdChildrenCountEliminator.SetTo(l_G);
  if FormulaAsPicture then
   TddFormula2PictureFilter.SetTo(l_G);
  // - это само начало трубы
  f_Reader.Generator := l_G;
 finally
  FreeAndNil(l_G);
 end;//try..finally

 f_NullFilter.Generator:= f_EmptyTableElim;
 f_EmptyTableElim.Generator:= {x f_PicFilter;
 f_PicFilter.Generator:=} f_FixFilter;
 f_FixFilter.Generator:= f_ExpGen;
 f_DemonDocGen.Generator:=  f_Fork;
 f_Fork.Generator := f_ExpGen;
 f_ExpGen.Generator:= f_ExtObjInserter;
 f_ExtObjInserter.Generator := f_Filter;
 f_Filter.Generator:= f_DocTypeDetector;


 // SetTo
// TddDocTypeDetector.SetTo(f_Generator);
// TExportFilter.SetTo

end;

procedure TSewerPipe.DestroyPipeBends;
begin
 FreeAndNil(f_PicFilter);
 FreeAndNil(f_EmptyTableElim);
 l3Free(f_ExtObjInserter);
 l3Free(f_StructureGenerator);
 l3Free(f_Fork);
 DictServer(Family).DelDictChangeNotifiedObj(f_Filter);
 l3Free(f_Filer);
 l3Free(f_FixFilter);
 l3Free(f_NullFilter);
 l3Free(f_Reader);
 l3Free(f_ExpGen);
 l3Free(f_DocTypeDetector);
 l3Free(f_Filter);
 if f_DemonDocGen <> nil then
  f_DemonDocGen.UnLinkListner(Self);
 l3Free(f_DemonDocGen);
 l3Free(f_HyperlinkCorrector);
 l3Free(f_ObjTopicTextFilter);
end;

procedure TSewerPipe.DoExportDictionaries;
var
 i : TdtAttribute;
 S : AnsiString;
begin
  if Dicts <> [] then
  try
    for i:= Low(TdtAttribute) to High(TdtAttribute) do
    begin
      if i in Dicts then
      begin
        S:= ConcatDirName(ExportDirectory, SysUtils.Format('%s.nsr',[GetAttrName(i)]));
       if f_Progressor <> nil then
       begin
        f_DemonDocGen.ExportDictionary(AttrID2DLType(i), S, f_Progressor.ProcessUpdate);
       end
       else
        f_DemonDocGen.ExportDictionary(AttrID2DLType(i), S, f_TotalProgressProc);
      end;
    end; { for i:= }
  except
   on E: Exception do
   begin
    Error('Ошибка экспорта словаря');
    l3System.Exception2Log(E);
   end;
  end; { try..except };
end;

procedure TSewerPipe.DoExportKeywords;
begin
  if ExportKW and (KWFileName <> '') then
  begin
   ForceDirectories(ExportDirectory);
   if f_Progressor <> nil then
   begin
    f_DemonDocGen.ExportKeywordData(ConcatDirName(ExportDirectory, KWFileName), f_Progressor.ProcessUpdate, ExportEmpty);
   end
   else
    f_DemonDocGen.ExportKeywordData(ConcatDirName(ExportDirectory, KWFileName), f_TotalProgressProc, ExportEmpty);
   end;
end;

procedure TSewerPipe.Error(const aDescription: AnsiString; aCategory: Integer = 0);
begin
 if Assigned(f_OnError) then
  f_OnError(aDescription, aCategory)
 else
  l3System.Msg2Log(aDescription);
end;

function TSewerPipe.Execute: Boolean;
var
  S: AnsiString;
  I, l_DocCount : Integer;
  l_NameFilter: TevTagsListFilter;
  l_What: Tm3DocPartSet;
begin
 Result:= False;
 if f_Aborted then
  Exit;
 f_StartProgress:= False;
 f_Running:= True;
 try
  f_TotalDone:= 0;
  CreatePipeBends;
  try
   f_DocTypeDetector.OnStartDocument:= StartDocument;
   f_Filter.ExportUnnecessaryDataNotifier:= OnUnnecessaryData;

   if ExportEditions then
    ExpandEditions;

   if (DocSab <> nil) and DocSab.IsValid then
    f_DemonDocGen.DocSab:= DocSab
   else
    Assert(False, 'Использование невалидного типа экспорта');
    //f_DemonDocGen.Diapason:= Diapason;

   f_DemonDocGen.Renum:= not InternalFormat;//True;
   f_DemonDocGen.ProcessDocs := ExportDocument;
   f_DemonDocGen.ProcessRels := ExportReferences;
   f_DemonDocGen.ProcessAnnos := ExportAnnotation;
   f_DemonDocGen.SpecialAnnotation := SpecialAnnotation;
   if (ExportDocument or ExportAnnotation or ExportReferences) and (f_DemonDocGen.DocCount <> 0) then
   begin
    // Создаем цепочку генераторов
    if SpecialAnnotation then
    begin
     l_NameFilter:= TevTagsListFilter.Create(nil);
     l_NameFilter.ExcludeTagAttrList := TevTagsListFilter.MakeAttrList(k2_typAnnoTopic, [k2_tiName]);
     f_Fork.Generator2 := l_NameFilter;
     l_NameFilter.Generator := f_ExpGen;
     f_NameWriter := TddNameWriter.Create(nil);
     f_Fork.Generator := f_NameWriter;
     f_NameWriter.Filer := SpecialFiler;
    end // SpecialAnnotation
    else
     f_Fork.Generator := f_ExpGen;
    f_Filter.OEMConvertion:= Convert2OEM;

    f_Filter.DocGenerator:= f_DemonDocGen;
    f_Filter.SpecialAnnotation := SpecialAnnotation;
    f_DocTypeDetector.Generator := f_ObjTopicTextFilter;

    if OnlyStructure then
    begin
     f_ObjTopicTextFilter.Generator:= f_StructureGenerator;
     //f_StructureGenerator.Link(Writer); пока не работает
     f_StructureGenerator.Generator:= Writer;
    end
    else
     //f_ObjTopicTextFilter.Link(Writer); пока не работает
     f_ObjTopicTextFilter.Generator:= Writer;
    f_Filter.Renum:= not InternalFormat;
    //if OnlyReferences then
    // f_Filter.Attributes := [atRelHLink];
    try
     f_TopicsList.Clear;
     l_What := [];
     if ExportDocument then
      Include(l_What, m3_dsMain);
     if ExportAnnotation then
      Include(l_What, m3_dsAnno);
     CalcWorkValue(l_What);
     f_Filer.Indicator.NeedProgressProc:= True;
     f_Filer.Indicator.OnProgressProc:= InnerTopicUpdate;
     StartProgress;
     f_DemonDocGen.Execute;
    finally
     StopProgress;
     if SpecialAnnotation then
     begin
      f_Fork.Generator := f_ExpGen;
      f_Fork.Generator2 := nil;
      l3Free(l_NameFilter);
      l3Free(f_NameWriter);
     end;
    end; { execute }
   end; // ExportDocument or ExportAnnotation
   DoExportKeywords;
   DoExportDictionaries;
  finally
   DestroyPipeBends;
  end;
 finally
  f_Running:= False;
 end;
 Result:= True;
{$IFDEF ddLog}
 l3System.Msg2Log('Экспорт завершен');
{$Endif ddLog}
end;

procedure TSewerPipe.ExpandEditions;
var
 l_Sab: ISab;
begin
 if DocSab = nil then
 begin
  Assert(False, 'Невалидный тип экспорта');
  //DocSab:= MakeSab(DocumentServer(f_Family).FileTbl, f_Diapason.List);
  //htClearResults(f_Diapason.List);
 end;
 DocSab.RecordsBykey(fID_Fld);

 DocumentServer(f_Family).FileTbl.ExpandAllEdition(DocSab);
 DocSab.ValuesOfKey(fID_Fld);
end;

procedure TSewerPipe.TopicInit;
begin
 if f_TopicNo > 0 then
  f_TopicsList.Add(f_TopicNo);
 {$IFDEF ddLog}
 l3System.Msg2Log('# %-9d (%d из %d)%s',
                 [Abs(f_TopicNo), TopicDone, f_TopicsNeedDo,
                  IfThen(f_TopicNo < 0, ' - пропущен по типу', '')]);
 {$ENDIF}
end;

procedure TSewerPipe.StartDocument(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart; MainGroup:
 ShortString);
begin
 f_TopicNo:= TopicNo;
 if f_TopicNo > 0 then
 begin
  if Assigned(f_OnNewDocument) then
   f_OnNewDocument(Sender, f_TopicNo, aDocPart, MainGroup);
 end; // f_TopicNo > 0
 TopicInit;
end;

procedure TSewerPipe.TopicSwitch(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
begin
  (f_Filer As Tm3DBFiler).PartSelector := Handle.rPart;
  f_Filer.Handle:= Handle.rID;
  if (f_Filer.Handle > 0) then
   f_Reader.Execute;
  if Assigned(f_Progressor) then
    f_Progressor.TotalTick;
end;

procedure TSewerPipe.SetFamily(aFamily: Longint);
begin
 if Family <> aFamily then
 begin
  f_Family:= aFamily;
  //DestroyPipeBends;
  //CreatePipeBends;
 end;
end;

(*
procedure TSewerPipe.SetBreakFlag(Value: Boolean);
begin
  f_DemonDocGen.BreakFlag:= Value;
end;

function TSewerPipe.GetBreakFlag: Boolean;
begin
  Result:= f_DemonDocGen.BreakFlag;
end;
*)

procedure TSewerPipe.InnerTopicUpdate(aState: Byte; aValue: Long; const aMsg:
    AnsiString);
var
 l_TempValue: Int64;
begin
 if not f_StartProgress then
  StartProgress;
{ Сюда попадаем из прогресса чтения файла.
  Если обрабатываем реальный объем (f_UseDocSize = True),
  нужно обновлять Общий прогресс при State = 1 на значение aValue,
  иначе только при State = 2 на 1 }
 if (aState = 0) and not f_UseDocSize then
 begin
  // проверить размер документа
  if aValue <= cEmptyDocSize then
  begin
   Error(Format('Отсутствует текст # %-11d', [f_TopicNo]));
   Inc(f_EmptyCount);
  end;
 end; // (aState = 0) and not f_UseDocSize

 if f_Progressor <> nil then
 begin
  f_Progressor.ProcessUpdate(aState, aValue, aMsg);
  if aState = 2 then
   f_TotalDone:= f_Progressor.TotalCur;
 end
 else
  case aState of
   0:
    begin
      f_CurSize:= aValue;
      f_CurDone:= 0;
      if f_TotalDone = 0 then
       if Assigned(f_TotalProgressProc) then    // какой-то бред на мой взгляд...
        f_TotalProgressProc(aState, f_TopicsNeedDo, 'Начало экспорта');
    end;
   1:
    begin
      f_CurDone:= aValue;
      if Assigned(f_TotalProgressProc) then
      begin
       l_TempValue := aValue+f_TotalDone;
       f_TotalProgressProc(aState, aValue+f_TotalDone, 'Экспорт...');
      end;
    end;
   2:
    begin
     Inc(f_TotalDone, f_CurSize);
     if Assigned(f_TotalProgressProc) then
     begin
      if f_UseDocSize then
      begin
       if f_TotalDone = f_TopicsNeedDo then
        f_TotalProgressProc(aState, f_TotalDone, 'Экспорт завершен')
       else
        f_TotalProgressProc(1, f_TotalDone, '')
      end
      else
       f_TotalProgressProc(1, f_TotalDone, '')
     end;
    end;
  end;
end;

function TSewerPipe.GetTotalDone: Int64;
begin
 if (f_Progressor <> nil) and (f_Progressor.TotalState <> 0) then
  Result:= f_Progressor.TotalCur
 else
  Result:= f_TotalDone;
end;

procedure TSewerPipe.MakeSingleDocSab(aDocID: TDocID; aIsExternal: Boolean);
var
 l_ISab: ISab;
 l_ValueFiller: IValueSetFiller;
 l_DocID : TDocID;
begin
 try
  l_ISab := MakeSab(DocumentServer(f_Family).FileTbl);
  if aIsExternal then
   l_DocID := LinkServer(f_Family).Renum.ConvertToRealNumber(aDocID)
  else
   l_DocID := aDocID;
  l_ValueFiller := l_ISab.MakeValueSetFiller(fID_Fld);
  try
   l_ValueFiller.AddValue(l_DocID);
  finally
   l_ValueFiller := nil;
  end;
  DocSab:= l_ISab;
 finally
  l_ISab := nil;
 end;
end;

function TSewerPipe.OnlyReferences: Boolean;
begin
 Result := (dtRelText in ExportDocTypes) and not ((dtNone in ExportDocTypes) or (dtText in ExportDocTypes));
end;

function TSewerPipe.pm_GetTopicDone: Longint;
begin
 Result := f_TopicsList.Count;
end;

procedure TSewerPipe.pm_SetAttributes(const Value: TdtAttributeSet);
begin
 f_Attributes := Value;
 if f_Filter <> nil then
  f_Filter.Attributes := f_Attributes;
end;

procedure TSewerPipe.pm_SetProgressor(const Value: TddProgressObject);
begin
 FreeAndNil(f_Progressor);
 f_Progressor := Value.Use;
end;

procedure TSewerPipe.pm_SetTotalProgressProc(const Value: Tl3ProgressProc);
begin
 f_TotalProgressProc := Value;
 // Проверить наличие f_Progressor
 CheckProgressor;
 f_Progressor.OnProgressProc:= f_TotalProgressProc;
end;

procedure TSewerPipe.StartProgress;
begin
 f_StartProgress:= True;
 if f_Progressor <> nil then
 begin
   if f_UseDocSize then
     f_Progressor.Start(f_AllTopicSize, 'Экспорт документов', f_UseDocSize)
   else
     f_Progressor.Start(CalcTotalTopicCount, 'Экспорт документов', f_UseDocSize);
 end
 else
 begin
  if Assigned(f_TotalProgressProc) then
   f_TotalProgressProc(0, f_AllTopicSize, 'Экспорт');
 end;
end;

procedure TSewerPipe.StopProgress;
begin
 if f_Progressor <> nil then
 begin
  f_Progressor.Stop
 end
 else
 if Assigned(f_TotalProgressProc) then
  f_TotalProgressProc(2, f_AllTopicSize, 'Экспорт завершен');
end;

procedure TSewerPipe.WriteSpecialName;
begin
  f_NameWriter.WriteName;
end;

constructor TddObjTopicTextDeleterFilter.Create;
begin
 inherited Create(k2_idTextPara);
end;

procedure TddObjTopicTextDeleterFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiType) and
    (Value.Kind = k2_vkInteger) then
  IsActive := (Value.AsInteger = Ord(dtObject));
 inherited; 
end;

function TSewerPipe.CalcTotalTopicCount: Int64;
var
  l_RelCount: Integer;
  l_AnnoCount: Integer;
begin
 Result := f_DemonDocGen.DocCount;
 if Result > 0 then
 begin
  l_RelCount := f_DemonDocGen.RelatedCount(l_AnnoCount);
  Result := Result + l_RelCount + l_AnnoCount;
 end;
end;

procedure TSewerPipe.NeedDeleteFileData;
begin
 if f_Listner <> nil then
  IddDocumentListner(f_Listner).NeedDeleteFileData;
end;

procedure TSewerPipe.LinkListner(const aListner: IddDocumentListner);
begin
 f_Listner := Pointer(aListner);
end;

procedure TSewerPipe.UnLinkListner(const aListner: IddDocumentListner);
begin
 f_Listner := nil;
end;

end.
