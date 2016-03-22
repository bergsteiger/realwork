unit l3Speller;

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Бабанин В.Б.                 }
{ Модуль: l3Speller - контейнер для нескольких лингвистических модулей}
{ Начат: 01.04.2009 }
{ $Id: l3Speller.pas,v 1.1 2016/02/15 16:07:49 voba Exp $ }

// $Log: l3Speller.pas,v $
// Revision 1.1  2016/02/15 16:07:49  voba
// no message
//

interface
uses
 SysUtils,
 l3Base,
 l3SpellMisc,
 l3SpellIntf,
 l3Interfaces,
 l3InterfaceList;

type
 Tl3Speller = class(Tl3Base, ISpeller)
 private
  fLingModules : Tl3InterfaceList;

 protected
  procedure Cleanup; override;
 public
  constructor Create; reintroduce;
  procedure AddModule(const aModule : ISpeller);

  function CheckSpell(const Word: UnicodeString): Boolean; overload;
  function CheckSpell(const Word: AnsiString): Boolean; overload;
  function CheckSpell(const Word: Tl3PCharLenPrim): Boolean; overload;

  procedure GetSuggestions(const Word: UnicodeString; aAddFunc : TllAddUStrProc); overload;
  procedure GetSuggestions(const Word: AnsiString; aAddFunc : TllAddStrProc); overload;
  procedure GetSuggestions(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc); overload;

 end;

 procedure SetSpeller(const aSpeller : ISpeller);
 procedure ReleaseSpeller;
 function  gSpeller : ISpeller;

implementation
 var
  lSpeller : ISpeller;

 constructor Tl3Speller.Create;
 begin
  inherited;
  fLingModules := Tl3InterfaceList.Create;
 end;

 procedure Tl3Speller.Cleanup;
 begin
  l3Free(fLingModules);
  inherited;
 end;

 procedure Tl3Speller.AddModule(const aModule : ISpeller);
 begin
  fLingModules.Add(aModule);
 end;

 function Tl3Speller.CheckSpell(const Word: UnicodeString): Boolean;
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   if ISpeller(fLingModules[I]).CheckSpell(Word) then
   begin
    Result := True;
    Exit;
   end;
  Result := false;
 end;

 function Tl3Speller.CheckSpell(const Word: AnsiString): Boolean;
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   if ISpeller(fLingModules[I]).CheckSpell(Word) then
   begin
    Result := True;
    Exit;
   end;
  Result := false;
 end;

 function Tl3Speller.CheckSpell(const Word: Tl3PCharLenPrim): Boolean;
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   if ISpeller(fLingModules[I]).CheckSpell(Word) then
   begin
    Result := True;
    Exit;
   end;
  Result := false;
 end;

 procedure Tl3Speller.GetSuggestions(const Word: UnicodeString; aAddFunc : TllAddUStrProc);
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   ISpeller(fLingModules[I]).GetSuggestions(Word, aAddFunc);
 end;

 procedure Tl3Speller.GetSuggestions(const Word: AnsiString; aAddFunc : TllAddStrProc);
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   ISpeller(fLingModules[I]).GetSuggestions(Word, aAddFunc);
 end;

 procedure Tl3Speller.GetSuggestions(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc);
 var
  I : integer;
 begin
  for I := 0 to Pred(fLingModules.Count) do
   ISpeller(fLingModules[I]).GetSuggestions(Word, aAddFunc);
 end;


function gSpeller : ISpeller;
begin
 Assert(lSpeller <> nil, 'Speller not initialized');
 Result := lSpeller;
end;

procedure SetSpeller(const aSpeller : ISpeller);
begin
 lSpeller := aSpeller;
end;

procedure ReleaseSpeller;
begin
 lSpeller := nil;
end;

initialization

finalization
 ReleaseSpeller;
end.
