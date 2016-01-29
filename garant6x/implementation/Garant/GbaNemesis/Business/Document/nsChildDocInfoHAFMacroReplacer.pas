unit nsChildDocInfoHAFMacroReplacer;

{ $Id: nsChildDocInfoHAFMacroReplacer.pas,v 1.3 2009/12/09 16:33:47 lulin Exp $ }

// $Log: nsChildDocInfoHAFMacroReplacer.pas,v $
// Revision 1.3  2009/12/09 16:33:47  lulin
// - рисуем контейнер документа на модели и правим зависимости.
//
// Revision 1.2  2009/12/07 17:20:14  lulin
// - переносим "интерфейсы обмена данными" в правильные места.
//
// Revision 1.1  2009/09/14 11:28:38  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.5  2009/01/13 08:11:13  oman
// - new: Новый макрос для колонтитулов (К-121144891)
//
// Revision 1.4  2008/12/29 09:00:49  oman
// - fix: Правильней готовим MacroReplacer для зоны (К-122675365)
//
// Revision 1.3  2008/12/26 14:00:13  oman
// - fix: подключаем MacroReplacer (К-122675365)
//
// Revision 1.2  2008/12/26 09:37:29  oman
// - fix: первоначальная реализация MacroReplacer (К-122675365)
//
// Revision 1.1  2008/12/26 08:59:09  oman
// - fix: первоначальная реализация MacroReplacer (К-122675365)
//
//

{$Include nsDefine.inc }

interface

uses
 l3Interfaces,
 l3InternalInterfaces,

 evCustomHAFMacroReplacer,

 DocumentInterfaces,
 DocumentAndListInterfaces
 ;

type
 TnsChildDocInfoHAFMacroReplacer = class(TevCustomHAFMacroReplacer)
 private
  f_DocInfo: IdeDocInfo;
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
  constructor Create(const aParent: Il3HAFMacroReplacer; const aDocInfo: IdeDocInfo);
   reintroduce;
   {-}
  class function Make(const aParent: Il3HAFMacroReplacer; const aDocInfo: IdeDocInfo): Il3HAFMacroReplacer;
   reintroduce;
   {-}
 end;

implementation

uses
 l3String,
 l3Base,

 evHAFPainterMacros,

 bsUtils
 ;

{ TnsChildDocInfoHAFMacroReplacer }

procedure TnsChildDocInfoHAFMacroReplacer.Cleanup;
begin
 f_DocInfo := nil;
 inherited Cleanup;
end;

constructor TnsChildDocInfoHAFMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer; const aDocInfo: IdeDocInfo);
begin
 inherited Create(aParent);
 f_DocInfo := aDocInfo;
end;

function TnsChildDocInfoHAFMacroReplacer.DoUnfold(
  const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;
begin
 if l3Same(aMacroName, l3CStr(SInternalNumber)) then
  Result := f_DocInfo.InternalNumber
 else
  if l3Same(aMacroName, l3CStr(SDataSize)) then
   Result := f_DocInfo.DataSize
  else
   if l3Same(aMacroName, l3CStr(SFilePosition)) then
    Result := f_DocInfo.FilePosition
   else 
    Result := aValue;
end;

class function TnsChildDocInfoHAFMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer;
  const aDocInfo: IdeDocInfo): Il3HAFMacroReplacer;
var
 l_Inst: TnsChildDocInfoHAFMacroReplacer;
begin
 l_Inst := Create(aParent, aDocInfo);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

function TnsChildDocInfoHAFMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SDocName), aText);
 Result := CheckMacro(l3CStr(SDocFullName), Result);
 Result := CheckMacro(l3CStr(SInternalNumber), Result);
 Result := CheckMacro(l3CStr(SDataSize), Result);
 Result := CheckMacro(l3CStr(SFilePosition), Result);
end;

end.

