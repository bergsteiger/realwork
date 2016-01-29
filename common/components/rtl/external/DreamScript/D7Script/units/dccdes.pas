{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dccdes;

interface
{$I dc.inc}

uses
  dcsystem, classes, typinfo, dcparser,

  {$IFDEF WIN32}
    windows,
    {$IFDEF D3}
    activex,
    {$ELSE},
    ole2
    {$ENDIF}
  {$ELSE}
    dcactivex,
    types,
  {$ENDIF}

  sysutils,
  dcconsts, dcdreamlib
  ;

type
  TGetMethodCodeProc = procedure (Sender : TObject; const MethodName : string; MethodCode : TStrings) of object;

  TStringsCodeDesigner = class(TCodeDesigner)
  private
    fSyntaxParser: TStringsParser;
    fStrings: TStrings;
    FLink: TPersistent;
    FPropName: string;
    fOnGetMethodCode : TGetMethodCodeProc;
    FVersion: TDCVersion;

    function GetSyntaxParser: TStringsParser;
    procedure SetLink(Value: TPersistent);
    procedure SetPropName(value: string);
    procedure RefreshStrings;
    function  ScanForMethodStart(const AMethodName: string; var pt: TPoint): boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure FilterUsedUnits(S, NewUse: TStrings; InInterface: boolean);
    function IsMethodEmpty: boolean;
    function GetParser: TStringsParser;
    function GetMethodEnd(var pt: TPoint): boolean; virtual;
    function GetMethodName: string;
    procedure SetStrings(val: TStrings); override;
    function GetStrings: TStrings; override;
    function FindMethod(const AMethodName: string; var pt: TPoint): boolean; virtual;
    function FindMethodStart(const AMethodName: string; var pt: TPoint): boolean; virtual;
    function ScanMethodName: string; virtual;
    function IsMethodStart: boolean; virtual; abstract;

    //    procedure ShowSource(x, y : integer); virtual;
    function IsEqualDeclaration(TypeData: PTypeData): boolean; virtual; abstract;
    function GetMethodStart(const pt: TPoint): TPoint; virtual; abstract;
    function GetComment: string; virtual; abstract;
    procedure GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); virtual;
    function IsBlockBegin: boolean; virtual; abstract;
    function IsBlockEnd: integer; virtual; abstract; // 0 - false, 1 - true, 2 - end of function
    function DoDeleteEmptyMethods: boolean; virtual;
    function GetUseUnitString: string; virtual;
  public
    UserData: integer;

    //    function  GetSyntaxParserClass : TCustomDCParserClass; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetMethods(TypeData: PTypeData; S: TStrings); override;

    procedure FillWithTemplate(const ModuleName: string; NewTemplate: boolean); override;
    procedure InsertComponent(Comp: TComponent; const CompName: string); override;
    procedure DeleteComponent(Comp: TComponent); override;
    procedure RenameComponent(Comp: TComponent; const NewName: string); override;
    procedure GetUsedUnits(S: TStrings; InInterface: boolean); override;
    procedure UseUnits(S: TStrings; InInterface: boolean); override;
    procedure DeleteEmptyMethods; override;
    procedure CreateMethod(const AMethodName: string; TypeData: PTypeData); override;
    procedure DeleteMethod(const MethodName: string); override;
    function ValidIdentifier(const Ident: string): boolean; override;

    procedure RenameMethod(const OldName, NewName: string); override;
    function MethodExists(const MethodName: string): boolean; override;
    procedure ShowMethod(const MethodName: string); override;
    function GetMethodState(const MethodName: string): TMethodState; override;

    function IdentsEqual(const S1, S2: string): boolean; virtual;

    property SyntaxParser: TStringsParser read GetSyntaxParser;
  published
    property Link: TPersistent read FLink write SetLink;
    property PropName: string read FPropName write SetPropName;
    property Version: TDCVersion read FVersion write FVersion stored false;
    property OnGetMethodCode : TGetMethodCodeProc read fOnGetMethodCode write fOnGetMethodCode;
  end;

  TScriptCodeDesigner = class(TStringsCodeDesigner)
  protected
    function IsEqualDeclaration(TypeData: PTypeData): boolean; override;
    function AlwaysUseBrackets: Boolean; virtual;
    function CreateEventName(const EventName: string; TypeData: PTypeData; OnlyType: boolean): string; virtual;
    function GetFuncName(TypeData: PTypeData): string; virtual; abstract;
  end;

  TVbsCodeDesigner = class(TScriptCodeDesigner)
  protected
    function IsMethodStart: boolean; override;
    function GetMethodStart(const pt: TPoint): TPoint; override;
    function GetFuncName(TypeData: PTypeData): string; override;
    function ConvertType(TypeName: string): string;
    function IsBlockBegin: boolean; override;
    function IsBlockEnd: integer; override;
    function GetMethodEnd(var pt: TPoint): boolean; override;
    procedure GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); override;
    function GetComment: string; override;
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
    function TypeToString(TypeCode: integer): string; override;
  end;

  TBasicCodeDesigner = class(TVbsCodeDesigner)
  protected
    function IsEqualDeclaration(TypeData: PTypeData): boolean; override;
    function CreateEventName(const EventName: string; TypeData: PTypeData;
      OnlyType: boolean): string; override;
  end;

  TJsCodeDesigner = class(TScriptCodeDesigner)
  protected
    function IsMethodStart: boolean; override;
    function GetMethodStart(const pt: TPoint): TPoint; override;
    procedure GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); override;
    function IsBlockBegin: boolean; override;
    function IsBlockEnd: integer; override;
    function GetFuncName(TypeData: PTypeData): string; override;
    function AlwaysUseBrackets: Boolean; override;
    function GetComment: string; override;
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
    function IdentsEqual(const S1, S2: string): boolean; override;
  end;

  TPythonCodeDesigner = class(TScriptCodeDesigner)
  protected
    function IsMethodStart: boolean; override;
    function GetMethodStart(const pt: TPoint): TPoint; override;
    procedure GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); override;
    function IsBlockBegin: boolean; override;
    function IsBlockEnd: integer; override;
    function GetFuncName(TypeData: PTypeData): string; override;
    function GetComment: string; override;
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
    function IdentsEqual(const S1, S2: string): boolean; override;
  end;

  TUnitCodeDesigner = class(TStringsCodeDesigner)
  protected
    function GetResWordPosition(AResWordID: integer): TPoint;
    function FindUses(var pt: TPoint; InInterface: boolean): boolean;
    procedure _getUsedUnits(S: TStrings; InInterface: boolean);
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
    procedure FillWithTemplate(const ModuleName: string; NewTemplate: boolean); override;
    procedure RenameModule(const OldName, NewName: string); override;
    function TypeToString(TypeCode: integer): string; override;
    function AutoFillUses: boolean; override;

    procedure GetUsedUnits(S: TStrings; InInterface: boolean); override;
    procedure UseUnits(S: TStrings; InInterface: boolean); override;
  end;

  TDelphiCodeDesigner = class(TUnitCodeDesigner)
  private
    procedure RenameOwnerInVar(const NewName: string);
    procedure RenameOwnerInEvents(const NewName: string);
    procedure RenameOwnerInTypeDesc(const NewName: string);
    procedure InsertMethodInTypeDesc(const AMethodName: string; TypeData: PTypeData);
    function  _FindMethod(const AMethodName: string; var pt: TPoint): boolean;
    function  PeekTokenStr2 : string;
  protected
    function GetOwnerCompsDesc(var pt: TPoint): boolean;
    function GetOwnerTypeDesc(var pt: TPoint): boolean;
    function GetCompStringIndex(Comp: TComponent): integer;
    procedure RenameOwner(const NewName: string);
    function FindMethodInTypeDesc(const AMethodName: string; var pt: TPoint): boolean;
    procedure SkipToFinalEnd;
    function FindMethodStart(const AMethodName: string; var pt: TPoint): boolean; override;

    function IsEqualDeclaration(TypeData: PTypeData): boolean; override;
    function IsMethodStart: boolean; override;
    function GetMethodStart(const pt: TPoint): TPoint; override;
    function CreateEventName(const EventName: string; TypeData: PTypeData;
      OnlyTypes, AddOwnerName: boolean): string;

    procedure GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); override;
    function IsBlockBegin: boolean; override;
    function IsBlockEnd: integer; override;
    function ScanMethodName: string; override;
    function FindMethod(const AMethodName: string; var pt: TPoint): boolean; override;
    function GetMethodEnd(var pt: TPoint): boolean; override;
    function DoDeleteEmptyMethods: boolean; override;
  public
    procedure CreateMethod(const AMethodName: string; TypeData: PTypeData); override;
    procedure DeleteMethod(const MethodName: string); override;
    procedure FillWithTemplate(const ModuleName: string; NewTemplate: boolean); override;
    procedure InsertComponent(Comp: TComponent; const CompName: string); override;
    procedure DeleteComponent(Comp: TComponent); override;
    procedure RenameComponent(Comp: TComponent; const NewName: string); override;
    procedure RenameMethod(const OldName, NewName: string); override;
    //    class function GetDescription : string; override;
  end;

  TPerlCodeDesigner = class(TJsCodeDesigner)
  protected
    function IsMethodStart: boolean; override;
    function GetFuncName(TypeData: PTypeData): string; override;
    function GetComment: string; override;
    function CreateEventName(const EventName: string; TypeData: PTypeData; OnlyType: boolean): string; override;
    function IsEqualDeclaration(TypeData: PTypeData): boolean; override;
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
  end;

  TSqlCodeDesigner = class(TStringsCodeDesigner)
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
  end;

  THTMLCodeDesigner = class(TStringsCodeDesigner)
  public
    function GetSyntaxParserClass: TSimpleParserClass; override;
    procedure FillWithTemplate(const ModuleName: string; NewTemplate: boolean); override;
  end;

function GenerateCodeForComp(Comp: TComponent; const UnitName: string): string;

procedure Register;

function BuildClassName (BaseName : string) : string;

implementation

function BuildClassName (BaseName : string) : string;
begin
  result := ClassPrefix + BaseName;
end;

const
  //BeginSkipConst
  SNewHTMLTemplate =
    '<html>'#13#10 +
    #13#10 +
    '<head>'#13#10 +
    '<title>%s</title>'#13#10 +
    '</head>'#13#10 +
    #13#10 +
    '<body>'#13#10 +
    '</body>'#13#10 +
    '</html>';

  SExportCodeTemplate =
    'unit %s;'#13#10 + //  1 - unitname
  #13#10 + //
  'interface'#13#10 + //
  #13#10 + //
  'uses %s;'#13#10 + //  2 - uses
  #13#10 + //
  'type'#13#10 + //
  '  %s = class(%s)'#13#10 + //  3 - new class name   4 - old classname
  '%s' + //  5 - codegen section
  '  private'#13#10 + //
  '    {private declarations}'#13#10 +
  '  protected'#13#10 + //
  '    {protected declarations}'#13#10 +
  '  public'#13#10 + //
  '    {public declarations}'#13#10 +
  '  end;'#13#10 + //
  #13#10 + //
  'var'#13#10 + //
  '  %s: %s;'#13#10 + //   6 - varname  7 - new class name
  #13#10 + //
  'implementation'#13#10 + //
  #13#10 + //
  '{$R *.DFM}'#13#10 + //
  #13#10 + //
  'end.'; //
  //EndSkipConst

function GenerateCodeForComp(Comp: TComponent; const UnitName: string): string;

  function CreateSubComplist(F: TComponent): string;
  var
    I: Integer;
  begin
    Result := '';
    if F = nil then exit;
    for I := 0 to F.ComponentCount - 1 do
      Result := Result + '    ' + F.Components[i].Name + ': ' + F.Components[i].ClassName + ';'#13#10; //don't resource
  end;

  procedure AddCompUnit(UnitList: TStrings; C: TComponent);
  var
    i: Integer;
    TempStr: string;
  begin
    TempStr := GetClassUnit(C);
    for i := 0 to UnitList.Count - 1 do
      if CompareText(TempStr, UnitList[i]) = 0 then exit;
    UnitList.Add(TempStr);
  end;

  function UnitListToString(UnitList: TStrings): string;
  var
    Leng: Integer;
    i: Integer;
  begin
    Result := '';
    Leng := 0;
    for i := 0 to UnitList.Count - 1 do
    begin
      if i > 0 then
        Result := Result + ', ';
      if Leng > 60 then
      begin
        Leng := 0;
        Result := Result + #13#10 + '     ';
      end;
      Result := Result + UnitList[i];
      Leng := Leng + Length(UnitList[i]) + 2;
    end;
  end;

var
  NewClassName: string;
  UsesClause, CodeGenSection: string;
  UnitList: TStringList;
  i: Integer;
begin
  with Comp do
  begin
    UnitList := TStringList.Create;
    try
      UnitList.CommaText := 'Windows,Messages,SysUtils,Classes,Graphics,Controls,Forms,Dialogs'; //don't resource
      for i := 0 to ComponentCount - 1 do
        AddCompUnit(UnitList, Components[i]);

      NewClassName := BuildClassName(Name);
      UsesClause := UnitListToString(UnitList);
    finally
      UnitList.Free;
    end;

    CodeGenSection := CreateSubCompList(Comp);
    Result := Format(SExportCodeTemplate, [
      UnitName, // 1 - unit name
      UsesClause, // 2 - uses
      NewClassName, // 3 - new class name
      ClassName, // 4 - old class name
      CodeGenSection, // 5 - codegen section
      Name, // 6 - var name
      NewClassName]); // 7 - new class name
  end;
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.SetLink(Value: TPersistent);
begin
  if FLink <> Value then
  begin
    FLink := Value;
    if FLink is TComponent then
      TComponent(FLink).FreeNotification(Self);
    RefreshStrings;
  end;
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.RefreshStrings;
var
  Info: PPropInfo;
begin
  if Assigned(FLink) then
  begin
    Info := GetPropInfo(FLink.ClassInfo, FPropName);
    if Assigned(Info) then
      SetStrings(TStrings(GetOrdProp(FLink, Info)));
  end
  else
    SetStrings(nil);
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (operation = opRemove) and (Acomponent = FLink) then
    SetLink(nil);
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.SetPropName(Value: string);
begin
  if FpropName <> Value then
  begin
    FPropName := Value;
    RefreshStrings;
  end;
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.SetStrings(val: TStrings);
begin
  fStrings := val;
end;

{------------------------------------------------------------------}

function TStringsCodeDesigner.GetStrings: TStrings;
begin
  result := fStrings;
end;

{------------------------------------------------------------------}

constructor TStringsCodeDesigner.Create(AOwner: TComponent);
begin
  inherited;
  if GetSyntaxParserClass <> nil then
    fSyntaxParser := TStringsParser(GetSyntaxParserClass.Create(nil));
end;

{------------------------------------------------------------------}

destructor TStringsCodeDesigner.Destroy;
begin
  fSyntaxParser.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TStringsCodeDesigner.GetSyntaxParser: TStringsParser;
begin
  Result := fSyntaxParser;
end;

{------------------------------------------------------------------}

procedure TStringsCodeDesigner.RenameMethod(const OldName, NewName: string);
var
  pt: TPoint;
  s: string;
begin
  if FindMethod(OldName, pt) then
  begin
    s := Strings[pt.y];
    Replace(s, pt.x, OldName, NewName);
    Strings[pt.y] := s;
  end;
end;

{------------------------------------------------------------------}

function TStringsCodeDesigner.MethodExists(const MethodName: string): boolean;
var
  pt: TPoint;
begin
  result := FindMethod(MethodName, pt);
end;

{-------------------------------------------------------------}

function TStringsCodeDesigner.GetMethodState(const MethodName: string): TMethodState;
var
  pt: TPoint;
begin
  result := msNotPresent;
  if FindMethod(MethodName, pt) then
    begin
      result := msOk;
      if IsMethodEmpty then
        result := msEmpty;
    end;
end;

{-------------------------------------------------------------}

function TStringsCodeDesigner.ValidIdentifier(const Ident: string): boolean;
var
  i: integer;
begin
  result := IsValidIdent(Ident) and not
    TStringList(GetSyntaxParser.SortedResWords).Find(Ident, i);
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.IdentsEqual(const S1, S2: string): boolean;
begin
  result := CompareText(s1, s2) = 0;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.ScanMethodName: string;
begin
  result := GetSyntaxParser.NextValidTokenStr;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.GetMethodName: string;
begin
  with GetSyntaxParser do
  begin
    PushState;
    result := ScanMethodName;
    PopState;
  end;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.GetParser: TStringsParser;
begin
  result := GetSyntaxParser;
  with result do
  begin
    Strings := self.Strings;
    ResetParser;
  end;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.ScanForMethodStart(const AMethodName: string; var pt: TPoint): boolean;
begin
  with GetSyntaxParser do
    while not ParserEOF do
      if (token = tokResWord) and IsMethodStart and IdentsEqual(GetMethodName, AMethodName) then
        begin
          pt := Point(TokenCharPos + 1, LinePos);
          result := true;
          exit;
        end
      else
        NextToken;

  result := false;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.FindMethodStart(const AMethodName: string; var pt: TPoint): boolean;
begin
  GetParser;
  result := ScanForMethodStart(AMethodName, pt);
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.FindMethod(const AMethodName: string; var pt: TPoint): boolean;
begin
  result := FindMethodStart(AMethodName, pt);
  if result then
    with GetSyntaxParser do
    begin
      NextToken;
      pt := Point(TokenCharPos + 1, LinePos);
    end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.ShowMethod(const MethodName: string);
var
  pt: TPoint;
begin
  if FindMethod(MethodName, pt) then
    with GetMethodStart(pt) do
      ShowSource(x, y);
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.GetMethods(TypeData: PTypeData; S: TStrings);
var
  mname: string;
begin
  with GetParser do
    while not ParserEOF do
      if (token = tokResWord) and IsMethodStart then
      begin
        mname := GetMethodName;
        if (TypeData = nil) or IsEqualDeclaration(TypeData) then
        begin
          S.Add(mname);
          NextToken;
        end;
      end
      else
        NextToken;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.DoDeleteEmptyMethods: boolean;
begin
  result := false;

  with GetSyntaxParser do
    while not ParserEOF do
      if (token = tokResWord) and IsMethodStart and IsMethodEmpty then
      begin
        DeleteMethod(GetMethodName);
        result := true;
        exit;
      end
      else
        NextToken;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings); 
begin
  if Assigned(OnGetMethodCode) then
    OnGetMethodCode(self, AMethodName, S);
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.DeleteEmptyMethods;
begin
  repeat
    GetParser;
  until not DoDeleteEmptyMethods;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.GetMethodEnd(var pt: TPoint): boolean;
var
  blocklevel: integer;
  tcount: integer;
begin
  with GetSyntaxParser do
  begin
    //      ScanMethodName;

    NextValidToken; // '('

    if IsTokenChar('(') then //!!! Maybe use IsParamListBegin
      while not (ParserEOF or IsTokenChar(')')) do
        NextToken;

    while not (ParserEOF or IsBlockBegin) do
      NextToken;

    tcount := -1;
    blocklevel := 1;

    while (blocklevel > 0) and not ParserEOF do
    begin
      inc(tcount);
      NextToken;
      case IsBlockEnd of
        0:
          if IsBlockBegin then
            inc(blocklevel);
        1: dec(blocklevel);
        2: break;
      end;
    end;

    result := not ParserEOF and (tcount < 1); // Method is empty
    pt := Point(CharPos, LinePos);
  end;
end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.IsMethodEmpty: boolean;
var
  pt: TPoint;
begin
  with GetSyntaxParser do
  begin
    PushState;
    result := GetMethodEnd(pt);
    PopState;
  end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.DeleteMethod(const MethodName: string);
var
  pt: TPoint;
  endpt: TPoint;
  i: integer;
  s: string;

begin
  if (MethodName <> '') and FindMethodStart(MethodName, pt) then
    with GetSyntaxParser do
    begin
      PushState;
      pt := Point(TokenCharPos, LinePos);
      GetMethodEnd(endpt);
      if pt.y = endpt.y then
      begin
        s := Strings[pt.y];
        Delete(s, pt.x, endpt.x - pt.x);
        Strings[pt.y] := s;
      end
      else
      begin
        s := copy(Strings[pt.y], 1, pt.x);
        if s <> '' then
          Strings[pt.y] := s
        else
        begin
          Strings.Delete(pt.y);
          dec(pt.y);
        end;

        for i := pt.y to endpt.y - 2 do
          Strings.Delete(pt.y + 1);

        s := Strings[pt.y + 1];
        Delete(s, 1, endpt.x);
        if s <> '' then
          Strings[pt.y + 1] := s
        else
          Strings.Delete(pt.y + 1);
      end;
      PopState;
    end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.FillWithTemplate(const ModuleName: string; NewTemplate: boolean);
begin

end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.InsertComponent(Comp: TComponent; const CompName: string);
begin

end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.DeleteComponent(Comp: TComponent);
begin

end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.RenameComponent(Comp: TComponent; const NewName: string);
begin

end;

{-----------------------------------------------------------}

function TStringsCodeDesigner.GetUseUnitString: string;
begin
  result := GetComment + 'USEUNIT '; //don't resource
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.GetUsedUnits(S: TStrings; InInterface: boolean);
var
  i: integer;
  k: integer;
  ustring: string;
  uname: string;
begin
  ustring := GetUseUnitString;
  for i := 0 to Strings.Count - 1 do
    if pos(ustring, Strings[i]) = 1 then
    begin
      uname := Strings[i];
      Delete(uname, 1, length(ustring));
      uname := Trim(uname);
      k := 1;
      while (k < length(uname)) and (uname[k] in ['A'..'Z', 'a'..'z', SlashString, ':', '.', '_', '0'..'9']) do
        inc(k);
      S.Add(copy(uname, 1, k));
    end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.FilterUsedUnits(S, NewUse: TStrings; InInterface: boolean);
var
  used: TStringList;
  i: Integer;
  index: integer;
begin
  used := TStringList.Create;
  try
    GetUsedUnits(used, true);
    used.Sorted := true;
    for i := 0 to S.Count - 1 do
      if not used.Find(S[i], index) then
        if newuse.IndexOf(S[i]) < 0 then
          newuse.Add(S[i]);
  finally
    used.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.UseUnits(S: TStrings; InInterface: boolean);
var
  newuse: TStringList;
  i: integer;
begin
  newuse := TStringList.Create;
  try
    FilterUsedUnits(S, NewUse, InInterface);
    for i := 0 to newuse.Count - 1 do
      Strings.Insert(0, GetUseUnitString + ' ' + newuse[i]); //don't resource
  finally
    newuse.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TStringsCodeDesigner.CreateMethod(const AMethodName: string; TypeData: PTypeData);
var
  mtemplate: TStringList;
  i: integer;
begin
  with Strings do
  begin
    BeginUpdate;
    if (Count > 0) and (Strings[Count - 1] <> '') then
      Add('');

    mtemplate := TStringList.Create;
    try
      GetMethodTemplate(AMethodName, TypeData, mtemplate);
      for i := 0 to mtemplate.Count - 1 do
        Add(mtemplate[i]);
    finally
      mtemplate.Free;
      EndUpdate;
    end;
    ShowSource(0, Count - 2);
  end;
end;

{***********************************************************}

function TScriptCodeDesigner.IsEqualDeclaration(TypeData: PTypeData): boolean;
var
  pcount: integer;
begin
  result := false;

  pcount := 0;
  with GetSyntaxParser do
  begin
    NextToken; // sub name
    NextToken; // '('

    if IsTokenChar('(') then
    begin
      while not ParserEOF do
      begin
        NextToken;
        if IsTokenChar(')') then
          break;

        if not IsTokenChar(',') then
          inc(pcount);
      end;

      result := pcount = TypeData^.ParamCount;
    end;
  end;
end;

{-----------------------------------------------------------}

function TScriptCodeDesigner.AlwaysUseBrackets: Boolean;
begin
  Result := False;
end;

{-----------------------------------------------------------}

function TScriptCodeDesigner.CreateEventName(const EventName: string; TypeData: PTypeData; OnlyType: boolean): string;
var
  P: PChar;
  i: integer;
begin
  result := '';
  if TypeData = nil then
    exit;

  result := GetFuncName(TypeData) + EventName + '(';
  P := @TypeData^.ParamList;
  if TypeData^.ParamCount > 0 then
  begin
    for i := 1 to TypeData^.ParamCount do
    begin
      inc(p);
      Result := Result + PReadShortStr(p) + ', ';
      PReadShortStr(p);
    end;
    delete(result, length(result) - 1, 2);
    Result := Result + ')';
  end
  else if AlwaysUseBrackets then
    Result := Result + ')'
  else
    Delete(Result, Length(Result), 1);
end;

{***********************************************************}

function TVbsCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TVBScriptParser;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.GetMethodStart(const pt: TPoint): TPoint;
begin
  result := Point(0, pt.y + 1);
end;

{-----------------------------------------------------------}
//BeginSkipConst
const
  VT_BasicNames: array[-1..VT_LPWSTR] of string =
    (
    'Color',
    '', //VT_EMPTY
    '', //VT_NULL
    'Integer', //VT_I2
    'Long', //VT_I4
    'Single', //VT_R4
    'Double', //VT_R8
    'Currency', //VT_CY
    'Date', //VT_DATE
    'String', //VT_BSTR
    'Pointer', //VT_DISPATCH  ????
    'Integer', //VT_ERROR ????
    'Boolean', //VT_BOOL
    'Variant', //VT_VARIANT
    'Pointer', //VT_UNKNOWN ????
    'Decimal', //VT_DECIMAL
    '',
    'Byte', //VT_I1
    'Byte', //VT_UI1
    'Integer', //VT_UI2
    'Long', //VT_UI4
    'Variant', //VT_I8
    'Variant', //VT_UI8
    'Integer', //VT_INT
    'Integer', //VT_UINT
    'Variant', //VT_VOID
    'Longint', //VT_HRESULT
    'Variant', //VT_PTR ????
    'Variant', //VT_SAFEARRAY
    'Variant', //VT_CARRAY
    'Variant', //VT_USERDEFINED
    'String', //VT_LPSTR
    'String' //VT_LPWSTR
    );
  //EndSkipConst
  {-------------------------------------------------------------}

function TVbsCodeDesigner.TypeToString(TypeCode: integer): string;
begin
  result := VT_BasicNames[TypeCode];
end;

{-------------------------------------------------------------}

function TBasicCodeDesigner.IsEqualDeclaration(TypeData: PTypeData): boolean;
var
  evname: string;
  ParamList: string;

begin
  result := false;

  evname := CreateEventName('', TypeData, true);
  paramlist := '';

  with GetSyntaxParser do
  begin
    NextToken; // sub name
    NextToken; // '('

    if IsTokenChar('(') then
    begin
      while not (ParserEOF or IsTokenChar(')')) do
      begin
        NextToken; // Var
        if CompareText(TokenString, 'ByVal') = 0 then //don't resource
        begin
          paramlist := paramlist + 'ByVal '; //don't resource
          NextToken; // Var
        end;

        NextToken; // As
        NextToken; // Type
        paramlist := paramlist + TokenString + ',';
        NextToken;
      end;

      delete(paramlist, length(paramlist), 1);
      result := CompareText(evname, paramlist) = 0;
    end;
  end;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.IsMethodStart: boolean;
var
  s: string;
begin
  with GetSyntaxParser do
    begin
      result := (CompareText(TokenString, 'function') = 0) or //don't resource
      (CompareText(TokenString, 'sub') = 0); //don't resource

      if result then
        begin
          s := copy(Strings[LinePos], 1, TokenCharPos);
          result := Trim(s) = '';
        end;
    end;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.GetFuncName(TypeData: PTypeData): string;
begin
  if (TypeData^.MethodKind in [mkFunction{$IFDEF D3}, mkSafeFunction{$ENDIF}]) then
    result := 'Function ' //don't resource
  else
    result := 'Sub '; //don't resource
end;

{-------------------------------------------------------------}

function TBasicCodeDesigner.CreateEventName(const EventName: string; TypeData: PTypeData; OnlyType: boolean): string;
var
  P: PChar;
  i: integer;
  ParamName, TypeName: string;
  FLags: TParamFlags;
  bb: byte;
begin
  result := '';
  if TypeData = nil then
    exit;

  if not OnlyType then
    result := GetFuncName(TypeData) + EventName + '(';

  P := @TypeData^.ParamList;
  for i := 1 to TypeData^.ParamCount do
  begin
    Flags := TParamFlags(p^);
    inc(p);
    ParamName := PReadShortStr(p);
    TypeName := PReadShortStr(p);
    TypeName := ConvertType(TypeName);
    if pfVar in Flags then
      result := result + 'ByVal '; //don't resource

    if not OnlyType then
      result := result + ParamName + ' As ' + TypeName + ', ' //don't resource
    else
      result := result + TypeName + ',';
  end;
  bb := byte(not OnlyType);
  delete(result, length(result) - bb, 1 + bb);
  if not OnlyType then
  begin
    result := result + ')';
    if (TypeData^.MethodKind in [mkFunction{$IFDEF D3}, mkSafeFunction{$ENDIF}]) then
      result := result + ' As ' + PReadShortStr(p); //don't resource

  end;
end;

{-------------------------------------------------------------}
//BeginSkipConst
const
  MaxTypeCount = 22;
  D2BTypes: array[1..MaxTypeCount * 2] of string =
    (
    'TObject', 'Object',
    'Shortint', 'Byte',
    'Smallint', 'Integer',
    'Longint', 'Longint',
    'Byte', 'Byte',
    'Word', 'Integer',
    'Cardinal', 'Long',
    'Integer', 'Long',
    'Boolean', 'Boolean',
    'String', 'String',
    'Char', 'Integer',
    'AnsiChar', 'String',
    'WideChar', 'String',
    'String', 'String',
    'PChar', 'String',
    'Single', 'Single',
    'Double', 'Double',
    'TDate', 'Date',
    'TDateTime', 'Date',
    'TTime', 'Time',
    'Currency', 'Currency',
    'TShiftState', 'Integer'
    );
  //EndSkipConst

function TVbsCodeDesigner.ConvertType(TypeName: string): string;
var
  i: integer;
begin
  for i := 1 to MaxTypeCount do
    if CompareText(D2BTypes[i * 2 - 1], TypeName) = 0 then
    begin
      result := D2BTypes[i * 2];
      exit;
    end;
  if GetClass(TypeName) <> nil then
    result := 'Object' //don't resource
  else
    result := 'Variant'; //don't resource
end;

{-------------------------------------------------------------}

procedure TVbsCodeDesigner.GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings);
begin
  with S do
  begin
    Add(CreateEventName(AMethodName, TypeData, false));
    Add('');
    Add('End Sub'); //don't resource
  end;

  inherited;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.IsBlockBegin: boolean;
begin
  result := true;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.IsBlockEnd: integer;
begin
  with GetSyntaxParser do
    if (CompareText(TokenString, 'END') = 0) and //don't resource
    ((CompareText(PeekTokenStr, 'SUB') = 0) or //don't resource
      (CompareText(PeekTokenStr, 'FUNCTION') = 0)) then //don't resource
      result := 2
    else
      result := 0;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.GetMethodEnd(var pt: TPoint): boolean;
begin
  result := inherited GetMethodEnd(pt);
  with GetSyntaxParser do
  begin
    NextValidToken; // SUB or FUNCTION
    pt := Point(CharPos, LinePos);
  end;
end;

{-----------------------------------------------------------}

function TVbsCodeDesigner.GetComment: string;
begin
  result := '''';
end;

{***********************************************************}

function TJsCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TJavaScriptParser;
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.IsMethodStart: boolean;
begin
  result := GetSyntaxParser.TokenString = 'function'; //don't resource
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.GetMethodStart(const pt: TPoint): TPoint;
begin
  result := Point(0, pt.y + 2); // !!!
end;

{-----------------------------------------------------------}

procedure TJsCodeDesigner.GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings);
begin
  with S do
  begin
    Add(CreateEventName(AMethodName, TypeData, false));
    Add('{');
    Add('');
    Add('}');
  end;

  inherited;
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.IdentsEqual(const S1, S2: string): boolean;
begin
  result := s1 = s2; // Java is case sensitive
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.IsBlockBegin: boolean;
begin
  result := SyntaxParser.IsTokenChar('{');
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.IsBlockEnd: integer;
begin
  result := ord(SyntaxParser.IsTokenChar('}'));
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.GetFuncName(TypeData: PTypeData): string;
begin
  result := 'function '; //don't resource
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.AlwaysUseBrackets: Boolean;
begin
  Result := True;
end;

{-----------------------------------------------------------}

function TJsCodeDesigner.GetComment: string;
begin
  result := '//';
end;

{-------TPythonCodeDesigner.---------------------------------}

function TPythonCodeDesigner.IsMethodStart: boolean;
begin
  result := CompareText(GetSyntaxParser.TokenString, 'def') = 0; //don't resource
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.GetMethodStart(const pt: TPoint): TPoint;
begin
  result := Point(0, pt.y + 1);
end;

{-----------------------------------------------------------}

procedure TPythonCodeDesigner.GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings);
begin
  with S do
  begin
    Add(CreateEventName(AMethodName, TypeData, false) + ':');
    Add('');
    Add('#def'); //don't resource
  end;

  inherited;
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.IsBlockBegin: boolean;
begin
  result := true;
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.IsBlockEnd: integer;
begin
  if CompareText(GetSyntaxParser.TokenString, '#def') = 0 then //don't resource
    result := 2
  else
    result := 0;
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.GetFuncName(TypeData: PTypeData): string;
begin
  result := 'def '; //don't resource
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.GetComment: string;
begin
  result := '#';
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TPythonParser;
end;

{-----------------------------------------------------------}

function TPythonCodeDesigner.IdentsEqual(const S1, S2: string): boolean;
begin
  result := CompareText(S1, S2) = 0;
end;

{***********************************************************}
//BeginSkipConst
const
  cNewUnitCode: string =
    'unit %s;'#13#10 +
    #13#10 +
    'interface'#13#10 +
    #13#10 +
    'implementation'#13#10 +
    #13#10 +
    'end.'#13#10;
  //EndSkipConst

procedure TUnitCodeDesigner.FillWithTemplate(const ModuleName: string; NewTemplate: boolean);
begin
  Strings.Text := Format(cNewUnitCode, [ModuleName]);
end;

{-----------------------------------------------------------}

procedure TUnitCodeDesigner.RenameModule(const OldName, NewName: string);
var
  s: string;
begin
  if OldName = NewName then
    exit;
  with GetParser do
  begin
    if not SkipToResWord(ID_UNIT) then
      exit;
    NextValidToken;
    if CompareText(TokenString, OldName) = 0 then
    begin
      s := Strings[LinePos];
      Replace(s, TokenCharPos + 1, OldName, NewName);
      Strings[LinePos] := s;
    end;
  end;
end;

{-----------------------------------------------------------}

function TUnitCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TDelphiParser;
end;

{-----------------------------------------------------------}

function TUnitCodeDesigner.GetResWordPosition(AResWordID: integer): TPoint;
begin
  with GetParser do
    if SkipToResWord(AResWordID) then
      result := Point(TokenCharPos + 1, LinePos)
    else
      result := Point(0, 0);
end;

{-----------------------------------------------------------}

function TUnitCodeDesigner.FindUses(var pt: TPoint; InInterface: boolean): boolean;

  function ptempty(const p: TPoint): boolean;
  begin
    result := (p.x = 0) and (p.y = 0);
  end;

  function ptless(const p1, p2: TPoint): boolean;
  begin
    result := (p1.y < p2.y) or (p1.y = p2.y) and (p1.x < p2.x);
  end;

var
  intpos: TPoint;
  imppos: TPoint;
begin
  result := false;
  intpos := GetResWordPosition(ID_Interface);
  imppos := GetResWordPosition(ID_Implementation);

  if not InInterface and (ptempty(intpos) or ptempty(imppos)) then
    exit;

  with GetParser do
  begin
    if not InInterface then
      LinePos := imppos.y;

    if SkipToResWord(ID_Uses) then
    begin
      pt := Point(TokenCharPos + 1, LinePos);
      result := not InInterface or (ptless(intpos, pt) and (ptless(pt, imppos) or ptempty(imppos)));
    end;
  end;
end;

{-----------------------------------------------------------}

procedure TUnitCodeDesigner._getUsedUnits(S: TStrings; InInterface: boolean);
var
  pt: TPoint;
begin
  if S <> nil then
    S.Clear;

  if FindUses(pt, InInterface) then
    with GetSyntaxParser do
      while not ParserEOF do
        begin
          NextValidToken;
          if IsTokenChar(';') then
            break;
          if (S <> nil) and (TokenString <> ',') then
            S.Add(TokenString);
        end;
end;

{-----------------------------------------------------------}

procedure TUnitCodeDesigner.GetUsedUnits(S: TStrings; InInterface: boolean);
begin
  _getusedunits(S, InInterface);
end;

{-----------------------------------------------------------}

const
  MAXSTRINGLENGTH = 80;
  IDENT = 2;

procedure TUnitCodeDesigner.UseUnits(S: TStrings; InInterface: boolean);

  procedure _UseUnits(S: TStrings; InInterface: boolean);
  var
    st: string;
    x: integer;
    y: integer;
    id: integer;
    pt: TPoint;
    i: integer;

    procedure CreateUses;
    begin
      with GetSyntaxParser do
      begin
        ResetParser;
        if InInterface then
          id := ID_Interface
        else
          id := ID_Implementation;

        if not SkipToResWord(id) then
          exit;

        with Strings do
        begin
          if LinePos = Count - 1 then
            exit;

          Insert(LinePos + 1, 'uses'); //don't resource
          Insert(LinePos + 2, '');
        end;

        st := StringOfChar(' ', IDENT);
        x := 1;
        y := LinePos + 2;
      end;
    end;

  begin
    if S.Count = 0 then
      exit;

    with GetSyntaxParser do
    begin
      if not FindUses(pt, InInterface) then
        CreateUses
      else
      begin
        _getusedunits(nil, InInterface);
        x := CharPos; //
        y := LinePos; //
        st := copy(Strings[y], 1, x - 1) + ',';
      end;

      for i := 0 to S.Count - 1 do
      begin
        if length(st) + length(S[i]) + 1 > MAXSTRINGLENGTH then
        begin
          Strings[y] := st;
          inc(y);
          Strings.Insert(y, '');
          st := StringOfSpace(IDENT);
        end;

        AddStr(st, S[i] + ', ');
      end;

      st[length(st) - 1] := ';';
      Strings[y] := st;
    end;
  end;

var
  TempStrings: TStringList;
begin
  TempStrings := TStringList.Create;
  try
    FilterUsedUnits(S, TempStrings, InInterface);
    _UseUnits(TempStrings, InInterface);
  finally
    TempStrings.Free;
  end;
end;

{-----------------------------------------------------------}

function TUnitCodeDesigner.TypeToString(TypeCode: integer): string;
begin
  {$IFDEF D3}
  result := ConvertDelphiTypeToString(TypeCode);
  {$ELSE}
  result := '';
  {$ENDIF}
end;

{-----------------------------------------------------------}

function TUnitCodeDesigner.AutoFillUses: boolean;
begin
  result := true;
end;

{***********************************************************}

function TDelphiCodeDesigner.IsEqualDeclaration(TypeData: PTypeData): boolean;
var
  evname: string;
  paramlist: string;
  typedecl: boolean;
begin
  result := false;

  evname := CreateEventName('', TypeData, true, false);
  paramlist := '';

  with GetSyntaxParser do
  begin
    NextValidToken; // owner name
    NextToken; // '.'
    NextToken; // method name
    NextToken; // (
    ParamList := '';
    TypeDecl := false;

    if IsTokenChar('(') then
    begin
      while not ParserEOF do
      begin
        NextValidToken;
        if IsTokenChar(')') then
          break;

        if TypeDecl or (Token = tokResWord) or IsTokenChar(':') or
          IsTokenChar(',') or IsTokenChar(';') then
        begin
          ParamList := ParamList + TokenString;
          if not TypeDecl then
            ParamList := ParamList + ' ';
        end
        else
          ParamList := ParamList + '#';

        typedecl := IsTokenChar(':');
      end;

      result := not ParserEOF and (CompareText(evname, paramlist) = 0);
    end;
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.FindMethodStart(const AMethodName: string; var pt: TPoint): boolean;
begin
  with GetParser do
    if not SkipToResWord(ID_IMPLEMENTATION) then
      ResetParser;

  result := ScanForMethodStart(AMethodName, pt);
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.IsMethodStart: boolean;
begin
  with GetSyntaxParser do
    result := (IsTokenResWord(ID_PROCEDURE) or IsTokenResWord(ID_Function))
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.GetMethodStart(const pt: TPoint): TPoint;
begin
  result := Point(0, pt.y + 2); // !!!
end;

{-----------------------------------------------------------}

function GetParPrefix(const A: TParamFlags): string;
begin
  if pfVar in A then
    result := 'var ' //don't resource
  else if pfConst in A then
    result := 'const ' //don't resource
    {$IFDEF D3}
  else if pfOut in A then
    result := 'out ' //don't resource
    {$ENDIF}
  else
    result := '';
end;

{------------------------------------------------------------------}

function TDelphiCodeDesigner.CreateEventName(const EventName: string; TypeData: PTypeData;
  OnlyTypes, AddOwnerName: boolean): string;

var
  P: PChar;
  i: integer;
  IsFunction: boolean;
  ParamName: string;
  OldTypeName: string;
  TypeName: string;
  OldFlags: TParamFlags;
  FLags: TParamFlags;
  List: TStringList;
  //-----------------------------

  function InsParName(const PrevPar, NewPar: string): string;
  begin
    result := PrevPar;
    Insert(', ' + NewPar, Result, Pos(':', Result));
  end;
  //-----------------------------

  procedure _add(const s: string);
  begin
    AddStr(result, s);
  end;
  //-----------------------------
begin
  result := '';

  if TypeData = nil then
    exit;

  IsFunction := (TypeData^.MethodKind in [mkFunction{$IFDEF D3}, mkSafeFunction{$ENDIF}]);

  if not OnlyTypes then
  begin
    if IsFunction then
      result := 'function ' //don't resource
    else
      result := 'procedure '; //don't resource

    if AddOwnerName and (ModuleOwner <> nil) and (ModuleOwner.Name <> '') then
      _add(BuildClassName(ModuleOwner.Name + '.'));

    _add(EventName);

    if TypeData^.ParamCount > 0 then
      _add('(');
  end;

  P := @TypeData^.ParamList;
  List := TStringList.Create;
  try
    for i := 1 to TypeData^.ParamCount do
    begin
      Flags := TParamFlags(p^);
      inc(p);
      ParamName := PReadShortStr(p);
      if OnlyTypes then
        ParamName := '#';
      TypeName := PReadShortStr(p);
      if pfArray in Flags then
        Insert('Array of ', TypeName, 1); //don't resource

      if (i > 1) and (OldFlags = Flags) and (CompareText(TypeName, oldTypeName) = 0) then
        List[List.Count - 1] := InsParName(List[List.Count - 1], ParamName)
      else
        List.Add(GetParPrefix(Flags) + ParamName + ': ' + TypeName);

      OldFlags := Flags;
      OldTypeName := TypeName;
    end;

    for i := 0 to List.Count - 1 do
    begin
      _add(List[i]);
      if i < List.Count - 1 then
        _add('; ');
    end;
  finally
    List.Free;
  end;

  if not OnlyTypes then
  begin
    if TypeData^.ParamCount > 0 then
      _add(')');
    if IsFunction then
      _add(': ' + PReadShortStr(p));

    _add(';');
  end;
end;

{------------------------------------------------------------------}

procedure TDelphiCodeDesigner.GetMethodTemplate(const AMethodName: string; TypeData: PTypeData; S: TStrings);
begin
  with S do
  begin
    Add(CreateEventName(AMethodName, TypeData, false, true));
    Add('begin'); //don't resource
    Add('');
    Add('end;'); //don't resource
    Add('');
  end;

  inherited;
end;

{-----------------------------------------------------------}
{
class function TDelphiCodeDesigner.GetDescription : string;
begin
  result := 'Delphi files';
end;
}
{-----------------------------------------------------------}

function TDelphiCodeDesigner.IsBlockBegin: boolean;
begin
  result := SyntaxParser.IsTokenResWord(ID_BEGIN);
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.IsBlockEnd: integer;
begin
  result := ord(SyntaxParser.IsTokenResWord(ID_END));
end;

{-----------------------------------------------------------}
//BeginSkipConst
const
  cNewFormCode: string =
    'unit %s;'#13#10 + // unitname
  #13#10 +
    'interface'#13#10 +
    #13#10 +
    'uses'#13#10 +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;'#13#10 +
    #13#10 +
    'type'#13#10 +
    '  T%s = class(%s)'#13#10 + // obj name, classname
  '  private'#13#10 +
    '    { Private declarations }'#13#10 +
    '  public'#13#10 +
    '    { Public declarations }'#13#10 +
    '  end;'#13#10 +
    #13#10 +
    'var'#13#10 +
    '  %s: T%s;'#13#10 + // obj name, classname
  #13#10 +
    'implementation'#13#10 +
    #13#10 +
    '{$R *.DFM}'#13#10 +
    #13#10 +
    'end.'#13#10;
  //EndSkipConst

procedure TDelphiCodeDesigner.FillWithTemplate(const ModuleName: string; NewTemplate: boolean);
begin
  if ModuleOwner = nil then
    inherited
  else
    if NewTemplate then
      Strings.Text := Format(cNewFormCode, [ModuleName, ModuleOwner.Name, ModuleOwner.ClassName, ModuleOwner.Name, ModuleOwner.Name])
    else
      Strings.Text := GenerateCodeForComp(ModuleOwner, ModuleName);
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.GetOwnerTypeDesc(var pt: TPoint): boolean;
var
  tname: string;
begin
  result := false;
  if ModuleOwner = nil then
    exit;
  tname := BuildClassName(ModuleOwner.Name);

  with GetParser do
  begin
    if (not SkipToResWord(ID_Interface)) or (not SkipToResWord(ID_Type)) then
      exit;
    while not (ParserEof or IsTokenResWord(id_implementation)) do
    begin
      NextToken;
      if (Token = tokSymbol) and (CompareText(TokenString, tName) = 0) then
      begin
        PushState;
        pt := Point(TokenCharPos + 1, LinePos);
        if (not IsNextTokenChar('=')) or
          (not IsNextTokenResWord(ID_Class)) or
          (not IsNextTokenChar('(')) or
          (NextToken <> tokSymbol) or
          (not IsNextTokenChar(')')) then
          continue;
        PopState;
        Result := True;
        break;
      end;
    end;
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.GetOwnerCompsDesc(var pt: TPoint): boolean;
begin
  result := GetOwnerTypeDesc(pt);

  if result then
    with GetSyntaxParser do
    begin
      NextValidToken; // =
      NextValidToken; // class
      NextValidToken; // (
      NextValidToken; // TForm
      NextValidToken; // )
      NextValidToken;
      pt := Point(TokenCharPos + 1, LinePos);
      result := true;
    end;
end;

{-----------------------------------------------------------}

function GetCompStr(Comp: TComponent; const CompName: string): string;
begin
  result := '    ' + BuildCompName(Comp, CompName) + ';';
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.InsertMethodInTypeDesc(const AMethodName: string; TypeData: PTypeData);
var
  pt: TPoint;
  i: integer;
  s: string;
begin
  if GetOwnerCompsDesc(pt) then
  begin
    i := pt.y;
    while (i < Strings.Count) do
    begin
      s := UpperCase(Trim(Strings[i]));
      if s = 'PRIVATE' then //don't resource
      begin
        Strings.Insert(i, '    ' + CreateEventName(AMethodName, TypeData, false, false));
        break;
      end;

      inc(i);
    end;
  end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.SkipToFinalEnd;
begin
  with GetSyntaxParser do
    while not ParserEOF do
      if SkipToResWord(ID_END) then
        if PeekValidTokenStr = '.' then
          break
        else
          NextValidToken;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.CreateMethod(const AMethodName: string; TypeData: PTypeData);
var
  mtemplate: TStringList;
  i: integer;
  TempCount: Integer;
begin
  with GetParser do
    with Strings do
    begin
      BeginUpdate;
      mtemplate := nil;
      try
        InsertMethodInTypeDesc(AMethodName, TypeData);

        SkipToFinalEnd;

        {
                if ParserEOF then
                  exit;
        }
        mtemplate := TStringList.Create;

        GetMethodTemplate(AMethodName, TypeData, mtemplate);

        if (LinePos > 0) and (Strings[LinePos - 1] <> '') then
          Insert(LinePos, '');

        for i := 0 to mtemplate.Count - 1 do
          Insert(LinePos + i, mtemplate[i]);

        TempCount := mtemplate.Count;

      finally
        EndUpdate;
        mtemplate.Free;
      end;

      ShowSource(0, LinePos + TempCount - 1);
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.InsertComponent(Comp: TComponent; const CompName: string);
var
  pt: TPoint;
  i: integer;
  s: string;
begin
  inherited;
  if GetOwnerCompsDesc(pt) then
  begin
    i := pt.y;
    while (i < Strings.Count) do
    begin
      s := UpperCase(Trim(Strings[i]));
      if (s = 'PRIVATE') or (pos('FUNCTION', s) = 1) or (pos('PROCEDURE', s) = 1) then //don't resource
      begin
        Strings.Insert(i, GetCompStr(Comp, CompName));
        break;
      end;

      inc(i);
    end;
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.GetCompStringIndex(Comp: TComponent): integer;
var
  pt: TPoint;
  i: integer;
  s: string;
  compstring: string;
begin
  result := -1;

  if GetOwnerCompsDesc(pt) then
  begin
    i := pt.y;
    compstring := Trim(GetCompStr(Comp, ''));
    while (i < Strings.Count) do
    begin
      s := Trim(Strings[i]);
      if CompareText(s, 'PRIVATE') = 0 then //don't resource
        break;

      if CompareText(s, compstring) = 0 then
      begin
        result := i;
        exit;
      end;

      inc(i);
    end;
  end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.DeleteComponent(Comp: TComponent);
var
  i: integer;
begin
  inherited;
  i := GetCompStringIndex(Comp);
  if i >= 0 then
    Strings.Delete(i);
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameOwnerInVar(const NewName: string);
var
  x: integer;
  y: integer;
  s: string;
begin
  if ModuleOwner = nil then
    exit;
    
  with GetParser do
    if SkipToResWord(ID_Interface) then
    begin
      repeat
        NextToken;
        if Token in [tokComment, tokString] then
          continue;

        if CompareText(TokenString, ModuleOwner.Name) = 0 then
        begin
          x := TokenCharPos;
          y := LinePos;
          if (CompareText(NextValidTokenStr, ':') = 0) and
            (CompareText(NextValidTokenStr, BuildClassName(ModuleOwner.Name)) = 0) then
          begin
            s := Strings[y];
            Replace(s, x + 1, ModuleOwner.Name, NewName);
            Strings[y] := s;

            LinePos := y;
            CharPos := x;
            NextToken;
            NextValidToken; // :
            NextValidToken;

            s := Strings[LinePos];
            Replace(s, TokenCharPos + 2, ModuleOwner.Name, NewName);

            Strings[LinePos] := s;
          end;
        end;
      until ParserEOF or IsTokenResWord(ID_Implementation);
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameOwnerInEvents(const NewName: string);

  function IsOwnerEvent: boolean;
  begin
    result := false;
    with GetSyntaxParser do
      if CompareText(TokenString, BuildClassName(ModuleOwner.Name)) = 0 then
      begin
        PushState;
        NextToken;
        result := isTokenChar('.');
        PopState;
      end;
  end;

var
  s: string;

begin
  if ModuleOwner = nil then
    exit;
     
  with GetParser do
    while not ParserEOF do
      if (token = tokResWord) and IsMethodStart then
      begin
        NextValidTokenStr;
        if IsOwnerEvent then
        begin
          s := Strings[LinePos];
          Replace(s, TokenCharPos + 2, ModuleOwner.Name, NewName);
          Strings[LinePos] := s;
        end;
      end
      else
        NextToken;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameOwnerInTypeDesc(const NewName: string);
var
  pt: TPoint;
  s: string;
begin
  if ModuleOwner = nil then
    exit;

  if GetOwnerTypeDesc(pt) then
    begin
      s := Strings[pt.y];
      Replace(s, pt.x + 1, ModuleOwner.Name, NewName);
      Strings[pt.y] := s;
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameOwner(const NewName: string);
begin
  RenameOwnerInTypeDesc(NewName);
  RenameOwnerInVar(NewName);
  RenameOwnerInEvents(NewName);
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameComponent(Comp: TComponent; const NewName: string);
var
  i: integer;
begin
  inherited;
  if Comp = ModuleOwner then
    RenameOwner(NewName)
  else
  begin
    i := GetCompStringIndex(Comp);
    if i >= 0 then
      Strings[i] := GetCompStr(Comp, NewName);
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.ScanMethodName: string;
begin
  with GetSyntaxParser do
    begin
      result := NextValidTokenStr;
      if ModuleOwner <> nil then
        if CompareText(result, BuildClassName(ModuleOwner.Name)) = 0 then
          begin
            NextToken;
            if isTokenChar('.') then
              result := NextTokenStr;
          end;
    end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.FindMethodInTypeDesc(const AMethodName: string;
  var pt: TPoint): boolean;
var
  i: integer;
begin
  result := false;

  if GetOwnerCompsDesc(pt) then
    with GetSyntaxParser do
    begin
      i := pt.y;
      while (i < Strings.Count) do
      begin
        LinePos := i;
        CharPos := 0;
        NextToken;
        if IsTokenResWord(ID_PRIVATE) then
          break;

        if IsMethodStart and
          (CompareText(PeekValidTokenStr, AMethodName) = 0) then
        begin
          NextValidToken;
          pt := Point(TokenCharPos + 1, LinePos);
          result := true;
        end;

        inc(i);
      end;
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.RenameMethod(const OldName, NewName: string);
var
  pt: TPoint;
  s: string;
begin
  inherited;
  if FindMethodInTypeDesc(OldName, pt) then
    with pt do
    begin
      s := Strings[y];
      Replace(s, x, OldName, NewName);
      Strings[y] := s;
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiCodeDesigner.DeleteMethod(const MethodName: string);
var
  pt: TPoint;
  i: integer;
begin
  inherited;
  if FindMethodInTypeDesc(MethodName, pt) then
    Strings.Delete(pt.y);
  with GetSyntaxParser do
  begin
    SkipToFinalEnd;
    if not ParserEOF then
    begin
      i := LinePos;
      while (i > 1) and (Strings[i - 1] = '') and (Strings[i - 2] = '') do
      begin
        Strings.Delete(i - 1);
        dec(i);
      end;
    end;
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.PeekTokenStr2 : string;
begin
  with GetSyntaxParser do
    begin
      PushState;
      NextValidToken;
      result := NextValidTokenStr;
      PopState;
    end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner._FindMethod(const AMethodName: string; var pt: TPoint): boolean;
var
  hastypedesc : boolean;
  pt2         : TPoint;
begin
  hastypedesc := GetOwnerTypeDesc(pt2);
  with GetParser do
    while not ParserEOF do
      if (token = tokResWord) and IsMethodStart and IdentsEqual(GetMethodName, AMethodName) and
         (not hastypedesc or (PeekTokenStr2 = '.')) then
      begin
        pt := Point(TokenCharPos + 1, LinePos);
        result := true;
        exit;
      end
      else
        NextToken;

  result := false;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.FindMethod(const AMethodName: string; var pt: TPoint): boolean;
begin
  result := _FindMethod(AMethodName, pt);
  if result then
    with GetSyntaxParser do
    begin
      if PeekTokenStr2 = '.' then
        begin
          repeat
            NextToken; //.
          until IsTokenChar('.');

          NextToken;
        end;
      pt := Point(TokenCharPos + 1, LinePos);
    end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.GetMethodEnd(var pt: TPoint): boolean;
begin
  result := inherited GetMethodEnd(pt);
  with GetSyntaxParser do
  begin
    NextValidToken; // ;
    pt := Point(CharPos, LinePos);
  end;
end;

{-----------------------------------------------------------}

function TDelphiCodeDesigner.DoDeleteEmptyMethods: boolean;
begin
  SyntaxParser.SkipToResWord(ID_Implementation);
  result := inherited DoDeleteEmptyMethods;
end;

{------------TPerlCodeDesigner--------------------------------------}

function TPerlCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TPerlParser;
end;

{-----------------------------------------------------------}

function TPerlCodeDesigner.IsMethodStart: boolean;
begin
  result := SyntaxParser.TokenString = 'sub'; //don't resource
end;

{-----------------------------------------------------------}

function TPerlCodeDesigner.GetFuncName(TypeData: PTypeData): string;
begin
  result := 'sub '; //don't resource
end;

{-----------------------------------------------------------}

function TPerlCodeDesigner.GetComment: string;
begin
  result := '#';
end;

{-----------------------------------------------------------}

function TPerlCodeDesigner.CreateEventName(const EventName: string; TypeData: PTypeData; OnlyType: boolean): string;
var
  P: PChar;
  i: integer;
begin
  result := '';
  if TypeData = nil then
    exit;

  result := GetFuncName(TypeData) + EventName + ' # ';
  P := @TypeData^.ParamList;
  for i := 1 to TypeData^.ParamCount do
  begin
    inc(p);
    Result := Result + PReadShortStr(p) + ', ';
    PReadShortStr(p);
  end;
  delete(result, length(result) - 1, 2);
end;

{-----------------------------------------------------------}

function TPerlCodeDesigner.IsEqualDeclaration(TypeData: PTypeData): boolean;
begin
  result := true;
end;

{---------TSqlCodeDesigner---------------------------------------}

function TSqlCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := TSqlParser;
end;

{---------THTMLCodeDesigner--------------------------------------}

function THTMLCodeDesigner.GetSyntaxParserClass: TSimpleParserClass;
begin
  result := THTMLParser;
end;

{-----------------------------------------------------------}

procedure THTMLCodeDesigner.FillWithTemplate(const ModuleName: string; NewTemplate: boolean);
begin
  if NewTemplate then
    Strings.Text := Format(SNewHTMLTemplate, [ModuleName]);
end;

{-----------------------------------------------------------}

procedure _Register;
begin
  RegisterUnitCodeDesigner(TVbsCodeDesigner, SExtvbs);
  RegisterUnitCodeDesigner(TJsCodeDesigner, SExtjs);
  RegisterUnitCodeDesigner(TUnitCodeDesigner, SExtpas);
  RegisterUnitCodeDesigner(TPerlCodeDesigner, SExtpl);
  RegisterUnitCodeDesigner(TPythonCodeDesigner, SExtPython);

  RegisterFormCodeDesigner(TDelphiCodeDesigner, SExtpas);
  RegisterFormCodeDesigner(TVbsCodeDesigner, SExtvbs);
  RegisterFormCodeDesigner(TJsCodeDesigner, SExtjs);
  RegisterFormCodeDesigner(TPerlCodeDesigner, SExtpl);
  RegisterFormCodeDesigner(TPythonCodeDesigner, SExtPython);

  RegisterUnitCodeDesigner(TSqlCodeDesigner, SExtsql);
  RegisterUnitCodeDesigner(THTMLCodeDesigner, SExthtml);
  RegisterUnitCodeDesigner(THTMLCodeDesigner, SExthtm);
end;

{-----------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SpalDreamMemo, [TJsCodeDesigner, TVbsCodeDesigner,
    TDelphiCodeDesigner, TPerlCodeDesigner,
      TPythonCodeDesigner]);
end;

{-----------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-----------------------------------------------------------}

initialization
  RunRegister;
end.

