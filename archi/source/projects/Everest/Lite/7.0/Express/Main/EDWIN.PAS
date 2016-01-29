unit EdWin;
{ $Id: EDWIN.PAS,v 1.16 2014/05/05 05:31:00 dinishev Exp $ }

// $Log: EDWIN.PAS,v $
// Revision 1.16  2014/05/05 05:31:00  dinishev
// Bug fix: не собиралось.
//
// Revision 1.15  2014/04/30 13:11:38  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.14  2014/04/11 15:35:17  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.13  2014/04/11 05:56:57  dinishev
// Bug fix: не собирался Эверест.
//
// Revision 1.12  2014/04/09 08:59:59  dinishev
// Bug fix; не собирался Эверест.
//
// Revision 1.11  2014/03/13 09:54:08  dinishev
// Preview tests
//
// Revision 1.10  2014/02/21 13:09:17  dinishev
// "Скрытый" Preview в Арчи.
//
// Revision 1.9  2014/02/17 09:10:20  dinishev
// Убрал компонент TextSource с формы - теперь он создается в FormCreate.
//
// Revision 1.8  2014/01/29 12:20:20  dinishev
// {Requestlink:514874341}
//
// Revision 1.7  2014/01/29 11:28:11  dinishev
// {Requestlink:514874360}
//
// Revision 1.6  2013/10/21 15:42:18  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:30:04  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2013/07/01 12:59:06  dinishev
// Недокоммичено.
//
// Revision 1.3  2013/04/30 08:37:50  dinishev
// {Requestlink:453149163}
//
// Revision 1.2  2013/04/04 07:25:51  dinishev
// Поддержка Style 52 в Эвересте.
//
// Revision 1.1  2013/03/18 08:50:50  dinishev
// {Requestlink:437519030}. Тесты.
//
// Revision 1.169  2013/02/27 13:49:32  dinishev
// {Requestlink:431386215}. Еще один тест + начало обоощения тестов Арчи и Эвереста.
//
// Revision 1.168  2013/02/07 06:37:44  dinishev
// Bug fix: не применяли фильтры для таблиц при чтении из NSR
//
// Revision 1.167  2013/01/23 08:09:36  kostitsin
// не собиралось
//
// Revision 1.166  2012/12/04 09:28:41  lulin
// [$412186608]
//
// Revision 1.165  2012/10/30 10:46:21  dinishev
// Недокоммичено.
//
// Revision 1.164  2012/10/29 16:55:37  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.163  2012/08/15 13:17:39  dinishev
// {Requestlink:384434990}
//
// Revision 1.162  2012/08/10 13:36:5  dinishev
// {Requestlink:382417737}
//
// Revision 1.161  2012/08/08 12:32:04  dinishev
// Cleanup
//
// Revision 1.160  2012/06/07 13:26:49  lulin
// {RequestLink:370389917}
//
// Revision 1.159  2011/12/05 12:11:00  lulin
// {RequestLink:313753938}
//
// Revision 1.158  2011/10/10 07:18:51  dinishev
// Bug fix: не компилировался Эверест с веткой.
//
// Revision 1.157  2011/09/01 10:33:41  dinishev
// Bug fix: не собирался EverestLite
//
// Revision 1.156  2011/08/31 13:55:56  dinishev
// [$280859299]
//
// Revision 1.155  2011/08/30 17:08:02  lulin
// {RequestLink:280006084}.
//
// Revision 1.154  2011/08/15 07:07:36  dinishev
// [$235876114]
//
// Revision 1.153  2011/07/19 10:35:57  dinishev
// [$271754380]
//
// Revision 1.152  2011/06/29 10:35:13  dinishev
// Bug fix: не компилировалось.
//
// Revision 1.151  2011/05/21 06:20:52  dinishev
// Bug fix: не компилировался Эверест.
//
// Revision 1.150  2011/04/04 17:04:03  lulin
// {RequestLink:259175088}.
//
// Revision 1.149  2011/02/22 12:14:50  lulin
// {RequestLink:254941681}.
//
// Revision 1.148  2011/02/17 07:23:46  dinishev
// [$254351028]
//
// Revision 1.147  2011/02/08 10:13:16  dinishev
// [$252524029]
//
// Revision 1.146  2011/02/03 15:16:55  dinishev
// [$252524029]
//
// Revision 1.145  2011/01/21 16:17:37  dinishev
// [$185830965]
//
// Revision 1.144  2010/09/29 09:14:34  lulin
// {RequestLink:234360788}.
//
// Revision 1.143  2010/07/15 10:55:56  fireton
// - переделка под новую орфографию
//
// Revision 1.142  2010/07/01 09:20:01  dinishev
// Вычищаем заплатку для [$156370173]
//
// Revision 1.141  2010/02/12 11:21:21  dinishev
// Не падаем при закрытии редактора в Preview
//
// Revision 1.140  2009/08/11 12:47:48  dinishev
// Возвращаем фильтры на место.
//
// Revision 1.139  2009/08/07 09:28:08  lulin
// {RequestLink:159353531}.
//
// Revision 1.138  2009/07/14 14:51:39  dinishev
// Теперь действительно выключаем мультивыделение для EverestLite.
//
// Revision 1.137  2009/07/14 14:38:32  dinishev
// Выключаем мультивыделение: http://mdp.garant.ru/pages/viewpage.action?pageId=156370173&focusedCommentId=156927154#comment-156927154
//
// Revision 1.136  2009/07/02 09:38:53  dinishev
// [$155026370]
//
// Revision 1.135  2009/07/02 07:48:48  dinishev
// [$155026370]
//
// Revision 1.134  2009/06/30 10:00:13  dinishev
// Фильтр для строк, состоящих только из продолжений объединенных ячеек сверху.
//
// Revision 1.133  2009/06/02 13:47:40  lulin
// [$148574526].
//
// Revision 1.132  2009/06/01 17:38:19  lulin
// [$148574348].
//
// Revision 1.131  2009/06/01 16:07:43  lulin
// [$148574348].
//
// Revision 1.130  2009/04/28 12:41:27  dinishev
// Bug fix: Integer overflow
//
// Revision 1.129  2009/04/16 12:38:20  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=143396720&focusedCommentId=144147492#comment-144147492
//
// Revision 1.128  2009/04/08 11:45:29  lulin
// [$140287160]. Bug fix: не собирался Эверест.
//
// Revision 1.127  2009/04/08 11:32:13  oman
// - new: В _JumpTo подаем не состояние мыши а желаемое поведение - [$140287160]
//
// Revision 1.126  2009/04/07 16:40:53  lulin
// [$140837386]. №13. Не собирался Архивариус.
//
// Revision 1.125  2009/03/06 07:55:07  dinishev
// CleanUp
//
// Revision 1.124  2009/03/04 14:17:44  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.123  2009/02/03 13:56:46  dinishev
// По просьбе трудящихся делаем колонтитулы ближе к Арчи
//
// Revision 1.122  2009/01/26 08:00:02  dinishev
// Поднимаем диалог печати
//
// Revision 1.121  2009/01/23 13:52:28  dinishev
// <K> : 135602523
//
// Revision 1.120  2008/12/24 14:38:30  dinishev
// CleanUp
//
// Revision 1.119  2008/11/19 12:37:29  dinishev
// Bug fix: не забываем закрыть окно поиска при закрытии документа
//
// Revision 1.118  2008/11/14 08:13:24  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=121156019&focusedCommentId=122675450#comment-122675450
//
// Revision 1.117  2008/11/13 13:10:32  dinishev
// <K> : 121156019
//
// Revision 1.116  2008/10/28 10:14:17  dinishev
// <K> : 121156019
//
// Revision 1.115  2008/10/28 09:52:09  dinishev
// <K> : 121156019
//
// Revision 1.114  2008/10/13 13:38:20  dinishev
// <K> : 84640081
//
// Revision 1.113  2008/10/09 11:36:12  dinishev
// Cleanup
//
// Revision 1.112  2008/10/09 07:55:02  dinishev
// <K> : 84640081
//
// Revision 1.111  2008/10/01 11:13:28  lulin
// - <K>: 120718563.
//
// Revision 1.110  2008/06/06 07:05:46  lulin
// - собираем без SSE.
//
// Revision 1.109  2008/05/20 10:52:03  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.108  2008/05/08 10:53:12  dinishev
// Bug fix: непоказывался диалог "Граница/заливки"
//
// Revision 1.107  2008/04/16 08:40:39  lulin
// - выделяем фасад для скрытия различий старого и нового редакторов.
//
// Revision 1.106  2008/04/15 17:36:12  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.105  2008/04/14 07:04:17  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.104  2008/03/12 14:43:11  dinishev
// Восстанавливаем потерянные обработчики
//
// Revision 1.103  2007/12/26 00:16:32  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.102  2007/12/24 15:25:12  lulin
// - удалены ненужные файлы.
//
// Revision 1.101  2007/12/05 13:51:23  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.93.2.9  2007/09/25 12:19:00  lulin
// - по двойному щелчку мыши по формуле поднимаем диалог редактирования формул.
//
// Revision 1.93.2.8  2007/09/12 19:11:26  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.93.2.7  2007/03/27 08:00:35  dinishev
// Bug fix: не собирался Everest в ветке
//
// Revision 1.93.2.6  2007/01/19 16:24:06  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.93.2.5  2006/12/21 16:20:50  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.93.2.4  2006/02/08 14:47:48  lulin
// - собрал Everest в ветке.
//
// Revision 1.93.2.3  2006/02/08 14:25:07  lulin
// - собрал Everest в ветке.
//
// Revision 1.93.2.2  2006/02/08 14:08:24  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.93.2.1  2006/02/07 15:15:56  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.93  2006/01/10 08:42:10  lulin
// - не компилировался Эверест.
//
// Revision 1.92  2005/10/06 09:37:19  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.91  2005/05/27 14:44:23  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.90  2005/05/26 17:49:36  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.89  2005/05/24 14:53:15  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.88  2005/05/20 11:30:29  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.87  2005/04/26 08:43:29  lulin
// - bug fix: не компилировалось.
//
// Revision 1.86  2005/04/25 13:21:21  lulin
// - new build.
//
// Revision 1.85  2005/03/24 12:40:29  lulin
// - remove method: Ik2TagBox.Tag.
// - new method: Ik2TagBox.Target.
//
// Revision 1.84  2005/03/17 10:39:56  lulin
// - bug fix: не компилировалось.
//
// Revision 1.83  2005/03/16 15:19:51  lulin
// - bug fix: неправильно формировалось имя для документа с поддокументами.
//
// Revision 1.82  2005/03/03 17:30:32  lulin
// - в Эвересте теперь есть возможность задания типа вновь создаваемого файла.
//
// Revision 1.81  2005/01/12 15:00:02  dinishev
// Поддержка True-колорных иконок
//
// Revision 1.80  2004/12/29 16:37:40  lulin
// - remove prop: TevCustomEditor.HAFPainter.
//
// Revision 1.79  2004/12/23 11:16:11  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.78  2004/12/17 10:28:19  dinishev
// новые иконки
//
// Revision 1.77  2004/12/17 08:36:16  dinishev
// обработчик события получения картинок для кнопок
//
// Revision 1.76  2004/11/15 17:32:20  lulin
// - добавил в Эверест пример передачи дерева контролу.
//
// Revision 1.75  2004/10/18 16:27:51  lulin
// - remove unit: evTagTools.
//
// Revision 1.74  2004/09/21 10:32:31  lulin
// - bug fix: не компилировалось.
//
// Revision 1.73  2004/09/08 15:52:35  lulin
// - восстановлена возможность мультивыделения.
//
// Revision 1.72  2004/09/08 09:42:29  lulin
// - временно отключил множественное выделение.
//
// Revision 1.71  2004/09/06 16:10:12  law
// - new behavior: включено мультивыделение и выключены директивы слежения.
//
// Revision 1.70  2004/07/29 15:56:41  law
// - изменения в связи с изменением сигнатуры события.
//
// Revision 1.69  2004/05/26 17:01:50  law
// - new behavior: TvtCustomOutliner теперь знает только про интерфейсы Il3SimpleTree и Il3Tree, а не про объект Tl3Tree.
//
// Revision 1.68  2004/03/15 14:22:41  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.67  2003/10/14 16:36:21  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.66  2003/10/13 15:06:36  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.65  2003/07/29 08:17:57  law
// no message
//
// Revision 1.64  2003/01/15 15:23:52  law
// no message
//
// Revision 1.63  2002/11/01 16:55:51  law
// - move unit: D_Undo переехал в Common.
//
// Revision 1.62  2002/10/28 12:41:44  law
// - new behavior: возможность редактирования ссылок на тот же документ, где эта ссылка стоит.
//
// Revision 1.61  2002/10/08 08:42:50  law
// - change: обработкой локальных ссылок теперь занимается окно редактора.
//
// Revision 1.60  2002/07/17 13:38:59  law
// - some refactoring.
//
// Revision 1.59  2002/07/17 13:06:37  law
// - some refactoring.
//
// Revision 1.58  2002/07/17 12:11:27  law
// - some refactoring.
//
// Revision 1.57  2002/07/16 17:27:11  law
// - some refactoring.
//
// Revision 1.56  2002/07/16 15:45:47  law
// - some refactoring.
//
// Revision 1.55  2002/07/15 14:27:53  law
// no message
//
// Revision 1.54  2002/07/09 13:57:49  law
// - new unit: evMsgCode.
//
// Revision 1.53  2002/07/09 12:11:57  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.52  2002/04/06 11:33:44  law
// - Delphi 6.0.
//
// Revision 1.51.2.10  2002/04/06 11:25:11  law
// - cleanup & bugfix.
//
// Revision 1.51.2.9  2002/02/08 13:30:19  law
// - cleanup.
//
// Revision 1.51.2.8  2002/02/07 15:23:02  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.51.2.7  2002/01/08 08:11:47  law
// - cleanup: убрано использование agOpenDialog.
//
// Revision 1.51.2.6  2002/01/03 14:20:11  law
// - some cosmetics.
//
// Revision 1.51.2.5  2001/12/18 14:13:48  law
// - new unit: evSaveDocumentManager.
//
// Revision 1.51.2.4  2001/10/03 06:29:33  law
// - new project: EverestLite 2001.
//
// Revision 1.51.2.3  2001/10/02 12:32:15  law
// - new units: MainMDI и MainMDIEx - в них вынесена часть функциональности с основной формы.
//
// Revision 1.51.2.2  2001/09/21 09:59:47  law
// - cleanup.
//
// Revision 1.51.2.1  2001/09/20 14:24:58  law
// - new behavior: сделана возможность открытия/закрытия блоков определенного уровня.
//
// Revision 1.51  2001/09/14 09:45:34  law
// - change: W95Meter -> vtW95Meter.
//
// Revision 1.50  2001/08/29 07:01:42  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.49  2001/06/08 13:31:53  law
// - bu fix: убрана ссылка на удаленный модуль D_Paste.
//
// Revision 1.48  2001/06/08 13:20:32  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.47  2001/06/08 12:09:53  law
// - new behavior: сделана "расширенная" обработка операций.
//
// Revision 1.46  2001/06/06 08:54:46  law
// - change interface: IevSub.
//
// Revision 1.45  2001/06/05 15:26*15  law
// - new behavior: сделано объединение соседних блоков.
//
// Revision 1.44  2001/05/23 14:00:45  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.43  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.42  2001/04/20 14:04:10  law
// - cleanup: def_cm* => def_inch*, evCm2Pixel -> evCm2Inch.
//
// Revision 1.41  2001/04/19 13:02:47  law
// - new behavior: сделана печать широких страниц.
//
// Revision 1.40  2001/04/16 11:45:32  law
// - new props: к параметрам раздела добавлена высота и ширина бумаги (A0..A5).
//
// Revision 1.39  2001/04/13 13:53:37  law
// - cleanup.
//
// Revision 1.38  2001/04/12 15:32:04  law
// - new behavior: сделана обработка формата cf_hDrop.
//
// Revision 1.37  2001/03/30 13:58:56  law
// no message
//
// Revision 1.36  2001/02/21 14:26:40  law
// - убраны ненужные ссылки на модуль vbSpin.
//
// Revision 1.35  2001/02/21 12:58:23  law
// - удалены ненужные панели и элементы.
//
// Revision 1.34  2001/01/16 12:12:20  law
// - добавлен формат RTFLite.
//
// Revision 1.33  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

{$Include Everest.inc}

uses
  SysUtils, 
  WinTypes, 
  WinProcs, 
  Messages, 
  Classes, 
  Graphics, 
  Controls,
  Forms, 
  Dialogs, 
  Buttons, 
  ExtCtrls,
  ComCtrls, 
  ImgList,
  Menus,    
  
  l3Types,
  l3Base,   
  l3Interfaces,
  l3InternalInterfaces, 
  l3Units,
  l3InterfacedComponent,
  l3ProgressComponent,
  l3Forms,
  l3TreeInterfaces,
  
  afwInterfaces,
  afwNavigation,

  RXSplit,

  k2TagGen,
  k2Base,
  k2Reader,
  k2DocumentGenerator,

  evConst,
  evOpProc,
  evRuler,  
  evTextSource, 
  evEditorWindow,  
  OvcBase, 
  evEditor,
  W95Meter, 
  evTypes,  
  StdCtrls, 
  evSubPn, 
  evToolPanel,
  evLinkedToolPanel,
  evInternalInterfaces,
  evEditorInterfaces,
  evMenu,
  
  nevTools,
  nevBase,

  vtLister,
  vtOutliner, evEditorWindowTextSource,
  afwInputControl, afwControl, vtPanel, evMultiSelectEditorWindow,
  evCustomEditor, evEditorWithOperations, evTunedEditor, evCustomTextSource,

  {$IfDef evUndoBrowser}
  D_Undo,
  {$EndIf evUndoBrowser}
  PreviewFormUnit,

  evTextSourcePublished, afwTextControlPrim, afwTextControl,
  afwControlPrim, afwBaseControl, nevControl,

  arCommonTypes,

  k2Interfaces, evCustomEditorWindowModelPart, evCustomEditorWindowPrim,
  evCustomEditorModelPart, l3WinControlCanvas, evCustomEditorWindow,
  vtPanelPrim
  ;

type
  TEditorWindow = class(Tl3Form, IevMonikerSink, Il3ActionProcessor, IevClearPreviewLink)
    FooterPanel: TPanel;
    pnMeter: TPanel;
    pnModified: TPanel;
    pnHScrollBar: TPanel;
    pnStatus: TPanel;
    pmUnits: TPopupMenu;
    miInch: TMenuItem;
    miCm: TMenuItem;
    miChar: TMenuItem;
    miPixel: TMenuItem;
    W95Meter: TvtW95Meter;
    sbUndoContents: TSpeedButton;
    pnEditors: TPanel;
    pnEditor1: TPanel;
    Editor1: TevEditor;
    VRuler1: TevRuler;
    VSubPanel1: TevSubPanel;
    splEditor1: TRxSplitter;
    HRuler1: TevRuler;
    pnEditor2: TPanel;
    Editor2: TevEditor;
    VRuler2: TevRuler;
    VSubPanel2: TevSubPanel;
    splEditor2: TRxSplitter;
    HRuler2: TevRuler;
    splEditors: TRxSplitter;
    splExplorer: TRxSplitter;
    outExplorer: TvtOutliner;
    pnPos: TPanel;
    pnToolbar: TPanel;
    cbParts: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Editor1FontChange(Sender: TObject; const Font: Il3Font);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Editor1StyleChange(Sender: TObject; const Style: IedStyle);
    procedure TextSourceChangeModified(Sender: TObject);
    procedure TextSourceAllowGotoSub(Sender: TObject; const aPoint: IevDocumentPoint);
    procedure Editor1ZoomChange(Sender: TObject);
    procedure VSubPanel1MenuSub(Sender: TObject; const Pt: Tl3SPoint; const R: Tl3SRect;
      SubType, SubHandle: Longint);
    procedure miUnitsClick(Sender: TObject);
    procedure TextSourceIOProcessChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VSubPanel1Resize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function  Editor1ReplaceConfirm(Sender: TObject; const Block: InevRange): Shortint;
    procedure sbUndoContentsClick(Sender: TObject);
    procedure Editor2Enter(Sender: TObject);
    procedure VSubPanel2Resize(Sender: TObject);
    procedure pmUnitsPopup(Sender: TObject);
    procedure splEditorsPosChanged(Sender: TObject);
    procedure cbPartsChange(Sender: TObject);
    procedure HRuler2DblClick(Sender: TObject);
    procedure HRuler1DblClick(Sender: TObject);
    procedure outExplorerActionElement(Sender: TObject; Index: Longint);
    function  TextSourceFinishAtom(G: Tk2DocumentGenerator;
      var Atom: Tk2StackAtom): Boolean;
    procedure TextSourceEditorWindowProcessorBruttoCharCountChange(
      Sender: TObject);
    procedure TextSourceEditorWindowProcessorReadOnlyChange(
      Sender: TObject);
    procedure miDeleteBlockClick(Sender: TObject);
    function outExplorerGetItemImage(Sender: TObject;
      Index: Integer; var aImages : TCustomImageList): Integer;
    function Editor1GetMonikerSink(Sender: TObject;
      out theMonikerSink: IevMonikerSink): Boolean;
    procedure W95MeterSetStr(const aStr: string);
    procedure miGotoSubClick(Sender: TObject);
    procedure miExplorerSubPropertiesClick(Sender: TObject);
    function TextSourceGetControlData(aSander: TObject;
      const aControl: IevControl): IInterface;
    procedure TextSourceGetControlItemImg(aSender   : TObject;
                                        const aControl   : TnevControlInfo;
                                        out theImageInfo : TnevControlImageInfo);
    procedure VSubPanel2ClickSub(Sender: TObject; SubType,
      SubHandle: Integer; aKind: TafwClickKind);
    procedure TextSourceTextParaCountChange(Sender: TObject);
    procedure TextSourceNettoCharCountChange(Sender: TObject);
    procedure TextSourceTOCCreated(aSender: TObject;
      const aTOC: Il3SimpleTree);
    procedure outExplorerGetItemFont(Sender: TObject; Index: Integer;
      const aFont: Il3Font);
    procedure TextSourceGetReader(Sender: TObject; aFormat: Cardinal;
      var Reader: Tk2CustomReader);
  private
    { Private declarations }
    {$IfDef evUndoBrowser}
    f_UndoContents : TUndoContentsForm;
    {$EndIf evUndoBrowser}
    f_DocInfo      : TevDocInfo;
    f_TreeWasInit  : Boolean;
    f_Preview      : TPreviewForm;
     {-}
    f_TextSource   : TevTextSource;
  private
  {property methods}
    function  pm_GetEditor: TevEditor;
      {-}
  private
  {interface methods}
    {IevPropertySink}
    function JumpTo(anEffects : TafwJumpToEffects;
                    const aMoniker : IevMoniker): Bool;
      {-}
  private
  {internal methods}
    procedure WMSize(var M: TMessage);
      message WM_Size;
      {-}
    procedure UpdateDocInfo;
      {-}
    procedure CursorChange(Sender: TObject);
      {-}
   procedure MakeMacroReplacer(Sender: TObject; var aReplacer: IafwHAFMacroReplacer);
      {-}
   procedure InitScrollBar;
      {-}   
  protected
   procedure Cleanup;
     override;
     {-}
  public
  {public methods}
    function IsPreviewInProgress: Boolean;
      {-}
    function IsNeedSaveDocument: Boolean;
      {-}
    procedure MakePreview;
      {-}
    procedure ClearPreview;
      {-}
    procedure GotoSub(const aSub: IevSub);
      {-}
    procedure NewHyperlink;
      {-}
    procedure DeleteCurrentSub;
      {-}
    // Il3ActionProcessor
    function Process(Sender : TObject; 
                     Target : TObject;
                     Action : Long; 
                     Down   : Bool): Bool;
      {-}
  public
  {public properties}
    property Editor: TevEditor
      read pm_GetEditor;
      {-}
    property TextSource: TevTextSource read f_TextSource;
     {-} 
  end;

implementation

{$R *.DFM}

uses
  TypInfo,
  IniShop,
  ShellAPI,

  D_RepCon,

  l3Bits,
  l3Tree,
  l3Chars,
  l3Const,
  l3Nodes,
  l3String,
  l3Variant,
  l3Tree_TLB,
  l3ImageList,

  vtUtils,
  vtDialogs,
  vtScrollBar,

  k2Tags,
  k2Except,

  evPictureReader,

  evCommonUtils,
  evCommonRes,

  evDef,
  evSBSPar,
  evMsgCode,
  evMenuMisc,
  evFacadeSub,
  evStandardActions,
  evFacadTextSource,
  evFacadeCursor,
  evFacadeGUI,
  evContentsTree,
  evTableFilter,
  evdEmptyRowFilter,
  nevNavigation,
  //evUnicodeConvertFilter,

  arConst,
  evTabStopsFilter,
  evMergedCellFilter,
  evContentsTreeWaiter,
  evEverestMacroReplacer,
  evTextInTableCorrector,
  evEverestDocumentContainerWithContentsTree,

  D_TxSrch,

  MainEditor,
  {$IFNDEF EverestLite}
  dmStdRes,
  {$ENDIF EverestLite}
  dmControlRes,
  DocumentRes,

  {$IfDef evSpellChecker}
  D_Spell,
  {$EndIf evSpellChecker}

  Document_Const,
  BitmapPara_Const,
  Block_Const,
  TextPara_Const,
  ControlPara_Const,
  
  evStrictContentsElementEliminator
  ;

procedure TEditorWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if TextSource.CloseQuery(Handle) then
 begin
  Action := caFree;
  if f_Preview <> nil then
   f_Preview.Close;
 end
 else
  Action := caNone;
end;

procedure TEditorWindow.Editor1FontChange(Sender: TObject; const Font: Il3Font);
begin
 MainForm.EditorWindowFontChange(Font);
end;

procedure TEditorWindow.FormActivate(Sender: TObject);
begin
 MainForm.ActiveEditor := Self;
 {$IfDef evSpellChecker}
 TSpellCheckDlg.CloseSpellCheck;
 {$EndIf evSpellChecker}
end;

procedure TEditorWindow.FormDestroy(Sender: TObject);
begin
 with MainForm do 
 begin
  if (ActiveEditor = Self) then 
   ActiveEditor := nil;
  CloseMDIChild(Self);
 end;//with MainForm
end;

procedure TEditorWindow.Editor1StyleChange(Sender: TObject; const Style: IedStyle);
begin
 MainForm.EditorWindowStyleChange(Style.Name)
end;

procedure TEditorWindow.TextSourceChangeModified(Sender: TObject);
begin
 if TextSource.Modified then
  pnModified.Caption := '*'
 else
  pnModified.Caption := ' ';
end;

procedure TEditorWindow.TextSourceAllowGotoSub(Sender: TObject;
  const aPoint: IevDocumentPoint);
var
 l_Sub : IevSub;  
begin
 if Supports(aPoint, IevSub, l_Sub) then
  try
   GotoSub(l_Sub);
  finally
   l_Sub := nil;
  end;//try..finally
end;

procedure TEditorWindow.Editor1ZoomChange(Sender: TObject);
begin
 if (Editor <> nil) then
 begin
  MainForm.EditorWindowZoomChange(Editor.Canvas.Zoom);
  if (IniRec <> nil) then
   IniRec^.Zoom := Editor.Zoom;
 end;
end;

procedure TEditorWindow.VSubPanel1MenuSub(Sender: TObject; const Pt: Tl3SPoint; const R: Tl3SRect;
  SubType, SubHandle: Longint);
begin
 MainForm.ShowSubMenu(evGetSubList(TextSource).SubEx[SubHandle, SubType], Pt, Sender as TComponent);
end;

procedure TEditorWindow.miUnitsClick(Sender: TObject);
var
 l_Str : string;
begin
 l_Str := TComponent(Sender).Name;
 l_Str := 'ev_un' + Copy(l_Str, 3, Length(l_Str) - 2);
 TevRuler(TPopupMenu(TMenuItem(Sender).Parent.Owner).PopupComponent).Units :=
  TevUnits(GetEnumValue(TypeInfo(TevUnits), l_Str));
end;

procedure TEditorWindow.VSubPanel1Resize(Sender: TObject);
begin
 if (IniRec <> nil) then 
  IniRec^.SubPanelWidth1 := VSubPanel1.Width;
end;

procedure TEditorWindow.TextSourceIOProcessChange(Sender: TObject);
begin
 if not TextSource.Indicator.InIO then 
 begin
  UpdateDocInfo;
  pnToolbar.Visible := (TextSource.PartCount > 1);
  if pnToolbar.Visible then
   cbParts.ItemIndex := 0;
 end;{not TextSource.IOProcess}
end;

procedure TEditorWindow.FormCreate(Sender: TObject);
begin
 if IniRec^.MaxEditor then
  WindowState := wsMaximized;
 outExplorer.Width := 1;
 outExplorer.OnContextPopup := MainForm.DoExplorerContextPopup;
 f_TreeWasInit := False;
 {$IfNDef evUndoBrowser}
 sbUndoContents.Visible := False;
 {$EndIf  evUndoBrowser}
 pnEditor2.Height := 0;
 if (IniRec <> nil) then 
 begin
  Editor1.HRuler.Visible := IniRec^.ShowHRuler1;
  Editor2.HRuler.Visible := IniRec^.ShowHRuler2;
  Editor1.VRuler.Visible := IniRec^.ShowVRuler1;
  Editor2.VRuler.Visible := IniRec^.ShowVRuler2;
  VSubPanel1.Width := IniRec^.SubPanelWidth1;
  VSubPanel2.Width := IniRec^.SubPanelWidth2;
  VSubPanel1.Visible := IniRec^.ShowSubPanel1;
  VSubPanel2.Visible := IniRec^.ShowSubPanel2;
  Editor.Zoom := IniRec^.Zoom;
 end;

 // Переехало из из dfm
 f_TextSource := TevTextSource.Create;
 with f_TextSource do
 begin
  Indicator.NeedProgressProc := True;
  Indicator.Meter := W95Meter;
  Indicator.OnIOProcessChange := TextSourceIOProcessChange;
  OnChangeModified := TextSourceChangeModified;
  OnGetReader := TextSourceGetReader;
  OnGetControlData := TextSourceGetControlData;
  OnBruttoCharCountChange := TextSourceEditorWindowProcessorBruttoCharCountChange;
 end; // with f_TextSource do

 Editor1.AllowMultiSelect := True;
 Editor2.AllowMultiSelect := True;
 Editor1.OnMouseAction := MainForm.MouseAction;
 Editor1.TextSource := f_TextSource;
 Editor2.TextSource := f_TextSource;
 Editor2.OnMouseAction := MainForm.MouseAction;
 Editor1.OnGetHotSpotInfo := MainForm.GetHotSpotInfo;
 Editor2.OnGetHotSpotInfo := MainForm.GetHotSpotInfo;
 Editor1.OnContextPopup := MainForm.DoContextPopup;
 Editor2.OnContextPopup := MainForm.DoContextPopup;
 Editor1.OnCursorChange := CursorChange;
 Editor2.OnCursorChange := CursorChange;

 //Editor1.AACLike := nev_aacLeft;
 //Editor2.AACLike := nev_aacLeft;

 TextSource.OnGetControlItemImg := TextSourceGetControlItemImg;

 TextSource.DocumentContainer := TevEverestDocumentContainerWithContentsTree.Make;
 Editor1.OnMakeMacroReplacer := MakeMacroReplacer;
 Editor2.OnMakeMacroReplacer := MakeMacroReplacer;
 TextSource.OnNettoCharCountChange := TextSourceNettoCharCountChange;
 TextSource.OnTextParaCountChange := TextSourceTextParaCountChange;
 TextSource.OnTOCCreated := TextSourceTOCCreated;
 TextSource.PrintDialog := MainForm.PrintDialog;
 TextSource.DocumentContainer.LinkWaiter(TevContentsTreeWaiter.Make(Editor1));
 InitScrollBar;
end;

procedure TEditorWindow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 l_Handle    : THandle;
 l_DlgResult : Integer;
begin
 if MainForm.Terminating then 
  l_Handle := MainForm.Handle 
 else 
  l_Handle := Handle;

 {$IfDef evSpellChecker}
 if TSpellCheckDlg.IsSpellCheckInProgress then
 begin
  TSpellCheckDlg.InterruptSpellCheck(l_Handle);
  Exit;
 end;
 {$EndIf evSpellChecker}

 if not TextSource.CloseQuery(l_Handle) then
 begin
  CanClose := False;
  Exit;
 end;

 CanClose := True;
 if TextSource.Modified AND IniShop.IniRec^.Confirmations.AskDocumentSave then
 begin
  l_DlgResult := vtMessageDlg(l3Fmt(str_sidSaveAsk.AsCStr, [Caption]), mtWarning, mbYesNoCancel);
  case l_DlgResult of
   mrYes    : MainForm.SaveToFile(Self);
   mrCancel : CanClose := False;
  end;{case}
 end; // if TextSource.Modified AND IniShop.IniRec^.Confirmations.AskDocumentSave then
end;

procedure TEditorWindow.WMSize(var M: TMessage);
  {message WM_Size;}
  {-}
begin
 if not (csReading in ComponentState) then
  IniRec^.MaxEditor := (M.wParam = SIZE_MAXIMIZED);
 inherited;
end;

procedure TEditorWindow.UpdateDocInfo;
  {-}
var
 l_Str : string;
begin
 if not (csDestroying in ComponentState) then 
 begin
  if not TextSource.Indicator.InIO then  
   with f_DocInfo do 
   begin
    l_Str := Format('| %d/%d символов | %d параграфов',
                    [NettoCharCount, BruttoCharCount, TextParaCount]);
    if ReadOnly then
     pnStatus.Caption := 'Чтение ' + l_Str
    else
     pnStatus.Caption := 'Редактирование ' + l_Str;
   end;
 end;//not (csDestroying in ComponentState)
end;

function TEditorWindow.Editor1ReplaceConfirm(Sender: TObject; const Block: InevRange): Shortint;
begin
 Result := (Sender as TevEditor).AdjustForm2Found(ReplaceConfirmDlg).ShowModal;
end;

procedure TEditorWindow.sbUndoContentsClick(Sender: TObject);
begin
 {$IfDef evUndoBrowser}
 if (f_UndoContents = nil) then 
  f_UndoContents := TUndoContentsForm.Make(Self, TextSource.Processor);
 if (f_UndoContents.WindowState = wsMinimized) then
  f_UndoContents.WindowState := wsNormal
 else 
  if f_UndoContents.Visible then
   f_UndoContents.Hide
  else
   f_UndoContents.Show;
 {$EndIf evUndoBrowser}
end;

procedure TEditorWindow.Editor2Enter(Sender: TObject);
begin
 if (Sender is TevEditor) then
  MainForm.CheckEditorProperties(TevEditor(Sender));
end;

function TEditorWindow.pm_GetEditor: TevEditor;
  {-}
begin
 if (ActiveControl = Editor2) then
  Result := Editor2
 else
  Result := Editor1;
end;

procedure TEditorWindow.VSubPanel2Resize(Sender: TObject);
begin
 if (IniRec <> nil) then 
  IniRec^.SubPanelWidth2 := VSubPanel2.Width;
end;

procedure TEditorWindow.pmUnitsPopup(Sender: TObject);
var
 l_Str : string;
begin
 if (Sender is TPopupMenu) then 
 begin
  if (TPopupMenu(Sender).PopupComponent is TevRuler) then 
  begin
   l_Str := GetEnumName(TypeInfo(TevUnits), Ord(TevRuler(TPopupMenu(Sender).PopupComponent).Units));
   l_Str := 'mi' + Copy(l_Str, 6, Length(l_Str) - 5);
   TMenuItem(FindComponent(l_Str)).Checked := True;
  end;
 end;
end;

procedure TEditorWindow.splEditorsPosChanged(Sender: TObject);
begin
 if (splEditors.ControlFirst.Height <= 3) then
  splEditors.ControlFirst.Height := 0;
 if (splEditors.ControlSecond.Height <= 3) then
  splEditors.ControlSecond.Height := 0;
end;

procedure TEditorWindow.cbPartsChange(Sender: TObject);
begin
 Editor1.Invalidate;
 Editor1.SetFocus;
end;

procedure TEditorWindow.HRuler2DblClick(Sender: TObject);
begin
 Editor2.SetFocus;
end;

procedure TEditorWindow.HRuler1DblClick(Sender: TObject);
begin
 Editor1.SetFocus;
end;

procedure TEditorWindow.GotoSub(const aSub: IevSub);
  {-}
begin
 with Editor do 
 begin
  aSub.Select(Selection);
  SetFocus;
 end;{with Editor}
end;

procedure TEditorWindow.outExplorerActionElement(Sender: TObject;
  Index: Longint);
var
 l_Node : Il3Node;
 l_Sub  : IevSub;
begin
 if Supports(outExplorer.TreeStruct.Nodes[Index], Il3Node, l_Node) then
  if (l_Node <> nil) AND l3IOk(l_Node.QueryInterface(IevSub, l_Sub)) then
   try
    GotoSub(l_Sub);
   finally
    l_Sub := nil;
   end;{try..finally}
end;

function TEditorWindow.TextSourceFinishAtom(G: Tk2DocumentGenerator;
  var Atom: Tk2StackAtom): Boolean;
var
 l_ShortName : string;
 l_Number    : Long;
begin
 Result := True;
 if Atom.Box.IsKindOf(k2_typDocument) AND (Atom.Parent = nil) then 
 begin
  // - Берем Name только от основного документа, но не от вложенных
  try
   l_ShortName := Atom.Box.Attr[k2_tiShortName].AsString;
  except
   on Ek2ConversionError do
    l_ShortName := '';
  end;//try..except
  if (l_ShortName <> '') then
   Caption := Caption + ' : ' + l_ShortName;
  with Atom.Box.Attr[k2_tiExternalHandle] do
   if IsValid then
    l_Number := AsLong
   else
    l_Number := 0;
  if (l_Number <> 0) then
   Caption := Caption + ' : ' + IntToStr(l_Number);
 end;//Atom.IsKindOf(k2_typDocument)..
end;

procedure TEditorWindow.TextSourceEditorWindowProcessorBruttoCharCountChange(
  Sender: TObject);
begin
 f_DocInfo.BruttoCharCount := evGetBruttoCharCount(TextSource);
 UpdateDocInfo;
end;

procedure TEditorWindow.TextSourceEditorWindowProcessorReadOnlyChange(
  Sender: TObject);
begin
 UpdateDocInfo;
end;

procedure TEditorWindow.miDeleteBlockClick(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if l3IOk(outExplorer.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
  try
   TMainEditorForm(MainForm).DeleteSub(l_Sub);
  finally
   l_Sub := nil;
  end;{try..finally}
end;

function TEditorWindow.outExplorerGetItemImage(Sender: TObject;
  Index: Integer; var aImages : TCustomImageList): Integer;
var
 l_Node    : Il3Node;
 l_TagWrap : Il3TagRef;
begin
 Result := -1;
 if Supports(outExplorer.TreeStruct.Nodes[Index], Il3Node, l_Node) then
  if l3IOk(l_Node.QueryInterface(Il3TagRef, l_TagWrap)) then
   try
    with l_TagWrap.AsObject do
    begin
     if IsKindOf(k2_typDocument) then
      Result := 1
     else 
      if IsKindOf(k2_typBlock) then
       Result := 9
      else
       Result := 8;
    end;{with l_TagWrap.Target}
   finally
    l_TagWrap := nil;
   end;{try..finally}
end;

function TEditorWindow.Editor1GetMonikerSink(Sender: TObject;
  out theMonikerSink: IevMonikerSink): Boolean;
begin
 Result := True;
 theMonikerSink := Self;
end;

function TEditorWindow.JumpTo(anEffects : TafwJumpToEffects;
                              const aMoniker : IevMoniker): Bool;
  {-}
var
 l_URLMoniker : IevURLMoniker;
 l_URL        : string;
begin
 Result := False;                             
 if l3IOk(aMoniker.QueryInterface(IevURLMoniker, l_URLMoniker)) then
  try
   l_URL := l_URLMoniker.URL;
   if (l_URL <> '') then 
   begin
    ShellExecute(MainForm.Handle, nil, PChar(l_URL), nil, nil, SW_ShowNormal);
    Result := True;
    Exit;
   end;{l_URL <> ''}
  finally
   l_URLMoniker := nil;
  end;{try..finally}
end;

procedure TEditorWindow.W95MeterSetStr(const aStr: string);
begin
 if (pnStatus <> nil) then 
 begin
  pnStatus.Caption := aStr;
  pnStatus.Update;
 end;{pnStatus <> nil}
end;

procedure TEditorWindow.CursorChange(Sender: TObject);
  {-}
var
 l_Pos: Integer; 
begin
 if (Editor = Sender) then
 begin
  l_Pos := evGetMostInnerPos(Editor);
  if l_Pos <> l3NilLong then
   pnPos.Caption := IntToStr(l_Pos + 1);
 end;
end;
  
procedure TEditorWindow.miGotoSubClick(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if l3IOk(outExplorer.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
  try
   GotoSub(l_Sub);
  finally
   l_Sub := nil;
  end;{try..finally}
end;

procedure TEditorWindow.miExplorerSubPropertiesClick(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if l3IOk(outExplorer.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
  try
   TMainEditorForm.SubProperties(l_Sub, Editor);
  finally
   l_Sub := nil;
  end;{try..finally}
end;

procedure TEditorWindow.NewHyperlink;
  {-}
var
 l_Hyperlink : IevHyperlink;
begin
 if l3IOk(Editor.Selection.QueryInterface(IevHyperlink, l_Hyperlink)) then
  try
   TMainEditorForm.HyperlinkProperties(l_Hyperlink, TextSource.Document);
  finally
   l_Hyperlink := nil;
  end;//try..finally
end;

procedure TEditorWindow.DeleteCurrentSub;
  {-}
var
 l_Sub : IevSub;
begin
 l_Sub := evCurrentSub(Editor);
 if (l_Sub <> nil) then
  try
   TMainEditorForm(MainForm).DeleteSub(l_Sub);
  finally
   l_Sub := nil;
  end;{try..finally}
end;

function TEditorWindow.Process(Sender : TObject; 
                               Target : TObject;
                               Action : Long; 
                               Down   : Bool): Bool;
  {-}
begin
 Result := True;
 case TevOperation(Action) of
  ev_ccBordersAndShade :
   with Editor.Range do
    MainForm.BordersAndShade(Paragraph, Table);
  else 
   Result := False;
 end;{case TevOperation(Action)}
end;

function TEditorWindow.TextSourceGetControlData(aSander: TObject;
  const aControl: IevControl): IInterface;
var
 l_Tree : Tl3Tree;
begin
 l_Tree := Tl3Tree.Create;
 try
  with l_Tree.RootNode do
  begin
   with InsertChild(MakeNode('Node 1')) do
   begin
    InsertChild(MakeNode('Child 1'));
    InsertChild(MakeNode('Child 2'));
   end;//with InsertChild(MakeNode('Node1'))
   InsertChild(MakeNode('Node 2'));
  end;//with l_Tree.RootNode
  Result := l_Tree;
 finally
  l3Free(l_Tree);
 end;//try..finally
end;

procedure TEditorWindow.TextSourceGetControlItemImg(aSender   : TObject;
                                        const aControl   : TnevControlInfo;
                                        out theImageInfo : TnevControlImageInfo);
{$IFNDEF EverestLite}
var
 l_ImageList : Tl3ImageList;
{$ENDIF EverestLite}
begin
 if (aControl.rControl <> nil) then
 begin
  if not aControl.rControl.IsKindOf(k2_typBlock) and not aControl.rControl.IsKindOf(k2_typTextPara) then
  begin
   theImageInfo.rImageList := vtMakeImageListWrapper(nsDocumentRes.CommentsImageList);
   if aControl.rControl.IsKindOf(k2_typBitmapPara) then
   begin
    if (aControl.rFormatInfo <> nil) AND
       (aControl.rFormatInfo.ParentInfo <> nil) AND
       (aControl.rFormatInfo.ParentInfo.ParentInfo <> nil) then
    begin
     if Editor.View.Metrics.IsTagCollapsed(aControl.rFormatInfo.ParentInfo.ParentInfo.Obj.AsObject) then
      theImageInfo.rFirstIndex := 3
     else
      theImageInfo.rFirstIndex := 2;
    end;//aControl.rTool <> nil
   end//aControl.rControl.IsKindOf(k2_typBitmap)
  end; // if not aControl.rControl.IsKindOf(k2_typBlock) then
 end;
{$IFNDEF EverestLite}
if aControl.rControl.IsKindOf(k2_typControlPara) then
 begin
  if l3Same(aControl.rControl.PCharLenA[k2_tiName], 'AddButton') then
   theImageInfo.rImageList := Tl3ImageList.Make(dmStandardRes.ilOffice)
  else
  if l3Same(aControl.rControl.PCharLenA[k2_tiName], 'TCButton') then
   theImageInfo.rImageList := Tl3ImageList.Make(dmCtrlRes.PNGImageList)
  else
   theImageInfo.rImageList := Tl3ImageList.Make(dmCtrlRes.BtnImageList);
  theImageInfo.rFirstIndex := 1;
 end;//aControl.rControl.IsKindOf(k2_typControlPara)
{$ENDIF EverestLite}
end;

procedure TEditorWindow.TextSourceTextParaCountChange(Sender: TObject);
begin
 f_DocInfo.TextParaCount := evGetTextParaCount(TextSource);
 UpdateDocInfo;
end;

procedure TEditorWindow.TextSourceNettoCharCountChange(Sender: TObject);
begin
 f_DocInfo.NettoCharCount := evGetNettoCharCount(TextSource);
 UpdateDocInfo;
end;

procedure TEditorWindow.TextSourceTOCCreated(aSender: TObject;
  const aTOC: Il3SimpleTree);
begin
 if not TextSource.Indicator.InIO then
 begin
  UpdateDocInfo;
  //pnToolbar.Visible := (TextSource.DocumentContainer.PartCount > 1);
  if pnToolbar.Visible and (cbParts.ItemIndex <= 0) then
   cbParts.ItemIndex := 0;
 end;{not TextSource.IOProcess}
end;

procedure TEditorWindow.VSubPanel2ClickSub(Sender: TObject; SubType,
  SubHandle: Integer; aKind: TafwClickKind);
begin
 if not TMainEditorForm.SubProperties(evGetSubList(TextSource).SubEx[SubHandle, SubType], Editor) then
  ShowMessage(Format('%d:%d', [SubType, SubHandle]));
end;

procedure TEditorWindow.outExplorerGetItemFont(Sender: TObject;
  Index: Integer; const aFont: Il3Font);
begin
 if l3TestMask(outExplorer.TreeStruct.Nodes[Index].Flags, nfContens) then
  if outExplorer.Selected[Index] and outExplorer.Focused then
   aFont.ForeColor := clAqua
  else
   aFont.ForeColor := clBlue
end;

procedure TEditorWindow.TextSourceGetReader(Sender: TObject;
  aFormat: Cardinal; var Reader: Tk2CustomReader);
var
 l_TagGenerator: Tk2TagGenerator;
begin
 if Reader <> nil then
  if (aFormat = cf_EverestBin) or (aFormat = cf_EverestTxt) or (aFormat = cf_RTF)
     or (aFormat = cf_RTFLite) or (aFormat = cf_NSRC) or (aFormat = cf_Doc) or (aFormat = cf_HTML) then
  begin
   evLinkTableFilters(l_TagGenerator, True);
   //TevUnicodeConvertFilter.SetTo(l_TagGenerator);
   TevStrictContentsElementEliminator.SetTo(l_TagGenerator);
   try
    (Reader As Ik2TagGeneratorChainEnd).Link(l_TagGenerator);
   finally
    l3Free(l_TagGenerator);
   end;
  end; 
end;

procedure TEditorWindow.Cleanup;
begin
 f_Preview := nil;
 TTextSearchDlg.ClientFormClosed(Self);
 TTextSearchDlg.HideFindContext;
 Editor1.TextSource := nil;
 Editor2.TextSource := nil;
 l3Free(f_TextSource);
 inherited;
end;

procedure TEditorWindow.MakeMacroReplacer(Sender: TObject;
  var aReplacer: IafwHAFMacroReplacer);
begin
 aReplacer := TevEverestMacroReplacer.Make(nil, ExtractFileName(Caption), evGetNettoCharCount(TextSource));
end;

procedure TEditorWindow.MakePreview;
begin
 if f_Preview = nil then
 begin
  f_Preview := TPreviewForm.Create(Self);
  f_Preview.PreviewLinkOwner := Self;
  f_Preview.vtPreviewPanel1.Preview := Editor.Preview;
 end // if f_Preview = nil then
 else
  f_Preview.SetFocus;
end;

procedure TEditorWindow.ClearPreview;
begin
 SetFocus;
 f_Preview := nil;
end;

procedure TEditorWindow.InitScrollBar;
var
 l_HScroll: TvtScrollBar;
begin
 l_HScroll := TvtScrollBar.Create(pnHScrollBar);
 pnHScrollBar.InsertControl(l_HScroll);
 with l_HScroll do
 begin
  ScrollBarKind := sbHorizontal;
  Max := 0;
  PageSize := 0;
  SmallChange := 150;
  Visible := True;
 end; // with l_HScroll do
 Editor1.HScrollBar := l_HScroll;
 Editor2.HScrollBar := l_HScroll;
end;

function TEditorWindow.IsNeedSaveDocument: Boolean;
begin
 Result := TextSource.Modified;
end;

function TEditorWindow.IsPreviewInProgress: Boolean;
begin
 Result := f_Preview <> nil;
 if Result then
  Result := f_Preview.vtPreviewPanel1.Preview.InProcess;
end;

end.




