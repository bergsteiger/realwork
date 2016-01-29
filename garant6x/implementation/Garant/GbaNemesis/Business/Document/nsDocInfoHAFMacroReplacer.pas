unit nsDocInfoHAFMacroReplacer;

{ $Id: nsDocInfoHAFMacroReplacer.pas,v 1.4 2009/12/09 16:33:47 lulin Exp $ }

// $Log: nsDocInfoHAFMacroReplacer.pas,v $
// Revision 1.4  2009/12/09 16:33:47  lulin
// - рисуем контейнер документа на модели и правим зависимости.
//
// Revision 1.3  2009/12/07 17:20:14  lulin
// - переносим "интерфейсы обмена данными" в правильные места.
//
// Revision 1.2  2009/09/29 13:44:08  lulin
// {RequestLink:159360578}. №34.
//
// Revision 1.1  2009/09/14 11:28:38  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.3  2009/01/13 08:11:13  oman
// - new: Новый макрос для колонтитулов (К-121144891)
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

{$If not (defined(Monitorings) or defined(Admin))}
uses
 l3Interfaces,
 l3InternalInterfaces,

 evCustomHAFMacroReplacer,

 DocumentInterfaces,
 DocumentAndListInterfaces
 ;

type
 TnsDocInfoHAFMacroReplacer = class(TevCustomHAFMacroReplacer)
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
{$IfEnd} 

implementation

{$If not (defined(Monitorings) or defined(Admin))}
uses
 l3String,
 l3Base,
 l3Chars,

 evHAFPainterMacros,

 bsUtils
 ;

{ TnsDocInfoHAFMacroReplacer }

procedure TnsDocInfoHAFMacroReplacer.Cleanup;
begin
 f_DocInfo := nil;
 inherited Cleanup;
end;

constructor TnsDocInfoHAFMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer; const aDocInfo: IdeDocInfo);
begin
 inherited Create(aParent);
 f_DocInfo := aDocInfo;
end;

function TnsDocInfoHAFMacroReplacer.DoUnfold(
  const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;

 function lp_AddEditionWarning(const aStr: Il3CString): Il3CString;
 var
  l_Warning: Il3CString;
 begin
  l_Warning := bsCreatePrintEditionWarning(f_DocInfo.Doc);
  if not l3IsNil(l_Warning) then
   Result := l3Cat([l3Cat(aStr, cc_EOLStr), l_Warning])
  else
   Result := aStr;
 end;

begin
 if l3Same(aMacroName, l3CStr(SDocName)) then
  Result := lp_AddEditionWarning(f_DocInfo.DocShortName)
 else
  if l3Same(aMacroName, l3CStr(SDocFullName)) then
   Result := lp_AddEditionWarning(f_DocInfo.DocName)
  else
   if l3Same(aMacroName, l3CStr(SDocRedactionDate)) then
   begin
    if f_DocInfo.Doc.HasPrevRedaction or f_DocInfo.Doc.HasNextRedaction then
     Result := f_DocInfo.CurEditionName
    else
     Result := nil;
   end
   else
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

class function TnsDocInfoHAFMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer;
  const aDocInfo: IdeDocInfo): Il3HAFMacroReplacer;
var
 l_Inst: TnsDocInfoHAFMacroReplacer;
begin
 l_Inst := Create(aParent, aDocInfo);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

function TnsDocInfoHAFMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SDocName), aText);
 Result := CheckMacro(l3CStr(SDocFullName), Result);
 Result := CheckMacro(l3CStr(SDocRedactionDate), Result);
 Result := CheckMacro(l3CStr(SInternalNumber), Result);
 Result := CheckMacro(l3CStr(SDataSize), Result);
 Result := CheckMacro(l3CStr(SFilePosition), Result);
end;
{$IfEnd}

end.

