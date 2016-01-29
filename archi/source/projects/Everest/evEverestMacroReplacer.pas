unit evEverestMacroReplacer;

interface

{$Include Everest.inc}

uses
 l3Interfaces,
 l3InternalInterfaces,

 evCustomHAFMacroReplacer;

type
 TevEverestMacroReplacer = class(TevCustomHAFMacroReplacer)
 private
  f_DocName  : Il3CString;
   {-}
  f_DataSize : Integer;
   {-}
 protected
  function DoReplace(const aText: Il3CString): Il3CString;
   override;
   {-}
  function DoUnfold(const aMacroName: Il3CString; const aValue: Il3CString): Il3CString;
   override;
   {-}
  procedure Cleanup;
   override;
   {-}
 public
  constructor Create(const aParent: Il3HAFMacroReplacer; const aDocName: string; aDataSize: Integer);
   reintroduce;
   {-}
  class function Make(const aParent: Il3HAFMacroReplacer; const aDocName: string; aDataSize: Integer): Il3HAFMacroReplacer;
   reintroduce;
   {-}
 end;

implementation

uses
 SysUtils,

 l3Base,
 l3DateSt,
 l3String,

 evColontitulStr,
 evHAFPainterMacros;

{ TevEverestMacroReplacer }

procedure TevEverestMacroReplacer.Cleanup;
begin
 inherited;
 f_DocName := nil;
end;

constructor TevEverestMacroReplacer.Create(
  const aParent: Il3HAFMacroReplacer; const aDocName: string; aDataSize: Integer);
begin
 inherited Create(aParent);
 f_DocName := l3CStr(aDocName);
 f_DataSize := aDataSize;
end;

function TevEverestMacroReplacer.DoReplace(
  const aText: Il3CString): Il3CString;
begin
 Result := CheckMacro(l3CStr(SDocName), aText);
 Result := CheckMacro(l3CStr(SDataSize), Result);
 Result := CheckMacro(l3CStr(SOtherDataSize), Result);
 Result := CheckMacro(l3CStr(SCurrentDate), Result);
end;

function TevEverestMacroReplacer.DoUnfold(const aMacroName,
  aValue: Il3CString): Il3CString;
begin
 if l3Same(aMacroName, l3CStr(SDocName)) then
  Result := f_DocName
 else
  if l3Same(aMacroName, l3CStr(SDataSize)) then
   Result := l3Fmt('%d', [f_DataSize])
  else
   if l3Same(aMacroName, l3CStr(SOtherDataSize)) then
    Result := l3Fmt('%d', [Trunc(1.6 * f_DataSize)])
   else
    if l3Same(aMacroName, l3CStr(SCurrentDate)) then
     Result := l3CStr(l3DateToStr(Now))
    else
     Result := aValue;
end;

class function TevEverestMacroReplacer.Make(
  const aParent: Il3HAFMacroReplacer;
  const aDocName: string; aDataSize: Integer): Il3HAFMacroReplacer;
var
 l_Inst: TevEverestMacroReplacer;
begin
 l_Inst := Create(aParent, aDocName, aDataSize);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;

end.
