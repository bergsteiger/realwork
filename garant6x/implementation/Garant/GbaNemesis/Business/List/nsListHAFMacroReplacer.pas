unit nsListHAFMacroReplacer;

{ $Id: nsListHAFMacroReplacer.pas,v 1.3 2010/03/02 13:34:24 lulin Exp $ }

// $Log: nsListHAFMacroReplacer.pas,v $
// Revision 1.3  2010/03/02 13:34:24  lulin
// {RequestLink:193823544}.
//
// Revision 1.2  2010/03/02 11:15:02  lulin
// {RequestLink:193823544}.
//
// Revision 1.1  2009/09/14 11:28:41  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.3  2009/03/04 08:07:36  oman
// - fix: Не раскрывали длинное имя списка
//
// Revision 1.2  2008/12/26 14:00:20  oman
// - fix: подключаем MacroReplacer (К-122675365)
//
// Revision 1.1  2008/12/26 08:59:08  oman
// - fix: первоначальная реализация MacroReplacer (К-122675365)
//
//

{$Include nsDefine.inc }

interface

uses
 l3Interfaces,
 l3InternalInterfaces,

 DynamicDocListUnit,

 evCustomHAFMacroReplacer ;

type
 TnsListHAFMacroReplacer = class(TevCustomHAFMacroReplacer)
 private
  f_List: IDynList;
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
  constructor Create(const aParent: Il3HAFMacroReplacer; const aList: IDynList);
   reintroduce;
   {-}
  class function Make(const aParent: Il3HAFMacroReplacer; const aList: IDynList): Il3HAFMacroReplacer;
   reintroduce;
   {-}
 end;

implementation

uses
 l3String,
 l3Base,

 evHAFPainterMacros,
 nevInterfaces,

 nsValueMaps,

 bsUtils
 ;

{ TnsListHAFMacroReplacer }

procedure TnsListHAFMacroReplacer.Cleanup;
begin
 f_List := nil;
 inherited;
end;

constructor TnsListHAFMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer; const aList: IDynList);
begin
 inherited Create(aParent);
 f_List := aList;
end;

function TnsListHAFMacroReplacer.DoUnfold(
  const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;
begin
 if l3Same(aMacroName, l3CStr(SDocName)) then
  Result := bsShortListName(f_List)
 else
  if l3Same(aMacroName, l3CStr(SDocFullName)) then
   Result := bsListName(f_List)
  else
   if l3Same(aMacroName, l3CStr(SDocRedactionDate)) then
    Result := nil
   else
    if l3Same(aMacroName, l3CStr(SInternalNumber)) then
     Result := str_nevpmUndefinedSize.AsCStr
    else
     if l3Same(aMacroName, l3CStr(SDataSize)) then
      Result := str_nevpmUndefinedTopic.AsCStr
     else
      Result := aValue;
end;

class function TnsListHAFMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer;
  const aList: IDynList): Il3HAFMacroReplacer;
var
 l_Inst: TnsListHAFMacroReplacer;
begin
 l_Inst := Create(aParent, aList);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

function TnsListHAFMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SDocName), aText);
 Result := CheckMacro(l3CStr(SDocFullName), Result);
 Result := CheckMacro(l3CStr(SDocRedactionDate), Result);
 Result := CheckMacro(l3CStr(SInternalNumber), Result);
 Result := CheckMacro(l3CStr(SDataSize), Result);
end;

end.

