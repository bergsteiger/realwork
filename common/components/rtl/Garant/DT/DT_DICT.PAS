
unit Dt_Dict;

{ $Id: DT_DICT.PAS,v 1.440 2016/07/05 13:31:20 lukyanets Exp $ }

// $Log: DT_DICT.PAS,v $
// Revision 1.440  2016/07/05 13:31:20  lukyanets
// Cleanup
//
// Revision 1.439  2016/06/30 12:34:15  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.438  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.437  2016/06/09 15:14:58  fireton
// - кеширование образов документов
//
// Revision 1.436  2016/04/15 11:57:05  lukyanets
// Чистим протухший код
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.435  2016/04/08 11:01:23  voba
// -bf вычисление priority  для групповой операции не работало
//
// Revision 1.434  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.433  2015/11/24 14:08:24  voba
// -bf убрал конкурентную запись дерева словаря. Теперь дерево переписываем только при апдейте, в спокойной обстановке
//
// Revision 1.432  2015/11/03 09:02:40  lukyanets
// Cleanup
//
// Revision 1.431  2015/10/01 08:54:04  voba
// -k:608012012
//
// Revision 1.430  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.429  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.428  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.427  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.426  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.425  2015/04/06 09:38:46  lukyanets
// Изолируем язык базы
//
// Revision 1.424  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.423  2015/03/13 11:55:46  voba
// - локальное автосохранение документов
//
// Revision 1.422  2015/02/10 15:50:33  kostitsin
// ChangingChanged
//
// Revision 1.421  2015/02/02 18:26:54  kostitsin
// рисуем l3Nodes
//
// Revision 1.420  2015/02/02 14:15:28  kostitsin
// рисуем l3Nodes
//
// Revision 1.419  2015/01/30 13:30:45  kostitsin
// рисуем l3Nodes
//
// Revision 1.418  2015/01/28 12:06:43  kostitsin
// рисуем Tl3PrimNode
//
// Revision 1.417  2015/01/22 14:31:40  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.416  2014/09/09 05:29:05  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.415  2014/07/24 05:47:24  lulin
// - улучшаем диагностику.
//
// Revision 1.414  2014/07/21 09:26:54  lulin
// - спрямляем модель.
//
// Revision 1.413  2014/07/18 16:40:12  lulin
// - рефакторим работу с данными заданий.
//
// Revision 1.412  2014/07/11 11:20:24  lulin
// - bug fix: не падаем при запросе несуществующего элемента.
//
// Revision 1.411  2014/07/02 17:13:50  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.410  2014/07/01 11:12:15  lulin
// - удаляем "мусор".
//
// Revision 1.409  2014/07/01 10:09:29  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.408  2014/06/17 10:33:25  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.407  2014/06/09 17:27:13  lulin
// - подготавливаем "рыбу" для регистрации Action'ов.
//
// Revision 1.406  2014/06/06 14:24:39  lulin
// - чистим код.
//
// Revision 1.405  2014/06/06 14:01:19  lulin
// - чистим код.
//
// Revision 1.404  2014/06/06 13:26:15  lulin
// - чистим код.
//
// Revision 1.403  2014/06/06 13:14:11  lulin
// - чистим код.
//
// Revision 1.402  2014/06/06 11:20:17  lulin
// - чистим код.
// - исправляем ошибки.
//
// Revision 1.401  2014/05/29 16:40:13  lulin
// - переименовываем безликое свойство.
//
// Revision 1.400  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.399  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.398  2014/02/12 12:35:19  lulin
// - рефакторим списки заданий.
//
// Revision 1.397  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.396  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.395  2013/02/05 10:04:38  voba
// - замена типа у  function di_Get_Name : Tl3PCharLenPrim;
//
// Revision 1.394  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.393  2013/01/16 09:38:23  voba
// - перенес интерфейсы
//
// Revision 1.392  2012/11/14 11:04:11  fireton
// - SetNameE
//
// Revision 1.391  2012/11/01 09:42:41  lulin
// - забыл точку с запятой.
//
// Revision 1.390  2012/11/01 07:44:35  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.389  2012/11/01 07:09:22  lulin
// - вычищаем мусор.
//
// Revision 1.388  2012/10/10 10:12:26  narry
// Не пополнялись словари
//
// Revision 1.387  2012/08/20 12:52:54  voba
// - bug fix
//
// Revision 1.386  2012/07/16 11:16:15  voba
// no message
//
// Revision 1.385  2012/04/20 15:20:01  lulin
// {RequestLink:283610570}
//
// Revision 1.384  2012/03/06 13:00:34  fireton
// - Слияние с веткой B_archi_base132
//
// Revision 1.383.6.1  2012/02/13 06:24:07  fireton
// - Добавляем Flags к источникам опубликования документа
//
// Revision 1.383  2011/06/29 16:02:31  fireton
// - даём возможность редактировать ID элемента словаря при создании
//
// Revision 1.382  2011/06/21 12:37:08  dinishev
// Удалил лишний модуль.
//
// Revision 1.381  2011/05/18 18:01:05  lulin
// {RequestLink:266409354}.
//
// Revision 1.380  2011/03/23 11:59:55  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//
// Revision 1.379  2010/11/26 12:38:55  narry
// К244187411. Ошибка присвоения номера справки
//
// Revision 1.378  2010/11/23 11:42:46  voba
// - K : 242845614
//
// Revision 1.377  2010/10/04 14:08:25  fireton
// - const перед Tl3WString и Il3CString
//
// Revision 1.376  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.375  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.374  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.373  2010/03/16 11:59:05  voba
// no message
//
// Revision 1.372  2010/02/24 18:33:33  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.371  2010/02/24 11:54:50  narry
// - удаление зависимости проектов от парня
//
// Revision 1.370  2010/01/22 10:22:48  narry
// - Обновление
//
// Revision 1.369  2009/12/23 08:33:43  voba
// - bug fix : проблемы с захватом семейства (таблица ctrl)
//
// Revision 1.368  2009/10/14 11:09:14  voba
// - избавляемся от библиотеки mg
//
// Revision 1.367  2009/09/29 13:01:54  voba
// - нумерация полей для сортировки теперь начинается с 1
//
// Revision 1.366  2009/09/25 13:22:28  voba
// - add // хакерское добавление синонимов 'федеральный конституционный закон' = 'ФКЗ', 'федеральный закон' = 'ФЗ'
//
// Revision 1.365  2009/09/25 10:35:59  voba
// - [$163065584]
//
// Revision 1.364  2009/07/23 08:14:58  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.363  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.362  2009/07/20 11:22:08  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.361  2009/07/14 12:35:57  voba
// - bug fix
//
// Revision 1.360  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.359  2009/05/19 12:19:50  voba
// - сс
//
// Revision 1.358  2009/05/15 07:53:27  narry
// - AV при рассылке уведомления об изменениях элемента словаря
//
// Revision 1.357  2009/05/13 11:20:20  voba
// - убрал procedure TDictionaryServer.AddBatchToGroupDict
//
// Revision 1.356  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.355  2009/04/28 15:16:49  lulin
// - перегенерация документации и работа над ошибками за Вованом.
//
// Revision 1.354  2009/04/28 07:13:36  voba
// - interface IExtItemNode переехал в l3TreeInterfaces
//
// Revision 1.353  2009/04/23 06:49:50  fireton
// - [$145099046]. Не распредедялся ItemList.
//
// Revision 1.352  2009/04/13 09:13:18  narry
// - разделение определения типов и реализации
//
// Revision 1.351  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.350  2009/03/23 08:35:37  voba
// - bug fix procedure TDictionaryServer.CopyFromJournaledDict
//
// Revision 1.349  2009/03/19 08:44:52  voba
// - перенес процедур экспорта словарей в отдельный модуль dt_DictExport
//
// Revision 1.348  2009/03/16 09:41:47  narry
// - коррекция максимального номера элемента
//
// Revision 1.347  2009/03/13 15:56:56  narry
// - загрузка после создания только настоящих словарей
//
// Revision 1.346  2009/03/13 15:05:36  narry
// - дата удаления элемента
// - запрос полного имени элемента в виде дерева или строки
// - загрузка содержимого словаря при его создании
//
// Revision 1.345  2009/03/10 15:20:05  voba
// - enh. function TDictionary.GetFullDictItemName работа с "отрицательными" ID
//
// Revision 1.344  2009/03/04 12:37:49  voba
// - убрал из dt_Const константы HyTech
//
// Revision 1.343  2009/03/02 08:10:07  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.342  2009/02/20 13:27:58  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.341  2009/02/12 10:37:41  narry
// - сложные словари редактируются на станции
//
// Revision 1.340  2009/02/12 09:06:12  narry
// - сложные словари редактируются на станции
//
// Revision 1.339  2009/02/06 12:08:05  fireton
// - приведение в соответствие с изменениями в l3BMSearch
//
// Revision 1.338  2009/02/06 07:24:46  voba
// - add type TDictRec
//
// Revision 1.337  2009/02/05 10:21:27  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.336  2009/02/03 12:02:01  voba
// - не компилировалось
//
// Revision 1.335  2009/01/16 14:59:25  voba
// - bug fix
//
// Revision 1.334  2009/01/16 10:07:25  voba
// no message
//
// Revision 1.333  2008/12/29 10:33:08  voba
// - enh. procedure TDictionaryTbl.EditDictItem при изменении русского названия ставит звездочку в английское
//
// Revision 1.332  2008/12/18 09:53:08  voba
// - сс
//
// Revision 1.331  2008/11/25 12:51:47  narry
// - обновление
//
// Revision 1.330  2008/10/30 12:58:00  narry
// - Единый КВ
//
// Revision 1.329  2008/10/15 09:06:56  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.328  2008/10/03 11:06:38  narry
// - замена обращения к полю на обращение к свойству
//
// Revision 1.327  2008/09/29 08:13:22  fireton
// - bugfix: структуры записей не соответствовали структуре базы
//
// Revision 1.326  2008/09/26 12:35:05  voba
// - bug fix
//
// Revision 1.325  2008/09/23 12:17:54  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.324  2008/09/19 13:07:53  voba
// - cc
//
// Revision 1.323  2008/09/17 14:47:46  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.322  2008/09/16 06:40:02  narry
// - восстановление функции DelDictItem
//
// Revision 1.321  2008/09/15 09:00:04  voba
// -add function CheckExists
//
// Revision 1.320  2008/07/31 14:38:43  voba
// - enh. функции манипуляции с ExtItem
//
// Revision 1.319  2008/07/23 09:11:13  voba
// - enh. функции манипуляции с ExtItem
//
// Revision 1.318  2008/07/17 10:42:16  voba
// - enh. сокращаем количество функций редактирования словаря
//
// Revision 1.317  2008/07/15 12:48:19  voba
// - refact. перетаскивание методов в TDictionary
//
// Revision 1.316  2008/07/14 07:33:55  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.315  2008/07/10 12:30:51  voba
// - refact. перетаскивание методов в TDictionary
//
// Revision 1.314  2008/07/09 06:05:47  narry
// - исправление ошибки применения delta.kw
//
// Revision 1.313  2008/07/08 13:32:49  voba
// - поменял формат TReadDictChangeProc
//
// Revision 1.312  2008/07/07 10:50:28  voba
// - refact. перетаскивание методов в TDictionary
//
// Revision 1.311  2008/07/07 09:39:30  voba
// - refact. выделил объект для работы со словарем (TDictionary)
//
// Revision 1.310  2008/07/03 11:24:25  narry
// - промежуточное обновление Единого КВ
//
// Revision 1.309  2008/06/25 11:28:59  voba
// - add  function TDictionaryTbl.GetDeferDelInfo
//
// Revision 1.308  2008/06/24 13:51:16  narry
// - исправление ошибок
//
// Revision 1.307  2008/06/24 12:57:45  narry
// - шажок к Единому К.В.
//
// Revision 1.306  2008/06/09 10:06:11  voba
// - add debug out
//
// Revision 1.305  2008/06/07 09:53:41  voba
// - refact. TDictionaryTbl.FillListFromSab
//
// Revision 1.304  2008/05/22 13:07:38  voba
// - bug fix : error -25 при удалении элемента словаря с приемником
//
// Revision 1.303  2008/05/15 13:36:39  voba
// - bug fix
//
// Revision 1.302  2008/04/21 06:36:52  narry
// - bug fix (c) voba
//
// Revision 1.301  2008/04/18 12:07:05  fireton
// - не компилируем не-листьевые типы и источники в словарь
//
// Revision 1.300  2008/04/14 12:46:15  voba
// - enh. расширил TDLPassportRec
// - enh. IDictNode возвращает тип ноды
//
// Revision 1.299  2008/04/09 06:43:56  voba
// - add  procedure  DelDictItem
//
// Revision 1.298  2008/04/07 11:35:22  voba
// - refact.
//
// Revision 1.297  2008/04/03 07:58:21  voba
// - add удаление образа издания вместе со словарным элементом
//
// Revision 1.296  2008/03/31 06:29:10  voba
// - refact.
//
// Revision 1.295  2008/03/28 10:39:34  voba
// - ren GetRecordByUniq -> GetRecordIDByUniq
// - ren HasRecordsWith -> HasRecord
//
// Revision 1.294  2008/03/27 09:51:49  voba
// - add удаление TExtItemNode
//
// Revision 1.293  2008/03/21 14:09:26  lulin
// - cleanup.
//
// Revision 1.292  2008/03/20 09:48:35  lulin
// - cleanup.
//
// Revision 1.291  2008/02/21 16:32:51  lulin
// - cleanup.
//
// Revision 1.290  2008/02/20 17:23:03  lulin
// - упрощаем строки.
//
// Revision 1.289  2008/02/19 11:38:38  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.288  2008/02/14 09:40:39  lulin
// - удалён ненужный класс.
//
// Revision 1.287  2008/02/13 16:03:08  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.286  2008/02/07 14:44:40  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.285  2008/02/06 15:37:05  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.284  2008/02/05 18:55:09  lulin
// - запрещаем напрямую устанавливать буфер строке.
//
// Revision 1.283  2008/02/05 09:58:05  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.282  2008/02/04 12:32:22  voba
// - remove procedure VerifyDict (see procedure VerifyLink in dt_link)
//
// Revision 1.281  2008/02/01 17:00:28  lulin
// - используем кошерные потоки.
//
// Revision 1.280  2008/02/01 16:41:33  lulin
// - используем кошерные потоки.
//
// Revision 1.279  2008/02/01 15:14:48  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.278  2008/01/22 13:32:20  voba
// - refact TDictionaryServer.VerifyDict(
//
// Revision 1.277  2007/12/24 15:25:28  lulin
// - удалены ненужные файлы.
//
// Revision 1.276  2007/12/21 11:17:09  voba
// no message
//
// Revision 1.275  2007/12/19 12:59:32  fireton
// - Ok теперь локальная переменная (l_Ok)
//
// Revision 1.274  2007/12/11 12:02:56  voba
// - bug fix
//
// Revision 1.273  2007/12/06 11:12:51  narry
// - замена Integer на TDictID
//
// Revision 1.272  2007/11/30 09:06:17  voba
// - расширил синтаксис TDictionaryServer.DelExtItemFromTbl
//
// Revision 1.271  2007/11/26 10:08:30  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.270  2007/11/22 10:31:55  narry
// - ошибка экспорта обазов пустой выборки
// - неполный список документов для Прайма
// - фильтр экспорта закладок
//
// Revision 1.269  2007/11/21 08:35:09  voba
// - use gExtDictItemRecArr
//
// Revision 1.268  2007/11/16 12:25:55  voba
// - cc
//
// Revision 1.267  2007/11/16 08:10:53  narry
// - Оптимизация вывода сообщения об ошибке
//
// Revision 1.266  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.265  2007/10/02 11:14:07  narry
// - не работает импорт с пополнением словарей
//
// Revision 1.264  2007/09/07 13:24:37  lulin
// - удален ненужный параметр.
//
// Revision 1.263  2007/08/28 13:54:18  voba
// - update to 128 DB version
//
// Revision 1.262  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.261  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.260  2007/08/14 14:30:07  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.259.2.1  2007/07/26 12:20:40  voba
// - перевел procedure TDictionaryTbl.GetIndexDictList на ISab (!!Эта функция используется только в DT_user)
//
// Revision 1.259  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.258  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.257  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.256  2007/05/14 12:43:36  voba
// - bug fix
//
// Revision 1.255  2007/05/14 06:34:34  narry
// - если не задано длинное имя, но есть короткое, короткое испульзуется как длинное
//
// Revision 1.254  2007/04/26 10:56:50  fireton
// - Рефакторинг DT. Таблица DICTSRC больше не нужна.
//
// Revision 1.253  2007/04/26 10:26:49  fireton
// - Рефакторинг DT. Имена словарей переехали в cDLPassports.
//
// Revision 1.252  2007/04/26 10:01:43  fireton
// - Рефакторинг DT. Переход DT_Link и DT_Dict от таблиц к типам словарей.
//
// Revision 1.251  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.250  2007/04/17 11:36:40  fireton
// - AdornNodeName (украшаем имя из словаря при загрузке саба)
//  это нужно для добавления имени региона...
//
// Revision 1.249  2007/04/17 06:46:33  voba
// - bug fix
//
// Revision 1.248  2007/04/10 14:06:36  narry
// - в Источники опубликования добавлялся мнимый элемент
//
// Revision 1.247  2007/04/10 11:01:01  voba
// - cc
//
// Revision 1.246  2007/04/09 11:41:38  fireton
// - максимально возможный размер имени таблицы - 8 символов (а не 5)
//
// Revision 1.245  2007/03/30 08:06:40  voba
// - bug fix
//
// Revision 1.244  2007/03/29 10:07:51  voba
// - bug fix
//
// Revision 1.243  2007/03/15 12:28:05  voba
// - merge with b_archi_BigDictID
//
// Revision 1.242  2007/03/06 14:50:22  fireton
// + TPublishedUniqueKeyRec
//
// Revision 1.241  2007/03/02 10:09:40  voba
// - bug fix htSubSearch Bug
//
// Revision 1.240  2007/02/22 09:21:50  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.239  2007/02/16 16:12:39  voba
// - rename type Condition ->ThtCondition
// - bugfix
//
// Revision 1.238  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.237  2007/01/30 15:34:10  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.236  2007/01/19 14:03:01  voba
// - use procedure TDictionaryServer.VerifyDict
//
// Revision 1.235  2007/01/09 10:15:45  voba
// - new beh. TDictEqualNode строка теперь хранится
//
// Revision 1.234  2006/12/25 12:21:48  lulin
// - параметры строки теперь получаем одним вызовом, а не тремя.
//
// Revision 1.233  2006/12/25 08:07:13  voba
// - bug fix
//
// Revision 1.232  2006/12/13 15:44:09  voba
// - cc
//
// Revision 1.231  2006/12/08 15:24:16  voba
// - add IExtItemNode
//
// Revision 1.230  2006/11/21 12:35:35  voba
// - cc IDictItem
// - add TCustomExtItemNode
//
// Revision 1.229  2006/11/07 16:13:38  voba
// - cc
//
// Revision 1.228  2006/10/13 10:15:44  voba
// - add procedure ExportAllDictionary(const aDir : TFileName);
//
// Revision 1.227  2006/10/11 11:57:48  voba
// - bug fix
//
// Revision 1.226  2006/10/09 12:11:18  voba
// - procedure TDictionaryServer.CopyFromJournaledDict
//                - эквивалентные переходят к элементу-приемнику
//                - ускорилась перекодировка линк-таблицы
//
// Revision 1.225  2006/10/04 08:29:27  voba
// - merge with b_archi_ht64
//
// Revision 1.224  2006/09/14 08:11:29  narry
// - борьба с бесконечным циклом обработки сообщений
//
// Revision 1.223.2.1  2006/09/19 07:36:41  voba
// - переход на HTStub
//
// Revision 1.223  2006/08/30 08:31:36  narry
// - ловушка для обнуления поля
//
// Revision 1.222  2006/07/28 12:31:38  narry
// - контроль правильности поля
//
// Revision 1.221  2006/06/14 12:24:54  narry
// - новое: переход на новый механизм рассылки нотификаций
//
// Revision 1.220  2006/06/08 15:54:45  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.219.2.1  2006/06/08 08:52:12  fireton
// - перевод User ID на Longword
//
// Revision 1.219  2006/06/06 08:52:32  narry
// - новое: перевод на новый механизм рассылки нотификаций
//
// Revision 1.218  2006/04/25 12:18:39  lulin
// - cleanup.
//
// Revision 1.217  2006/04/25 11:40:24  lulin
// - cleanup.
//
// Revision 1.216  2006/04/20 13:52:39  voba
// -  change in Tl3_CustomString - вместо pm_GetSt теперь перекрываем DoGetSt
//
// Revision 1.215  2006/04/17 13:07:13  voba
// - refactoring
// - add
//   procedure  SaveDict(aDict : TdaDictionaryType);
//   procedure  SaveAllDicts;
//
// Revision 1.214.2.2  2006/04/20 13:49:23  voba
// -  change in Tl3_CustomString - вместо pm_GetSt теперь перекрываем DoGetSt
//
// Revision 1.214.2.1  2006/04/17 13:46:26  voba
// - merge
//
// Revision 1.215  2006/04/17 13:07:13  voba
// - refactoring
// - add
//   procedure  SaveDict(aDict : TdaDictionaryType);
//   procedure  SaveAllDicts;
//
// Revision 1.214  2006/04/12 14:24:29  voba
// - add procedure  ReloadDict(aDict : TdaDictionaryType);
//
// Revision 1.213  2006/03/27 12:39:09  fireton
// - change: при компиляции словаря типов вычисляются и добавляются синонимы (то, что в скобках)
// - чистка кода
//
// Revision 1.212  2005/11/21 09:37:11  voba
// - add  param to procedure _Changed(const anOp: Il3OpPack = nil)
//
// Revision 1.211  2005/10/21 11:29:01  voba
// - Procedure DelDictItemFromTbls param NewID теперь  по-умолчанию
//
// Revision 1.210  2005/10/20 11:27:33  step
// убран вызов отладочной процедуры LogDeletion
//
// Revision 1.209  2005/10/18 12:33:23  step
// в GetPublishData добавлена сортировка по SourceId
//
// Revision 1.208  2005/10/18 11:56:22  step
// исправления, связанные с добавлением в табл. DT#A поля Nonperiod
//
// Revision 1.207  2005/10/17 12:55:35  step
// изменена TDictionaryServer.GetPublishData (учтено новое поле Nonperiod)
//
// Revision 1.206  2005/10/14 12:03:55  step
// new: TDictionaryServer.IdByShortNameInAccGroupsTable (по просьбе Гарри)
//
// Revision 1.205  2005/09/29 11:06:05  voba
// - bug fix эквивалентные не отдают IDictItem
//
// Revision 1.204  2005/09/05 14:14:43  voba
// - change Il3HandleNode больше не наследник Il3Node
//
// Revision 1.203  2005/07/18 11:36:46  step
// new: TDictionaryTbl.HasRecordWithName
//
// Revision 1.202  2005/06/27 14:22:36  step
// опубликована IdByFullPath
//
// Revision 1.201  2005/06/24 13:18:27  step
// добавлен параметр aLevelSlash (там, где aFullPath)
//
// Revision 1.200  2005/06/24 12:20:25  step
// добавлен параметр в TDictionaryServer.NodeByFullPath
//
// Revision 1.199  2005/06/21 15:58:40  step
// TDictionaryServer получил несколько перегруженных методов (с параметром aFullPath: PAnsiChar вместо aID: LongInt). По настоятельной просьбе Гарри.
//
// Revision 1.198  2005/06/08 17:31:23  step
// TDictionaryServer.DelDictItemFromTbls теперь может работать и с CorSources
//
// Revision 1.197  2005/02/15 13:11:40  step
// new: TDictionaryServer.GetNearestEqualsFor
//
// Revision 1.196  2005/02/03 14:34:21  step
// добавлен временный код для ловли факта удаления в табл. DT#B
//
// Revision 1.195  2004/12/23 11:42:13  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.194  2004/11/30 10:34:43  lulin
// no message
//
// Revision 1.193  2004/10/28 14:05:12  narry
// - update
//
// Revision 1.192  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.191  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.190  2004/09/02 15:23:20  voba
// - поправлены процедуры индикации.
//
// Revision 1.189  2004/08/30 14:04:51  law
// - new method: Im4DB.CompileDictionary.
//
// Revision 1.188  2004/08/27 15:13:34  voba
// - merge with B_New_Text_Base
//
// Revision 1.187.2.1  2004/08/25 16:36:31  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.187  2004/08/18 08:32:17  voba
// - code format
//
// Revision 1.186  2004/08/18 08:21:39  step
// новый виртуальный метод TDictItem.SetData
//
// Revision 1.185  2004/08/03 08:52:47  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.184  2004/07/20 13:46:40  step
// виртуальная функция TDictionaryTbl.GetOffset замена на локальную PosInTmpRec
//
// Revision 1.183  2004/07/13 08:02:34  step
// слияние с веткой b_import_filter_optimization2
//
// Revision 1.182.2.2  2004/07/12 17:01:56  step
// оптимизация: уменьшение "фрагментации" интервалов в табл. FREE
//
// Revision 1.182.2.1  2004/07/08 17:16:52  step
// TNumSet перенесен из Dt_Free в отдельный модуль
//
// Revision 1.182  2004/07/05 14:53:06  voba
// - remove {$Define DeleteBugCatcher}
//
// Revision 1.181  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.180  2004/06/18 17:46:35  voba
// - add {$Define DeleteBugCatcher}  // попытка выловить нечто, удаляющее элементы словаря без спроса (ask Voba)
//
// Revision 1.179.2.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.179  2004/06/16 13:15:08  step
// в TDictionaryServer.SendEditMessage добавлена проверка типа словаря
//
// Revision 1.178  2004/06/10 11:23:40  law
// - свойство Tl3CustomString.Len сделано статическим.
//
// Revision 1.177  2004/06/03 11:31:14  step
// change: TDictionaryServer.AddBatchToGroupDict
//
// Revision 1.176  2004/06/02 18:10:22  step
// change: fn_AddBatchToGroupDict
//
// Revision 1.175  2004/06/02 08:45:45  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.174  2004/06/01 18:24:17  step
// изменена TDictionaryServer.AddBatchToGroupDict - использование TNumSet
//
// Revision 1.173  2004/06/01 15:17:59  law
// - удалены конструкторы Tl3VList.MakeLongint, MakeLongintSorted - пользуйтесь _Tl3LongintList.
// - подчистил Archi, за сегодняшними переделками Димона.
//
// Revision 1.172  2004/05/28 18:49:27  step
// new: TDictionaryServer.AddBatchToGroupDict
//
// Revision 1.171  2004/05/28 11:06:27  law
// - change: наследуемся от гарантированно некешируемого класса.
//
// Revision 1.170  2004/05/27 14:32:07  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.169  2004/05/26 10:34:21  step
// убрано лишнее поле fFamily (дублирует поле TblFamily предка)
//
// Revision 1.168  2004/05/21 14:27:35  fireton
// - change: слегка отформатирован код
//
// Revision 1.167  2004/05/18 09:09:33  step
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath()
//
// Revision 1.166  2004/05/13 16:32:18  step
// замена: "TFreeTbl.Create ..." --> "GlobalHtServer.FreeTbl[...]"
//
// Revision 1.165  2004/05/13 13:59:58  step
// замена GlobalHtServer.StartTransactionWithWait на GlobalHtServer.StartTransaction
//
// Revision 1.164  2004/05/06 09:15:51  voba
// merge with adding_diapasons_table_free2
//
// Revision 1.163  2004/04/27 09:25:06  voba
// -rename nfWasDeleted to  nfWasDisappear
//
// Revision 1.162.4.1  2004/04/13 14:19:09  step
// Изменена TFreeTbl.ResetFreeTblNum
//
// Revision 1.162  2004/04/08 08:53:37  step
// Исправлена запись в лог
//
// Revision 1.161  2004/04/08 08:26:32  step
// Добавлена запись в лог
//
// Revision 1.160  2004/04/08 08:19:02  step
// Изменена обработка ошибки
//
// Revision 1.159  2004/03/26 14:09:41  voba
// no message
//
// Revision 1.158.2.2  2004/03/22 12:37:32  step
// Еще некоторые исправления, связанные с добавлением поля DT#A.PRIVATE
//
// Revision 1.158.2.1  2004/03/19 17:11:56  step
// Исправления, связанные с добавлением поля DT#A.PRIVATE
//
// Revision 1.158  2004/03/05 16:52:23  step
// чистка кода
//
// Revision 1.157  2004/03/03 18:22:21  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.156  2004/02/27 11:16:37  voba
// no message
//
// Revision 1.155  2004/02/27 10:30:55  voba
// - merge with adding_field_shname
//
// Revision 1.154  2004/02/26 16:03:59  step
// изменена TPublishedDictRec (добавлено поле Comment)
//
// Revision 1.153  2004/02/19 13:13:09  voba
// no message
//
// Revision 1.152.2.6  2004/02/26 16:14:00  voba
// no message
//
// Revision 1.152.2.5  2004/02/26 12:22:08  step
// добавлен перегруженный TDictionaryServer.GetPublishData
//
// Revision 1.152.2.4  2004/02/24 14:58:41  step
// исправлена TDictionaryServer.DictRecords
//
// Revision 1.152.2.3  2004/02/24 13:50:43  step
// исправлена TDictionaryServer.GetPublishData
//
// Revision 1.152.2.2  2004/02/20 12:06:44  step
// bug fix
//
// Revision 1.152.2.1  2004/02/10 11:20:14  step
// add: function TDictionaryServer.DictRecords
//
// Revision 1.154  2004/02/26 16:03:59  step
// изменена TPublishedDictRec (добавлено поле Comment)
//
// Revision 1.153  2004/02/19 13:13:09  voba
// no message
//
// Revision 1.152  2004/02/03 09:07:06  step
// В таблицу DT#B возвращено поле Coment
//
// Revision 1.151  2004/01/30 18:30:39  step
// add: piUniqKeyNum
//
// Revision 1.150  2004/01/28 20:17:55  step
// в THandledRecordTbl.EditData добавлена проверка НЕОБХОДИМОСТИ записи в БД
//
// Revision 1.149  2004/01/27 10:30:47  step
// add: TDictionaryServer.DataOfDictRec
//
// Revision 1.148  2004/01/26 17:01:04  step
// Исправлена TPublishedDictRec
//
// Revision 1.147  2004/01/23 14:39:40  step
// bug fix
//
// Revision 1.146  2004/01/23 13:34:57  voba
// -new feature: в AddDictFullDataNode параметр aID стал var
//
// Revision 1.145  2004/01/21 12:38:51  step
// Изменена THandledRecordTbl.AddData
//
// Revision 1.144  2004/01/21 11:12:16  voba
// -new feature: в AddDictFullDataNode сделал последний параметр необязательным
//
// Revision 1.143  2004/01/16 12:43:09  step
// изменен интерфейс TDictionaryServer.FilteredAsDataList
//
// Revision 1.142  2004/01/15 18:09:59  step
// Добавлена сортировка к TDictionaryServer.FilteredAsDataList
//
// Revision 1.141  2004/01/15 13:00:18  step
// добавлен модификатор const к параметрам типа AnsiString
//
// Revision 1.140  2004/01/14 17:22:18  step
// add: TDictionaryServer.FilteredAsDataList, TDictionaryServer.ValueByUniqKey
//
// Revision 1.139  2004/01/13 16:42:04  step
// Добавлено property TDictionaryServer.Tbl
//
// Revision 1.138  2004/01/09 15:05:22  step
// Изменена TPublishedDictRec
//
// Revision 1.137  2004/01/08 10:07:52  voba
// - refactoring : убил AllocCopyPChar
//
// Revision 1.136  2003/12/25 15:12:35  fireton
// - bugfix: сохранение значения NeedAllocStr в FillListFromSab
//
// Revision 1.135  2003/12/24 16:04:15  voba
// no message
//
// Revision 1.134  2003/12/19 12:14:43  narry
// - change: замена работы с TiniFile на TCfgList
//
// Revision 1.133  2003/12/18 08:39:11  step
// speed optimization
//
// Revision 1.132  2003/12/11 13:28:16  voba
// - change: все упоминания ChildsCount заменены AllChildrenCount
//
// Revision 1.131  2003/12/05 16:57:49  voba
// - add procedure GetFullDictItemName
//
// Revision 1.130  2003/11/28 14:09:37  fireton
// update: исключения при компиляции словарей (CompileDictionary) читаются теперь из base.ini
//
// Revision 1.129  2003/11/28 12:43:29  fireton
// update: компиляция словарей теперь происходит по дереву с исключением ненужных веток
//
// Revision 1.128  2003/11/25 14:34:58  voba
// - improvement: ExportDictTree
//
// Revision 1.127  2003/09/22 13:57:08  voba
// - bug fix: СopyToJournaledDict и CopyFromJournaledDict не работали если словари были ранее открыты
//
// Revision 1.126  2003/09/09 13:51:16  step
// В TDictionaryServer.CopyFromJournaledDict добавлена запись в лог.
//
// Revision 1.125  2003/09/04 17:30:09  step
// Переопределен метод TDictionaryTbl.GetOffset и изменена TDictionaryTbl._GetItemList (для использования этого GetOffset)
//
// Revision 1.124  2003/09/03 08:59:44  step
// Установка свойства TDictionaryTbl.NameFld перенесена из TTreeDesignerForm.Create в TDictionaryServer.GetDictTbl
//
// Revision 1.123  2003/09/02 11:11:01  step
// Добавлено св-во  DictServer.Bilingual
//
// Revision 1.122  2003/09/02 09:27:15  step
// Добавлено переключение русс. - англ. язык
//
// Revision 1.121  2003/08/29 12:45:58  step
// Исправлена TDictionaryTbl._GetItemList (учтено изменение структуры записи из-за добавленного NameEFld)
//
// Revision 1.120  2003/08/22 17:11:11  step
// Исправление словарей в рез-те добавления поля NameE
//
// Revision 1.119  2003/08/22 07:17:35  step
// В словари добавлено поле NameE и удалено поле NameLen
//
// Revision 1.118  2003/08/19 18:06:37  step
// В словари добавлено поле NameE и удалено поле NameLen
//
// Revision 1.117  2003/07/17 15:26:42  voba
// - bug fix: "насрали" в память. в StringDataList с размером данных Word клали данные размером в LongInt
//
// Revision 1.116  2003/06/03 15:26:04  voba
// - rename Tl3StringDataList AddData to Add
//
// Revision 1.115  2003/05/19 15:40:12  demon
// - new behavior: Теперь можно мапировать атрибут не только на аналогичный словарь другого семейства,
// но и на другой словарь (как другого, так и своего семейства)
//
// Revision 1.114  2003/04/29 15:51:03  voba
// no message
//
// Revision 1.113  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.112  2003/01/24 15:28:07  narry
// - bug fix
//
// Revision 1.111  2003/01/23 16:38:42  demon
// - new: добавил операцию FindRec в объект THandledRecordTbl
//
// Revision 1.110  2003/01/21 17:19:42  demon
// - new behavior: добавлена операция для проверки наличия
// элемента словаря в листе.
//
// Revision 1.109  2003/01/17 14:13:08  demon
// - new behavior: изменен принцип нотификации об изменении словарей.
// Теперь все централизовано и сообщение получает только DictServer, а все кому нужна дополнительная
// нотификация должны зарегистрироваться на нем.
//
// Revision 1.108  2002/12/24 13:02:00  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.107.2.1  2002/12/24 11:56:43  law
// - new behavior: используем 64-битный Seek вместо 32-битного.
//
// Revision 1.107  2002/11/14 16:57:21  voba
// - new behavior: в TParamGroupTbl.GetItemsOnKeyValue добавил опциональный параметр поиска (HT_Const.Condition)
//
// Revision 1.106  2002/10/29 13:48:51  demon
// - add special function for Class-Prefix statistic
//
// Revision 1.105  2002/09/11 14:59:52  voba
// -add TODO
//
// Revision 1.104  2002/09/11 14:52:21  voba
// -small improve : предотвращение поднятия Exception в случае отсутствия записи о пользователе
//
// Revision 1.103  2002/07/29 12:19:29  voba
// - new param: TDictEqualNode.Delete anOpProc.
//
// Revision 1.102  2002/07/16 08:49:40  voba
// -bug fix: поправлена структура TNewClassDictRec
//
// Revision 1.101  2002/07/10 12:10:18  demon
// - add tree notification when its items _changed
//
// Revision 1.100  2002/07/10 11:21:04  demon
// - bug fix
//
// Revision 1.99  2002/07/10 10:54:23  demon
// - add notification in editing Journal Dict fields
//
// Revision 1.98  2002/07/10 07:58:28  demon
// - bug fix
//
// Revision 1.97  2002/07/10 07:48:46  demon
// - bug fix (recieve edit and add messages in Journaled Dicts)
//
// Revision 1.96  2002/07/02 14:32:27  voba
// - bug fix : DelDictItemFromTbls с пустым знакнием NewID не работала
//
// Revision 1.95  2002/07/02 08:54:48  demon
// - add renuming of deleted items, when coping from Journal dict to Normal
//
// Revision 1.94  2002/07/01 14:04:54  demon
// - bug fix and some checking added
//
// Revision 1.93  2002/07/01 13:44:06  demon
// - bug fix and some checking added
//
// Revision 1.92  2002/07/01 12:31:00  demon
// - add changing of newID in Deleting operation in Journaled Dicts recurcivly
//
// Revision 1.91  2002/07/01 08:56:14  demon
// - new behavior: add newID (for deleted Items) field to the Journaled dictions
//
// Revision 1.90  2002/05/29 12:42:13  voba
// -bug fix: поле комментариев писалось не туда куда надо
//
// Revision 1.89  2002/05/23 07:52:50  voba
// - bug fix: обламавалась процедура удаления элемента словаря, если это *потерянный элемент*
//
// Revision 1.88  2002/04/16 12:15:25  voba
// -bug fix : подправил FindTreeNodeByID, а то она падала на вставленных эквивалентных
//
// Revision 1.87  2002/04/15 12:17:00  demon
// - add Free Tbl in all massive transaction.
//
// Revision 1.86  2002/04/03 13:58:56  demon
// - bug fix in reading deleting Dicts records
//
// Revision 1.85  2002/04/03 12:40:18  demon
// - bug fix
//
// Revision 1.84  2002/04/03 11:37:57  demon
// - bug fix
//
// Revision 1.83  2002/04/03 09:26:09  demon
// - new behavior: modify procedures CopyTo and CopyFrom JornaledDict
//
// Revision 1.82  2002/04/02 14:32:37  demon
// - bug fix: add refresh options of Item list
//
// Revision 1.81  2002/04/02 14:18:02  voba
// - bug fix
//
// Revision 1.80  2002/04/02 12:17:22  demon
// - new behavior: add methods for copyTo and copyFrom JournaledDicts
//
// Revision 1.79  2002/03/29 14:11:20  demon
// - new behavior: add procedure AddEqualNode to TDictionaryServer
//
// Revision 1.78  2002/03/29 12:17:17  demon
// - new behavior: add property HasEqualNodes to TDictRootNode. Set it to true for load equal nodes.
//
// Revision 1.77  2002/03/29 09:43:12  voba
// - bug fix
//
// Revision 1.76  2002/03/19 15:29:16  demon
// - bug fix
//
// Revision 1.75  2002/03/19 14:57:18  demon
// - bug fix
//
// Revision 1.74  2002/03/19 14:55:57  demon
// - new behavior: now Equal nodes display full name
//
// Revision 1.73  2002/03/19 12:17:42  voba
// - bug fix
//
// Revision 1.72  2002/03/18 15:32:08  demon
// - fix export tree (add filtering equals and deleted)
//
// Revision 1.71  2002/03/15 14:56:15  demon
// - new behavior: exportDictTree now has additional options
//
// Revision 1.70  2002/03/15 09:40:29  demon
// - new behavior: new flags in export _dictionary tree in NSRC (withCommand, withEquals)
//
// Revision 1.69  2002/03/14 17:08:54  voba
// -bug fix
//
// Revision 1.68  2002/03/14 16:23:27  demon
// - bug fix
//
// Revision 1.67  2002/03/14 16:14:51  demon
// - bug fix
//
// Revision 1.66  2002/03/14 14:35:06  demon
// -bug fix
//
// Revision 1.65  2002/03/14 14:18:53  demon
// - new behavior: all working with tbls in TDictLeafNodeWithJournal now inside object
//
// Revision 1.64  2002/03/13 15:42:35  demon
// - new behavior: add LoadEqualClassesToTree procedure
//
// Revision 1.63  2002/03/13 10:32:29  demon
// - new behavior: add IPersistentNode for saving only this type of nodes
//
// Revision 1.62  2002/03/12 17:01:58  demon
// - bug fix
//
// Revision 1.61  2002/03/12 15:27:54  demon
// - bug fix
//
// Revision 1.60  2002/03/12 15:18:52  demon
// - spellchecking
//
// Revision 1.59  2002/03/12 14:33:30  demon
// - new class: new JournaledDidtItem and his node
//
// Revision 1.58  2002/03/12 09:48:19  demon
// - add new dittion (type = dlNewClasses)
//
// Revision 1.57  2002/02/26 16:33:45  voba
// -bug fix : в словарь прописывалась избыточная длина строки айтема
//
// Revision 1.56  2002/02/08 17:13:25  voba
// no message
//
// Revision 1.55  2002/02/08 17:09:56  voba
// no message
//
// Revision 1.54  2002/01/10 14:14:49  voba
// -lib sincro: replace l3GetStrLen to l3StrLen
//
// Revision 1.53  2001/11/21 12:50:31  demon
// - new: add new doc attribute - _dictionary #F (dlAccGroups)
//
// Revision 1.52  2001/09/27 08:03:28  demon
// - new: add procedures for unoficial tree repairing
//
// Revision 1.51  2001/09/24 16:26:08  demon
// - new behavior: when load tree now may check lost items
//
// Revision 1.50  2001/09/04 13:59:09  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.49  2001/07/06 14:38:14  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.48  2001/01/11 10:59:56  demon
// fix some Delphi Warnings
//
// Revision 1.47  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{ TODO : Словарь пользователей не обновляется на запущенных копиях. Если завести нового пользователя остальные до след. перезагрузки его не видят }

{$I DtDefine.inc}

interface

Uses
 Classes, Windows, SysUtils,
 l3Types, l3Base,
 l3Nodes, l3DatLst, l3IniFile, l3Date, l3Interfaces,
 l3TreeInterfaces, l3Tree_TLB,
 l3ObjectRefList,
 l3LongintList,
 l3FieldSortRecList,
 l3BaseWithIDList,

 m4DictScanner,

 daTypes,
 daSchemeConsts,

 //mgCPQStr,
 HT_Const,
 Dt_Types, Dt_Const,
 dt_DictIntf,
 dt_AttrSchema,
 dtIntf,
 DT_Table, DT_Sab,
 Dt_ATbl, Dt_Equal, Dt_DictTree,
 dtCustomDictItem,
 dtDictItems, dt_DictTypes, dt_DictConst,

 vConst,
 csClient, csDataPipe, csNotification, csMessageManager, csServerTaskTypes

 ,
 DictEditQueryList
 ;


Type
 TOnBeforeDeleteRecord = procedure(aTable : TdtTable; aRecID : Longint) of object;

 // TCustomDictTbl
 //     THandledRecordTblwithLog
 //         TParamGroupTbl
 //     TDictionaryTbl

 // TCustomDictItem
 //     TDictItem
 //         TJournaledDictItem

 // Tl3HandleNode
 //     TDictAbsNode
 //         TDictRootNode
 //         TDictLeafNode
 //              TDictLeafNodeWithJournal
 //     TCustomExtItemNode
 //         TExtItemNode
 //         TDictEqualNode

 TCustomDictTbl = Class(TPrometTbl)
  protected
   fDictType    : TdaDictionaryType;
   fBeforeDelete : TOnBeforeDeleteRecord;
   function    GetIDSize : Word;
   function    GetDataSize : Word;
   function    MaxIdValue: LongWord;
  public
   constructor Create(aFamily    : TdaFamilyID;
                      aType      : TdaDictionaryType;
                      aTable: Integer = 0); reintroduce; virtual;

   procedure   DropTblData; override;

   procedure   GetFullList(aFList : Tl3DataList);
   procedure   GetFullListOnSAB(Values : SAB;aFList : Tl3CustomDataList; const aSortOrder : TSortRec);

   function    GetFullInfo(aID : TDictID;WithHold : Boolean) : LongInt; // Возвращает Абсолютный Номер записи,
                                                                        // а тело помещает в fFullRecord
   function    CheckExists(aDictID : TDictID) : Boolean; virtual;
   function    GetData(aID : TDictID;aData : PAnsiChar;aLen : Word) : Word;
   procedure   AddData(var theID : TDictID;aData : PAnsiChar); virtual;
   procedure   EditData(aID : TDictID;aData : PAnsiChar); virtual;
   procedure   DelData(aID : TDictID); virtual;

   function    GetFullSabOnValues(Values : SAB) : Sab;

   function    GetMaxID : TDictID;
   function    GetMinIDinSab(Values : SAB;Fld : Word) : TDictID;
   procedure   DeleteItems(aIDs : Sab);

   property    IDSize : Word read GetIDSize;
   property    DataSize : Word read GetDataSize;
   property    BeforeDelete : TOnBeforeDeleteRecord read fBeforeDelete write fBeforeDelete;
   property    DictType : TdaDictionaryType read fDictType;
 end;

 THandledRecordTblwithLog = Class(TCustomDictTbl)
  public
   procedure   AddData(var theID : TDictID;aData : PAnsiChar); override;
   procedure   EditData(aID : TDictID;aData : PAnsiChar); override;
   procedure   DelData(aID : TDictID); override;
 end;

 TParamGroupTbl = Class(THandledRecordTblwithLog)
  public
   procedure   GetItemsOnKeyValue(var theItems : SAB;aValue : Pointer;
                                  aFld : Word; {WithRefresh : Boolean;}
                                  aCondition : ThtCondition = EQUAL);
 end;

 TDictionaryTbl = class;

 TCustomDictItem = class(TdtCustomDictItem)
  protected
(*   function Compare(const aCompareData : Tl3CompareData;
                    aSortIndex : Tl3SortIndex = l3_siNative) : Long; override;*)
 end;

 TDictItem = class(TCustomDictItem, IDictItem, IDictItemPro)
  protected
   fLinkNode : Pointer;
   fDataStr  : AnsiString;
   fHandle   : TDictID;
   fLinkFlag : Boolean;

   procedure DoChanging; override;
   procedure DoChanged; override;

   function  Get_Handle : TDictID; override;
   procedure Set_Handle(aValue : TDictID); override;

   function  IDictItem.di_Get_Handle = Get_Handle;

   function  di_Get_Name : Tl3PCharLenPrim;

   function  dip_Get_LinkNode : Il3Node;
   procedure dip_Set_LinkNode(const Value : Il3Node);
   function  dip_RefCount : Longint;
   procedure dip_LinkDisconnect;

  public
   procedure SetData(aData: PAnsiChar; aTable: TDictionaryTbl); virtual;

   procedure DeleteEx(aHeirID : TDictID = cUndefDictID); virtual;
    {- Удаление ноды и словарного элемента связанного с ней}

   property LinkNode : Il3Node read dip_Get_LinkNode write dip_Set_LinkNode;
 end;

 TDictItemClass = class of TDictItem;

 IDictItemJour = interface(IDictItem)
     ['{19CD8D13-6E1A-4BEB-B7B2-B48A5D2625A2}']
  function  dij_Get_Operation : TOperActionType;
  procedure dij_Set_Operation(aVal : TOperActionType);
  function  dij_Get_NewID : TDictID;
  procedure dij_Set_NewID(aVal : TDictID);
  function  dij_Get_Comment : AnsiString;
  procedure dij_Set_Comment(aVal : AnsiString);

  property Operation : TOperActionType read dij_Get_Operation write dij_Set_Operation;
  property NewID : TDictID read dij_Get_NewID write dij_Set_NewID;
  property Comment : AnsiString read dij_Get_Comment write dij_Set_Comment;
 end;

 TJournaledDictItem = Class(TDictItem,IDictItemJour)
  protected
   fOperation : TOperActionType;
   fNewID     : TDictID;
   fComment   : AnsiString;

   function  IDictItemJour.di_Get_Handle = Get_Handle;
   function  dij_Get_Operation : TOperActionType;
   procedure dij_Set_Operation(aVal : TOperActionType);
   function  dij_Get_NewID : TDictID;
   procedure dij_Set_NewID(aVal : TDictID);
   function  dij_Get_Comment : AnsiString;
   procedure dij_Set_Comment(aVal : AnsiString);
  public
   procedure SetData(aData: PAnsiChar; aTable: TDictionaryTbl); override;
   property Operation : TOperActionType read dij_Get_Operation write dij_Set_Operation;
   property NewID : TDictID read dij_Get_NewID write dij_Set_NewID;
   property Comment : AnsiString read dij_Get_Comment write dij_Set_Comment;
 end;

 TDictionaryTbl = Class(THandledRecordTblwithLog)
  private
   fNameFld       : ThtField;
   fOpenFldArr    : Array[1..2] of SmallInt;
  protected
   fDictItemClass : TDictItemClass;
   fItemList      : TdtDictItems;
   fNeedLoadItemList : boolean;

   function    AdornNodeName(anID: Longword; const aName: AnsiString): AnsiString; virtual;
   procedure   DropTblData; override;

   procedure   SetNameFld(aValue : SmallInt);
   procedure   setDictItemClass(aVal : TDictItemClass);

   function    SortByName(CurSab : LPSAB) : Sab;
   procedure   FillListFromSab(aSab : Sab; aList : TPersistent; Caps : Boolean);

   procedure   Cleanup; override;
   function    NeedItemList: Boolean; virtual;
  private
   function    ReceiveGetNode(aID : TDictID) : IDictItem;
   procedure   ReceiveDelNode(aID : TDictID);

   procedure   RegetItemList;
   procedure   CheckDictType(aAllowedTypes: TDLTypeSet); // выбрасывает исключение
   function    pm_GetIsLoaded: Boolean;

  public
   constructor Create(aFamily    : TdaFamilyID;
                      aType      : TdaDictionaryType;
                      aTable: Integer = 0); override;

   procedure   UpdateTbl; override;

   procedure   GetDictList(aList : TPersistent;Caps : Boolean);
   procedure   GetDictListOnSab(Values : SAB;aList : TPersistent;Caps : Boolean);

   procedure   GetIndexDictList(aList : Tl3StringDataList;ConvertToOEM : Boolean;
                                Caps : Boolean);

   function    GetNameStr(aID : TDictID) : AnsiString;
   function    GetNameE(aID: TDictID): AnsiString;
   function    GetNameR(aID: TDictID): AnsiString;
   function    GetIsPrivate(aID: TDictID): TIsPrivate;
   function    GetIsNonperiodic(aID: TDictID): TIsNonperiodic;

   procedure   IterateAllDict(Action : Tl3IteratorAction; NeedSort: Boolean = False);

   function    AddDictItem(aID: TDictID;
                           const aNameR, aNameE, aShortName: Tl3WString;
                           aIsPrivate: TIsPrivate = cEmptyByte;
                           aIsNonperiodic: TIsNonperiodic = cEmptyByte): IDictItem;

   procedure   EditDictItem(aID : TDictID;
                            const aNameR, aNameE, aShortName: Tl3WString;
                            aIsPrivate: TIsPrivate = cEmptyByte;
                            aIsNonperiodic: TIsNonperiodic = cEmptyByte);

   procedure   AddData(var theID : TDictID;aData : PAnsiChar); override;
   procedure   EditData(aID : TDictID;aData : PAnsiChar); override;

   procedure   EditNonKeyFields(aID : TDictID;aField : Word;aValue : Pointer);
   procedure   ChangeDictField(aField : ThtField; var theOldValue; var theNewValue);

   function    iCheckItemInList(aID : TDictID) : IDictItem;
   //function    bCheckItemInList(aID : TDictID) : Boolean;
   function    CheckExists(aDictID : TDictID) : Boolean; override;

   procedure   DelData(aID : TDictID); override;

   procedure   SetDelNumber(aID : TDictID);
   procedure   GetDelNumbers(aList : Tl3LongintList);
   procedure   ClearDelNumbers;
   function    GetItemList: TdtDictItems;
   procedure   LoadItemList;
   procedure   SetNameE(aID: TDictID; const aName: AnsiString);

   function    SearchInName(CurSab : LPSAB; aNameMask : PAnsiChar) : Sab;
   function    HasRecordWithName(const aName: AnsiString;
                                 aDoFlushCache: Boolean = True): Boolean;

   property    NameFld : SmallInt read fNameFld write SetNameFld;

   property    ItemList : TdtDictItems read GetItemList;
   property    DictItemClass : TDictItemClass read fDictItemClass write setDictItemClass;
   property    IsLoaded: Boolean read pm_GetIsLoaded;
 end;

// TDictionaryServer = Class;

 TDictAbsNode = Class(Tl3HandleNode)
  protected
   function  GetDictRootNode : TDictAbsNode; virtual; abstract;
 end;

 TDictLeafNode = Class;
 TDictionary = class;

 TDictLeafNodeClass = class of TDictLeafNode;

 TDictRootNode = class(TDictAbsNode,IDictItem)
  protected
   fDict           : TDictionary;
   //fDictType       : TdaDictionaryType;
   fTreeObj        : TTreeStrorage;

   //fTreeChanged,
   fIsEqualLoaded  : Boolean;

   fChildNodeClass : TDictLeafNodeClass;

   fInReload : boolean; // спецрежим для оптимизации загрузки словаря из внешнего источника
   function  GetDictRootNode : TDictAbsNode; override;

   procedure setChildNodeClass(aVal : TDictLeafNodeClass);
   procedure ChangeLoadEqualsState(aVal : Boolean);

   function  di_Get_Handle : TDictID;
   function  di_Get_Name : Tl3PCharLenPrim;
   function  di_Get_LinkFlag : Boolean;
   procedure di_Set_LinkFlag(Value : Boolean);
   function  di_Get_DataStr : AnsiString;
   procedure di_Set_DataStr(Value : AnsiString);

   function  GetAsPCharLen: Tl3PCharLenPrim;
        override;
        {-}
   function pm_GetHandle : Integer; override;

   //procedure BeforeRelease; override;
   procedure Cleanup; override;
  private
   procedure   CloseTreeObj;
   procedure   OpenTreeObj;
  public
   constructor CreateWithInit(aDict : TDictionary);

   procedure   Load;
   procedure   Save; // только для Reload
   procedure   StartReload; // начинаем процесс загрузки словаря из внешнего источника, заканчиваем вызовом Save

   procedure   ClearAllData;

   procedure   DataChanged(aOperation : TOperActionType;aID,aParentID,aNextID : TDictID);
   procedure   DeleteFromTbl(aID, aHairID: TDictID; aDateToDelete: TDateTime);
   procedure   EditNameInTbl(aID : TDictID; const aName : Tl3WString);
   procedure   EditNonKeyValueInTbl(aID : TDictID; aFld : Word; aValue : Pointer);
   procedure   ChangeKeyValues(aFld : ThtField; var theOldValue; var theNewValue);
   function    CheckItem(aID : TDictID) : IDictItem;

   procedure   AddEqualToTbl(aFirstID,aSecondID : TDictID);
   procedure   DelEqualFromTbl(aFirstID,aSecondID : TDictID);

   function    AddExtItemTbl(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
   procedure   EditExtItemTbl(aRec : Pointer);
   procedure   DelExtItemTbl(aItemID: TDictID; aHairID : TDictID = cUndefDictID);

   procedure   DeleteEx(aHeirID : TDictID = cUndefDictID); virtual;
    {- Удаление ноды и словарного элемента связанного с ней}

   property    ChildNodeClass : TDictLeafNodeClass read fChildNodeClass write setChildNodeClass;
   property    HasEqualNodes : boolean read fIsEqualLoaded write ChangeLoadEqualsState;
 end;

 TDictLeafNode = Class(TDictAbsNode, IDictNode, IDictItem, IPersistentNode)
  protected
   fHandle   : Integer;
   fDictRec  : IDictItem;

   function  GetDictRootNode : TDictAbsNode; override;

   function  GetRootNode : TDictRootNode;

   procedure pm_SetParent(Value : Tl3Node); override;

   function  dn_IsLastEntry : Boolean;
   procedure dn_BeforeDelete(aNewID : TDictID = cUndefDictID); virtual;
   procedure dn_SetDictItem(aDictItem : IDictItem);

   function  pn_CheckSaveStatus : boolean;

   function  di_Get_Handle : TDictID;
   function  di_Get_Name : Tl3PCharLenPrim;

   function  GetAsPCharLen: Tl3PCharLenPrim;
    override;
    {-}

   procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
    override;
    {-}
   function  pm_GetHandle : Integer; override;
   procedure pm_SetHandle(aVar : Integer); override;

   function  GetDictNodeType : TDictNodeType;

   procedure Cleanup; override;
  public
   procedure DoDelete; override;
   procedure DeleteEx(aHeirID: TDictID = cUndefDictID; aDateDeleted: TDateTime = 0); virtual;

   procedure MovingStopped(aUserParam : Pointer); override;

   property  RootNode : TDictRootNode read GetRootNode;
 end;

 TDictLeafNodeWithJournal = Class(TDictLeafNode, IDictItemJour)
  protected
   procedure dn_BeforeDelete(aNewID : TDictID = cUndefDictID); override;

   function  dij_Get_Operation : TOperActionType;
   procedure dij_Set_Operation(aVal : TOperActionType);
   function  dij_Get_NewID : TDictID;
   procedure dij_Set_NewID(aVal : TDictID);
   function  dij_Get_Comment : AnsiString;
   procedure dij_Set_Comment(aVal : AnsiString);

   procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
    override;
     {-}
  public
   procedure MovingStarted(var theUserParam : Pointer); override;
   procedure MovingStopped(aUserParam : Pointer); override;
 end;

 TCustomExtItemNode = Class(Tl3HandleNode, IDictNode)
 protected
  function  dn_IsLastEntry : Boolean;
   virtual;

  procedure dn_SetDictItem(aDictItem: IDictItem);
   virtual;

  function  GetAsPCharLen: Tl3PCharLenPrim;
   override;
    {-}
  procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
   override;
    {-}

  function  pm_GetHandle : Integer;
   override;

  procedure pm_SetHandle(aValue : Integer);
   override;

  procedure pm_SetParent(aValue : Tl3Node);
   override;

  function  GetDictNodeType : TDictNodeType;
   virtual;
   abstract;

 public
  procedure MovingStarted(var theUserParam : Pointer);
   override;

  procedure MovingStopped(aUserParam : Pointer);
   override;

  function DoMove(aDirection: Tl3Direction): Boolean;
   override;

  procedure DeleteEx(aHeirID : TDictID = cUndefDictID);
   virtual;
  procedure DoDelete;
   override;
 end;

 TExtItemNode = class(TCustomExtItemNode, Il3ExtItemNode, IPersistentNode)
 protected
  fItemRec  : Pointer;
  fItemSize : Cardinal;
  fItemStr  : AnsiString;

  procedure Cleanup; override;
  function  pn_CheckSaveStatus : boolean;
  procedure InitData(var theItemRec; aItemSize : Cardinal);
  procedure Set_Data(aRec : Pointer);
  function  GetAsPCharLen: Tl3PCharLenPrim; override;
  function  pm_GetHandle: Integer; override;
  procedure DeleteEx(aHeirID: TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
  function  Get_Data : Pointer;
  function  Get_DataSize : Longint;
  function  GetRootNode : TDictRootNode;

  function  GetDictNodeType : TDictNodeType; override;
 end;//TExtItemNode

 TDictEqualNode = Class(TCustomExtItemNode)
 protected
  fDictRec   : IDictItem;
  fText      : Tl3PCharLen;
  procedure Cleanup; override;
  function  dn_IsLastEntry : Boolean; override;
  procedure dn_SetDictItem(aDictItem: IDictItem); override;
  function  GetAsPCharLen: Tl3PCharLenPrim;
   override;
        {-}
  function pm_GetHandle: Integer; override;

  function  GetDictNodeType : TDictNodeType; override;
 public
  procedure DoDelete; override;
 end;

{ TDictTblRec = record
  Obj      : TCustomDictTbl;
  List     : Tl3StringDataList;
  RootNode : TDictRootNode;
  Equals   : TEqualItemsTbl;
 end;}

 PdtDeferDelRec = ^TdtDeferDelRec;
 TdtDeferDelRec = record
  rID      : TDictID;
  rDestID  : TDictID;
  rDelDate : TstDate;
 end;

 TDictionary = class(Tl3Base)
 private
   fTbl      : TCustomDictTbl;
   fList     : Tl3StringDataList;
   fRootNode : TDictRootNode;
   fEquals   : TEqualItemsTbl;
   fDeferDeleletedItems : Tl3FieldSortRecList;

   fFamily : TdaFamilyID;
   fDictType : TdaDictionaryType;

   function GetTbl : TCustomDictTbl;
   function GetDictTbl : TDictionaryTbl;
   function GetGroupTbl : TParamGroupTbl;

   function GetList : Tl3StringDataList;
   function GetRootNode : TDictRootNode;
   function GetEquals : TEqualItemsTbl;

   procedure ReloadList;
   procedure DoBeforeItemDelete(aTable : TdtTable; aRecID : Longint);

   procedure ReadDictChange(aIterProc : TReadDictChangeProc);
   procedure LoadDeferDeleletedItems;

 protected
  procedure Cleanup; override;

  function  CheckItem(aID: TDictID): IDictItem;

  procedure SendEditMessage(aOperation : TOperActionType;
                            aID, aParentID, aNextID : TDictID);

  function  LoadEqualClassesToTree : boolean;


  procedure DelDictItemFromTbls(aID : TDictID; aNewID : TDictID = cUndefDictID); virtual;

  procedure EditNonKeyValueInTbl(aID: TDictID; aFld: Word; aValue: Pointer);

  procedure EditDictItemInTblEx(aID: TDictID;
                                const aNameR, aNameE, aShortName: Tl3WString;
                                aIsPrivate: TIsPrivate = cEmptyByte;
                                aIsNonperiodic: TIsNonperiodic = cEmptyByte); virtual;

  procedure ChangeKeyValues(aFld: ThtField; var theOldValue, theNewValue);

  procedure AddEqualToTbl(aFirstID, aSecondID : TDictID);
  procedure DelEqualFromTbl(aFirstID, aSecondID : TDictID);

  function  AddExtItemTbl(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
  procedure EditExtItemTbl(aRec : Pointer);
  procedure DelExtItemTbl(aDictID : TDictID; aHairDictID : TDictID = cUndefDictID);

  function  LoadExtItemsToTree : boolean;
  function  GetExtItemDataSize : Integer;
 public
  constructor Create(aFamily : TdaFamilyID; aDictType : TdaDictionaryType); Reintroduce;
  procedure   Update; // не вызывается, все делается с таблицами напрямую по имени (что неправильно)
  //procedure   Save;

  function    Lock : Boolean;
  procedure   UnLock;

  function  FindNodeByFullPath(const aNodePath: Tl3WString; const aLevelSlash: AnsiString = c_LevelSlash): Il3Node;
  function  FindIDByFullPath(const aNodePath: Tl3WString; const aLevelSlash: AnsiString = c_LevelSlash): TDictID;
  function  FindNodeByID(aDictID : TDictID; aNodeType : TDictNodeType = dntItem) : Il3Node;

  function  IDOfDictRec(aRec: PAnsiChar): TDictID;
  function  DataOfDictRec(aRec: PAnsiChar): PAnsiChar;
   (* - получает указатель на запись словаря и возвращает указатель на второе поле
        этой записи (проще говоря, указатель на ту же запись, но без первого поля*)

  function IsDictIDFree(aID: TDictID): Boolean;

  function  AddDictNode(aID: TDictID;
                        const aNameR, aNameE, aShortName: Tl3WString;
                        const aParentNode: Il3Node;
                        aIsPrivate: TIsPrivate = cEmptyByte;
                        aIsNonperiodic: TIsNonperiodic = cEmptyByte): Il3Node;

  function  AddDictFullDataNode(var theID : TDictID; aData : PAnsiChar; const aParentNode : Il3Node = nil): Il3Node; virtual;
  function  RealAddDictFullDataNode(var theID : TDictID; aData : PAnsiChar; const aParentNode : Il3Node = nil): Il3Node;

  procedure EditDictFullData(aID : TDictID; aData : PAnsiChar); virtual;

  procedure EditDictItem(aID: TDictID;
                         const aNameR, aNameE, aShortName: Tl3WString;
                         aIsPrivate: TIsPrivate = cEmptyByte;
                         aIsNonperiodic: TIsNonperiodic = cEmptyByte);

  procedure DelDictItem(aID : TDictID; aNewID : TDictID = cUndefDictID);

  function  AddExtItem(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
  procedure AddEqualNode(aFirstID, aSecondID : TDictID);
  function CreateExtNode(const aParentNode : Il3Node; aRec : Pointer): Il3Node;
  function  GetDeferDelInfo(aItemID : TDictID) : PdtDeferDelRec;
  function  RealAddDictNode(aID: TDictID;
                            const aNameR, aNameE, aShortName: Tl3WString;
                            const aParentNode               : Il3Node;
                            aIsPrivate: TIsPrivate = cEmptyByte;
                            aIsNonperiodic: TIsNonperiodic = cEmptyByte): Il3Node;

  procedure RealDelDictItemFromTbls(aID: TDictID; aNewID: TDictID = cUndefDictID; aDateToDelete: TstDate = 0);
  procedure RealEditDictItemInTbl(aID: TDictID;
                                  const aNameR, aNameE, aShortName: Tl3WString;
                                  aIsPrivate: TIsPrivate = cEmptyByte;
                                  aIsNonperiodic: TIsNonperiodic = cEmptyByte);

  procedure RealAddEqualToTbl(aFirstID, aSecondID : TDictID);
  procedure RealDelEqualFromTbl(aFirstID, aSecondID : TDictID);

  procedure RealEditDictFullData(aID : TDictID; aData : PAnsiChar);
  procedure RealEditNonKeyValueInTbl(aID: TDictID; aFld: Word; aValue: Pointer);

  function GetShortName(aID : TDictID) : ShortString;
  function GetFullDictItemName(const aNode : Il3Node; aAsTree: Boolean = True): AnsiString; overload;
  function GetFullDictItemName(aDictID : TDictID; aAsTree: Boolean = True): AnsiString; overload;

  property DictType : TdaDictionaryType read fDictType;
  property Tbl      : TCustomDictTbl read GetTbl;
  property DictTbl  : TDictionaryTbl read GetDictTbl;
  property GroupTbl : TParamGroupTbl read GetGroupTbl;

  property List     : Tl3StringDataList  read  GetList;
  property RootNode : TDictRootNode      read  GetRootNode;
  property Equals   : TEqualItemsTbl     read  GetEquals;
  property DeferDeleletedItems : Tl3FieldSortRecList read fDeferDeleletedItems;
 end;

 TDictionaryServer = Class(Tl3Base)
  private
   f_CSClient: TcsClient;
   f_EditedItems: TDictEditQueryList;
   f_LastEditedID: TDictID;
   {$IfDef AppServerSide}
   f_MessageManager: TcsMessageManager;
   {$EndIf AppServerSide}
   f_DictScan   : Tm4DictScanner;
  protected
   fNotifiedObjList : Tl3LongintList;

   fFamily       : TdaFamilyID;
   fDicts        : Array[da_dlSources..High(TdaDictionaryType)] of TDictionary;
   fPocketModify : LongInt;

   procedure SetFamily(aValue : TdaFamilyID);
   function  GetDict(aDictType : TdaDictionaryType) : TDictionary;
   function  GetDictRootNode(DictType : TdaDictionaryType) : TDictRootNode;
   function  GetDictList(DictType : TdaDictionaryType) : Tl3StringDataList;
   procedure RefreshDictList(DictType : TdaDictionaryType);
   function  GetDictTbl(aDictType : TdaDictionaryType) : TDictionaryTbl;
   function  GetGroupTbl(aDictType : TdaDictionaryType) : TParamGroupTbl;
   function  GetTbl(aDictType: TdaDictionaryType): TCustomDictTbl;
   function  GetDictEqualObj(DictType : TdaDictionaryType) : TEqualItemsTbl;
   function  GetPocketModifyFlag : Boolean;

   function  GetBiLingual : Boolean;
   procedure SetBilingual(aValue : Boolean);

   procedure AllDictClear;
   procedure DictClear(aDict : TdaDictionaryType);
   procedure SetDictChanges(DictType : TdaDictionaryType);
   function  GetDictChanges(DictType : TdaDictionaryType) : TStDateTimeRec;

   procedure SendEditMessage(aDictType : TdaDictionaryType;aOperation : TOperActionType;
                             aID,aParentID,aNextID : TDictID);

   procedure ReceiveAddNode(aDictType : TdaDictionaryType;aID,aParentID : TDictID);
   procedure ReceiveEditNode(aDictType : TdaDictionaryType;aID : TDictID);
   procedure ReceiveDelNode(aDictType : TdaDictionaryType;aID : TDictID);
   procedure ReceiveMoveMode(aDictType : TdaDictionaryType;aID,aParentID,aNextID : TDictID);

   procedure Cleanup; override;
   procedure DoBeforeItemDelete(aTable : TdtTable; aRecID : Longint);
  private
//   function pm_GetBusy: Boolean;

   procedure pm_SetCSClient(const Value: TcsClient);
   {$IfDef AppServerSide}
   procedure pm_SetMessageManager(const Value: TcsMessageManager);
   {$EndIf AppServerSide}
   function  pm_GetDictScanner : Tm4DictScanner;
   procedure DropDictScanData; // сброс компилированных словарей

   function  MakeDictScanner : Tm4DictScanner;

  public
   Constructor Create; Reintroduce;

   procedure  AddDictChangeNotifiedObj(aObj : IDictChangeNotifyRecipient);
   procedure  DelDictChangeNotifiedObj(aObj : IDictChangeNotifyRecipient);

   procedure  Update; // не вызывается, все делается с таблицами напрямую по имени (что неправильно)
   //procedure  SaveDict(aDict : TdaDictionaryType);
   //procedure  SaveAllDicts;
   procedure  ReloadDict(aDict : TdaDictionaryType);

   procedure  GetNumberList(aTyp : TDNType;aList : TStrings);

   //procedure  DoCompileDictionaries(aProgress : Tl3ProgressProc);
   //procedure  CompileDictionary(aCompStream : TmgCompPhraseQueryStream; aProgress : Tl3ProgressProc);

   procedure  ReceiveMessage(aMessage : PAnsiChar);

   function   GetDictsChanges(LastEnter : TStDateTimeRec) : TDLTypeSet;

   procedure  GetEqualClassesList(ClassID : TDictID; aList : Tl3StringDataList);
   procedure  GetNearestEqualsFor(aDict: TdaDictionaryType; aId: TDictID; aList: Tl3StringDataList);

   procedure  CopyToJournaledDict(aJourDict,aNormalDict : TdaDictionaryType);
   procedure  CopyFromJournaledDict(aJourDict,aNormalDict : TdaDictionaryType);

   function   GetPublishData(const aDocIds: ISab; aSortedBySourceId: Boolean = False) : ISabCursor;
    overload;

(*   procedure  GetPublishData(aDocId: TDocId;
                             aResult: Tl3CustomDataList;
                             aSortedBySourceId: Boolean = False);
    overload;*)

   //procedure AddBatchToGroupDict(aDictType: TdaDictionaryType; aData: TStream);
   function  CSClientNotify(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;
   procedure ProcessDictEdit(theDictRec: TDictMessageRec; ExcludeUser: Integer);
   procedure cs_GetDictEdit(aDataPipe: TcsDataPipe);

    // пакетное добавление данных в словарь, который на самом деле не
    // словарь (DT#7 и DT#9). Исходные данные предоставляются
    // в потоке в виде последовательного набора записей.
    //  Внимание: метод не посылает никаких сообщений об изменении словаря
    //  (таких, как SendEditMessage), только лОчит (LockDict) словарь.

   Procedure  PO_Begin;
   Procedure  PO_End;

(*   function   IdByShortNameInAccGroupsTable(const aShName: AnsiString; out aFoundId: TDictID): Boolean;*)
   procedure  SendNotify(theDictRec: TDictMessageRec; ExcludeUser: Integer);

   property   Family : TdaFamilyID read fFamily write SetFamily;
   property   Dict[aDictType : TdaDictionaryType] : TDictionary read GetDict;
   property   DictList[DictType : TdaDictionaryType] : Tl3StringDataList read GetDictList; default;
   property   DictRootNode[DictType : TdaDictionaryType] : TDictRootNode read GetDictRootNode;
   property   DictTbl[DictType : TdaDictionaryType] : TDictionaryTbl read GetDictTbl;
   property   GroupTbl[DictType : TdaDictionaryType] : TParamGroupTbl read GetGroupTbl;
   property   Tbl[DictType: TdaDictionaryType]: TCustomDictTbl read GetTbl;
   property   DictEqualObj[DictType : TdaDictionaryType] : TEqualItemsTbl read GetDictEqualObj;
   property   DictChanges[DictType : TdaDictionaryType] : TStDateTimeRec read GetDictChanges;
   property   PocketModify : Boolean read GetPocketModifyFlag;
   property   BiLingual: Boolean read GetBiLingual write SetBilingual;
   property   CSClient: TcsClient read f_CSClient write pm_SetCSClient;
//   property   Busy: Boolean read pm_GetBusy;
   property   LastEditedID: TDictID read f_LastEditedID;
   {$IfDef AppServerSide}
   property   MessageManager: TcsMessageManager read f_MessageManager write pm_SetMessageManager;
   {$EndIf AppServerSide}

   property   DictScanner : Tm4DictScanner read pm_GetDictScanner;
 end;

(* TClientDictionary = class(TDictionary)
 end;

 TServerDictionary = class(TDictionary)
 end;*)


 function GetExpandDictIDValueSab(aDictType : TdaDictionaryType; aDictIDList : Tl3LongintList; aIsInvert : boolean = False) : ISab;
 // На входе лист элементов словаря, на выходе Sab ЛИСТЬЕВЫХ элементов словаря для этих веток
 // если aIsInvert то в результирующий список попадут все листьевые кроме тех что в ветках
 // Используется для поиска с вложенными и при компиляции словарей

(* procedure RepairClassTree;*)

 (* Специальная функция расчета статистики вхождений документов с одинаковыми
    префиксами в конкретный класс *)
(* procedure CountPrefixesOnClasses;*)

function DictServer(aFamily: TdaFamilyID = CurrentFamily): TDictionaryServer;

procedure FreeDictServer;

procedure ExpandDictIDList(aDictionary: TdaDictionaryType; var theIDList: Tl3LongintList);

Const
 gDictServer : TDictionaryServer = Nil;

 DictChangeConfig : TCfgList = Nil;

 cCommonFldCount = 2;

 JournaledFldCount = 5;
 JournaledFldArr: Array[1..JournaledFldCount] of SmallInt =
          (dtIDFld,dtNameRFld,dtOperationFld,dtNewIDFld,dtCommentFld);

 gBiLingual: Boolean = False;
implementation

uses
 StrUtils,

 TypInfo,

 l3MinMax,
 l3BMSearch,
 l3FileUtils,
 l3Bits, l3Chars,
 l3String, l3StringEx,
 l3Stream,
 l3Languages,

 m2xltlib,
 //MGExFStr,
 //MGBufStr,
 m4DB,

 daDataProvider,
 daInterfaces,

 htDataProvider,

 HT_Dll,
 DT_Misc,
 Dt_Serv,
 Dt_Free,
 Dt_Err,
 Dt_Containers,
 Dt_Lock,
 Dt_Link, Dt_LinkServ,
 Dt_List,
 Dt_DocImages,
 //dt_DictExport,

 IniFiles,
 Base_CFG,

 csQueryTypes,
 CsNotifier,
 csUserRequestManager,

 //ddServerTask,

 DictsSup,

 l3Memory, dt_UserConst;

// start class TCustomDictTbl

constructor TCustomDictTbl.Create(aFamily : TdaFamilyID; aType : TdaDictionaryType; aTable: Integer = 0);
var
 l_FTbl: TFamTbls;
 l_MTbl: TMainTbls;
begin
 if aFamily <> MainTblsFamily then
 begin
  if aType <> da_dlNone then
   l_FTbl := cDLPassports[aType].rDict
  else
   l_FTbl := TFamTbls(aTable);
  inherited Create(aFamily, Ord(l_FTbl))
 end
 else
 begin
  Assert(aType = da_dlNone);
  l_MTbl := TMainTbls(aTable);
  inherited Create(aFamily, Ord(l_MTbl));
 end;
 fDictType := aType;
end;

function TCustomDictTbl.GetFullInfo(aID : TDictID; WithHold : Boolean) : LongInt;
begin
 Result := GetRecordIDByUniq(dtIDfld, aID);
 if Result > 0 then
  GetFullRec(Result,WithHold)
 else
  raise EHtErrors.CreateInt(ecNotFound);
end;

function TCustomDictTbl.CheckExists(aDictID : TDictID) : Boolean; 
begin
 Result := HasRecord(dtIDfld, aDictID);
end;

procedure TCustomDictTbl.DropTblData;
begin
 Inherited;

 GlobalHtServer.FreeTbl[TblFamily].ResetFreeTblNum(TblName, 1, MaxIdValue);
end;

function TCustomDictTbl.GetIDSize : Word;
begin
 Result := FldLength[dtIDFld];
end;

function TCustomDictTbl.GetDataSize : Word;
begin
 Result := RecSize - IDSize;
end;

function TCustomDictTbl.MaxIdValue: LongWord;
begin
 Result := Pred(High(LongWord));
end;

procedure TCustomDictTbl.GetFullList(aFList : Tl3DataList);
var
 TmpRec   : PAnsiChar;

 TmpList  : TAbstractList;
 TmpMode  : TOpenMode;
 I        : LongInt;
 lSab     : Sab;
begin
 lSab := MakeAllRecordsSab;

 aFList.Changing;
 try
  aFList.Clear;
  if lSab.gFoundCnt = 0 then
   exit;

  TmpMode.openMode:=ROPEN_BODY;
  TmpMode.Count:=0;
  TmpMode.FldArr:=Nil;
  TmpList:=TAbstractList.Create(@lSab,TmpMode);
  TmpList.ReadForvard:=True;
  Try
   For I:=0 to TmpList.Count-1 do
    begin
     TmpRec:=TmpList.GetItem(I);
     aFList.Add(TmpRec);
    end;
  finally
   l3Free(TmpList);
  end;
 finally
  aFList.Changed;
 end;
 htClearResults(lSab);
end;

procedure TCustomDictTbl.GetFullListOnSAB(Values : SAB;aFList : Tl3CustomDataList;
                                             Const aSortOrder : TSortRec);
var
 SortSab,
 TmpSab   : Sab;

 TmpRec   : PAnsiChar;

 TmpList  : TAbstractList;
 TmpMode  : TOpenMode;
 I        : LongInt;
begin
 aFList.Changing;
 try
  aFList.Clear;

  if Values.gFoundCnt = 0 then
   exit;
  htTransferToTable(Values,Handle,dtIDFld);
  htRecordsByKey(TmpSab,Values);

  if TmpSab.gFoundCnt = 0 then
   exit;

  Try
   if aSortOrder.FldCount=0
    then
     htCopyResults(SortSab,TmpSab)
    else
     htSortResults(SortSab,TmpSab,@aSortOrder.Fld,aSortOrder.FldCount);
  finally
   htClearResults(TmpSab);
  end;
  Try
   TmpMode.openMode:=ROPEN_BODY;
   TmpMode.Count:=0;
   TmpMode.FldArr:=Nil;
   TmpList:=TAbstractList.Create(@SortSab,TmpMode);
   TmpList.ReadForvard:=True;
   Try
    For I:=0 to TmpList.Count-1 do
     begin
      TmpRec:=TmpList.GetItem(I);
      aFList.Add(TmpRec);
     end;
   finally
    l3Free(TmpList);
   end;
  finally
   htClearResults(SortSab);
  end;
 finally
  aFList.Changed;
 end;
end;

function TCustomDictTbl.GetData(aID : TDictID;aData : PAnsiChar;aLen : Word) : Word;
var
 lRecNum : Longint;
begin
 if aLen < RecSize - IDSize then
  Result := 0
 else
  Result := RecSize - IDSize;

 lRecNum := GetRecordIDByUniq(dtIDfld, aID);
 GetFullRec(lRecNum, False);
 l3Move(fFullRecord[IDSize], aData^, RecSize - IDSize);
end;

procedure TCustomDictTbl.AddData(var theID : TDictID;aData : PAnsiChar);
begin
 if theID = cUndefDictID then
  theID := GetFreeNum;
 ClearFullRec;
 PutToFullRec(dtIDfld, theID);
 l3Move(aData^, fFullRecord[IDSize], RecSize - IDSize);
 AddFRec;
end;

procedure TCustomDictTbl.EditData(aID : TDictID;aData : PAnsiChar);
var
 AbsN    : LongInt;
begin
 AbsN := GetRecordIDByUniq(dtIDfld, aID);
 if AbsN > 0 then
  begin
   GetFullRec(AbsN, True);
   Try
    // а новые данные отличаются от старых?
    if not CompareMem(aData,
                      fFullRecord + IDSize,
                      RecSize - IDSize) then
    begin
     l3Move(aData^,
          fFullRecord[IDSize],
          RecSize - IDSize);
     UpdFRec(AbsN);
    end;
   finally
    FreeRec(AbsN);
   end;
  end
 else
  raise EHtErrors.CreateInt(ecNotFound);
end;

procedure TCustomDictTbl.DelData(aID : TDictID);
var
 lRecID     : LongInt;
begin
 lRecID := GetRecordIDByUniq(dtIDfld, aID);

 if lRecID > 0 then
 begin
  if Assigned(fBeforeDelete) then fBeforeDelete(Self, lRecID);
  Ht(htRecordDelete(Handle, lRecID));
 end;
end;

procedure TCustomDictTbl.DeleteItems(aIDs : Sab);
begin
 DeleteRecsByKeys(aIDs, dtIDFld);
//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoDelete);
end;

function TCustomDictTbl.GetFullSabOnValues(Values : SAB) : Sab;
begin
 l3FillChar(Result,SizeOf(Result));
 htTransferToTable(Values,Handle,dtIDFld);
 htRecordsByKey(Result,Values);
end;

function TCustomDictTbl.GetMaxID : TDictID;
begin
 Result := MaxID;
end;

function TCustomDictTbl.GetMinIDinSab(Values : SAB;Fld : Word) : TDictID;
var
 lSab   : Sab;
begin
 Result:=0;

 htTransferToTable(Values,Handle,dtIDFld);
 htRecordsByKey(lSab,Values);
 Try
  if lSab.gFoundCnt > 0 then
   HT(htKeyMinimum(lSab,Fld,@Result));
 finally
  htClearResults(lSab);
 end;
end;

{ THandledRecordTblwithLog }

procedure THandledRecordTblwithLog.AddData(var theID : TDictID;aData : PAnsiChar);
begin
 Inherited;
//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoAdd);
end;

procedure THandledRecordTblwithLog.EditData(aID : TDictID;aData : PAnsiChar);
begin
 Inherited;
//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoEdit);
end;

procedure THandledRecordTblwithLog.DelData(aID : TDictID);
begin
 Inherited;
//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoDelete);
end;

{ TParamGroupTbl }

procedure TParamGroupTbl.GetItemsOnKeyValue(var theItems : SAB; aValue : Pointer;
                                            aFld : Word; {WithRefresh : Boolean;}
                                            aCondition : ThtCondition = EQUAL);
begin
 l3FillChar(theItems,SizeOf(Sab));

 if ElementKeyKind[aFld] = EK_NOTKEY then
  raise EHtErrors.CreateInt(ecNotKeyField);

 //if WithRefresh then
 // RefreshSrchList;

 //if fSrchList.gFoundCnt=0 then Exit;
 htSearch(nil, theItems, Handle, aFld, aCondition, aValue, nil);
end;

{ TDictItem }

procedure TDictItem.DeleteEx(aHeirID : TDictID = cUndefDictID);
    {- Удаление ноды и словарного элемента связанного с ней}
begin
 if LinkNode <> nil then
  LinkNode.Delete;
end;

procedure TDictItem.SetData(aData: PAnsiChar; aTable: TDictionaryTbl);
begin
 with aTable do
  AsWStr := l3RTrim(l3PCharLen(aData - fldLength[dtIDFld] + fldOffset[NameFld], fldLength[NameFld], GlobalDataProvider.BaseLanguage[CurrentFamily].ANSICodePage), [#0, #32]);
end;

procedure TDictItem.DoChanging;
begin
 if fLinkNode <> nil then
  LinkNode.Changing;
 inherited;
end;

procedure TDictItem.DoChanged;
begin
 inherited;
 if fLinkNode <> nil then
  LinkNode.Changed;
end;

function TDictItem.Get_Handle : TDictID;
begin
 Result := fHandle;
end;

procedure TDictItem.Set_Handle(aValue : TDictID);
begin
 fHandle := aValue;
end;

function TDictItem.di_Get_Name : Tl3PCharLenPrim;
begin
 Result:=Tl3String(Self).AsPCharLen;
end;

function TDictItem.dip_Get_LinkNode : Il3Node;
begin
 Result:=IUnknown(fLinkNode) as Il3Node;
end;

procedure TDictItem.dip_Set_LinkNode(const Value : Il3Node);
begin
 fLinkNode:=Pointer(Value);
end;

function TDictItem.dip_RefCount : LongInt;
begin
 Result:=refCount;
end;

procedure TDictItem.dip_LinkDisconnect;
begin
 fLinkNode:=nil;
end;

{ TJournaledDictItem }

function TJournaledDictItem.dij_Get_Operation : TOperActionType;
begin
 Result:=fOperation;
end;

procedure TJournaledDictItem.dij_Set_Operation(aVal : TOperActionType);
begin
 fOperation:=aVal;
 if fLinkNode <> nil then
 begin
  LinkNode.Changing;
  LinkNode.Changed;
 end;
end;

function TJournaledDictItem.dij_Get_NewID : TDictID;
begin
 Result:=fNewID;
end;

procedure TJournaledDictItem.dij_Set_NewID(aVal : TDictID);
begin
 fNewID:=aVal;
 if fLinkNode <> nil then
 begin
  LinkNode.Changing;
  LinkNode.Changed;
 end;
end;

function TJournaledDictItem.dij_Get_Comment : AnsiString;
begin
 Result:=fComment;
end;

procedure TJournaledDictItem.dij_Set_Comment(aVal : AnsiString);
begin
 fComment:=aVal;
 if fLinkNode <> nil then
 begin
  LinkNode.Changing;
  LinkNode.Changed;
 end;
end;

procedure TJournaledDictItem.SetData(aData: PAnsiChar; aTable: TDictionaryTbl);
var
 l_Record: PAnsiChar;
 l_Comment: AnsiString;
begin
 inherited;

 l_Record := aData - aTable.fldLength[dtIDFld];
 Operation := TOperActionType(PByte(l_Record + aTable.fldOffset[dtOperationFld])^);
 NewID := PDictID(l_Record + aTable.fldOffset[dtNewIDFld])^;

 SetLength(l_Comment, aTable.fldLength[dtCommentFld]);
 l3Move((l_Record + aTable.fldOffset[dtCommentFld])^,
      PAnsiChar(l_Comment)^,
      aTable.fldLength[dtCommentFld]);
 Comment := SysUtils.Trim(l_Comment);
end;

{ TDictionaryTbl }

Constructor TDictionaryTbl.Create(aFamily : TdaFamilyID; aType : TdaDictionaryType; aTable: Integer = 0);
begin
 inherited;

 fOpenFldArr[1]:=dtIDFld;
 NameFld := dtNameRFld;
 fDictItemClass:=TDictItem;

 fNeedLoadItemList := IsDictClass(fDictType);
end;

procedure TDictionaryTbl.Cleanup;
begin
 l3Free(fItemList);
 Inherited;
end;

procedure TDictionaryTbl.UpdateTbl;
begin
 inherited;
 ClearDelNumbers;
end;

procedure TDictionaryTbl.DropTblData;
begin
 inherited;
 // Когда будет интеграция дерева в объект Словарь сюда нужно добавить сброс
 // файлов, в которых храниться дерево
end;

procedure TDictionaryTbl.SetNameFld(aValue : SmallInt);
begin
 fNameFld:=aValue;
 fOpenFldArr[2]:=aValue;
 JournaledFldArr[2] := aValue;
end;

function TDictionaryTbl.GetItemList : TdtDictItems;
begin
 if NeedItemList then LoadItemList;
 Result := fItemList;
end;

procedure TDictionaryTbl.LoadItemList;
var
 TmpList  : TAbstractList;
 TmpMode  : TOpenMode;
 TmpRec   : PAnsiChar;
 I        : LongInt;
 TmpID    : TDictID;
 TmpItem  : TDictItem;

 function PosInTmpRec(aField: Word): Word;
 var
  I: Integer;
 begin
  Result := 0;
  if not (fDictType in sJournaled) then
  begin
   for I := Low(fOpenFldArr) to High(fOpenFldArr) do
    if fOpenFldArr[I] = aField then
     Exit
    else
     Inc(Result, fldLength[fOpenFldArr[I]]);
  end
  else
  begin
   for I := Low(JournaledFldArr) to High(JournaledFldArr) do
    if JournaledFldArr[I] = aField then
     Exit
    else
     Inc(Result, fldLength[JournaledFldArr[I]]);
  end;

  // если пришли сюда, значит aField не найден в fOpenFldArr (или JournaledFldArr)
  raise EHtErrors.CreateInt(ecNotFound);
 end;

var
 lSab : Sab;
begin
 if (fItemList = nil) then
  begin
   lSab := MakeAllRecordsSab;
   try
    fItemList:=TdtDictItems.MakeSorted;
    TmpMode.openMode:=ROPEN_READ;
    if not (fDictType in sJournaled) then
    begin
     TmpMode.Count:=cCommonFldCount;
     TmpMode.FldArr:=@fOpenFldArr;
    end
    else
    begin
     TmpMode.Count:=JournaledFldCount;
     TmpMode.FldArr:=@JournaledFldArr;
    end;

    TmpList:=TAbstractList.Create(@lSab,TmpMode);
    TmpList.ReadForvard:=True;
    Try
     fItemList.Capacity:=TmpList.Count;
     //fItemList.Changing;
     Try
      For I:=0 to TmpList.Count-1 do
       begin
        TmpRec:=TmpList.GetItem(I);                                                 
        TmpItem:=fDictItemClass.Create;
        Try
         // Id
         TmpID:=0;
         l3Move((TmpRec + PosInTmpRec(dtIDFld))^,
               TmpID,
               fldLength[dtIDFld]);
         TmpItem.Handle:=TmpID;
         // Name
         TmpItem.AsWStr := l3RTrim(l3PCharLen(PAnsiChar(@TmpRec[PosInTmpRec(fNameFld)]), fldLength[fNameFld], GlobalDataProvider.BaseLanguage[CurrentFamily].ANSICodePage), [#0, #32]);
         //TmpItem.SetSt(@TmpRec[PosInTmpRec(fNameFld)],fldLength[fNameFld]);
         //TmpItem.RTrim;

         if (fDictType in sJournaled) then
         begin
          // Operation
          TmpID:=0;
          l3Move((TmpRec + PosInTmpRec(dtOperationFld))^,
               TmpID,
               fldLength[dtOperationFld]);
          TJournaledDictItem(TmpItem).Operation:=TOperActionType(TmpID);
          // NewID
          TmpID:=0;
          l3Move((TmpRec + PosInTmpRec(dtNewIDFld))^,
               TmpID,
               fldLength[dtNewIDFld]);
          TJournaledDictItem(TmpItem).NewID:=TDictID(TmpID);
          // Comment
          TJournaledDictItem(TmpItem).Comment :=
           l3ArrayToString((TmpRec + PosInTmpRec(dtCommentFld))^,
                         fldLength[dtCommentFld]);
         end;

         fItemList.Add(TmpItem);
        finally
         l3Free(TmpItem);
        end;
       end;
     finally
      //fItemList.Changed;
     end;
    finally
     l3Free(TmpList);
    end;
   finally
    htClearResults(lSab);
   end;
  end;
end;

procedure TDictionaryTbl.RegetItemList;
begin
 if Assigned(fItemList) then
 begin
  l3Free(fItemList);
  GetItemList;
 end;
end;

procedure TDictionaryTbl.setDictItemClass(aVal : TDictItemClass);
begin
 if (fItemList = nil) then
  fDictItemClass:=aVal
 else
  raise EHtErrors.CreateInt(ecNotEnable);
end;

function TDictionaryTbl.SortByName(CurSab : LPSAB) : Sab;
begin
 htSortResults(Result,CurSab^,@fNameFld,1);
end;

procedure TDictionaryTbl.FillListFromSab(aSab : Sab;aList : TPersistent;
                                         Caps : Boolean);
var
 lSab   : ISab;
 lStub : TdtRecAccessProc;

 lSaveState : Boolean;

 function lRecAccessProc(aRec : PAnsiChar) : Boolean;
 var
  lID  : TDictID;
  lStr : AnsiString;
 begin
  Result := True;
  lID := 0;
  l3Move(aRec[0], lID, IDSize);
  lStr := l3ArrayToString(aRec[fldLength[dtIDFld]], FldLength[fNameFld]);
  lStr := AdornNodeName(lID, lStr);
  if Caps then
   m2XLTConvertBuff(PAnsiChar(lStr), Length(lStr), Cm2XLTANSI2Upper);
  if aList is TStrings then
   TStrings(aList).AddObject(lStr,TObject(lID))
  else
  if aList is Tl3StringDataList then
   Tl3StringDataList(aList).AddStr(lStr, @lID);
 end;

begin
 lSab := MakeSab(Self, aSab);
 if lSab.IsEmpty then Exit;

 if aList is Tl3StringDataList then
 begin
  lSaveState := Tl3StringDataList(aList).NeedAllocStr;
  Tl3StringDataList(aList).NeedAllocStr := False;
 end;

 lStub := L2RecAccessProc(@lRecAccessProc);
 try
  {$IfOpt D+}
  try
  {$EndIf}

   lSab.IterateRecords(lStub, MakeFieldArray([fOpenFldArr[1], fOpenFldArr[2]]));

  {$IfOpt D+}
  except
   l3System.Msg2Log(SysUtils.Format('Ловим HTErr = 63 Dict = %d, Openfld1 = %d, Openfld2 = %d',
                                      [ord(fDictType), fOpenFldArr[1], fOpenFldArr[2]]));

   l3System.Msg2Log(SysUtils.Format('lSab.Count = %d, lSab.TypeOfSab = %d',
                                      [lSab.Count, lSab.TypeOfSab]));

   l3System.Msg2Log(SysUtils.Format('FldLen1 = %d, FldLen2 = %d',
                                      [GetFldLength(fOpenFldArr[1]), GetFldLength(fOpenFldArr[2])]));

   raise;
  end;
  {$EndIf}
 finally
  FreeRecAccessProc(lStub);
 end;

 if aList is Tl3StringDataList then
  Tl3StringDataList(aList).NeedAllocStr := lSaveState;
end;

procedure TDictionaryTbl.GetDictList(aList : TPersistent;Caps : Boolean);
var
 lSab : Sab;
begin
 lSab := MakeAllRecordsSab;
 try
  if aList is TStrings then
  begin
   TStrings(aList).BeginUpdate;
   try
    TStrings(aList).Clear;
    if lSab.gFoundCnt = 0 then
     exit;

    FillListFromSab(lSab,aList,Caps);
   finally
    TStrings(aList).EndUpdate;
   end;
  end;
  if aList is Tl3StringDataList then
  begin
   Tl3StringDataList(aList).Changing;
   try
    Tl3StringDataList(aList).Clear;
    Tl3StringDataList(aList).DataSize:=IDSize;
    Tl3StringDataList(aList).NeedAllocStr:=True;
    if lSab.gFoundCnt = 0 then
     exit;

    FillListFromSab(lSab,aList,Caps);
   finally
    Tl3StringDataList(aList).Changed;
   end;
  end;
 finally
  htClearResults(lSab);
 end;
end;

procedure TDictionaryTbl.GetDictListOnSab(Values : SAB;aList : TPersistent;
                                          Caps : Boolean);
var
 TmpSab : Sab;
 lSaveState : boolean;
begin
 if aList is TStrings then
  begin
   TStrings(aList).BeginUpdate;
   try
    TStrings(aList).Clear;

    if (Values.gFoundCnt=0) then
     exit;

    htTransferToTable(Values,Handle,dtIDFld);
    htRecordsByKey(TmpSab,Values);
    if (TmpSab.gFoundCnt=0) then
     exit;

    Try
     FillListFromSab(TmpSab,aList,Caps);
    finally
     htClearResults(TmpSab);
    end;
   finally
    TStrings(aList).EndUpdate;
   end;
  end;
 if aList is Tl3StringDataList then
  begin
   Tl3StringDataList(aList).Changing;
   try
    Tl3StringDataList(aList).Clear;
    Tl3StringDataList(aList).DataSize:=IDSize;
    lSaveState := Tl3StringDataList(aList).NeedAllocStr;
    try
     Tl3StringDataList(aList).NeedAllocStr:=False;

     if (Values.gFoundCnt=0) then
      exit;

     htTransferToTable(Values,Handle,dtIDFld);
     htRecordsByKey(TmpSab,Values);
     if (TmpSab.gFoundCnt=0) then
     exit;

     Try
      FillListFromSab(TmpSab,aList,Caps);
     finally
      htClearResults(TmpSab);
     end;
    finally
     Tl3StringDataList(aList).NeedAllocStr := lSaveState;
    end;
   finally
    Tl3StringDataList(aList).Changed;
   end;
  end;
end;

procedure TDictionaryTbl.GetIndexDictList(aList : Tl3StringDataList;
                                          ConvertToOEM : Boolean;
                                          Caps : Boolean);
var
 lRec       : PAnsiChar;
 lName      : PAnsiChar;
 lID        : TDictID;
 lNameLen   : Word;

 TmpList    : TAbstractList;
 TmpMode    : TOpenMode;
 I          : Longint;

 lSab       : ISab;
 lSabCursor : ISabCursor;

begin
 if Not IsTableOpened then raise EHtErrors.CreateInt(ecTblNotOpen);

 aList.Changing;
 try
  aList.Clear;
  aList.NeedAllocStr:=False;
  aList.DataSize:=SizeOf(Word);
  aList.Count:=GetMaxID+1;
  lSab := MakeSab(TdtTable(Self));
  lSab.SelectAll;
  with lSab.MakeSabCursor(MakeFieldArray([fOpenFldArr[1], fOpenFldArr[2]]), cmForward, ROPEN_READ) do
   for I := 0 to Pred(Count) do
   begin
    lRec := GetItem(I);
    lID := 0;
    l3Move(lRec[0], lID, IDSize);

    lNameLen := l3SizeOfTextArray(@lRec[fldLength[fOpenFldArr[1]]], FldLength[fOpenFldArr[2]]);

    lName := l3AllocPChar(lRec[fldLength[fOpenFldArr[1]]], lNameLen);

    if ConvertToOEM then m2XLTConvertBuff(lName, lNameLen, Cm2XLTANSI2OEM);

    aList.Strings[lID] := lName;
    aList.Data[lID] := @lNameLen;
   end;
 finally
  aList.Changed;
 end;
end;

function TDictionaryTbl.GetNameStr(aID : TDictID) : AnsiString;
var
 lName  : PAnsiChar;
 tmpIndex : Longint;
 lRecID   : Longint;
begin
 if Assigned(fItemList) and
    (fNameFld = dtNameRFld) then
  begin
   if fItemList.FindData(aID,tmpIndex) then
     Result:=TDictItem(fItemList.Items[tmpIndex]).AsString
    else
     Result := Format('#%d',[aID]);
     //raise EHtErrors.CreateInt(ecNotFound);
  end
 else
  begin
   lRecID := GetRecordIDByUniq(dtIDfld, aID);
   if lRecID <= 0 then raise EHtErrors.CreateInt(ecNotFound);
   GetFullRec(lRecID, False);
   GetFromFullRec(fNameFld, lName);
   Try
    Result := StrPas(lName);
   finally
    l3StrDispose(lName);
   end;
  end;
end;

procedure TDictionaryTbl.IterateAllDict(Action : Tl3IteratorAction; NeedSort: Boolean = False);
var
 TmpRec,
 HStr     : PAnsiChar;
 TmpID    : TDictID;

 TmpList  : TAbstractList;
 TmpMode  : TOpenMode;
 I        : LongInt;

 lSab : ISab;
begin
 lSab := MakeAllRecords(Self);
 if lSab.Count = 0 then
  exit;

 if NeedSort then
  lSab.Sort([fNameFld]);

 TmpMode.openMode:=ROPEN_READ;
 TmpMode.Count:=cCommonFldCount;
 TmpMode.FldArr:=@fOpenFldArr;

 TmpList := TAbstractList.Create(lSab.HTSabAddr, TmpMode);
 TmpList.ReadForvard:=True;
 Try
  For I:=0 to TmpList.Count-1 do
   begin
    TmpRec:=TmpList.GetItem(I);
    TmpID:=0;
    l3Move(TmpRec[0], TmpID, IDSize);
    HStr:=l3AllocPChar(TmpRec[fldLength[dtIDFld]], FldLength[fNameFld]);
    Try
     if Not Action(HStr,TmpID) then Break;
    finally
     l3StrDispose(HStr);
    end;
   end;
 finally
  l3Free(TmpList);
 end;
end;

function TDictionaryTbl.AddDictItem(aID: TDictID;
                                    const aNameR, aNameE, aShortName: Tl3WString;
                                    aIsPrivate: TIsPrivate = cEmptyByte;
                                    aIsNonperiodic: TIsNonperiodic = cEmptyByte): IDictItem;
Const
 TmpName  : AnsiString = 'Имя не задано';
var
 tmpItem  : TDictItem;
 l_NameR : Tl3WString;
begin
 if l3IsNil(aNameR) and l3IsNil(aShortName) then
  raise EHtErrors.CreateInt(ecNotEnable);

 if aID = cUndefDictID then
  aID := GetFreeNum
 {else
  ClaimFreeNum(aID)};
 ClearFullRec;
 PutToFullRec(dtIDfld,aID);
 if l3IsNil(aNameR) then
  l_NameR := l3PCharLen(tmpName)
 else
  l_NameR := aNameR;
 PutWStrToFullRec(dtNameRFld, l_NameR);
 if not l3IsNil(aNameE) then
  PutWStrToFullRec(dtNameEFld, aNameE);
 if not l3IsNil(aShortName) then
  PutWStrToFullRec(dtShNameFld, aShortName);
 if (DictType in sWithIsPrivateField) and (aIsPrivate <> cEmptyByte) then
  PutToFullRec(dtIsPrivate, aIsPrivate);
 if (DictType in sWithNonperiodicField) and (aIsNonperiodic <> cEmptyByte) then
  PutToFullRec(dtIsNonperiodic, aIsNonperiodic);

 AddFRec;

//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalHTDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoAdd);

 tmpItem:=fDictItemClass.Create;
 Try
  tmpItem.Handle:=aID;
  if gBiLingual then
   tmpItem.AsWStr := aNameE
  else
   tmpItem.AsWStr := aNameR;

  ItemList.Add(tmpItem);
  Result:=tmpItem;
 finally
  l3Free(tmpItem);
 end;
end;

procedure TDictionaryTbl.EditDictItem(aID: TDictID;
                                      const aNameR, aNameE, aShortName: Tl3WString;
                                      aIsPrivate: TIsPrivate = cEmptyByte;
                                      aIsNonperiodic: TIsNonperiodic = cEmptyByte);
var
 RecH     : RHandle;
 AbsN     : LongInt;
 tmpIndex : LongInt;

 lNeedEngEdit : boolean;

 lEngName : AnsiString;
 l_NameE  : Tl3WString;

 procedure lGetFromFullRec(aField : ThtField; var theStr : AnsiString);
 var
  lStr : PAnsiChar;
 begin
  GetFromFullRec(aField, lStr);
  try
   theStr := StrPas(lStr);
  finally
   l3StrDispose(lStr);
  end;
 end;

begin
 lNeedEngEdit := False;
 l_NameE := aNameE;
 AbsN := GetRecordIDByUniq(dtIDfld, aID);
 if AbsN > 0 then
 begin
  GetFullRec(AbsN,True);
  try
   if not l3IsNil(aNameR) then
   begin
    PutWStrToFullRec(dtNameRFld, aNameR);
    lNeedEngEdit := True;
   end;

   if not l3IsNil(l_NameE) then
    PutWStrToFullRec(dtNameEFld, l_NameE)
   else
    if lNeedEngEdit then
    begin
     lGetFromFullRec(dtNameEFld, lEngName);
     lEngName := cWrongEnglishMark + lEngName;
     l_NameE := l3PCharLen(lEngName);
     PutWStrToFullRec(dtNameEFld, l_NameE);
    end;

   if not l3IsNil(aShortName) then
    PutWStrToFullRec(dtShNamefld, aShortName);
   if (DictType in sWithIsPrivateField) and (aIsPrivate <> cEmptyByte) then
    PutToFullRec(dtIsPrivate, aIsPrivate);
   if (DictType in sWithNonperiodicField) and (aIsNonperiodic <> cEmptyByte) then
    PutToFullRec(dtIsNonperiodic, aIsNonperiodic);

   UpdFRec(AbsN);
  finally
   FreeRec(AbsN);
  end;
 end
  else
   raise EHtErrors.CreateInt(ecNotFound);

//!! !!! Возможно тут нужен GlobalHTDataProvider
 GlobalDataProvider.Journal.LogEditDict(TblFamily, fDictType, da_eoEdit);

 if Assigned(fItemList) then
  if fItemList.FindData(aID,tmpIndex) then
   case fNameFld of
    dtNameRFld: TDictITem(fItemList.Items[tmpIndex]).AsWStr := aNameR;
    dtNameEFld: TDictITem(fItemList.Items[tmpIndex]).AsWStr := l_NameE;
   end;
end;

procedure TDictionaryTbl.AddData(var theID : TDictID;aData : PAnsiChar);
var
 tmpItem : TDictItem;
 CurName : PAnsiChar;
begin
 Inherited;

 GetFromFullRec(dtNameRFld, CurName);
 Try
  tmpItem:=fDictItemClass.Create;
  Try
   tmpItem.Handle := theID;
   tmpItem.SetSt(CurName,StrLen(CurName));
   ItemList.Add(tmpItem);
  finally
   l3Free(tmpItem);
  end;
 finally
  l3StrDispose(CurName);
 end;
end;

procedure TDictionaryTbl.EditData(aID : TDictID;aData : PAnsiChar);
var
 tmpIndex: LongInt;
begin
 Inherited;

 if Assigned(fItemList) then
  if fItemList.FindData(aID,tmpIndex) then
   TDictItem(fItemList.Items[tmpIndex]).SetData(aData, Self);
end;

procedure TDictionaryTbl.EditNonKeyFields(aID : TDictID; aField : Word; aValue : Pointer);
var
 AbsN    : LongInt;
begin
 AbsN := GetRecordIDByUniq(dtIDfld, aID);
 if AbsN > 0 then
 begin
  GetFullRec(AbsN, True);
  try
   case ElementType[aField] of
    ET_CHAR,
    ET_ARRA : PutToFullRec(aField,aValue);

    ET_BYTE,
    ET_INTR,
    ET_WORD,
    ET_DATE,
    ET_NMBR,
    ET_LONG,
    ET_DWRD,
    ET_FLOA,
    ET_CURR,
    ET_DFLT : PutToFullRec(aField,aValue^);
   end;
   UpdFRec(AbsN);
  finally
   FreeRec(AbsN);
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotFound);
end;

procedure TDictionaryTbl.ChangeDictField(aField : ThtField; var theOldValue; var theNewValue);
var
 lSab  : ISAB;
 lStub : TdtRecAccessProc;

 function lRecAccessProc(aRec : Pointer) : Boolean;
 var
  lIndex : Integer;
 begin
  Result := True;
  if fItemList.FindData(PDictID(aRec)^, lIndex) then
  case aField of
   dtOperationFld:
    TJournaledDictItem(fItemList.Items[lIndex]).Operation := TOperActionType(PByte(theNewValue)^);
   dtNewIDFld:
    TJournaledDictItem(fItemList.Items[lIndex]).newID := PDictID(theNewValue)^;
  end;
 end;

begin
 lSab := MakeSab(Self);
 lSab.Select(aField, theOldValue);
 if lSab.IsEmpty then
  Exit;

 lSab.ModifyRecs(aField, theNewValue);

 if (fDictType in sJournaled) and
       (aField in [dtOperationFld,dtNewIDFld]) and
       Assigned(fItemList) then
 begin
  lStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lStub, [dtIDFld]);
  finally
   FreeRecAccessProc(lStub);
  end;
 end;
end;

function TDictionaryTbl.iCheckItemInList(aID : TDictID) : IDictItem;
var
 lIndex : Longint;
begin
 Result:=nil;
 if ItemList.FindData(aID, lIndex) then
  Result := TDictItem(ItemList.Items[lIndex]);
end;

(*
function TDictionaryTbl.bCheckItemInList(aID : TDictID) : Boolean;
var
 lIndex : Longint;
begin
 Result := ItemList.FindData(aID, lIndex);
end;
*)

function TDictionaryTbl.CheckExists(aDictID : TDictID) : Boolean;
var
 lIndex : Longint;
begin
 if fItemList <> nil then
  Result := fItemList.FindData(aDictID, lIndex)
 else
  Result := HasUniqRec(aDictID);

end;

procedure TDictionaryTbl.DelData(aID : TDictID);
var
 lIndex : Longint;
begin
 if ItemList.FindData(aID, lIndex) then
  fItemList.Delete(lIndex);

 Inherited;
end;

function TDictionaryTbl.ReceiveGetNode(aID : TDictID) : IDictItem;
var
 AbsN       : LongInt;
 {RecH       : RHandle;}
 tmpItem    : TDictItem;
 newNodeFl  : Boolean;
 tmpIndex   : LongInt;
 tmpName    : PAnsiChar;

 tmpID      : TDictID;
 tmpComment : PAnsiChar;

begin
 Result:=nil;
 newNodeFl:=False;
 AbsN := GetRecordIDByUniq(dtIDfld, aID); 
 if AbsN > 0 then
 begin
  GetFullRec(AbsN,False);
  GetFromFullRec(dtNameRFld,tmpName);
  try
   if Assigned(fItemList) then
   begin
    if fItemList.FindData(aID,tmpIndex) then
     tmpItem:=TDictItem(fItemList.Items[tmpIndex])
    else
    begin
     tmpItem:=fDictItemClass.Create;
     newNodeFl:=True;
    end;
    try
     tmpItem.Handle:=aID;
     tmpItem.SetSt(tmpName);

     if (fDictType in sJournaled) then
     begin
      tmpID:=0;
      GetFromFullRec(dtOperationFld,tmpID);
      TJournaledDictItem(TmpItem).Operation:=TOperActionType(tmpID);
      tmpID:=0;
      GetFromFullRec(dtNewIDFld,tmpID);
      TJournaledDictItem(TmpItem).NewID:=TDictID(tmpID);

      GetFromFullRec(dtCommentFld,tmpComment);
      try
       TJournaledDictItem(TmpItem).Comment:=AnsiString(tmpComment);
      finally
       l3StrDispose(tmpComment);
      end;
     end;

     if newNodeFl then
      fItemList.Add(tmpItem);

     Result:=tmpItem;
    finally
     if newNodeFl then l3Free(tmpItem);
    end;
   end;
  finally
   l3StrDispose(tmpName);
  end;
 end;
end;

procedure TDictionaryTbl.ReceiveDelNode(aID : TDictID);
var
 tmpIndex : LongInt;
begin
 if Assigned(fItemList) and fItemList.FindData(aID,tmpIndex) then
  fItemList.Delete(tmpIndex);
end;

procedure TDictionaryTbl.SetDelNumber(aID : TDictID);
var
 lFileName : TFileName;
 FlH       : Tl3FileStream;
begin
 lFileName:=GlobalHtServer.FamilyTbl.FamilyPath(TblFamily)+TblName+'.Del';
 FlH:=Tl3FileStream.Create(lFileName,l3_fmExclusiveAppend);
 try
  FlH.WriteBuffer(aID,SizeOf(aID));
 finally
  l3Free(FlH);
 end;
end;

procedure TDictionaryTbl.GetDelNumbers(aList : Tl3LongintList);
var
 lFileName : TFileName;
begin
 aList.Clear;
 lFileName:=GlobalHtServer.FamilyTbl.FamilyPath(TblFamily)+TblName+'.Del';
 if not l3FileUtils.FileExists(lFileName) then
  exit
 else
  aList.LoadFromFile(lFileName);
end;

procedure TDictionaryTbl.ClearDelNumbers;
var
 lFileName : AnsiString;
begin
 lFileName:=GlobalHtServer.FamilyTbl.FamilyPath(TblFamily)+TblName+'.Del';
 SysUtils.DeleteFile(lFileName);
end;

function TDictionaryTbl.SearchInName(CurSab : LPSAB; aNameMask : PAnsiChar) : Sab;
var
 lBT : Tl3BMTable;
 lMatchString   : PAnsiChar;
 lMatchWStr     : Tl3WString;

  function lFilterOnName(aRecNo : LongInt; aName : PAnsiChar) : SmallInt;
  var
   Pos : Cardinal;
  begin
   if l3SearchStrUC(l3PCharLen(aName,fldLength[fNameFld]), lBT, lMatchWStr, Pos) then
    Result:=1
   else
    Result:=0;
  end;

var
 lHTStub : Pointer;
begin
 lMatchString := aNameMask;
 m2XLTConvertBuff(lMatchString, StrLen(lMatchString), Cm2XLTANSI2Upper);
 BMMakeTable(lMatchString, lBT, StrLen(lMatchString));
 lMatchWStr := l3PCharLen(lMatchString);

 lHTStub := HTStub3(@lFilterOnName);
 try
  htFilterRecords(Result, CurSab^, @fNameFld, 1, lHTStub, Self);
 finally
  HTStubFree(lHTStub);
 end;
end;

function TDictionaryTbl.HasRecordWithName(const aName: AnsiString;
                                          aDoFlushCache: Boolean = True): Boolean;
var
 l_FoundRecs: Sab;
begin
 if aDoFlushCache then
  FlushCache;

 htSearch(nil, l_FoundRecs, Handle, fNameFld, EQUAL, PAnsiChar(aName), nil);
 Ht(l_FoundRecs.nRetCode);
 try
  Result := l_FoundRecs.gFoundCnt > 0;
 finally
  htClearResults(l_FoundRecs);
 end;
end;

function TDictionaryTbl.GetIsNonperiodic(aID: TDictID): TIsNonperiodic;
var
 lRecID : Longint;
begin
 CheckDictType([da_dlCorSources]);
 lRecID := GetRecordIDByUniq(dtIDfld, aID);
 if lRecID <= 0 then
  raise EHtErrors.CreateInt(ecNotFound);
 GetFullRec(lRecID, False);
 GetFromFullRec(dtIsNonperiodic, Result);
end;

procedure TDictionaryTbl.CheckDictType(aAllowedTypes: TDLTypeSet);
begin
 if not (DictType in aAllowedTypes) then
  raise EHtErrors.Create('Выполняемая операция не допустима для словаря ' + TblName);
end;

{ TDictRootNode }

Constructor TDictRootNode.CreateWithInit(aDict : TDictionary);
begin
 Inherited Create;
 fDict := aDict;
 //fDictType := fDict.DictType;
 fChildNodeClass:=TDictLeafNode;
 OpenTreeObj;
 //fTreeChanged:=False;
 fIsEqualLoaded:=False;
end;

(*procedure TDictRootNode.BeforeRelease;
begin
 Try
  if fTreeChanged then Save;
 finally
  Inherited;
 end;
end;
*)

procedure TDictRootNode.Cleanup;
begin
 CloseTreeObj;
 fDict := Nil;
 Inherited;
end;

function TDictRootNode.GetDictRootNode : TDictAbsNode;
begin
 Result:=Self;
end;

procedure TDictRootNode.setChildNodeClass(aVal : TDictLeafNodeClass);
begin
 if not hasChild then
 begin
  fChildNodeClass:=aVal;
  fTreeObj.ChildNodeClass:=fChildNodeClass;
 end
 else
  raise EHtErrors.CreateInt(ecNotEnable);
end;

procedure TDictRootNode.ChangeLoadEqualsState(aVal : Boolean);
begin
 if fIsEqualLoaded <> aVal then
  if aVal then
  begin
   Changing;
   try
    fIsEqualLoaded := fDict.LoadEqualClassesToTree;
   finally
    Changed;
   end;
  end
  else
   // В этом месте можно подключить операцию удаления эквивалентных классов
   // из дерева. Пока такая операция не требуется, генерится exception.
   raise EHtErrors.CreateInt(ecNotEnable);
end;

function TDictRootNode.di_Get_Handle : TDictID;
begin
 Result:=0;
end;

function TDictRootNode.di_Get_Name : Tl3PCharLenPrim;
begin
 l3AssignNil(Result);
 //Result:=Nil;
end;

function TDictRootNode.di_Get_LinkFlag : Boolean;
begin
 Result:=False;
end;

procedure TDictRootNode.di_Set_LinkFlag(Value : Boolean);
begin
end;

function TDictRootNode.di_Get_DataStr : AnsiString;
begin
 Result:='';
end;

procedure TDictRootNode.di_Set_DataStr(Value : AnsiString);
begin
end;

function TDictRootNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 Result := l3PCharLen(cDLPassports[fDict.DictType].rName);
end;

function TDictRootNode.pm_GetHandle : Integer;
begin
 Result:=0;
end;

procedure TDictRootNode.CloseTreeObj;
begin
 if Assigned(fTreeObj) then
 begin
  l3Free(fTreeObj);
 end;
end;

procedure TDictRootNode.OpenTreeObj;
begin
 if not Assigned(fTreeObj) then
 begin
  fTreeObj:=TTreeStrorage.Create(Copy(fDict.DictTbl.TblFullName,1,
                                 Length(fDict.DictTbl.TblFullName)-1));
  fTreeObj.ChildNodeClass:=fChildNodeClass;
 end;
end;

procedure TDictRootNode.Load;
var
 CurChild   : TDictLeafNode;
 tmpIndex   : LongInt;

 function IterHandler1(const CurNode : Il3Node) : Boolean; far;
 begin
  if fDict.DictTbl.ItemList.FindData((CurNode as Il3HandleNode).Handle,tmpIndex) then
   begin
    (CurNode as IDictNode).dn_SetDictItem(TDictItem(fDict.DictTbl.ItemList.Items[tmpIndex]));
    TDictItem(fDict.DictTbl.ItemList.Items[tmpIndex]).dip_Set_LinkNode(CurNode);
   end;
  Result:=False;
 end;

 function IterHandler2(Data : Pointer;Index : LongInt) : Boolean; far;
 begin
  CurChild:=ChildNodeClass.Create;
  try
   CurChild.fDictRec:=TDictItem(Data^);
   TDictItem(Data^).dip_Set_LinkNode(Il3Node(CurChild));
   InsertChild(CurChild);
  finally
   l3Free(CurChild);
  end;
  Result:=True;
 end;

 function IterHandler3(Data : Pointer;Index : LongInt) : Boolean; far;
 begin
  if TDictItem(Data^).LinkNode = Nil then
   begin
    CurChild:=ChildNodeClass.Create;
    try
     CurChild.fDictRec:=TDictItem(Data^);
     TDictItem(Data^).dip_Set_LinkNode(Il3Node(CurChild));
     InsertChild(CurChild);
    finally
     l3Free(CurChild);
    end;
   end;
  Result:=True;
 end;

begin
 if Not fTreeObj.IsEmpty then
  begin
   ReleaseChilds;
   fTreeObj.Load(Self);
   IterateF(l3L2NA(@IterHandler1),0);
   //fTreeChanged:=False;

 (*
   // Add missing items from dict to tree
   //if fDictType = dlNewClasses then
   begin
    fDict.DictTbl.ItemList.IterateAllF(l3L2IA(@IterHandler3));
    fTreeChanged:=True;
   end;
*)
  end
 else
  begin
   ReleaseChilds;
   fDict.DictTbl.ItemList.IterateAllF(l3L2IA(@IterHandler2));
   //fTreeChanged:=False;
  end;
 fIsEqualLoaded:=False;
end;

procedure TDictRootNode.StartReload; // начинаем процесс загрузки словаря из внешнего источника, заканчиваем вызовом Save
begin
 ClearAllData;
 fInReload := True;
end;

procedure TDictRootNode.Save;
begin
 if not fInReload then
 begin
  l3System.Stack2Log(Format('Непонятный вызов TDictRootNode.Save dict=%s', [GetEnumName(TypeInfo(TdaDictionaryType), ord(fDict.DictType))]));
  Exit;
 end;
 fTreeObj.Save(Self);
 fInReload := false;
end;

procedure TDictRootNode.ClearAllData;
begin
 fTreeObj.Clear;
 ReleaseChilds;
 //fTreeChanged:=False;
end;

procedure TDictRootNode.DataChanged(aOperation : TOperActionType;
                                    aID,aParentID,aNextID : TDictID);
begin
 if fInReload then Exit;
 fTreeObj.AddChangeRec(aOperation,aID,aParentID,aNextID);
 if aOperation = atMove then
  fDict.SendEditMessage(atMove,aID,aParentID,aNextID);
 //fTreeChanged := True;
 {$IFNDEF EnableClassEdit}
 if fDict.DictType = da_dlClasses then
  l3System.Stack2Log('Модификация дерева классов');
 {$ENDIF}
end;

procedure TDictRootNode.DeleteFromTbl(aID, aHairID: TDictID; aDateToDelete: TDateTime);
begin
 fDict.DelDictItemFromTbls(aID, aHairID);
end;

procedure TDictRootNode.EditNameInTbl(aID : TDictID; const aName : Tl3WString);
begin
 fDict.EditDictItemInTblEx(aID, aName, l3PCharLen, l3PCharLen);
end;

procedure TDictRootNode.EditNonKeyValueInTbl(aID : TDictID; aFld : Word; aValue : Pointer);
begin
 fDict.EditNonKeyValueInTbl(aID, aFld, aValue);
end;

procedure TDictRootNode.ChangeKeyValues(aFld : ThtField; var theOldValue; var theNewValue);
begin
 fDict.ChangeKeyValues(aFld, theOldValue, theNewValue);
end;

function TDictRootNode.CheckItem(aID : TDictID) : IDictItem;
begin
 Result:= fDict.CheckItem(aID);
end;

procedure TDictRootNode.AddEqualToTbl(aFirstID,aSecondID : TDictID);
begin
 fDict.AddEqualToTbl(aFirstID, aSecondID);
end;

procedure TDictRootNode.DelEqualFromTbl(aFirstID,aSecondID : TDictID);
begin
 fDict.DelEqualFromTbl(aFirstID, aSecondID);
end;

function  TDictRootNode.AddExtItemTbl(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
begin
 Result := fDict.AddExtItemTbl(aParentNode, aRec);
end;

procedure TDictRootNode.EditExtItemTbl(aRec : Pointer);
begin
 fDict.EditExtItemTbl(aRec);
end;

procedure TDictRootNode.DelExtItemTbl(aItemID: TDictID; aHairID : TDictID = cUndefDictID);
begin
 fDict.DelExtItemTbl(aItemID, aHairID);
end;

procedure TDictRootNode.DeleteEx(aHeirID : TDictID = cUndefDictID);
begin
 DoDelete;
 // тут надо все дерево грохнуть?
end;

{ TDictLeafNode }

procedure TDictLeafNode.Cleanup;
begin
 if Assigned(fDictRec) then
 begin
  (fDictRec as IDictItemPro).dip_LinkDisconnect;
  fDictRec:=nil;
 end;
 Inherited;
end;

procedure TDictLeafNode.pm_SetParent(Value : Tl3Node);
begin
 if (Value <> Nil) and Not (Value is TDictAbsNode) then
  raise El3InsertDenied.Create('');
 Inherited;
end;

procedure TDictLeafNode.DoDelete;
begin
 DeleteEx;
end;

procedure TDictLeafNode.DeleteEx(aHeirID: TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
var
 lCurID : TDictID;
 lRoot : TDictRootNode;
begin
 if fDictRec = nil then
  lCurID := Handle
 else
  lCurID := fDictRec.Handle;

 while ChildNode <> nil do
  ChildNode.Delete;

 dn_BeforeDelete;
 lRoot := GetRootNode;
 lRoot.DeleteFromTbl(lCurID, aHeirID, aDateDeleted);

 inherited DoDelete;
 lRoot.DataChanged(atDelete,lCurID,0,0);
end;

procedure TDictLeafNode.MovingStopped(aUserParam : Pointer);
begin
 Inherited;
 if Parent <> nil then
  if IsLast then
   RootNode.DataChanged(atMove,fDictRec.Handle,(Parent as IDictItem).Handle,0)
  else
   RootNode.DataChanged(atMove,fDictRec.Handle,(Parent as IDictItem).Handle,
                        (Next as IDictItem).Handle);
end;

function TDictLeafNode.GetDictRootNode : TDictAbsNode;
begin
 Result:=TDictAbsNode(Parent).GetDictRootNode;
end;

function TDictLeafNode.GetRootNode : TDictRootNode;
begin
 Result:=TDictRootNode(GetDictRootNode);
end;

function TDictLeafNode.dn_IsLastEntry : Boolean;
begin
 if Assigned(fDictRec) then
  Result:=(fDictRec as IDictItemPro).dip_RefCount = 2
 else
  Result:=True;
end;

procedure TDictLeafNode.dn_BeforeDelete(aNewID : TDictID);
begin
 if Assigned(fDictRec) then
  begin
   (fDictRec as IDictItemPro).dip_LinkDisconnect;
   fDictRec:=nil;
  end;
end;

procedure TDictLeafNode.dn_SetDictItem(aDictItem : IDictItem);
begin
 fDictRec:=aDictItem;
end;

function TDictLeafNode.pn_CheckSaveStatus : boolean;
begin
 Result:=True;
end;

function TDictLeafNode.di_Get_Handle : TDictID;
begin
 if Assigned(fDictRec) then
  Result:=fDictRec.Handle
 else
  Result:=fHandle;
end;

function TDictLeafNode.di_Get_Name : Tl3PCharLenPrim;
begin
 Result := GetAsPCharLen;
end;

function TDictLeafNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 if Assigned(fDictRec) then
  Result := fDictRec.Name
 else
  Result := l3PCharLen(AnsiString(BrokenLeaf));
end;

procedure TDictLeafNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 if Assigned(fDictRec) then
  RootNode.EditNameInTbl(fDictRec.Handle, Value)
 else
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

function TDictLeafNode.pm_GetHandle : Integer;
begin
 if Assigned(fDictRec) then
  Result:=fDictRec.Handle
 else
  Result:=fHandle;
end;

procedure TDictLeafNode.pm_SetHandle(aVar : Integer);
begin
 fHandle := aVar;
end;

function  TDictLeafNode.GetDictNodeType : TDictNodeType;
begin
 Result := dntItem;
end;


{ TDictLeafNodeWithJournal }

procedure TDictLeafNodeWithJournal.dn_BeforeDelete(aNewID : TDictID);
var
 lDictID : TDictID;
begin
 if Assigned(fDictRec) then
 begin
  lDictID := fDictRec.Handle;
  RootNode.ChangeKeyValues(dtNewIDFld, lDictID, aNewID);
 end;
 inherited;
end;

function TDictLeafNodeWithJournal.dij_Get_Operation : TOperActionType;
begin
 if Assigned(fDictRec) then
  Result:=(fDictRec as IDictItemJour).Operation
 else
  Result:= atNone;
  //raise EHtErrors.CreateInt(ecNotAssigned);
end;

procedure TDictLeafNodeWithJournal.dij_Set_Operation(aVal : TOperActionType);
var
 newFlag : Byte;
 flagFld : Word;
begin
 if Assigned(fDictRec) then
 begin
  if (fDictRec as IDictItemJour).Operation <> aVal then
  begin
   (fDictRec as IDictItemJour).Operation:=aVal;
   newFlag:=Byte(aVal);
   flagFld:=dtOperationFld;
   RootNode.EditNonKeyValueInTbl(fDictRec.Handle,flagFld,@newFlag);
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

function TDictLeafNodeWithJournal.dij_Get_NewID : TDictID;
begin
 if Assigned(fDictRec) then
  Result:=(fDictRec as IDictItemJour).NewID
 else
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

procedure TDictLeafNodeWithJournal.dij_Set_NewID(aVal : TDictID);
var
 oldValue : TDictID;
 foundItem : IDictItem;
begin
 if Assigned(fDictRec) then
 begin
  if ((fDictRec as IDictItemJour).Operation = atDelete) then
  begin
   if ((fDictRec as IDictItemJour).NewID <> aVal) then
   begin
    if aVal <> 0 then
    begin
     if aVal = fDictRec.Handle then
      raise EHtErrors.CreateInt(ecNotEnable);
     foundItem:=RootNode.CheckItem(aVal);
     if foundItem <> nil then
     try
      if (foundItem as IDictItemJour).Operation = atDelete then
       raise EHtErrors.CreateInt(ecNotEnable);
     finally
      foundItem:=nil;
     end
     else
      raise EHtErrors.CreateInt(ecNotEnable);
    end;
    oldValue := fDictRec.Handle;
    RootNode.ChangeKeyValues(dtNewIDFld, oldValue, aVal);
    RootNode.EditNonKeyValueInTbl(fDictRec.Handle, dtNewIDFld, @aVal);
    (fDictRec as IDictItemJour).NewID:=aVal;
   end;
  end
  else
   raise EHtErrors.CreateInt(ecNotEnable);
 end
 else
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

function  TDictLeafNodeWithJournal.dij_Get_Comment : AnsiString;
begin
 if Assigned(fDictRec) then
  Result:=(fDictRec as IDictItemJour).Comment
 else
  Result:='';

  //raise EHtErrors.CreateInt(ecNotAssigned);
end;

procedure TDictLeafNodeWithJournal.dij_Set_Comment(aVal : AnsiString);
var
 commentFld : Word;
begin
 if Assigned(fDictRec) then
 begin
  if (fDictRec as IDictItemJour).Comment <> aVal then
  begin
   (fDictRec as IDictItemJour).Comment:=aVal;
   commentFld:=dtCommentFld;
   RootNode.EditNonKeyValueInTbl(fDictRec.Handle,commentFld,PAnsiChar(aVal));
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotAssigned);
end;

procedure TDictLeafNodeWithJournal.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
var
 newFlag : Byte;
 flagFld : Word;
begin
 inherited;

 if Assigned(fDictRec) and
    ((fDictRec as IDictItemJour).Operation <> atAdd) then
 begin
  (fDictRec as IDictItemJour).Operation:=atEdit;
  newFlag:=Byte(atEdit);
  flagFld:=dtOperationFld;
  RootNode.EditNonKeyValueInTbl(fDictRec.Handle,flagFld,@newFlag);
 end;
end;

procedure TDictLeafNodeWithJournal.MovingStarted(var theUserParam : Pointer);
var
 tmpItem : IDictItem;
begin
 if (Parent <> nil) and
    l3IOk(Parent.QueryInterface(IDictItem,tmpItem)) then
 begin
  theUserParam:=Pointer(tmpItem.Handle);
  tmpItem:=nil;
 end;
 inherited;
end;

procedure TDictLeafNodeWithJournal.MovingStopped(aUserParam : Pointer);
var
 tmpItem : IDictItem;
 newFlag : Byte;
 flagFld : Word;
begin
 inherited;
 if Assigned(fDictRec) and
    ((fDictRec as IDictItemJour).Operation <> atAdd) and
    (Parent <> nil) and
    l3IOk(Parent.QueryInterface(IDictItem,tmpItem)) then
  begin
   if (tmpItem.Handle <> TDictID(aUserParam)) then
   begin
    (fDictRec as IDictItemJour).Operation:=atEdit;
    newFlag:=Byte(atEdit);
    flagFld:=dtOperationFld;
    RootNode.EditNonKeyValueInTbl(fDictRec.Handle,flagFld,@newFlag);
   end
   else
    if (fDictRec as IDictItemJour).Operation = atNone then
    begin
     (fDictRec as IDictItemJour).Operation:=atMove;
     newFlag:=Byte(atMove);
     flagFld:=dtOperationFld;
     RootNode.EditNonKeyValueInTbl(fDictRec.Handle,flagFld,@newFlag);
    end;
   tmpItem:=nil;
  end;
end;

{TCustomExtItemNode}
function TCustomExtItemNode.dn_IsLastEntry : Boolean;
begin
 Result := True;
end;

procedure TCustomExtItemNode.dn_SetDictItem(aDictItem : IDictItem);
begin
end;

function TCustomExtItemNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 l3AssignNil(Result);
end;

procedure TCustomExtItemNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  {-}
begin
 raise EHtErrors.CreateInt(ecNotEnable);
end;

function TCustomExtItemNode.pm_GetHandle : Integer;
begin
  Result := 0;
end;

procedure TCustomExtItemNode.pm_SetHandle(aValue : Integer);
begin
 raise EHtErrors.CreateInt(ecNotEnable);
end;

procedure TCustomExtItemNode.pm_SetParent(aValue : Tl3Node);
begin
 if (aValue <> nil) and not (aValue is TDictLeafNode) then
  raise El3InsertDenied.Create('');
 inherited;
end;

function TCustomExtItemNode.DoMove(aDirection: Tl3Direction): Boolean;
begin
 Result := false;
end;

procedure TCustomExtItemNode.MovingStarted(var theUserParam : Pointer);
var
 tmpItem : Il3HandleNode;
begin
 if (Parent <> nil) and
    l3IOk(Parent.QueryInterface(Il3HandleNode, tmpItem)) then
 begin
  theUserParam := Pointer(tmpItem.Handle);
  tmpItem := nil;
 end;
 inherited;
end;

procedure TCustomExtItemNode.MovingStopped(aUserParam : Pointer);
var
 tmpItem : IDictItem;
begin
 inherited;
 {if (Parent <> nil) and
    l3IOk(Parent.QueryInterface(IDictItem,tmpItem)) and
    (tmpItem.Handle <> TDictID(aUserParam)) then
 begin
  TDictLeafNode(Parent).RootNode.DelEqualFromTbl(TDictID(aUserParam),Handle);
  TDictLeafNode(Parent).RootNode.AddEqualToTbl(tmpItem.Handle,Handle);
  Parent.Flags := Parent.Flags or cNodeHasEquals;
  tmpItem := nil;
 end;}
end;

procedure TCustomExtItemNode.DoDelete;
begin
 DeleteEx;
end;

procedure TCustomExtItemNode.DeleteEx(aHeirID : TDictID = cUndefDictID);
begin
 inherited DoDelete;
end;

{ TExtItemNode }
procedure  TExtItemNode.InitData(var theItemRec; aItemSize : Cardinal);
begin
 l3System.FreeLocalMem(fItemRec);
 fItemSize := 0;
 if aItemSize > 0 then
 begin
  fItemSize := aItemSize;
  l3System.GetLocalMem(fItemRec, fItemSize);
  l3Move(theItemRec, fItemRec^, fItemSize);
 end;
end;

procedure  TExtItemNode.Set_Data(aRec : Pointer);
begin
 if aRec <> fItemRec then // редактировали не внутренние данные
 l3Move(aRec^, fItemRec^, fItemSize);

 GetRootNode.EditExtItemTbl(aRec);

 //refresh
 fItemStr := '';
end;

function TExtItemNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 if (Length(fItemStr) = 0) and (fItemRec <> nil) then
  //Это поабстрактей надо переписать
  fItemStr := GenIssueString(PPublishedDictRec(fItemRec)^);
  Result := l3PCharLen(fItemStr);
end;

procedure TExtItemNode.Cleanup;
begin
 l3System.FreeLocalMem(fItemRec);
 fItemSize := 0;
 inherited;
end;

function TExtItemNode.pm_GetHandle: Integer;
begin
 if (fItemRec <> nil) then
  Result := PPublishedDictRec(fItemRec)^.ID  {!! УЖС}
 else
  Result := 0;
end;

function TExtItemNode.Get_Data : Pointer;
begin
 Result := fItemRec;
end;

function TExtItemNode.Get_DataSize : Longint;
begin
 Result := fItemSize;
end;

function TExtItemNode.pn_CheckSaveStatus : boolean;
begin
 Result := False;
end;

function TExtItemNode.GetRootNode : TDictRootNode;
begin
 Result := TDictLeafNode(Parent).RootNode;
end;

procedure TExtItemNode.DeleteEx(aHeirID: TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
var
 lCurID : TDictID;
 lSaveRoot : TDictRootNode;
begin
 lCurID := Handle;
 lSaveRoot := GetRootNode;
 GetRootNode.DelExtItemTbl(Handle, aHeirID);

 inherited DoDelete;
 lSaveRoot.DataChanged(atDelete,lCurID,0,0);
end;

function  TExtItemNode.GetDictNodeType : TDictNodeType;
begin
 Result := dntExtItem;
end;

{TDictEqualNode}

procedure TDictEqualNode.Cleanup;
begin
 if Assigned(fDictRec) then
  fDictRec := nil;

 l3StrDispose(fText.S);
 inherited;
end;

procedure TDictEqualNode.DoDelete;
var
 lParent : IDictItem;
begin
 if (Parent <> nil) and
    l3IOk(Parent.QueryInterface(IDictItem, lParent)) then
 begin
  TDictLeafNode(Parent).RootNode.DelEqualFromTbl(lParent.Handle, Handle);
  lParent := nil;
 end;

 if Assigned(fDictRec) then
  fDictRec := nil;

 Inherited;
end;

function TDictEqualNode.dn_IsLastEntry : Boolean;
begin
 if Assigned(fDictRec) then
  Result:=(fDictRec as IDictItemPro).dip_RefCount = 2
 else
  Result := True;
end;

procedure TDictEqualNode.dn_SetDictItem(aDictItem : IDictItem);
begin
 fDictRec := aDictItem;
end;

function TDictEqualNode.GetAsPCharLen: Tl3PCharLenPrim;
begin
 if (fText.SLen > 0) then
  Result := fText
 else
  if Assigned(fDictRec) then
  begin
   fText := l3PCharLen(l3GetFullPathAlloc(TDictLeafNode(Parent).RootNode,
                              (fDictRec as IDictItemPro).LinkNode));
   Result := fText;
  end
  else
   Result := l3PCharLen(AnsiString(BrokenLeaf));
end;

function TDictEqualNode.pm_GetHandle: Integer;
begin
 if Assigned(fDictRec) then
  Result := fDictRec.Handle
 else
  Result := 0;
end;

function  TDictEqualNode.GetDictNodeType : TDictNodeType;
begin
 Result := dntEqual;
end;

{TDictionary}
//   fObj      : TCustomDictTbl;
//   fList     : Tl3StringDataList;
//   fRootNode : TDictRootNode;
//   fEquals   : TEqualItemsTbl;

constructor TDictionary.Create(aFamily : TdaFamilyID; aDictType : TdaDictionaryType);
begin
 inherited Create;
 fFamily := aFamily;
 fDictType := aDictType;
end;

procedure TDictionary.Cleanup;
begin
 l3Free(fDeferDeleletedItems);
 l3Free(fList);
 l3Free(fRootNode);
 l3Free(fTbl);
 l3Free(fEquals);
 inherited;
end;

function TDictionary.GetTbl : TCustomDictTbl;
begin
 if not Assigned(fTbl) then
 begin
  if not IsDictClass(fDictType) then
   fTbl := TParamGroupTbl.Create(fFamily, fDictType)
  else
  begin
   fTbl := TDictionaryTbl.Create(fFamily, fDictType);
   with fTbl as TDictionaryTbl do
   begin
    if gBiLingual then
     NameFld := dtNameEFld
    else
     NameFld := dtNameRFld;
   end;
   if (fDictType in sJournaled) then
    (fTbl as TDictionaryTbl).DictItemClass := TJournaledDictItem;
  end;
  fTbl.BeforeDelete := DoBeforeItemDelete;
 end;

 Result := fTbl;
end;

function TDictionary.GetDictTbl : TDictionaryTbl;
begin
 Result := TDictionaryTbl(Tbl);
end;

function TDictionary.GetGroupTbl : TParamGroupTbl;
begin
 Result := TParamGroupTbl(Tbl);
end;

function TDictionary.GetList : Tl3StringDataList;
begin
 if not IsDictClass(DictType) then
  raise EHtErrors.CreateInt(ecNotEnable);

 if not Assigned(fList) then
 begin
  GetDictTbl;
  fList := Tl3StringDataList.Create;
  fList.Sorted := not (DictType in sUnsortedDicts);
  DictTbl.GetDictList(fList, False);
 end;
 Result := fList;
end;

procedure TDictionary.ReloadList;
begin
 if Assigned(fList) then
 begin
  GetDictTbl;
  fList.Clear;
  fList.Sorted := not (DictType in sUnsortedDicts);
  DictTbl.GetDictList(fList, False);
 end;
end;

function TDictionary.GetRootNode : TDictRootNode;
begin
 if fRootNode = nil then
 begin
  GetTbl;
  fRootNode := TDictRootNode.CreateWithInit(Self);
  if (DictType in sJournaled) then
   fRootNode.ChildNodeClass := TDictLeafNodeWithJournal;
  fRootNode.Load;
  LoadDeferDeleletedItems;
  LoadExtItemsToTree;
 end;

 Result := fRootNode;
end;

function TDictionary.GetEquals : TEqualItemsTbl;
begin
 if not Assigned(fEquals) and (fDictType in sWithEquals) then
  fEquals := TEqualItemsTbl.Create(fFamily, DictType);
 Result := fEquals;
end;

procedure TDictionary.DoBeforeItemDelete(aTable : TdtTable; aRecID : Longint);
begin
 DictServer(fFamily).DoBeforeItemDelete(aTable, aRecID);
end;

function TDictionary.CheckItem(aID: TDictID): IDictItem;
begin
 Result:= DictTbl.iCheckItemInList(aID);
end;

procedure TDictionary.SendEditMessage(aOperation : TOperActionType;
                            aID, aParentID, aNextID : TDictID);
begin
 DictServer(fFamily).SendEditMessage(fDictType, aOperation, aID, aParentID, aNextID);
end;

{ TdtDeferDelRec = record
  rID      : TDictID;                        dt_types
  rDestID  : TDictID;
  rDelDate : TsttDate;
 end;
}

procedure TDictionary.ReadDictChange(aIterProc : TReadDictChangeProc);
 var
  lDate : TstDate;

 procedure lParseFile(aFileName : TFileName);
 var
  lIsReaded  : Boolean;
  lOperation : TDCOperation;
  lName      : AnsiString;
  lNewName   : AnsiString;
  lStr       : AnsiString;
  lLineCnt   : Integer;

  lStream    : Tl3TextStream;                        //l3Stream

  procedure CheckStr;
  begin
   if lName = '' then
    raise Exception.CreateFmt('ReadDictChange. Файл : "%s" Строка : %d Не указан элемент словаря', [aFileName, lLineCnt]);
   if (lOperation = dcChange) and (lNewName = '') then
    raise Exception.CreateFmt('ReadDictChange. Файл : "%s" Строка : %d Не указан элемент словаря 2', [aFileName, lLineCnt]);
  end;

  procedure lOutData;
  begin
   if not lIsReaded then Exit;
   CheckStr;
   aIterProc(MakeReadDictParam(lOperation, lName, lNewName, lDate));
   lIsReaded := False;
   lName      := '';
   lNewName   := '';
  end;

 begin
  if not FileExists(aFileName) then Exit;
  lIsReaded := False;
  lStream := Tl3TextStream.Create(aFileName, l3_fmRead);
  try
   with lStream do
   begin
    while not IsEof do
    begin
     lStr := Trim(GetLine);
     Inc(lLineCnt);
     if not lIsReaded then
     begin
      if lStr = '[DEL]' then
      begin
       lOperation := dcDel;
       lIsReaded := True;
      end
      else
      if lStr = '[ADD]' then
      begin
       lOperation := dcAdd;
       lIsReaded := True;
      end
       {Сюда если еще команды будут}
      else
       if lStr <> '' then
        raise Exception.CreateFmt('ReadDictChange. Файл : "%s" Строка : %d Непонятная команда', [aFileName, lLineCnt]);
     end //if not lIsReaded
     else
     begin
      if lStr = '' then
       lOutData;
      if lStr = '[ADD]' then
      begin
       lOperation := dcChange;
      end
      else
      if lStr[1] = '[' then
       raise Exception.CreateFmt('ReadDictChange. Файл : "%s" Строка : %d Ожидалось имя элемента', [aFileName, lLineCnt])
      else
      if lOperation = dcChange then
       lNewName := lStr
      else
       lName := lStr;
      ;
     end; //if not lIsReaded

    end; //while not IsEof

    lOutData;
   end;
  finally
   l3Free(lStream);
  end;
 end;

var
 lCurDate  : TstDate;
 lFileName : AnsiString;
 D, M, Y   : Integer;

begin
 if fDictType = da_dlNone then Exit;
 //TDCOperation = (dcAAdd, dcDel, dcChange, dcMove);
 // procedure(aOperation : TDCOperation; aName : AnsiString; aNewName : AnsiString); register;

 lCurDate := CurrentDate;
 lDate := lCurDate - 21; //??
 While lDate <= lCurDate do
 begin
  StDateToDMY(lDate, D, M, Y);
  lFileName := Format('%2d%2d%2d%2d.dct', [ord(fDictType), Y mod 100, M, D]);
  l3Replace(lFileName, ' ', '0');

  lFileName := ConcatDirName(ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(fFamily), gDictChangesDir), lFileName);

  lParseFile(lFileName);
  Inc(lDate);
 end;
end;

procedure TDictionary.LoadDeferDeleletedItems;

 procedure lReadDictChangeProc(aParam : TReadDictParam); register;
 var
  lRec : TdtDeferDelRec;
  lNode : Il3Node;
 begin
  with aParam do
  if rOperation in [dcDel, dcChange] then
  begin
   with lRec do
   begin
    lNode := l3SearchByPath(RootNode, l3PCharLen(rName));
    rID := (lNode as Il3HandleNode).Handle;
    lNode := nil;

    if rNewName = '' then
     rDestID := 0
    else
    begin
     lNode := l3SearchByPath(RootNode, l3PCharLen(rNewName));
     rDestID := (lNode as Il3HandleNode).Handle;
     lNode := nil;
    end;

    rDelDate := rDate;
   end;
  end;

 fDeferDeleletedItems.Add(lRec);

 end;

var
 lStub : TReadDictChangeProc;

begin
 if fFamily = 0 then Exit;
 if fDeferDeleletedItems = nil then
 begin
  fDeferDeleletedItems := Tl3FieldSortRecList.Create(SizeOf(TdtDeferDelRec),
                                                     [SizeOf(TDictID)],
                                                     [1]     // сортировка по rID
                                                     );

  fDeferDeleletedItems.Capacity := 64*1024 div SizeOf(TdtDeferDelRec);
  fDeferDeleletedItems.Sorted := True;
 end
 else
  fDeferDeleletedItems.Clear;

 lStub := L2ReadDictChangeProc(@lReadDictChangeProc);
 try
  ReadDictChange(lStub);
 finally
  FreeReadDictChangeProc(lStub);
 end;
end;

function TDictionary.GetDeferDelInfo(aItemID : TDictID) : PdtDeferDelRec;
var
 lIndex : Integer;
begin
 if (fDeferDeleletedItems <> nil) and
    fDeferDeleletedItems.FindRecord(aItemID, lIndex) then
  Result := PdtDeferDelRec(fDeferDeleletedItems.ItemSlot(lIndex))
 else
  Result := nil;
end;

function TDictionary.LoadEqualClassesToTree : boolean;
var
 mCurTbl      : TDictionaryTbl;
 mCurEqualTbl : TEqualItemsTbl;
 mEquals      : SAB;
 mEqualsList  : TAbstractList;
 mTmpMode     : TOpenMode;

 mTmpRec      : PAnsiChar;
 mLastID      : TDictID;
 I,
 mTmpIndex    : LongInt;
 mCurParent   : Il3Node;
 mCurChild    : TDictEqualNode;
begin
 Result:=False;
 mCurEqualTbl := Equals;
 if Assigned(mCurEqualTbl) then
 begin
  mCurTbl:=DictTbl;
  mEquals := mCurEqualTbl.GetAllEquals.ExtractHTSab;
  try
   mTmpMode.openMode:=ROPEN_BODY;
   mTmpMode.Count:=0;
   mTmpMode.FldArr:=nil;

   mEqualsList:=TAbstractList.Create(@mEquals, mTmpMode, True);
   try
    mLastID:=0;
    for I := 0 to mEqualsList.Count-1 do
    begin
     mTmpRec:=mEqualsList.GetItem(I);
     if mLastID<>PEqualRec(mTmpRec)^.FirstID then
     begin
      mLastID:=PEqualRec(mTmpRec)^.FirstID;
      if mCurTbl.ItemList.FindData(mLastID,mTmpIndex) then
       mCurParent:=TDictItem(mCurTbl.ItemList.Items[mTmpIndex]).LinkNode
      else
       mCurParent:=nil;
     end;
     if (mCurParent<>nil) and
        mCurTbl.ItemList.FindData(PEqualRec(mTmpRec)^.SecondID,mTmpIndex) then
     begin
      mCurChild:=TDictEqualNode.Create;
      try
       mCurChild.dn_SetDictItem(TDictItem(mCurTbl.ItemList.Items[mTmpIndex]));
       mCurParent.InsertChild(mCurChild);
       mCurChild.Flags:=mCurChild.Flags or cEqualNode;
       mCurParent.Flags:=mCurParent.Flags or cNodeHasEquals;
      finally
       l3Free(mCurChild);
      end;
     end;
    end;
   finally
    l3Free(mEqualsList);
   end;
  finally
   htClearResults(mEquals);
  end;
  Result:=True;
 end;
end;

procedure TDictionary.DelDictItemFromTbls(aID : TDictID; aNewID : TDictID = cUndefDictID);
begin
 if (aNewID <> cUndefDictID) and not Tbl.CheckExists(aNewID) then
  raise EHtErrors.CreateInt(ecNotEnable);
 RealDelDictItemFromTbls(aID, aNewID);
end;

procedure TDictionary.DelDictItem(aID : TDictID; aNewID : TDictID = cUndefDictID);
var
 lNode : Il3Node;
begin
 if IsDictClass(fDictType) then
  lNode := FindNodeByID(aID);

 if lNode <> nil then
 begin
  if aNewID = cUndefDictID then
   lNode.Delete
  else
  (lNode as IPersistentNode).DeleteEx(aNewID);
 end
 else
  DelDictItemFromTbls(aID, aNewID);
end;

procedure TDictionary.EditNonKeyValueInTbl(aID: TDictID; aFld: Word; aValue: Pointer);
begin
 RealEditNonKeyValueInTbl(aID, aFld, aValue);
end;

procedure TDictionary.ChangeKeyValues(aFld: ThtField; var theOldValue, theNewValue);
begin
 DictTbl.ChangeDictField(aFld, theOldValue, theNewValue);
end;

procedure TDictionary.AddEqualToTbl(aFirstID, aSecondID : TDictID);
begin
 RealAddEqualToTbl(aFirstID, aSecondID);
end;

procedure TDictionary.DelEqualFromTbl(aFirstID, aSecondID : TDictID);
var
 lCurEqualTbl : TEqualItemsTbl;
begin
 RealDelEqualFromTbl(aFirstID, aSecondID);
end;

procedure TDictionary.AddEqualNode(aFirstID, aSecondID : TDictID);
var
 mCurTbl      : TDictionaryTbl;
 mCurEqualTbl : TEqualItemsTbl;
 mCurParent   : Il3Node;
 mCurChild    : TDictEqualNode;
 mTmpIndex    : LongInt;
begin
 mCurEqualTbl := Equals;
 if Assigned(mCurEqualTbl) then
 begin
  mCurTbl := DictTbl;
  mCurEqualTbl.AddEqual(aFirstID,aSecondID);
  if Assigned(RootNode) and
     RootNode.HasEqualNodes then
  begin
   if mCurTbl.ItemList.FindData(aFirstID, mTmpIndex) then
    mCurParent := TDictItem(mCurTbl.ItemList.Items[mTmpIndex]).LinkNode
   else
    mCurParent := nil;
   if (mCurParent <> nil) and
      mCurTbl.ItemList.FindData(aSecondID,mTmpIndex) then
   begin
    mCurChild := TDictEqualNode.Create;
    try
     mCurChild.dn_SetDictItem(TDictItem(mCurTbl.ItemList.Items[mTmpIndex]));
     mCurParent.InsertChild(mCurChild);
     mCurChild.Flags := mCurChild.Flags or cEqualNode;
     mCurParent.Flags := mCurParent.Flags or cNodeHasEquals;
    finally
     l3Free(mCurChild);
    end;
   end;
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotEnable);
end;

function TDictionary.AddExtItem(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
begin
 Result := AddExtItemTbl(aParentNode, aRec);
end;

function TDictionary.AddExtItemTbl(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
var
 lID : TDictID;
begin
 if cDLPassports[fDictType].rDepDictID <> da_dlNone then
 begin
  lID := IDOfDictRec(aRec);
  DictServer(fFamily).Dict[cDLPassports[fDictType].rDepDictID].AddDictFullDataNode(lID, DataOfDictRec(aRec), aParentNode);
  PDictID(aRec)^ := lID; //возвращаем lID в рекорд

  Result := CreateExtNode(aParentNode, aRec);
 end;
end;

procedure TDictionary.EditExtItemTbl(aRec : Pointer);
begin
 if cDLPassports[fDictType].rDepDictID <> da_dlNone then
  DictServer(fFamily).Dict[cDLPassports[fDictType].rDepDictID].EditDictFullData(IDOfDictRec(aRec), DataOfDictRec(aRec));
end;

procedure TDictionary.DelExtItemTbl(aDictID : TDictID; aHairDictID : TDictID = cUndefDictID);
begin
 if cDLPassports[fDictType].rDepDictID <> da_dlNone then
  DictServer(fFamily).Dict[cDLPassports[fDictType].rDepDictID].DelDictItemFromTbls(aDictID, aHairDictID);
end;

function TDictionary.CreateExtNode(const aParentNode : Il3Node; aRec : Pointer) : Il3Node;
var
 lExtItemNode : TExtItemNode;
begin
 if (aParentNode <> nil) then
 begin
  lExtItemNode := TExtItemNode.Create;
  try
   lExtItemNode.InitData(aRec^, GetExtItemDataSize);
   Result := lExtItemNode;

   if aParentNode.HasChild then
    aParentNode.InsertChildBefore(aParentNode.Child as Il3Node, lExtItemNode)
   else
    aParentNode.InsertChild(lExtItemNode)
  finally
   l3Free(lExtItemNode);
  end;
 end;
end;

function TDictionary.GetExtItemDataSize : Integer;
begin
 if cDLPassports[fDictType].rDepDictID <> da_dlNone then
  Result := DictServer(fFamily).Dict[cDLPassports[fDictType].rDepDictID].Tbl.RecSize;
end;

function TDictionary.LoadExtItemsToTree : boolean;
var
 lDictTbl      : TDictionaryTbl;
 lExtItemsTbl  : TCustomDictTbl;

 lExtItemsList : ISABCursor;

 lItemRec     : PAnsiChar;
 lSavedID     : DWORD;
 lCurID       : DWORD;

 I,
 lIndex       : Longint;

 lParentNode  : Il3Node;
 lDictType : TdaDictionaryType;

begin
 Result := False;
 lDictType := cDLPassports[fDictType].rDepDictID;
 if lDictType = da_dlNone then Exit;

 lExtItemsTbl := DictServer(fFamily).Dict[lDictType].Tbl;
 if not Assigned(lExtItemsTbl) then Exit;

 lDictTbl := DictTbl;

 with MakeSab(lExtItemsTbl) do
 begin
  SelectAll;
  Sort([piSourFld, piSDateFld, -piNumberFld]);
  lExtItemsList := MakeSabCursor([], cmForward);
 end;

 lSavedID := cUndefDictID;
 RootNode.Changing;
 try
  for I := 0 to Pred(lExtItemsList.Count) do
  begin
   lItemRec := lExtItemsList.GetItem(I);
   lCurID := PDWORD(lItemRec + cDLPassports[fDictType].rDepFldOfs)^;
   if lSavedID <> lCurID then
   begin
    lSavedID := lCurID;
    if lDictTbl.ItemList.FindData(lCurID, lIndex) then
     lParentNode := TDictItem(lDictTbl.ItemList.Items[lIndex]).LinkNode
    else
     lParentNode := nil;
   end;

   CreateExtNode(lParentNode, lItemRec);
  end;
 finally
  RootNode.Changed;
 end;

 Result := True;
end;

procedure TDictionary.Update;
begin
 Tbl.UpdateTbl;
 UpdateTreeStuct(Tbl.TblFullName);
end;

(*procedure TDictionary.Save;
begin
 if fRootNode <> nil then
  fRootNode.Save;
end;
*)

function TDictionary.Lock : Boolean;
begin
 Try
  Tbl.LockTbl;
  Result := True;
 except
  Result := False;
 end;
end;

procedure TDictionary.UnLock;
begin
 Tbl.UnlockTbl;
end;

procedure TDictionary.EditDictItem(aID: TDictID;
                                   const aNameR, aNameE, aShortName: Tl3WString;
                                   aIsPrivate: TIsPrivate = cEmptyByte;
                                   aIsNonperiodic: TIsNonperiodic = cEmptyByte);
begin
 EditDictItemInTblEx(aID, aNameR, aNameE, aShortName, aIsPrivate, aIsNonperiodic);

 if IsDictClass(fDictType) then
 begin
  RootNode.Changing;
  RootNode.Changed;
 end;
end;

procedure TDictionary.EditDictItemInTblEx(aID: TDictID;
                                          const aNameR, aNameE, aShortName: Tl3WString;
                                          aIsPrivate: TIsPrivate = cEmptyByte;
                                          aIsNonperiodic: TIsNonperiodic = cEmptyByte);
begin
 RealEditDictItemInTbl(aID, aNameR, aNameE, aShortName, aIsPrivate, aIsNonperiodic);
end;

function TDictionary.AddDictFullDataNode(var theID : TDictID; aData : PAnsiChar; const aParentNode : Il3Node = nil): Il3Node;
begin
 Result:= RealAddDictFullDataNode(theID, aData, aParentNode)
end;

function TDictionary.RealAddDictFullDataNode(var theID : TDictID; aData : PAnsiChar; const aParentNode : Il3Node = nil): Il3Node;
var
 TmpIndex    : LongInt;
 TmpLeafNode : TDictLeafNode;
 lParentNode : Il3Node;
begin
 if not IsDictClass(fDictType) then
  begin
   GroupTbl.AddData(theID, aData);
   SendEditMessage(atAdd, theID, 0, 0);
   Result := nil;
  end
 else
  begin
   DictTbl.AddData(theID, aData);

   if DictTbl.ItemList.FindData(theID, tmpIndex) then
   begin
    if aParentNode = Nil then
     lParentNode := RootNode
    else
     lParentNode := aParentNode;

    TmpLeafNode := RootNode.ChildNodeClass.Create;
    try
     TDictItem(DictTbl.ItemList.Items[tmpIndex]).LinkNode := Il3Node(TmpLeafNode);
     TmpLeafNode.fDictRec := TDictItem(DictTbl.ItemList.Items[tmpIndex]);
     Result:=lParentNode.InsertChild(TmpLeafNode);
    finally
     l3Free(TmpLeafNode);
    end;
   end;
   RootNode.DataChanged(atAdd, theID, (lParentNode as IDictItem).Handle, 0);
   SendEditMessage(atAdd, theID, (lParentNode as IDictItem).Handle, 0);
  end;
end;

function TDictionary.AddDictNode(aID: TDictID;
                                 const aNameR, aNameE, aShortName: Tl3WString;
                                 const aParentNode: Il3Node;
                                 aIsPrivate: TIsPrivate = cEmptyByte;
                                 aIsNonperiodic: TIsNonperiodic = cEmptyByte): Il3Node;
var
 l_ParentID: TDictID;
begin
 Result:= RealAddDictNode(aID, aNameR, aNameE, aShortName, aParentNode, aIsPrivate, aIsNonperiodic);
end;

function TDictionary.RealAddDictNode(aID: TDictID;
                                     const aNameR, aNameE, aShortName: Tl3WString;
                                     const aParentNode: Il3Node;
                                     aIsPrivate: TIsPrivate = cEmptyByte;
                                     aIsNonperiodic: TIsNonperiodic = cEmptyByte): Il3Node;
var
 TmpDictItem : IDictItem;
 TmpLeafNode : TDictLeafNode;
 lParentNode : Il3Node;
 lNextNodeID : Integer;
begin
 TmpDictItem:=DictTbl.AddDictItem(aID, aNameR, aNameE, aShortName, aIsPrivate, aIsNonperiodic);

 if aParentNode = Nil then
  lParentNode := RootNode
 else
  lParentNode := aParentNode;

 TmpLeafNode := RootNode.ChildNodeClass.Create;
 Try
  (TmpDictItem as IDictItemPro).LinkNode := Il3Node(TmpLeafNode);
  TmpLeafNode.fDictRec := TmpDictItem;
  Result := lParentNode.InsertChild(TmpLeafNode);
 finally
  l3Free(TmpLeafNode);
 end;

 if Result.IsLast then
  lNextNodeID := 0
 else
  lNextNodeID := (Result.Nextnode as Il3HandleNode).Handle;

 RootNode.DataChanged(atAdd,TmpDictItem.Handle,(lParentNode as IDictItem).Handle, lNextNodeID);

 SendEditMessage(atAdd, TmpDictItem.Handle, (lParentNode as IDictItem).Handle, lNextNodeID);
end;

procedure TDictionary.RealAddEqualToTbl(aFirstID, aSecondID : TDictID);
var
 mCurEqualTbl : TEqualItemsTbl;
begin
 mCurEqualTbl := Equals;
 if Assigned(mCurEqualTbl) then
  mCurEqualTbl.AddEqual(aFirstID, aSecondID);
end;

procedure TDictionary.EditDictFullData(aID : TDictID; aData : PAnsiChar);
begin
 RealEditDictFullData(aID, aData);
end;

function TDictionary.FindNodeByFullPath(const aNodePath: Tl3WString;
                                        const aLevelSlash: AnsiString = c_LevelSlash): Il3Node;
begin
 if IsDictClass(fDictType) then
  Result := l3SearchByPath(RootNode, aNodePath, aLevelSlash)
 else
  Result := nil;
end;

function TDictionary.FindIDByFullPath(const aNodePath: Tl3WString; const aLevelSlash: AnsiString = c_LevelSlash): TDictID;
var
 l_Node: Il3Node;
begin
 l_Node := FindNodeByFullPath(aNodePath, aLevelSlash);
 try
  if l_Node <> nil then
   Result := (l_Node as IDictItem).Handle
  else
   Result := cUndefDictID;
 finally
  l_Node := nil;
 end;
end;

function TDictionary.FindNodeByID(aDictID : TDictID;  aNodeType : TDictNodeType = dntItem) : Il3Node;

//TDictNodeType = (dntItem, dntExtItem, dntEqual);
 function IterHandler(const CurNode : Il3Node) : Boolean; far;
 var
  lNode : IDictNode;
 begin
  if l3IOk(CurNode.QueryInterface(IDictNode, lNode)) then
   Result := (lNode.Handle = aDictID) and (lNode.NodeType = aNodeType)
  else
   Result := False;
 end;

begin
 Result := l3IterateSubTreeF(RootNode, l3L2NA(@IterHandler), imCheckResult);
end;

function TDictionary.DataOfDictRec(aRec: PAnsiChar): PAnsiChar;
begin
 if aRec <> nil then
  Result := aRec + Tbl.IdSize
 else
  Result := nil;
end;

function TDictionary.IDOfDictRec(aRec: PAnsiChar): TDictID;
begin
 Result := 0;
 l3Move(aRec^, Result, Tbl.IdSize);
end;

function TDictionary.GetShortName(aID : TDictID) : ShortString;
var
 lNFld : ThtField;
begin
 lNFld := DictTbl.NameFld;
 Try
  if DictType in sWithShortName then
   DictTbl.NameFld := dtShNameFld
  else
   DictTbl.NameFld := dtNameRFld;

  Result := DictTbl.GetNameStr(aID);
 finally
  DictTbl.NameFld := lNFld;
 end;
end;

function TDictionary.GetFullDictItemName(const aNode : Il3Node; aAsTree: Boolean = True) : AnsiString;
var
 l_Slash, l_Indent: AnsiString;
begin
 if aAsTree then
 begin
  l_Slash:= gLinesLevelSlash;
  l_Indent:= '  ';
 end
 else
 begin
  l_Slash:= '\';
  l_Indent:= '';
 end;
 Result := l3GetFullPathStr(RootNode, aNode, l_Slash, l_Indent);
end;

function TDictionary.GetFullDictItemName(aDictID : TDictID; aAsTree: Boolean = True) : AnsiString;
var
 lIndex    : LongInt;
 lMasterDict : TdaDictionaryType;
 lNode : Il3Node;
begin
 case cDLPassports[fDictType].rClass of
  atcDict :
   begin
    if DictTbl.ItemList.FindData(aDictID, lIndex) then
     Result := GetFullDictItemName(TDictItem(DictTbl.ItemList.Items[lIndex]).LinkNode, aAsTree)
    else
     Result := Format('Элемент (ID = %d) в словаре "%s" не найден', [aDictID, cDLPassports[fDictType].rName]);
   end;
  atcDepDict :
   begin
    lMasterDict := GetMasterDict(fDictType);
    with DictServer(fFamily).Dict[lMasterDict] do
    begin
     // если старший бит взведен - элемент мастер-словаря
     if Longint(aDictID) < 0 then
      lNode := FindNodeByID(Abs(Longint(aDictID)), dntItem)
     else
      lNode := FindNodeByID(aDictID, dntExtItem);
     Result := GetFullDictItemName(lNode);
    end;
   end;
  else
   Assert(False, 'TDictionaryServer.GetFullDictItemName for atcSingle');
 end;
end;

function TDictionary.IsDictIDFree(aID: TDictID): Boolean;
begin
 Result := DictTbl.IsNumFree(aID);
end;

procedure TDictionary.RealDelDictItemFromTbls(aID: TDictID; aNewID: TDictID = cUndefDictID; aDateToDelete: TstDate = 0);
var
 tmpEqTbl    : TEqualItemsTbl;
 lFoundItem   : IDictItem;
 l_TransId   : Ht_Const.TrId;
 l_TrStarted : Boolean;
 l_TrTables: array of TPrometTbl;
 l_Rec : TdtDeferDelRec;

 procedure CalcTrTables;   // инициализирует массив таблиц, участвующих в транзакции
 var
  l_List: TList;
  I: Integer;
 begin
  l_List := TList.Create;
  try
   l_List.Add(Tbl); // сам словарь
   l_List.Add(GlobalHtServer.FreeTbl[fFamily]); // табл. Free

   if fDictType = da_dlCorSources then // см. коммент. в ChangeLinks
    l_List.Add(DictServer(fFamily).GroupTbl[da_dlPublisheds])
   else
    l_List.Add(LinkServer(fFamily).Links[fDictType].table); 

   if fDictType in [da_dlTypes, da_dlSources] then
    l_List.Add(LinkServer(fFamily).PriorTbl);

   if Equals <> nil then
    l_List.Add(Equals);

   SetLength(l_TrTables, l_List.Count);
   for I := 0 to l_List.Count - 1 do
    l_TrTables[I] := l_List[I];
  finally
   l3Free(l_List);
  end;
 end; // procedure

 procedure ChangeLinks;
 begin
  if fDictType = da_dlCorSources then // Словарь "Источники опубликования" не имеет табл. LNK.
                                  // Взамен ее используется словарь da_dlPublisheds.
  begin
   if aNewId <> cUndefDictID then
    DictServer(fFamily).GroupTbl[da_dlPublisheds].ChangeValues(piSourFld, aID, aNewID)
  end
  else // Остальные словари
  begin
   if aNewId <> cUndefDictID then
    LinkServer(fFamily).Links[fDictType].Table.ChangeValues(lnkDictIDFld, aID, aNewID, True)
   else
    LinkServer(fFamily).Links[fDictType].DelAllRecsByDictID(aID);
  end; // if-else
 end; // procedure

begin
 if aID = aNewID then
  raise EHtErrors.CreateInt(ecNotEnable);

 if (fDictType in sJournaled) and (aNewId <> cUndefDictID) then
 begin
  lFoundItem := DictTbl.iCheckItemInList(aNewID);
  if lFoundItem = nil then
   raise EHtErrors.CreateInt(ecNotEnable);

  if ((lFoundItem as IDictItemJour).Operation = atDelete) then
   raise EHtErrors.CreateInt(ecNotEnable);
 end;

 tmpEqTbl:=Equals;

 CalcTrTables;
 try
  l_TrStarted := GlobalHtServer.StartTransaction(l_TrTables, l_TransId);
 finally
  l_TrTables := nil;
 end;
 if l_TrStarted then
  Try
   ChangeLinks;
   if (aDateToDelete = 0) or (aDateToDelete = CurrentDate) then
   begin
    Tbl.DelData(aID);
    Tbl.PutFreeNum(aID);
    if tmpEqTbl <> Nil then
     tmpEqTbl.DelAllEqualOnID(aID);

    if fDictType in [da_dlTypes, da_dlSources] then
    begin
     DictTbl.SetDelNumber(aID);
     LinkServer(fFamily).PriorTbl.DeletePriorityOnDictID(aID, fDictType);
    end;
   end // (aDateToDelete = 0) or (aDateToDelete = Today)
   else
   begin
    l_Rec.rID:= aID;
    l_Rec.rDestID:= aNewID;
    l_Rec.rDelDate:= aDateToDelete;
    fDeferDeleletedItems.Add(l_rec);
   end;
   GlobalHtServer.CommitTransaction(l_TransId);
  except
   GlobalHtServer.RollBackTransaction(l_TransId);
   raise;
  end;
 SendEditMessage(atDelete, aID, 0, 0);
end;

procedure TDictionary.RealDelEqualFromTbl(aFirstID, aSecondID : TDictID);
var
 lCurEqualTbl : TEqualItemsTbl;
begin
 lCurEqualTbl := Equals;
 if Assigned(lCurEqualTbl) then
  lCurEqualTbl.DelEqual(aFirstID, aSecondID);
end;

procedure TDictionary.RealEditDictFullData(aID : TDictID; aData : PAnsiChar);
begin
 DictTbl.EditData(aID, aData);
 SendEditMessage(atEdit, aID, 0, 0);

 if IsDictClass(fDictType) then
 begin
  RootNode.Changing;
  RootNode.Changed;
 end;
end;

procedure TDictionary.RealEditDictItemInTbl(aID: TDictID;
                                            const aNameR, aNameE, aShortName: Tl3WString;
                                            aIsPrivate: TIsPrivate = cEmptyByte;
                                            aIsNonperiodic: TIsNonperiodic = cEmptyByte);
begin
 DictTbl.EditDictItem(aID, aNameR, aNameE, aShortName, aIsPrivate, aIsNonperiodic);
 SendEditMessage(atEdit, aID, 0, 0);
end;

procedure TDictionary.RealEditNonKeyValueInTbl(aID: TDictID; aFld: Word; aValue: Pointer);
begin
 DictTbl.EditNonKeyFields(aID,aFld,aValue);
 SendEditMessage(atEdit, aID, 0, 0);
end;


{ TDictionaryServer }

constructor TDictionaryServer.Create;
begin
 Inherited Create;
 f_EditedItems := TDictEditQueryList.Make;
 if DictChangeConfig=Nil
  then
   DictChangeConfig:=TCfgList.Create('');
 if GlobalHtServer<>Nil
  then
   DictChangeConfig.CfgFileName:=GlobalHtServer.FamilyTbl.FamilyPath(MainTblsFamily)+DictJourName;
end;

procedure TDictionaryServer.Cleanup;
begin
 l3Free(f_DictScan);
 l3Free(f_EditedItems);
 l3Free(fNotifiedObjList);
 AllDictClear;
 l3Free(DictChangeConfig);
 Inherited;
end;

procedure TDictionaryServer.DropDictScanData;
begin
 l3Free(f_DictScan);
end;

procedure TDictionaryServer.AllDictClear;
var
 I : TdaDictionaryType;
begin
 for I:=da_dlSources to High(TdaDictionaryType) do
  DictClear(I);
end;

procedure TDictionaryServer.DictClear(aDict : TdaDictionaryType);
begin
 if fDicts[aDict] <> nil then
 begin
  fDicts[aDict].Free;
  fDicts[aDict] := nil;
 end; 
end;

procedure TDictionaryServer.SetFamily(aValue : TdaFamilyID);
begin
 if fFamily<>aValue then
 begin
  if fFamily <> 0 then
   AllDictClear;
  fFamily := aValue;
  if fFamily <> 0 then
   DictChangeConfig.Section:=FamilySectionPref+IntToHex(fFamily,2);
 end;
end;

function TDictionaryServer.GetDict(aDictType : TdaDictionaryType) : TDictionary;
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if fDicts[aDictType] = nil then
 begin
  fDicts[aDictType] := TDictionary.Create(fFamily, aDictType);
  (*
  if IsDictClass(aDictType) then // Загрузка словаря
   fDicts[aDictType].RootNode;
  *) 
 end;
 Result := fDicts[aDictType];
end;

function TDictionaryServer.GetDictList(DictType : TdaDictionaryType) : Tl3StringDataList;
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 Result := Dict[DictType].List;
end;

procedure TDictionaryServer.RefreshDictList(DictType : TdaDictionaryType);
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if not IsDictClass(DictType) then //raise EHtErrors.CreateInt(ecNotEnable);
 begin
  l3System.Msg2Log('Вызов TDictionaryServer.RefreshDictList с неправильным параметром DictType = ' + GetEnumName(TypeInfo(TdaDictionaryType), Ord(DictType)));
  Exit;
 end;

 Dict[DictType].ReloadList;
end;

function TDictionaryServer.GetDictRootNode(DictType : TdaDictionaryType) : TDictRootNode;
begin
 if fFamily=0 then raise EHtErrors.CreateInt(ecNotAssigned);
 //if (DictType in sGroupDicts) then raise EHtErrors.CreateInt(ecNotEnable);

 if cDLPassports[DictType].rClass = atcDepDict then
  DictType := GetMasterDict(DictType);

 Result := Dict[DictType].RootNode;
end;

function TDictionaryServer.GetDictTbl(aDictType : TdaDictionaryType) : TDictionaryTbl;
begin
 Result := Dict[aDictType].DictTbl;
end;

function TDictionaryServer.GetGroupTbl(aDictType : TdaDictionaryType) : TParamGroupTbl;
begin
 Result := Dict[aDictType].GroupTbl;
end;

function TDictionaryServer.GetTbl(aDictType: TdaDictionaryType): TCustomDictTbl;
begin
 Result := nil;
 if aDictType = da_dlNone then
  Exit;

 if fFamily = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 Result := Dict[aDictType].Tbl;
end;

function TDictionaryServer.GetDictEqualObj(DictType : TdaDictionaryType) : TEqualItemsTbl;
begin
 if fFamily = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 Result := Dict[DictType].Equals;
end;

function TDictionaryServer.GetPocketModifyFlag : Boolean;
begin
 Result:=fPocketModify > 0;
end;

function TDictionaryServer.GetBiLingual : Boolean;
begin
 Result := gBilingual;
end;

procedure TDictionaryServer.SetBilingual(aValue : Boolean);
begin
 gBilingual := aValue;
end;

procedure TDictionaryServer.SetDictChanges(DictType : TdaDictionaryType);
var
 TmpDT : TStDateTimeRec;
begin
 if Assigned(DictChangeConfig)
  then
   begin
    TmpDT.D:=CurrentDate;
    TmpDT.T:=CurrentTime;
    DictChangeConfig.WriteParamRec(DictChangePref+IntToHex(Byte(DictType),1),'DD',TmpDT);
   end;
end;

function TDictionaryServer.GetDictChanges(DictType : TdaDictionaryType) : TStDateTimeRec;
begin
 Result.D:=0;
 Result.T:=0;
 if Assigned(DictChangeConfig)
  then
   DictChangeConfig.ReadParamRec(DictChangePref+IntToHex(Byte(DictType),1),'DD',Result);
end;

procedure TDictionaryServer.AddDictChangeNotifiedObj(aObj : IDictChangeNotifyRecipient);
begin
 if fNotifiedObjList = nil then
  fNotifiedObjList := Tl3LongintList.MakeSorted;
 fNotifiedObjList.Add(Integer(aObj));
end;

procedure TDictionaryServer.DelDictChangeNotifiedObj(aObj : IDictChangeNotifyRecipient);
begin
 if fNotifiedObjList <> nil then
  fNotifiedObjList.Remove(Integer(aObj));
end;

procedure TDictionaryServer.Update;
var
 I : TdaDictionaryType;
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 for I := da_dlSources to High(TdaDictionaryType) do
  Dict[I].Update;
end;

(*
procedure TDictionaryServer.SaveDict(aDict : TdaDictionaryType);
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if fDicts[aDict] <> nil then
  fDicts[aDict].Save;
end;

procedure TDictionaryServer.SaveAllDicts;
var
 lDict : TdaDictionaryType;
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);

 for lDict := da_dlSources to High(TdaDictionaryType) do
  SaveDict(lDict);
end;
*)

procedure TDictionaryServer.ReloadDict(aDict : TdaDictionaryType);
begin
 DictClear(aDict);
end;

procedure TDictionaryServer.ReceiveAddNode(aDictType : TdaDictionaryType;aID,aParentID : TDictID);
var
 TmpDictItem : IDictItem;
 TmpLeafNode : TDictLeafNode;
 ParentNode  : Il3Node;
begin
 if IsDictClass(aDictType) then
  begin
   TmpDictItem:=DictTbl[aDictType].ReceiveGetNode(aID);
   if TmpDictItem <> nil then
   begin
    if aParentID = 0 then
     ParentNode:=DictRootNode[aDictType]
    else
     ParentNode := Dict[aDictType].FindNodeByID(aParentID);

    if ParentNode <> Nil then
     begin
      TmpLeafNode:=DictRootNode[aDictType].ChildNodeClass.Create;
      Try
       TmpLeafNode.fDictRec:=TmpDictItem;
       (TmpDictItem as IDictItemPro).LinkNode := Il3Node(TmpLeafNode);
       ParentNode.InsertChild(TmpLeafNode);
      finally
       l3Free(TmpLeafNode);
      end;
     end;
   end; // TmpDictItem <> nil
  end;
end;

procedure TDictionaryServer.ReceiveEditNode(aDictType : TdaDictionaryType;aID : TDictID);
begin
 if IsDictClass(aDictType) then
  DictTbl[aDictType].ReceiveGetNode(aID);
end;

procedure TDictionaryServer.ReceiveDelNode(aDictType : TdaDictionaryType;aID : TDictID);
var
 tmpNode : Il3Node;
begin
 if IsDictClass(aDictType) then
  begin
   tmpNode:=Dict[aDictType].FindNodeByID(aID);
   if tmpNode<>nil then
    begin
     tmpNode.Remove;
     tmpNode:=Nil;
    end;

   DictTbl[aDictType].ReceiveDelNode(aID);
  end;
end;

procedure TDictionaryServer.ReceiveMoveMode(aDictType : TdaDictionaryType;
                                           aID,aParentID,aNextID : TDictID);
var
 tmpNode,
 tmpParent,
 tmpNext    : Il3Node;
begin
 if IsDictClass(aDictType) then
  begin
   tmpNode := Dict[aDictType].FindNodeByID(aID);
   if tmpNode<>nil then
    begin
     tmpNode.Remove;
     if aParentID = 0 then
      tmpParent:=DictRootNode[aDictType]
     else
      tmpParent := Dict[aDictType].FindNodeByID(aParentID);
     if tmpParent <> nil then
      begin
       if aNextID<>0 then
        begin
         tmpNext := Dict[aDictType].FindNodeByID(aNextID);
         if tmpNext <> nil then
          tmpParent.InsertChildBefore(tmpNext, tmpNode);
        end
       else
        tmpParent.InsertChild(tmpNode);
      end;
     tmpNode:=nil;
     tmpNext:=nil;
     tmpParent:=nil;
    end; // tmpNode <> nil
  end;
end;

procedure TDictionaryServer.DoBeforeItemDelete(aTable : TdtTable; aRecID : Longint);
var
 lImgFileName : AnsiString;
 lNonPeriodic : Boolean;
 lRecID       : Longint;
begin
 if (aTable as TCustomDictTbl).DictType = da_dlPublisheds then
 begin
  TCustomDictTbl(aTable).GetFullRec(aRecID);
  with PPublishedDictRec(TCustomDictTbl(aTable).FullRecord)^ do
  begin
   lNonPeriodic := (Sour = 0) or (DictTbl[da_dlCorSources].GetIsNonperiodic(Sour) = 1);
   if not (lNonPeriodic and ((SDate <> BlankDate) or (EDate <> BlankDate))) then
    // Защита. Дело в том что файлы для NonPeriodic кодируются без использования
    //даты и можно удаляя мусор из словаря снести полбазы образов,
    // что уже и проделала 07.08.2012 тупая Потрехаева (Такташова).
    //(Тупая не потому что снесла, а потому что ей говорили ничего не трогать.)
    DocImageServer.DeleteImages(Sour, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), lNonPeriodic);
  end;
 end;
end;


procedure TDictionaryServer.GetNumberList(aTyp : TDNType; aList : TStrings);
var
 //SrchTblH : HT_Const.THandle;
 //SrchList : LPSAB;

 //TmpStr   : ShortString;
 //TmpNum   : TNumberStr;

 //lSab : Sab;
 //TypList,
// Res1List,
 //Res2List  : SAB;

 lSab : ISab;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  aList.Add(l3ArrayToString(PNumberStr(aItemPtr)^, SizeOf(TNumberStr)));
 end;

 var
  lRAProcStub : TdtRecAccessProc;

begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 aList.Clear;
 //SrchTblH:=GroupTbl[da_dlDateNums].Handle;

 lSab := MakeAllRecords(GroupTbl[da_dlDateNums]);
 //SrchList:=@GroupTbl[da_dlDateNums].fSrchList;

 if aTyp = dnDoc then
  lSab := MakeAllRecords(GroupTbl[da_dlDateNums])
 else
 begin
  lSab := MakeSab(GroupTbl[da_dlDateNums]);
  lSab.Select(dnTypFld, aTyp);
 end;
 lSab.ValuesOfKey(dnNumFld);

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lSab.IterateRecords(lRAProcStub);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
end;

function TDictionaryServer.pm_GetDictScanner : Tm4DictScanner;
begin
 if f_DictScan = nil then
  f_DictScan := MakeDictScanner;

 Result := f_DictScan; 
end;

function TDictionaryServer.MakeDictScanner : Tm4DictScanner;
var
 lDictType   : TdaDictionaryType;
 lDictIDList : Tl3LongintList;
 lDictScan   : Tm4DictScanner;

 function DoInt(const aWord : Tl3WString; IsLast : Boolean) : Boolean;
 begin
  Result := true;
  lDictIDList.Add(l3StrToInt(aWord));
 end;

 function lRecAccessProc_Sources(aItemPtr : Pointer) : Boolean;
  function DoSynon(const aWord : Tl3WString; IsLast : Boolean) : Boolean;
  begin
   Result := true;
   lDictScan.AddToDict(aWord, PDictID(aItemPtr)^, Ord(lDictType));
  end;

 var
  lPChar : PAnsiChar;
 begin
  Result := True;
  with DictTbl[lDictType] do
  begin
   lPChar := PAnsiChar(aItemPtr) + FldLength[dtIDFld];
   lDictScan.AddToDict(l3Trim(l3PCharLen(lPChar, FldLength[dtNameFld])), PDictID(aItemPtr)^, Ord(lDictType));
   Inc(lPChar, FldLength[dtNameFld]);
   lDictScan.AddToDict(l3Trim(l3PCharLen(lPChar, FldLength[dtShNameFld])), PDictID(aItemPtr)^, Ord(lDictType));
   Inc(lPChar, FldLength[dtShNameFld]);
   l3ParseWordsExF(l3Trim(l3PCharLen(lPChar, FldLength[dtSinonimsFld])), l3L2WA(@DoSynon), [cc_SemiColon]);
  end;
 end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 const
  lFKZStr = 'федеральный конституционный закон';
  lFZStr = 'федеральный закон';
  lFKZStrLen = Length(lFKZStr);
  lFZStrLen = Length(lFZStr);
 var
  lIDFldSize : Integer;
  lStr : Tl3PCharLen;
 begin
  Result := True;
  with DictTbl[lDictType] do
  begin
   lIDFldSize := FldLength[dtIDFld];
   lDictScan.AddToDict(l3Trim(l3PCharLen(PAnsiChar(aItemPtr) + lIDFldSize, FldLength[dtNameFld])), PDictID(aItemPtr)^, Ord(lDictType));
   // хакерское добавление синонимов 'федеральный конституционный закон' = 'ФКЗ', 'федеральный закон' = 'ФЗ'
   if PAnsiChar(aItemPtr)[lIDFldSize] in ['Ф', 'ф'] then // предварительная проверка для скорости
   begin
    lStr := Tl3PCharLen(l3Trim(l3PCharLen(PAnsiChar(aItemPtr) + lIDFldSize, FldLength[dtNameFld])));
    if lStr.SLen = lFKZStrLen then
    begin
     if l3Compare(lStr, l3PCharLen(PAnsiChar(lFKZStr), lFKZStrLen), l3_siCaseUnsensitive) = 0 then
      lDictScan.AddToDict(l3PCharLen('ФКЗ'), PDictID(aItemPtr)^, Ord(lDictType));
    end
    else
    if lStr.SLen = lFZStrLen then
    begin
     if l3Compare(lStr, l3PCharLen(PAnsiChar(lFZStr), lFZStrLen), l3_siCaseUnsensitive) = 0 then
      lDictScan.AddToDict(l3PCharLen('ФЗ'), PDictID(aItemPtr)^, Ord(lDictType));
    end;
   end;
  end;
 end;

 function DictExcludeName(aDictType : TdaDictionaryType) : AnsiString;
 begin
  case aDictType of
   da_dlSources :  Result := 'Sources';
   da_dlTypes   :  Result := 'Types';
   else         Result := ''; //Assert(False, 'Словарь не поддерживается');
  end;
 end;

const
 lDictArr : array[0..1] of TdaDictionaryType = (da_dlSources, da_dlTypes);
var
 lStr        : AnsiString;
 I           : Integer;
 lSab        : ISab;
 lRAProcStub : TdtRecAccessProc;
begin
 if fFamily = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 lDictScan := Tm4DictScanner.Create;
 for I := 0 to Pred(Length(lDictArr)) do
 begin
  lDictType := lDictArr[I];

  lDictIDList := Tl3LongintList.Create;
  try
    if BaseConfig <> nil then
    begin
     BaseConfig.Section:= 'CompileExcludes';
     // загружаем исключения для источников
     lStr := BaseConfig.ReadParamStrDef(DictExcludeName(lDictType), '');
     l3ParseWordsF(l3PCharLen(lStr), l3L2WA(@DoInt), []);
    end;

   lSab := GetExpandDictIDValueSab(lDictType, lDictIDList, True {Invert});
  finally
   l3Free(lDictIDList);
  end;

  lSab.RecordsByKey(dtIDFld, MakePhoto(DictTbl[lDictType]));

  if lDictType = da_dlSources then
  begin
   lRAProcStub := L2RecAccessProc(@lRecAccessProc_Sources);
   try
    lSab.IterateRecords(lRAProcStub, [dtIDFld, dtNameFld, dtShNameFld, dtSinonimsFld]);
   finally
    FreeRecAccessProc(lRAProcStub);
   end;
  end
  else
  begin
   lRAProcStub := L2RecAccessProc(@lRecAccessProc);
   try
    lSab.IterateRecords(lRAProcStub, [dtIDFld, dtNameFld]);
   finally
    FreeRecAccessProc(lRAProcStub);
   end;
  end;
 end;

 lDictScan.AddComplete;

 //DebugOut(lDictScan);
 Result := lDictScan;
end;

procedure TDictionaryServer.SendEditMessage(aDictType : TdaDictionaryType;
                                            aOperation : TOperActionType;
                                            aID, aParentID, aNextID : TDictID);
var
 l_Q        : TDictEditQuery;
 l_S        : TDLTypeSet;
begin
 l_S:= [];
 AddDLClassToSet(l_S, atcSingle);
 If Not PocketModify and not (aDictType in l_S) then
 begin
  if CSClient <> nil then
  begin
   l_Q := TDictEditQuery.Create(csClient.ClientID);
   try
//    l_Q.UserID := CSClient.ClientId;
    l_Q.Family := Family;
    l_Q.DictType := Ord(aDictType);
    l_Q.Operation:= Ord(aOperation);
    l_Q.ID:= aID;
    l_Q.ParentID:= aParentID;
    l_Q.NextID:= aNextID;
    UserRequestManager.SendTask(l_Q);
   finally
    l3Free(l_Q);
   end
  end;
  SetDictChanges(aDictType);

  if aDictType in [da_dlSources, da_dlTypes] then
   DropDictScanData;
 end;
end;

procedure TDictionaryServer.ReceiveMessage(aMessage : PAnsiChar);
var
 CurChanges : TOperActionType;
 I          : Longint;
begin
 if PDictMessageRec(aMessage)^.Family = fFamily then
 begin
  RefreshDictList(PDictMessageRec(aMessage)^.DictType);
  CurChanges:=PDictMessageRec(aMessage)^.Operation;
  Case CurChanges of
   atAdd    : ReceiveAddNode(PDictMessageRec(aMessage)^.DictType,
                            PDictMessageRec(aMessage)^.ID,
                            PDictMessageRec(aMessage)^.ParentID);
   atDelete : ReceiveDelNode(PDictMessageRec(aMessage)^.DictType,
                            PDictMessageRec(aMessage)^.ID);
   atEdit   : ReceiveEditNode(PDictMessageRec(aMessage)^.DictType,
                             PDictMessageRec(aMessage)^.ID);
   atMove   : ReceiveMoveMode(PDictMessageRec(aMessage)^.DictType,
                             PDictMessageRec(aMessage)^.ID,
                             PDictMessageRec(aMessage)^.ParentID,
                             PDictMessageRec(aMessage)^.NextID);
  end;

  if PDictMessageRec(aMessage)^.DictType in [da_dlSources, da_dlTypes] then
   DropDictScanData;

  if Assigned(fNotifiedObjList) then
  begin
   I := Pred(fNotifiedObjList.Count);
   while I >= 0 do
   begin
    IDictChangeNotifyRecipient(fNotifiedObjList.Items[I]).dcn_DictionaryChange(PDictMessageRec(aMessage)^);
    Dec(I);
   end;
  end;
 end;
end;

function TDictionaryServer.GetDictsChanges(LastEnter : TStDateTimeRec) : TDLTypeSet;
Const
 NeededDicts : TDLTypeSet = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases,
                             da_dlWarnings, da_dlCorSources];
var
 I       : TdaDictionaryType;
 TmpDT   : TStDateTimeRec;
begin
 Result:=[];
 if fFamily=0 then raise EHtErrors.CreateInt(ecNotAssigned);

 For I:=da_dlSources to High(TdaDictionaryType) do
  begin
   TmpDT:=GetDictChanges(I);
   if LastEnter.D<TmpDT.D
     then
      Result:=Result+[I]
     else
      if (LastEnter.D=TmpDT.D) and
         (LastEnter.T<TmpDT.T)
       then
        Result:=Result+[I];
  end;
 Result:=Result*NeededDicts;
end;

procedure TDictionaryServer.GetEqualClassesList(ClassID : TDictID;aList : Tl3StringDataList);
var
 CurRootNode  : TDictRootNode;
 CurNode      : Il3Node;
 CurSab       : Sab;
 TmpIndex,
 TmpNum       : LongInt;
 l_ItemSize   : Longint;
begin
 if fFamily=0 then raise EHtErrors.CreateInt(ecNotAssigned);
 CurRootNode := DictRootNode[da_dlClasses].Use;
 Try
  aList.Clear;
  l_ItemSize := DictTbl[da_dlClasses].IDSize;
  aList.DataSize := l_ItemSize;
  aList.NeedAllocStr := False;

  CurSab := DictEqualObj[da_dlClasses].GetEqual(eqFID_Fld,ClassID);
  Try
   if CurSab.gFoundCnt>0
    then
     begin
      Ht(htOpenResults(CurSab,ROPEN_READ,Nil,0));
      Try
       While htReadResults(CurSab,@TmpNum,SizeOf(TmpNum))<>0 do
        begin
         CurNode := Dict[da_dlClasses].FindNodeByID(TDictID(TmpNum));
         if CurNode<>Nil then
          begin
           TmpIndex:=aList.Add(l3GetFullPathAlloc(CurRootNode,CurNode, gLinesLevelSlash,'  ',False),@TmpNum, l_ItemSize);
           if DictEqualObj[da_dlClasses].CheckEqualPair(TmpNum,ClassID)
            then
             aList.Flags[TmpIndex]:=aList.Flags[TmpIndex] or $8000;
          end;
        end;
      finally
       htCloseResults(CurSab);
      end;
     end;
  finally
   htClearResults(CurSab);
  end;
 finally
  l3Free(CurRootNode);
 end;
end;

procedure TDictionaryServer.CopyToJournaledDict(aJourDict,aNormalDict : TdaDictionaryType);
var
 lCurJourDict,
 lCurDict       : TDictionaryTbl;
 lTreeObj       : TTreeStrorage;
 lMaxDictNum    : TDictID;
 lCurJourEq,
 lCurDictEq     : TEqualItemsTbl;
 l_MaxIdValue   : LongWord;
begin
 if aJourDict in sJournaled then
 begin
  if LockServer.LockFamily(fFamily) then
  try
   lCurJourDict:=DictTbl[aJourDict];
   lCurDict:=DictTbl[aNormalDict];

   //GlobalHtServer.CloseAllTbls(fFamily);
   //try
    // Копирование табличных данных
    lCurJourDict.TemporalCloseTbl;
    try
     lCurDict.TemporalCloseTbl;
     try
      lCurJourDict.DropTblData;
      HT(htOutTo(@lCurDict.TblFullName[1],@lCurDict.TblPass[1],
              lCurDict.TblShareFlag,@lCurJourDict.TblFullName[1],
              @lCurJourDict.TblPass[1],@lCurJourDict.TblPass[1],
              nil,false,false));
      lCurJourDict.UpdateTbl;
     finally
      lCurDict.ReOpenTbl;
     end;
    finally
     lCurJourDict.ReOpenTbl;
    end;
   {finally
    GlobalHtServer.OpenClosedTbls;
   end;
   }

   // Копирование данных дерева
   if Assigned(Dict[aJourDict].RootNode) then
    begin
     Dict[aJourDict].RootNode.CloseTreeObj;
     Dict[aJourDict].RootNode.Changing;
    end;
   try
    lTreeObj:=TTreeStrorage.Create(Copy(lCurDict.TblFullName,1,
                                   Length(lCurDict.TblFullName)-1));
    try
     lTreeObj.CopyTo(Copy(lCurJourDict.TblFullName,1,
                          Length(lCurJourDict.TblFullName)-1));
    finally
     l3Free(lTreeObj);
    end;
   finally
    if Assigned(Dict[aJourDict].RootNode) then
    begin
     Dict[aJourDict].RootNode.OpenTreeObj;
     lCurJourDict.RegetItemList;
     Dict[aJourDict].RootNode.Load;
     Dict[aJourDict].RootNode.Changed;
    end;
   end;

   // Коррекция номеров в таблице Free
   lMaxDictNum:=lCurDict.GetMaxID;
   GlobalHtServer.FreeTbl[fFamily].ResetFreeTblNum(lCurJourDict.TblName,
                                                   lMaxDictNum,
                                                   lCurJourDict.MaxIdValue);

   GlobalHtServer.CloseAllTbls(fFamily);
   try
    // Копирование эквивалентных элементов
    lCurDictEq:=DictEqualObj[aNormalDict];
    lCurJourEq:=DictEqualObj[aJourDict];
    lCurJourEq.TemporalCloseTbl;
    try
     lCurJourEq.DropTblData;
     if lCurDictEq <> nil then
     begin
      lCurDictEq.TemporalCloseTbl;
      try
       HT(htOutTo(@lCurDictEq.TblFullName[1],@lCurDictEq.TblPass[1],
               lCurDictEq.TblShareFlag,@lCurJourEq.TblFullName[1],
               @lCurJourEq.TblPass[1],@lCurJourEq.TblPass[1],
               nil,false,false));
       lCurJourEq.UpdateTbl;
      finally
       lCurDictEq.ReOpenTbl;
      end;
     end;
    finally
     lCurJourEq.ReOpenTbl;
    end;
   finally
    GlobalHtServer.OpenClosedTbls;
   end;

  finally
   LockServer.UnLockFamily(fFamily);
  end
  else
   raise EHtErrors.CreateInt(ecUnableLockFamily);
 end
 else
  raise EHtErrors.CreateInt(ecNotEnable);
end;

procedure TDictionaryServer.CopyFromJournaledDict(aJourDict,aNormalDict : TdaDictionaryType);
var
 lCurJourDict,
 lCurModifiedDict : TDictionaryTbl;
 lTreeObj         : TTreeStrorage;
 lCurJourTree     : TDictRootNode;
 lDeletedRecs,
 lDeletedRecsZero,
 lNonDeleteRecs,
 lDeletedIDList   : SAB;
 lCurValue        : Integer;
 lDictJourItem    : IDictItemJour;
 lFreeT           : TFreeTbl;
 lMaxDictNum      : TDictID;
 lCurJourEq,
 lCurDictEq       : TEqualItemsTbl;

 l_DictIDs        : SAB;
 l_DocIDs         : SAB;
 l_ConvTable      : Tl3LongintList;

 lSab             : ISab;

 function IterHandler(const CurNode : Il3Node) : Boolean; far;
 begin
  if l3IOk(CurNode.queryInterface(IDictItemJour,lDictJourItem)) and
     (lDictJourItem.Operation = atDelete) then
   CurNode.Remove;
  lDictJourItem:=nil;
  Result:=False;
 end;

 procedure MakeConvTable(aDeletedItems : SAB; aMaxID : Integer);
 const
  OpenFldArr : Array[1..2] of SmallInt = (dtIDFld,dtNewIDFld);
 var
  I        : LongInt;
  TmpRec   : PAnsiChar;
  OldID,
  newID    : TDictID;

  TmpList  : TAbstractList;
  TmpMode  : TOpenMode;
 begin
  l_ConvTable := Tl3LongintList.Create;
  l_ConvTable.Count := aMaxID + 1;
  for I := 0 to l_ConvTable.Hi do
   l_ConvTable.Items[I] := I;


  TmpMode.openMode := ROPEN_BODY;
  TmpMode.Count := 2;
  TmpMode.FldArr := @OpenFldArr;
  TmpList := TAbstractList.Create(@aDeletedItems,TmpMode);
  TmpList.ReadForvard := True;
  try
   for I := 0 to Pred(TmpList.Count) do
   begin
    TmpRec := TmpList.GetItem(I);
    l3Move(TmpRec[0], OldID, SizeOf(TDictID));
    l3Move(TmpRec[SizeOf(TDictID)], newID, SizeOf(TDictID));
    l_ConvTable.Items[OldID] := newID;
   end;
  finally
   l3Free(TmpList);
  end;
 end;

 function lModifyRec_Link(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  lOldDictID : integer;
 begin
  Result := MFUNC_SUCCESS;
  with PSubLinkRec(fpRecord)^ do
  begin
   lOldDictID := DictID;
   DictID := l_ConvTable.Items[DictID];
   if DictID = 0 then

    Result := BoolToMFUNC_RET[lOldDictID <> DictID];
  end;
 end;

 function lModifyRec_EQ(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 begin
  Result := MFUNC_SUCCESS;
  with PEqualRec(fpRecord)^ do
  begin
   FirstID  := l_ConvTable.Items[FirstID];
   SecondID := l_ConvTable.Items[SecondID];
   if (FirstID = 0) or (SecondID = 0) then
    Result := MFUNC_ABORT;
  end;
 end;

var
 lHTStub    : Pointer;
 lAllRecSab : Sab;

begin
 if not (aJourDict in sJournaled) then raise EHtErrors.CreateInt(ecNotEnable);

 if LockServer.LockFamily(fFamily) then
  raise EHtErrors.CreateInt(ecUnableLockFamily);
 try
  lCurJourDict:=DictTbl[aJourDict];
  lCurModifiedDict:=DictTbl[aNormalDict];

  // Копирование табличных данных
  lCurModifiedDict.DropTblData;
  lCurModifiedDict.TemporalCloseTbl;
  try
   lCurJourDict.TemporalCloseTbl;
   try
    HT(htOutTo(@lCurJourDict.TblFullName[1],@lCurJourDict.TblPass[1],
               lCurJourDict.TblShareFlag,@lCurModifiedDict.TblFullName[1],
               @lCurModifiedDict.TblPass[1],@lCurModifiedDict.TblPass[1],
               nil,false,false));

   finally
    lCurJourDict.ReOpenTbl;
   end;
  finally
   lCurModifiedDict.ReOpenTbl;
  end;

  lCurModifiedDict.UpdateTbl;

  // Копирование эквивалентных элементов
  lCurDictEq := DictEqualObj[aNormalDict];
  lCurJourEq := DictEqualObj[aJourDict];

  if lCurDictEq <> nil then
  begin
   lCurDictEq.DropTblData;
   lCurDictEq.TemporalCloseTbl;
   try
    lCurJourEq.TemporalCloseTbl;
    try
     HT(htOutTo(@lCurJourEq.TblFullName[1],@lCurJourEq.TblPass[1],
              lCurJourEq.TblShareFlag,@lCurDictEq.TblFullName[1],
              @lCurDictEq.TblPass[1],@lCurDictEq.TblPass[1],
              nil,false,false));
    finally
     lCurJourEq.ReOpenTbl;
    end;
   finally
    lCurDictEq.ReOpenTbl;
   end;
   lCurDictEq.UpdateTbl;
  end;

  // Запись в лог
  lSab := MakeSab(lCurJourDict);
  lCurValue := Byte(atNone);
  lSab.Select(dtOperationFld, lCurValue, NOT_EQUAL);
  lSab.ValuesOfKey(dtIDFld);
  lSab.TransferToPhoto(lnkDictIDFld, LinkServer(fFamily).Links[aNormalDict]);
  lSab.ValuesOfKey(lnkDocIDFld);
  LinkServer(fFamily).LogBook.PutLogRecToDocs(lSab, acClassWork);

  (*
  // Старая !!! Запись в лог

  lCurJourDict.RefreshSrchList;
  lCurValue := Byte(atNone);
  htSearch(@lCurJourDict.fSrchList,
           lNonDeleteRecs,
           lCurJourDict.Handle,
           dtOperationFld,
           NOT_EQUAL,
           @lCurValue,
           nil);
  try
   htValuesOfKey(l_DictIDs, dtIDFld, lNonDeleteRecs);
   try
    LinkServer(fFamily).Links[aNormalDict].SrchOnBodies1(l_DictIDs, l_DocIDs, nil, True);
    GlobalHtServer.LogBook[CurrentFamily].PutLogRecToDocs(MakeSab(LinkServer(fFamily).Links[aNormalDict], l_DocIDs), acClassWork);
   finally
    htClearResults(l_DictIDs);
   end;
  finally
   htClearResults(lNonDeleteRecs);
  end;
  *)

  // Удаление "удаленных" элементов из таблиц
  lCurValue := Byte(atDelete);
  htSearch(nil, lDeletedRecs, lCurJourDict.Handle,
           dtOperationFld, EQUAL, @lCurValue, nil);
  try
   htValuesOfKey(lDeletedIDList,dtIDFld, lDeletedRecs);
   try
    lCurModifiedDict.DeleteItems(lDeletedIDList);
    lCurModifiedDict.PutFreeNums(lDeletedIDList);

    (* не корректируем эквивалентные, а удаляем *)
    if lCurDictEq <> nil then
    if lCurModifiedDict.fldLength[dtIDFld] = SizeOf(TDictID) then
     lCurDictEq.DelAllEqualOnIDs(lDeletedIDList)
    else
     lCurDictEq.DelAllEqualOnWordIDs(lDeletedIDList);
    (**)
   finally
    htClearResults(lDeletedIDList);
   end;

   MakeConvTable(lDeletedRecs, lCurJourDict.MaxID);
   try
    lCurValue := 0;
    htSubSearch(lDeletedRecs, lDeletedRecsZero, lCurJourDict.Handle,
                dtNewIDFld, EQUAL, @lCurValue, nil);
    try
     if lDeletedRecsZero.gFoundCnt > 0 then
      //удалим те которые не имеют преемника
     begin
      htValuesOfKey(lDeletedIDList, dtIDFld, lDeletedRecsZero);
      try
       // ... в Link
       LinkServer(fFamily).Links[aNormalDict].DelAllNodesOnBodies(lDeletedIDList);

      (* не корректируем эквивалентнтные, а удаляем
       // ... в EQ
       if lCurDictEq <> nil then
       if lCurModifiedDict.fldLength[dtIDFld] = SizeOf(TDictID) then
        lCurDictEq.DelAllEqualOnIDs(lDeletedIDList)
       else
        lCurDictEq.DelAllEqualOnWordIDs(lDeletedIDList);
       *)
      finally
       htClearResults(lDeletedIDList);
      end;
     end;

     //подкорректирум те которые имеют преемника
     with LinkServer(fFamily).Links[aNormalDict].Table do
     begin
      lHTStub := HTStub3(@lModifyRec_Link);
      try
       IgnoreDuplicates := True;
       try
        lAllRecSab := MakeAllRecordsSab;
        try
         ModifyRecs(lAllRecSab, lHTStub, True {DupIgnore});
        finally
         htClearResults(lAllRecSab);
        end;
       finally
        IgnoreDuplicates := False;
       end;
      finally
       HTStubFree(lHTStub);
      end;
      UpdateTbl;
     end;
     
     (* не корректируем эквивалентные, а удаляем
     if lCurDictEq <> nil then
     begin
      lHTStub := HTStub3(@lModifyRec_EQ);
      try
       lCurDictEq.IgnoreDuplicates := True;
       try
        lCurDictEq.ModifyRecs(nil, lHTStub, True {DupIgnore});
       finally
        lCurDictEq.IgnoreDuplicates := False;
       end;
      finally
       HTStubFree(lHTStub);
      end;
      lCurDictEq.UpdateTbl;
     end;
     *)
    finally
     htClearResults(lDeletedRecsZero);
    end;
   finally
    l3Free(l_ConvTable);
   end;
  finally
   htClearResults(lDeletedRecs);
  end;

  // Создание резервной копии дерева Journal
  lTreeObj:=TTreeStrorage.Create(Copy(lCurJourDict.TblFullName,1,
                                 Length(lCurJourDict.TblFullName)-1));
  try
   lTreeObj.CopyTo(GlobalHtServer.FamilyTbl.FamilyPath(fFamily)+'tmpJour');
  finally
   l3Free(lTreeObj);
  end;
  try
   // Удаление "удаленных" элементов из дерева
   lCurJourTree:=DictRootNode[aJourDict];
   l3IterateSubTreeF(lCurJourTree,l3L2NA(@IterHandler),0);
   //lCurJourTree.Save(nil,True);

   // Копирование данных дерева
   if Assigned(Dict[aNormalDict].RootNode) then
   begin
    Dict[aNormalDict].RootNode.CloseTreeObj;
    Dict[aNormalDict].RootNode.Changing;
   end;
   try
    lTreeObj:=TTreeStrorage.Create(Copy(lCurJourDict.TblFullName,1,
                                   Length(lCurJourDict.TblFullName)-1));
    try
     lTreeObj.CopyTo(Copy(lCurModifiedDict.TblFullName,1,
                          Length(lCurModifiedDict.TblFullName)-1));
    finally
     l3Free(lTreeObj);
    end;
   finally
    if Assigned(Dict[aNormalDict].RootNode) then
    begin
     Dict[aNormalDict].RootNode.OpenTreeObj;
     lCurModifiedDict.RegetItemList;
     Dict[aNormalDict].RootNode.Load;
     Dict[aNormalDict].RootNode.Changed;
    end;
   end;
  finally
   // Восстановление из резервной копии дерева Journal
   if Assigned(Dict[aJourDict].RootNode) then
   begin
    Dict[aJourDict].RootNode.CloseTreeObj;
    Dict[aJourDict].RootNode.Changing;
   end;
   try
    lTreeObj:=TTreeStrorage.Create(GlobalHtServer.FamilyTbl.FamilyPath(fFamily)+'tmpJour');
    try
     lTreeObj.CopyTo(Copy(lCurJourDict.TblFullName,1,
                          Length(lCurJourDict.TblFullName)-1));
     DeleteFile(GlobalHtServer.FamilyTbl.FamilyPath(fFamily)+'tmpJour.tre');
     DeleteFile(GlobalHtServer.FamilyTbl.FamilyPath(fFamily)+'tmpJour.trc');
    finally
     l3Free(lTreeObj);
    end;
   finally
    if Assigned(Dict[aJourDict].RootNode) then
    begin
     Dict[aJourDict].RootNode.OpenTreeObj;
     Dict[aJourDict].RootNode.Load;
     Dict[aJourDict].RootNode.Changed;
    end;
   end;
  end;

  // Коррекция номеров в таблице Free
  lMaxDictNum:=lCurJourDict.GetMaxID;
  GlobalHtServer.FreeTbl[fFamily].ResetFreeTblNum(lCurModifiedDict.TblName,
                                                  lMaxDictNum,
                                                  lCurModifiedDict.MaxIdValue);

 finally
  LockServer.UnLockFamily(fFamily);
 end;
end;

procedure TDictionaryServer.PO_Begin;
begin
 Inc(fPocketModify);
end;

procedure TDictionaryServer.PO_End;
begin
 if fPocketModify > 0 then Dec(fPocketModify);
end;

function TDictionaryServer.GetPublishData(const aDocIds: ISab; aSortedBySourceId: Boolean = False) : ISabCursor;
var
 lPublPhoto   : ISab;
 lLinkSab     : ISab;
 lJoinLinkSab : IJoinSab;
 lJoinPublSab : IJoinSab;
 lAllSab      : IJoinSab;

 lLinkTbl     : TdtTable;
 lPublTbl     : TdtTable;
 lCSrcTbl     : TdtTable;

begin
  if aDocIds.IsEmpty then
  begin
   Result := nil;
   Exit;
  end; 

  lLinkTbl := LinkServer(fFamily)[atPublisheds].Table;
  lPublTbl := Tbl[da_dlPublisheds];
  lCSrcTbl := Tbl[da_dlCorSources];

  lLinkSab := MakeSabCopy(aDocIds);
  lLinkSab.RecordsByKey(lnkDocIDFld, MakePhoto(lLinkTbl));

  lPublPhoto := MakeAllRecords(lPublTbl);
  lJoinLinkSab := MakeJoinSab(lLinkSab, lnkDictIDFld,
                              lPublPhoto, dtIDFld);

  lJoinPublSab := MakeJoinSab(lPublPhoto, piSourFld,
                              MakeAllRecords(lCSrcTbl), dtIDFld);

  lAllSab := MakeJoinSab(lJoinLinkSab, lJoinPublSab);

  if aSortedBySourceId then
   lAllSab.SortJoin([JFRec(lPublTbl, piSourFld)]) // сортировка по полю DT#B.Source
  else
   lAllSab.SortJoin([JFRec(lLinkTbl, lnkDocIDFld)]); // сортировка по полю LNK#B.DocId

  lAllSab.Flush;

  Result := lAllSab.MakeJoinSabCursor([JFRec(lPublTbl, piIDFld),            // DT#B.Id  (см. Dt_Types.TPublishDataRec)
                                       JFRec(lPublTbl, piSourFld),          // DT#B.Source = DT#A.Id
                                       JFRec(lPublTbl, piSDateFld),         // DT#B.StartDate
                                       JFRec(lPublTbl, piEDateFld),         // DT#B.EndDate
                                       JFRec(lPublTbl, piNumberFld),        // DT#B.Number
                                       JFRec(lPublTbl, piCommentFld),       // DT#B.Coment
                                       JFRec(lLinkTbl, lnkPublihedsPages),  // LNK#B.Pages
                                       JFRec(lLinkTbl, lnkPublihedsComent), // LNK#B.Coment
                                       JFRec(lLinkTbl, lnkPublihedsFlags),  // LNK#B.Flags
                                       JFRec(lLinkTbl, lnkDocIDFld),        // LNK#B.DocId
                                       JFRec(lCSrcTbl, dtShNameFld),        // DT#A.ShName
                                       JFRec(lCSrcTbl, dtIsPrivate),        // DT#A.Private
                                       JFRec(lCSrcTbl, dtIsNonperiodic)],   // DT#A.Nonperiod
                                      cmForward, ROPEN_READ);

end;

(*procedure TDictionaryServer.GetPublishData(aDocId: TDocId;
                                           aResult: Tl3CustomDataList;
                                           aSortedBySourceId: Boolean = False);
var
 l_DocIds   : ISab;
 I          : Integer;
 lSabCursor : ISabCursor;

begin
 if not Assigned(aResult) then Exit;

 l_DocIds := MakeValueSet(LinkServer(fFamily).Links[da_dlPublisheds], lnkDocIDFld, @aDocId, 1);

 lSabCursor := GetPublishData(l_DocIds, aSortedBySourceId);

 aResult.Changing;
 try
  aResult.Clear;
  aResult.DataSize := lSabCursor.ItemSize;
  for I := 0 to Pred(lSabCursor.Count) do
   aResult.Add(lSabCursor.GetItem(I));
 finally
  aResult.Changed;
 end;
end;*)

function TDictionaryTbl.GetNameE(aID: TDictID): AnsiString;
var
 RecH     : RHandle;
 TmpName  : PAnsiChar;
 tmpIndex : LongInt;
 l_Ok : Longint;
begin
 l_Ok := GetRecordIDByUniq(dtIDfld, aID);
 if l_Ok <= 0 then
  raise EHtErrors.CreateInt(ecNotFound);
 GetFullRec(l_Ok, False);
 GetFromFullRec(dtNameEFld,TmpName);
 Try
  Result := StrPas(TmpName);
 finally
  l3StrDispose(TmpName);
 end;
end;

function TDictionaryTbl.GetNameR(aID: TDictID): AnsiString;
var
 RecH     : RHandle;
 TmpName  : PAnsiChar;
 tmpIndex : LongInt;
 l_Ok : Longint;
begin
 l_Ok := GetRecordIDByUniq(dtIDfld, aID);
 if l_Ok <= 0  then
   raise EHtErrors.CreateInt(ecNotFound);
 GetFullRec(l_Ok, False);
 GetFromFullRec(dtNameRFld, TmpName);
 Try
  Result := StrPas(TmpName);
 finally
  l3StrDispose(TmpName);
 end;
end;

function TDictionaryTbl.GetIsPrivate(aID: TDictID): TIsPrivate;
var
 l_RecH : RHandle;
 l_Ok   : Longint;
begin
 l_Ok := GetRecordIDByUniq(dtIDfld, aID);
 if l_Ok <= 0 then
  raise EHtErrors.CreateInt(ecNotFound);
 GetFullRec(l_Ok, False);
 GetFromFullRec(dtIsPrivate, Result);
end;

function TDictionaryTbl.AdornNodeName(anID: Longword; const aName: AnsiString): AnsiString;
begin
 Result := aName;
end;

procedure TDictionaryTbl.SetNameE(aID: TDictID; const aName: AnsiString);
var
 l_AbsNum : Longint;
begin
 l_AbsNum := GetRecordIDByUniq(dtIDfld, aID);
 if l_AbsNum <= 0 then
  raise EHtErrors.CreateInt(ecNotFound);
 GetFullRec(l_AbsNum, True);
 try
  PutToFullRec(dtNameEFld, aName);
  UpdFRec(l_AbsNum);
 finally
  FreeRec(l_AbsNum);
 end;
end;

function TDictionaryTbl.NeedItemList: Boolean;
begin
 Result := fNeedLoadItemList;
end;

function TDictionaryTbl.pm_GetIsLoaded: Boolean;
begin
 Result := fItemList <> nil;
end;

(*procedure TDictionaryServer.AddBatchToGroupDict(aDictType: TdaDictionaryType; aData: TStream);

 function lAddBatchToGroupDict(nOrder: ADD_MODE; fpParm: LPAPARM) : Cardinal;
 begin
  if nOrder = ADD_FIRST then
   aData.Position := 0;

  if (fpParm = nil) or (fpParm^.wBufLen = 0) then
  begin
   Result := 0;
   Exit;
  end;

  with fpParm^ do
  begin
   aData.Read(PAnsiChar(fpBuf)^, wBufLen);
   Result := wBufLen;
  end;
 end;

var
 l_Table: TParamGroupTbl;
 l_Links: Tl3MemoryStream;
 l_RecAmount: Integer;
 l_FreeNums: TNumSet;
 l_LinkRec: packed record DocId, DictId: LongWord; end;
 I: Integer;
 l_SavedPos: Integer;
 lHTStub   : Pointer;

begin
 if not (aDictType in [da_dlDateNums, da_dlCorrects]) then
  raise Exception.Create('Использование метода TDictionaryServer.AddBatchToDict с недопустимым типом словаря.');
   // Увы, заточено только под DT#7 и DT#9.

 l_Table := GroupTbl[aDictType];
 l_RecAmount := aData.Size div l_Table.RecSize;

 // новые DictId
 l_FreeNums := TNumSet.Create;
 try
  GlobalHtServer.FreeTbl[CurrentFamily].GetFreeNums(l_Table.TblName,
                                                    l_RecAmount,
                                                    l_RecAmount,
                                                    l_FreeNums);
  l_Links := Tl3MemoryStream.Make;
  try
   aData.Position := 0;
   for I := 0 to l_RecAmount - 1 do
   begin
    l_SavedPos := aData.Position;

    // запись в поток линков очередной порции (DocId, DictId)
    aData.Read(l_LinkRec.DocId, SizeOf(l_LinkRec.DocId)); // DocId
    l_LinkRec.DictId := l_FreeNums.Pick; // DictId
    l_Links.Write(l_LinkRec, SizeOf(l_LinkRec));

    // замена в потоке DocId на DictId
    aData.Seek(l_SavedPos, soFrombeginning); // вернемся назад
    aData.Write(l_LinkRec.DictId, SizeOf(l_LinkRec.DictId)); // DocId

    // прыгаем на след. запись
    aData.Position := aData.Position + l_Table.RecSize - SizeOf(l_LinkRec.DictId);
   end;

   // запись в словарь исходного потока (с замененными Id)
   Dict[aDictType].Lock;
   try
    l_Table.StartTA;
    try
     lHTStub := HTStub3(@lAddBatchToGroupDict);
     try
      Ht(htPureAddRecords(l_Table.Handle, l_RecAmount, lHTStub, nil));
     finally
      HTStubFree(lHTStub);
     end;
     l_Table.SuccessTA;
    except
     l_Table.RollBackTA;
     raise;
    end;
   finally
    Dict[aDictType].UnLock;
   end;

   // запись в таблицу линков созданного потока
   LinkServer(fFamily).AddLinksToGroupDict(aDictType, l_Links);

  finally
   FreeAndNil(l_Links);
  end;
 finally
  l3Free(l_FreeNums);
 end;
end;
*)

procedure TDictionaryServer.GetNearestEqualsFor(aDict: TdaDictionaryType;
                                                aId: TDictID;
                                                aList: Tl3StringDataList);
var
 CurRootNode  : TDictRootNode;
 CurNode      : Il3Node;
 CurSab       : Sab;
 TmpIndex,
 TmpNum       : LongInt;
 l_ItemSize   : Longint;
begin
 if aList = nil then
  Exit;

 if fFamily=0 then
  raise EHtErrors.CreateInt(ecNotAssigned);
 CurRootNode := DictRootNode[aDict].Use;
 Try
  aList.Clear;
  l_ItemSize := DictServer(fFamily).DictTbl[aDict].IDSize;
  aList.DataSize := l_ItemSize;
  aList.NeedAllocStr:=False;

  CurSab := DictEqualObj[aDict].GetEqual(eqFID_Fld, aId);
  Try
   if CurSab.gFoundCnt>0 then
   begin
    Ht(htOpenResults(CurSab,ROPEN_READ,Nil,0));
    Try
     While htReadResults(CurSab,@TmpNum,SizeOf(TmpNum))<>0 do
     begin
      CurNode := Dict[aDict].FindNodeByID(TDictID(TmpNum));
      if CurNode<>Nil then
      begin
       TmpIndex:=aList.Add(l3GetFullPathAlloc(CurRootNode, CurNode, gLinesLevelSlash, '  ', False),
                           @TmpNum,
                           l_ItemSize);
       if DictEqualObj[aDict].CheckEqualPair(TmpNum, aId) then
        aList.Flags[TmpIndex]:=aList.Flags[TmpIndex] or $8000;
      end;
     end; // while
    finally
     htCloseResults(CurSab);
    end;
   end; // if
  finally
   htClearResults(CurSab);
  end;
 finally
  l3Free(CurRootNode);
 end;
end;

function TDictionaryServer.CSClientNotify(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;
var
 l_Q: TGetDictEditQuery;
 i: longint;
 l_Info : TDictMessageRec;
begin
 Result := False;
 if aNotificationType = ntDictEdit then
 begin
  l_Q:= TGetDictEditQuery.Create(csClient.ClientID, aNumber);
  try
   //l_Q.TaskIndex := aNumber;
   if CSClient.Exec(qtGetDictEdit, l_Q.CommunicateWithServer) then
   begin
    Result:= True;
    l_Info.Family := l_Q.Family;
    l_Info.DictType := TdaDictionaryType(l_Q.DictType);
    l_Info.Operation := TOperActionType(l_Q.Operation);
    l_Info.ID := l_Q.ID;
    l_Info.ParentID := l_Q.ParentID;
    l_Info.NextID := l_Q.NextID;

    if l_Info.Family = fFamily then
    begin
     RefreshDictList(l_Info.DictType);
     Case l_Info.Operation of
      atAdd    : ReceiveAddNode(l_Info.DictType,
                               l_Info.ID,
                               l_Info.ParentID);
      atDelete : ReceiveDelNode(l_Info.DictType,
                               l_Info.ID);
      atEdit   : ReceiveEditNode(l_Info.DictType,
                                l_Info.ID);
      atMove   : ReceiveMoveMode(l_Info.DictType,
                                l_Info.ID,
                                l_Info.ParentID,
                                l_Info.NextID);
     end; // case l_Q.Operation
     if Assigned(fNotifiedObjList) then
     begin
      I := Pred(fNotifiedObjList.Count);
      while I >= 0 do
      begin
       IDictChangeNotifyRecipient(fNotifiedObjList.Items[I]).dcn_DictionaryChange(l_Info);
       Dec(I);
      end; // while I >= 0
     end; // Assigned(fNotifiedObjList)
    end; // l_Q.Family = fFamily
   end; // CSClient.Exec(qtGetDictEdit, l_Q.WriteToPipe)
  finally
   l3Free(l_Q);
  end; // try..finally
 end; // aNotificationType = ntDictEdit
end;

procedure TDictionaryServer.ProcessDictEdit(theDictRec: TDictMessageRec; ExcludeUser: Integer);
var
 I    : Longint;
 l_Rec: TDictRec;
 l_Msg: TDictEditQuery;
begin
 // клиент передал на сервер информацию об элементе словаря, который он изменил
 if (theDictRec.Family = fFamily) and DictTbl[theDictRec.DictType].IsLoaded and IsDictClass(theDictRec.DictType) then
 begin
  RefreshDictList(theDictRec.DictType);

  Case theDictRec.Operation of
   atAdd    : ReceiveAddNode(theDictRec.DictType,
                            theDictRec.ID,
                            theDictRec.ParentID);
   atDelete : ReceiveDelNode(theDictRec.DictType,
                            theDictRec.ID);
   atEdit   : ReceiveEditNode(theDictRec.DictType,
                             theDictRec.ID);
   atMove   : ReceiveMoveMode(theDictRec.DictType,
                             theDictRec.ID,
                             theDictRec.ParentID,
                             theDictRec.NextID);
  end;

  if Assigned(fNotifiedObjList) then
  begin
   I := Pred(fNotifiedObjList.Count);
   while I >= 0 do
   begin
    IDictChangeNotifyRecipient(fNotifiedObjList.Items[I]).dcn_DictionaryChange(theDictRec);
    Dec(I);
   end;
  end;
 end; // (theDictRec.Family = fFamily) and DictTbl[theDictRec.DictType].IsLoaded
 SendNotify(theDictRec, ExcludeUser);
end;

procedure TDictionaryServer.cs_GetDictEdit(aDataPipe: TcsDataPipe);
var
 l_Index : Integer;
 l_Msg : TDictEditQuery;
begin
 // Найти исправленный элемент и передать пользователю
 l_Index := aDataPipe.ReadInteger;
 if (l_Index >= 0) AND (l_Index < f_EditedItems.Count) then
  l_Msg := f_EditedItems.Items[l_Index]
 else 
  l_Msg := nil;
 if (l_Msg <> nil) then
 begin
  aDataPipe.WriteInteger(l_Msg.Family);
  aDataPipe.WriteInteger(l_Msg.DictType);
  aDataPipe.WriteInteger(l_Msg.Operation);
  aDataPipe.WriteInteger(l_Msg.ID);
  aDataPipe.WriteInteger(l_Msg.ParentID);
  aDataPipe.WriteInteger(l_Msg.NextID);
 end;//l_Msg <> nil
end;
(*
function TDictionaryServer.pm_GetBusy: Boolean;
begin
 Result := false;
end;
*)
procedure TDictionaryServer.pm_SetCSClient(const Value: TcsClient);
begin
 if f_CSClient <> Value then
 begin
  f_CSClient := Value;
  f_CSClient.AddNotifyProc(CSClientNotify);

 end; // f_CSClient <> Value
end;

{$IfDef AppServerSide}
procedure TDictionaryServer.pm_SetMessageManager(const Value: TcsMessageManager);
begin
 if f_MessageManager <> Value then
  f_MessageManager := Value;
end;
{$EndIf AppServerSide}

procedure TDictionaryServer.SendNotify(theDictRec: TDictMessageRec; ExcludeUser: Integer);
var
 l_Msg: TDictEditQuery;
begin
 {$IfDef AppServerSide}
 Assert(MessageManager <> nil, 'Не присвоен MessageManager');
 l_Msg := TDictEditQuery.Create(usServerService);
 try
  l_Msg.Family := theDictRec.Family;
  l_Msg.DictType := Ord(theDictRec.DictType);
  l_Msg.Operation := Ord(theDictRec.Operation);
  l_Msg.ID := theDictRec.ID;
  l_Msg.ParentID := theDictRec.ParentID;
  l_Msg.NextID := theDictRec.NextID;
  MessageManager.SendNotify(c_AllClients, ntDictEdit, f_EditedItems.Add(l_Msg), '', ExcludeUser);
 finally
  l3Free(l_Msg);
 end;
 {$Else  AppServerSide}
 Assert(false);
 {$EndIf AppServerSide}
end;

function DictServer(aFamily: TdaFamilyID = CurrentFamily): TDictionaryServer;
begin
 if gDictServer = nil then
  gDictServer:= TDictionaryServer.Create;
 gDictServer.Family:= aFamily;
 Result := gDictServer;
end;

procedure FreeDictServer;
begin
 l3Free(gDictServer);
end;

function GetExpandDictIDValueSab(aDictType : TdaDictionaryType; aDictIDList : Tl3LongintList; aIsInvert : boolean = False) : ISab;
// На входе лист элементов словаря, на выходе Sab ЛИСТЬЕВЫХ элементов словаря для этих веток
 var
  lValueSetFiller : IValueSetFiller;
  lHasMasterDict : Boolean;

 function IsExtNode(const aNode : Il3Node) : boolean;
 begin
  Result := Supports(aNode, Il3ExtItemNode);
 end;

 function IterHandler(aCurNode : Il3Node) : Boolean; far;

  function IterLeafHandler(aLeafCurNode : Il3Node) : Boolean; far;
  var
   lHandle : integer;
  begin
   // листьевые ноды для занесения в список выделенных
   if not lHasMasterDict or IsExtNode(aLeafCurNode) then
   begin
    lHandle := (aLeafCurNode as Il3HandleNode).Handle;
    lValueSetFiller.AddValue(lHandle);
   end;
  end;

  var
   lHandle : integer;
   lIsMasterDictNode : boolean;

  begin
   Result := False;
   lHandle := (aCurNode as Il3HandleNode).Handle;

   //если словарь составной и aCurNode из MasterDict то lHandle нужно взвести старший бит (знак поменять),
   // тк таким образом кодируется в fDictIDList то что это элемент MasterDict
   lIsMasterDictNode := lHasMasterDict and not IsExtNode(aCurNode);
   if lIsMasterDictNode then
    lHandle := - lHandle;

   if aDictIDList.IndexOf(lHandle) >= 0 then
   begin
    if (not lHasMasterDict or lIsMasterDictNode) and aCurNode.HasChild then
    begin
     aCurNode.IterateF(l3L2NA(@IterLeafHandler), imLeavesOnly);
     Byte(Result) := 2; //skipChilds
    end
    else
     if not lHasMasterDict or not lIsMasterDictNode then
      lValueSetFiller.AddValue(lHandle);
   end;
  end;
 function InvertIterHandler(aCurNode : Il3Node) : Boolean; far;
  var
   lHandle : integer;
   lIsMasterDictNode : boolean;

  begin
   Result := False;
   lHandle := (aCurNode as Il3HandleNode).Handle;

   //если словарь составной и aCurNode из MasterDict то lHandle нужно взвести старший бит (знак поменять),
   // тк таким образом кодируется в fDictIDList то что это элемент MasterDict
   lIsMasterDictNode := lHasMasterDict and not IsExtNode(aCurNode);
   if lIsMasterDictNode then
    lHandle := - lHandle;

   if aDictIDList.IndexOf(lHandle) >= 0 then
   begin
    if (not lHasMasterDict or lIsMasterDictNode) and aCurNode.HasChild then
     Byte(Result) := 2; //skipChilds
   end
   else
    if not (lHasMasterDict and lIsMasterDictNode) and not aCurNode.HasChild then
     lValueSetFiller.AddValue(lHandle);
  end;

begin
 lHasMasterDict := GetMasterDict(aDictType) <> da_dlNone;

 Result := MakeSab(LinkServer(CurrentFamily).Links[aDictType].Table);
 lValueSetFiller := Result.MakeValueSetFiller(lnkDictIDFld);
 try
  if aIsInvert then
   DictServer(CurrentFamily).DictRootNode[aDictType].IterateF(l3L2NA(@InvertIterHandler), imCheckResult)
  else
   DictServer(CurrentFamily).DictRootNode[aDictType].IterateF(l3L2NA(@IterHandler), imCheckResult);
 finally
  lValueSetFiller := nil;
 end;
end;

procedure ExpandDictIDList(aDictionary: TdaDictionaryType; var theIDList: Tl3LongintList);
var
 l_Sab: ISab;
begin
 if theIDList <> nil then
 begin
  l_Sab := GetExpandDictIDValueSab(aDictionary, theIDList);
  try
   theIDList.Clear;
   dtCopyValuesSabToList(l_Sab, theIDList);
  finally
   l_Sab := nil;
  end;
 end; // theIDList <> nil
end;


initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\DT_DICT.PAS initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\DT_DICT.PAS initialization leave'); {$EndIf}
end.



