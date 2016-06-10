unit MainEditor;

{ $Id: MainEditor.pas,v 1.23 2016/04/26 12:46:14 lukyanets Exp $ }

// $Log: MainEditor.pas,v $
// Revision 1.23  2016/04/26 12:46:14  lukyanets
// Выключаем переключения текущего каталога
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.22  2016/03/26 00:46:20  lulin
// - запускаем тесты.
//
// Revision 1.21  2015/06/25 11:03:33  dinishev
// Вычистил лишнее.
//
// Revision 1.20  2015/04/20 13:10:04  dinishev
// {Requestlink:596845383}
//
// Revision 1.19  2014/05/27 12:03:58  lulin
// - чистка кода.
//
// Revision 1.18  2014/04/25 10:28:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/04/11 15:35:17  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.16  2014/04/11 05:56:57  dinishev
// Bug fix: не собирался Эверест.
//
// Revision 1.15  2014/04/09 08:59:59  dinishev
// Bug fix; не собирался Эверест.
//
// Revision 1.14  2014/04/08 04:59:20  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.13  2014/03/13 11:00:30  dinishev
// Preview tests
//
// Revision 1.12  2014/03/13 09:54:08  dinishev
// Preview tests
//
// Revision 1.11  2014/03/05 08:16:15  fireton
// - не собиралось
//
// Revision 1.10  2014/02/17 06:47:42  dinishev
// Перегнерация.
//
// Revision 1.9  2014/01/29 12:20:20  dinishev
// {Requestlink:514874341}
//
// Revision 1.8  2014/01/29 11:28:04  dinishev
// {Requestlink:514874360}
//
// Revision 1.7  2014/01/28 15:38:35  dinishev
// {Requestlink:514874360}
//
// Revision 1.6  2013/12/20 14:53:30  dinishev
// {Requestlink:509112119}
//
// Revision 1.5  2013/10/23 12:26:02  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.4  2013/04/17 14:20:44  lulin
// - портируем.
//
// Revision 1.3  2013/04/11 08:39:18  dinishev
// Ловим Exception, что таблица не найдена и выводим более осмысленное сообщение + не засоряем лог.
//
// Revision 1.2  2013/04/04 07:27:28  dinishev
// Недокоммичено.
//
// Revision 1.1  2013/02/27 11:51:28  dinishev
// {Requestlink:431386215}. Подготавливаем инфраструктуру.
//
// Revision 1.130  2013/02/14 04:47:53  dinishev
// Bug fix: не собирался Эверест.
//
// Revision 1.129  2012/11/01 13:47:27  dinishev
// {Requestlink:407150344}
//
// Revision 1.128  2012/10/29 16:55:39  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.127  2012/05/31 09:15:43  dinishev
// {Requestlink:365824453}
//
// Revision 1.126  2012/02/08 11:15:49  dinishev
// Поправил IFDEF для старого редактора.
//
// Revision 1.125  2012/02/08 08:33:50  lulin
// {RequestLink:336135727}
//
// Revision 1.124  2012/02/03 14:20:33  dinishev
// {Requestlink:333550210}
//
// Revision 1.123  2012/02/01 11:46:49  dinishev
// {Requestlink:330140904}
//
// Revision 1.122  2011/06/20 06:30:00  dinishev
// Bug fix: не собирался Эверест в ветке.
//
// Revision 1.121  2011/04/28 10:18:46  dinishev
// [$265388323]
//
// Revision 1.120  2011/04/28 10:16:52  dinishev
// Выделяем сообщения для общих диалогов.
//
// Revision 1.119  2011/04/21 07:54:33  dinishev
// Объединяем код работы с формулами в Арчи и Эвересте.
//
// Revision 1.118  2011/02/08 12:40:31  dinishev
// [$252524029]
//
// Revision 1.117  2011/02/08 10:13:38  dinishev
// [$252524029]
//
// Revision 1.116  2011/02/03 15:17:53  dinishev
// [$252524029]. Игнорируем графические файлы при перетаскивании.
//
// Revision 1.115  2010/11/18 13:52:19  dinishev
// [$242516161]. Чистим лишнее.
//
// Revision 1.114  2010/11/18 13:20:05  dinishev
// [$242516161]
//
// Revision 1.113  2010/07/15 10:55:56  fireton
// - переделка под новую орфографию
//
// Revision 1.112  2010/07/12 07:11:06  lulin
// {RequestLink:178323663}.
// - восстановил то, что Дима случайно удалил.
//
// Revision 1.111  2010/07/08 10:35:58  dinishev
// Cleanup
//
// Revision 1.110  2010/07/08 10:22:50  dinishev
// Cleanup
//
// Revision 1.109  2010/07/08 10:07:26  dinishev
// [$224788955]
//
// Revision 1.108  2010/06/03 12:02:03  dinishev
// [$214598023]
//
// Revision 1.107  2010/05/27 08:06:07  dinishev
// Удаляем лишние Action
//
// Revision 1.106  2010/05/26 08:30:40  dinishev
// [$210436129]
//
// Revision 1.105  2010/04/21 09:37:03  dinishev
// New build
//
// Revision 1.104  2010/03/30 06:11:50  dinishev
// Делаем набор стилей в Эвересте аналогичным с Арчи + ShortCut для формул
//
// Revision 1.103  2010/03/04 14:44:00  dinishev
// Cleanup
//
// Revision 1.102  2010/03/02 07:42:34  dinishev
// [$193822990]. Директива компиляции
//
// Revision 1.101  2010/03/02 06:36:43  dinishev
// [$193822990]
//
// Revision 1.100  2010/02/26 09:02:36  dinishev
// [$192645663]
//
// Revision 1.99  2010/02/24 18:22:33  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.98  2010/02/12 13:51:28  dinishev
// [$189268714]
//
// Revision 1.97  2010/02/12 11:21:48  dinishev
// [$189268714]
//
// Revision 1.96  2009/12/28 12:13:47  dinishev
// Cleanup
//
// Revision 1.95  2009/09/16 07:36:42  dinishev
// Добавил команды из Арчи по работе с рамками.
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.94  2009/07/24 13:14:32  lulin
// - bug fix: не собираля Эверест в ветке.
//
// Revision 1.93  2009/07/23 17:40:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.92  2009/07/23 08:15:06  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.91  2009/07/17 15:38:16  lulin
// - уменьшаем размер кодировки.
//
// Revision 1.90  2009/07/14 14:39:21  dinishev
// Bug fix: не работал пукт "Преобразование даты в текст"
//
// Revision 1.89  2009/06/11 12:56:41  dinishev
// Переход на метку
//
// Revision 1.88  2009/06/05 08:11:13  dinishev
// Bug fix: теряли путь к библиотеки стилей при открытии файла в Проводнике
//
// Revision 1.87  2009/06/05 08:10:03  dinishev
// Bug fix: не запускался Everest под Вистой с включенным UAC.
//
// Revision 1.86  2009/06/05 08:08:30  dinishev
// Cleanup
//
// Revision 1.85  2009/06/02 17:23:16  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.84  2009/06/02 13:47:41  lulin
// [$148574526].
//
// Revision 1.83  2009/06/01 16:07:44  lulin
// [$148574348].
//
// Revision 1.82  2009/05/29 17:30:36  lulin
// [$142610853].
//
// Revision 1.81  2009/05/14 08:47:06  dinishev
// Информация о документе в Эвересте по просьбе Лапина.
//
// Revision 1.80  2009/03/04 14:17:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.79  2009/02/06 12:51:57  dinishev
// CleanUp
//
// Revision 1.78  2009/02/03 13:54:20  dinishev
// CleanUp
//
// Revision 1.77  2009/01/12 11:42:27  lulin
// - <K>: 131793318.
//
// Revision 1.76  2008/10/17 12:15:30  dinishev
// <K> : 119475685 - окончательная версия
//
// Revision 1.75  2008/10/15 08:31:52  dinishev
// <K> : 119475685
//
// Revision 1.74  2008/10/13 13:38:19  dinishev
// <K> : 84640081
//
// Revision 1.73  2008/10/09 07:58:02  dinishev
// <K> : 84640081
//
// Revision 1.72  2008/10/01 11:13:31  lulin
// - <K>: 120718563.
//
// Revision 1.71  2008/10/01 06:31:09  dinishev
// Не собиралось
//
// Revision 1.70  2008/07/29 11:15:58  dinishev
// <K>: 77235630 - делаем операцию добавления выравнивания доступной для редактора
//
// Revision 1.69  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.68  2008/05/08 10:54:44  dinishev
// Bug fix: непоказывался диалог "Граница/заливки"
//
// Revision 1.67  2008/04/16 11:17:06  lulin
// - синхронизируем список параметров.
//
// Revision 1.66  2008/04/16 08:40:40  lulin
// - выделяем фасад для скрытия различий старого и нового редакторов.
//
// Revision 1.65  2008/04/14 07:04:19  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.64  2008/03/12 14:52:46  dinishev
// Делаем меню в Эвересте "ближе" к Арчи
//
// Revision 1.63  2007/12/24 15:25:13  lulin
// - удалены ненужные файлы.
//
// Revision 1.62  2007/12/05 13:51:26  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.52.2.12  2007/10/17 16:02:56  lulin
// - bug fix: не передавали контекст редактирования  - в итоге не взводился флаг модифицированности.
//
// Revision 1.52.2.11  2007/10/01 12:53:35  lulin
// - прикрутил предварительный просмотр.
//
// Revision 1.52.2.10  2007/09/30 12:02:47  lulin
// - bug fix: могли падать из-за несоответвтвия типов.
//
// Revision 1.52.2.9  2007/09/25 15:02:40  lulin
// - добавлена вставка формул.
//
// Revision 1.52.2.8  2007/09/25 13:55:14  lulin
// - перерисовываем редактор при правке формулы.
//
// Revision 1.52.2.7  2007/09/25 12:19:02  lulin
// - по двойному щелчку мыши по формуле поднимаем диалог редактирования формул.
//
// Revision 1.52.2.6  2007/09/12 19:11:28  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.52.2.5  2007/08/02 16:08:16  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.52.2.4  2007/03/27 07:57:18  dinishev
// Bug fix: не собирался Everest в ветке
//
// Revision 1.52.2.3  2007/01/19 16:24:47  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.52.2.2  2006/02/08 14:08:27  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.52.2.1  2006/02/07 15:15:57  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.52  2006/01/10 08:42:15  lulin
// - не компилировался Эверест.
//
// Revision 1.51  2005/09/08 14:31:49  lulin
// - bug fix: не собиралось.
//
// Revision 1.50  2005/07/25 13:06:49  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.49  2005/07/25 12:42:49  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.48  2005/05/20 13:50:49  lulin
// - new unit: evStyleInterfaceEx.
//
// Revision 1.47  2005/03/28 12:00:10  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.46  2005/03/23 16:29:40  lulin
// - свойство TextSource.Document стало _Ik2Tag.
//
// Revision 1.45  2005/03/19 16:41:09  lulin
// - спрятаны ненужные методы.
//
// Revision 1.44  2005/03/03 17:30:34  lulin
// - в Эвересте теперь есть возможность задания типа вновь создаваемого файла.
//
// Revision 1.43  2005/02/18 13:34:13  lulin
// - навел порядок с формой поиска.
//
// Revision 1.42  2004/11/30 10:36:11  lulin
// - убраны ненужные зависимости.
//
// Revision 1.41  2004/11/30 09:39:45  fireton
// - рефакторинг диалога поиска
//
// Revision 1.40  2004/11/13 16:44:57  lulin
// - new behavior: сообщаем пользователю о нажатии на кнопку.
//
// Revision 1.39  2004/07/13 09:22:47  fireton
// - add: прикрутка автозамены в Эверест
//
// Revision 1.38  2004/06/02 08:33:18  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.37  2004/05/14 17:28:06  law
// - remove unit: evStrGen.
//
// Revision 1.36  2003/11/28 15:56:17  law
// - в тестовых целях сделал отключение показа гиперссылок.
//
// Revision 1.35  2003/11/06 16:04:42  law
// - добавлены форматы секций - А2 и А1.
//
// Revision 1.34  2003/10/13 15:06:38  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.33  2003/05/13 08:57:40  law
// no message
//
// Revision 1.32  2003/02/17 16:37:52  law
// - remove prop: TevBlockCursor.HasSelection.
// - new prop: TevBlockCursor.Collapsed.
//
// Revision 1.31  2003/01/21 14:36:40  law
// - new behavior: сделана возможность редактирование списков.
//
// Revision 1.30  2003/01/15 15:23:54  law
// no message
//
// Revision 1.29  2002/11/22 13:15:12  law
// - change: DocBar переехал в MainEditor.
//
// Revision 1.28  2002/11/22 12:43:37  law
// - change: DocBar переехал в MainEditor.
//
// Revision 1.27  2002/11/22 10:33:40  law
// - new action: acMDIChildList.
//
// Revision 1.26  2002/11/11 14:56:48  law
// - new action: acMergeRows.
//
// Revision 1.25  2002/11/10 16:29:04  law
// - new feature: добавлена возможность вставки оглавления.
//
// Revision 1.24  2002/11/04 12:35:04  law
// - new actions: acText2Para.
//
// Revision 1.23  2002/11/04 10:22:57  law
// - new actions: acLo2Up, acUp2Lo, acSwapLoUp.
//
// Revision 1.22  2002/10/29 11:19:50  law
// - cleanup.
//
// Revision 1.21  2002/10/28 12:41:44  law
// - new behavior: возможность редактирования ссылок на тот же документ, где эта ссылка стоит.
//
// Revision 1.20  2002/10/18 11:32:17  law
// - change: более менее одинаковый дизайн всех диалогов.
//
// Revision 1.19  2002/10/15 11:43:49  law
// - new action: acAdjustMargin.
//
// Revision 1.18  2002/10/09 13:47:45  law
// - bug fix: AV при повторении поиска в новом окне редактора.
//
// Revision 1.17  2002/10/09 13:31:14  law
// - new behavior: добавлены новые функции в EverestLiteExpress.
//

{$Include evDefine.inc }

interface

uses
  Windows, 
  Messages, 

  SysUtils, 
  Variants, 
  Classes, 

  Graphics, 
  Controls, 
  Forms,
  ActnList, 
  Dialogs, 
  MainMDIEx,
  ImgList, 

  OvcBase,

  l3Variant,
  l3Base,
  l3Filer, 
  l3Types,
  l3Units,
  l3Interfaces, 
  l3ProgressComponent, 
  l3InternalInterfaces, 
  l3InterfacedComponent,

  afwInterfaces,

  nevBase,
  nevTools,

  evSubPn, 
  evEvdRd, 
  evdWriter,
  evCustomEditor,
  arCommonTypes, 
  evEditorWindow,
  evAutoComplete,
  evEditorInterfaces,
  evInternalInterfaces,
  evSaveDocumentManager,
  
  k2Reader,
  k2TagGen, 
  k2Interfaces, 
  k2DocumentGenerator, 

  d_AutoCompleteCfg

  {$IfDef evSpellChecker}
  ,
  ddSpell,
  D_Spell
  {$EndIf evSpellChecker}

  ,
  BrdDlg, k2StackGenerator, DdeMan, Tabs, evAction, 
  StdCtrls, k2FileGenerator, evdReader, evLoadDocumentManager,
  nevNavigation,
  nevGUIInterfaces
  ;

type
  TMainEditorForm = class(TevMainMDIFormEx)
    OvcController1: TOvcController;
    EverestWriter: TevdNativeWriter;
    EverestReader: TevEvdReader;
    DOSFiler: Tl3DOSFiler;
    PrintDialog: TPrintDialog;
    theActions: TActionList;
    acInsertFile: TAction;
    acInsertPicture: TAction;
    acSubProperties: TAction;
    acSubDelete: TAction;
    acDocumentPartMerge: TAction;
    acCellMerge: TAction;
    acCellDelete: TAction;
    acHyperlinkProperties: TAction;
    acHyperlinkFollow: TAction;
    acHyperlinkDelete: TAction;
    acSectionPortrait: TAction;
    acSectionLandscape: TAction;
    acSectionA4Size: TAction;
    acSectionA3Size: TAction;
    acGotoSub: TAction;
    acBuildDocumentStructure: TAction;
    acSendDocument: TAction;
    acEditStyles: TAction;
    acColorSelection: TAction;
    acANSIDOS: TAction;
    acNormal: TAction;
    acNormalOEM: TAction;
    acHeading1: TAction;
    acArticleHeading: TAction;
    acOutOfDate: TAction;
    acComment: TAction;
    acHyperlinkCont: TAction;
    acLeft: TAction;
    Everest: TDdeServerConv;
    acAdjustMargin: TAction;
    acInsertBlock: TAction;
    acConvertTextToTable: TAction;
    acLo2Up: TAction;
    acUp2Lo: TAction;
    acSwapLoUp: TAction;
    acText2Para: TAction;
    acBuildContents: TAction;
    acMDIChildList: TAction;
    tsDocuments: TTabSet;
    acDeleteAllDocumentParts: TAction;
    acBullet: TevAction;
    acNumber: TevAction;
    acDecIndent: TevAction;
    acIncIndent: TevAction;
    acSectionA2Size: TAction;
    acSectionA1Size: TAction;
    acHideHyperlinks: TAction;
    acAutoCompleteSetup: TAction;
    acAutoComplete: TAction;
    acToolsCnvRusCharset: TAction;
    acToolsCnvEngCharset: TAction;
    acToolsCnvOEM2ANSI: TAction;
    acToolsCnvANSI2OEM: TAction;
    acToolsCnvDate2Text: TAction;
    acToolsCnvMergePara: TAction;
    acInsertFormula: TAction;
    acPrintPreview: TAction;
    acAlignCellsBoundary: TAction;
    acAjustColumnWidth: TAction;
    acSetCellWidth: TAction;
    acBordersAndShade: TevAction;
    acAlignWithSeparator: TevAction;
    acHelpAbout: TAction;
    acDocInfo: TAction;
    acJump2Sub: TAction;
    acTblSetFrame: TAction;
    acTblDelFrame: TAction;
    acFindTable: TAction;
    acCopyWidths: TAction;
    acApplyWidth: TAction;
    acAAC: TAction;
    acVersInfo: TAction;
    acNotInPower: TAction;
    acAppHeader: TAction;
    acSetTextNonPrintable: TAction;
    acSetTextPrintable: TAction;
    acTranslate2Text: TevAction;
    acToolsSetSections: TAction;
    acInsertSub: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acInsertFileExecute(Sender: TObject);
    procedure acInsertPictureExecute(Sender: TObject);
    procedure acActiveEditorUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acSubPropertiesExecute(Sender: TObject);
    procedure acSubDeleteExecute(Sender: TObject);
    procedure acDocumentPartMergeExecute(Sender: TObject);
    procedure CurrentTargetActionUpdate(Sender: TObject);
    procedure DocumentPartActionUpdate(Sender: TObject);
    procedure acCellMergeExecute(Sender: TObject);
    procedure acCellDeleteExecute(Sender: TObject);
    procedure acHyperlinkPropertiesExecute(Sender: TObject);
    procedure acHyperlinkFollowExecute(Sender: TObject);
    procedure acHyperlinkDeleteExecute(Sender: TObject);
    procedure acSectionPortraitExecute(Sender: TObject);
    procedure acSectionLandscapeExecute(Sender: TObject);
    procedure SectionActionUpdate(Sender: TObject);
    procedure acSectionA4SizeExecute(Sender: TObject);
    procedure acSectionA3SizeExecute(Sender: TObject);
    procedure acGotoSubExecute(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure acSubPropertiesUpdate(Sender: TObject);
    procedure acBuildDocumentStructureExecute(Sender: TObject);
    procedure acSendDocumentExecute(Sender: TObject);
    procedure acEditStylesExecute(Sender: TObject);
    procedure acColorSelectionExecute(Sender: TObject);
    procedure EverestExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure FormShow(Sender: TObject);
    procedure acAdjustMarginExecute(Sender: TObject);
    procedure acInsertBlockExecute(Sender: TObject);
    procedure acConvertTextToTableExecute(Sender: TObject);
    procedure acLo2UpExecute(Sender: TObject);
    procedure acUp2LoExecute(Sender: TObject);
    procedure acSwapLoUpExecute(Sender: TObject);
    procedure acText2ParaExecute(Sender: TObject);
    procedure acBuildContentsExecute(Sender: TObject);
    procedure acMDIChildListExecute(Sender: TObject);
    procedure acMDIChildListUpdate(Sender: TObject);
    procedure tsDocumentsChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure acDeleteAllDocumentPartsExecute(Sender: TObject);
    procedure acSectionA2SizeExecute(Sender: TObject);
    procedure acSectionA1SizeExecute(Sender: TObject);
    procedure acHideHyperlinksUpdate(Sender: TObject);
    procedure acHideHyperlinksExecute(Sender: TObject);
    procedure acAutoCompleteSetupExecute(Sender: TObject);
    procedure acAutoCompleteExecute(Sender: TObject);
    procedure acToolsCnvRusCharsetExecute(Sender: TObject);
    procedure acToolsCnvEngCharsetExecute(Sender: TObject);
    procedure acToolsCnvOEM2ANSIExecute(Sender: TObject);
    procedure acToolsCnvANSI2OEMExecute(Sender: TObject);
    procedure acToolsCnvDate2TextExecute(Sender: TObject);
    procedure acToolsCnvMergeParaExecute(Sender: TObject);
    procedure acInsertFormulaExecute(Sender: TObject);
    procedure acPrintPreviewExecute(Sender: TObject);
    procedure acAlignCellsBoundaryExecute(Sender: TObject);
    procedure acAjustColumnWidthExecute(Sender: TObject);
    procedure acSetCellWidthExecute(Sender: TObject);
    procedure acHelpAboutExecute(Sender: TObject);
    procedure acDocInfoExecute(Sender: TObject);
    procedure acJump2SubExecute(Sender: TObject);
    procedure acFindTableExecute(Sender: TObject);
    procedure acTblSetFrameExecute(Sender: TObject);
    procedure acTblDelFrameExecute(Sender: TObject);
    procedure acCopyWidthsExecute(Sender: TObject);
    procedure acApplyWidthExecute(Sender: TObject);
    procedure acApplyWidthUpdate(Sender: TObject);
    procedure acAACExecute(Sender: TObject);
    procedure acAACUpdate(Sender: TObject);
    procedure acSetTextNonPrintableExecute(Sender: TObject);
    procedure acSetTextPrintableExecute(Sender: TObject);
    procedure acToolsSetSectionsExecute(Sender: TObject);
    procedure acInsertSubExecute(Sender: TObject);
  private
    { Private declarations }
    {$IfDef evSpellChecker}
    f_SpellDictionary : TddSpellDictionary;
    {$EndIf evSpellChecker}
  protected
  // internal fields
    CurrentTarget : IUnknown;
  private
  //  
    procedure WMDropFiles(var Msg: TMessage);
      message WM_DropFiles;
      {-}
    function SetSubPrim(aSubType: TSubType): Integer;
      {-}
  protected
  // property methods
      function  pm_GetAdjustMargin: Bool;
        override;
      procedure pm_SetAdjustMargin(aValue: Bool);
        override;
        {-}
    {$IfNDef evMyEditor}  
    procedure RegisterEvdFiles;
      {-}
    {$EndIf  evMyEditor}  
   function Date2Text(Sender      : TObject;
                      var B       : PAnsiChar;
                      var L       : Long;
                      var CharSet : SmallInt;
                      Data        : Pointer) : Boolean;
  protected
  // internal methods
    procedure DoCreate;
      override;
    function  cnvLo2Up   (Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvUp2Lo   (Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvLoUpSwap(Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvRus2Eng (Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvEng2Rus (Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvOEM2ANSI(Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
    function  cnvANSI2OEM(Sender : TObject; B: PAnsiChar; L: Long; CharSet: Long) : Boolean;
        {-}
  public
    { Public declarations }
    function CheckActiveEditor: Boolean;
     {* - Для унификации проверок. }  
    {$IfDef evSpellChecker}
    procedure Spellcheck;
      {-}
    {$EndIf evSpellChecker}
    procedure UpdateMenuItems(Sender: TObject);
      virtual;
      {-}
    procedure EditorWindowFontChange(const Font: Il3Font);
      virtual;
      {-}
    procedure EditorWindowStyleChange(const aName: String);
      virtual;
      {-}
    procedure EditorWindowZoomChange(NewZoom : Integer);
      virtual;
      {-}
    function Process(Sender : TObject;
                     Target : TObject;
                     Action : Long; 
                     Down   : Bool): Bool;
      override;
      {-}
    class function SubProperties(const aSub: IevSub; anEditor: TevCustomEditor): Boolean;
      {-}
    procedure DeleteSub(const aSub: IevSub);
      {-}
    class procedure BordersAndShade(const aParagraph : IedParagraph;
                                    const aTable     : IedTable;
                                    anApplyTo        : TddApplyToPrim = dd_atAuto;
                                    const aProcessor : InevProcessor = nil);
      {* - вызывает выполнение диалога для редактирования рамки и заливки. }
    class procedure HyperlinkProperties(const aHyperlink : IevHyperlink;
                                        aDocument  : Tl3Tag);
      {-}
    function  MouseAction(const aHotSpot    : IevHotSpot;
                          aButton           : TevMouseButton;
                          anAction          : TevMouseAction;
                          Keys              : TShiftState;
                          var NeedAsyncLoop : Bool): Bool;
      virtual;                    
      {-}
    procedure GetHotspotInfo(Sender         : TObject;
                             const aHotSpot : IevHotSpot;
                             const aKeys    : TafwCursorState;
                             var theInfo    : TafwCursorInfo);
      {-}
    procedure ShowSubMenu(const aSub : IevSub;
                          const aPt  : Tl3SPoint;
                          aComponent : TComponent);
      virtual;
      {-}
    procedure DoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
      virtual;
      {-}
    procedure DoExplorerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
      virtual;
      {-}
    procedure InitStylesName;
      {-}
    procedure CheckEditorProperties(aEditor: TevCustomEditorWindow);
      override;
      {-}
    procedure CloseMDIChild(Form: TForm);
      override;
      {-}
    procedure DocBarInsert(const aDocName: String);
      override;
      {-}
    procedure UpdateName(aEditor : TCustomForm; const aName: String);
      override;
      {-}
  end;

var
  MainForm: TMainEditorForm;

implementation

uses
  MAPI,
  ShellAPI,
  ShlObj,
  
  EdWin,

  Registry,

  STStrL,

  l3String,
  l3Stream,
  l3Chars,

  evdTypes,
  evdDOM,

  k2Tags,
  k2OpMisc,

  m2XLTLib,

  ddSectionRepair,
  ddSectionWithSub2Para,

  evOp,
  {$IfDef evSpellChecker}
  evExcept,
  {$EndIf evSpellChecker}
  evStandardActions,
  evMsgCode,
  evdStyles,
  evStyleTableTools,
  evTableTools,
  evTypes,
  evStyleInterfaceEx,
  evConst,

  dt_Types,

  evTableSearch,
  evAutoBlock,
  evTableConverter,
  evContentTable,
  evFacadeSub,
  evFacadeGUI,
  evFacadeCursor,
  evFacadeUtils,
  evFacadeSelection,
  evBitmapParaBitmapContainer,
  evFacadTextSource,
  evCopyTableCellWidth,

  evdFrame_Const,

  evCommonRes,
  StrShop,
  IniShop,

  D_TxSrch,
  D_edMSub,
  D_Hyperlink,
  D_Style,
  D_MDILst,
  D_TxSrch_Types,
  D_IntEdit,
  D_PicSizeEdit,
  D_AboutLite,
  D_DocInf,

  evCommonUtils,

{$IFDEF AAC_Support}
  ddAAC,
{$ENDIF AAC_Support}  

  vtDialogs,
  vtPreviewPanel,

  TextPara_Const,
  ObjectSegment_Const,
  Formula_Const,
  BitmapPara_Const
  ;

{$R *.dfm}

// start class TMainEditorForm

procedure TMainEditorForm.EditorWindowFontChange(const Font: Il3Font);
  //virtual;
  {-}
begin
end;

procedure TMainEditorForm.EditorWindowStyleChange(const aName: String);
  //virtual;
  {-}
begin
end;

procedure TMainEditorForm.EditorWindowZoomChange(NewZoom : Integer);
  //virtual;
  {-}
begin
end;

function TMainEditorForm.Process(Sender : TObject;
                                 Target : TObject;
                                 Action : Long;
                                 Down   : Bool): Bool;
  //override;
  {-}
begin
 Result := inherited Process(Sender, Target, Action, Down);
 if not Result then
 begin
  Result := true;
  case TevOperation(Action) of
   ev_ccSearch      : TTextSearchDlg.Execute(sdiSearch,  ActiveEditor.Editor, cSearchAllTypes);
   ev_ccReplace     : TTextSearchDlg.Execute(sdiReplace, ActiveEditor.Editor, cSearchAllTypes);
   ev_ccSearchAgain : TTextSearchDlg.FindNext(ActiveEditor.Editor);
   {$IfDef evSpellChecker}
   ev_ccSpellCheck  : SpellCheck;
   {$EndIf evSpellChecker}
   else
    Result := false;
  end;{case TevOperation(Action)}
 end;//not Result
end;

procedure TMainEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 inherited;
 if (l3System.CheckClipboard = IDCancel) then
  Action := caNone;
 DragAcceptFiles(Handle, false);
end;

procedure TMainEditorForm.acInsertFileExecute(Sender: TObject);
var
 l_Reader : Tk2CustomReader;
begin
 if CheckActiveEditor then
 begin
  with LoadManager do
  begin
   if QueryName then
   begin
    with ActiveEditor do
    begin
     l_Reader := GetReader(TextSource);
     try
      evInsertFile(Editor, l_Reader);
     finally
      l3Free(l_Reader);
     end;//try..finally
    end;//with ActiveEditor
   end;//QueryName
  end;//with LoadManager
 end;//ActiveEditor <> nil
end;

procedure TMainEditorForm.acInsertPictureExecute(Sender: TObject);
var
 l_Stream : Tl3FileStream;
 l_Filter : string;
begin
 if CheckActiveEditor then
 begin
  l_Filter := OpenDialog.Filter;
  try
   OpenDialog.Filter := evPirctureFilter;
   if ExecuteOpenDialog(OpenDialog) then begin
    l_Stream := Tl3FileStream.Create(OpenDialog.FileName, l3_fmRead);
    try
     ActiveEditor.Editor.InsertPicture(l_Stream);
    finally
     l3Free(l_Stream);
    end;{try..finally}
   end;//OpenDialog.Execute
  finally
   OpenDialog.Filter := l_Filter;
  end;//try..finally
 end;//ActiveEditor <> nil
end;

procedure TMainEditorForm.acActiveEditorUpdate(Sender: TObject);
begin
 (Sender As TAction).Enabled := (ActiveEditor <> nil);
end;

procedure TMainEditorForm.DoCreate;
  //override;
  {-}
var
 StyleInterface  : TevStyleInterfaceEx;
begin
 inherited;
 {$IfNDef evMyEditor}
 try
 RegisterEvdFiles;
 except
  on ERegistryException do;
 end;
 {$EndIf  evMyEditor}
 StyleInterface := TevStyleInterfaceEx.Create;
 try
  StyleInterface.SelectStyledObjectType(k2_typTextPara);
  InitStylesName;
  try
   StyleInterface.Load(EverestReader);
  except
   on EOSError do ;
  end;{try..except}
 finally
  l3Free(StyleInterface);
 end;{try..finally}
 AutoComplete := TevAutoComplete.Create;
end;
  
procedure TMainEditorForm.FormDestroy(Sender: TObject);
begin
 inherited;
 CurrentTarget := nil;
 {$IfDef evSpellChecker}
 f_SpellDictionary.Save;
 l3Free(f_SpellDictionary);
 {$EndIf evSpellChecker}
 l3Free(AutoComplete);
end;

{$IfDef evSpellChecker}
procedure TMainEditorForm.Spellcheck;
var
 DictName : TFileName;
begin
 if CheckActiveEditor then
 begin
  if (f_SpellDictionary = nil) then
  begin
   f_SpellDictionary := TddSpellDictionary.Create;
   DictName := IniRec^.DictIniName;
   if (DictName = '') then
   begin
    DictName := ExtractFilePath(OpenDialog.FileName);
    if (DictName = '') then
     DictName := OpenDialog.InitialDir;
    DictName := l3AddBackSlashL(DictName)
             +  ChangeFileExt(ExtractFileName(Application.ExeName), '.dic');
    IniRec^.DictIniName := DictName;
   end;{DictName = ''}
   f_SpellDictionary.FileName := DictName;
  end;{f_SpellChecker = nil}

  TSpellCheckDlg.Execute(ActiveEditor.Editor, f_SpellDictionary);
 end;
end;
{$EndIf evSpellChecker}

class function TMainEditorForm.SubProperties(const aSub: IevSub; anEditor: TevCustomEditor): Boolean;
var
 l_Param  : TevSubEditParam;
 l_Change : Boolean;
begin
 if (aSub = nil) OR (aSub.LayerID <> Ord(ev_sbtSub)) then
  Result := false
 else
  begin
   l_Param.rEditor := anEditor;
   l_Param.rSubID := aSub.ID;
   l_Param.rUserType := utNone;
   l_Param.rCanStylizeBlocks := True;
   l_Param.rIsDocEditor := False;
   l_Param.rSubList := nil;
   l_Param.rFamilyID := 0;
   l_Param.rDocID := -1;
   EvSubNameEdit(l_Param, l_Change);
   Result := true;
  end;
end;

procedure TMainEditorForm.DeleteSub(const aSub: IevSub);
  {-}
var
 l_Block : IevDocumentPart;
 l_Pack  : InevOp;                 
begin
 if (aSub <> nil) then
 begin
  if l3IOk(aSub.QueryInterface(IevDocumentPart, l_Block)) then
   try
    l_Pack := k2StartOp(aSub, ev_msgDeletePara);
    try
     if evDeleteSub(ActiveEditor.Editor, l_Block) then
      with l_Block do
       SetTo(Cursor.AsObject);
    finally
     l_Pack := nil;
    end;//try..finally
   finally
    l_Block := nil;
   end{try..finally}
  else
   evDeleteSub(ActiveEditor.Editor, aSub);
 end;{aSub <> nil}
end;

class procedure TMainEditorForm.BordersAndShade(const aParagraph : IedParagraph;
                                                const aTable     : IedTable;
                                                anApplyTo        : TddApplyToPrim = dd_atAuto;
                                                const aProcessor : InevProcessor = nil);
  {* - Вызывает выполнение диалога для редактирования рамки и заливки. }
begin
 with BorderDlg do 
 begin
  with IniRec^.Dialogs do 
  begin
   if (Border.Height > 0) then 
    Height := Border.Height;
   if (Border.Width > 0) then 
    Width := Border.Width;
  end;//with IniRec^.Dialogs
  if (aProcessor = nil) then
   ExecutePrim(aParagraph, aTable, aTable as InevProcessor, anApplyTo)
  else
   ExecutePrim(aParagraph, aTable, aProcessor, anApplyTo);
  with IniRec^.Dialogs do 
  begin
   Border.Height := Height;
   Border.Width := Width;
  end;//with IniRec^.Dialogs
 end;//with BorderDlg
end;

class procedure TMainEditorForm.HyperlinkProperties(const aHyperlink : IevHyperlink;
                                                    aDocument  : Tl3Tag);
  {-}
var
 l_DocID : Long;  
begin
 with TdHyperLink.Create(Application) do
  try
   l_DocID := 0;
   with aDocument do begin
    with Attr[k2_tiExternalHandle] do
     if IsValid then
      l_DocID := AsLong;
    if (l_DocID = 0) then
     with Attr[k2_tiInternalHandle] do
      if IsValid then
       l_DocID := AsLong;
   end;//with aDocument
   Execute(aHyperlink, l_DocID);
  finally
   Free;
  end;//try..finally
end;

procedure TMainEditorForm.acSubPropertiesExecute(Sender: TObject);
begin
 SubProperties(IevSub(CurrentTarget), ActiveEditor.Editor);
 CurrentTarget := nil;
end;

procedure TMainEditorForm.acSubDeleteExecute(Sender: TObject);
begin
 DeleteSub(IevSub(CurrentTarget));
 CurrentTarget := nil;
end;

procedure TMainEditorForm.acDocumentPartMergeExecute(Sender: TObject);
begin
 IevDocumentPart(CurrentTarget).Merge;
 CurrentTarget := nil;
end;

procedure TMainEditorForm.CurrentTargetActionUpdate(Sender: TObject);
begin
 (Sender As TAction).Enabled := (CurrentTarget <> nil);
end;

procedure TMainEditorForm.DocumentPartActionUpdate(Sender: TObject);
var
 l_DocumentPart : IevDocumentPart;
begin
 if (CurrentTarget <> nil) AND
    l3IOk(CurrentTarget.QueryInterface(IevDocumentPart, l_DocumentPart)) then
  try
   with (Sender As TAction) do 
   begin
    Visible := True;
    Enabled := True;
   end;//with (Sender As TBasicAction)
   CurrentTarget := l_DocumentPart;
  finally
   l_DocumentPart := nil;
  end
 else
  with (Sender As TAction) do 
  begin
   Visible := False;
   Enabled := False;
  end;//with (Sender As TBasicAction)
end;

procedure TMainEditorForm.acCellMergeExecute(Sender: TObject);
begin
 if (CurrentTarget <> nil) then 
 begin
  IedCell(CurrentTarget).Merge;
  CurrentTarget := nil;
 end;//CurrentTarget <> nil
end;

procedure TMainEditorForm.acCellDeleteExecute(Sender: TObject);
begin
 if (CurrentTarget <> nil) then 
 begin
  IedCell(CurrentTarget).Delete(nil);
  CurrentTarget := nil;
 end;//CurrentTarget <> nil
end;

procedure TMainEditorForm.acHyperlinkPropertiesExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  HyperlinkProperties(IevHyperlink(CurrentTarget), ActiveEditor.TextSource.Document);
 CurrentTarget := nil;
end;

procedure TMainEditorForm.acHyperlinkFollowExecute(Sender: TObject);
var
 l_URL : Tl3PCharLen;
begin
 if (CurrentTarget <> nil) then 
 begin
  l_URL := IevHyperlink(CurrentTarget).URL;
  if not l3IsNil(l_URL) then
   ShellExecuteA(Application.MainForm.Handle, nil, PAnsiChar(l_URL.S), nil, nil, SW_ShowNormal);
  CurrentTarget := nil;
 end;//CurrentTarget <> nil
end;

procedure TMainEditorForm.acHyperlinkDeleteExecute(Sender: TObject);
begin
 if (CurrentTarget <> nil) then 
 begin
  IevHyperlink(CurrentTarget).Delete;
  CurrentTarget := nil;
 end;//CurrentTarget <> nil
end;

procedure TMainEditorForm.acSectionPortraitExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).Orientation := ev_poPortrait;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;

procedure TMainEditorForm.acSectionLandscapeExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).Orientation := ev_poLandscape;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;

procedure TMainEditorForm.SectionActionUpdate(Sender: TObject);
var
 l_Section : IevdSection;
begin
 if (CurrentTarget <> nil) AND
  l3IOk(CurrentTarget.QueryInterface(IevdSection, l_Section)) then
  try
   (Sender As TAction).Enabled := True;
    if (l_Section.Orientation = ev_poPortrait) then
     acSectionPortrait.Checked := True
    else
     acSectionLandscape.Checked := True;
    case l_Section.PaperSize of
     evd_psA1:
      acSectionA1Size.Checked := True;
     evd_psA2:
      acSectionA2Size.Checked := True;
     evd_psA3:
      acSectionA3Size.Checked := True;
     else
      acSectionA4Size.Checked := True;
    end;//case l_Section.PaperSize
  finally
   l_Section := nil;
  end//try..finally
 else
  (Sender As TAction).Enabled := False;
end;

procedure TMainEditorForm.acSectionA4SizeExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).PaperSize := evd_psA4;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;

procedure TMainEditorForm.acSectionA3SizeExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).PaperSize := evd_psA3;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;

function  TMainEditorForm.MouseAction(const aHotSpot    : IevHotSpot;
                                      aButton           : TevMouseButton;
                                      anAction          : TevMouseAction;
                                      Keys              : TShiftState;
                                      var NeedAsyncLoop : Bool): Bool;
  //virtual;
  {-}
var
 l_Sub     : IevSub;
 l_Info    : TafwCursorInfo;
 l_State   : TafwCursorState;
 l_Control : IevControl;
begin
 case aButton of
  ev_mbLeft : begin
   if (anAction = ev_maDouble) then 
   begin
    Result := evEditFormula(aHotSpot, ActiveEditor.Editor, NeedAsyncLoop);
    if not Result then
     Result := evEditPicture(aHotSpot, ActiveEditor.Editor, NeedAsyncLoop);
    if not Result then
    begin
     l_State.rKeys := Keys; // Остальное нам не интересно...
     aHotSpot.HitTest(ActiveEditor.Editor.View, l_State, l_Info);
     if (l_Info.rCursor = ev_csProperties) and l3IOk(aHotSpot.QueryInterface(IevSub, l_Sub)) then
      try
       Result := SubProperties(l_Sub, ActiveEditor.Editor);
       if Result then
        NeedAsyncLoop := False;
      finally
       l_Sub := nil;
      end//try..finally
    end; // if not Result then
   end
   else
   if (anAction = ev_maUp) then
   begin
    if Supports(aHotSpot, IevControl, l_Control) then
     try
      MessageDlg(l3Str(l_Control.Text), mtInformation, [mbOk], 0);
      Result := True;
     finally
      l_Control := nil;
     end
    else
     Result := False;
   end//anAction = ev_maUp
   else
    Result := False;
  end;//ev_mbLeft
  else Result := false;
 end;//case aButton
end;

procedure TMainEditorForm.GetHotspotInfo(Sender         : TObject;
                                         const aHotSpot : IevHotSpot;
                                         const aKeys    : TafwCursorState;
                                         var theInfo    : TafwCursorInfo);
  {-}
var
 l_Tag: Tl3Variant;
begin
 if evIsFormula(aHotSpot, l_Tag) then
 begin
  theInfo.rCursor := ev_csHandPoint;
  //theInfo.rHint := l3CStr(l_Tag.PCharLenA[k2_tiText]);
 end;//l_Tag.Child[0].InheritsFrom(k2_idFormula)
end;
  
procedure TMainEditorForm.ShowSubMenu(const aSub : IevSub;
                                      const aPt  : Tl3SPoint;
                                      aComponent : TComponent);
  //virtual;
  {-}
begin
end;

procedure TMainEditorForm.DoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  //virtual;
  {-}
begin
end;

procedure TMainEditorForm.acGotoSubExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  ActiveEditor.GotoSub(IevSub(CurrentTarget));
 CurrentTarget := nil;
end;

procedure TMainEditorForm.DoExplorerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  //virtual;
  {-}
begin
end;

procedure TMainEditorForm.InitStylesName;
var
 l_Path : string;
begin
 if (DOSFiler.FileName = '') then 
 begin
  DOSFiler.FileName := IniRec^.StylesIniName;
  if (DOSFiler.FileName = '') then 
  begin
   l_Path := ExtractFilePath(OpenDialog.FileName);
   if (l_Path = '') then l_Path := OpenDialog.InitialDir;
   DOSFiler.FileName := AddBackSlashL(l_Path)
                      +  ChangeFileExt(ExtractFileName(Application.ExeName), '.evs');
  end
  else
   if ExtractFilePath(DOSFiler.FileName) = '' then
   begin
    l_Path := ExtractFilePath(Application.ExeName);
    DOSFiler.FileName := AddBackSlashL(l_Path) + DOSFiler.FileName;
  end;
  IniRec^.StylesIniName := DOSFiler.FileName;
 end;{DOSFiler.FileName = ''}
end;

{$IfNDef evMyEditor}
procedure TMainEditorForm.RegisterEvdFiles;
  {-}
var
 l_Registry : TRegistry;
 l_AppName  : string;
begin
 l_AppName := ChangeFileExt(ExtractFileName(Application.ExeName), '');
 l_Registry := TRegistry.Create;
 try
  with l_Registry do
  begin
   RootKey := HKEY_CLASSES_ROOT;
   if OpenKey('.evr', True) then 
   begin
    WriteString('', 'evrfile');
    CloseKey;
   end;
   if OpenKey('.nsr', True) then 
   begin
    WriteString('', 'evrfile');
    CloseKey;
   end;
   if OpenKey('.evd', True) then 
   begin
    WriteString('', 'evrfile');
    CloseKey;
   end;
   if OpenKey('evrfile', True) then 
   begin
    WriteString('', 'Everest 1.0 file');
    WriteInteger('EditFlags', $0);
    CloseKey;
   end;
   if OpenKey('evrfile\Shell', True) then 
   begin
    WriteString('', '');
    CloseKey;
   end;
   if OpenKey('evrfile\Shell\Open', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;

   if OpenKey('evrfile\Shell\Open\command', True) then 
   begin
    WriteString('', '"' + Application.ExeName + '" "%1"');
    CloseKey;
   end;
   //if KeyExists('evrfile\Shell\Open\ddeexec') then
   // DeleteKey('evrfile\Shell\Open\ddeexec');
   if OpenKey('evrfile\Shell\Open\ddeexec', True) then
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('evrfile\Shell\Open\ddeexec\Application', True) then
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('evrfile\Shell\Open\ddeexec\topic', True) then
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
   {--- rtf ---}
   if OpenKey('rtffile', True) then CloseKey;
   if OpenKey('rtffile\Shell', True) then CloseKey;
   if OpenKey('rtffile\Shell\Everest', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('rtffile\Shell\Everest\command', True) then 
   begin
    WriteString('', Application.ExeName);       
    CloseKey;
   end;
   if OpenKey('rtffile\Shell\Everest\ddeexec', True) then 
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('rtffile\Shell\Everest\ddeexec\Application', True) then 
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('rtffile\Shell\Everest\ddeexec\topic', True) then 
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
   {--- txt ---}
   if OpenKey('txtfile', True) then CloseKey;
   if OpenKey('txtfile\Shell', True) then CloseKey;
   if OpenKey('txtfile\Shell\Everest', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('txtfile\Shell\Everest\command', True) then 
   begin
    WriteString('', Application.ExeName);
    CloseKey;
   end;
   if OpenKey('txtfile\Shell\Everest\ddeexec', True) then 
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('txtfile\Shell\Everest\ddeexec\Application', True) then 
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('txtfile\Shell\Everest\ddeexec\topic', True) then 
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
   {--- doc ---}
   if OpenKey('.doc', True) then CloseKey;
   if OpenKey('.doc\Shell', True) then CloseKey;
   if OpenKey('.doc\Shell\Everest', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('.doc\Shell\Everest\command', True) then 
   begin
    WriteString('', Application.ExeName);
    CloseKey;
   end;
   if OpenKey('.doc\Shell\Everest\ddeexec', True) then 
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('.doc\Shell\Everest\ddeexec\Application', True) then 
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('.doc\Shell\Everest\ddeexec\topic', True) then 
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
   {--- doc ---}
   if OpenKey('.doc', True) then CloseKey;
   if OpenKey('.doc\ShellEx', True) then CloseKey;
   if OpenKey('.doc\ShellEx\Everest', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('.doc\ShellEx\Everest\command', True) then 
   begin
    WriteString('', Application.ExeName);
    CloseKey;
   end;
   if OpenKey('.doc\ShellEx\Everest\ddeexec', True) then 
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('.doc\ShellEx\Everest\ddeexec\Application', True) then 
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('.doc\ShellEx\Everest\ddeexec\topic', True) then 
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
   {--- doc ---}
   if OpenKey('.doc', True) then CloseKey;
   if OpenKey('.doc\ShellNew', True) then CloseKey;
   if OpenKey('.doc\ShellNew\Everest', True) then 
   begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('.doc\ShellNew\Everest\command', True) then 
   begin
    WriteString('', Application.ExeName);
    CloseKey;
   end;
   if OpenKey('.doc\ShellNew\Everest\ddeexec', True) then 
   begin
    WriteString('', '%1');
    CloseKey;
   end;
   if OpenKey('.doc\ShellNew\Everest\ddeexec\Application', True) then 
   begin
    WriteString('', l_AppName);
    CloseKey;
   end;
   if OpenKey('.doc\ShellNew\Everest\ddeexec\topic', True) then 
   begin
    WriteString('', 'everest');
    CloseKey;
   end;
  end;{with l_Registry}
 finally
  l3Free(l_Registry);
 end;{try..finally}
//  Не забываем обновить информацию об изменениях...
 SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;
{$EndIf evMyEditor}

procedure TMainEditorForm.pmExplorerPopup(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if (ActiveEditor = nil) then
  CurrentTarget := nil
 else
  with ActiveEditor do
   if l3IOk(outExplorer.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
    try
     CurrentTarget := l_Sub;
    finally
     l_Sub := nil;
    end//try..finally
   else
    CurrentTarget := nil;
end;

procedure TMainEditorForm.acSubPropertiesUpdate(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if (CurrentTarget <> nil) AND
    l3IOk(CurrentTarget.QueryInterface(IevSub, l_Sub)) then
  try
   with (Sender As TAction) do 
   begin
    if (l_Sub.LayerID = Ord(ev_sbtSub)) then 
    begin
     Visible := True;
     Enabled := True;
    end 
    else 
    begin
     Visible := False;
     Enabled := False;
    end;//l_Sub.LayerID = ev_sbtSub
   end;//wit (Sender As TBasicAction)
   CurrentTarget := l_Sub;
  finally
   l_Sub := nil;
  end
 else
  with (Sender As TAction) do 
  begin
   Visible := False;
   Enabled := False;
  end;//wit (Sender As TBasicAction)
end;

procedure TMainEditorForm.acBuildDocumentStructureExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  CreateBlockStructure(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acSendDocumentExecute(Sender: TObject);
var
 Files : ansistring;
begin
 Files := SaveToFile;
 if (Files <> '') then
  MAPISendDocuments(Application.Handle, ';', PAnsiChar(Files), nil, 0);
end;

procedure TMainEditorForm.acEditStylesExecute(Sender: TObject);
begin
 InitStylesName;
 RunStyleEditor;
end;

procedure TMainEditorForm.acColorSelectionExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
  with ActiveEditor.Editor.TextPara.Style do
   case (Sender As TComponent).Tag of
    0  : ID := ev_saToLeft;          { - Прижатый влево }
    1  : ID := ev_saColorSelection;  { - Цветовое выделение }
    2  : ID := ev_saANSIDOS;         { - Моноширинный }
    3  : ID := ev_saTxtNormalANSI;   { - Нормальный }
    4  : ID := ev_saTxtNormalOEM;    { - Нормальный (OEM) }
    5  : ID := ev_saTxtHeader1;      { - Заголовок 1 }
    6  : ID := ev_saArticleHeader;   { - Заголовок статьи }
    7  : ID := ev_saTxtOutOfDate;    { - Утратил силу }
    8  : ID := ev_saTxtComment;      { - Комментарий }
    9  : ID := ev_saHyperLinkCont;   { - Продолжение ссылки }
    10 : ID := ev_saVersionInfo;     { - Информация о версии }
    11 : ID := ev_saNotApplied;      { - Не вступил в силу }
    12 : ID := ev_saEnclosureHeader; { - Заголовок приложения }
   end;//case (Sender As TComponent).Tag
end;

procedure TMainEditorForm.EverestExecuteMacro(Sender: TObject;
  Msg: TStrings);
var
 S : string;
begin
 S := Msg[0];
 LoadManager.FileName := S;
 CreateMDIChild(nil, S);
end;

procedure TMainEditorForm.FormShow(Sender: TObject);
var
 i : Integer;
begin
 inherited;
 DragAcceptFiles(Handle, true);
 if (ParamCount > 0) then
  for i := 1 to ParamCount do begin
   LoadManager.FileName := ParamStr(i);
   CreateMDIChild(nil, ParamStr(i));
  end;//for i
end;

procedure TMainEditorForm.WMDropFiles(var Msg: TMessage);
  {message WM_DropFiles;}
  {-}
var
 H : THandle;
 S : Tl3String;
 i : Long;
 C : Long;
begin
 H := Msg.wParam;
 try
  C := DragQueryFile(H, $FFFFFFFF, nil, 0);
  if (C > 0) then
  begin
   S := Tl3String.Create;
   try
    for i := 0 to Pred(C) do 
    begin
     S.Len := DragQueryFile(H, i, nil, 0);
     if not S.Empty then 
     begin
      DragQueryFileA(H, i, S.St, S.StSize);
      LoadManager.FileName := S.AsString;
      CreateMDIChild(nil, S.AsString);
     end;{not S.Empty}
    end;{for i..}
   finally
    l3Free(S);
   end;{try..finally}
  end;{C > 0}
 finally
  DragFinish(H);
 end;{try..finally}
end;

procedure TMainEditorForm.acAdjustMarginExecute(Sender: TObject);
var
 l_AdjustMargin : Bool;
begin
 if CheckActiveEditor then
  with ActiveEditor do
  begin
   l_AdjustMargin := (Sender As TAction).Checked;
   if l_AdjustMargin then
   begin
    Editor1.LeftIndentDelta := 16;
    Editor2.LeftIndentDelta := 16;
   end
   else
   begin
    Editor1.LeftIndentDelta := 0;
    Editor2.LeftIndentDelta := 0;
   end;//l_AdjustMargin
   IniRec^.AdjustMargin := l_AdjustMargin
  end;//ActiveEditor <> nil
end;

function TMainEditorForm.pm_GetAdjustMargin: Bool;
  //override;
  {-}
begin
 Result := acAdjustMargin.Checked;
end;

procedure TMainEditorForm.pm_SetAdjustMargin(aValue: Bool);
  //override;
  {-}
begin
 acAdjustMargin.Checked := aValue;
 acAdjustMarginExecute(acAdjustMargin);
end;

procedure TMainEditorForm.CheckEditorProperties(aEditor: TevCustomEditorWindow);
  //override;
  {-}
begin
 inherited;
 acAdjustMargin.Checked := (aEditor.LeftIndentDelta <> 0);
end;

procedure TMainEditorForm.acInsertBlockExecute(Sender: TObject);

begin
 if CheckActiveEditor then
  SetSubPrim(stBlock);
end;

procedure TMainEditorForm.acConvertTextToTableExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  ConvertText2Table(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acLo2UpExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvLo2Up); 
 end; 
end;

procedure TMainEditorForm.acUp2LoExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvUp2Lo);
 end; 
end;

procedure TMainEditorForm.acSwapLoUpExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvLoUpSwap);
 end; 
end;

procedure TMainEditorForm.acText2ParaExecute(Sender: TObject);
begin
 if CheckActiveEditor then ActiveEditor.Editor.Block2Para;
end;

procedure TMainEditorForm.acBuildContentsExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  with ActiveEditor do
   CollectContentTable(Editor, 0, True, Editor.Selection.Collapsed);
end;

procedure TMainEditorForm.acMDIChildListExecute(Sender: TObject);
begin
 D_MDILst.Execute;
end;

procedure TMainEditorForm.acMDIChildListUpdate(Sender: TObject);
begin
 (Sender As TAction).Enabled := (MDIChildCount > 0);
end;

procedure TMainEditorForm.tsDocumentsChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
begin
 if (NewTab >= 0) then
  PostMessage(ClientHandle, wm_MDIActivate,
              WParam((tsDocuments.Tabs.Objects[NewTab] As TForm).Handle), 0);
end;

procedure TMainEditorForm.CloseMDIChild(Form: TForm);
  {-}
var
 l_Index : Long;
begin
 inherited;
 if (tsDocuments <> nil) then
  with tsDocuments do 
  begin
   l_Index := Tabs.IndexOfObject(Form);
   if (l_Index >= 0) then Tabs.Delete(l_Index);
   Visible := (Tabs.Count > 1);
  end;//with tsDocuments
end;

procedure TMainEditorForm.UpdateName(aEditor : TCustomForm; const aName: string);
  //override;
  {-}
var
 l_Index : Long;
begin
 inherited;
 if (tsDocuments <> nil) then
  with tsDocuments do 
  begin
   l_Index := Tabs.IndexOfObject(aEditor);
   if (l_Index >= 0) then Tabs[l_Index] := aName;
  end;//with tsDocuments
end;

procedure TMainEditorForm.DocBarInsert(const aDocName: string);
  //virtual;
  {-}
begin
 with tsDocuments do begin
  TabIndex := Tabs.AddObject(aDocName, ActiveEditor);
  Visible := (Tabs.Count > 1);
 end;//with tsDocuments
end;

procedure TMainEditorForm.UpdateMenuItems(Sender: TObject);
  //virtual;
  {-}
begin
 if (tsDocuments <> nil) then
  with tsDocuments do
   TabIndex := Tabs.IndexOfObject(ActiveEditor);
end;
  
procedure TMainEditorForm.FormCreate(Sender: TObject);
begin
 inherited;
 Screen.OnActiveFormChange := UpdateMenuItems;
end;

procedure TMainEditorForm.acDeleteAllDocumentPartsExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  evFacadeSub.evDeleteAllDocumentParts(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acSectionA2SizeExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).PaperSize := evd_psA2;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;

procedure TMainEditorForm.acSectionA1SizeExecute(Sender: TObject);
begin
 if (IevdSection(CurrentTarget) <> nil) then 
 begin
  IevdSection(CurrentTarget).PaperSize := evd_psA1;
  IevdSection(CurrentTarget) := nil;
 end;//IevdSection(CurrentTarget) <> nil
end;                                                         

procedure TMainEditorForm.acHideHyperlinksUpdate(Sender: TObject);
begin
 if CheckActiveEditor then                          
 begin
  (Sender As TAction).Enabled := True;
  (Sender As TAction).Checked := (ev_slHyperlinks in ActiveEditor.Editor.ExcludeSuper);
 end
 else
  (Sender As TAction).Enabled := False;
end;

procedure TMainEditorForm.acHideHyperlinksExecute(Sender: TObject);
begin
 if (ActiveEditor <> nil) then
  with ActiveEditor.Editor do
   if (ev_slHyperlinks in ExcludeSuper) then
    ExcludeSuper := ExcludeSuper - [ev_slHyperlinks]
   else
    ExcludeSuper := ExcludeSuper + [ev_slHyperlinks];
end;

procedure TMainEditorForm.acAutoCompleteSetupExecute(Sender: TObject);
var
 l_Dlg: TAutoCompleteCfgDlg;
begin
 l_Dlg := TAutoCompleteCfgDlg.Create(Self);
 try
  if l_Dlg.ShowModal = mrOK then
   AutoComplete.SaveToFile
  else
   AutoComplete.LoadFromFile;
 finally
  l3Free(l_Dlg);
 end;
end;

procedure TMainEditorForm.acAutoCompleteExecute(Sender: TObject);
begin
 AutoComplete.Apply(ActiveEditor.Editor);
end;

function TMainEditorForm.cnvANSI2OEM(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 m2XLTConvertBuff(B, L, Cm2XLTANSI2OEM);
 Result := True;
end;

function TMainEditorForm.cnvEng2Rus(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEMEng2Rus)
 else
  m2XLTConvertBuff(B, L, Cm2XLTANSIEng2Rus);
 Result := True;
end;

function TMainEditorForm.cnvLo2Up(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2Upper)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2Upper);
 Result := True;
end;

function TMainEditorForm.cnvLoUpSwap(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2SWAP)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2SWAP);
 Result := True;
end;

function TMainEditorForm.cnvOEM2ANSI(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 m2XLTConvertBuff(B, L, Cm2XLTOEM2ANSI);
 Result := True;
end;

function TMainEditorForm.cnvRus2Eng(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEMRus2Eng)
 else m2XLTConvertBuff(B, L, Cm2XLTANSIRus2Eng);
 Result := True;
end;

function TMainEditorForm.cnvUp2Lo(Sender: TObject; B: PAnsiChar; L,
  CharSet: Long): Boolean;
begin
 if (CharSet = CP_OEM) or (CharSet = CP_OEMLite) then
  m2XLTConvertBuff(B, L, Cm2XLTOEM2Lower)
 else m2XLTConvertBuff(B, L, Cm2XLTANSI2Lower);
 Result := True;
end;

procedure TMainEditorForm.acToolsCnvRusCharsetExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvEng2Rus); 
 end;
end;

procedure TMainEditorForm.acToolsCnvEngCharsetExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvRus2Eng); 
 end;
end;

procedure TMainEditorForm.acToolsCnvOEM2ANSIExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvOEM2ANSI); 
 end;
end;

procedure TMainEditorForm.acToolsCnvANSI2OEMExecute(Sender: TObject);
begin
 if CheckActiveEditor then 
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextConvert(cnvANSI2OEM); 
 end;
end;

procedure TMainEditorForm.acToolsCnvDate2TextExecute(Sender: TObject);
var
 l_Buff : array[0..30] of Byte;
begin
 if CheckActiveEditor then
 begin
  if not evCursorInSel(ActiveEditor.Editor) then
   Exit;
  ActiveEditor.Editor.TextBufConvert(Date2Text, @l_Buff);
 end;
end;

procedure TMainEditorForm.acToolsCnvMergeParaExecute(Sender: TObject);
begin
 Screen.Cursor := crHourGlass;
 try
  if CheckActiveEditor then
   ActiveEditor.Editor.Block2Para;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TMainEditorForm.acInsertFormulaExecute(Sender: TObject);
begin
 evInsertFormula(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acPrintPreviewExecute(Sender: TObject);
begin
 ActiveEditor.MakePreview;
end;

procedure TMainEditorForm.acAlignCellsBoundaryExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  EvAlignCellsBoundary(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acAjustColumnWidthExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  evTable_FixNSRCWidth(ActiveEditor.Editor.Range);
end;

procedure TMainEditorForm.acSetCellWidthExecute(Sender: TObject);
var
 l_CellWidth : Integer;
begin
 if CheckActiveEditor then
 begin
  l_CellWidth := 0;
  if RequestIntegerValue(l_CellWidth, Self,
    'Задание ширины ячеек', 'Ширина ячеек(в символах)') then
   evTable_FixNSRCWidth(ActiveEditor.Editor.Range, l_CellWidth);
 end;
end;

procedure TMainEditorForm.acHelpAboutExecute(Sender: TObject);
var
 l_AboutLite: TAboutBoxLite;
begin
 l_AboutLite := TAboutBoxLite.Create(nil);
 try
  l_AboutLite.ShowModal;
 finally
  l_AboutLite.Free;
 end;
end;

procedure TMainEditorForm.acDocInfoExecute(Sender: TObject);
begin
 with ActiveEditor do
 begin
  with TShowDocInfoDlg.Create(ActiveEditor) do
   try
    lblDocSize.Caption :=
     Format(lblDocSize.Caption, [evGetNettoCharCount(TextSource)]);
    ShowModal;
   finally
    Free;
   end;
 end; // with ActiveEditor do
end;

procedure TMainEditorForm.acJump2SubExecute(Sender: TObject);
begin
 with TIntegerEditDlg.Create(Self) do
  try
   Caption := 'Перейти на метку';
   LabelText := 'Номер метки';
   Value := IniRec^.SrchSubID;
   if Execute then
   begin
    if Value < 0 then Exit;
    with ActiveEditor do
     evGetSubList(TextSource).Sub[Value].Select(Editor.Selection);

    IniRec^.SrchSubID := Value;
   end;
  finally
   Free;
  end;
end;

function TMainEditorForm.Date2Text(Sender: TObject; var B: PAnsiChar; var L: Long;
  var CharSet: SmallInt; Data: Pointer): Boolean;
begin
 cnvDate2Text(B, L, Data);
end;

procedure TMainEditorForm.acFindTableExecute(Sender: TObject);
begin
 if ActiveEditor <> nil then
 begin
  try
   ActiveEditor.Editor.Find(TevFirstTableCellSearcher.Make, nil, []);
   ActiveEditor.Editor.DeleteFoundRgn;
  except
   on EevSearchFailed do
    vtMessageDlg(str_sidTableNotFound.AsCStr, mtInformation);
  end;
 end;
end;

procedure TMainEditorForm.acTblSetFrameExecute(Sender: TObject);
begin
 if ActiveEditor <> nil then
 begin
  if ActiveEditor.Editor.HasSelection then
  begin
   ActiveEditor.Editor.Find(TevTableTextSearcher.Make, TevTableCellFrameReplacer.Make(evd_fvSolid), [ev_soGlobal, ev_soSelText, ev_soUseInternalCursor, ev_soReplace, ev_soReplaceAll]);
   ActiveEditor.Editor.Modified := True;
  end
  else
   vtMessageDlg(str_sidNoTextSelection.AsCStr, mtError);
 end;
end;

procedure TMainEditorForm.acTblDelFrameExecute(Sender: TObject);
begin
 if ActiveEditor <> nil then
 begin
  if ActiveEditor.Editor.HasSelection then
  begin
   ActiveEditor.Editor.Find(TevTableTextSearcher.Make, TevTableCellFrameReplacer.Make(evd_fvEmpty), [ev_soGlobal, ev_soSelText, ev_soUseInternalCursor, ev_soReplace, ev_soReplaceAll]);
   ActiveEditor.Editor.Modified := True;
  end
  else
   vtMessageDlg(str_sidNoTextSelection.AsCStr, mtError);
 end;
end;

procedure TMainEditorForm.acCopyWidthsExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  EvCopyWidthOfCells(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acApplyWidthExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  EvApplyWidthOfCells(ActiveEditor.Editor);
end;

procedure TMainEditorForm.acApplyWidthUpdate(Sender: TObject);
begin
 (Sender As TAction).Enabled := CheckActiveEditor and TevCopyTableCellWidth.Instance.CanApply;
end;

procedure TMainEditorForm.acAACExecute(Sender: TObject);
begin
{$IFDEF AAC_Support}
 if CheckActiveEditor then
  TddAACForm.Execute(ActiveEditor.Editor);
{$ENDIF AAC_Support}
end;

procedure TMainEditorForm.acAACUpdate(Sender: TObject);
begin
{$IFDEF AAC_Support}
 (Sender As TAction).Enabled := CheckActiveEditor;
{$ELSE}
 (Sender As TAction).Visible := False;
{$ENDIF AAC_Support}
end;

procedure TMainEditorForm.acSetTextNonPrintableExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  ActiveEditor.Editor.SetVisibleEx(False);
end;

procedure TMainEditorForm.acSetTextPrintableExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  ActiveEditor.Editor.SetVisibleEx(True);
end;

procedure TMainEditorForm.acToolsSetSectionsExecute(Sender: TObject);
var
 l_Pack: InevOp;
 l_Filt: Tk2TagGenerator;
begin
 if CheckActiveEditor then
 begin
  l_Filt := TddSectionRepairFilter.Create;
  try
   TddSectionWithSub2ParaFilter.SetTo(l_Filt);
   l_Pack :=  ActiveEditor.Editor.StartOp(ev_ocUser + 111);
   try
    evRangeInsertFrom( ActiveEditor.Editor, l_Filt);
   finally
    l_Pack := nil;
   end;
  finally
   FreeAndNil(l_Filt);
  end;
 end;
end;

function TMainEditorForm.CheckActiveEditor: Boolean;
begin
 Result := (ActiveEditor <> nil) and (ActiveEditor.Editor <> nil);
end;

function TMainEditorForm.SetSubPrim(aSubType: TSubType): Integer;
var
 l_Change  : Boolean;
 l_SubParam: TevSetSubParam;
begin
 l_SubParam.rEditor := ActiveEditor.Editor;
 l_SubParam.rSubType := aSubType;
 l_SubParam.rCodePage := CP_ANSI;
 l_SubParam.rAutoMode := False;
 l_SubParam.rWithConfirm := True;
 l_SubParam.rSubNumFormula := '';
 l_SubParam.rUserType := utNone;
 l_SubParam.rCanStylizeBlocks := True;
 Result := evSetSubPrim(l_SubParam, l_Change, nil);
end;

procedure TMainEditorForm.acInsertSubExecute(Sender: TObject);
begin
 if CheckActiveEditor then
  SetSubPrim(stSub);
end;

end.
