unit evFormatHAFMacroReplacer;

{ Библиотека "Эверест"    }
{ Начал: Лукьянец Р.В.       }
{ Модуль: evFormatHAFMacroReplacer.pas - }
{ Начат: 26.12.2008 }                              
{ $Id: evFormatHAFMacroReplacer.pas,v 1.1 2009/09/14 11:27:56 lulin Exp $ }

// $Log: evFormatHAFMacroReplacer.pas,v $
// Revision 1.1  2009/09/14 11:27:56  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.1  2008/12/26 08:57:55  oman
// - fix: первоначальная реализация MacroReplacer (К-122675365)
//
//

{$Include evDefine.inc }

interface

uses
 l3Interfaces,
 l3InternalInterfaces,

 evCustomHAFMacroReplacer
 ;

type
 TevFormatHAFMacroReplacer = class(TevCustomHAFMacroReplacer)
 private
  f_Format: Il3CString;
 protected
  function DoReplace(const aText: Il3CString): Il3CString;
   override;
   {-}
  function DoUnfold(const aMacroName: Il3CString; const aValue: Il3CString):  Il3CString;
   override;
   {-}
  procedure Cleanup;
   override;
   {-}
 public
  constructor Create(const aParent: Il3HAFMacroReplacer; const aFormat: Il3CString);
   reintroduce;
   {-}
  class function Make(const aParent: Il3HAFMacroReplacer; const aFormat: Il3CString): Il3HAFMacroReplacer;
   reintroduce;
   {-}
 end;

implementation

uses
 l3String,
 l3Base,

 evHAFPainterMacros
 ;

{ TevFormatHAFMacroReplacer }

procedure TevFormatHAFMacroReplacer.Cleanup;
begin
 f_Format := nil;
 inherited Cleanup;
end;

constructor TevFormatHAFMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer; const aFormat: Il3CString);
begin
 inherited Create(aParent);
 f_Format := aFormat;
end;

function TevFormatHAFMacroReplacer.DoUnfold(
  const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;
begin
 if l3Same(aMacroName, l3CStr(SDocName)) or
    l3Same(aMacroName, l3CStr(SDocFullName)) then
  Result := l3Fmt(f_Format, [aValue])
 else
  Result := aValue;
end;

class function TevFormatHAFMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer;
  const aFormat: Il3CString): Il3HAFMacroReplacer;
var
 l_Inst: TevFormatHAFMacroReplacer;
begin
 l_Inst := Create(aParent, aFormat);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

function TevFormatHAFMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SDocName), aText);
 Result := CheckMacro(l3CStr(SDocFullName), Result);
end;

end.

