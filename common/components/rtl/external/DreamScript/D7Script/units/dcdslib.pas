{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDSLib;

interface
{$I dc.inc}
Uses
  {$IFDEF WIN32}
  Windows,
  {$ELSE}
  dcactivex,
  {$ENDIF}

  SysUtils, Classes, dcdreamLib, dcsystem, dcscript;

const

  SEmptyScriptName = 'Delphi Script Block';

  SEBreakpointBegin = 'Invalid breakpoint condition: ';
  SEBreakpointEnd = '. Error message: ';

  SVarUnknown = 'Unknown';
  SVarNull = 'Null';
  SVarUnassigned = 'Unassigned';
  SVarBoolTrue = 'True';
  SVarBoolFalse = 'False';

  cMaxKnownScripts = 3;
  SStrKnownScripts: Array[0..cMaxKnownScripts -1] of string =
  ('JScript', 'VBScript', 'DelphiScript');

type
  TBreakResumeType =(brtNone, brtAbort, brtContinue, brtStepInto, brtStepOver, brtEvaluate);
  TEvaluateSpecifier = (evsNone, evsHex, evsFloating);

  TKindOfScript = (kscNone, kscJavaScript, kscVBScript, kscDelphiScript, kscUnknown);

  TCustomBreakPoint=Class(TCollectionItem)
  Private
    FCondition:String;
    FEnabled:Boolean;
    FLine:Integer;
    FPassCount:Integer;
    FUnitHandle:Integer;
    FPassCntr: integer;
    procedure SetPassCount(const Value: Integer);
  protected
    function CheckPassCount: boolean;
    function CheckCondition: boolean; virtual;
  Published
    Property Condition:String read FCondition write FCondition;
    Property Enabled:Boolean read FEnabled write FEnabled;
    Property Line:Integer read FLine write FLine;
    Property PassCount:Integer read FPassCount write SetPassCount;
    Property UnitHandle:Integer read FUnitHandle write FUnitHandle;
  End;

  TCustomStackItem = class
  private
    FLine: integer;
    FUnitHandle: integer;
  protected
    property UnitHandle: integer read FUnitHandle;
  public
    constructor Create(AUnitHandle:integer; ALine:integer);
    destructor Destroy; override;
    property Line: integer read FLine;
  end;

  TCustomUnit = class
  protected
    FName: string;
    FParser: TSimpleParser;
    function GetText : string; virtual; abstract;
    function GetParser : TSimpleParser; virtual; abstract;
  public
    property Text: string read GetText;
    property Name: string read FName;
    property Parser: TSimpleParser read GetParser;
  end;

  TCrtlSection = class
  private
    FCrtlSect: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Enter;
    procedure Leave;
  end;

type
  PRunToLineInfo = ^TRunToLineInfo;
  TRunToLineInfo = record
    AtLine: integer;
    AtUnit: Pointer;
    Stop: boolean;
  end;


function  ExpressionToSpecifier(var AExpress: string; var Digits: integer):TEvaluateSpecifier;
function  ConvertVarToStr(const OleVar: OleVariant; const ASpecifier: TEvaluateSpecifier;
          const Cnt: integer; ASc: TKindOfScript; AStrInBracks: boolean; ScriptRunner : TScriptRunner {$IFDEF D4}= nil{$ENDIF}): string;
procedure GetPreffixes (ASc: TKindOfScript; var APref_Hex, APref_Str: string);

implementation

uses Registry, shellapi;

{-----------------------------------------------------}

function ExpressionToSpecifier(var AExpress: string; var Digits: integer):TEvaluateSpecifier;
var
  _D, i: integer;
  Ch:Char;
begin
  Result := evsNone;
  Digits:=0;
  I:=BackPosEx(',',AExpress,Length(AExpress));
  if i = 0 then
    exit;
  _D := Length(AExpress) - i + 1;
  Ch:=UpCase(AExpress[i+1]);
  case Ch of
    'H' : if _D = 2 then
            Result := evsHex;
    'F' : begin
            try
              if _D = 2 then
                Digits := 11
              else
                Digits := StrToInt(Copy(AExpress, i+2, _D));
              Result := evsFloating;
            except
            end;
          end;
  end;
  if (Result <> evsNone) and (_D > 1) then
    Delete(AExpress, i, _D + 2);
end;

{-----------------------------------------------------}

procedure GetPreffixes (ASc: TKindOfScript; var APref_Hex, APref_Str: string);
begin
  case ASc of
    kscDelphiScript:
      begin
        APref_Hex := '$';
        APref_Str := '''';
      end;
    kscJavaScript:
      begin
        APref_Hex := '0x';
        APref_Str := '"';
      end;
    kscVBScript:
      begin
        APref_Hex := '&H';
        APref_Str := '"';
      end;
    else
    begin
      APref_Hex := '0x';
      APref_Str := '"';
    end;
  end;
end;

{-----------------------------------------------------}

function ConvertVarToStr(const OleVar: OleVariant; const ASpecifier: TEvaluateSpecifier;
         const Cnt: integer; ASc: TKindOfScript; AStrInBracks: boolean; ScriptRunner : TScriptRunner {$IFDEF D4}= nil{$ENDIF}): string;
var
  Pref_Hex, Pref_Str: string;
begin
  if ScriptRunner <> nil then
    ScriptRunner.GetWatchesPreffixes(Pref_Hex, Pref_Str)
  else
    GetPreffixes(ASc, Pref_Hex, Pref_Str);
    
  with TVarData(OleVar) do
    case vType of
      varEmpty: Result := SVarUnassigned;
      varNull : Result := SVarNull;
      varSmallint:
                 begin
                   if ASpecifier = evsHex then
                     Result := Pref_Hex + IntToHex(VSmallint,0)
                   else
                     Result := IntToStr(VSmallint);
                 end;
      varInteger:
                 begin
                   if ASpecifier = evsHex then
                     Result := Pref_Hex + IntToHex(VInteger,0)
                   else
                     Result := IntToStr(VInteger);
                 end;
      varSingle:
                 begin
                   if ASpecifier = evsFloating then
                     Result := FloatToStrF(VSingle,ffGeneral,Cnt,0)
                   else
                     Result := FloatToStrF(VSingle,ffGeneral,11,0)
                 end;
      varDouble :
                 begin
                   if ASpecifier = evsFloating then
                     Result := FloatToStrF(VDouble,ffGeneral,Cnt,0)
                   else
                     Result := FloatToStrF(VDouble,ffGeneral,11,0)
                 end;
      varCurrency: Result := FloatToStrF(VCurrency,ffCurrency,10,10);
      varDate : Result := DateTimeToStr(VDate);
      varOleStr : begin
                    if AStrInBracks then
                      Result :=  Pref_Str + String(VOleStr) + Pref_Str
                    else
                      Result :=  String(VOleStr);
                  end;
      varBoolean : if VBoolean then
                     Result := SVarBoolTrue
                   else
                     Result := SVarBoolFalse;
      varUnknown : Result := Pref_Hex + IntToHex(Integer(VUnknown),0);
      varByte : Result := IntToStr(VByte);
      varString : begin
                    if AStrInBracks then
                       Result := Pref_Str + String(VString^)  + Pref_Str
                    else
                       Result := String(VString^);
                  end;
      (varByRef + varVariant): Result := ConvertVarToStr(POleVariant(VPointer)^, ASpecifier, Cnt, ASc, AStrInBracks,nil);
    else
      Result := SVarUnknown;
    end;
end;

{-----------------------------------------------------}

{ TCustomBreakPoint }

function TCustomBreakPoint.CheckCondition: boolean;
begin
  Result := true;
end;

function TCustomBreakPoint.CheckPassCount: boolean;
begin
  Dec(fPassCntr);
  Result := fPassCntr <= 0;
  if Result then
    fPassCntr := FPassCount;
end;

procedure TCustomBreakPoint.SetPassCount(const Value: Integer);
begin
  FPassCount := Value;
  FPassCntr := Value;
end;

{ TCustomStackItem }

constructor TCustomStackItem.Create(AUnitHandle, ALine: integer);
begin
  FLine := ALine;
  FUnitHandle := AUnitHandle;
end;

destructor TCustomStackItem.Destroy;
begin
  inherited;
end;

{ TCrtlSection }

constructor TCrtlSection.Create;
begin
  InitializeCriticalSection(FCrtlSect);
end;

destructor TCrtlSection.Destroy;
begin
  DeleteCriticalSection(FCrtlSect);
  inherited Destroy;
end;

procedure TCrtlSection.Enter;
begin
  EnterCriticalSection(FCrtlSect);
end;

procedure TCrtlSection.Leave;
begin
  LeaveCriticalSection(FCrtlSect);
end;

end.
