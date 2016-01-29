unit evCustomHAFMacroReplacer;

{ Библиотека "Эверест"    }
{ Начал: Лукьянец Р.В.       }
{ Модуль: evCustomHAFMacroReplacer.pas - }
{ Начат: 26.12.2008 }
{ $Id: evCustomHAFMacroReplacer.pas,v 1.2 2013/12/26 14:10:27 lulin Exp $ }

// $Log: evCustomHAFMacroReplacer.pas,v $
// Revision 1.2  2013/12/26 14:10:27  lulin
// {RequestLink:509706011}
//
// Revision 1.1  2010/06/23 18:05:49  lulin
// {RequestLink:219124975}.
//
// Revision 1.2  2008/12/26 14:38:31  lulin
// - bug fix: боремся с бесконечным циклом.
//
// Revision 1.1  2008/12/26 08:57:55  oman
// - fix: первоначальная реализация MacroReplacer (К-122675365)
//
//

{$Include evDefine.inc }

interface

uses
 l3Base,
 l3InternalInterfaces,
 l3Interfaces,
 l3ProtoObject
 ;

type
 TevCustomHAFMacroReplacer = class(Tl3ProtoObject, Il3HAFMacroReplacer)
 private
  f_Parent: Il3HAFMacroReplacer;
 protected
 // Il3HAFMacroReplacer
  function Get_Parent: Il3HAFMacroReplacer;
  procedure Set_Parent(const aValue: Il3HAFMacroReplacer);
   {-}
  function Replace(const aText: Il3CString): Il3CString;
   {-}
  function UnfoldOne(const aMacroName: Il3CString): Il3CString;
   {-}
 private
  function HasCycles(const aParent: Il3HAFMacroReplacer): Boolean;
   {-}
 protected
  function DoUnfold(const aMacroName: Il3CString; const aValue: Il3CString):  Il3CString;
   virtual;
   {-}
  function DoReplace(const aText: Il3CString): Il3CString;
   virtual;
   {-}
  procedure Cleanup;
   override;
   {-}
  function CheckMacro(const aMacroName: Il3CString; const aText: Il3CSTring): Il3CString;
   {-}
 public
  constructor Create(const aParent: Il3HAFMacroReplacer);
   reintroduce;
   {-}
  class function Make(const aParent: Il3HAFMacroReplacer): Il3HAFMacroReplacer;
   {-}
  public
   property Parent: Il3HAFMacroReplacer
     read Get_Parent
     write Set_Parent;
   {-}
 end;

implementation

uses
 SysUtils,

 l3InterfacesMisc,
 l3String
 ;

{ TevCustomHAFMacroReplacer }

function TevCustomHAFMacroReplacer.CheckMacro(const aMacroName,
  aText: Il3CSTring): Il3CString;
begin
 Result := l3StringReplace(aText, aMacroName.AsWStr, UnfoldOne(aMacroName), [rfReplaceAll]);
end;

procedure TevCustomHAFMacroReplacer.Cleanup;
begin
 f_Parent := nil;
 inherited Cleanup;
end;

constructor TevCustomHAFMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer);
begin
 inherited Create;
 Parent := aParent;
end;

function TevCustomHAFMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := aText;
end;

function TevCustomHAFMacroReplacer.DoUnfold(
  const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;
begin
 Result := aMacroName;
end;

function TevCustomHAFMacroReplacer.Get_Parent: Il3HAFMacroReplacer;
begin
 Result := f_Parent;
end;

function TevCustomHAFMacroReplacer.HasCycles(
  const aParent: Il3HAFMacroReplacer): Boolean;
var
 l_Parent: Il3HAFMacroReplacer;
begin
 Result := False;
 l_Parent := aParent;
 while Assigned(l_Parent) do
  if l3IEQ(l_Parent, Self) then
  begin
   Result := True;
   Exit;
  end
  else
   l_Parent := l_Parent.Parent;
end;

class function TevCustomHAFMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer): Il3HAFMacroReplacer;
var
 l_Inst: TevCustomHAFMacroReplacer;
begin
 l_Inst := Create(aParent);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

function TevCustomHAFMacroReplacer.Replace(
  const aText: Il3CString): Il3CString;
begin
 Result := DoReplace(aText);
 if Assigned(Parent) then
  Result := Parent.Replace(Result);
end;

procedure TevCustomHAFMacroReplacer.Set_Parent(
  const aValue: Il3HAFMacroReplacer);
begin
 if not l3IEQ(f_Parent, aValue) then
 begin
  Assert(not HasCycles(aValue));
  f_Parent := aValue;
 end;
end;

function TevCustomHAFMacroReplacer.UnfoldOne(
  const aMacroName: Il3CString): Il3CString;
begin
 if Assigned(Parent) then
  Result := Parent.UnfoldOne(aMacroName)
 else
  Result := aMacroName;
 Result := DoUnfold(aMacroName, Result);
end;

end.

