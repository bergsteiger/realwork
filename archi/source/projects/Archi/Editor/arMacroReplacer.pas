unit arMacroReplacer;

{ $Id: arMacroReplacer.pas,v 1.3 2015/03/16 08:38:10 voba Exp $ }

{$Include evDefine.inc }

interface

uses
 DocIntf,

 l3Interfaces,
 l3InternalInterfaces,

 evCustomHAFMacroReplacer;

type
 TarMacroReplacer = class(TevCustomHAFMacroReplacer)
 private
  f_HasSelection : Boolean;
   {-}
  f_Document     : TarCustomDocument;
   {-}
 private
  function GetUrgencyStr: Il3CString;
   {-}
  function GetChDate: Il3CString;
   {-}
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
  constructor Create(const aParent   : Il3HAFMacroReplacer;
                     const aDocument : TarCustomDocument;
                     aHasSelection   : Boolean);
   reintroduce;
   {-}
  class function Make(const aParent   : Il3HAFMacroReplacer;
                      const aDocument : TarCustomDocument;
                      aHasSelection   : Boolean): Il3HAFMacroReplacer;
   reintroduce;
   {-}
 end;

implementation

uses
 SysUtils,

 l3Base,
 l3Date,
 l3Chars,
 l3DateSt,
 l3String,

 Dt_Types,
 Dt_Dict,
 Dt_Serv,
 Dt_LinkServ,

 DocAttrIntf,
 dt_AttrSchema,
 DictsSup,
 DocAttrUtils, DocAttrToolsIntf,

 arPrintMacros,
 arColontitulStr,

 evFacadTextSource,
 evHAFPainterMacros, dt_DictTypes;

{ TarDocInfoMacroReplacer }

procedure TarMacroReplacer.Cleanup;
begin
 f_Document := nil;
 inherited;
end;

constructor TarMacroReplacer.Create(const aParent   : Il3HAFMacroReplacer;
                                    const aDocument : TarCustomDocument;
                                    aHasSelection   : Boolean);
begin
 inherited Create(aParent);
 f_HasSelection := aHasSelection;
 f_Document := aDocument;
end;

function TarMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SUrgency), aText);
 Result := CheckMacro(l3CStr(SInternalNumber), Result);
 Result := CheckMacro(l3CStr(SDataSize), Result);
 Result := CheckMacro(l3CStr(SOtherDataSize), Result);
 Result := CheckMacro(l3CStr(SBaseName), Result);
 Result := CheckMacro(l3CStr(SDocRedactionDate), Result);
 Result := CheckMacro(l3CStr(SCurrentDate), Result);
end;

function TarMacroReplacer.DoUnfold(const aMacroName,
  aValue: Il3CString): Il3CString;
begin
 if l3Same(aMacroName, l3CStr(SUrgency)) then
  Result := GetUrgencyStr
 else
  if l3Same(aMacroName, l3CStr(SInternalNumber)) then
   Result := l3Fmt('%d %s', [LinkServer(f_Document.DocFamily).Renum.GetExtDocID(f_Document.DocID), cBlockStr[f_HasSelection]])
  else
   if l3Same(aMacroName, l3CStr(SDocRedactionDate)) then
    Result := GetChDate
   else
    if l3Same(aMacroName, l3CStr(SDataSize)) then
     Result := l3Fmt('%d', [evGetNettoCharCount(f_Document.TextSource)])
    else
     if l3Same(aMacroName, l3CStr(SOtherDataSize)) then
      Result := l3Fmt('%d', [Trunc(1.6 * evGetNettoCharCount(f_Document.TextSource))])
     else
      if l3Same(aMacroName, l3CStr(SBaseName)) then
       Result := l3CStr(f_Document.GetBasesStr)
      else
       if l3Same(aMacroName, l3CStr(SCurrentDate)) then
        Result := l3CStr(l3DateToStr(Now))
       else
        Result := aValue;
end;

function TarMacroReplacer.GetChDate: Il3CString;
var
 i           : Integer;
 l_ChDateStr : string;
 l_ChDate    : TstDate;
begin
 l_ChDateStr := '';
 l_ChDate := BadDate;
 if f_Document is TarDocument then
  l_ChDate := (TarDocument(f_Document).AttrManager.GetDocAttribute(atDateNums) as IDateNumDocAttributeTool).GetChDate;

 if l_ChDate <> BadDate then
  l_ChDateStr := cc_SoftEnter + cChDate + GenStDateString(l_ChDate);
 if l_ChDateStr <> '' then
  Result := l3CStr(l_ChDateStr)
 else
  Result := nil;
end;

function TarMacroReplacer.GetUrgencyStr: Il3CString;
var
 l_UrgencyStr: string;
begin
 if f_Document is TarDocument then
 begin
  l_UrgencyStr := cUrgencyStr[Byte(TarDocument(f_Document).Urgency)];
  if l_UrgencyStr <> '' then
  begin
   l_UrgencyStr := l_UrgencyStr + cc_SoftEnter;
   Result := l3CStr(l_UrgencyStr);
  end
  else
   Result := nil;
 end
 else
  Result := nil;
end;

class function TarMacroReplacer.Make(const aParent   : Il3HAFMacroReplacer;
                                     const aDocument : TarCustomDocument;
                                     aHasSelection   : Boolean): Il3HAFMacroReplacer;
var
 l_Inst: TarMacroReplacer;
begin
 l_Inst := Create(aParent, aDocument, aHasSelection);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

end.
