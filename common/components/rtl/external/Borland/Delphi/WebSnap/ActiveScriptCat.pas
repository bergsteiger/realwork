
unit ActiveScriptCat;

interface

uses
  Windows, Messages, SysUtils, Classes, WebScriptAs;

type

  TActiveScriptLanguages = class(TAbstractActiveScriptLanguages)
  private
    FList: TStringList;
  public
    constructor Create; override;
    function List: TStrings; override;
  end;

implementation

uses ComObj, ActiveX, NetConst;

var
  ProgIDList: TStringList;

const
  CATID_ActiveScriptParse: TGUID = '{F0B7A1A2-9847-11cf-8F20-00805F2CD064}';

procedure GetActiveScriptParse(List: TStrings);
const
  sXML = 'XML';
  sSigned = 'SIGNED';
var
  ProgID: string;

  function ValidProgID: Boolean;
  var
    PID: string;
  begin
     if Length(ProgID) > 7 then
       Result := AnsiCompareStr('.Encode', Copy(ProgID, Length(ProgID)-6, 7)) <> 0
     else
       Result := True;
     // Exclude XML script engine
     if CompareText(Copy(ProgID, 1, Length(sXML)), sXML) = 0 then
       Result := False;
     // Exclude "signed" script engines
     PID := UpperCase(ProgID);
     if Pos(sSigned, PID) <> 0 then
       Result := False;
  end;
var
  EnumGUID: IEnumGUID;
  Fetched: Cardinal;
  Guid: TGUID;
  Rslt: HResult;
  CatInfo: ICatInformation;
  I, BufSize: Integer;
  ClassIDKey: HKey;
  S: string;
  Buffer: array[0..255] of Char;
begin
  List.Clear;
  Rslt := CoCreateInstance(CLSID_StdComponentCategoryMgr, nil,
    CLSCTX_INPROC_SERVER, ICatInformation, CatInfo);
  if Succeeded(Rslt) then
  begin
    OleCheck(CatInfo.EnumClassesOfCategories(1, @CATID_ActiveScriptParse, 0, nil, EnumGUID));
    while EnumGUID.Next(1, Guid, Fetched) = S_OK do
    begin
      try
        ProgID := ClassIDToProgID(Guid);
        if ValidProgID then
          List.Add(ProgID);
      except
        ProgID := ClassIDToProgID(StringToGUID(Buffer));
        List.Add(sInvalidEntryInCategories);
      end;
    end;
  end else
  begin
    if RegOpenKey(HKEY_CLASSES_ROOT, 'CLSID', ClassIDKey) <> 0 then
      try
        I := 0;
        while RegEnumKey(ClassIDKey, I, Buffer, SizeOf(Buffer)) = 0 do
        begin
          S := Format('%s\Implemented Categories\%s',[Buffer,  { do not localize }
            GUIDToString(CATID_ActiveScriptParse)]);
          if RegQueryValue(ClassIDKey, PChar(S), nil, BufSize) = 0 then
          begin
            ProgID := ClassIDToProgID(StringToGUID(Buffer));
            if ValidProgID then
              List.Add(ProgID);
          end;
          Inc(I);
        end;
      finally
        RegCloseKey(ClassIDKey);
      end;
  end;
end;

{ TActiveScriptEngines }

constructor TActiveScriptLanguages.Create;
begin
  if ProgIDList = nil then
  begin
    ProgIDList := TStringList.Create;
    GetActiveScriptParse(ProgIDList);
    ProgIDList.Sort;
  end;
  FList := ProgIDList;
  inherited Create;
end;

function TActiveScriptLanguages.List: TStrings;
begin
  Result := FList;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\ActiveScriptCat.pas initialization enter'); {$EndIf}
  WebScriptAS.ActiveScriptLanguagesClass := TActiveScriptLanguages;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\ActiveScriptCat.pas initialization leave'); {$EndIf}
finalization
  ProgIDList.Free;
end.
