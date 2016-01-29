unit Main;

{ $Id: MAIN.PAS,v 1.90 2014/08/19 12:13:19 kostitsin Exp $ }

// $Log: MAIN.PAS,v $
// Revision 1.90  2014/08/19 12:13:19  kostitsin
// {requestlink: 562594400 }
//
// Revision 1.89  2013/01/23 08:09:36  kostitsin
// не собиралось
//
// Revision 1.88  2009/03/23 15:09:14  lulin
// [$139442655]. Переименовываем файл.
//
// Revision 1.87  2009/03/23 14:54:32  lulin
// [$139442655]. Переименовываем новый контрол.
//
// Revision 1.86  2009/03/23 14:17:17  lulin
// [$139442655]. Bug fix: не компилировалось.
//
// Revision 1.85  2009/03/19 17:46:41  lulin
// [$139442655].
//
// Revision 1.84  2008/05/20 10:52:03  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.83  2007/12/26 00:16:32  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.82  2007/12/06 12:14:40  lulin
// - используем стандартный контрол выбора цвета.
//
// Revision 1.81  2007/12/05 13:51:23  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.77.2.3  2007/01/19 16:24:20  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.77.2.2  2006/12/21 16:20:21  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.77.2.1  2006/02/08 14:08:24  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.77  2006/01/10 08:42:10  lulin
// - не компилировался Эверест.
//
// Revision 1.76  2005/10/06 09:37:19  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.75  2005/09/08 14:31:47  lulin
// - bug fix: не собиралось.
//
// Revision 1.74  2005/07/25 13:06:46  lulin
// - исправлено имя класса компонента для записи EVD.
//
// Revision 1.73  2005/05/30 10:28:41  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.72  2005/05/27 14:44:23  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.71  2005/05/24 14:53:15  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.70  2005/03/03 17:30:32  lulin
// - в Эвересте теперь есть возможность задания типа вновь создаваемого файла.
//
// Revision 1.69  2004/12/23 11:16:11  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.68  2004/05/14 17:28:01  law
// - remove unit: evStrGen.
//
// Revision 1.67  2004/05/05 14:59:04  law
// - изменения в связи с переименованием модуля.
//
// Revision 1.66  2003/10/14 16:36:21  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.65  2003/10/13 15:06:36  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.64  2002/10/10 13:52:29  law
// - cleanup.
//
// Revision 1.63  2002/07/09 12:11:57  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.62  2002/04/06 11:33:45  law
// - Delphi 6.0.
//
// Revision 1.61.2.7  2002/01/08 08:11:47  law
// - cleanup: убрано использование agOpenDialog.
//
// Revision 1.61.2.6  2001/10/03 06:29:33  law
// - new project: EverestLite 2001.
//
// Revision 1.61.2.5  2001/10/01 14:06:00  law
// - new unit: сделано разделение на MainForm и MainFormLite.
//
// Revision 1.61.2.4  2001/10/01 13:17:58  law
// - cleanup.
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

uses
  Windows,

  Menus, 
  ImgList, 
  Classes, 
  Dialogs, 
  ExtCtrls,     
  Controls, 
  StdCtrls, 
  ActnList, 

  Tabs, 
  MainLite, 

  vtSpin, 
  vtCtrls, 
  vtHeader, 
  vtPanel, 

  RxCombos, 

  evMenu, 
  evEvdRd, 
  evSubPn, 
  evButton,   
  evAction, 
  evdReader, 
  evTextSource, 
  evEditorWindow, 
  evLoadDocumentManager, 
  evSaveDocumentManager, 
  evEditorWindowTextSource, 

  k2TagGen, 
  k2Reader, 
  k2FileGenerator, 
  k2StackGenerator, 
  k2DocumentGenerator, 

  evdWriter, 
  
  OvcBase, 

  l3Filer, 
  l3Interfaces, 
  l3ProgressComponent, 
  l3InternalInterfaces, 
  l3InterfacedComponent, 
  
  DdeMan, 

  TB97, 
  TB97Ctls, 
  TB97Tlbr,  
  tb97Control, 
  tb97GraphicControl, 

  W95Meter,   

  afwControl,
  afwCustomCommonControl, nevControl, evMultiSelectEditorWindow,
  evCustomEditor, evEditorWithOperations, evCustomMemo, evCustomEdit,
  elCustomEdit, elCustomButtonEdit, ctButtonEdit, ctAbstractEdit, AbstractDropDown,
  DropDownTree, EditableBox, FakeBox, vtColorBox,
  evCustomTextSource, afwCustomCommonControlPrim, afwControlPrim,
  afwBaseControl, afwTextControlPrim, afwTextControl
  ;

type
  TMainForm = class(TMainFormLite)
    FontSizeComboBox: TFontSizeComboBox;
    FontComboBox: TFontComboBox;
    ColorComboBox: TvtColorBox;
    BackColorComboBox: TvtColorBox;
    procedure FontComboBoxChange(Sender: TObject);
    procedure FontSizeComboBoxChange(Sender: TObject);
    procedure ColorComboBoxChange(Sender: TObject);
    procedure BackColorComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    FreezeFontCombo : Boolean;
  public
    procedure EditorWindowFontChange(const Font: Il3Font);
      override;
      {-}
  end;//TMainForm

implementation

{$R *.DFM}

uses
  SysUtils,
  Forms,

  l3Base
  ;

procedure TMainForm.FontComboBoxChange(Sender: TObject);
var
 ActChild : TForm;
begin
 if not FreezeFontCombo then begin
  ActChild := ActiveMDIChild;
  if (ActChild <> nil) then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then begin
   FontSizeComboBox.FontName:=FontComboBox.FontName;
   ActiveEditor.Editor.TextPara.Font.Name := FontComboBox.FontName;
  end;{ActiveEditor <> nil}
 end;{not FreezeFontCombo}
end;

procedure TMainForm.FontSizeComboBoxChange(Sender: TObject);
var
 ActChild : TForm;
begin
 if not FreezeFontCombo then begin
  ActChild := ActiveMDIChild;
  if ActChild <> nil then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then
   try
    ActiveEditor.Editor.TextPara.Font.Size := StrToInt(FontSizeComboBox.Text);
   except
    EditorWindowFontChange(ActiveEditor.Editor.TextPara.Font);
   end;
 end;{not FreezeFontCombo}
end;

procedure TMainForm.ColorComboBoxChange(Sender: TObject);
var
 ActChild : TForm;
Begin
 if not FreezeFontCombo then begin
  ActChild := ActiveMDIChild;
  if (ActChild <> nil) then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then
   ActiveEditor.Editor.TextPara.Font.ForeColor := ColorComboBox.Selected;
 end;{not FreezeFontCombo}
end;

procedure TMainForm.EditorWindowFontChange(const Font: Il3Font);
var
 F : Il3FontInfo;
begin
 inherited;
 FreezeFontCombo := true;
 try
  if l3IOk(Font.QueryInterface(Il3FontInfo, F)) then
   try
    FontComboBox.FontName := F.Name;
    ColorComboBox.Selected := F.ForeColor;
    BackColorComboBox.Selected := F.BackColor;
    FontSizeComboBox.FontSize := F.Size;
   finally
    F := nil;
   end;{try..finally}
 finally
  FreezeFontCombo := false;
 end;{try..finally}
end;

procedure TMainForm.BackColorComboBoxChange(Sender: TObject);
var
 ActChild : TForm;
Begin
 if not FreezeFontCombo then begin
  ActChild := ActiveMDIChild;
  if (ActChild <> nil) then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then
   ActiveEditor.Editor.TextPara.Font.BackColor := BackColorComboBox.Selected;
 end;{not FreezeFontCombo}
end;

end.