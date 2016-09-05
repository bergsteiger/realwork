unit CustEditWin;

{ $Id: CustEditWin.pas,v 1.41 2016/08/11 10:41:57 lukyanets Exp $ }

// $Log: CustEditWin.pas,v $
// Revision 1.41  2016/08/11 10:41:57  lukyanets
// Полчищаем dt_user
//
// Revision 1.40  2016/06/16 05:38:44  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.39  2016/06/03 07:48:32  fireton
// - недокоммит
//
// Revision 1.38  2016/04/22 10:59:48  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.37  2016/04/18 08:39:29  lukyanets
// Cleanup
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.36  2015/12/25 12:49:10  voba
// no message
//
// Revision 1.34  2015/12/10 13:58:40  voba
// -k:613297314
//
// Revision 1.33  2015/11/26 08:45:27  lukyanets
// КОнстанты переехали
//
// Revision 1.32  2015/11/23 11:36:56  lukyanets
// Заготовки Renum
//
// Revision 1.31  2015/06/25 10:46:19  dinishev
// Установка полосатого стиля на таблицу.
//
// Revision 1.30  2015/04/17 10:40:07  kostitsin
// {requestlink: 597331965 }
//
// Revision 1.29  2015/04/15 15:05:07  voba
// -bf
//
// Revision 1.28  2015/04/06 09:38:26  lukyanets
// Изолируем язык базы
//
// Revision 1.27  2015/03/16 08:38:02  voba
// - локальное автосохранение документов
//
// Revision 1.26  2015/03/05 06:08:22  dinishev
// Не компилировалось.
//
// Revision 1.25  2015/01/14 13:45:38  voba
// - bug fix : маска прав неправильно считалась для AccGroup
//
// Revision 1.24  2014/10/21 14:02:30  voba
//  k:569221072
//
// Revision 1.23  2014/09/26 13:43:31  dinishev
// Ручки для скрытия диалога о залочивании документа.
//
// Revision 1.22  2014/09/24 14:54:00  lulin
// - готовимся к запуску тестов с разных машин.
//
// Revision 1.21  2014/08/29 10:26:52  fireton
// - реализация макроса
//
// Revision 1.20  2014/08/11 09:52:51  voba
// - Реакцию DragData а закрытие дока подправил
//
// Revision 1.19  2014/08/08 07:55:05  dinishev
// Bug fix: вернул правки {Requestlink:557869554} - тепрь они не имеют смысла.
//
// Revision 1.18  2014/07/31 10:24:34  dinishev
// {Requestlink:557869554}
//
// Revision 1.17  2014/06/09 12:19:00  dinishev
// Оказывется {Requestlink:512986739} давно уже отъехало...
//
// Revision 1.16  2014/05/14 13:11:11  lulin
// {RequestLink:517789752}.
//
// Revision 1.15  2014/04/25 10:28:16  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.14  2014/04/08 12:34:36  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.13  2014/04/07 08:06:39  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.12  2014/04/03 13:12:06  voba
//  k:236721575 (Атрибуты в EVD)  Merge
//
// Revision 1.11  2014/03/26 14:54:09  dinishev
// Обобщил код установки стиля в Арчи и EverestLite
//
// Revision 1.4.2.2  2014/03/05 13:13:34  voba
// - merge c 1.10
//
// Revision 1.10  2014/03/04 14:47:08  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.9  2014/02/28 08:29:50  dinishev
// Bug fix: неправильно выставлялся стиль.
//
// Revision 1.8  2014/02/27 08:51:05  fireton
// - данные шаблонов - на синглетон
//
// Revision 1.7  2014/02/26 11:21:24  dinishev
// Bug fix: отъехало выставление стилей в Арчи.
//
// Revision 1.6  2014/02/24 11:43:25  fireton
// - шаблоны
//
// Revision 1.5  2014/02/21 13:09:06  dinishev
// "Скрытый" Preview в Арчи.
//
// Revision 1.4  2014/01/31 12:26:10  dinishev
// {Requestlink:515524193}. Временный фильтр-костыль для обработки, вставляемого из буфера.
//
// Revision 1.145.2.4  2013/10/25 09:23:58  voba
// - k:236721575 (Атрибуты в EVD)
//
// Revision 1.145.2.3  2013/08/12 11:46:46  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.145.2.2  2013/07/30 14:05:50  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.145.2.1  2013/07/19 11:42:59  voba
// - K:236721575 (Загрузка и запись атрибутов из тегов EVD)
//
// Revision 1.145  2013/05/31 07:20:24  lulin
// - портируем под XE4.
//
// Revision 1.144  2013/04/30 08:37:28  dinishev
// {Requestlink:453149163}
//
// Revision 1.143  2013/04/19 13:04:38  lulin
// - портируем.
//
// Revision 1.142  2013/02/27 13:50:38  dinishev
// {Requestlink:431386215}. Еще один тест + начало обоощения тестов Арчи и Эвереста.
//
// Revision 1.141  2013/02/25 15:11:10  voba
// - K:358358627
//
// Revision 1.140  2012/10/29 12:20:10  dinishev
// Bug fix: не правились ID сабов при вставке из буфера (RTF, txt и т.п.)
//
// Revision 1.139  2012/09/07 10:54:54  dinishev
// {Requestlink:390586769}
//
// Revision 1.138  2012/08/15 13:24:58  dinishev
// {Requestlink:384434990}
//
// Revision 1.137  2012/06/05 13:19:41  voba
// - убрал зоопарк инклюдов в опциями компиляции, оставил только ProjectDefine.inc
//
// Revision 1.136  2012/05/17 12:43:01  voba
// no message
//
// Revision 1.135  2012/04/25 10:42:57  dinishev
// Вычищаем старый код.
//
// Revision 1.134  2012/04/11 09:10:26  dinishev
// Cleanup
//
// Revision 1.133  2012/04/11 08:08:23  dinishev
// Cleanup
//
// Revision 1.132  2012/04/04 14:05:14  dinishev
// Cleanup - убрал закомментированный код, след которого теряется в веках...
//
// Revision 1.131  2012/03/07 07:43:37  dinishev
// Продолжаем бороться с AV при закрытии документа.
//
// Revision 1.130  2012/02/16 11:50:40  dinishev
// {Requestlink:338003907}
//
// Revision 1.129  2012/02/16 05:37:57  dinishev
// {Requestlink:338003941}
//
// Revision 1.128  2012/02/13 11:00:47  dinishev
// Bug fix: перестарался с проверкой.
//
// Revision 1.127  2012/02/13 10:56:59  dinishev
// Bug fix: перестарался с проверкой.
//
// Revision 1.126  2012/02/08 13:32:48  dinishev
// {Requestlink:335578573}. Bug fix: не вовремя срабатывал ActiveChanged.
//
// Revision 1.125  2012/02/08 06:43:19  dinishev
// Борьба с AV при закрытии формы.
//
// Revision 1.124  2012/01/27 14:58:49  dinishev
// {Requestlink:330704233}. Тест.
//
// Revision 1.123  2012/01/10 10:47:07  dinishev
// {Requestlink:321987098}
//
// Revision 1.122  2011/08/31 14:18:40  dinishev
// Bug fix: отъехала компиляция ветки.
//
// Revision 1.121  2011/08/31 13:54:05  dinishev
// [$280859299]
//
// Revision 1.120  2011/08/30 09:08:32  dinishev
// [$280010450]
//
// Revision 1.119  2011/08/19 11:58:10  dinishev
// Компилируем в подкаталог Арчи
//
// Revision 1.118  2011/08/15 11:02:36  dinishev
// Bug fix: не компилировалась ветка.
//
// Revision 1.117  2011/08/15 07:07:34  dinishev
// [$235876114]
//
// Revision 1.116  2011/06/30 11:59:52  dinishev
// [$271754614]
//
// Revision 1.115.2.2  2011/07/20 09:25:50  voba
// - k : 236721575
//
// Revision 1.115.2.1  2011/06/20 09:07:13  voba
// - k : 236721575
//
// Revision 1.115  2011/05/30 14:07:34  fireton
// - закрываем диалог при смене редактора
//
// Revision 1.114  2011/04/19 13:30:58  voba
// - k : 262636449
//
// Revision 1.113  2011/04/19 11:40:55  voba
// - k : 262636449
//
// Revision 1.112  2011/01/17 07:58:28  voba
// - k : 103448837
//
// Revision 1.111  2010/12/09 10:09:56  voba
// - k:77235690
//
// Revision 1.110.2.5  2011/06/10 13:31:25  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TdaFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.110.2.4  2011/06/07 14:03:40  voba
// - k : 236721575
//
// Revision 1.110.2.3  2011/04/08 07:53:36  voba
// - k : 236721575
//
// Revision 1.110.2.2  2011/02/16 13:26:15  voba
// - k : 236721575
//
// Revision 1.110.2.1  2011/01/26 08:19:19  voba
// - k : 236721575
//
// Revision 1.112  2011/01/17 07:58:28  voba
// - k : 103448837
//
// Revision 1.111  2010/12/09 10:09:56  voba
// - k:77235690
//
// Revision 1.110  2010/09/29 09:14:33  lulin
// {RequestLink:234360788}.
//
// Revision 1.109  2010/09/24 12:15:31  voba
// - k : 235046326
//
// Revision 1.108  2010/08/13 10:31:40  voba
// - k:229214076
//
// Revision 1.107  2010/06/18 16:21:14  lulin
// {RequestLink:182452717}.
// - перенумеровываем номер документа из внешнего во внутренний.
//
// Revision 1.106  2010/06/18 16:03:41  lulin
// {RequestLink:182452717}.
//
// Revision 1.105  2010/04/23 08:42:14  dinishev
// Подключаем TevdEmptyRowFilter, чтобы не лезло лишних Assert'ов
//
// Revision 1.104  2010/04/12 15:13:03  lulin
// {RequestLink:203129570}.
// - убираем ненужный тип подитеративной функции.
//
// Revision 1.103  2010/04/09 08:25:46  lulin
// - bug fix: забыл покоммитеть.
//
// Revision 1.102  2010/03/31 10:37:12  dinishev
// [$200085711]
//
// Revision 1.101  2010/02/26 17:33:57  lulin
// {RequestLink:190677208}.
// - финальный аккорд.
//
// Revision 1.100  2009/11/24 13:09:33  voba
// - bug fix
//
// Revision 1.99  2009/11/09 11:54:02  voba
// no message
//
// Revision 1.98  2009/10/30 14:01:44  dinishev
// [$168951859]
//
// Revision 1.97  2009/10/29 13:40:40  dinishev
// [$168951859]
//
// Revision 1.96  2009/09/25 10:48:04  voba
// no message
//
// Revision 1.95  2009/09/15 12:30:12  voba
// no message
//
// Revision 1.94  2009/09/11 08:45:23  voba
// - отказываемся от коротких названий
//
// Revision 1.93  2009/07/23 17:40:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.92  2009/07/23 08:15:01  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.91  2009/07/20 13:01:45  voba
// - Засунул renum в атрибуты
//
// Revision 1.90  2009/06/23 07:35:15  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.89  2009/06/02 13:47:36  lulin
// [$148574526].
//
// Revision 1.88  2009/06/01 16:07:41  lulin
// [$148574348].
//
// Revision 1.87  2009/05/29 17:30:35  lulin
// [$142610853].
//
// Revision 1.86  2009/04/16 14:27:16  lulin
// [$143396720]. Собираем Архивариус в HEAD.
//
// Revision 1.85  2009/04/15 18:49:46  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.84  2009/04/14 07:33:02  dinishev
// Фильтр таблиц не подключался при вставке из буфера - в результате имели кривые таблицы, если они побывали в новом редакторе
//
// Revision 1.83  2009/02/26 08:01:50  voba
// - убрал не неужную procedure lCorrectRefToDB
//
// Revision 1.82  2009/02/05 10:12:04  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.81  2009/02/03 13:48:53  dinishev
// CleanUp
//
// Revision 1.80  2009/01/28 14:24:59  dinishev
// CleanUp
//
// Revision 1.79  2009/01/23 08:47:04  dinishev
// CleanUp
//
// Revision 1.78  2009/01/14 12:13:29  voba
// no message
//
// Revision 1.77  2008/12/04 07:46:15  dinishev
// Фильтр для совместимости со старым редактором
//
// Revision 1.76  2008/11/14 08:13:41  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=121156019&focusedCommentId=122675450#comment-122675450
//
// Revision 1.75  2008/11/13 14:11:17  dinishev
// <K> : 122671895
//
// Revision 1.74  2008/10/17 14:40:19  voba
// no message
//
// Revision 1.73  2008/10/13 13:37:00  dinishev
// <K> : 84640081
//
// Revision 1.72  2008/10/09 13:45:27  dinishev
// Уменьшаем число ARCHI_OLD_EVEREST
//
// Revision 1.71  2008/10/09 11:28:21  dinishev
// Подготавливаемся к <K> : 89103144
//
// Revision 1.70  2008/06/25 14:46:20  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.69  2008/06/20 14:48:43  lulin
// - используем префиксы элементов.
//
// Revision 1.68  2008/06/18 14:46:08  voba
// - enh. TvtForm наследуем от Tl3Form
//
// Revision 1.67  2008/06/18 11:53:12  dinishev
// По возможности вычищаем ARCHI_OLD_EVEREST
//
// Revision 1.66  2008/06/10 14:38:32  lulin
// - храним ссылки на типы в полях таблицы тегов.
//
// Revision 1.65  2008/05/26 06:12:30  voba
// - enh.
//
// Revision 1.64  2008/05/23 06:40:15  voba
// no message
//
// Revision 1.63  2008/05/22 13:04:35  voba
// - защита от открывания дока с ID = 0
//
// Revision 1.62  2008/05/20 10:52:00  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.61  2008/05/07 16:14:29  voba
// no message
//
// Revision 1.60  2008/04/22 12:48:58  voba
// no message
//
// Revision 1.59  2008/04/16 12:55:55  lulin
// - синхронизируем список параметров.
//
// Revision 1.58  2008/04/15 08:29:24  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.57  2008/04/08 08:11:12  voba
// - bug fix: стили не ставились
//
// Revision 1.56  2007/12/24 15:25:10  lulin
// - удалены ненужные файлы.
//
// Revision 1.55  2007/12/18 07:29:49  dinishev
// Bug fix: AV при проставлении ссылок
//
// Revision 1.54  2007/12/03 10:06:30  dinishev
// Используем редактор из ветки
//
// Revision 1.53  2007/11/22 14:45:59  fireton
// - приводим информацию о всех пользователей, захвативших документ
//
// Revision 1.52  2007/10/24 10:19:32  voba
// no message
//
// Revision 1.51  2007/03/01 15:09:26  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.50  2006/12/13 15:51:24  voba
// no message
//
// Revision 1.49  2006/11/16 10:47:01  fireton
// - подготовка к большому UserID
//
// Revision 1.48  2006/10/05 14:54:52  fireton
// - история переходов по ссылкам внутри одного документа
//
// Revision 1.47  2006/03/29 10:33:40  voba
// no message
//
// Revision 1.46.4.3  2006/03/29 10:27:13  voba
// no message
//
// Revision 1.46.4.2  2006/03/24 09:27:33  voba
// no message
//
// Revision 1.46.4.1  2006/03/23 15:04:20  voba
// no message
//
// Revision 1.46  2006/01/23 12:51:00  voba
// no message
//
// Revision 1.45  2005/11/28 13:47:26  voba
// no message
//
// Revision 1.44  2005/11/25 13:32:39  voba
// no message
//
// Revision 1.43  2005/11/17 12:49:20  fireton
// - change: переходы по истории с более точным позиционированием
//
// Revision 1.42.2.1  2006/03/23 11:27:00  voba
// no message
//
// Revision 1.42  2005/10/17 11:24:28  voba
// no message
//
// Revision 1.41  2005/10/13 11:07:00  voba
// no message
//
// Revision 1.40  2005/10/06 12:09:18  voba
// no message
//
// Revision 1.39  2005/08/11 10:41:03  fireton
// - change: нотификации диалога поиска
//
// Revision 1.38  2005/08/09 15:20:10  voba
// no message
//
// Revision 1.37  2005/07/27 17:13:52  voba
// - improve вставили пачку операций (InevOp) в процедуру установки ссылок
//
// Revision 1.36  2005/07/14 09:29:03  voba
// no message
//
// Revision 1.35  2005/05/17 12:25:25  voba
// no message
//
// Revision 1.34  2005/03/24 12:29:53  voba
// no message
//
// Revision 1.33  2005/02/18 14:38:31  voba
// - вынес DOCID и Family в новый класс DocInfo
//
// Revision 1.32  2005/02/18 13:54:04  lulin
// - навел порядок с формой поиска.
//
// Revision 1.31  2005/02/15 11:50:19  lulin
// - new behavior: теперь все итераторы могут перебирать составные части документов (main, anno).
//
// Revision 1.30  2005/02/14 16:35:50  lulin
// - в Архивариусе сделана возможность указать с каким потоком документа работать.
//
// Revision 1.29  2005/01/14 15:21:50  voba
// no message
//
// Revision 1.28  2004/12/11 12:43:19  voba
// no message
//
// Revision 1.27  2004/11/30 09:39:43  fireton
// - рефакторинг диалога поиска
//
// Revision 1.26  2004/11/25 09:27:59  lulin
// - прописаны пути.
// - поправлены ошибки - не компилировалось.
//
// Revision 1.25  2004/11/18 16:23:53  voba
// no message
//
// Revision 1.24  2004/11/10 08:39:42  voba
// no message
//
// Revision 1.23  2004/10/22 14:44:12  voba
// no message
//
// Revision 1.22  2004/09/21 11:27:26  lulin
// - bug fix: не компилировалось.
//
// Revision 1.21  2004/09/14 14:22:29  voba
// no message
//
// Revision 1.20  2004/09/09 13:01:13  voba
// no message
//
// Revision 1.19  2004/09/07 09:21:58  voba
// no message
//
// Revision 1.18  2004/09/06 11:33:15  voba
// no message
//
// Revision 1.17  2004/08/30 12:16:14  step
// TAddDocAttributeFilter получил новое свойство RecalcHyperLinks
//
// Revision 1.16  2004/08/23 09:08:00  voba
// no message
//
// Revision 1.15  2004/08/03 08:12:26  voba
// no message
//
// Revision 1.14  2004/08/02 13:12:21  voba
// no message
//
// Revision 1.13  2004/07/28 12:54:50  voba
// no message
//
// Revision 1.12  2004/06/03 12:18:29  fireton
// - bug fix: Диалог поиска закрывается при закрытии редактора и переключении на другой таб
//
// Revision 1.11  2004/05/28 15:40:43  voba
// no message
//
// Revision 1.10  2004/05/13 07:45:49  voba
// no message
//
// Revision 1.9  2004/05/12 13:23:18  voba
// no message
//

{$Include l3XE.inc}
{$INCLUDE ProjectDefine.inc}

interface

uses
 SysUtils, 
 Windows, 
 Messages,
 Classes, 

 Forms, 
 Dialogs, 
 Controls,
 
 l3Base,
 l3Const,
 l3Date, 
 l3Tree, 
 l3Types,
 
 k2Reader, 
 k2TagGen,

 m3DBInterfaces,

 evIntf,
 evTypes,
 evEditor,
 evFacadeSelection,

 evCommonTypes,
 evCustomTextSource,
 evTextSource,                           
 evEditorWindow,
 evCustomEditor,
 evEditorInterfaces,
 evInternalInterfaces,

 DocIntf,       
 DragData,
 TypeShop,


 vConst,
 vtForm,
 vtDialogs,

 afwNavigation,

{$IFDEF InsiderTest}
 arCommonTypes,
 PreviewFormUnit,
{$ENDIF InsiderTest}

 nevTools,
 nevGUIInterfaces,
 nevNavigation,

 daTypes,

 DT_Types,
 DT_Const,
 dt_AttrSchema,
 DT_Hyper,

 D_TxSrch_Types,

 ObjExWin;

 type
  TRefAddr  = record
   Family : TdaFamilyID;
   DocID  : TdaDocID;
   Block  : TnevLocation;
  end;

  EDocLoadBreak = class(Exception);

  TTreeSelector = (tsAll, tsAttr, tsSubAttr);
  THyperTextActionSet = (haSub, haReference);

  TGetRefAddrFunc = function(var aRefAddr : TdaGlobalCoordinateRec) : Boolean;

  TCustomEditorWindow = class(TvtForm
  {$IFDEF InsiderTest}
  , IevClearPreviewLink
  {$ENDIF InsiderTest}
  )
    private
     fDocument         : TarDocument;
     fStopAutoSaveCnt  : Integer;
     fLastSaveDT       : TStDateTimeRec;
     fReadOnly         : Boolean;
     fNewDocLog        : Boolean;
    {DragData Serv}
     DragDropInProcess : Boolean;
    {..DragData}

     fDocName          : AnsiString;
     //fHIInsertCnt      : Longint;
     fNeedSilentClose  : Boolean;

     procedure WMIdleMsg(var Message: TMessage); message wm_IdleMsg;
     procedure SetReadOnly(Value : Boolean);
     procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;
  {$IFDEF InsiderTest}
   public
  {$ENDIF InsiderTest}
     procedure WMDropAccepted(var Message: TMessage); message wm_DropAccepted;

    protected
    {DragData Serv}
     DDCurDocument     : TarCustomDocument;
     DDBlock           : TnevLocation;
    {DragData Client}
  {$IFDEF InsiderTest}
   public
  {$ENDIF InsiderTest}
     DDHLink           : TdaGlobalCoordinateRec;
  {$IFDEF InsiderTest}
   protected
    f_Preview      : TPreviewForm;
     {-}
  {$ENDIF InsiderTest}

     fLoadStopLog      : Boolean; //проверять при загрузке, для предотвращения дозагрузки формы, которую грохнули
     fDocJumpData      : TDocJumpRec;

     fGroupMode       : Boolean;
     fModalMode       : Boolean;

     fGetOnlyText     : Boolean; // предотвращает включение фильтра подмешивания атрибутов (см DocumentSourceGetWriter)
                                 // в тех местах где это не нужно
                                 // например TDocEditorWindow.acToolsSetSectionsExecute

     fIconID      : Integer;

     function GetTextDocumentView: InevView; virtual;
     procedure SetDocFam(Value : TdaFamilyID);
     procedure SetDocID(Value : TDocID);
     function  GetDocFam : TdaFamilyID;
     function  GetDocID : TDocID;
     function  GetDocument : TarDocument;
     procedure SetDocument(aValue : TarDocument);
     procedure SetDocJumpData(aDocJumpData : TDocJumpRec);

     function  GetIconID : Integer;

     procedure ClearDocJumpData;

     procedure SetCaption; virtual;
     procedure AddToExplorer(aExpPlace : TExplorerObjType);
     procedure SetDocName(const aValue : AnsiString);        virtual;

     function  GetCurEditor: TevCustomEditor;            virtual;
     function  GetCurDocument: TarCustomDocument;        virtual;
     procedure TuneDocument(aDocument : TarDocument);    virtual;
     procedure SaveDocument(aFullSave : Boolean = True); virtual;

     //procedure TuneTextSource(const aTextSource: TevCustomTextSource); virtual;
     procedure DocumentTextSourceTune(aSender: TObject); virtual;

     procedure SetReadOnlyMask(aLockMask : Longint);  virtual;

     function  IsDocParamChange(aFullCheck : Boolean = True): Boolean; virtual;

     procedure Activate; override;

     procedure evntFinishInsertFromFile(Sender : TObject); virtual;
     function  evntDocTextSave(aPart: Tm3DocPartSelector; aFullSave: Boolean) : boolean; virtual;

     procedure GetAttrTreeListOnSub(aSubID   : TSubID;
                                    aDictSet : TdtAttributeSet;
                                    aTreeSel : TTreeSelector = tsAll); virtual;

     procedure RefreshAttr(aSubID   : TSubID;
                           aDictSet : TdtAttributeSet;
                           aTreeSel : TTreeSelector = tsAll); virtual;

    {AutoSave}
     procedure InitAutoSave;
     procedure StopAutoSave;
     procedure StartAutoSave(aResetCounter : Boolean = True);
     function  MayAutoSave: Boolean; virtual;

    {HyperLinks}
     procedure InitSetReference;
     procedure DragStopNotify(Sender: TObject);
     procedure GoByRefClick(aHyperlink : IevHyperlink = nil);
     function  DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;

     procedure SetReferenceListF(const aBlock    : TnevLocation;
                                aGetRefAddrFunc : TGetRefAddrFunc);
     procedure SetReferencePrim(const aBlock : TnevLocation;
                               aRefAddr     : TdaGlobalCoordinateRec);
     //move to public function RemoveReference(aLinkAddr : PDestHLinkRec = nil; const aHLink : IevHyperlink = nil): Boolean;

     function  GetReferenceHintString(const aHyperLink : IevHyperlink) : AnsiString;                   overload;
     function  GetReferenceHintString(const aHotSpot : IevHotSpot; const aHint : AnsiString) : AnsiString; overload;

     function  ShowDoc(aDocID       : Longint;
                     aDocJumpData : TDocJumpRec): TCustomEditorWindow; overload;
     function  ShowDoc(aDocID : Longint;
                     aGOSub : TSubID): TCustomEditorWindow; overload;

  {$IFDEF InsiderTest}
   public
    procedure MakePreview;
      {-}
    procedure ClearPreview;
      {-}
  {$ENDIF InsiderTest}
     procedure SetExpiredStyle(aStyleID : Integer);
  {$IFDEF InsiderTest}
   protected
  {$ENDIF InsiderTest}
     procedure AcquireCurDocParams; virtual;
     procedure EditorStyleChange(const Style: IedStyle);

     function  CloseQuery: Boolean; override;
     function  TextSourcesCloseQuery: Boolean; virtual;
     //procedure DocumentMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource); virtual;
     procedure DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint); virtual;
     procedure ReturnFocusToForm; virtual;
     function  GetAllowReplaceTypes: TtsSrchTypeSet; virtual;

    public
     function  IsNeedSaveDocument: Boolean; virtual;
     procedure Cleanup; override;

     constructor Create(AOwner: TComponent; aDocument : TarDocument = nil); reintroduce;

     procedure Lock;
     procedure UnLock;
     procedure ReLock;


     procedure LoadDoc; virtual;
     function  Save: Boolean; override;
     procedure SilentClose;

     function  IsMyDocID(aDocID : TDocID) : Boolean; virtual;
     function  NormDocID(aDocID : TDocID) : TDocID; virtual;

     procedure GoToSub(aGoToSubID : Integer = 0; aDocID : TDocID = 0); virtual;
     procedure AfterHyperTextAction(haType : THyperTextActionSet; aSubFlagRebuild : Boolean = False); virtual;

     procedure Find;
     procedure Replace;
     procedure Find_or_Replace;
     procedure FindNext;

     procedure PrintAll; virtual;

     procedure StyleComboBoxChange(Sender: TObject);
     procedure StyleComboBoxDropDown(Sender: TObject);

     procedure SetShowSelect;  virtual;

     function  RemoveReference(aLinkAddr    : PDestHLinkRec = nil;
                              const aHLink : IevHyperlink = nil): Boolean;
     procedure ActiveChanged; override;

     procedure SaveState2Log; // {Requestlink:508172837}

     function  IsDocLoaded : Boolean;
     procedure JumpTo; virtual;

     property DocFamily   : TdaFamilyID read GetDocFam     write SetDocFam;
     property DocID       : TDocID    read GetDocID      write SetDocID;
     property Document    : TarDocument read GetDocument  write SetDocument;
     property DocJumpData : TDocJumpRec read fDocJumpData write SetDocJumpData;
     property IsNewDoc    : Boolean read fNewDocLog write fNewDocLog;
     property ReadOnly    : Boolean   read FReadOnly write SetReadOnly;
     property CurEditor   : TevCustomEditor read GetCurEditor;
     property DocName     : AnsiString read FDocName write SetDocName;
     property CurDocument : TarCustomDocument read GetCurDocument;
     property IconID      : Integer read GetIconID write fIconID;
  end;

function TrunkDocName(const aValue : AnsiString) : AnsiString;

implementation

uses
 Main,
 StrShop,
 IniShop,
 ResShop,
 Com_Cnst,
 DictsSup,

 daInterfaces,
 daDataProvider,
 daSchemeConsts,

 DT_Record,
 DT_Err,
 DT_CFltr,
 dt_LinkServ,
 Dt_Doc,

 l3Variant,
 l3Bits,
 l3Chars,
 l3Units,
 l3DatLst,
 l3String,
 l3MinMax,
 l3Languages,
 l3InterfacesMisc,
 l3Interfaces,

 k2Base,
 k2Tags,
 k2Except,
 k2OpMisc,
 k2Interfaces,

 evdTypes,

 evCommonUtils,
 evCommonRes,

 {$IFDEF InsiderTest}
 arArchiTestsAdapter,
 {$ENDIF InsiderTest}

 evOp,
 evSubPn,
 evdStyles,
 evTextFormatter,
 evTextInTableCorrector,
 evEditorInterfacesMisc,
 evSubPanelSub,

 ObjList,

 D_CRef,
 D_TxSrch,
 D_Spell,

 evdF1HyperlinkCorrector,
 evStrictContentsElementEliminator,

 arHyperLinkProcessor,
 arTemplateProcessor,
 
 DocAttrToolsIntf
 , Dt_ReNum;

constructor TCustomEditorWindow.Create(AOwner: TComponent; aDocument : TarDocument = nil);
begin
 inherited Create(AOwner);
 if aDocument <> nil then
  Document := aDocument;
 fIconID := -1;
end;

procedure TCustomEditorWindow.Cleanup;
begin
 TTextSearchDlg.ClientFormClosed(Self);
 Unlock;
 TTextSearchDlg.HideFindContext;
 ClearDocJumpData;
 if Assigned(fDocument) then
  fDocument.ClearWindowLink;
 l3Free(fDocument);
 inherited;
end;

procedure TCustomEditorWindow.Activate;
begin
 inherited;
 TTextSearchDlg.SwitchActiveEditor(CurEditor);
 TSpellCheckDlg.CheckEditor(CurEditor);
end;

function  TCustomEditorWindow.GetDocFam : TdaFamilyID;
begin
 Result := Document.DocFamily;
end;

function  TCustomEditorWindow.GetDocID  : TDocID;
begin
 Result := Document.DocID;
end;

function  TCustomEditorWindow.GetIconID : Integer;
begin
 if fIconID = -1 then
  with Document do
  fIconID := GetDocumentImageIndex(DocClass, UserType, IsActive);

 Result := fIconID;
end;

function  TCustomEditorWindow.IsMyDocID(aDocID : TDocID) : Boolean;
begin
 Result := aDocID = DocID;
end;

function TCustomEditorWindow.NormDocID(aDocID : TDocID) : TDocID;
begin
 if aDocID = 0 then
  Result := Document.DocID
 else
  Result := aDocID;
end;

procedure TCustomEditorWindow.TuneDocument(aDocument : TarDocument);
begin
 aDocument.OnAfterDataInsert := evntFinishInsertFromFile;
 aDocument.OnDocTextSave := evntDocTextSave;
end;

procedure TCustomEditorWindow.SaveDocument(aFullSave : Boolean = True);
begin
end;

procedure TCustomEditorWindow.SetReadOnlyMask(aLockMask : Longint);
begin
end;

procedure TCustomEditorWindow.SetDocument(aValue : TarDocument);
begin
 l3Set(fDocument,aValue);
 TuneDocument(fDocument);
end;

procedure TCustomEditorWindow.DocumentTextSourceTune(aSender: TObject);
begin
end;

{procedure TCustomEditorWindow.DocumentMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 theTextSource := Document.TextSource;
 TuneTextSource(theTextSource);
end;
}
function TCustomEditorWindow.GetDocument : TarDocument;
var
 lDocument : TarDocument;
begin
 if fDocument = nil then
 begin
  lDocument := TarDocument.Create;
  try
   Document := lDocument;
  finally
   l3Free(lDocument);
  end;
 end;
 Result := fDocument;
end;

procedure TCustomEditorWindow.SetDocFam(Value : TdaFamilyID);
begin
 Document.DocFamily := Value;
end;

procedure TCustomEditorWindow.SetDocID(Value : TDocID);
begin
 Document.DocID := Value;
end;

function  TCustomEditorWindow.IsDocLoaded : Boolean;
begin
 Result := (fDocument <> nil) and (fDocument.HasTextSource) and (fDocument.TextSource.HasDocument);
end;

procedure TCustomEditorWindow.JumpTo;
begin
 //
end;

procedure TCustomEditorWindow.ClearDocJumpData;
begin
 case fDocJumpData.DocJumpType of
  djNone       : ;
  djFoundWord  : ;
  djSubList    : l3Free(fDocJumpData.FindSubList);
  djReferences : l3Free(fDocJumpData.DocAddrList.rSubIDList);
 end;
 fDocJumpData.DocJumpType := djNone;
end;

procedure TCustomEditorWindow.SetDocJumpData(aDocJumpData : TDocJumpRec);
begin
 ClearDocJumpData;

 fDocJumpData := aDocJumpData;

 if IsDocLoaded then
  JumpTo;

 if MainForm.ActiveMDIChild = Self then
  SetSpeedButton(Enabled);
end;

procedure TCustomEditorWindow.Lock;
var
 lDenyMask : Longint;
 lMsgStr   : AnsiString;
 lStation  : TStationNameArray;
 lUserID   : TdaUserIDArray;
 I         : Integer;

 function lp_DialogSaysYes: Boolean;
 begin
  Result := vtMessageDlg(l3CStr(sidAssMaskDeny + ^M +
                 GetAssMaskStr(lDenyMask) + ^M +
                 '(' + lMsgStr + ')'^M +
                 'Прервать загрузку?'), mtWarning, [mbYes, mbNo], 0, mbNo, mbNo) = mrYes;
 end;

 function lp_NeedSkip: Boolean;
 begin
 {$IFDEF InsiderTest}
   case TarTestConfig.Instance.SkipLockDialog of
    ar_AsUsual: Result := lp_DialogSaysYes;
    ar_OpenDocument: Result := False;
    ar_NotOpen: Result := True;
   end;
 {$ELSE}
  Result := lp_DialogSaysYes;
{$ENDIF InsiderTest}
 end;

begin
 if fReadOnly then
  Exit;

 if Document.IsLock then Exit;
 //If DocID = 0 then raise Exception.Create(sidDocIdNonDef);

 Document.Lock;
 try
  lDenyMask := Document.MaxMask and not Document.LockMask;
  if lDenyMask <> 0 then
  begin
   Document.WhoLockDoc(lStation, lUserID);
   //lMsgStr := 'Станция : '+ lStation;
   lMsgStr := '';
   for I := Low(lUserID) to High(lUserID) do
   begin
    if lMsgStr <> '' then
     lMsgStr := lMsgStr + ', ';
    lMsgStr := lMsgStr + GlobalDataProvider.UserManager.GetUserName(lUserID[I]);
   end;
   if High(lUserID) > 0 then
    lMsgStr := 'Пользователи : ' + lMsgStr
   else
    lMsgStr := 'Пользователь : ' + lMsgStr;

   if lp_NeedSkip then
    raise EDocLoadBreak.Create('');
  end;

  SetSpeedButton(MainForm.ActiveMDIChild = Self);
 except
  Document.Unlock;
  Raise;
 end;
end;

procedure TCustomEditorWindow.UnLock;
begin
 Document.Unlock;
end;

procedure TCustomEditorWindow.ReLock;
begin
 Document.Relock;
end;

procedure TCustomEditorWindow.LoadDoc;
begin
end;

procedure TCustomEditorWindow.InitAutoSave;
begin
 fLastSaveDT := CurrentDateTime;
end;

procedure TCustomEditorWindow.StopAutoSave;
begin
 Inc(fStopAutoSaveCnt);
end;

function TCustomEditorWindow.MayAutoSave: Boolean;
begin
 Result := IsDocLoaded and (fStopAutoSaveCnt = 0) and IniRec.AutoSave and not fReadOnly;
end;

procedure TCustomEditorWindow.StartAutoSave(aResetCounter : Boolean = true);
begin
 if fStopAutoSaveCnt > 0 then 
  Dec(fStopAutoSaveCnt);
 if aResetCounter then 
  fLastSaveDT := CurrentDateTime;
end;

procedure TCustomEditorWindow.WMIdleMsg(var Message: TMessage);
var
 lDT : TStDateTimeRec;
 Days : Longint;
 Secs : Longint;
begin
 if not MayAutoSave then Exit;
 lDT := CurrentDateTime;
 DateTimeDiff(CurrentDateTime, fLastSaveDT, Days, Secs);
 if (Days > 0) or (Secs >= Longint(IniRec.AutoSaveInterval) * 60) then
 begin
  fLastSaveDT := lDT;
  try
   SaveDocument(false);
  except
   on ERequiredFieldsEmpty do;
   on E : Exception do Application.ShowException(E);
  end;
 end;
end;

procedure TCustomEditorWindow.SetReadOnly(Value : Boolean);
begin
 FReadOnly := Value;
 if Value then SetReadOnlyMask(0);
end;

function TCustomEditorWindow.GetCurEditor: TevCustomEditor;
begin
 Result := nil;
end;

function TCustomEditorWindow.GetCurDocument: TarCustomDocument;
begin
 Result := Document;
end;

procedure TCustomEditorWindow.InitSetReference;
var
 l_Hyperlink : IevHyperlink;
begin
 try
  TDragDataSupport.Instance.CheckInProgress;
  with TDragDataSupport.Instance do
  begin
   DragDataType := Ord(ddHyperLink);
   DragData     := nil;
   DDCurDocument := CurDocument;

   DragDropInProcess := True;
   try
    evSaveBlock(CurEditor, DDBlock);
    try
     if l3IOk(DDBlock.QueryInterface(IevHyperlink, l_Hyperlink)) then
      l_Hyperlink := nil
     else
      raise EarSetHyperLinkError.Create(sidCannotAddHyperLink);
     OnDragStop := DragStopNotify;
     with CurEditor.Range do
      if ContainsOneLeaf then
       MainForm.OutToStatusBar(Format(sidMakeRefProcess, [AsString]));
     RunDragData(Self);
    except
     evFreeBlock(DDBlock);
     raise;
    end;
   except
    DragDropInProcess := False;
   end;
  end;
 except
  on E : EDragInProcess do 
   Application.ShowException(E);
 end;
end;

procedure TCustomEditorWindow.DragStopNotify(Sender: TObject);
begin
 MainForm.OutToStatusBar('');
 evFreeBlock(DDBlock);
 TDragDataSupport.Instance.OnDragStop := nil;
 DragDropInProcess    := False;
 DDCurDocument        := nil;
end;

procedure TCustomEditorWindow.SilentClose;
begin
 fNeedSilentClose := True;
 Close;
end;

function TCustomEditorWindow.CloseQuery: Boolean;

 function lDragDropInProcess: Boolean;
 begin
  Result := false;
  if TDragDataSupport.Instance.DragState = dsActive then
  begin
   if TDragDataSupport.Instance.DragDataType = Ord(ddHyperLink) then
    Result := DDCurDocument = CurDocument
   {else
    if TDragDataSupport.Instance.DragDataType <> Ord(ddBackHyperLink) then
     Result := False};
  end;
 end;

var
 lActCtrl : TWinControl;
 lAddToExplorerLog : Boolean;
 lDlgResult : Integer;
begin
 if lDragDropInProcess then
 begin
  Result := False;
  vtMessageDlg(l3CStr(@sidHLinkInProcess),  mtError);
  Exit;
 end;

 {$IFDEF InsiderTest}
 if f_Preview <> nil then
 begin
  f_Preview.Close;
  f_Preview := nil;
 end; // if f_Preview <> nil then
 {$ENDIF InsiderTest}  

 if ActiveControl <> nil then
 begin
  lActCtrl := ActiveControl;
  ActiveControl := Nil;
  lActCtrl.Perform(CM_Exit, 0, 0);
  Result := ActiveControl = Nil;
  if not Result then Exit;
 end;

 Result := inherited CloseQuery;

 if not Result then Exit;

 lAddToExplorerLog := True;

 if not TextSourcesCloseQuery then
 begin
  fLoadStopLog := True;
  Result := False;
  Exit;
 end;

 StopAutoSave;
 try
  if IsNeedSaveDocument then
  begin
   if fNeedSilentClose or MainForm.SilentClose then
   begin
    if IsNewDoc then
     lDlgResult := mrNo
    else
     lDlgResult := mrYes
   end
   else
    if IniRec.AutoSave and not IsNewDoc then
     lDlgResult := mrYes
    else
     lDlgResult := vtMessageDlg(l3Fmt(str_sidSaveAsk.AsCStr, [DocName]), mtWarning, mbYesNoCancel);

   case lDlgResult of
    mrYes :
     begin
      Result := False;
      try
       SaveDocument(True);
       Result := True;
      except
       on E : ERequiredFieldsEmpty do
        MainForm.LayMsg(E.Message, mtError, [mbOK], 0 {HelpCtx});
      end;
     end;

    mrNo :
     if IsNewDoc then
     begin
      Screen.Cursor := crHourGlass;
      try
       {If IsNewDoc then}
       Document.DeletePersistent;
       lAddToExplorerLog := False;
      finally
       Screen.Cursor := crDefault;
      end;
     end;

    mrCancel :
     Result := False;
   end; //case lDlgResult of
  end;
 finally
  StartAutoSave;
 end;

 if Result then
 begin
  Unlock;
  ModalResult := mrOk;
  if lAddToExplorerLog then AddToExplorer(eotMRUDocument);
  MainForm.OEWin.DelFromExplorer(eotDocument, Longint(Self));
  Document.Close;
 end;
end;

function TCustomEditorWindow.IsNeedSaveDocument: Boolean;
begin
 Result := not ReadOnly;
end;

function TCustomEditorWindow.IsDocParamChange(aFullCheck : Boolean = True): Boolean;
begin
 Result := Document.IsModified;
end;

function TCustomEditorWindow.TextSourcesCloseQuery: boolean;
begin
 Result := True;
end;

procedure TCustomEditorWindow.AddToExplorer(aExpPlace : TExplorerObjType);
var
 lParam : Integer;
begin
 case aExpPlace of
  eotDocument :
   lParam := Longint(Self);
  eotMRUDocument :
   lParam := DocID;
 end;

 try
  if Length(FDocName) = 0 then
   MainForm.OEWin.AddToExplorer(aExpPlace, Format(sidDocumentWithNumber, [Document.UserDocID]), lParam, IconID)
  else
   MainForm.OEWin.AddToExplorer(aExpPlace, l3PCharLen(fDocName, GlobalDataProvider.BaseLanguage[DocFamily].AnsiCodePage), lParam, IconID);
 except
 end;
end;

procedure TCustomEditorWindow.SetDocName(const aValue : AnsiString);
begin
 if fGroupMode then Exit;
 fDocName := aValue;
 SetCaption;
 AddToExplorer(eotDocument);
end;

procedure TCustomEditorWindow.SetCaption;
var
 lStr : AnsiString;
begin
 if Readonly then
  Caption := '"' + fDocName + '"'
 else
 begin
  lStr := 'Редактор';
  if IniRec.ShowIDinCaption and (DocID > 0) and (Document.UserDocID > 0) then
   lStr := lStr + Format(' [%d]', [Document.UserDocID]);
  if Length(fDocName) > 0 then lStr := lStr + ' ' + fDocName;
  Caption := lStr;
 end;
end;

procedure TCustomEditorWindow.GoToSub(aGoToSubID : Integer = 0; aDocID : TDocID = 0);
begin
end;

procedure TCustomEditorWindow.AfterHyperTextAction(haType : THyperTextActionSet; aSubFlagRebuild : boolean = false);
begin
 //abort;
end;

procedure TCustomEditorWindow.evntFinishInsertFromFile(Sender : TObject);
begin
 AfterHyperTextAction(haSub, True);
end;

function  TCustomEditorWindow.evntDocTextSave(aPart: Tm3DocPartSelector; aFullSave: Boolean) : boolean;
begin
 Result := True;
end;

procedure TCustomEditorWindow.GetAttrTreeListOnSub(aSubID : TSubID; aDictSet : TdtAttributeSet;
                                                   aTreeSel : TTreeSelector);
begin
//
end;

procedure TCustomEditorWindow.RefreshAttr(aSubID : TSubID; aDictSet : TdtAttributeSet;
                                       aTreeSel : TTreeSelector = tsAll);
begin
//
end;

//procedure TCustomEditorWindow.evntInsertedSubCount(aCount : LongInt);
//begin
 //fHIInsertCnt := aCount;
//end;

procedure TCustomEditorWindow.DocumentSourceAllowGotoSub(Sender: TObject; const aPoint : IevDocumentPoint);
begin
end;

function TCustomEditorWindow.GetAllowReplaceTypes: TtsSrchTypeSet;
begin
 Result := [];
 if l3TestMask(Document.LockMask, acgText) then
  Result := Result + [srtText, srtStyle];

 if l3TestMask(Document.LockMask, acgSub) then
  Result := Result + [srtSub];

 if l3TestMask(Document.LockMask, acgHyperLink) then
  Result := Result + [srtHLink];
end;

procedure TCustomEditorWindow.Find_or_Replace;
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 TTextSearchDlg.Execute(cSearchMode_NoChange[lAllowReplaceTypes <> []], CurEditor, lAllowReplaceTypes);
end;

procedure TCustomEditorWindow.Find;
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 TTextSearchDlg.Execute(cSearchMode_Search[lAllowReplaceTypes <> []], CurEditor, lAllowReplaceTypes);
end;

procedure TCustomEditorWindow.Replace;
var
 lAllowReplaceTypes: TtsSrchTypeSet;
begin
 lAllowReplaceTypes := GetAllowReplaceTypes;
 if lAllowReplaceTypes <> [] then
  TTextSearchDlg.Execute(sdiReplace, CurEditor, lAllowReplaceTypes);
end;

procedure TCustomEditorWindow.FindNext;
begin
 TTextSearchDlg.FindNext(CurEditor);
end;

procedure TCustomEditorWindow.PrintAll;
begin
//
end;

function TCustomEditorWindow.Save: Boolean;
begin
 Result := False;
 try
  SaveDocument;
  Result := True;
 except
  on E : ERequiredFieldsEmpty do
   MainForm.LayMsg(E.Message, mtError, [mbOK], 0 {HelpCtx});
 end;
end;

procedure TCustomEditorWindow.GoByRefClick(aHyperlink : IevHyperlink = nil);
var
 l_HyperlinkMoniker : IevHyperlinkMoniker;
begin
 if aHyperlink = nil then
  aHyperlink := CurEditor.Range.Hyperlink;

 if l3BQueryInterface(aHyperlink, IevHyperlinkMoniker, l_HyperlinkMoniker) then
 try
  DocEditorJumpTo(l_HyperlinkMoniker);
 finally
  l_HyperlinkMoniker := nil;
 end;{try..finally}
end;

function TCustomEditorWindow.DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;
var
 l_DestLink         : TDestHLinkRec;
 l_CtrlKeyDown       : Boolean;
 l_HyperlinkMoniker : IevHyperlinkMoniker;
 l_Hyperlink        : IevHyperlink;
 l_AddresList       : IevAddressList;
 l_CurEditor        : TevCustomEditor;
 I                  : Integer;


function GetLinkAddrName(aLinkDoc : TDocID; aLinkSub : TSubID) : String;
var
 lRecord       : TdtRecord;
 lNameSubPChar : PAnsiChar;
 lNameSub      : AnsiString;
 lDocID        : TDocID;
 lHLinkRec     : TDestHLinkRec;
begin
 lRecord := DocumentServer(DocFamily).FileTbl.GetRecordByUniq(aLinkDoc);
 if lRecord.WasFound then

  begin
   Result := TrunkDocName(lRecord.GetStrField(fFName_Fld));
   if aLinkSub <> 0 then
   begin
    lHLinkRec := DestHLinkRec(aLinkDoc, aLinkSub);
    lRecord := LinkServer(DocFamily).Attribute[atSub].Table.GetRecordByUniq(lHLinkRec);
    if lRecord.WasFound then
     lNameSub := lRecord.GetStrField(subName_fld);
    if Length(lNameSub) > 0 then
     Result := Result + Format(#13'(%s)', [lNameSub])
    else
     lNameSub := Format('Метка # %d', [aLinkSub]);
   end;
  end
  else //if DocumentServer.FileTbl.CheckDoc ...
  begin
   lDocID := DocumentServer.FileTbl.GetDocIdOnRelated(aLinkDoc);
   if lDocID > 0 then
    Result := TrunkDocName(DocumentServer.FileTbl.GetRecordByUniq(lDocID).GetStrField(fFName_Fld))  + #13'(справка)'
   else
    Result := Format('Документ отсутствует (внутренний DocID = %d)', [aLinkDoc]);
  end;
 end;

begin
 Result := False;
 if l3IOk(aMoniker.QueryInterface(IevHyperlinkMoniker, l_HyperlinkMoniker)) then
  try
  Result := True;
  l_CtrlKeyDown := GetKeyState(VK_Control) and $8000 <> 0;

  if l3IOk(l_HyperlinkMoniker.QueryInterface(IevHyperlink, l_Hyperlink)) then
   try
    if arOpenHyperLink(l_Hyperlink) then Exit;
    if l3IOk(l_Hyperlink.QueryInterface(IevAddressList, l_AddresList)) then
     try
      if l_AddresList.Count <= 0 then
      begin
       vtMessageDlg(l3CStr(@sidEmptyReference), mtWarning);
       Exit;
      end;
      if (l_AddresList.Count = 1) and Not l_CtrlKeyDown then
       with l_AddresList[0]{$IfDef XE4}.rTafwAddress{$EndIf} do
        ShowDoc(DocID, SubID)
      else
      begin
       for I := 0 to Pred(l_AddresList.Count) do
        with l_AddresList[I]{$IfDef XE4}.rTafwAddress{$EndIf} do
         if l_AddresList.Name[I].SLen = 0 then
          l_AddresList.Name[I] := l3PCharLen(GetLinkAddrName(NormDocID(DocID), SubID));

       l_CurEditor := CurEditor;
       with TChoiceRefDlg.Create(self) do
        try
         if Execute(DocFamily, l_Hyperlink, l_DestLink) then
          ShowDoc(l_DestLink.Doc, l_DestLink.Sub)
         else
         begin
          //!!if Lister.Items.Count = 0 then l_CurEditor.DeleteHyperLink;
          l_CurEditor.SetFocus;
         end;
        finally
         Free;
        end;
      end;
     finally
      l_AddresList := nil;
     end;
   finally
   l_Hyperlink := nil;
   end;
  finally
   l_HyperlinkMoniker := nil;
  end;{try..finally}
end;

function TCustomEditorWindow.ShowDoc(aDocID : Longint; aDocJumpData : TDocJumpRec): TCustomEditorWindow;
var
 l_AltKeyDown: Boolean;
 l_Rec: TarTemplateDataRec;
 l_TS: TarTemplateStorage;
begin
 if (aDocID = 0) or IsMyDocID(aDocID) and (aDocJumpData.DocJumpType = djSub) then
 begin
  with aDocJumpData.DocPointAddr do
  begin
   MainForm.PrepareStack;
   MainForm.AddDocumentToStack(Self);
   GoToSub(Sub, Doc);
   CurEditor.SetFocus;
   MainForm.AddDocumentToStack(Self);
  end;
  Result := Self;
 end
 else
  try
   l_AltKeyDown := GetKeyState(VK_ALT) and $8000 <> 0;

   l3FillChar(l_Rec, SizeOf(TarTemplateDataRec));
   l_TS := GetTemplateStorage;
   l_TS.TemplateData := l_Rec; // это надо обнулить

   if l_AltKeyDown and (aDocJumpData.DocJumpType = djSub) then
    AcquireCurDocParams;
   Result := TCustomEditorWindow(MainForm.RunTextEditor(DocFamily, aDocID, False, aDocJumpData, True));
  except
   vtMessageDlg(l3Fmt(sidNoDocPresent,[aDocID]), mtError);
   Result := nil;
  end;
  {if (Result <> nil) and (aDocJumpData.DocJumpType <> djNone) then
   Result.DocJumpData := aDocJumpData;}
end;

function TCustomEditorWindow.ShowDoc(aDocID : Longint; aGOSub : TSubID): TCustomEditorWindow;
var
 lDocAddr : TDocPointAddr;
 lDocJumpRec : TDocJumpRec;
begin
 lDocAddr := MakeDocPointAddr(DocFamily, aDocID, aGOSub);
 lDocJumpRec := MakeDocJumpData(djSub, lDocAddr);

 Result := ShowDoc(aDocID, lDocJumpRec);
end;

procedure TCustomEditorWindow.SetReferencePrim(const aBlock : TnevLocation;
                   aRefAddr : TdaGlobalCoordinateRec);
var
 aIterExit : Boolean;

 function lGetRefAddrFunc(var aCurRefAddr : TdaGlobalCoordinateRec) : Boolean;
 begin
  aCurRefAddr := aRefAddr;
  Result := not aIterExit;
  aIterExit := True;
 end;

begin
 aIterExit := False;
 SetReferenceListF(aBlock,TGetRefAddrFunc(l3LocalStub(@lGetRefAddrFunc)));
end;

procedure TCustomEditorWindow.SetReferenceListF(const aBlock : TnevLocation;
                   aGetRefAddrFunc : TGetRefAddrFunc);
var
 l_Hyperlink  : IevHyperlink;
 lHLId       : Tl3Handle;
 l_AddresList : IevAddressList;
 lCurRefAddr : TdaGlobalCoordinateRec;
 lPack       : InevOp;

begin
 try
  Assert(aBlock <> nil);
  if l3IOk(aBlock.QueryInterface(IevHyperlink, l_Hyperlink)) then
   try
    lPack := k2StartOp(aBlock, ev_ocUser + 101);
    try
     if l_Hyperlink.ID = 0 then
      l_Hyperlink.Insert;

     if l3IOk(l_Hyperlink.QueryInterface(IevAddressList, l_AddresList)) then
     try
      while aGetRefAddrFunc(lCurRefAddr) do
       with lCurRefAddr do
        l_AddresList.Add(TevAddress_C(Doc, Sub));
     finally
      l_AddresList := nil;
     end;
    finally
     lPack := nil;
    end;

    Document.AddLog(acTextWork);

   finally
    l_Hyperlink := nil;
   end
  else
   raise EarSetHyperLinkError.Create(sidCannotAddHyperLink);
 finally
  l3FreeFA(Tl3FreeAction(aGetRefAddrFunc));
 end;
end;

procedure TCustomEditorWindow.WMDropAccept(var Message: TMessage);
var
 Pt            : Tl3SPoint;
 St            : Tl3Handle;
 Sub           : TevSubPanelSub;
 //CCRec         : TItemCountRec;
 CSub          : Longint;
 I             : Longint;
 DDRefAddr     : TRefAddr;
 ItData        : PAnsiChar;
 HLId          : Tl3Handle;
 l_Hyperlink   : IevHyperlink;
 l_AddresList  : IevAddressList;
 lMainAttrTree : Boolean;
 lPack         : InevOp;
 l_Editor      : TevCustomEditor;
begin
{ddBackHyperLink}
 if TDragDataSupport.Instance.DragDataType  = Ord(ddBackHyperLink) then
 begin
  DDRefAddr.Family := Document.DocFamily;
  l_Editor := TControl(Message.lParam) As TevCustomEditor;
  with l_Editor do
  begin
   with Selection do
   begin
    evSaveBlock(l_Editor, DDRefAddr.Block);
    try
     if l3IOk(DDRefAddr.Block.QueryInterface(IevHyperlink, l_Hyperlink)) then
      try
       lPack := k2StartOp(DDRefAddr.Block, ev_ocUser + 101);
       try
        if l_Hyperlink.ID = 0 then l_Hyperlink.Insert;

        if CurEditor.TextSource.Modified then
         Self.Document.AddLog(acTextWork);

        if l3IOk(l_Hyperlink.QueryInterface(IevAddressList, l_AddresList)) then
         try
          with TArchiObjectList(TDragDataSupport.Instance.DragData) do
           for I := 0 to Pred(Count) do
           begin
            ItData := Data[I];
            if (TDragDataType(ItData[0]) = ddBackHyperLink) then
             with PdaGlobalCoordinateRec(ItData + 1)^ do
              l_AddresList.Add(TevAddress_C(Doc, Sub));
           end;
         finally
          l_AddresList := nil;
         end;
       finally
        lPack := nil;
       end;
      finally
       l_Hyperlink := nil;
      end;{try..finally}
    finally
     evFreeBlock(DDRefAddr.Block);
    end;{try..finally}
   end;{with Selection}
  end;{with (TControl(Message.lParam)..}

  TDragDataSupport.Instance.AnswerData := nil;
  Message.Result := 1;
  Exit;
 end;

{ddHyperLink}
 if TDragDataSupport.Instance.DragDataType  = Ord(ddHyperLink) then
 begin
  TDragDataSupport.Instance.AnswerData := @DDHLink;
  DDHLink.Family := DocFamily;
  DDHLink.Doc := CurDocument.DocID;

  Message.Result := 1;

  if TControl(Message.lParam) is TevSubPanel then {SubShowPanel}
  begin
   with TevSubPanel(Message.lParam) do
   begin
    Pt.GetCursorPos;
    Pt.Convert(ScreenToClient);
    Sub := SubOnPoint(Pt, St);
    If (Sub <> nil) and (St = Ord(ev_sbtSub)) then
    begin
     DDHLink.Sub := Sub.Handle;
     Exit;
    end;
   end;
  end;
  Message.Result := 0;
  TDragDataSupport.Instance.AnswerData := Nil;
 end
{ddDragObj ddDictItem ddDNDictItem}
(* else
  if (TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
     (TDragDataSupport.Instance.DragDataType = Ord(ddDictItem)) or
     (TDragDataSupport.Instance.DragDataType = Ord(ddDNDictItem)) then
  begin
   CCRec.Current := 0;
   CCRec.Count   := 0;

   if TControl(Message.lParam) is TvtOutliner then
   begin
    lMainAttrTree := TControl(Message.lParam) = MainAttrExplorer.otlAttributes;
    if lMainAttrTree then
     lAttrExplorer := MainAttrExplorer
    else
     lAttrExplorer := SubAttrExplorer;
    lAttrExplorer.DDSupportDropAcceptHandler(CCRec.Count);
   end;

   if CCRec.Count = 0 then
    vtMessageDlg(sidNotCompatibleData,mtError)
   else                                
     Message.Result:=1;
  end;
*)
end;

procedure TCustomEditorWindow.WMDropAccepted(var Message: TMessage);
begin
 Message.Result := 1;

 if TDragDataSupport.Instance.DragDataType  = Ord(ddHyperLink) then
 begin
  SetReferencePrim(DDBlock, PdaGlobalCoordinateRec(TDragDataSupport.Instance.AnswerData)^);

  AfterHyperTextAction(haReference);
 end;
end;

function TCustomEditorWindow.GetReferenceHintString(const aHyperLink : IevHyperlink) : AnsiString;
var
 l_AddresList : IevAddressList;
 I           : Integer;
 lHintStr     : AnsiString;
 lUserDocID  : TDocID;
begin
 if (aHyperlink <> nil) {and (aHyperlink.ID > 0)} then
 begin
  if l3IOk(aHyperlink.QueryInterface(IevAddressList, l_AddresList)) then
   try
    for I := 0 to Min(Pred(l_AddresList.Count), 3) do
     with l_AddresList[I]{$IfDef XE4}.rTafwAddress{$EndIf} do
     begin
      if Length(lHintStr) > 0 then lHintStr := lHintStr + ',';
      lUserDocID := LinkServer(DocFamily).Renum.GetExtDocID(NormDocID(DocID));
      if lUserDocID <> cUndefDocID then
       lHintStr := lHintStr + Format('%d.%d', [lUserDocID, SubID])
      else
       lHintStr := lHintStr + Format('#%d.%d', [DocID, SubID]);
     end;
    if l_AddresList.Count > 3 then
     lHintStr := lHintStr + Format(' ... (всего адресов: %d)', [l_AddresList.Count]);
   finally
    l_AddresList := nil;
   end;
  Result := Format('Адрес(а) ссылки: %s',[lHintStr]);
 end
 else
  Result := '';
end;

function TCustomEditorWindow.GetReferenceHintString(const aHotSpot : IevHotSpot; const aHint : AnsiString) : AnsiString;
var
 l_Hyperlink  : IevHyperlink;
 lDocPart     : IevDocumentPart;//IevSub;
 l_AddresList : IevAddressList;
 I            : Integer;
 lHintStr     : AnsiString;
 lUserDocID   : TDocID;
begin
 if l3IOk(aHotSpot.QueryInterface(IevHyperlink, l_Hyperlink)) and l_Hyperlink.Exists and (l_Hyperlink.Kind = ev_lvkUnknown {ссылка обыкновенная}) then
  try
   if not l3IsNil(l_Hyperlink.Hint) then
    Result := l3PCharLen2String(l_Hyperlink.Hint)
   else
    If l3IOk(l_Hyperlink.QueryInterface(IevAddressList, l_AddresList)) then
     try
      if l_AddresList.Count = 0 then
       Result := Format(sidHlinkErr, [l_Hyperlink.ID])
      // vtMessageDlg(l3Fmt(l3CStr(@sidHlinkErr), [l_Hyperlink.ID]),  mtError)
      else
      begin
       for I := 0 to Pred(l_AddresList.Count) do
        with l_AddresList[I]{$IfDef XE4}.rTafwAddress{$EndIf} do
        begin
         if Length(lHintStr) > 0 then lHintStr := lHintStr + #13;
         lUserDocID := LinkServer(DocFamily).Renum.GetExtDocID(NormDocID(DocID));

         if lUserDocID <> cUndefDocID then
          lHintStr := lHintStr + Format('%d.%d', [lUserDocID, SubID])
         else
          lHintStr := lHintStr + Format('#%d.%d', [NormDocID(DocID), SubID]);
        end;
        I := Pos('|',aHint);
        if I = 0 then
         Result := lHintStr + '|' + aHint
        else
         Result := lHintStr + System.Copy(aHint, I, Length(aHint) - I);
        try
         l_Hyperlink.Hint := l3PCharLen(Result);
        except
         l3System.Msg2Log(Format('Проблемы с гиперссылкой в топике %d',[Document.DocID]));
        end;
      end;
     finally
      l_AddresList := nil;
     end;

  finally
   l_Hyperlink := nil;
  end
 else
 if l3IOk(aHotSpot.QueryInterface(IevDocumentPart, lDocPart)) then
  try
   with lDocPart do
    Result := Format('"%s" [%d]',[AnsiString(Name.S), ID]);

  finally
   lDocPart := nil;
  end
 else
  Result := aHint;

end;

function TCustomEditorWindow.RemoveReference(aLinkAddr : PDestHLinkRec = nil;
                                             const aHLink    : IevHyperlink = nil): Boolean;
var
 HL : IevHyperlink;
 AL : IevAddressList;
begin
 Result := l3TestMask(Document.LockMask, acgHyperLink);
 if not Result then Exit;

 HL := aHLink;
 if HL = nil then
  Result := l3IOk(CurEditor.Selection.QueryInterface(IevHyperlink, HL));

  if Result then
  begin
   try
    if (HL.ID > 0) then
    begin
     try
      if aLinkAddr = nil then
       //l_HLServ.DelHyperLink(0, 0)
        (* выключили занесение удаленных ссылок сразу в таблицы,
           потому как undo не восстанавливает их в таблицах.
           Эту работу должен сделать фильтр сохранения текста
        *)
      else
       with aLinkAddr^ do LinkServer(DocFamily).HLinkTbl.DelHyperLink(CurDocument.DocID, HL.ID, Doc, Sub);
     except
     end;{try..except}
    end;


    if aLinkAddr = nil then                    
     HL.Delete
     //CurEditor.DeleteHyperLink
    else
     if l3IOk(HL.QueryInterface(IevAddressList, AL)) then
      try
       with aLinkAddr^ do AL.Delete(TevAddress_C(Doc, Sub));
      finally
       AL := nil;
      end;
   finally
    HL := nil;
   end;{try..finally}
  end
  else
   if (not CurEditor.Selection.Collapsed) and
      (vtMessageDlg(l3CStr(@sidDeleteHLinkInSelectQst),
                    mtConfirmation, [mbYes, mbNo]) = mrYes) then
    CurEditor.DeleteHyperLink;

 AfterHyperTextAction(haReference);
 Result := True;
end;

procedure TCustomEditorWindow.ActiveChanged;
 begin
  Inherited ActiveChanged;
  If Application.Terminated or fLoadStopLog then Exit;
  {If ActiveControl is TevCustomEditor
   then FEditor := TevCustomEditor(ActiveControl)
   else FEditor := Nil;}

  If (MainForm.CurrentChild = Self) and
   not (csDestroying in ComponentState) then
  begin
   MainForm.FreezeFontCombo:=True;
   SetSpeedButton(True);
   MainForm.FreezeFontCombo:=False;
  end;
 end;

procedure TCustomEditorWindow.EditorStyleChange(const Style: IedStyle);
begin
 try
  MainForm.StyleComboBox.Text := Style.Name;
  //MainForm.dxBarComboStyle.Text := Style.Name;
 except
  on Ek2ParamNotDefined do
  begin
   MainForm.StyleComboBox.Text := '';
   //MainForm.dxBarComboStyle.Text := '';
  end;
 end;{try..except}
end;

{$IFDEF InsiderTest}
procedure TCustomEditorWindow.MakePreview;
begin
 if f_Preview = nil then
 begin
  f_Preview := TPreviewForm.Create(Self);
  f_Preview.PreviewLinkOwner := Self;
  f_Preview.vtPreviewPanel1.Preview := GetCurEditor.Preview;
 end // if f_Preview = nil then
 else
  f_Preview.SetFocus;
end;

procedure TCustomEditorWindow.ClearPreview;
begin
 SetFocus;
 f_Preview := nil;
end;
{$ENDIF InsiderTest}

procedure TCustomEditorWindow.SetExpiredStyle(aStyleID : Integer);

 function IterFunc(const aLeafParagraph: IedLeafParagraph): Boolean;
 begin
  Result := true;
  with aLeafParagraph.Style do
   if (ID <> ev_saTxtComment) and
      (ID <> ev_saTechComment) and
      (ID <> ev_saVersionInfo) then
    ID := aStyleID;
 end;

begin
 if (CurEditor <> nil) then
  with CurEditor do
   Range.IterateLeafParagraphsF(L2IedRangeIterateLeafParagraphsAction(@IterFunc), TextSource);
end;

procedure TCustomEditorWindow.StyleComboBoxChange(Sender: TObject);
var
 lInd : Integer;
 lID  : Integer;
 l_Tag: Tl3Tag;
begin
 //if Sender = MainForm.StyleComboBox then
  with MainForm.StyleComboBox do
  begin
   lInd := Items.IndexOf(Text);
   if lInd >= 0 then
   begin
    l_Tag := MainForm.StyleComboBox.Items.Objects[lInd] As Tl3Tag;
    lID := l_Tag.IntA[k2_tiHandle];
    if (lID = ev_saTwoColorTable) then
     evSetTableStyle(CurEditor)
    else
    if (lID = ev_saTxtOutOfDate) or (lID = ev_saNotApplied) then
     SetExpiredStyle(lID)
    else
     CurEditor.TextPara.Style.ID := lID;
    if not CurEditor.View.IsCaretVisible then
     CurEditor.ScrollToCursor(CurEditor.Selection.Cursor);
   end;
   MainForm.StyleComboBox.Text := CurEditor.TextPara.Style.Name;
  end;
 (*
 else
  with MainForm.dxBarComboStyle do
  begin
   lInd := Items.IndexOf(Text);
   if lInd >= 0 then
   begin
    lID := (MainForm.StyleComboBox.Items.Objects[lInd] As Tl3PrimString).StringID;
    if (lID = ev_saTxtOutOfDate) or (lID = ev_saNotApplied) then
     SetExpiredStyle(lID)
    else
     CurEditor.TextPara.Style.ID := lID;
   end;
   Text := CurEditor.TextPara.Style.Name;
  end;
 *)
 ReturnFocusToForm;
end;

procedure TCustomEditorWindow.ReturnFocusToForm;
var
 lActCtrl : TWinControl;
begin
 lActCtrl := ActiveControl;
 if lActCtrl <> nil then
  lActCtrl.SetFocus;
end;

procedure TCustomEditorWindow.StyleComboBoxDropDown(Sender: TObject);
begin
 //if Sender = MainForm.StyleComboBox then
  MainForm.StyleComboBox.Items.Assign(CurEditor.TextPara.Style.Styles.Items);
 //else
 // MainForm.dxBarComboStyle.Items.Assign(CurEditor.TextPara.Style.Styles.Items);
end;

function TrunkDocName(const aValue : AnsiString) : AnsiString;
var
 I : Integer;
const
 cMaxLen = 70;
 cMinLen = 40;
begin
 Result := aValue;
 If Length(Result) > cMaxLen then
 begin
  I := cMaxLen;
  while (Result[I] <> ' ') and (I > cMinLen) do Dec(I);
  if I < cMinLen then I := cMaxLen;

  SetLength(Result, I);
  Result[I] := cc_Ellipsis;
 end;
end; 

procedure TCustomEditorWindow.AcquireCurDocParams;
var
 l_Rec: TarTemplateDataRec;
 l_TS : TarTemplateStorage;
begin
 RetrieveCurrentSubData(CurEditor.CurPara, l_Rec.rSubNum, l_Rec.rSubName);
 l_Rec.rDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(CurDocument.DocID);
 l_TS := GetTemplateStorage;
 l_TS.TemplateData := l_Rec;
end;

procedure TCustomEditorWindow.SetShowSelect;
begin

end;

procedure TCustomEditorWindow.SaveState2Log;
var
 l_View      : InevView;
 l_FirstTag  : Tl3Variant;
 l_FirstChild: InevObject;
begin
 if fDocument.TextSource = nil then
  l3System.Msg2Log('Не инициализирован TextSource!')
 else
  if not fDocument.TextSource.HasDocument then
   l3System.Msg2Log('Не документ не загружен!')
  else
  begin
   l3System.Msg2Log(Format('Text para count: %d', [fDocument.TextSource.DocumentContainer.DocumentInfo.TextParaCount]));
   l_View := GetTextDocumentView;
   l_FirstTag := fDocument.TextSource.Document.Child[0];
   if (l_View <> nil) and (l_FirstTag <> nil) and l_FirstTag.QT(InevObject, l_FirstChild) then
   begin
    if l_View.FormatInfoByPara(l_FirstChild) = nil then
     l3System.Msg2Log('Информация о форматировании недостуна!');
   end; // if (l_View <> nil) and fDocument.TextSource.Document.QT(InevObject, l_FirstChild) then
  end;
end;

function TCustomEditorWindow.GetTextDocumentView: InevView;
begin
 Result := nil;
end;

end.
