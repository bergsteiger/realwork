unit evScript;

{ Ѕиблиотека "Ёверест"    }
{ Ќачал: Ћюлин ј.¬.       }
{ ћодуль: evScript -      }
{ Ќачат: 03.10.2007 21:11 }
{ $Id: evScript.pas,v 1.1 2007/12/04 13:04:55 lulin Exp $ }

// $Log: evScript.pas,v $
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объедин€ем два каталога с исходниками Ёвереста.
//
// Revision 1.11  2007/10/04 16:40:02  lulin
// - сделано сохранение.
//
// Revision 1.10  2007/10/04 16:30:12  lulin
// - определ€ем количество параметров.
//
// Revision 1.9  2007/10/04 15:51:15  lulin
// - не переносим фокус.
//
// Revision 1.8  2007/10/04 15:46:55  lulin
// - добавлены параметры команд.
//
// Revision 1.7  2007/10/04 14:48:55  lulin
// - добавлены алиасы.
//
// Revision 1.6  2007/10/04 14:30:16  lulin
// - сделана передача строкового параметра.
//
// Revision 1.5  2007/10/04 14:04:53  lulin
// - определ€ем пространства имен.
//
// Revision 1.4  2007/10/03 18:14:15  lulin
// - добавлено управление выделением и отмена/возврат.
//
// Revision 1.3  2007/10/03 18:02:20  lulin
// - сделана вставка/удаление колонок.
//
// Revision 1.2  2007/10/03 17:56:35  lulin
// - сделана вставка таблицы и вставка/удаление ее строк.
// - сделан переход на начало/конец документа.
//
// Revision 1.1  2007/10/03 17:23:46  lulin
// - выдел€ем команды редактора.
//

{$Include evDefine.inc }

interface

uses
  l3Script
  ;

procedure DefineOps(S: Tl3Script);
  {-}

implementation

uses
  Windows,

  Forms,

  l3Types,
  l3String,
  l3Chars,

  k2Tags,

  evTypes,
  
  evCustomEditor,

  evLoadDocumentManager,
  evSaveDocumentManager
  ;

var
  LM : TevLoadDocumentManager = nil;

procedure OpLoad(const aCtx: Tl3OpContext);
var
 l_T : Int64;
begin
 if (LM = nil) then
  LM := TevLoadDocumentManager.Create(Application);
 if not l3IsNil(aCtx.rTail) then
  LM.FileName := l3PCharLen2String(aCtx.rTail.AsWStr);
 if LM.QueryName then
 begin
  l_T := GetTickCount;
  LM.Load(TevCustomEditor(aCtx.rTarget).TextSource, k2_idDocument);
  l_T := GetTickCount - l_T;
  aCtx.rCon.Say(l3Fmt('%s ms', [l_T]));
  //TevCustomEditor(aCtx.rTarget).SetFocus;
 end;//LM.QueryName
end;

var
 SM : TevSaveDocumentManager = nil;

procedure OpSave(const aCtx: Tl3OpContext);
begin
 if (SM = nil) then
  SM := TevSaveDocumentManager.Create(Application);
 SM.Save(TevCustomEditor(aCtx.rTarget).TextSource, nil)
end;

procedure OpSaveAs(const aCtx: Tl3OpContext);
begin
 if (SM = nil) then
  SM := TevSaveDocumentManager.Create(Application);
 TevCustomEditor(aCtx.rTarget).TextSource.FileName := ''; 
 SM.Save(TevCustomEditor(aCtx.rTarget).TextSource, nil)
end;

procedure OpShowSpec(const aCtx: Tl3OpContext);
begin
 TevCustomEditor(aCtx.rTarget).Canvas.DrawSpecial := true;
end;

procedure OpHideSpec(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).Canvas.DrawSpecial := false;
end;

procedure OpToggleSpec(const aForm: Tl3OpContext);
begin
 with TevCustomEditor(aForm.rTarget).Canvas do
  DrawSpecial := not DrawSpecial;
end;

procedure InsertTable(const aCtx: Tl3OpContext);
var
 l_P : TLongArray;
begin
 l_P := aCtx.IntParams;
 TevCustomEditor(aCtx.rTarget).InsertTable(l_P[0], l_P[1]);
end;

procedure InsertRow(const aCtx: Tl3OpContext);
begin
 TevCustomEditor(aCtx.rTarget).InsertRow(aCtx.IntParams[0]);
end;

procedure DeleteRow(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).DeleteRow;
end;

procedure InsertColumn(const aCtx: Tl3OpContext);
begin
 TevCustomEditor(aCtx.rTarget).InsertColumn(aCtx.IntParams[0]);
end;

procedure DeleteColumn(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).DeleteColumn;
end;

procedure Top(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).GotoTop;
end;

procedure Bottom(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).GotoBottom;
end;

procedure SelectAll(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).Select(ev_stDocument);
end;

procedure Unselect(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).Selection.Unselect;
end;

procedure Undo(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).Processor.Undo;
end;

procedure Redo(const aForm: Tl3OpContext);
begin
 TevCustomEditor(aForm.rTarget).Processor.Redo;
end;

procedure DefineOps(S: Tl3Script);
  {-}
begin
 S.Add('load', OpLoad, TevCustomEditor);
 S.Add('save', OpSave, TevCustomEditor);
 S.Add('saveas', OpSaveAs, TevCustomEditor);
 with S.Space('spec') do
 begin
  Add('hide', OpHideSpec, TevCustomEditor);
  Add('show', OpShowSpec, TevCustomEditor);
  Add('toggle', OpToggleSpec, TevCustomEditor);
 end;//with S.Space('spec')
 with S.Space('table') do
 begin
  Add('insert', InsertTable, TevCustomEditor).DefParams(2, 3).Alias('ins');
 end;//with S.Space('table')
 with S.Space('row') do
 begin
  Add('insert', InsertRow, TevCustomEditor).DefParams(1, 1).Alias('ins');
  Add('delete', DeleteRow, TevCustomEditor).Alias('del');
 end;//with S.Space('row')
 with S.Space('col') do
 begin
  Add('insert', InsertColumn, TevCustomEditor).DefParams(1, 1).Alias('ins');
  Add('delete', DeleteColumn, TevCustomEditor).Alias('del');
 end;//with S.Space('col')
 with S.Space('go') do
 begin
  Add('top', Top, TevCustomEditor);
  Add('bottom', Bottom, TevCustomEditor);
 end;//with S.Space('go')
 with S.Space('doc') do
 begin
  Add('sel', SelectAll, TevCustomEditor);
 end;//with S.Space('doc')
 S.Add('unselect', Unselect, TevCustomEditor);
 S.Add('undo', Undo, TevCustomEditor);
 S.Add('redo', Redo, TevCustomEditor);
end;

end.

