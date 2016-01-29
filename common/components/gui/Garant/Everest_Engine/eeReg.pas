unit eeReg;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeReg -         }
{ Начат: 13.11.2002 16:42 }
{ $Id: eeReg.pas,v 1.3 2015/04/13 10:53:16 lulin Exp $ }

// $Log: eeReg.pas,v $
// Revision 1.3  2015/04/13 10:53:16  lulin
// - пытаемся собрать библиотеку.
//
// Revision 1.2  2015/01/23 14:53:50  kostitsin
// рисуем TeeEditor
//
// Revision 1.1  2015/01/20 11:54:23  lulin
// - правим зависимости.
//
// Revision 1.1  2014/12/09 14:16:03  kostitsin
// {requestlink: 580710238 }
//
// Revision 1.36  2014/08/21 10:20:37  lulin
// - чиним библиотеки.
//
// Revision 1.35  2014/04/21 11:58:13  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.34  2013/01/22 15:51:58  kostitsin
// [$424399029]
//
// Revision 1.33  2010/12/08 20:06:27  lulin
// {RequestLink:228688602}.
// - рисуем правильные связи между компонентами.
//
// Revision 1.32  2009/11/30 17:19:01  lulin
// - перегенерация.
//
// Revision 1.31  2009/08/18 08:54:56  lulin
// {ReqestLink:158795592}. №2.
//
// Revision 1.30  2009/03/19 11:20:11  oman
// - fix: Выносим лишние компоненты (К-137463980)
//
// Revision 1.29  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.24.14.4  2006/05/18 10:51:09  mmorozov
// - new: компоненты с разным набором операций;
//
// Revision 1.24.14.3  2005/12/14 11:08:04  lulin
// - cleanup.
//
// Revision 1.24.14.2  2005/10/06 10:50:59  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.24.14.1  2005/10/06 09:17:53  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.24  2004/10/25 16:18:05  lulin
// - вся логика из TeePreviewPanel переехала в TevCustomPreviewPanel.
//
// Revision 1.23  2004/09/16 11:30:54  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.22  2004/04/26 13:41:05  mmorozov
// new: регистрация TeeGroupBox;
//
// Revision 1.21  2004/04/23 11:28:39  nikitin75
// +TeeShortCutEdit;
//
// Revision 1.20  2004/03/19 13:51:56  nikitin75
// контролы поддерживающие шорткаты
//
// Revision 1.19  2004/03/19 11:36:36  nikitin75
// поддержка shortcut'ов;
//
// Revision 1.18  2004/03/18 12:11:50  nikitin75
// + eeBitBtn: поддержка shortcut'ов (OvcController);
//
// Revision 1.17  2004/03/18 11:38:29  nikitin75
// + eeButton, eeRadioGroup: поддержка shortcut'ов (OvcController);
//
// Revision 1.16  2004/03/17 15:52:57  nikitin75
// + eeMemo;
//
// Revision 1.15  2004/03/17 13:18:34  nikitin75
// + eeCheckBox: CheckBox + поддержка shortcut'ов (OvcController);
//
// Revision 1.14  2004/03/04 16:35:31  law
// - rename unit: VLister -> vtLister.
//
// Revision 1.13  2003/12/18 17:19:50  law
// - борьба с мерцанием.
//
// Revision 1.12  2003/10/14 09:56:15  law
// - слили с веткой BPRINT_PREVIEW.
//
// Revision 1.11  2003/09/05 13:40:30  law
// - new: опубликовал класс TeeSubDescriptors.
//
// Revision 1.10  2003/07/23 14:32:02  law
// - new prop category: Mouse.
//
// Revision 1.9  2003/07/18 10:56:56  nikitin75
// на закладку Everest добавлен vtSpinEdit;
//
// Revision 1.8  2003/07/15 15:55:38  law
// - new prop: TeeTreeView.OnSelectChange, OnSelectChange.
//
// Revision 1.7  2003/07/10 14:43:32  law
// - new prop: TevEditorWindow.AutoHideSelection.
// - new prop: TevCustomEditor.OnSelectionChange.
// - new prop: TeeEditor.OnCursorInSelectionChange.
//
// Revision 1.6  2003/07/03 09:41:48  law
// - new event: _OnDocumentChanged - сделана возможность узнавать о смене документа в TextSource.
//
// Revision 1.5  2003/06/02 15:55:25  law
// - new unit: eevtLister.
//
// Revision 1.4  2003/06/02 15:42:50  law
// - new unit: eevtLister.
//
// Revision 1.3  2003/03/13 10:14:13  law
// - change: компонентам добавлены картинки.
//
// Revision 1.2  2003/02/06 16:41:40  law
// - new component: TeeTreeView.
//
// Revision 1.1  2002/11/13 15:22:49  law
// - new class: TeeSubPanel.
//

{.$I evDefine.inc }

interface

uses
  evConst,
  vtSpin,

  eeTreeView,
  eeTextSource,
  eeSubDescriptorsExport,

  vtPanel,
  
  eePreviewPanel,
  eeEditor,
  eeEditorWithoutOperations,
  eeSubPanel,
  eeCheckBox,
  eeButton,
  eeMemo,
  eeShortCutEdit,
  eeGroupBox
  ;

procedure Register;

implementation

{$R eeReg.res eeReg.rc}

uses
  Classes,
  DesignIntf
  ;

const
 cEEPage = 'Everest';
 cEECategory = cEEPage;
 cSelectionCategory = 'Selection';
 cMouseCategory = 'Mouse';

procedure Register;
begin
 RegisterComponents(evEverestPage, [TvtSpinEdit]);
 RegisterComponents(evEverestPage, [TeeEditor, TeeEditorWithoutOperations,
  TeeSubPanel, TeeTreeView,
  {$If Declared(TeeMemoWithEditOperations)}
  TeeMemoWithEditOperations,
  {$IfEnd}
  TeePreviewPanel,
  TeeCheckBox,
  TeeButton,
  //TeeBitBtn,
  //TeeRadioButton,
  TeeShortCutEdit, TeeGroupBox]);
 RegisterComponents(evEverestPage, [TvtPanel]);
 RegisterComponents(evEverestComponentsPage, [TeeTextSource
                                              {$If Declared(TeeSubDescriptors)}
                                              ,
                                              TeeSubDescriptors
                                              {$IfEnd}
                                             ]);
 RegisterPropertiesInCategory(cEECategory, TeeEditor,
                              ['TextSource', 'WebStyle', 'AutoHideSelection',
                               'VSubPanel', 'OnBlockChange',
                               'OnBlockScroll', 'OnMouseAction',
                               'OnCursorInSelectionChange',
                               'OnSelectionChange']);
 RegisterPropertiesInCategory(cSelectionCategory, TeeEditor,
                              ['AutoHideSelection',
                               'OnCursorInSelectionChange',
                               'OnSelectionChange']);
 RegisterPropertiesInCategory(cSelectionCategory, TeeTreeView,
                              ['OnSelectChange',
                               'OnSelectChanged']);
 RegisterPropertiesInCategory(cMouseCategory, TeeTreeView,
                              ['OnLMouseDown',
                               'OnRMouseDown']);
 RegisterPropertiesInCategory(cEECategory, TeeTextSource,
                              ['OnDocumentChanged', 'OnAllowGotoSub']);
end;

end.
