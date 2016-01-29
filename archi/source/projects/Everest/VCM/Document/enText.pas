unit enText;

// $Id: enText.pas,v 1.5 2008/05/20 10:52:04 lulin Exp $

// $Log: enText.pas,v $
// Revision 1.5  2008/05/20 10:52:04  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.4  2005/05/27 14:44:27  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.3  2004/10/07 11:52:38  lulin
// - не компилировалось без define Nemesis.
//
// Revision 1.2  2004/03/03 18:22:50  law
// no message
//
// Revision 1.1  2003/12/09 18:28:27  law
// no message
//
// Revision 1.14  2003/12/02 18:18:07  law
// - new operation: SpecialPaste.
//
// Revision 1.13  2003/12/02 18:09:32  law
// - добавлен обработчик TableInsertTest.
//
// Revision 1.12  2003/12/02 17:40:53  law
// - new operations: Edit.Cut, Copy, Paste, Delete.
//
// Revision 1.11  2003/12/02 17:18:52  law
// - new operations: Font.Italic, Underline, Strikeout.
//
// Revision 1.10  2003/12/02 17:08:14  law
// - new operation: Font.Bold.
//
// Revision 1.9  2003/12/02 16:37:26  law
// - new operations: View.ShowSpecial.
//
// Revision 1.8  2003/12/02 16:31:01  law
// - new operations: Edit.Undo, Edit.Redo.
//
// Revision 1.7  2003/12/02 16:25:15  law
// - new operation: Table.Insert.
//
// Revision 1.6  2003/12/02 16:08:32  law
// - new operation: SaveAs.
//
// Revision 1.5  2003/12/02 16:01:06  law
// - new operation: Save.
//
// Revision 1.4  2003/12/02 15:35:46  law
// - new operation: Open.
//
// Revision 1.3  2003/12/02 15:11:35  law
// - реализована операция New.
//
// Revision 1.2  2003/12/02 14:59:51  law
// - выставлены директивы CVS.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities,
  vcmBaseEntities, OvcBase,  evEditorWindow, evEditor,
  l3InterfacedComponent, l3ProgressComponent, evTextSource,
  evMultiSelectEditorWindow, evTextSource, vcmComponent;

type
  TevpText = class(TvcmEntityForm)
      Entities : TvcmEntities;
    Editor: TevEditor;
    TextSource: TevTextSource;
    procedure vcmEntityFormInit(const aParams: IvcmParams);
    procedure FileSaveTest(const aParams: IvcmParams);
    procedure FileSaveExecute(var aParams: IvcmParams);
    procedure FileSaveAsExecute(var aParams: IvcmParams);
    procedure TableInsertExecute(var aParams: IvcmParams);
    procedure EditUndoTest(const aParams: IvcmParams);
    procedure EditUndoExecute(var aParams: IvcmParams);
    procedure EditRedoTest(const aParams: IvcmParams);
    procedure EditRedoExecute(var aParams: IvcmParams);
    procedure ViewShowSpecialTest(const aParams: IvcmParams);
    procedure ViewShowSpecialExecute(var aParams: IvcmParams);
    procedure FontBoldTest(const aParams: IvcmParams);
    procedure FontBoldExecute(var aParams: IvcmParams);
    procedure FontItalicTest(const aParams: IvcmParams);
    procedure FontItalicExecute(var aParams: IvcmParams);
    procedure FontUnderlineTest(const aParams: IvcmParams);
    procedure FontUnderlineExecute(var aParams: IvcmParams);
    procedure FontStrikeOutTest(const aParams: IvcmParams);
    procedure FontStrikeOutExecute(var aParams: IvcmParams);
    procedure EditCutTest(const aParams: IvcmParams);
    procedure EditCutExecute(var aParams: IvcmParams);
    procedure EditCopyTest(const aParams: IvcmParams);
    procedure EditCopyExecute(var aParams: IvcmParams);
    procedure EditPasteTest(const aParams: IvcmParams);
    procedure EditPasteExecute(var aParams: IvcmParams);
    procedure EditDeleteTest(const aParams: IvcmParams);
    procedure EditDeleteExecute(var aParams: IvcmParams);
    procedure TableInsertTest(const aParams: IvcmParams);
    procedure EditSpecialPasteExecute(var aParams: IvcmParams);
    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation

uses
  ClipBrd,

  evLoadDocumentManager,
  evSaveDocumentManager,

  evExtDlgInsertTable,
  evExtDlgSpecialPaste,

  StdRes
  ;

{$R *.DFM}

procedure TevpText.vcmEntityFormInit(const aParams: IvcmParams);
var
 l_Manager : TevCustomLoadDocumentManager;
begin
 if (aParams.Count < 1) then
 begin
  Caption := 'Новый';
  TextSource.New;
 end
 else
 begin
  l_Manager := (aParams.AsIU[0] As IvcmHolder).Target As TevCustomLoadDocumentManager;
  l_Manager.Load(TextSource);
  Caption := TextSource.FileName;
 end;//aParams.Count < 1
end;

procedure TevpText.FileSaveTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := Editor.TextSource.Modified;
end;

procedure TevpText.FileSaveExecute(var aParams: IvcmParams);
var
 l_Manager : TevCustomSaveDocumentManager;
 l_Name    : String;
begin
 with Dispatcher.ModuleOperation(mop_evpDocument_GetSaveManager) do
  if Done then
  begin
   l_Manager := (AsIU[0] As IvcmHolder).Target As TevCustomSaveDocumentManager;
   l_Name := l_Manager.Save(TextSource);
   if (l_Name <> '') then
    Caption := l_Name;
  end;//Done
end;

procedure TevpText.FileSaveAsExecute(var aParams: IvcmParams);
var
 l_Name : String;
begin
 with TextSource do
 begin
  l_Name := FileName;
  try
   FileName := '';
   Operation(op_File_Save);
  finally
   if (FileName = '') then
    TextSource.FileName := l_Name;
  end;//try..finally
 end;//with TextSource
end;

procedure TevpText.TableInsertExecute(var aParams: IvcmParams);
begin
 evExtDlgInsertTable.Execute(Editor);
end;

procedure TevpText.EditUndoTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := Editor.CanUndo;
end;

procedure TevpText.EditUndoExecute(var aParams: IvcmParams);
begin
 Editor.Processor.Undo;
end;

procedure TevpText.EditRedoTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := Editor.CanRedo;
end;

procedure TevpText.EditRedoExecute(var aParams: IvcmParams);
begin
 Editor.Processor.Redo;
end;

procedure TevpText.ViewShowSpecialTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opChecked] := Editor.Canvas.DrawSpecial;
end;

procedure TevpText.ViewShowSpecialExecute(var aParams: IvcmParams);
begin
 with Editor.Canvas do
  DrawSpecial := not DrawSpecial;
end;

procedure TevpText.FontBoldTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opChecked] := Editor.TextPara.Font.Bold;
end;

procedure TevpText.FontBoldExecute(var aParams: IvcmParams);
begin
 with Editor.TextPara.Font do
  Bold := not Bold;
end;

procedure TevpText.FontItalicTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opChecked] := Editor.TextPara.Font.Italic;
end;

procedure TevpText.FontItalicExecute(var aParams: IvcmParams);
begin
 with Editor.TextPara.Font do
  Italic := not Italic;
end;

procedure TevpText.FontUnderlineTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opChecked] := Editor.TextPara.Font.Underline;
end;

procedure TevpText.FontUnderlineExecute(var aParams: IvcmParams);
begin
 with Editor.TextPara.Font do
  Underline := not Underline;
end;

procedure TevpText.FontStrikeOutTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opChecked] := Editor.TextPara.Font.StrikeOut;
end;

procedure TevpText.FontStrikeOutExecute(var aParams: IvcmParams);
begin
 with Editor.TextPara.Font do
  StrikeOut := not StrikeOut;
end;

procedure TevpText.EditCutTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := not Editor.ReadOnly AND Editor.HasSelection;
end;

procedure TevpText.EditCutExecute(var aParams: IvcmParams);
begin
 Editor.Cut;
end;

procedure TevpText.EditCopyTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := Editor.HasSelection;
end;

procedure TevpText.EditCopyExecute(var aParams: IvcmParams);
begin
 Editor.Copy;
end;

procedure TevpText.EditPasteTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] :=
  not Editor.ReadOnly AND (Clipboard.FormatCount > 0);
end;

procedure TevpText.EditPasteExecute(var aParams: IvcmParams);
begin
 Editor.Paste;
end;

procedure TevpText.EditDeleteTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := not Editor.ReadOnly AND Editor.HasSelection;
end;

procedure TevpText.EditDeleteExecute(var aParams: IvcmParams);
begin
 Editor.Range.Delete;
end;

procedure TevpText.TableInsertTest(const aParams: IvcmParams);
begin
 aParams.AsBool[vcm_opEnabled] := not Editor.ReadOnly;
end;

procedure TevpText.EditSpecialPasteExecute(var aParams: IvcmParams);
begin
 evExtDlgSpecialPaste.Execute(Editor);
end;

end.
