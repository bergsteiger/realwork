unit evExtDlgSpecialPaste;

{ $Id: evExtDlgSpecialPaste.pas,v 1.11 2007/12/04 12:47:41 lulin Exp $ }

// $Log: evExtDlgSpecialPaste.pas,v $
// Revision 1.11  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.6.30.4  2007/09/28 07:30:18  dinishev
// Bug fix: Сообщение List index out of bounds (-1) при закрытии диалога при отсутствии поддерживаемых форматов.
//
// Revision 1.6.30.3  2006/12/05 14:15:34  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.6.30.2  2005/06/06 10:45:14  lulin
// - bug fix: не компилировалось.
//
// Revision 1.6.30.1  2005/05/27 14:42:26  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.6  2004/03/05 13:01:09  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.5  2004/03/04 16:35:34  law
// - rename unit: VLister -> vtLister.
//
// Revision 1.4  2003/10/13 15:04:18  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.3  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.2  2001/08/28 12:55:13  law
// - rename unit: evUtils -> l3Utils.
//
// Revision 1.1  2001/06/08 13:19:36  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.1  2001/06/06 14:59:22  law
// - часть диалогов переехало в Common/Dlg.
//
// Revision 1.4  2001/01/16 12:10:35  law
// - добавлен формат RTFLite.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses 
 WinTypes, 
 WinProcs, 
 Classes, 
 Graphics, 
 Forms, 
 Controls, 
 Buttons,
 StdCtrls, 
 ExtCtrls, 

 OvcBase, 

 vtLister, 
 vtStringLister, 

 l3Types,
 l3Base, 

 evEditorWindow, 

 afwControl, 
 afwInputControl;

type
  TevExtDlgSpecialPaste = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    pnClipboardFormats: TPanel;
    lstClipboardFormats: TvtStringLister;
    procedure FormShow(Sender: TObject);
    procedure lstClipboardFormatsActionElement(Sender: TObject;
      Index: Longint);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    f_Editor : TevCustomEditorWindow;
  public
    { Public declarations }
    property Editor: TevCustomEditorWindow
      read f_Editor
      write f_Editor;
      {-}
  end;

function Execute(Editor: TevCustomEditorWindow): Bool;
  {-}

implementation

uses
  SysUtils,
  RichEdit,
  
  evTypes,
  
  l3Utils
  ;

{$R *.DFM}

procedure TevExtDlgSpecialPaste.FormShow(Sender: TObject);
var
 l_Format     : TevFormat;
 l_FormatName : string;
begin
 l_Format := 0;
 OpenClipboard(Handle);
 try
  repeat
   l_Format := EnumClipboardFormats(l_Format);
   if (l_Format = 0) then
    Break
   else 
    if LongBool(Editor.Perform(EM_CanPaste, wParam(l_Format), 0)) then 
    begin
     l_FormatName := l3ClipboardFormatName(l_Format);
     if (l_FormatName <> EmptyStr) then
      lstClipboardFormats.Items.AddObject(l_FormatName, TObject(l_Format));
     if (l_Format = cf_RTF) AND LongBool(Editor.Perform(EM_CanPaste, wParam(cf_RTFLite), 0)) then 
     begin
      l_FormatName := l3ClipboardFormatName(cf_RTFLite);
      if (l_FormatName <> EmptyStr) then
       lstClipboardFormats.Items.AddObject(l_FormatName, TObject(cf_RTFLite));
     end;//l_Format = cf_RTF
    end;//l_Format = 0
  until False;
 finally
  CloseClipboard;
 end;//try..finally
end;

procedure TevExtDlgSpecialPaste.lstClipboardFormatsActionElement(Sender: TObject;
  Index: Longint);
begin
 ModalResult := mrOk;
end;

procedure TevExtDlgSpecialPaste.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if (ModalResult = mrOk) then
  with lstClipboardFormats do
   if Current > DefItemIndex then
    Editor.Perform(EM_PasteSpecial, wParam(Items.Objects[Current]), 0);
 Editor.SetFocus;  
end;

function Execute(Editor: TevCustomEditorWindow): Bool;
  {-}
var
 l_Dlg : TevExtDlgSpecialPaste;
begin
 Result := True;
 l_Dlg := TevExtDlgSpecialPaste.Create(Application.MainForm);
 try
  l_Dlg.Editor := Editor;
  l_Dlg.ShowModal;
 finally
  l3Free(l_Dlg);
 end;{try..finally}
end;

end.
