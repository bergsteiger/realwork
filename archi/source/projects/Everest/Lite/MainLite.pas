unit MainLite;

{ $Id: MainLite.pas,v 1.80 2016/04/26 12:46:09 lukyanets Exp $ }

// $Log: MainLite.pas,v $
// Revision 1.80  2016/04/26 12:46:09  lukyanets
// Выключаем переключения текущего каталога
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.79  2015/06/25 11:03:34  dinishev
// Вычистил лишнее.
//
// Revision 1.78  2015/05/29 11:50:21  kostitsin
// no message
//
// Revision 1.77  2014/07/15 11:14:51  lulin
// - восстанавливаем работоспособность.
//
// Revision 1.76  2014/01/29 12:20:19  dinishev
// {Requestlink:514874341}
//
// Revision 1.75  2013/10/23 09:34:07  lulin
// - bug fix: не компилировалось.
//
// Revision 1.74  2013/01/23 08:09:39  kostitsin
// не собиралось
//
// Revision 1.73  2011/02/17 09:59:56  lulin
// {RequestLink:253659765}.
// - вычищаем мусорок.
//
// Revision 1.72  2011/01/21 16:17:54  dinishev
// [$185830965]
//
// Revision 1.71  2011/01/21 15:44:39  dinishev
// Cleanup
//
// Revision 1.70  2010/05/27 12:45:41  dinishev
// Cleanup
//
// Revision 1.69  2009/07/16 09:16:28  lulin
// - bug fix: не собирался тестовый Эверест.
//
// Revision 1.68  2009/07/08 13:33:12  lulin
// - bug fix: не собирался тестовый Эверест в ветке.
//
// Revision 1.67  2009/07/08 11:26:30  lulin
// - bug fix: не собирался тестовый Эверест.
//
// Revision 1.66  2009/06/02 13:47:41  lulin
// [$148574526].
//
// Revision 1.65  2009/05/29 17:30:36  lulin
// [$142610853].
//
// Revision 1.64  2009/03/11 14:47:36  lulin
// - <K>: 139429761.
//
// Revision 1.63  2008/12/23 11:27:15  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.62  2008/10/01 11:13:31  lulin
// - <K>: 120718563.
//
// Revision 1.61  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.60  2008/06/10 14:38:34  lulin
// - храним ссылки на типы в полях таблицы тегов.
//
// Revision 1.59  2008/05/20 10:52:04  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.58  2008/04/01 17:05:33  lulin
// - нарисовал контейнер документа на модели.
//
// Revision 1.57  2008/03/12 14:52:46  dinishev
// Делаем меню в Эвересте "ближе" к Арчи
//
// Revision 1.56  2007/12/26 00:16:33  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.55  2007/12/05 13:51:26  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.50.2.4  2006/12/21 16:19:30  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.50.2.3  2006/02/08 14:25:10  lulin
// - собрал Everest в ветке.
//
// Revision 1.50.2.2  2006/02/08 14:08:27  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.50.2.1  2006/02/07 15:15:57  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.50  2006/01/10 08:42:15  lulin
// - не компилировался Эверест.
//
// Revision 1.49  2005/10/06 09:37:20  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.48  2005/09/08 14:31:49  lulin
// - bug fix: не собиралось.
//
// Revision 1.47  2005/07/25 13:06:49  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.46  2005/05/30 10:28:44  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.45  2005/05/27 14:44:26  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.44  2005/05/26 17:49:37  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.43  2005/05/24 14:53:17  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.42  2005/05/23 15:47:31  lulin
// - убрал надоевшую зависимость между библиотеками.
//
// Revision 1.41  2005/04/04 06:44:29  lulin
// - в связи с появлением механизма событий и фасада библиотеки K-2, удалены глобальные "заплатки" связанные с созданием/уничтожением таблицы тегов.
//
// Revision 1.40  2005/03/03 17:30:34  lulin
// - в Эвересте теперь есть возможность задания типа вновь создаваемого файла.
//
// Revision 1.39  2004/12/29 15:39:34  lulin
// - с TextSource убрана печать.
//
// Revision 1.38  2004/12/23 11:47:09  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.37  2004/09/21 10:32:34  lulin
// - bug fix: не компилировалось.
//
// Revision 1.36  2004/07/13 09:22:48  fireton
// - add: прикрутка автозамены в Эверест
//
// Revision 1.35  2004/05/14 17:28:06  law
// - remove unit: evStrGen.
//
// Revision 1.34  2004/05/05 14:59:08  law
// - изменения в связи с переименованием модуля.
//
// Revision 1.33  2004/03/15 14:22:45  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.32  2003/11/28 15:56:18  law
// - в тестовых целях сделал отключение показа гиперссылок.
//
// Revision 1.31  2003/11/06 16:04:42  law
// - добавлены форматы секций - А2 и А1.
//
// Revision 1.30  2003/10/14 16:36:23  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.29  2003/10/13 15:06:38  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.28  2003/05/20 11:35:41  law
// - rename class: TevCustomTextSourceFiler -> TevCustomTextSourceDocumentContainer.
// - rename prop: TevCustomTextSource.Filer -> TevCustomTextSource.DocumentContainer.
//
// Revision 1.27  2003/01/21 14:36:15  law
// - new behavior: сделана возможность редактирование списков.
//
// Revision 1.26  2003/01/17 15:40:49  law
// - bug fix: не открывались файлы из командной строки.
//
// Revision 1.25  2003/01/15 15:23:54  law
// no message
//
// Revision 1.24  2002/11/22 12:43:37  law
// - change: DocBar переехал в MainEditor.
//
// Revision 1.23  2002/11/22 10:33:40  law
// - new action: acMDIChildList.
//
// Revision 1.22  2002/11/11 14:56:49  law
// - new action: acMergeRows.
//
// Revision 1.21  2002/11/11 14:07:07  law
// - new behavior: acConvertTextToTable.
//
// Revision 1.20  2002/11/10 16:29:04  law
// - new feature: добавлена возможность вставки оглавления.
//
// Revision 1.19  2002/11/04 12:35:04  law
// - new actions: acText2Para.
//
// Revision 1.18  2002/11/04 10:22:57  law
// - new actions: acLo2Up, acUp2Lo, acSwapLoUp.
//
// Revision 1.17  2002/10/18 11:32:17  law
// - change: более менее одинаковый дизайн всех диалогов.
//
// Revision 1.16  2002/10/15 11:43:50  law
// - new action: acAdjustMargin.
//
// Revision 1.15  2002/10/10 13:52:30  law
// - cleanup.
//
// Revision 1.14  2002/10/09 13:31:14  law
// - new behavior: добавлены новые функции в EverestLiteExpress.
//
// Revision 1.13  2002/10/08 15:57:20  law
// - new actions.
//
// Revision 1.12  2002/10/08 13:12:39  law
// - new actions.
//
// Revision 1.11  2002/10/08 08:44:38  law
// - cleanup.
//
// Revision 1.10  2002/09/18 14:33:19  law
// - change: начата работа по поддержке нотификации об изменении стилей.
// - new unit: evStyleTableTools.
//
// Revision 1.9  2002/09/18 12:37:23  law
// - new behavior: добавлена возможность просмотра документа как в Web.
//
// Revision 1.8  2002/07/17 13:39:02  law
// - some refactoring.
//
// Revision 1.7  2002/07/17 13:06:40  law
// - some refactoring.
//
// Revision 1.6  2002/07/12 11:05:36  law
// - new actions: ev_ccInsertPageBreak, ev_ccInsertSectionBreak.
//
// Revision 1.5  2002/07/09 12:12:00  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.4  2002/04/23 15:50:23  law
// - cleanup.
//
// Revision 1.3  2002/04/09 12:25:22  law
// - new action: acInsertPicture.
//
// Revision 1.2  2002/04/06 11:33:49  law
// - Delphi 6.0.
//
// Revision 1.1.2.23  2002/04/06 11:25:14  law
// - cleanup & bugfix.
//
// Revision 1.1.2.22  2002/02/08 13:30:20  law
// - cleanup.
//
// Revision 1.1.2.21  2002/01/15 17:26:23  law
// - new function: объединение ячеек таблицы после сканирования.
//
// Revision 1.1.2.20  2002/01/12 14:56:20  law
// - new operation: ev_ccMergeCellsHorz.
//
// Revision 1.1.2.19  2002/01/11 16:02:47  law
// - new operation: ev_ccMergeCellsVert.
//
// Revision 1.1.2.18  2002/01/08 12:48:46  law
// - new behavior: сделано отключение записи в cf_EverestTxt для EverestLite.
//
// Revision 1.1.2.17  2002/01/08 09:24:39  law
// - rename class: TevDOSFiler -> Tl3Filer.
//
// Revision 1.1.2.16  2002/01/08 08:34:43  law
// - cleanup: убрано использование rxCombos.
//
// Revision 1.1.2.15  2002/01/08 08:11:49  law
// - cleanup: убрано использование agOpenDialog.
//
// Revision 1.1.2.14  2001/12/18 14:13:56  law
// - new unit: evSaveDocumentManager.
//
// Revision 1.1.2.13  2001/10/16 14:27:58  law
// - new behavior: работа с буфером обмена через OLE.
//
// Revision 1.1.2.12  2001/10/11 12:41:29  law
// - new behavior: отрываем функциональность от интерфейса.
//
// Revision 1.1.2.11  2001/10/10 13:02:40  law
// - new ptoject: EverestLiteExpress.
//
// Revision 1.1.2.10  2001/10/03 16:54:09  law
// - new behavior: сделаны меню на TAction.
//
// Revision 1.1.2.9  2001/10/03 06:29:35  law
// - new project: EverestLite 2001.
//
// Revision 1.1.2.8  2001/10/02 15:07:16  law
// - new unit: MainEditor.
//
// Revision 1.1.2.7  2001/10/02 12:32:16  law
// - new units: MainMDI и MainMDIEx - в них вынесена часть функциональности с основной формы.
//
// Revision 1.1.2.6  2001/10/02 07:07:45  law
// - new behavior: добавлена возможность помещать панели инструментов вниз окна.
//
// Revision 1.1.2.5  2001/10/02 06:53:02  law
// - new behavior: добавлено обновление состояния меню для управления панелями.
//
// Revision 1.1.2.4  2001/10/02 06:39:21  law
// - new behavior: добавлено меню для управления панелями инструментов.
//
// Revision 1.1.2.3  2001/10/01 14:11:27  law
// - bug fix: EverestLite не компилировался.
//
// Revision 1.1.2.2  2001/10/01 14:06:02  law
// - new unit: сделано разделение на MainForm и MainFormLite.
//
// Revision 1.1.2.1  2001/10/01 13:20:04  law
// - new unit: MainLite.
//
// Revision 1.61.2.3  2001/09/25 06:46:57  law
// - cleanup & new features.
//
// Revision 1.61.2.2  2001/09/21 09:59:47  law
// - cleanup.
//
// Revision 1.61.2.1  2001/09/20 14:24:58  law
// - new behavior: сделана возможность открытия/закрытия блоков определенного уровня.
//
// Revision 1.61  2001/09/14 09:45:00  law
// - change: W95Meter -> vtW95Meter.
//
// Revision 1.60  2001/08/29 15:36:49  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.59  2001/08/29 07:01:43  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.58  2001/08/03 14:40:23  law
// no message
//
// Revision 1.57  2001/07/19 15:59:00  law
// - bug fix: не работало DDE для EverestLite. В соответствии с ошибкой №727.
//
// Revision 1.56  2001/07/18 16:34:31  law
// - bug fix: не работало DDE для EverestLite. В соответствии с ошибкой №727.
//
// Revision 1.55  2001/07/12 07:07:34  law
// no message
//
// Revision 1.54  2001/06/08 13:20:32  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.53  2001/06/08 12:09:53  law
// - new behavior: сделана "расширенная" обработка операций.
//
// Revision 1.52  2001/06/06 11:26:45  law
// - сделано разделение ячеек по горизонтали.
//
// Revision 1.51  2001/06/05 15:26:15  law
// - new behavior: сделано объединение соседних блоков.
//
// Revision 1.50  2001/05/24 14:29:50  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.49  2001/05/23 14:00:45  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.48  2001/05/10 14:29:14  law
// - delete button: tbVisualFormatting.
//
// Revision 1.47  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.46  2001/04/28 13:39:25  law
// - new behavior: добавлены Shortcut'ы стилей.
//
// Revision 1.45  2001/04/16 13:15:08  law
// - new: сделана возможность объединять две таблицы.
//
// Revision 1.44  2001/04/12 15:32:04  law
// - new behavior: сделана обработка формата cf_hDrop.
//
// Revision 1.43  2001/04/11 17:25:00  law
// - new behavior: сделана вставка файла.
//
// Revision 1.42  2001/04/11 11:58:18  law
// - new behavior: сделано добавление всех открывавшихся файлов в MRU, а не только 20-ти последних.
//
// Revision 1.41  2001/03/30 13:58:56  law
// no message
//
// Revision 1.40  2001/03/15 17:23:07  law
// - Эверест 1.0.0.89.
//
// Revision 1.39  2001/02/21 12:58:24  law
// - удалены ненужные панели и элементы.
//
// Revision 1.38  2001/02/21 12:27:18  law
// - добавлен диалог со свойствами документа.
//
// Revision 1.37  2001/02/20 13:52:28  law
// - some tuning
//
// Revision 1.36  2001/01/16 12:13:08  law
// - добавлено выравнивание ячеек таблиц по вертикали.
//
// Revision 1.35  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

{$I Everest.inc}
{$I evDefine.inc}

uses WinTypes, WinProcs, SysUtils,
     Classes, Graphics, Forms, Controls, Menus,
     StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, Mask, vtCalendarPanel,
     OvcBase,
     EdWin, vtCtrls,
     evTypes, BackPnl, ActnList, l3Filer,  evEditorWindow, evEditor, evMemo,
     evRuler, evTextSource, 
     W95Meter, vtHeader, 
     k2Base, evSearch, l3Types, l3InternalInterfaces, k2DocumentGenerator,
     TB97, evButton, evConst, evMenu, k2TagGen,
     evDisp,  
     {$IfDef Win32}
     TB97Ctls,
     TB97Tlbr,
     {$EndIf Win32}
     vtSpin, evdWriter, evEvdRd, evTxtRd,
     k2Reader, l3Forms, ImgList, evSubPn, Tabs,

  l3Units,
  l3InterfacedComponent,
  l3ProgressComponent,

  evSaveDocumentManager,
  evLoadDocumentManager,
  evInternalInterfaces,
  
  MainEditor, k2StackGenerator, DdeMan, evAction, 
  tb97GraphicControl, tb97Control, vtPanel, k2FileGenerator,
  evdReader, evEditorWindowTextSource, afwCustomCommonControl, afwControl,
  evCustomTextSource, afwCustomCommonControlPrim, afwControlPrim,
  afwBaseControl, afwTextControlPrim, afwTextControl,

  nevTools,
  nevGUIInterfaces,
  evTextSourcePublished, vtPanelPrim
  ;

type
  TMainFormLite = class(TMainEditorForm)
    MainMenu: TMainMenu;
    miFile: TevMenuItem;
    miFileNew: TevMenuItem;
    miFileOpen: TevMenuItem;
    miFileClose: TevMenuItem;
    miWindow: TevMenuItem;
    miHelp: TevMenuItem;
    N1: TevMenuItem;
    miFileExit: TevMenuItem;
    miWindowCascade: TevMenuItem;
    miWindowTile: TevMenuItem;
    miWindowArrange: TevMenuItem;
    miHelpAbout: TevMenuItem;
    miFileSave: TevMenuItem;
    miFileSaveAs: TevMenuItem;
    miWindowMinimize: TevMenuItem;
    MI_Text: TevMenuItem;
    MIUndo: TevMenuItem;
    MIRedo: TevMenuItem;
    MISplitLine1: TevMenuItem;
    MICut: TevMenuItem;
    MICopy: TevMenuItem;
    MIPaste: TevMenuItem;
    miFormatJustifyLeft: TevMenuItem;
    miFormatJustifyCenter: TevMenuItem;
    miFormatJustifyRight: TevMenuItem;
    miFormatJustifyWidth: TevMenuItem;
    miTable: TevMenuItem;
    miTableInsert: TevMenuItem;
    miTableFromText: TevMenuItem;
    miTableInsertRow: TevMenuItem;
    miTableDeleteRow: TevMenuItem;
    miTableInsertColumn: TevMenuItem;
    miTableDeleteColumn: TevMenuItem;
    MITblShlCol: TevMenuItem;
    MITblShrCol: TevMenuItem;
    miSearch: TevMenuItem;
    miFind: TevMenuItem;
    miReplace: TevMenuItem;
    miSearchAgain: TevMenuItem;
    miFormat: TevMenuItem;
    N2: TevMenuItem;
    miFormatStyles: TevMenuItem;
    miMergeCells: TevMenuItem;
    miTextTextToPara: TevMenuItem;
    miSideBySide: TevMenuItem;
    miSubs: TevMenuItem;
    miAddSub: TevMenuItem;
    miDelSub: TevMenuItem;
    miConversion: TevMenuItem;
    N6: TevMenuItem;
    miUpCase: TevMenuItem;
    miLoCase: TevMenuItem;
    miSwapLoUp: TevMenuItem;
    miLoadStyles: TevMenuItem;
    miSaveStyles: TevMenuItem;
    Timer: TTimer;
    miInsert: TevMenuItem;
    miInsertPicture: TevMenuItem;
    N8: TevMenuItem;
    miFilePrint: TevMenuItem;
    N9: TevMenuItem;
    miSelectAll: TevMenuItem;
    N10: TevMenuItem;
    miHideSelection: TevMenuItem;
    miHyperLink: TevMenuItem;
    miInsertHyperLink: TevMenuItem;
    miDeleteHyperLink: TevMenuItem;
    N3: TevMenuItem;
    miMDIChildren: TevMenuItem;
    miSelectPara: TevMenuItem;
    TextSource: TevTextSource;
    miFileBatchPrint: TevMenuItem;
    StatusLine: TvtHeader;
    Progress: TvtW95Meter;
    pnMemory: TLabel;
    miSelectWord: TevMenuItem;
    miPaintDebug: TevMenuItem;
    miSplitCell: TevMenuItem;
    miBlock: TevMenuItem;
    miInsertComponent: TevMenuItem;
    miFormatBordersAndShade: TevMenuItem;
    N12: TevMenuItem;
    N13: TevMenuItem;
    dcTop: TDock97;
    dcLeft: TDock97;
    tbAdd: TToolbar97;
    btInsert: TevButton;
    btDelete: TevButton;
    tbUndo: TToolbar97;
    btUndo: TevButton;
    btRedo: TevButton;
    tbJustification: TToolbar97;
    btLeft: TevButton;
    btCenter: TevButton;
    btRight: TevButton;
    btWidth: TevButton;
    tbFont: TToolbar97;
    tbView: TToolbar97;
    btShowSpecial: TevButton;
    btWebStyle: TevButton;
    btPrintPreview: TevButton;
    btPersistent: TevButton;
    tbFile: TToolbar97;
    btNew: TevButton;
    btOpen: TevButton;
    btSave: TevButton;
    btSaveAll: TevButton;
    btPrint: TevButton;
    tbEdit: TToolbar97;
    btCut: TevButton;
    btCopy: TevButton;
    btPaste: TevButton;
    tbSearchReplace: TToolbar97;
    btSearch: TevButton;
    btSearchAgain: TevButton;
    btSpellcheck: TevButton;
    btGroup: TevButton;
    tbTable: TToolbar97;
    btInsertTable: TevButton;
    btInsertRow: TevButton;
    btInsertColumn: TevButton;
    btDeleteRow: TevButton;
    btDeleteColumn: TevButton;
    miMRUBreak: TMenuItem;
    miMRU: TMenuItem;
    btPreformatted: TevButton;
    btVisible: TevButton;
    btTest: TevButton;
    MIAddToClipboard: TevMenuItem;
    miDelete: TevMenuItem;
    miSpecialPaste: TevMenuItem;
    N14: TMenuItem;
    miFileSend: TMenuItem;
    btAdjustMargin: TevButton;
    miInsertBreak: TMenuItem;
    miInsertPageBreak: TevMenuItem;
    miInsertSectionBreak: TevMenuItem;
    tbStyle: TToolbar97;
    StyleComboBox: TSpeedBarComboBox;
    tbZoom: TToolbar97;
    seZoom: TvtSpinEdit;
    miFormatPreformatted: TevMenuItem;
    btShowDocumentParts: TevButton;
    btMergeCells: TevButton;
    btDrawLines: TevButton;
    tbVerticalAligment: TToolbar97;
    btTop: TevButton;
    btVCenter: TevButton;
    btBottom: TevButton;
    N4: TMenuItem;
    miTop: TevMenuItem;
    miVCenter: TevMenuItem;
    miBottom: TevMenuItem;
    miFileProperties: TMenuItem;
    N5: TMenuItem;
    miTableSplitTable: TevMenuItem;
    miInsertFileInsert: TMenuItem;
    miTableMergeTables: TevMenuItem;
    miFormatStyle: TMenuItem;
    miFormatStyleColorSelection: TMenuItem;
    miFormatStyleToLeft: TMenuItem;
    tbFormat: TToolbar97;
    btBordersAndShade: TevButton;
    btSplitCells: TevButton;
    btStyles: TevButton;
    tbOutline: TToolbar97;
    btHSplit: TevButton;
    btVSplit: TevButton;
    miView: TMenuItem;
    miViewShowDocumentParts: TevMenuItem;
    miViewShowSpecial: TevMenuItem;
    miViewPrintPreview: TevMenuItem;
    N7: TMenuItem;
    miViewPanels: TMenuItem;
    dcBottom: TDock97;
    miMergeCellsVert: TevMenuItem;
    miMergeCellsHorz: TevMenuItem;
    miTableToolsBreak: TMenuItem;
    miTableTools: TMenuItem;
    miMergeRows: TMenuItem;
    pmSection: TPopupMenu;
    miPortrait: TMenuItem;
    miLandscape: TMenuItem;
    MenuItem1: TMenuItem;
    miA4Size: TMenuItem;
    miA3Size: TMenuItem;
    pmSub: TPopupMenu;
    miSubProperties: TMenuItem;
    miSubDelete: TMenuItem;
    miDocumentPartMerge: TMenuItem;
    pmHyperlink: TPopupMenu;
    miHypelinkProperties: TMenuItem;
    miFollowHyperlink: TMenuItem;
    MenuItem2: TMenuItem;
    pmCell: TPopupMenu;
    miCellBordersAndShade: TMenuItem;
    miCellMerge: TMenuItem;
    miCellDelete: TMenuItem;
    pmEditor: TPopupMenu;
    miHRuler: TMenuItem;
    miVRuler: TMenuItem;
    miVSubPanel: TMenuItem;
    miSplitWindow: TMenuItem;
    miShowExplorer: TMenuItem;
    miLine1: TMenuItem;
    evMenuItem1: TevMenuItem;
    evMenuItem2: TevMenuItem;
    evMenuItem3: TevMenuItem;
    evMenuItem4: TevMenuItem;
    evMenuItem5: TevMenuItem;
    MenuItem3: TMenuItem;
    evMenuItem6: TevMenuItem;
    evMenuItem7: TevMenuItem;
    miFindAgain: TevMenuItem;
    MenuItem4: TMenuItem;
    miCloseEditor: TMenuItem;
    miMaximize: TMenuItem;
    pmExplorer: TPopupMenu;
    miGotoSub: TMenuItem;
    miExplorerSubProperties: TMenuItem;
    MenuItem5: TMenuItem;
    miTools: TevMenuItem;
    miBuildDocumentStructure: TMenuItem;
    miBuildContents: TMenuItem;
    miDeleteAllBlocks: TMenuItem;
    tbList: TToolbar97;
    btBullet: TToolbarButton97;
    btIncIndent: TToolbarButton97;
    btDecIndent: TToolbarButton97;
    btNumber: TToolbarButton97;
    miA2Size: TMenuItem;
    miA1Size: TMenuItem;
    btHideHyperlinks: TevButton;
    procedure FormCreate(Sender: TObject);
    procedure miWindowCascadeClick(Sender: TObject);
    procedure miWindowTileClick(Sender: TObject);
    procedure miWindowArrangeClick(Sender: TObject);
    procedure miFileCloseClick(Sender: TObject);
    procedure miFileExitClick(Sender: TObject);
    procedure miWindowMinimizeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StyleComboBoxChange(Sender: TObject);
    procedure StyleComboBoxDropDown(Sender: TObject);
    procedure miAddSubClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure seZoomExit(Sender: TObject);
    procedure seZoomKeyPress(Sender: TObject; var Key: Char);
    procedure miDelSubClick(Sender: TObject);
    procedure miInsertHyperLinkClick(Sender: TObject);
    procedure miDeleteHyperLinkClick(Sender: TObject);
    procedure StatusLineSizing(Sender: TObject; ASection, AWidth: Integer);
    procedure TextSourceProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
    procedure miFileBatchPrintClick(Sender: TObject);
    procedure pnMemoryDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miPaintDebugClick(Sender: TObject);
    procedure miInsertComponentClick(Sender: TObject);
    procedure miMRUClick(Sender: TObject);
    procedure seZoomTopClick(Sender: TObject);
    procedure seZoomBottomClick(Sender: TObject);
    procedure btTestClick(Sender: TObject);
    procedure miHelpAboutClick(Sender: TObject);
    procedure miFilePropertiesClick(Sender: TObject);
    procedure miHRulerClick(Sender: TObject);
    procedure miCloseEditorClick(Sender: TObject);
    procedure miVRulerClick(Sender: TObject);
    procedure miVSubPanelClick(Sender: TObject);
    procedure miSplitWindowClick(Sender: TObject);
    procedure miShowExplorerClick(Sender: TObject);
    procedure miMaximizeClick(Sender: TObject);
    procedure pmEditorPopup(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
  private
    f_Printing : Bool;
    procedure PrintFile(const FileName : TFileName);
    procedure ShowHint(Sender: TObject);
  private
  {message handlers}
    function  MakeMRUItem(aParent: TMenuItem; i : Long): TMenuItem;
      {-}
    procedure miViewPanelsClick(Sender: TObject);
      {-}
    procedure MakePanelsMenu;
      override;
      {-}
    procedure ToolbarVisibleChanged(Sender: TObject);
      {-}
    protected
    // property methods
      function  pm_GetShowDocumentParts: Bool;
        override;
      procedure pm_SetShowDocumentParts(Value: Bool);
        override;
        {-}
      function  pm_GetPrintPreview: Bool;
        override;
      procedure pm_SetPrintPreview(Value: Bool);
        override;
        {-}
      function  pm_GetShowSpecial: Bool;
        override;
      procedure pm_SetShowSpecial(Value: Bool);
        override;
        {-}
      function  pm_GetPersistentBlocks: Bool;
        override;
      procedure pm_SetPersistentBlocks(Value: Bool);
        override;
        {-}
      function  pm_GetWebStyle: Bool;
        override;
      procedure pm_SetWebStyle(Value: Bool);
        override;
        {-}
    protected
    // internal methods
      procedure BeforeRelease;
        //override;
        {-}
      procedure UpdateMenuItems(Sender: TObject);
        override;
        {-}
  public
    procedure EditorWindowZoomChange(NewZoom : Integer);
      override;
      {-}
    procedure EditorWindowStyleChange(const StyleName: String);
      override;
      {-}
    procedure CheckEditorProperties(aEditor: TevCustomEditorWindow);
      override;
      {-}
    procedure UpdateMRU;
      override;
      {-}
    function Process(Sender : TObject;
                     Target : TObject;
                     Action : Long; 
                     Down   : Bool): Bool;
      override;               
      {-}
    function  MouseAction(const aHotSpot    : IevHotSpot;
                          aButton           : TevMouseButton;
                          anAction          : TevMouseAction;
                          Keys              : TShiftState;
                          var NeedAsyncLoop : Bool): Bool;
      override;
      {-}
    procedure ShowSubMenu(const aSub : IevSub;
                          const aPt  : Tl3SPoint;
                          aComponent : TComponent);
      override;
      {-}
    procedure DoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
      override;
      {-}
    procedure DoExplorerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
      override;
      {-}
  end;//TMainFormLite

implementation

{$R *.DFM}

uses
  ShellAPI,
  {$IfDef evMemoryUsageDialog}
  D_MemUsg,
  {$EndIf evMemoryUsageDialog}
  IniShop, l3IniFile, Printers,

  l3Interfaces,
  l3Chars,
  l3MinMax,
  l3Base,
  l3String,
  l3Stream,
  l3Printer,

  k2Interfaces,
  k2Facade,
  k2Tags,

  nevBase,
  evExcept,
  evdStyles,

  D_FlSrch,

  evdDOM,
  evEditorInterfaces,
  evStandardActions,
  evMenuMisc,
  evDocumentPreview,

  evFacadeGUI,

  evTableConverter,
  nevNavigation,

  D_About,
  D_DocumentProperties,

  Document_Const
  ;

procedure TMainFormLite.FormCreate(Sender: TObject);
var
 l_Popup : TPopupMenu;
 l_Item  : TevMenuItem;
 l_Index : Integer;
 l_Type  : Tk2Type;
begin
 inherited;
    TextSource.Indicator.NeedProgressProc := True;
    TextSource.Indicator.Meter := Progress;
    TextSource.Indicator.OnProgressProc := TextSourceProgressProc;
 evOperationDispatcher.IncludeOperations([ev_ccGroup]);
 evOperationDispatcher.ExcludeOperations([ev_ccInsertTable]);
 Application.OnHint := ShowHint;
 IniLoadToolbarPositions(Self, UserConfig.CfgFileName, '');
 {$IfDef evExternalProduct}
 miPaintDebug.Visible := false;
 {$Else  evExternalProduct}
 miPaintDebug.Visible := IniRec^.Debug.Paint;
 {$EndIf evExternalProduct}

 {$IfDef EverestRelease}
 btPrintPreview.Visible := false;
 btTest.Visible := false;
 {$Else  EverestRelease}
 btPrintPreview.Visible := true;
 btTest.Visible := true;
 {$EndIf EverestRelease}

 {$IfDef evSpellChecker}
 btSpellcheck.Visible := true;
 {$Else  evSpellChecker}
 btSpellcheck.Visible := false;
 {$EndIf evSpellChecker}
 l_Popup := TPopupMenu.Create(btNew);
 btNew.DropdownMenu := l_Popup;
 btNew.DropdownCombo := true;

 with k2.TypeTable do
  for l_Index := 0 to MaxTypeID do
  begin
   l_Type := TypeByHandle[Ord(l_Index)];
   if (l_Type <> nil) AND l_Type.IsKindOf(k2_typDocument) then
   begin
    l_Item := TevMenuItem.Create(l_Popup);
    l_Item.Caption := l_Type.AsString;
    l_Item.Tag := l_Type.ID;
    l_Item.Operation := ev_ccNew;
    l_Popup.Items.Add(l_Item);
   end;//..k2_idDocument..
  end;//for l_Index
end;

procedure TMainFormLite.FormDestroy(Sender: TObject);
begin
 inherited;
 Screen.OnActiveFormChange := nil;
end;

procedure TMainFormLite.ShowHint(Sender: TObject);
begin
 StatusLine.Sections[0].Caption := Application.Hint;
end;

procedure TMainFormLite.CheckEditorProperties(aEditor: TevCustomEditorWindow);
begin
 inherited;
 seZoom.Value := aEditor.Zoom;
end;

procedure TMainFormLite.miViewPanelsClick(Sender: TObject);
  {-}
begin
 with (Sender As TevMenuItem) do begin
  TToolbar97(Tag).Visible := Checked;
 end;//with (Sender As TevMenuItem)
end;

procedure TMainFormLite.MakePanelsMenu;
  {-}
var
 l_MenuItem : TevMenuItem;
 l_Index    : Long;
 l_Comp     : TComponent;
begin
 inherited;
 for l_Index := 0 to Pred(ComponentCount) do begin
  l_Comp := Components[l_Index];
  if (l_Comp Is TToolbar97) then begin
   TToolbar97(l_Comp).OnVisibleChanged := ToolbarVisibleChanged;
   l_MenuItem := TevMenuItem.Create(miViewPanels);
   with l_MenuItem do begin
    Caption := TToolbar97(l_Comp).Caption;
    Checked := TToolbar97(l_Comp).Visible;
    AutoCheck := true;
    Tag := Integer(l_Comp);
    OnClick := miViewPanelsClick;
   end;//with l_MenuItem
   miViewPanels.Add(l_MenuItem);
  end;//l_Comp Is TToolbar97
 end;//for l_Index
end;

function TMainFormLite.MakeMRUItem(aParent: TMenuItem; i : Long): TMenuItem;
  {-}
var
 l_Name : String;
begin
 l_Name := OpenDialog.HistoryList[i];
 Result := TMenuItem.Create(aParent);
 Result.Caption := l_Name;
 Result.OnClick := miMRUClick;
 Case l3StringCase(ExtractFileExt(l_Name),
                   ['.evd', '.doc', '.rtf', '.txt', '.htm', '.html', '.evr'],
                   l3_siCaseUnsensitive) of
  0, 6 : Result.ImageIndex := 227;
  1, 2 : Result.ImageIndex := 229;
  3 : Result.ImageIndex := 228;
  4, 5 : Result.ImageIndex := 1;
 end;//Case l3StringCase
 aParent.Add(Result);
end;

procedure TMainFormLite.UpdateMRU;
var
 i : Long;
 l_Count : Long;
 l_Item  : TMenuItem;
 l_Item1 : TMenuItem;
 l_Start : Long;
begin
 inherited;
 l_Count := Pred(OpenDialog.HistoryList.Count);
 with miMRU do
  while (Count > 0) do Remove(Items[0]);
 l_Start := 0;
 l_Item := miMRU;
 while true do begin
  for i := l_Start to Min(l_Start + 20, l_Count) do MakeMRUItem(l_Item, i);
  l_Start := Min(l_Start + 21, l_Count);
  if (l_Start < l_Count) then begin
   l_Item1 := TMenuItem.Create(miMRU);
   l_Item1.Caption := 'Еще..';
   l_Item.Add(l_Item1);
   l_Item := l_Item1;
  end else
   break;
 end;//while (l_Start < l_Count)
 with miMRU do begin 
  Visible := (Count > 0);
  miMRUBreak.Visible := Visible;
 end;//with miMRU
end;

function TMainFormLite.pm_GetShowDocumentParts: Bool;
  //override;
  {-}
begin
 Result := btShowDocumentParts.Down;
end;

procedure TMainFormLite.pm_SetShowDocumentParts(Value: Bool);
  //override;
  {-}
begin
 btShowDocumentParts.Down := Value;
end;

function TMainFormLite.pm_GetPrintPreview: Bool;
  //override;
  {-}
begin
 Result := btPrintPreview.Down;
end;

procedure TMainFormLite.pm_SetPrintPreview(Value: Bool);
  //override;
  {-}
begin
 btPrintPreview.Down := Value;
end;

function TMainFormLite.pm_GetShowSpecial: Bool;
  //override;
  {-}
begin
 Result := btShowSpecial.Down;
end;

procedure TMainFormLite.pm_SetShowSpecial(Value: Bool);
  //override;
  {-}
begin
 btShowSpecial.Down := Value;
end;

function TMainFormLite.pm_GetPersistentBlocks: Bool;
  //override;
  {-}
begin
 Result := btPersistent.Down;
end;

procedure TMainFormLite.pm_SetPersistentBlocks(Value: Bool);
  //override;
  {-}
begin
 btPersistent.Down := Value;
// IniRec^.PersistentBlocks := Value;
end;

function TMainFormLite.pm_GetWebStyle: Bool;
  //override;
begin
 if (btWebStyle = nil) then
  Result := false
 else if (btWebStyle.Action = nil) then
  Result := btWebStyle.Down
 else 
  Result := (btWebStyle.Action As TCustomAction).Checked;
end;

procedure TMainFormLite.pm_SetWebStyle(Value: Bool);
  //override;
  {-}
begin
 if (btWebStyle <> nil) then begin
  btWebStyle.Down := Value;
  if (btWebStyle.Action <> nil) then
   (btWebStyle.Action As TCustomAction).Checked := Value;
 end;//btWebStyle <> nil
// IniRec^.WebStyle := Value;
end;

procedure TMainFormLite.miFileCloseClick(Sender: TObject);
begin
 if ActiveMDIChild <> nil then ActiveMDIChild.Close;
end;

procedure TMainFormLite.miFileExitClick(Sender: TObject);
 Begin
  Close;
 end;

procedure TMainFormLite.miWindowCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainFormLite.miWindowTileClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainFormLite.miWindowArrangeClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainFormLite.miWindowMinimizeClick(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainFormLite.UpdateMenuItems(Sender: TObject);
var
 l_Enabled : Bool;
begin
 inherited;
 l_Enabled := (MDIChildCount > 0);
 miFileClose.Enabled := l_Enabled;
 miWindowCascade.Enabled := l_Enabled;
 miWindowTile.Enabled := l_Enabled;
 miWindowArrange.Enabled := l_Enabled;
 miWindowMinimize.Enabled := l_Enabled;
 miFileProperties.Enabled := l_Enabled;
end;

procedure TMainFormLite.seZoomExit(Sender: TObject);
begin
 if (ActiveEditor <> nil) then
 seZoom.AsInteger := ActiveEditor.Editor.Zoom;
end;

procedure TMainFormLite.seZoomKeyPress(Sender: TObject; var Key: Char);
begin
 if (ActiveEditor = nil) then Exit;
 case Byte(Key) of
  vk_RETURN :
   ActiveEditor.Editor.Zoom := seZoom.AsInteger;
  vk_Escape,
  vk_Tab    : seZoom.AsInteger := ActiveEditor.Editor.Zoom;
  else        Exit;
 end;
 WinProcs.SetFocus(ActiveEditor.Handle);
end;

procedure TMainFormLite.EditorWindowZoomChange(NewZoom : Integer);
begin
 inherited;
 if (ActiveEditor <> Nil) then
  seZoom.AsInteger := ActiveEditor.Editor.Zoom;
end;

function TMainFormLite.Process(Sender : TObject;
                           Target : TObject;
                           Action : Long; 
                           Down   : Bool): Bool;
  {-}
begin
 Result := inherited Process(Sender, Target, Action, Down);
 if not Result then begin
  Result := true;
  Case TevOperation(Action) of
   ev_ccGroup  : FileSrchForm.Show;
   else Result := false;
  end;{Case TevOperation(Action)}
 end;
end;

procedure TMainFormLite.StyleComboBoxChange(Sender: TObject);
var
 ActChild : TForm;
begin
 ActChild := ActiveMDIChild;
 if ActChild <> nil then WinProcs.SetFocus(ActChild.Handle);
 if (ActiveEditor <> nil) then
  ActiveEditor.Editor.TextPara.Style.Name := StyleComboBox.Text;
end;

procedure TMainFormLite.StyleComboBoxDropDown(Sender: TObject);
begin
 if (ActiveEditor <> nil) then begin
  try
   StyleComboBox.Items.Assign(ActiveEditor.Editor.TextPara.Style.Styles.Items)
  except
   StyleComboBox.Items.Clear;
  end;{try..except}
 end;{ActiveEditor <> nil..}
end;

procedure TMainFormLite.EditorWindowStyleChange(const StyleName: String);
begin
 inherited;
 if (ActiveEditor <> nil) then StyleComboBox.Text := StyleName;
end;

procedure TMainFormLite.miAddSubClick(Sender: TObject);
begin
 acInsertSubExecute(Sender);
end;

procedure TMainFormLite.FormShow(Sender: TObject);
begin
 inherited;
 btWidth.Enabled := true;  // - устраняем глюк с отрисовкой кнопки
 btWidth.Enabled := false; //   "разгонка по ширине"
 miHelpAbout.Visible := false; // - устраняем глюк с картинкой меню
 miHelpAbout.Visible := true;  //   "о программе"
end;

procedure TMainFormLite.TimerTimer(Sender: TObject);
begin
 with l3Base.l3System do
  pnMemory.Caption := IntToStr(LocalMemUsed div 1024) + '/' +
                      IntToStr(GlobalMemUsed div 1024) + '/' +
                      IntToStr(ObjectMemUsed div 1024) + '/' +
                      IntToStr(ObjectCount div 1024) + 'K ' +
                      IntToStr(DCCount) + '/' +
                      IntToStr(RgnCount);
end;

procedure TMainFormLite.miDelSubClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then ActiveEditor.DeleteCurrentSub;
end;

procedure TMainFormLite.miInsertHyperLinkClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then ActiveEditor.NewHyperlink;
end;

procedure TMainFormLite.miDeleteHyperLinkClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then ActiveEditor.Editor.DeleteHyperLink;
end;

procedure TMainFormLite.StatusLineSizing(Sender: TObject; ASection,
  AWidth: Integer);
 Var
  I : Byte;
  C : TControl;
  Delta : Integer absolute AWidth;
 begin
  if Delta=0 then Exit;
  C:=nil;

  Case ASection of
    0 : ;
    1 : C:= Progress;
    2 : C := pnMemory;
{    3 : C:=ColorComboBox;
    4 : C:=FormatSpeedBar;}
  end;

  If Assigned(C) then C.Width := C.Width + Delta;

  For I := Succ(ASection) to Pred(StatusLine.Sections.Count) do {MoveSection}
   Begin
    Case I of
     0 : ;
     1 : Progress.Left := Progress.Left + Delta;
     2 : pnMemory.Left := pnMemory.Left + Delta;
{     3 : ColorComboBox.Left:=ColorComboBox.Left+Delta;
     4 : FormatSpeedBar.Left:=FormatSpeedBar.Left+Delta;}
    end;
   end;
 end;

procedure TMainFormLite.TextSourceProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
begin
 Case aState of
  piStart: StatusLine.Sections[0].Caption := aMsg;
  piEnd: StatusLine.Sections[0].Caption := '';
 end;{Case aState}
end;

procedure TMainFormLite.miFileBatchPrintClick(Sender: TObject);
begin
 if f_Printing then
 begin
  TextSource.CloseQuery(0);
  DOSFiler.CloseQuery(0);
 end
 else
 begin
  if ExecuteOpenDialog(OpenDialog) then
  begin
   miFileBatchPrint.Caption := 'Прервать фоновую печать';
   try
    PrintFile(OpenDialog.FileName);
   finally
    miFileBatchPrint.Caption := 'Фоновая печать...';
   end;{try..finally}
  end;{OpenDialog.Execute}
 end;
end;

procedure TMainFormLite.PrintFile(const FileName : TFileName);
var
 P : Tl3Printer;
 t : TDateTime;
begin
 DOSFiler.FileName := FileName;
 f_Printing := true;
 try
  t := Now;
  TextSource.Load(EverestReader);
  t := Now - t;
  Caption := TimeToStr(t);
  Exit; {&Exit&}
  P := Tl3Printer.Create;
  try
   P.Title := Application.Title + ': ' + FileName;
   with TevDocumentPreview.Make(TextSource.Document, evDefaultPreviewCacheKey) do
   begin
    Printer := P;
    Print;
   end;//with TevDocumentPreview.Make(k2Tag(TextSource.Document)
  finally
   l3Free(P);
  end;{try..finally}
 finally
  f_Printing := false;
  TextSource.DocumentContainer := nil;
 end;{try..finally}
end;

procedure TMainFormLite.pnMemoryDblClick(Sender: TObject);
begin
 {$IfDef evMemoryUsageDialog}
 MemoryUsageDlg.ShowModal;
 {$EndIf evMemoryUsageDialog}
end;

procedure TMainFormLite.BeforeRelease;
  //override;
  {-}
begin
 IniSaveToolbarPositions(Self, UserConfig.CfgFileName, '');
 inherited;
end;

procedure TMainFormLite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if TextSource.CloseQuery(Handle) AND DOSFiler.CloseQuery(Handle) then begin
  Action := caFree;
  inherited;
 end else Action := caNone;
end;

procedure TMainFormLite.miPaintDebugClick(Sender: TObject);
begin
 miPaintDebug.Checked := not miPaintDebug.Checked;
 if miPaintDebug.Checked then
  SetBounds(577, 99, 445, 518)
 else
  SetBounds(188, 180, 667, 499);
end;

procedure TMainFormLite.miInsertComponentClick(Sender: TObject);
begin
 {$IfDef k2UseVCLPara}
 if (ActiveEditor <> nil) then ActiveEditor.Editor.InsertComponent;
 {$EndIf k2UseVCLPara}
end;

procedure TMainFormLite.miMRUClick(Sender: TObject);
var
 FileName : String;
begin
 FileName := (Sender As TMenuItem).Caption;
 {$IfDef Delphi5}
 FileName := StripHotKey(FileName);
 {$EndIf Delphi5}
 LoadManager.FileName := FileName;
 CreateMDIChild(nil, FileName);
end;

procedure TMainFormLite.seZoomTopClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then
  ActiveEditor.Editor.Zoom := seZoom.AsInteger;
end;

procedure TMainFormLite.seZoomBottomClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then
  ActiveEditor.Editor.Zoom := seZoom.AsInteger;
end;

procedure TMainFormLite.btTestClick(Sender: TObject);
begin
 with ActiveEditor.Editor do begin
  ReadOnly := not ReadOnly;
  Invalidate;
 end;
end;

procedure TMainFormLite.miHelpAboutClick(Sender: TObject);
begin
 with TAboutBox.Create(Self) do
  try
   ShowModal;
  finally
   Free;
  end;//try..finally
end;

procedure TMainFormLite.miFilePropertiesClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then
  with TDocumentPropertiesDlg.Create(Self) do
   try
    Execute(ActiveEditor.TextSource As IevDocument);
   finally
    Free;
   end;//try..finally
end;

procedure TMainFormLite.ToolbarVisibleChanged(Sender: TObject);
var
 l_Index : Long;
begin
 for l_Index := 0 to Pred(miViewPanels.Count) do begin
  with miViewPanels[l_Index] do
   if (Tag = Long(Sender)) then begin
    Checked := (Sender As TToolbar97).Visible;
    System.break;
   end;//Tag = Long(Sender)
 end;//for l_Index
end;

function TMainFormLite.MouseAction(const aHotSpot    : IevHotSpot;
                                   aButton           : TevMouseButton;
                                   anAction          : TevMouseAction;
                                   Keys              : TShiftState;
                                   var NeedAsyncLoop : Bool): Bool;
  {-}
begin
 Result := inherited MouseAction(aHotSpot, aButton, anAction, Keys, NeedAsyncLoop);
 if not Result then
  Case aButton of
   ev_mbRight : begin
    if (anAction = ev_maUp) then
      Result := evPopupMenuEx(aHotSpot,
                              [IevHyperlink, IevSub, IedCell, IevdSection],
                              [pmHyperlink, pmSub, pmCell, pmSection],
                              CurrentTarget)
    else
     Result := false;
   end;//ev_mbRight
   else Result := false;
  end;//Case aButton
end;

procedure TMainFormLite.ShowSubMenu(const aSub : IevSub;
                                    const aPt  : Tl3SPoint;
                                    aComponent : TComponent);
  {-}
begin
 CurrentTarget := aSub;
 pmSub.PopupComponent := aComponent;
 with aPt.P do pmSub.Popup(X, Y);
end;

procedure TMainFormLite.DoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  //override;
  {-}
begin
 Handled := true;
 CurrentTarget := nil;
 if (Sender Is TControl) then
  MousePos := TControl(Sender).ClientToScreen(MousePos);
 with MousePos do pmEditor.Popup(X, Y);
end;

procedure TMainFormLite.DoExplorerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  //override;
  {-}
begin
 Handled := true;
 CurrentTarget := nil;
 if (Sender Is TControl) then
  MousePos := TControl(Sender).ClientToScreen(MousePos);
 with MousePos do pmExplorer.Popup(X, Y);
end;

procedure TMainFormLite.miHRulerClick(Sender: TObject);
var
 E : TevEditor;
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  E := Editor;
  if (E <> nil) then with E do begin
   if HRuler.Visible then begin
    miHRuler.Checked := false;
    HRuler.Visible := false;
   end else begin
    miHRuler.Checked := true;
    HRuler.Visible := true;
   end;
   if (IniRec <> nil) then begin
    if (E = Editor1) then
     IniRec^.ShowHRuler1 := HRuler.Visible
    else
     IniRec^.ShowHRuler2 := HRuler.Visible;
   end;
  end;
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.miCloseEditorClick(Sender: TObject);
begin
 if ActiveMDIChild <> nil then ActiveMDIChild.Close;
end;

procedure TMainFormLite.miVRulerClick(Sender: TObject);
var
 E : TevEditor;
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  E := Editor;
  if (E <> nil) then with E do begin
   if VRuler.Visible then begin
    miVRuler.Checked := false;
    VRuler.Visible := false;
   end else begin
    miVRuler.Checked := true;
    VRuler.Visible := true;
   end;
   if (IniRec <> nil) then begin
    if (E = Editor1) then
     IniRec^.ShowVRuler1 := VRuler.Visible
    else
     IniRec^.ShowVRuler2 := VRuler.Visible;
   end;
  end;
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.miVSubPanelClick(Sender: TObject);
var
 E : TevEditor;
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  E := Editor;
  if (E <> nil) then with E do begin
   if VSubPanel.Visible then begin
    miVSubPanel.Checked := false;
 {   Splitter1.Visible := false;}
    VSubPanel.Visible := false;
   end else begin
    miVSubPanel.Checked := true;
    VSubPanel.Visible := true;
 {   Splitter1.Visible := true;}
   end;
   if (IniRec <> nil) then begin
    if (Editor = Editor1) then
     IniRec^.ShowSubPanel1 := VSubPanel.Visible
    else
     IniRec^.ShowSubPanel2 := VSubPanel.Visible;
   end;
  end;
 end;//ActiveEditor <> nil
end;


procedure TMainFormLite.miSplitWindowClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  if miSplitWindow.Checked then begin
   pnEditor2.Height := 0;
   miSplitWindow.Checked := false;
  end else begin
   pnEditor2.Height := pnEditors.Height div 2;
   miSplitWindow.Checked := true;
  end;//miShowExplorer.Checked
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.miShowExplorerClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  if miShowExplorer.Checked then begin
   outExplorer.Width := 1;
   miShowExplorer.Checked := false;
  end else begin
   outExplorer.Width := Width div 5;
   miShowExplorer.Checked := true;
  end;//miShowExplorer.Checked
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.miMaximizeClick(Sender: TObject);
begin
 if (ActiveEditor <> nil) then with ActiveEditor do begin
  Case WindowState of
   wsNormal, wsMinimized: WindowState := wsMaximized;
   wsMaximized: WindowState := wsNormal;
  end;{Case WindowState}
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.pmEditorPopup(Sender: TObject);
begin
 if (ActiveEditor <> nil) then with ActiveEditor, Editor do begin
  miVRuler.Checked := VRuler.Visible;
  miVSubPanel.Checked := VSubPanel.Visible;
  miHRuler.Checked := HRuler.Visible;
  miMaximize.Checked := (WindowState = wsMaximized);
 end;//ActiveEditor <> nil
end;

procedure TMainFormLite.pmExplorerPopup(Sender: TObject);
var
 l_Sub : IevSub;
begin
 if (ActiveEditor = nil) then
  CurrentTarget := nil
 else with ActiveEditor do
  if l3IOk(outExplorer.GetCurrentNode.QueryInterface(IevSub, l_Sub)) then
   try
    CurrentTarget := l_Sub;
   finally
    l_Sub := nil;
   end//try..finally
  else
   CurrentTarget := nil;
end;

end.
