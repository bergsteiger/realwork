unit evAutoComplete;

{ $Id: evAutoComplete.pas,v 1.26 2014/07/21 13:10:42 dinishev Exp $}

// $Log: evAutoComplete.pas,v $
// Revision 1.26  2014/07/21 13:10:42  dinishev
// {Requestlink:556758667}
//
// Revision 1.25  2014/02/14 15:33:32  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.24  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.23  2009/07/14 14:56:25  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.22  2008/10/15 10:32:49  lulin
// - <K>: 121149970.
//
// Revision 1.21  2008/10/01 11:13:29  lulin
// - <K>: 120718563.
//
// Revision 1.20  2008/04/10 17:34:24  lulin
// - <K>: 89097983.
//
// Revision 1.19  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.18  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.17  2008/02/20 17:22:54  lulin
// - упрощаем строки.
//
// Revision 1.16  2008/02/05 09:57:37  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.15  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.13.2.4  2007/06/20 09:23:55  dinishev
// bug fix: не компилировалось
//
// Revision 1.13.2.3  2006/02/07 15:16:22  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.13.2.2  2005/11/09 15:28:22  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.13.2.1  2005/05/18 12:42:45  lulin
// - отвел новую ветку.
//
// Revision 1.11.4.1  2005/05/18 12:32:07  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.13  2005/05/17 11:19:24  lulin
// - cleanup: возвращаем более общий интерфейс.
//
// Revision 1.12  2005/05/16 15:31:11  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.11  2004/12/23 11:42:04  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.10  2004/12/23 08:40:25  lulin
// - вычищен ненужный модуль.
//
// Revision 1.9  2004/09/21 12:55:39  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2004/07/13 09:25:15  fireton
// - bug fix: не создавался файл настроек автозамены по умолчанию
//
// Revision 1.7  2004/07/06 11:43:02  fireton
// - change: возможность использования регекспов в автозамене
//
// Revision 1.6  2004/07/05 08:36:30  fireton
// - bug fix: корректная вставка текста (через блок)
//
// Revision 1.5  2004/07/02 13:13:39  fireton
// - change: избавление от глобальных процедур в автозамене
//
// Revision 1.4  2004/07/02 07:23:31  voba
// -add aACFileName in InitAutoComplete
//
// Revision 1.3  2004/06/30 12:58:55  fireton
// - доработка функционала для прикручивания автозамены к редактору
//

interface

uses l3Base, evTypes, evEditor,
  l3ObjectRefList,
  l3StringList
  ;

type
 IevAutoComplete = interface(IUnknown)
 ['{36C9FC78-717C-42CC-AB73-D85F7AF1530C}']
  function  AddMacro(aMacro, aReplacement: string; aRegExp: Boolean = True): Integer;
  function  DeleteMacro(aMacro: string): Boolean;
  function  FindMacro(aMacro: string; out Replacement: string; out RegExp: Boolean): Boolean;
  function  SetRegExp(aMacro: string; aRegExp: Boolean): Boolean;
  procedure Apply(aEditor: TevEditor);
 end;

 TevAutoComplete = class(Tl3Base, IevAutoComplete)
 private
  FFileName: string;
  FMacroList: Tl3StringList;
  function LocateMacro(aMacro: string): Integer;
  procedure SetFileName(const Value: string);
 public
  constructor Create(aFileName: string = ''); reintroduce;
  {$IFDEF nsTest}
  procedure ClearDataAndSave;
  {$ENDIF nsTest}
  procedure Cleanup; override;
  function AddMacro(aMacro, aReplacement: string; aRegExp: Boolean = True): Integer;
  procedure Apply(aEditor: TevEditor);
  function DeleteMacro(aMacro: string): Boolean;
  function FindMacro(aMacro: string; out Replacement: string; out RegExp: Boolean): Boolean;
  procedure LoadFromFile; virtual;
  procedure SaveToFile; virtual;
  function SetRegExp(aMacro: string; aRegExp: Boolean): Boolean;
  property FileName: string read FFileName write SetFileName;
  property MacroList: Tl3StringList read FMacroList;
 end;

  TevACMacro = class (Tl3String)
  private
   FRegExp: Boolean;
   FReplacement: string;
   function GetMacro: string;
   procedure SetMacro(const Value: string);
  public
   constructor Create(aMacro: string; aReplacement: string; aRegExp: Boolean); reintroduce;
   property RegExp: Boolean read FRegExp write FRegExp;
   property Macro: string read GetMacro write SetMacro;
   property Replacement: string read FReplacement write FReplacement;
 end;

var
 AutoComplete: TevAutoComplete;

implementation

uses 
  SysUtils, 
  Forms, 
  
  l3String, 
  l3IniFile, 
  l3Interfaces,
  l3InterfacedString, 

  evOp, 
  evSearch, 
  evEditorWindow, 
  evInternalInterfaces,
  evParaTools,

  nevTools,
  nevConfirm
  ;

type
 TACStorageRec = record
  Macro: string[255];
  Relpacement: string[255];
  RegExp: Boolean;
 end;

var
 ACFileName: string;

constructor TevAutoComplete.Create(aFileName: string = '');
begin
 inherited Create;
 FMacroList := Tl3StringList.MakeSorted;
 fFileName := '\@Empty@\';
 FileName := aFileName;
end;

function TevAutoComplete.AddMacro(aMacro, aReplacement: string; aRegExp: Boolean = True): Integer;
var
 l_Index : Integer;
 l_Macro : TevACMacro;
begin
 l_Index := LocateMacro(aMacro);
 if l_Index = -1 then
 begin
  l_Macro := TevACMacro.Create(aMacro, aReplacement, aRegExp);
  try
   Result := FMacroList.Add(l_Macro)
  finally
   l3Free(l_Macro);
  end;//try..finally
 end
 else
 begin
  TevACMacro(FMacroList[l_Index]).Replacement := aReplacement;
  Result := l_Index;
 end;
end;

{$IFDEF nsTest}
procedure TevAutoComplete.ClearDataAndSave;
begin
 FMacroList.Clear;
 SaveToFile;
end;
{$ENDIF nsTest}


procedure TevAutoComplete.Apply(aEditor: TevEditor);
var
 I             : Integer;
 l_BlockStr    : Il3CString;
 l_Found       : Boolean;
 l_StartCur    : InevBasePoint;
 l_FinCur      : InevBasePoint;
 l_Macro       : TevACMacro;
 l_Str         : Tl3InterfacedString;
 l_RegExp      : Boolean;
 l_Block       : InevRange;
 l_OpPack      : InevOp;
 l_TxtSearcher : TevTextSearcher;
 l_TxtReplacer : TevTextReplacer;
 l_RegSearcher : TevRegularExpressionSearcher;
 l_RegReplacer : TevRegExpReplacer;
begin
 with aEditor do
 begin
  l_OpPack := StartOp(ev_ocUser+154);
  try
   l_TxtSearcher := TevTextSearcher.Create(nil);
   l_TxtReplacer := TevTextReplacer.Create(nil);
   l_TxtReplacer.Searcher := l_TxtSearcher;
   l_RegSearcher := TevRegularExpressionSearcher.Create(nil);
   l_RegReplacer := TevRegExpReplacer.Create(nil);
   l_RegReplacer.Searcher := l_RegSearcher;
   try
    Select(ev_stWord);
    l_Block := InevSelection(Selection).GetBlock;
    l_BlockStr := evAsString(l_Block.Data);
    l_Block.GetBorderPoints(l_StartCur, l_FinCur);
    l_Found := False;
    for I := 0 to MacroList.Count-1 do
    begin
     l_Macro := TevACMacro(MacroList.Items[I]);
     if l_Macro.RegExp then
     begin
      try
       l_RegSearcher.Text := l_Macro.Macro;
       l_RegReplacer.Text := l_Macro.Replacement;
       l_Block.SearchReplace(l_RegSearcher, l_RegReplacer, TnevConfirm.Make, l_StartCur, l_OpPack);
      except
       Continue;
      end; {try..except}
      l_Found := True;
      Break;
     end
     else
     begin
      if l3Same(l_BlockStr, l_Macro.Macro) then
      begin
       l_Str := Tl3InterfacedString.Make(l3PCharLen(l_Macro.Replacement));
       try
        l_Block.Text.Modify.InsertString(View, l_Str, l_OpPack, True, [misfDirect]);
       finally
        l3Free(l_Str);
       end;
       l_Found := True;
      end
     end;
    end;                
    if not l_Found then
     InevSelection(Selection).Unselect;
   finally
    l3Free(l_TxtSearcher);
    l3Free(l_TxtReplacer);
    l3Free(l_RegSearcher);
    l3Free(l_RegReplacer);
   end; {try..finally}
  finally
   l_OpPack := nil;
  end; {try..finally}
 end;
end;

function TevAutoComplete.DeleteMacro(aMacro: string): Boolean;
var
 l_Index: Integer;
begin
 l_Index := LocateMacro(aMacro);
 Result := l_Index <> -1;
 if Result then
  FMacroList.Delete(l_Index);
end;

function TevAutoComplete.FindMacro(aMacro: string; out Replacement: string; out RegExp: Boolean): Boolean;
var
 l_Index: Integer;
begin
 l_Index := LocateMacro(aMacro);
 Result := l_Index <> -1;
 if Result then
 begin
  Replacement := TevACMacro(FMacroList[l_Index]).Replacement;
  RegExp := TevACMacro(FMacroList[l_Index]).RegExp;
 end;
end;

procedure TevAutoComplete.LoadFromFile;
var
 I       : Integer;
 l_Count : Integer;
 l_SR    : TACStorageRec;
 l_Cfg   : TCfgList;
begin
 l_Cfg := TCfgList.Create(fFileName);
 try
  l_Cfg.Section := 'Settings';
  l_Count := l_Cfg.ReadParamIntDef('Count', 0) - 1;
  l_Cfg.Section := 'Items';
  FMacroList.Clear;
  for I := 0 to l_Count do
  begin
   l_Cfg.ReadParamRec('Item'+IntToStr(I), 'SSB', l_SR);
   AddMacro(l_SR.Macro, l_SR.Relpacement, l_SR.RegExp);
  end;
 finally
  l3Free(l_Cfg);
 end;
end;

function TevAutoComplete.LocateMacro(aMacro: string): Integer;
var
 I: Integer;
begin
 Result := -1;
 for I := 0 to Pred(FMacroList.Count) do
  if TevACMacro(FMacroList[I]).Macro = aMacro then
  begin
   Result := I;
   Break;
  end;
end;

procedure TevAutoComplete.Cleanup;
begin
 l3Free(FMacroList);
 inherited;
end;

procedure TevAutoComplete.SaveToFile;
var
 I     : Integer;
 l_SR  : TACStorageRec;
 l_Cfg : TCfgList;
begin
 l_Cfg := TCfgList.Create(fFileName);
 try
  l_Cfg.Section := 'Settings';
  l_Cfg.WriteParamInt('Count', FMacroList.Count);
  l_Cfg.DeleteSection('Items');
  l_Cfg.Section := 'Items';
  for I := 0 to Pred(FMacroList.Count) do
  begin
   l_SR.Macro := TevACMacro(FMacroList[I]).Macro;
   l_SR.Relpacement := TevACMacro(FMacroList[I]).Replacement;
   l_SR.RegExp := TevACMacro(FMacroList[I]).RegExp;
   l_Cfg.WriteParamRec('Item' + IntToStr(I), 'SSB', l_SR);
  end;
 finally
  l3Free(l_Cfg);
 end;
end;

function TevAutoComplete.SetRegExp(aMacro: string; aRegExp: Boolean): Boolean;
var
 l_Index: Integer;
begin
 l_Index := LocateMacro(aMacro);
 Result := l_Index <> -1;
 if Result then
  TevACMacro(FMacroList[l_Index]).RegExp := aRegExp;
end;

procedure TevAutoComplete.SetFileName(const Value: string);
begin
 if fFileName <> Value then
 begin
  if Value <> '' then
   FFileName := Value
  else
   FFileName := ExtractFilePath(Application.ExeName) + 'acomplete.ini'; 
  LoadFromFile;
 end;
end;

constructor TevACMacro.Create(aMacro: string; aReplacement: string; aRegExp: Boolean);
begin
 inherited Create;
 Macro := aMacro;
 Replacement := aReplacement;
 RegExp := aRegExp;
end;

function TevACMacro.GetMacro: string;
begin
 Result := AsString;
end;

procedure TevACMacro.SetMacro(const Value: string);
begin
 AsString := Value;
end;

end.
