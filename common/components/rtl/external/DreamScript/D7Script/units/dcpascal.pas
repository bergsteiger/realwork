{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpascal;
{$I dc.inc}
{$I dcscripter.inc}

interface
//{$DEFINE USECOMPILER}


uses
  forms,
  dcsystem, consts, dcscript, classes, sysutils,

  dcscriptdebug,

  {$IFDEF D4}
  sysconst,
  {$ENDIF}

  {$IFDEF ACTIVESCRIPTING}
  dcdscript,
  {$ENDIF}

  {$IFDEF ACTIVESCRIPTING}
  ActiveX,
  Windows,
  {$ELSE}
  dcactivex,
  {$ENDIF}

  {$IFDEF D6}
  Variants,
  {$ENDIF}

  {$IFDEF D6}
  VarUtils, RTLConsts,
  {$ENDIF}

  typinfo,
  dcconsts, dcdreamlib, dcparser;

const
  SErrScriptNotParsed = 'Script is not parsed';
  SErrTypedConst = 'Typed constants aren''t supported';
  SErrConstantExpected = 'Constant expression expected';
  SErrUnterminated = 'Unterminated string';
  SErrSymbol = 'Unexpected symbol : ';
  SErrObjectTypeExpected = 'Object type required';
  SErrUndeclaredIdentifier = 'Undeclared identifier: %s';
  SErrEvaluate = 'Can''t evaluate : %s';
  SErrDivByZero = 'Division by zero';
  SErrParamsCount = 'Bad parameters count';
  SErrProcedureResult = 'Procedure can''t have a result type';
  SErrFunctionNeedsResult = 'Function needs result type';
  SErrLabelNotSet = 'Label declared and referenced, but not set';
  SExpression = 'Expression';
  SErrLowBoundExceedsHighBound = 'Low bound exceeds high bound';
  SErrDefValueIsVar = 'Default parameter ''%s'' must be by value or const';
  SErrDefValueRequired = 'Default value required for ''%s''';
  SErrOrdinalTypeExpected = 'Ordinal type expected';
  SErrUnknownDirective = 'Unknown directive';
  SErrUnknownType = 'Unknown type: %s';
  SErrOutOfMem = 'Not enough storage is available to complete this operation.';
  SErrTopLevelVar = 'Can''t access top level variable';
  SIdentifier = 'Identifier';
  SErrInvalidConstant = 'Invalid constant';
  SErrUnexpectedEOF = 'Unexpected end of file';
  {$IFNDEF D4}
  SRangeError = 'Range check error';
  SVarArrayCreate = 'Error creating variant array';
  {$ENDIF}
  SErrIdentifierRedeclared = 'Identifier redeclared: ''%s''';
type
  tbytearray = Array[0..maxparams] of byte;

type
  TIdentType = (tivariable, tiprocedure, tifunction);
  TDCParamType = (ptNormal, ptVar, ptConst);

type
  TIdentListItem = class
  private
    procedure SetParam(i : integer; val : TDCParamType);
    function  GetParam(i : integer) : TDCParamType;
  public
    Address    : integer;
    IdentType  : TIdentType;

    ParamNames : TStringList;
    DefaultParams : TList;
    Name       : string;
    LocalsSize : integer;

    Bounds     : TList;

    constructor Create;
    destructor Destroy; override;
    Procedure  Assign(Source: TIdentlistItem);
    function   HasParams : boolean;

    property   Params[i : integer] : TDCParamType read GetParam write SetParam;
  End;

type
  TExecuteLineEvent = procedure (Sender : TObject; LineNo : integer) of object;

(*
  IDCDScriptRunner = interface
  ['{A212B78A-C59C-40C9-B28D-675D865A0A98}']
    function ProcessDMethodCall(const AName : string; Params : Pointer; const  ParamCount : integer; var VarResult : Variant) : boolean;
  end;
*)
  TDelphiRunner = class(TScriptRunner, IUnknown, IDispatch (*, IDCDScriptRunner*))
  private
    FBinProg      : TObject;
    FHalCompiler  : TObject;
    FRefCount     : Longint;
    fParsedScript : string;
    fOnExecuteLine : TExecuteLineEvent;

    fLastIDName    : string;
    fLastID        : integer;
    fFreeOnRelease : boolean;

    {$IFDEF ACTIVESCRIPTING}
    FDSProject     : TDSProjectRun;
    FDSUnit        : TDSUnit;
    procedure _OnDebuggerConnect (Sourse: TObject);
    procedure _OnDebuggerDisconnect (Sourse: TObject);
    procedure ChangeTraceLine (ADebugInfo: TLineDebugInfo);
    procedure FunctionEnter (const ANewLine, AOldLine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList);
    procedure FunctionExit (const ANewLine, AOldLine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList);
    procedure CatchException (AExeption: Exception; ADebugInfo: TLineDebugInfo);
    {$ENDIF}

    {IUnknown}
    function QueryInterface(const IID: TGUID; out  Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IDispatch}
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT; stdcall;

    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; stdcall;

    (*
    {IDCDScriptRunner}
    function ProcessDMethodCall(const AName : string; Params : Pointer; const  ParamCount : integer; var VarResult : Variant) : boolean;
    *)
    procedure InvokeError(const AName : string; const Status : {$IFDEF D5}integer{$ELSE}DWORD{$ENDIF}; var ExcepInfo : TExcepInfo);

    function  ProcessProcedureCall(const AName:string; Params : Pointer; const  ParamCount : integer;
              const InvKind : integer; var ExcepInfo : TExcepInfo;  var Status : TDCErrorStatus;Var Successful : boolean) : variant;

    function  MethodCall(AItem : TIdentListItem; var Params : TDispParams; VarResult : POleVariant) : HRESULT;
    function  PutProperty(Item : TIdentListItem; Params : TDispParams) : HResult;
    function  GetProperty(Item : TIdentListItem; VarResult : POleVariant) : HResult;

    procedure FreeProg;
    procedure SetOnExecuteLine(val : TExecuteLineEvent);
  protected
    procedure FreeRunner; override;
    function GetModuleAlias : string; override;
    function  GetScriptDispatch : IDispatch; override;


    procedure DoOut(const s : string);

    procedure DoInterrupt; override;
    procedure CheckCompiled;
  public
    function   CurrentExecutionLine : integer; override;
    procedure  TraceInto; override;
    procedure  StepOver; override;

    constructor Create(AScripter : TDCScripter; const AScriptName : string); override;
    destructor  Destroy; override;
    function    ParseScript(const Script : string) : boolean; override;
    procedure   GetVarList(S : TStrings); override;

    procedure SaveToStream(S : TStream); override;
    procedure LoadFromStream(S : TStream); override;

    function  EvaluateExpression(const Expr : string) : OleVariant; override;
    procedure   GetProgramCodes(s : TStream);
    {$IFDEF ACTIVESCRIPTING}
    property  DSProject: TDSProjectRun read FDSProject;
    function  GetStackState: integer;
    procedure SetStackState(ANewState: integer);
    {$ENDIF}

    function GetExecutionLine : integer;
    procedure GetWatchesPreffixes(var APref_Hex, APref_Str: string); override;

    function FindConstant(const ConstName : string; var VarValue : Variant) : boolean;
    property OnExecuteLine : TExecuteLineEvent read fOnExecuteLine write SetOnExecuteLine;
  end;
{---------------------------------------------------}

function Evaluate(const expr : string) : string;

type
  TOleVariantArray = array[0..1] of OleVariant;
  POleVariantArray = ^TOleVariantArray;

function GetObjectProperty(const idisp : IDispatch; const PropName : string; cParams : integer;
                      pParams : POleVariantArray; var VarResult : Variant; var ErrMsg : string) : boolean;

procedure DCRegisterType(const ANames : array of string; const ATypes : array of PTypeInfo);
procedure DCUnregisterType(const ANames : array of string);

implementation
{$IFDEF ACTIVESCRIPTING}
uses dcDSLib;
{$ENDIF}

//{$IFDEF THREADSAFE}
//{$UNDEF USECOMPILER}
//{$ENDIF}

var
  DCTypesList : TStringList = nil;

{------------------------------------------------------------------}

procedure DCInitTypesList;
begin
  if Assigned(DCTypesList) then
    Exit;
  DCTypesList := TStringList.Create;
  with DCTypesList do
    Sorted := True;
end;

{------------------------------------------------------------------}

procedure DCRegisterType(const ANames : array of string; const ATypes : array of PTypeInfo);
var
  I : Integer;
begin
  DCInitTypesList;
  for I := Low(ATypes) to High(ATypes) do
    DCTypesList.AddObject(ANames[I], Pointer(ATypes[I]));
end;

{------------------------------------------------------------------}

procedure DCUnregisterType(const ANames : array of string);
var
  I, Idx : Integer;
begin
  if not Assigned(DCTypesList) then
    Exit;
  for I := Low(ANames) to High(ANames) do
    begin
      Idx := DCTypesList.IndexOf(ANames[I]);
      if Idx >= 0 then
        DCTypesList.Delete(Idx);
    end;
end;

{------------------------------------------------------------------}

function DCFindTypeByName(const ATypeName : string) : PTypeInfo;
var
  Idx : Integer;
begin
  Result := nil;
  if not Assigned(DCTypesList) then
    Exit;
  Idx := DCTypesList.IndexOf(ATypeName);
  if Idx >= 0 then
    Result := Pointer(DCTypesList.Objects[Idx]);
end;

{------------------------------------------------------------------}

procedure DCInitParamInfo(ATypeInfo : PTypeInfo; AFlags : TParamFlags;
  var AParamInfo : TParamRec; var AParamsSize : Integer);
var
  ConvInfo : PTypeConvertInfo;
begin
  if ATypeInfo = nil then
    begin
      with AParamInfo do
        begin
          PSize := 4;
          UseRegister := 1;
          VarToParam := nil;
          ParamToVar := nil;
          VarToVar := nil;
          FreeParam := nil;
          Flags := AFlags;
          _tinfo := nil;
          Inc(AParamsSize, 4);
        end;
      Exit;
    end;

  ConvInfo := GetConvertInfo(ATypeInfo);
  TypeConvertToParamRec(ConvInfo, AParamInfo, AFlags, ATypeInfo, AParamsSize);
end;

{------------------------------------------------------------------}

function DCProcedureDeclParser(const AProcDecl : string) : TMethodInfo;
var
  HasResult : Boolean;
  Parser : TDelphiParser;
  ParamPassed : Boolean;

  {- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}

  procedure _ParseDeclarationBegin;
  begin
    if (Parser.NextToken = tokResWord) and (Parser.ResWordID in [ID_PROCEDURE, ID_FUNCTION]) then
      HasResult := Parser.ResWordID = ID_FUNCTION
    else
      ErrorFmt(SErrExpectedButFound, ['PROCEDURE or FUNCTION', Parser.TokenString]); //don't resource
  end;

  {- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}

  procedure _AddNewParam(var AParamType : string; var AFlags : TParamFlags; var AParamsNumber : Integer);
  var
    I : Integer;
    Info : PTypeInfo;
  begin
    if ParamPassed then
      Exit;
    if AParamType <> '' then
      begin
        Info := DCFindTypeByName(AParamType);
        if Info = nil then
          ErrorFmt(sErrUnknownType, [AParamType]);
      end
    else
      Info := nil;

    for I := 1 to AParamsNumber do
      begin
        Result.ParamCount := Result.ParamCount + 1;
        DCInitParamInfo(Info, AFlags, Result.ParamRecs[Result.ParamCount - 1], Result.ParamsSize);
      end;

    AParamType := '';
    AFlags := [];
    AParamsNumber := 1;
    ParamPassed := True;
  end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure _ParseType(var ATypeName : string; var AFlags : TParamFlags);
  begin
    with Parser do
      begin
        NextValidToken;
        if IsTokenResWord(ID_ARRAY) then
          begin
            Include(AFlags, pfArray);
            NextValidToken; // OF
            NextValidToken;
          end;

        if IsTokenResWord(ID_CONST) and (pfArray in AFlags) then
          ATypeName := 'Array of Const' //don't resource
        else
          ATypeName := TokenString;
      end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure _ProcessParameters;
  var
    ParamsNumber : Integer;
    Flags : TParamFlags;
    VarType, PeekStr : string;
  begin
    Flags := [];
    ParamsNumber := 1;
    ParamPassed := True;
    with Parser do
      while not (ParserEOF or IsTokenChar(')')) do
        begin
          if IsTokenResWord(ID_VAR) then
            begin
              Flags := [pfVar];
              ParamPassed := False;
            end
          else
            if IsTokenResWord(ID_OUT) then
              begin
                Flags := [pfOut];
                ParamPassed := False;
              end
            else
              if IsTokenResWord(ID_CONST) then
                begin
                  Flags := [pfConst];
                  ParamPassed := False;
                end
              else
                if IsTokenChar(';') then
                  _AddNewParam(VarType, Flags, ParamsNumber)
                else
                  if IsTokenChar(':') then
                    begin
                      ParamPassed := False;
                      _ParseType(VarType, Flags);

                      if PeekValidTokenStr = '=' then
                        repeat
                          NextValidToken;
                          PeekStr := PeekValidTokenStr;
                          if (PeekStr = ';') or (PeekStr = ')') then
                            break;
                        until ParserEOF;
                      _AddNewParam(VarType, Flags, ParamsNumber);
                    end
                  else
                    if IsTokenChar(',') then
                      Inc(ParamsNumber);

          NextValidToken;
        end;
    _AddNewParam(VarType, Flags, ParamsNumber)
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure _ParseDeclTail;
  var
    ResultType : string;
  begin
    with Parser do
      begin
        if IsTokenChar(':') then
          begin
            if not HasResult then
              Error(SErrProcedureResult);
              
            NextValidToken;
            ResultType := TokenString;
            Result.RetType := DCFindTypeByName(ResultType);
            if Result.RetType = nil then
              ErrorFmt(SErrUnknownType, [ResultType]);
            NextValidToken;
          end;
        while not ParserEOF do
          begin
            if Token = tokResWord then
              case ResWordID of
                ID_Of : Result.OfObject := True;
                ID_Register : Result.CallType := cRegister;
                ID_Pascal : Result.CallType := cPascal;
                ID_cdecl : Result.CallType := cCdecl;
                ID_Stdcall : Result.CallType := cStdCall;
                ID_Safecall : Result.CallType := cSafeCall;
              end;
            NextValidToken;
          end;
      end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Result := TMethodInfo.Create;
  with Result do
    begin
      OfObject := False;
      CallType := cRegister;
      Address := nil;
      RetType := nil;
      IsVirtual := False;
      IsDynamic := False;
      MethodType := mtProc;
      ParamCount := 0;
      ParamsSize := 0;
      ITypeData := nil; // This parameter cannot be obtained from inside this procedure.
    end;

  Parser := TDelphiParser.Create(nil);
{  Parser.Defines.Add('DCPASCAL');}
  with Parser do
    try
      Strings := TStringList.Create;
      Strings.Text := AProcDecl;
      LinePos := 0;
      try
        _ParseDeclarationBegin;
        NextToken;
        if IsTokenChar('(') then
          begin
            NextValidToken;
            _ProcessParameters;
          end
        else if not (IsTokenChar(':') or IsTokenChar(';')) then
          ErrorFmt(SErrExpectedButFound, ['''('', '':'' or '';''', TokenString]);

        NextValidToken;
        _ParseDeclTail;
      finally
        Strings.Free;
      end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

type
  TDCExternalProcLauncher = class
  private
    FInfo : TMethodInfo;
  public
    constructor Create(AProcAddress : Pointer; const AProcDecl : string);
    destructor Destroy; override;

    function Execute(cArgs : Integer; pArgs : PArgList) : OleVariant;
  end;

{------------------------------------------------------------------}

constructor TDCExternalProcLauncher.Create(AProcAddress : Pointer; const AProcDecl : string);
begin
  inherited Create;
  FInfo := DCProcedureDeclParser(AProcDecl);
  FInfo.Address := AProcAddress;
end;

{-------------------------------------------------------------------------}

destructor TDCExternalProcLauncher.Destroy;
begin
  FInfo.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TDCExternalProcLauncher.Execute(cArgs : Integer; pArgs : PArgList) : OleVariant;
begin
  DCScript.CallMethod(nil, FInfo, cArgs, pArgs, @Result);
end;

{*************************************************************************}

{$IFNDEF CLX}
var
  typesregistered : boolean = false;

const WinTypeNames :
  array [0 .. {$IFDEF D5}109{$ELSE}{$IFDEF D4}108{$ELSE}97{$ENDIF}{$ENDIF}] of string =
(
  'PChar', 'PAnsiChar', 'PWideChar', 'Array of const', 'Pointer',
  'Byte', 'Word', 'ShortInt', 'LongWord', 'Integer', 'Cardinal',

  'WCHAR', 'DWORD', 'BOOL', 'UCHAR', 'SHORT', 'UINT', 'ULONG', 'LCID',
  'LANGID', 'THandle', 'LONGLONG', {$IFDEF D4}'TLargeInteger',{$ENDIF} 'SID_NAME_USE',
  'TAclInformationClass', 'SECURITY_DESCRIPTOR_CONTROL',
  {$IFDEF D4}'AUDIT_EVENT_TYPE',{$ENDIF} 'TTokenType', 'TTokenInformationClass',
  'SECURITY_CONTEXT_TRACKING_MODE', 'SECURITY_INFORMATION', 'WPARAM', 'LPARAM',
  'LRESULT', 'LOWORD', 'LOBYTE', 'HWND', 'HHOOK', 'ATOM', 'TAtom', 'HGLOBAL',
  'HLOCAL', 'HGDIOBJ', 'HACCEL', 'HBITMAP', 'HBRUSH', 'HCOLORSPACE',
  'HDC', 'HGLRC', 'HDESK', 'HENHMETAFILE',
  'HFONT', 'HICON', 'HMENU', 'HMETAFILE',
  'HINST', 'HMODULE', 'HPALETTE', 'HPEN', 'HRGN', 'HRSRC', 'HSTR', 'HTASK',
  'HWINSTA', 'HKL', 'HFILE', 'HCURSOR', 'COLORREF', 'TColorRef', 'TComStateFlag',
  'TComStateFlags', {$IFDEF D4}'_GET_FILEEX_INFO_LEVELS',{$ENDIF}
  'TGetFileExInfoLevels', {$IFDEF D4}'GET_FILEEX_INFO_LEVELS',{$ENDIF}
  {$IFDEF D4}'_FINDEX_INFO_LEVELS', 'TFindexInfoLevels',
  'FINDEX_INFO_LEVELS', '_FINDEX_SEARCH_OPS',
  'TFindexSearchOps', 'FINDEX_SEARCH_OPS',{$ENDIF}
  'LCSCSTYPE', 'LCSGAMUTMATCH', 'FXPT16DOT16', 'FXPT2DOT30',
  {$IFDEF D4}'COLOR16',{$ENDIF} 'HDWP',
  {$IFDEF D5}'TOwnerDrawState',{$ENDIF}
  'HELPPOLY', 'LCTYPE', 'CALTYPE', 'CALID', 'REGSAM', 'HKEY',
  'ACCESS_MASK',

  'Char', 'ShortString', 'String', 'WideChar', 'AnsiString', 'WideString',
  'Single', 'Double', 'Extended', 'Currency',

  'TDateTime',
  'Variant', 'OleVariant',
  'Boolean', 'TObject', 'IUnknown'
);

procedure registerwintypes;
begin
  DCRegisterType(WinTypeNames ,
                  [ TypeInfoPChar, TypeInfoPChar, TypeInfoPWideChar, TypeInfoArrayOfConst,
                    TypeInfoPointer,

                    TypeInfo( Byte ), TypeInfo( Word ), TypeInfo( ShortInt ), TypeInfo( DWORD ),
                    TypeInfo( Integer ), TypeInfo( Cardinal ),

                    TypeInfo( WCHAR ), TypeInfo( DWORD ), TypeInfo( BOOL ), TypeInfo( UCHAR ),
                    TypeInfo( SHORT ), TypeInfo( UINT ), TypeInfo( ULONG ), TypeInfo( LCID ),
                    TypeInfo( LANGID ), TypeInfo( THandle ), TypeInfo( LONGLONG ),
                    {$IFDEF D4}TypeInfo( TLargeInteger ),{$ENDIF} TypeInfo( SID_NAME_USE ),
                    TypeInfo( TAclInformationClass ), TypeInfo( SECURITY_DESCRIPTOR_CONTROL ),
                    {$IFDEF D4}TypeInfo( AUDIT_EVENT_TYPE ),{$ENDIF} TypeInfo( TTokenType ),
                    TypeInfo( TTokenInformationClass ), TypeInfo( SECURITY_CONTEXT_TRACKING_MODE ),
                    TypeInfo( SECURITY_INFORMATION ), TypeInfo( WPARAM ), TypeInfo( LPARAM ),
                    TypeInfo( LRESULT ), TypeInfo( LOWORD ), TypeInfo( LOBYTE ), TypeInfo( HWND ),
                    TypeInfo( HHOOK ), TypeInfo( ATOM ), TypeInfo( TAtom ), TypeInfo( HGLOBAL ),
                    TypeInfo( HLOCAL ), TypeInfo( HGDIOBJ ), TypeInfo( HACCEL ),
                    TypeInfo( HBITMAP ), TypeInfo( HBRUSH ), TypeInfo( HCOLORSPACE ),
                    TypeInfo( HDC ), TypeInfo( HGLRC ), TypeInfo( HDESK ), TypeInfo( HENHMETAFILE ),
                    TypeInfo( HFONT ), TypeInfo( HICON ), TypeInfo( HMENU ), TypeInfo( HMETAFILE ),
                    TypeInfo( HINST ), TypeInfo( HMODULE ), TypeInfo( HPALETTE ), TypeInfo( HPEN ),
                    TypeInfo( HRGN ), TypeInfo( HRSRC ), TypeInfo( HSTR ), TypeInfo( HTASK ),
                    TypeInfo( HWINSTA ), TypeInfo( HKL ), TypeInfo( HFILE ), TypeInfo( HCURSOR ),
                    TypeInfo( COLORREF ), TypeInfo( TColorRef ), TypeInfo( TComStateFlag ),
                    TypeInfo( TComStateFlags ), {$IFDEF D4}TypeInfo( _GET_FILEEX_INFO_LEVELS ),{$ENDIF}
                    TypeInfo( TGetFileExInfoLevels ), {$IFDEF D4}TypeInfo( GET_FILEEX_INFO_LEVELS ),{$ENDIF}
                    {$IFDEF D4}TypeInfo( _FINDEX_INFO_LEVELS ), TypeInfo( TFindexInfoLevels ),
                    TypeInfo( FINDEX_INFO_LEVELS ), TypeInfo( _FINDEX_SEARCH_OPS ),
                    TypeInfo( TFindexSearchOps ), TypeInfo( FINDEX_SEARCH_OPS ),{$ENDIF}
                    TypeInfo( LCSCSTYPE ), TypeInfo( LCSGAMUTMATCH ), TypeInfo( FXPT16DOT16 ),
                    TypeInfo( FXPT2DOT30 ), {$IFDEF D4}TypeInfo( COLOR16 ),{$ENDIF} TypeInfo( HDWP ),
                    {$IFDEF D5}TypeInfo( TOwnerDrawState ), {$ENDIF}TypeInfo( HELPPOLY ), TypeInfo( LCTYPE ),
                    TypeInfo( CALTYPE ), TypeInfo( CALID ), TypeInfo( REGSAM ), TypeInfo( HKEY ),
                    TypeInfo( ACCESS_MASK ),

                    TypeInfo( Char ), TypeInfo( ShortString ), TypeInfo( String ),
                    TypeInfo( WideChar ), TypeInfo( AnsiString ), TypeInfo( WideString ),

                    TypeInfo( Single ), TypeInfo(Double), TypeInfo( Extended ), TypeInfo( Currency ),

                    TypeInfo( TDateTime ),

                    TypeInfo( Variant ), TypeInfo( OleVariant ),
                    TypeInfo( Boolean ), TypeInfo( TObject ), TypeInfo( IUnknown )
                  ] );
end;

function LoadExternalProc(AModule : HInst; const AProcName, AProcDecl : string) : TDCExternalProcLauncher;
var
  ProcAddress : Pointer;
begin
  if not typesregistered then
    begin
      typesregistered := true;
      registerwintypes;
    end;
  ProcAddress := GetProcAddress(AModule, PChar(AProcName));
  if ProcAddress = nil then
    {$IFDEF D6}
    RaiseLastOSError;
    {$ELSE}
    RaiseLastWin32Error;
    {$ENDIF}
  Result := TDCExternalProcLauncher.Create(ProcAddress, AProcDecl);
end;
{$ENDIF}

{function FastProcessMethodCall(const Dispatch : IDispatch; const AName : string; Params : Pointer; const  ParamCount : integer; var VarResult : Variant) : boolean;
var
  iDScriptRunner : IDCDScriptRunner;
begin
  if Dispatch.QueryInterface(IDCDScriptRunner, iDScriptRunner) = S_OK then
    result := iDScriptRunner.ProcessDMethodCall(AName, Params, ParamCount, VarResult)
  else
    result := false;
end;
}
function ProcessMethodCall(const Dispatch : IDispatch ; AName : PWideChar; Params : Pointer; const  ParamCount : integer;
                       const InvKind : integer;  var ExcepInfo : TExcepInfo; var Status : TDCErrorStatus; var Successful : boolean) : variant;
var
  fdispid    : TDispID;
  DispParams : TDispParams;
  NParams    : integer;
//  vNULL      : Variant;
begin
  if Dispatch = nil then
    exit;
  VarClear(result);
  Successful := false;
  if Dispatch.GetIDsOfNames(GUID_NULL, @AName, 1, 0, @fdispID) = S_OK then
    begin
      FillChar(DispParams, sizeof(DispParams), 0);
      if ParamCount <> 0 then
        begin
          DispParams.rgvarg := PVariantArgList(Params);
          DispParams.cArgs := ParamCount;
        end;

      if InvKind = DISPATCH_PROPERTYPUT then
        begin
          DispParams.cNamedArgs := 1;
          NParams := DISPID_PROPERTYPUT;
          DispParams.rgdispidNamedArgs := @NParams;
        end;
//      DispParams.cArgs := ParamCount;
      Status :=  Dispatch.Invoke(fdispID, GUID_NULL, 0, InvKind , DispParams, @result, @ExcepInfo, nil);
      Successful := Status = S_Ok;
      {if not Successful then
        InvokeError(AName,Status,ExcepInfo);}
    end;
end;

{-------------------------------------------------------------------------}

function GetObjectProperty(const idisp : IDispatch; const PropName : string; cParams : integer;
                      pParams : POleVariantArray; var VarResult : Variant; var ErrMsg : string) : boolean;
var
  einfo : TExcepInfo;
  Status : TDCErrorStatus;
  Successful : boolean;
  wName      : PWideChar;
begin
  wName := DCStringToOleSt(PropName);
  try
    VarResult := ProcessMethodCall(idisp, wName, pParams, cParams,
                        DISPATCH_PROPERTYGET or DISPATCH_METHOD, einfo,
                        Status, Successful);
  finally
    {$IFDEF WIN32}
    SysFreeString(wName);
    {$ENDIF}
  end;

  result := Successful and (Status = S_OK);
  if result then
    ErrMsg := ''
  else
    ErrMsg := einfo.bstrDescription;
end;

{-------------------------------------------------------------------------}

const
  MaxStackSize = $100000;

  ParserVersion = 3;

  { maximal number of procedure parameters allowed in the interpreter}
  maxparams = 100;

  S_UnknownIdent = 1001;

  FirstConstID = 65000;

{-------------------------------------------------------------------------}

Const
  coprocResult = '.RESULT'; // don't resource

Type
  ECompilerError = Class(Exception);

{-----------------------------------------------------------}

Type
  TToken = record
    TokenID : integer;
    iValue  : integer;
    fValue  : extended;
    stValue : string[255];
  End;

{----------------------------------------------}

{ Writer types }
const
  wInt8    = 0;
  wInt16   = wInt8   + 1;
  wInt32   = wInt16  + 1;
  wDouble  = wInt32  + 1;
  wString  = wDouble + 1;
  wEmpty   = wString + 1;
  wNULL    = wEmpty  + 1;
  wTrue    = wNULL   + 1;
  wFalse   = wTrue   + 1;
  wSingle  = wFalse  + 1;


{----------------------------------------------}

const
  ocNop            = 0;
  ocAdd            = ocNop + 1;
  ocSub            = ocAdd + 1;
  ocMul            = ocSub + 1;
  ocDiv            = ocMul + 1;
  ocMod            = ocDiv + 1;
  ocShl            = ocMod + 1;
  ocShr            = ocShl + 1;
  ocNot            = ocShr + 1;
  ocOr             = ocNot + 1;
  ocXor            = ocOr + 1;
  ocAnd            = ocXor + 1;

  ocSlash          = ocAnd + 1;

  ocGreaterEqual   = ocSlash + 1;
  ocEqual          = ocGreaterEqual + 1;
  ocLessEqual      = ocEqual + 1;
  ocNotEqual       = ocLessEqual + 1;
  ocGreater        = ocNotEqual + 1;
  ocLess           = ocGreater + 1;

  ocIfGreater      = ocLess + 1;
  ocIfLess         = ocIfGreater + 1;
  ocIfNotEqual     = ocIfLess + 1;
  ocIfEqual        = ocIfNotEqual + 1;
  ocIfLessEqual    = ocIfEqual + 1;
  ocIfGreaterEqual = ocIfLessEqual + 1;


  ocIF             = ocIfGreaterEqual   + 1;
  ocloadconst      = ocIF               + 1;
  ocmov            = ocloadconst        + 1;
  ocreturn         = ocmov              + 1;
  ocEnterProc      = ocreturn           + 1;
  ocvarraycreate   = ocEnterProc        + 1;
  ocsetvarray      = ocvarraycreate     + 1;
  ocScriptInvoke   = ocsetvarray        + 1;
  ocScriptInvoke2  = ocScriptInvoke     + 1;
  ocScriptDispatch = ocScriptInvoke2    + 1;
  ocScriptDispatch2= ocScriptDispatch   + 1;

  ocDispAssign     = ocScriptDispatch2  + 1;
  ocPushIDisp      = ocDispAssign       + 1;
  ocTry            = ocPushIDisp        + 1;

  ocGetItem        = ocTry              + 1;
  ocGetItem2       = ocGetItem          + 1;
  ocSetItem        = ocGetItem2         + 1;
  ocSetItem2       = ocSetItem          + 1;
  ocTrueCheck      = ocSetItem2         + 1;
  ocFalseCheck     = ocTrueCheck        + 1;
  ocMovRef         = ocFalseCheck       + 1;

  //single param codes
  ocNeg            = ocMovRef           + 1;
  ocGoto           = ocNeg              + 1;
  ocInternalGoto   = ocGoto             + 1;
  ocloadintconst   = ocInternalGoto     + 1;
  ocloadboolconst  = ocloadintconst     + 1;
  ochalt           = ocloadboolconst    + 1;
  ocincvar         = ochalt             + 1;
  ocdecvar         = ocincvar           + 1;
  occall           = ocdecvar           + 1;
  ocPopIDisp       = occall             + 1;
  ocEndFinally     = ocPopIDisp         + 1;
  ocNormalFinally  = ocEndFinally       + 1;
  ocEndTry         = ocNormalFinally    + 1;
  ocRaise          = ocEndTry           + 1;
  ocAddWith        = ocRaise            + 1;
  ocRemoveWith     = ocAddWith          + 1;
  ocPush0          = ocRemoveWith       + 1;
  ocPush           = ocPush0            + 1;
  ocPop            = ocPush             + 1;
  ocPushRef        = ocPop              + 1;
  ocPushConst      = ocPushRef          + 1;
  ocOut            = ocPushConst        + 1;
  ocEvaluate       = ocOut              + 1;
  ocUseUnit        = ocEvaluate         + 1;
  ocUnloadUnit     = ocUseUnit          + 1;
  ocCauseBreak     = ocUnloadUnit       + 1;
  ocWrite          = ocCauseBreak       + 1;
  ocWriteln        = ocWrite            + 1;
  ocRead           = ocWriteln          + 1;
  ocReadLn         = ocRead             + 1;

  ocCos            = ocReadln           + 1;
  ocSin            = ocCos              + 1;
  ocExp            = ocSin              + 1;
  ocLn             = ocExp              + 1;
  ocArcTan         = ocLn               + 1;
  ocSqr            = ocArcTan           + 1;
  ocSqrt           = ocSqr              + 1;

  SingleParamOpCodes = [ocNeg .. ocSqrt];

  ocCreateArray    = ocSqrt             + 1;
  ocIncVar2        = ocCreateArray      + 1;
  ocDecVar2        = ocIncVar2          + 1;

  ocCallExternal   = ocDecVar2          + 1;

  IntOpsBase       = 1000;

  ocAddInt          = ocAdd          + IntOpsBase;
  ocSubInt          = ocSub          + IntOpsBase;
  ocMulInt          = ocMul          + IntOpsBase;
  ocDivInt          = ocDiv          + IntOpsBase;
  ocModInt          = ocMod          + IntOpsBase;
  ocSlashInt        = ocSlash        + IntOpsBase;
  ocShlInt          = ocShl          + IntOpsBase;
  ocShrInt          = ocShr          + IntOpsBase;
  ocNotInt          = ocNot          + IntOpsBase;
  ocOrInt           = ocOr           + IntOpsBase;
  ocXorInt          = ocXor          + IntOpsBase;
  ocAndInt          = ocAnd          + IntOpsBase;
  ocGreaterEqualInt = ocGreaterEqual + IntOpsBase;
  ocEqualInt        = ocEqual        + IntOpsBase;
  ocLessEqualInt    = ocLessEqual    + IntOpsBase;
  ocNotEqualInt     = ocNotEqual     + IntOpsBase;
  ocGreaterInt      = ocGreater      + IntOpsBase;
  ocLessInt         = ocLess         + IntOpsBase;

  ocIfGreaterInt      = ocIfGreater      + IntOpsBase;
  ocIfLessInt         = ocIfLess         + IntOpsBase;
  ocIfNotEqualInt     = ocIfNotEqual     + IntOpsBase;
  ocIfEqualInt        = ocIfEqual        + IntOpsBase;
  ocIfLessEqualInt    = ocIfLessEqual    + IntOpsBase;
  ocIfGreaterEqualInt = ocIfGreaterEqual + IntOpsBase;

  ConstOpsBase         = 2000;

  ocAddConst             = ocAdd          + ConstOpsBase;
  ocSubConst             = ocSub          + ConstOpsBase;
  ocMulConst             = ocMul          + ConstOpsBase;
  ocDivConst             = ocDiv          + ConstOpsBase;
  ocModConst             = ocMod          + ConstOpsBase;
  ocSlashConst           = ocSlash        + ConstOpsBase;
  ocShlConst             = ocShl          + ConstOpsBase;
  ocShrConst             = ocShr          + ConstOpsBase;
  ocNotConst             = ocNot          + ConstOpsBase;
  ocOrConst              = ocOr           + ConstOpsBase;
  ocXorConst             = ocXor          + ConstOpsBase;
  ocAndConst             = ocAnd          + ConstOpsBase;
  ocGreaterEqualConst    = ocGreaterEqual + ConstOpsBase;
  ocEqualConst           = ocEqual        + ConstOpsBase;
  ocLessEqualConst       = ocLessEqual    + ConstOpsBase;
  ocNotEqualConst        = ocNotEqual     + ConstOpsBase;
  ocGreaterConst         = ocGreater      + ConstOpsBase;
  ocLessConst            = ocLess         + ConstOpsBase;

  ocIfGreaterConst       = ocIfGreater      + ConstOpsBase;
  ocIfLessConst          = ocIfLess         + ConstOpsBase;
  ocIfNotEqualConst      = ocIfNotEqual     + ConstOpsBase;
  ocIfEqualConst         = ocIfEqual        + ConstOpsBase;
  ocIfLessEqualConst     = ocIfLessEqual    + ConstOpsBase;
  ocIfGreaterEqualConst  = ocIfGreaterEqual + ConstOpsBase;

  MinConstOp = ocAddConst;
  MaxConstOp = ocIfGreaterEqualConst;

  CmpOps = [ocGreaterEqual .. ocLess];
  InvertIfs    : array[ocGreaterEqual .. ocLess] of integer = (ocIfLess, ocIfNotEqual, ocIfGreater, ocIfEqual, ocIfLessEqual, ocIfGreaterEqual);

 { ID Bases and ID ends }
  idCharBase = 1024;
  idBase = idCharBase + 256;

{ Character IDs}
  idNewLine = idCharBase + $0a;
  idpower = idCharBase + Integer('^');
  idPoint = idCharBase + Integer('.');
  idDelimiter = idCharBase + Integer(';');
  idgreater = idCharBase + Integer('>');
  idless = idCharBase + Integer('<');
  idComma = idCharBase + Integer(',');
  idPlus = idCharBase + Integer('+');
  idMinus = idCharBase + Integer('-');
  idSlash = idCharBase + Integer('/');
  idStar = idCharBase + Integer('*');
  idOpenBracket = idCharBase + Integer('(');
  idCloseBracket = idCharBase + Integer(')');
  idOpenComment = idCharBase + Integer('{');
  idCloseComment = idCharBase + Integer('}');
  idEqual = idCharBase + Integer('=');
  idnotequal = idCharBase + integer('#');
  id2Points = idCharBase + Integer(':');
  idStringChar = idCharBase + Integer('''');
  id2StringChar = idCharBase + Integer('"');
  idsqopenbracket = idCharBase + integer('[');
  idsqclosebracket = idCharBase + integer(']');
  idDollar = idCharBase + Integer('$');

 { Other IDs }
  idIdentifier = idBase + 0;

  idStringConst = idBase + 1;
  idNumberConst = idBase + 2;
  idFloatConst  = idBase + 3;
  idEndOfFile   = idBase + 4;
  idhexConst    = idbase + 6;


  {
  id_false := 99;
  id_true  := 100;
  }
{-----------------------------------------------------------}

type
  pvariantarray = ^tvariantarray;
  tvariantarray = Array[0..1] of Olevariant;

  tbinprogitem = Record
    a, b, opcode, linepos, charpos : integer;
  End;

  tprogarray = Array[0..1000] of tbinprogitem;
  pprogarray = ^tprogarray;

  pintarray = ^tintarray;
  tintarray = Array[0..1000] of integer;

  PPointerArray = ^TPointerArray;
  TPointerArray = array[0..1] of pointer;

  TIdentList = Class(TStringList)
  private
    Function AddItem(Const Aname: String; ID: Integer): Integer;
    Function IDByName(Const AName: String; Var AID: integer): boolean;
    function AddItem2(const AName : string; ID : integer) : TIdentListItem;
  public
    Constructor Create;
    Destructor Destroy; override;
    function Find(const s : string; var index : integer): boolean; override;
  End;

  TConstItem = Class(TCollectionItem)
  public
    Data : Variant;
  End;

  TConstList = Class(TCollection)
  Public
    Function newitem(const adata: Variant): integer;
  End;

  TVariantHolder = class
  private
    fValue : Variant;
  public
    property Value : Variant read fValue write fValue;

    destructor Destroy; override;
  end;

  TDeclConstList = class(TStringList)
  public
    constructor Create;
    destructor Destroy; override;

    function  ConstantExists(const ConstName : string) : boolean;
    procedure AddConst(const ConstName : string; const Value : variant);
    procedure GetConstValue(const ConstName : string; var Value: variant);
  end;

  TIDLabelItem = Class(TCollectionItem)
  public
    Place      : integer;
    Referenced : boolean;
    Exist      : boolean;
  end;

  TIDLabelList = Class(TCollection)
  Public
    BreakID, ContinueID: Integer;
    Function newitem: integer;
    function NewReferencedItem : integer;
    Procedure SetPlace(index, aplace: integer);
    Procedure SetReference(index: integer);
  End;

  TProgItem = Class(TCollectionItem)
  public
    OpCode  : integer;
    A       : integer;
    B       : integer;
    LinePos : integer;
    CharPos : integer;
  end;

{-----------------------------------------------------------}

Function Hex2Dec(Const S: String): Longint; forward;

{-----------------------------------------------------------}

destructor TVariantHolder.Destroy;
begin
  inherited;
end;

//BeginSkipConst
function Evaluate(const expr : string) : string;
begin
  result := 'function Calculate : integer;'#13#10+
       'begin'#13#10+
       'result := ' + expr + ';'#13#10+
       'end;';
end;
//EndSkipConst

{-----------------------------------------------------------}

type
  TGetExpressionProc = Function (var IsAllConst : boolean; var ConstValue : Variant): integer of object;

  THalCompiler = class
  private
    FRunner      : TScriptRunner;
    IdentPrefix  : string;
    spoint       : integer;
    maxspoint    : integer;
    fout         : TStream;
    Labels       : TIdentList;
    Variables    : TIdentList;
    Consts       : TConstList;
    StringConsts : TStringList;
    IDLabels     : TIDLabelList;
    Prog         : TCollection;
    FParser      : TDCIncludeParser;
    Token        : TToken;
    fcodecount   : integer;
    fDeclConsts  : TDeclConstList;
    fEnterProcs  : TStringList;
    fRefs        : TList;
    fGotos       : TList;
    fspoints     : TIntStack;
    fArrays      : TList;
    fDeclaredClasses : TStringList;

    StaticVarCount : integer;
    fInitializePos : integer;

    fPutReference : boolean;
    fGlobalVars : boolean;
    fIgnoreAssignment : boolean;

    function  VarIDByName(const AName : string; var Id : Integer) : boolean;
    procedure getprocbody(i : integer);
    procedure getvartype;
    function  getprocdef(askip : boolean) : Integer;
    procedure getmyvariables(b : boolean);
    function  getvar : integer;
    procedure gettypeidentifier;
    function  getinternalfun(const sname : string; ident : tidentlistitem) : integer;
    function  putcode(aid, aa, bb : integer) : TProgItem;
    procedure PutSingleCode(code : integer);
    function  ReadParam : integer;
    function  ReadIdent(const Acode : integer) : integer;
    function  iexpression : integer;
    function  iexpression2(var IsAllConst : boolean; var ConstValue : Variant; OnlyCalc : boolean) : integer;
    function  isimpleexpression(var IsAllConst : boolean; var ConstValue : Variant) : integer;
    function  GetOpenArray(NeedSq : boolean) : Integer;
    procedure getcoma;
    procedure getidentifier;
    function  iterm(var IsAllConst : boolean; var ConstValue : Variant) : integer;
    function  ifactor(var IsConst : boolean; var ConstValue : Variant) : integer;
    function  VarByName(const AName : string; var Ident : TIdentListItem) : boolean;
    function  AddVars(const Aname : string; ID : Integer) : Integer;
    procedure labeldispatch(const labelname : string);
    procedure getprogramname;
    procedure GetMainProc;
    procedure getclassdef(const cname : string);
    procedure getdeclarations;
    procedure ProcessProcIdent(BeginCode : Integer);
    procedure getoperatorcoma;
    procedure getwhileoperator;
    procedure getrepeatoperator;
    procedure getforoperator;
    procedure getifoperator;
    procedure GetCaseOperator;
    function  getoperator : boolean;
    procedure gettry;
    procedure getwith;
    procedure getDo;
    procedure getoperatorblock(ProcessEnd : boolean);
    procedure writeprogram;
    procedure getclosebracket;
    procedure getafterproc;
    procedure getopenbracket;
    procedure getdelimiter;

    procedure _readtoken;
    procedure GetExit;
    procedure GetRaise;
    procedure GetBreak;
    procedure GetContinue;
    procedure GetGoto;

    procedure getconsts;
    procedure getconst;
    procedure getuses;
    procedure getlabel;

    procedure getOut;

    procedure _DoProc(ACode : integer; var isconst, isallconst : boolean;
      var ConstValue : Variant; var Result : integer;
      iProc : TGetExpressionProc);
    procedure ExpectID(id : integer; const ErrStr : string);
    procedure ExpectNextID(id : integer; const ErrStr : string);
    procedure putloadconst(const Value : Variant);
    procedure PlaceLabelHere(LabelID : integer);
    function  IsTypeCast(const stToken : string) : boolean;
    function  getprocparams(WasDeclared : boolean; ProcIdent : TIdentListItem) : integer;
    procedure OpWithConst(ACode : integer; Op1 : integer; const ConstVal : Variant);
//    procedure OpWithIntConst(ACode, Op1, constval : integer);
    procedure getassignment(Ident : TIdentListItem);
    procedure putgoto(dest : integer);
    procedure putinternalgoto(dest : integer);
    procedure putif(condition, dest : integer);
    function  ReturnSPoint : integer;

    function  OptimizeIfCondition(OldPC, OldSP, IfLabel : integer) : boolean;

    procedure StartUseStack;
    procedure StopUseStack;

    procedure CheckLabels;
    function  AddStringConst(const Value : string) : integer;
    procedure putlistToCodes(list : TList);
    procedure CheckConst(IsConst : boolean);
    function  AddVariable(const AName : string; ID : integer) : TIdentListItem;
    procedure _mkcreatearray(item : TIdentListItem);
    function  ProcessInternalProc(const s : string) : boolean;
    procedure getoperatorProcessPointOrBracket(id : integer);
    function  ProcessExternalFunction(VarID : integer) : integer;
    procedure CheckNotEOF;
  public
    constructor Create(const ScriptStr : string; afout : TStream; Runner : TScriptRunner);
    constructor CreateFromStream(S : TStream; Runner : TScriptRunner);
    procedure compile;

    procedure compileprogram;
    procedure LinkProgram;
    procedure OptimizeProgram;

    destructor Destroy; override;
    function   ReadToken : TToken;
    procedure  error(const s : string);
    function   NextToken : TToken;
    function   NextTokenID : integer;
    function   NextToken2 : TToken;
    procedure  SaveToStream(S : TStream);
    procedure  ErrSymbolExpected(const Symbol : string);
    procedure  ErrSymbolExpectedButFound(const Expected, Found : string);
  end;

{-------------------------------------------------------------------------}

type
  TFinallyReason = (frNormal, frGoto, frReturn, frExcept);

{$IFDEF THREADSAFE}
  TBinProgThreadVarList = class(TSortedList)
  protected
    function Compare(Item1, Item2 : pointer) : integer; override;
    function CompareWithKey(Item, Key : pointer) : integer; override;
  end;
{$ENDIF}

  TBinProgThreadVars = class
    fThreadID         : DWORD;
    fdispatch         : TIntStack;
    CallStack         : TIntStack;
    fStacks           : TIntStack;
    CallMax           : integer; //???
    fExceptMessage    : string;
    FCodeCount        : integer;
    fErrorPos         : integer;
    fWithObjects      : TIntStack;
    fExceptPos        : TIntStack;
    curpos            : integer;
    fFinallyList      : TIntStack;
    fGotoPos          : integer;
    fStack            : TVariantStack;
    fBaseStackPointer : integer;
    fRefCount         : integer;
    fFuncStack        : TStringList;
    fFinallyReason    : TFinallyReason;

    constructor Create;
    destructor  Destroy; override;
  end;

  TBinProg = class
  private
    fMainThreadVars : TBinProgThreadVars;
    ConstSize       : integer;
    ProgSize        : integer;
    StaticVars      : PVariantArray;
    fConsts         : PVariantArray;
    prog            : pprogarray;
    sConsts         : TStringList;
    FRunner         : TDelphiRunner;
    fCompiledProg   : TMemoryStream;
    svarcount       : integer;
    LastLine        : integer;
    LastPos         : integer;

    {$IFDEF THREADSAFE}
    fTVarsLock      : TRTLCriticalSection;
    fTVarsList      : TBinProgThreadVarList;
    {$ENDIF}

    fBinCodes      : TMemoryStream;
    OpCodesAddr    : PPointerArray;
    fInitializePos : integer;
    FStop          : boolean;
    FLoaded        : boolean;
    fDestroyed     : boolean;

    FDebugging     : boolean;
    fInitialized   : boolean;
    fTraced        : boolean;

    {$IFDEF ACTIVESCRIPTING}
    FPrevLinePos   : integer;
    FCurLinePos   : integer;

    FDebugInfo     : TLineDebugInfo;
    FPrevCurPos    : integer;
    FOnChangeTraceLine : TChangeLineNotifyEvent;
    FOnFunctionEnter   : TCallStackNotifyEvent;
    FOnFunctionExit    : TCallStackNotifyEvent;
    FOnException       : TExceptionNotifyEvent;
    procedure BeforeDispatch;
    procedure DoChangeTraceLine;
    procedure DoFunctionEnter(const AItem: TIdentListItem);
    procedure DoFunctionExit(const AItem: TIdentListItem);
    function  DoException (AExeption: Exception): boolean;
    {$ENDIF}

    {$IFNDEF USECOMPILER}
    Function  _dispatch(opcode, a, b: integer): boolean;
    {$ENDIF}
    Procedure Error(Const s: String);
    procedure _ProcessPutProc(const  AName : string; const ParamCount: integer);
    procedure _ProcessGetProc(const Acode, StackPoint : integer ; ParamCount: integer);
    procedure _ProcessGetProc2(const Acode, StackPoint : integer; ProcNameIndex : integer);
    {$IFDEF USECOMPILER}
    procedure _DispAssign(a, b : integer);
    {$ENDIF}
    procedure _ProcessProc(const AName : string; const Acode, StackPoint ,ParamCount: integer;const InvKind:integer);
    function  GetSingleCode : integer;
    procedure GotoNewPlace(newpos : integer);
    {$IFDEF USECOMPILER}
    function  GotoNewPlace2(newpos : integer) : pointer;
    {$ENDIF}
    function  OutsideFinally(newpos : integer) : boolean;
    function  DoReturn : integer;
    {$IFDEF USECOMPILER}
    function  DoReturn2 : integer;
    {$ENDIF}
    function  FindExceptHandler : boolean;
    {$IFDEF USECOMPILER}
    function  _FinallyExcept : integer;
    {$ENDIF}
    procedure _EndTry;
    procedure _DoTry(a, b : integer);

    function  SaveState : pointer;
    procedure RestoreState(state : pointer);
    function  GetStackPointer : integer;
    function  _makestackptr(i : integer) : POleVariant;
    procedure LeaveProc;
    procedure EnterProc(a, b : integer);
    procedure _AddWith(PSA : POleVariant);
    procedure _RemoveWith;
    procedure _setvararray(a : integer; PSB : POleVariant);
    function  _Raise(a : integer; PSA : POleVariant) : pointer;
    procedure _PushIDisp(PSA : POleVariant);
    {$IFDEF USECOMPILER}
    procedure _Push(PSA : POleVariant);
    procedure _Pop(PSA : POleVariant);
    procedure _PushRef(PSA : POleVariant);
    {$ENDIF}
    procedure DoRun;
    function  ProgItemToStr(const Index: Integer): string;
    {$IFDEF USECOMPILER}
    procedure _DoOut(i : integer);
    {$ENDIF}
    procedure _GetItem2(icount : integer; PSB : POleVariant);
    procedure _SetItem2(icount : integer; PSB : POleVariant);
    procedure _CreateArray(PSA : POleVariant; arrCount : integer);
    procedure _Evaluate(PSA : POleVariant);
    procedure _UseUnit(PSA : POleVariant);
    procedure _UnloadUnit(PSA : POleVariant);
    procedure CauseBreak;
    procedure FillParamsFromCode(Params : POleVariantArray; ParamCount : integer);
    procedure ClearParams(Params : POleVariantArray; ParamCount : integer);
    procedure _CallExternal(PSA : POleVariant; ParamCount : integer);

    {$IFDEF THREADSAFE}
    procedure AddScriptThread;
    procedure RemoveScriptThread;
    function ThreadVars : TBinProgThreadVars;
    {$ELSE}
    property ThreadVars : TBinProgThreadVars read fMainThreadVars;
    {$ENDIF}

  public
    procedure TraceInto;
    procedure StepOver;
    
    procedure RunFrom(Acurpos: Integer; var Params : TDispParams;
                      VarResult : POleVariant; im : TIdentListItem);

    constructor Create(CodeStream : TStream; Runner : TDelphiRunner);
    Procedure Run;
    Destructor Destroy; override;

    property  StackPointer : integer read GetStackPointer;
    procedure GetProgInCodes(s : TStream);

    {$IFDEF USECOMPILER}
    procedure RealCompile;
    {$ENDIF}
{$IFDEF ACTIVESCRIPTING}
    property  OnChangeTraceLine: TChangeLineNotifyEvent read FOnChangeTraceLine write FOnChangeTraceLine;
    property  OnFunctionEnter: TCallStackNotifyEvent read FOnFunctionEnter write FOnFunctionEnter;
    property  OnFunctionExit: TCallStackNotifyEvent read FOnFunctionExit write FOnFunctionExit;
    property  OnException: TExceptionNotifyEvent read FOnException write FOnException;
    property  Debugging: boolean read FDebugging write FDebugging;
{$ENDIF}

  End;

  TFinalInfo = class
    CodeStart      : integer;
    CodeEnd        : integer;
    CallPos        : integer;
    StackPos       : integer;
    fBasePointer   : integer;
    fStacksSize    : integer;
    CallStackState : integer;
    IsFinal        : boolean;
  end;

{***********************************************************}

procedure TDeclConstList.AddConst(const ConstName : string; const Value : variant);
var
  vHolder : TVariantHolder;
begin
  if not ConstantExists(ConstName) then
    begin
      vHolder := TVariantHolder.Create;
      vHolder.Value := Value;
      AddObject(ConstName, vHolder);
    end;
end;

{-----------------------------------------------------------}

function TDeclConstList.ConstantExists(const ConstName : string) : boolean;
var
  i : integer;
begin
  result := Find(ConstName, i);
end;

{-----------------------------------------------------------}

procedure TDeclConstList.GetConstValue(const ConstName : string; var Value: variant);
var
  i : integer;
begin
  if Find(ConstName, i) then
    Value := TVariantHolder(Objects[i]).Value
  else
    VarClear(Value);
end;

{-----------------------------------------------------------}

constructor TDeclConstList.Create;
begin
  inherited;
  Sorted := true;
  AddConst('pi', pi);
end;

{-----------------------------------------------------------}

destructor TDeclConstList.Destroy;
var
  i : integer;
begin
  for i := Count - 1 downto 0 do
    Objects[i].Free;

  inherited;
end;

{***********************************************************}

type
  TCalcExpressionProc = function : Variant of object;

type
  TExprParser = class(TCustomDCParser)
  private
    fRunner : TDelphiRunner;
    fNextToken : integer;
    fNextStr   : string;
    fNextResWordID : integer;

    fNextToken2 : integer;
    fNextStr2   : string;
    fNextResWordID2 : integer;

    procedure Peek;
    function PeekResWord(id : integer) : boolean;
    function PeekChar(c : char) : boolean;
    function PeekChar2(c : char) : boolean;

    function CalcSimpleexpression : Variant;
    function CalcTerm : Variant;
    function CalcFactor : Variant;
    function CalcIdentifier : Variant;
    procedure DoCalc(OpCode : integer; var CurValue : Variant; Proc : TCalcExpressionProc);

    procedure ReadCloseBracket;
    function  GetInternalVarFunc(var Value : Variant) : boolean;
    function  GetVarFunc(const vName : string; var Value : Variant) : boolean;
    function  GetExternalVarFunc(var VarResult : Variant) : boolean;
    procedure CalcProperty(var Result : Variant);

    procedure GetParams(var pCount : integer; var pParams : POleVariantArray);
    function  ProcessItemsList(const pname : string; items : TStringList; var VarResult : Variant; cParams : integer; pParams : POleVariantArray) : boolean;
  public
    function Calculate : Variant;
    constructor Create(AOwner : TComponent); override;
  end;

{-----------------------------------------------------------}

constructor TExprParser.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  InitDelphiSyntax;
end;

{-----------------------------------------------------------}

procedure TExprParser.ReadCloseBracket;
begin
  NextToken;
  if not IsTokenChar(')') then
    Error(Format(ResStr(SSymbolExpected),[')']));
end;

{-----------------------------------------------------------}

procedure TExprParser.Peek;
begin
  PushState;
  NextToken;
  fNextToken := Token;
  fNextStr := TokenString;
  fNextResWordID := ResWordID;

  NextToken;
  fNextToken2 := Token;
  fNextStr2 := TokenString;
  fNextResWordID2 := ResWordID;

  PopState;
end;

{-----------------------------------------------------------}

function TExprParser.PeekChar(c : char) : boolean;
begin
  result := (fNextToken = tokWhiteChar) and (fNextStr[1] = c);
end;

{-----------------------------------------------------------}

function TExprParser.PeekChar2(c : char) : boolean;
begin
  result := (fNextToken2 = tokWhiteChar) and (fNextStr2[1] = c);
end;

{-----------------------------------------------------------}

function TExprParser.PeekResWord(id : integer) : boolean;
begin
  result := (fNextToken = tokResWord) and (fNextResWordID = id);
end;

{-----------------------------------------------------------}

procedure TExprParser.DoCalc(OpCode : integer; var CurValue : Variant; Proc : TCalcExpressionProc);
var
  val2 : OleVariant;
begin
  NextToken;

  val2 := Proc;

  case OpCode of
    ocadd   : CurValue := CurValue + val2;
    ocsub   : CurValue := CurValue - val2;
    ocmul   : CurValue := CurValue * val2;
    ocdiv   : CurValue := CurValue div val2;
    ocmod   : CurValue := CurValue mod val2;
    ocSlash : CurValue := CurValue / val2;
    ocshl   : CurValue := CurValue shl val2;
    ocshr   : CurValue := CurValue shr val2;
    ocor    : CurValue := CurValue or val2;
    ocxor   : CurValue := CurValue xor val2;
    ocAnd   : CurValue := CurValue and val2;
    ocGreaterEqual   : CurValue := CurValue >= val2;
    ocEqual          : CurValue := CurValue = val2;
    ocLessEqual      : CurValue := CurValue <= val2;
    ocNotEqual       : CurValue := CurValue <> val2;
    ocGreater        : CurValue := CurValue > val2;
    ocLess           : CurValue := CurValue < val2;
  end;
end;

{-----------------------------------------------------------}

function TExprParser.Calculate : Variant;

  procedure DoProc(ACode:Integer);
  begin
    DoCalc(ACode, Result, CalcSimpleexpression);
  end;

begin
  result := CalcSimpleExpression;

  Peek;

  if PeekChar('=') then
    DoProc(ocEqual)
  else if PeekChar('>') then
    begin
      if PeekChar2('=') then
        begin
          NextToken;
          DoProc(ocgreaterequal);
        end
      else
        DoProc(ocgreater);
    end
  else if PeekChar('<') then
    begin
      if PeekChar2('=') then
        begin
          NextToken;
          DoProc(oclessequal);
        end
      else if PeekChar2('>') then
        begin
          NextToken;
          DoProc(ocnotequal);
        end
      else
        DoProc(ocless);
    end;
end;

{-----------------------------------------------------------}

function TExprParser.CalcSimpleexpression : Variant;

  procedure DoProc(ACode : Integer);
  begin
    DoCalc(ACode, result, CalcTerm);
  end;

begin
  result := CalcTerm;

  while True do
    begin
      Peek;

      if PeekChar('+') then
        DoProc(ocAdd)
      else if PeekChar('-') then
        DoProc(ocSub)
      else if PeekResWord(id_Or) then
        DoProc(ocOr)
      else if PeekResWord(id_Xor) then
        DoProc(ocXor)
      else
        break;
    end;
end;

{-----------------------------------------------------------}

function TExprParser.CalcTerm : Variant;

  procedure DoProc(ACode : Integer);
  begin
    DoCalc(ACode, result, CalcFactor);
  end;

begin
  result := CalcFactor;

  while True do
    begin
      Peek;

      if PeekResWord(id_Shl) then
        DoProc(ocshl)
      else if PeekResWord(id_Shr) then
        DoProc(ocshr)
      else if PeekResWord(id_And) then
        DoProc(ocAnd)
      else if PeekResWord(id_Div) then
        DoProc(ocDiv)
      else if PeekResWord(id_Mod) then
        DoProc(ocMod)
      else if PeekChar('*') then
        DoProc(ocmul)
      else if PeekChar('/') then
        DoProc(ocSlash)
      else
        break;
    end;
end;

{-----------------------------------------------------------}

function TExprParser.CalcFactor : Variant;
var
  ConvertResult : integer;
  i             : integer;
begin
  NextToken;
  case Token of
    tokString : result := ExtractQuotedStr(TokenString, '''');

    tokInteger : result := StrToInt(TokenString);

    tokFloat : result := GetFloatFromString(TokenString);

    tokWhiteChar :
      case TokenPtr^ of
        '(':
             begin
               result := Calculate;
               ReadCloseBracket;
             end;

        '+' : result := CalcFactor;

        '-' : result := - CalcFactor;

        '#' :
             begin
               NextToken;
               if Token <> tokInteger then
                 Error(SErrbad_charconst);

                Val(TokenString, i, ConvertResult);
                if ConvertResult <> 0 then
                  Error(SErrInvalidConstant);
                result := i;
             end
        else
          dcdreamlib.Error(SErrSymbol + TokenPtr^);
      end;

    tokResWord :
      case ResWordID of
        id_nil : result := 0;

        id_not : result := not CalcFactor;
        else
          dcdreamlib.Error(SErrSymbol + TokenString);
      end;

    tokSymbol : result := CalcIdentifier;
  end;

  repeat
    Peek;
(*
            ReadToken;
            StartUseStack;
            oldresult := result;
            indexlist := TList.Create;
            try
              repeat
                indexlist.Add(pointer(iExpression));
                if NextTokenID = idComma then
                  ReadToken
                else
                  break;
              until false;
              result := integer(indexlist[0]);
              ReadToken;
              if indexlist.count = 0 then
                putcode(ocGetItem, result, oldresult)
              else
                begin
                  putcode(ocGetItem2, indexlist.count, oldresult);
                  putlisttocodes(indexlist);
                end;
            finally
              indexlist.Free;
            end;
            StopUseStack;
    if PeekChar('[') then
      begin
        indexlist := TList.Create;
        repeat
          indexlist.Add(CalcSimpleExpression);
          if NextTokenID = idComma then
            ReadToken
          else
            break;
        until false;
      end
    else
*)
    if PeekChar('.') then
      begin
        NextToken;
        NextToken;
        CalcProperty(result);
      end
    else
      break;
  until false;
end;

{-----------------------------------------------------------}

function TExprParser.CalcIdentifier : Variant;
var
  ts : string;
begin
  ts := TokenString;
  if CompareText(ts, 'True') = 0 then //don't resource
    result := True
  else if CompareText(ts, 'False') = 0 then //don't resource
    result := False
  else
    with THalCompiler(fRunner.FHalCompiler).fDeclConsts do
      if ConstantExists(ts) then
        GetConstValue(ts, result)
  else if IsConstRegistered(ts) then
    GetRegisteredConst(ts, result)
  else if isClassRegistered(ts) and (PeekTokenStr = '(') then
    begin
      NextToken;
      result := Calculate;
      ReadCloseBracket;
    end
  else if GetInternalVarFunc(result) then
    exit
  else if not GetExternalVarFunc(result) then
    dcdreamlib.Error(Format(SErrUndeclaredIdentifier, [ts]));
end;

{-----------------------------------------------------------}

function TExprParser.GetInternalVarFunc(var Value : Variant) : boolean;
var
  vname   : string;
begin
  vname := TokenString;

  with TBinProg(fRunner.FBinProg).ThreadVars.fFuncStack  do
    if Count > 0 then
      if GetVarFunc(Strings[Count - 1] + '.' + vName, Value) then
        begin
          result := true;
          exit;
        end;

  result := GetVarFunc(vName, Value)
end;

{-----------------------------------------------------------}

function TExprParser.GetVarFunc(const vName : string; var Value : Variant) : boolean;
var
  vid : TIdentListItem;
  vptr: POleVariant;
  dParams : TDispParams;
begin
  result := THalCompiler(fRunner.FHalCompiler).VarByName(vName, vid);
  if result then
    with vid do
      case IdentType of
        tivariable :
           begin
             vptr :=TBinProg(fRunner.fBinProg)._makestackptr(Address);
             Value := vptr^;
           end;

        tiprocedure : Error(Format(SErrEvaluate, [vName]));

        tifunction :
          begin
            with dParams do
              begin
                GetParams(integer(cArgs), POleVariantArray(rgvarg));
                if cArgs <> vid.ParamNames.Count then
                  dcdreamlib.Error(SErrParamsCount);
              end;

            try
              with TBinProg(fRunner.FBinProg) do
                RunFrom(Address, dParams, POleVariant(@Value), vid);
            finally
              with dParams do
                if rgvarg  <> nil then
                  FreeMem(rgvarg);
            end;
          end;
      end;
end;

{-----------------------------------------------------------}

function TExprParser.ProcessItemsList(const pname : string; items : TStringList; var VarResult : Variant; cParams : integer; pParams : POleVariantArray) : boolean;
var
  i : integer;
  errmsg  : string;
begin
  with Items do
    for i := Count - 1 downto 0 do
      begin
         if CompareText(pname, Strings[i]) = 0 then
           begin
             VarResult := IDispatch(Pointer(Objects[i]));
             result := true;
             exit;
           end;

         result := GetObjectProperty(IDispatch(Pointer(Objects[i])), pName, cParams, pParams, VarResult, errmsg);

         if result then
           exit;

         if errmsg <> '' then
           dcdreamlib.Error(ErrMsg);
      end;
  result := false;
end;

{-----------------------------------------------------------}

function TExprParser.GetExternalVarFunc(var VarResult : Variant) : boolean;
var
  cParams : integer;
  pParams : POleVariantArray;
  pname   : string;
begin
  pName := TokenString;
  GetParams(cParams, pParams);
  try
    result := ProcessItemsList(pname, fRunner.GlobalItems, VarResult, cParams, pParams) or
              ProcessItemsList(pname, fRunner.NamedItems, VarResult, cParams, pParams);
  finally
    if pParams <> nil then
      FreeMem(pParams);
  end;
end;

{-----------------------------------------------------------}

procedure TExprParser.CalcProperty(var Result : Variant);
var
  cParams : integer;
  pParams : POleVariantArray;
  pname   : string;
  ErrMsg  : string;
begin
  with TVarData(Result) do
    if vType <> varDispatch then
      Error(SErrObjectTypeExpected)
    else
      begin
        pname := TokenString;
        GetParams(cParams, pParams);
        try
          if not GetObjectProperty(IDispatch(vDispatch), pName, cParams, pParams, Result, errmsg) then
            if ErrMsg <> '' then
              dcdreamlib.Error(ErrMsg)
            else
              dcdreamlib.Error(TokenString + ' : ' + ResStr(SUnknownProperty)); //don't resource
        finally
          if pParams <> nil then
            FreeMem(pParams);
        end;
      end;
end;

{-----------------------------------------------------------}

procedure ReverseParams(pParams : POleVariantArray; pCount : integer);
var
  i : integer;
  j : integer;
  v : array[0..sizeof(OleVariant) - 1] of byte;
begin
  if pCount < 2 then
    exit;

  i := integer(pParams);
  j := i + (pCount - 1) * sizeof(OleVariant);

  while i < j do
    begin
      move(pointer(i)^, v, sizeof(OleVariant));
      move(pointer(j)^, pointer(i)^, sizeof(OleVariant));
      move(v, pointer(j)^, sizeof(OleVariant));
      inc(i, sizeof(OleVariant));
      dec(j, sizeof(OleVariant));
    end;
end;

{-----------------------------------------------------------}

procedure TExprParser.GetParams(var pCount : integer; var pParams : POleVariantArray);
begin
  pCount := 0;
  Peek;
  if PeekChar('(') then
    begin
      GetMem(pParams, sizeof(OleVariant) * MaxParams);
      repeat
        NextToken;
        pParams^[pCount] := Calculate;
        inc(pCount);
        Peek;
      until not PeekChar(',');
      ReadCloseBracket;
      ReverseParams(pParams, pCount);
    end
  else
    pParams := nil;
end;

{***********************************************************}

function  TDelphiRunner.CurrentExecutionLine : integer;
var
  cpos : integer;
begin
  result := -1;
  if FBinProg <> nil then
    with TBinProg(FBinProg) do
      begin
        cpos := ThreadVars.CurPos;
        if cpos < progsize then
          result := prog[cpos].linepos;
      end;
end;

{-----------------------------------------------------------}

procedure  TDelphiRunner.TraceInto;
begin
  CheckCompiled;
  TBinProg(FBinProg).Debugging := true;
  TBinProg(FBinProg).TraceInto;
end;

{-----------------------------------------------------------}

procedure  TDelphiRunner.StepOver;
begin
  CheckCompiled;
  TBinProg(FBinProg).StepOver;
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.DoInterrupt;
begin
  if fBinProg <> nil then
    TBinProg(fBinProg).fStop := true;

//  Stop;
//  Scripter.RaiseScriptError('');
end;

{-----------------------------------------------------------}

function TDelphiRunner.FindConstant(const ConstName : string; var VarValue : Variant) : boolean;
begin
  result := false;
  with THalCompiler(FHalCompiler).fDeclConsts do
    if ConstantExists(ConstName) then
      begin
        GetConstValue(ConstName, VarValue);
        result := true;
      end;
end;

{-----------------------------------------------------------}

function TDelphiRunner.GetExecutionLine : integer;
var
  cpos : integer;
begin
  result := -1;
  if fBinProg <> nil then
    with TBinProg(fBinProg) do
      begin
        cpos := ThreadVars.CurPos;
        if (cpos >= 0) and (cpos < progsize) then
          result := prog^[cpos].LinePos
      end;
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.GetWatchesPreffixes(var APref_Hex, APref_Str: string); 
begin
  APref_Hex := '$';
  APref_Str := '''';
end;

{-----------------------------------------------------------}

function  TDelphiRunner.EvaluateExpression(const Expr : string) : OleVariant;
begin
  result := Unassigned;
  if Expr = '' then
    exit;

  with TExprParser.Create(nil) do
    try
      fRunner := self;
      LinePtr:=PChar(Expr);
      result := Calculate;
    finally
      Free;
    end;
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.GetProgramCodes(s : TStream);
begin
  TBinProg(FBinProg).GetProgInCodes(s);
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.SaveToStream(S : TStream);
var
  Compiler : THalCompiler;
  OutStream : TMemoryStream;
  UseNewCompiler : boolean;

  procedure DoSave(c : THalCompiler; prog : TMemoryStream);
  begin
    c.SaveToStream(S);
    with prog do
      begin
        WriteInt(S, Size);
        S.Write(Memory^, Size);
      end;
  end;

begin
  if (fHalCompiler <> nil) and (fBinProg <> nil) then
    begin
      UseNewCompiler := fParsedScript <> '';
      if UseNewCompiler then
        begin
          OutStream := TMemoryStream.Create;
          Compiler := THalCompiler.Create(fParsedScript, OutStream, Self);
          try
            if UseNewCompiler then
              Compiler.Compile;

            DoSave(Compiler, OutStream);
          finally
            Compiler.Free;
            OutStream.Free;
          end
        end
      else
        DoSave(THalCompiler(fHalCompiler), TBinProg(fBinProg).fCompiledProg);
    end
  else
    Error(SErrScriptNotParsed);
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.LoadFromStream(S : TStream);
var
  InStream : TMemoryStream;
  InSize   : integer;
begin
  FreeProg;
  FHalCompiler := THalCompiler.CreateFromStream(S, Self);
  fParsedScript := '';
  InStream := TMemoryStream.Create;
  try
    S.Read(InSize, sizeof(integer));
    InStream.SetSize(InSize);
    S.Read(Instream.Memory^, InSize);
    FBinProg := TBinProg.Create(InStream, Self);
  finally
    InStream.Free;
  end;
end;

{-----------------------------------------------------------}

function TDelphiRunner.GetModuleAlias : string;
begin
  result := 'self'; // don't resource
end;

{-----------------------------------------------------------}

function TDelphiRunner.GetTypeInfoCount(out  Count: Integer): HRESULT;
begin
  Count := 0;
  Result := S_OK;
end;

{-----------------------------------------------------------}

function  TDelphiRunner.GetScriptDispatch : IDispatch;
begin
  QueryInterface(IDispatch, Result);
end;

{-----------------------------------------------------------}

function TDelphiRunner.GetTypeInfo(Index:Integer;LocaleID: Integer; out  TypeInfo): HRESULT;
begin
  pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

{-----------------------------------------------------------}

function TDelphiRunner.MethodCall(AItem : TIdentListItem; var Params : TDispParams; VarResult : POleVariant) : HRESULT;
begin
  with TBinProg(FBinProg) do
    if AItem.Name = '' then
      Run
    else
      RunFrom(AItem.Address, Params, VarResult, AItem);

  result := S_OK;
end;

{-----------------------------------------------------------}

procedure varput(var A : OleVariant; const Value : OleVariant; iCount : integer; list : pointer);
asm
  push edi
  push esi
  push ebx
  mov  edi, iCount
  mov  esi, list
  lea  esi, esi + edi * 4 - 4
  mov  ebx, esp
@@l:
  push dword ptr [esi]
  sub  esi, 4
  dec  edi
  jne  @@l

  push iCount
  push Value
  push A
  call System.@VarArrayPut
  mov  esp, ebx
  pop  ebx
  pop  esi
  pop  edi
end;

{-----------------------------------------------------------}

function TDelphiRunner.PutProperty(Item : TIdentListItem; Params : TDispParams) : HResult;
var
  pv : POleVariant;
  ilist : TList;
  i : integer;
begin
  pv := TBinProg(fBinProg)._makestackptr(Item.Address);
  if Params.cArgs > 1 then
    begin
      ilist := TList.Create;
      try
        for i := Params.cArgs - 1 downto 1 do
          ilist.Add(pointer(integer(OleVariant(Params.rgvarg[i]))));

        varput(pv^, OleVariant(Params.rgvArg[0]), ilist.Count, ilist.List);
      finally
        ilist.Free;
      end;
    end
  else
    pv^ := OleVariant(Params.rgvArg[0]);

  result := S_OK;
end;

{-----------------------------------------------------------}

function TDelphiRunner.GetProperty(Item : TIdentListItem; VarResult : POleVariant) : HResult;
var
  pv : POleVariant;
begin
  pv := TBinProg(fBinProg)._makestackptr(Item.Address);
  if VarResult <> nil then
    VarResult^ := pv^;
  result := S_OK;
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.GetVarList(S : TStrings);
var
  i : integer;
begin
  S.Clear;
  with THalCompiler(FHalCompiler).Variables do
    for i := 0 to Count - 1 do
      if (TIdentListItem(Objects[i]).IdentType = tivariable) and (pos(coprocResult, Strings[i]) = 0) then
        S.Add(Strings[i]);
end;

{-----------------------------------------------------------}

(*
function TDelphiRunner.ProcessDMethodCall(const AName : string; Params : Pointer; const  ParamCount : integer; var VarResult : Variant) : boolean;
var
  ident   : TIdentListItem;
  dparams : TDispParams;
  id      : integer;
  ipcount : integer;
  defcount : integer;
begin
  result := false;
  if THalCompiler(FHalCompiler).Variables.Find(AName, id) then
    begin
      ident := TIdentListItem(THalCompiler(FHalCompiler).Variables.Objects[id]);
      if (ident.IdentType in [tiprocedure, tifunction]) then
        begin
          ipcount := ident.ParamNames.Count;
          defcount := ident.DefaultParams.Count;

          if ((ParamCount >= ipCount - defcount) and (ParamCount <= ipCount)) then
            begin
              dparams.rgvarg := PVariantArgList(Params);
              dparams.cArgs := ParamCount;
              MethodCall(ident, dParams, @VarResult);
              result := true;
            end;
        end;
    end;
end;
*)
{-----------------------------------------------------------}

function TDelphiRunner.GetIDsOfNames(const IID: TGUID; Names: Pointer;
    cNames, LocaleID: Integer; DispIDs: Pointer): HRESULT;
var
  id		: integer;
  pname 	: string;
begin
  for id := 1 to cNames - 1 do
    PDispIDList(DispIDs)^[id] := -1;

  pname := WideCharToString(PWideChar(pointer(Names)^));

  if (pname <> '') and (pname = fLastIDName) then
    begin
      PDispIDList(DispIDs)^[0] := fLastID;
      result := S_OK;
      exit;
    end;

  with THalCompiler(FHalCompiler).Variables do
    begin
      id := IndexOf(pname) + 1;

      if (id = 0) and (DefaultObject is TComponent) then
        id := IndexOf('T' + TComponent(DefaultObject).Name + '.' + pName) + 1;

      if (id = 0) and (Scripter.ModuleClassName <> '') then
        id := IndexOf(Scripter.ModuleClassName + '.' + pName) + 1;
    end;

  if id = 0 then
    begin
      id := NamedItems.IndexOf(pname);
      id := - (id + 1);  // -1 -> 0
    end;

  if id = 0 then
    begin
      id := THalCompiler(fHalCompiler).fDeclConsts.IndexOf(pname);
      if id < 0 then
        id := 0
      else
        inc(id, FirstConstID);
    end;

  if id = 0 then
    begin
      result := DISP_E_UNKNOWNNAME;
      dec(id);
    end
  else
    begin
      result := S_OK;
      fLastIDName := pname;
      fLastID := id;
    end;

  PDispIDList(DispIDs)^[0] := TDispID(id);
end;

{-----------------------------------------------------------}

function GetDefaultPropByDispatch(const disp : IDispatch; const index : Variant) : OleVariant;
var
  dparams : TDispParams;
begin
  FillChar(dparams, sizeof(dparams), 0);
  with dparams do
    begin
      rgvarg := @index;
      cArgs := 1;
    end;

  disp.Invoke(0, GUID_NULL, 0, DISPATCH_PROPERTYGET, dparams, @Result, nil, nil);
end;

{-----------------------------------------------------------}

function getitem(const s : string; i : integer) : string;
{$IFDEF DCMBCS}
var
  p : pchar;
  p2 : pchar;
{$ENDIF}  
begin
  result := '';
{$IFDEF DCMBCS}
  if LeadBytes = [] then
    begin
      if i <= length(s) then
        result := s[i];
    end
  else
    begin
      if (i > 0) and (s <> '') then
        begin
          p := PChar(s);
          while i > 1 do
            begin
              dec(i);
              p := CharNext(p);
            end;

          if p^ <> #0 then
            begin
              p2 := CharNext(p);
              SetString(result, p, p2 - p);
            end;
        end;
    end;
{$ELSE}
  if i <= length(s) then
    result := s[i];
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.CheckCompiled;
begin
  if FBinProg  = nil then
    raise Exception.Create(SErrcompile_before);
end;

{-----------------------------------------------------------}

function TDelphiRunner.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
   Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
var
  AName : string;
  ident : TIdentListItem;
  ipcount : integer;
  dpcount : integer;
  defcount : integer;
  vt       : integer;
  index : integer;
  v     : Variant;
begin
  result := DISP_E_MEMBERNOTFOUND;
  AName :='';
  try
    CheckCompiled;

    if DispID > 0 then
      if DispID < FirstConstID then
        begin
          ident := TIdentListItem(THalCompiler(FHalCompiler).Variables.Objects[DispID - 1]);
          AName := ident.Name;
          if (Flags and DISPATCH_METHOD <> 0) and (ident.IdentType in [tiprocedure, tifunction]) then
            begin
              ipcount := ident.ParamNames.Count;
              defcount := ident.DefaultParams.Count;
              dpcount := TDispParams(params).cArgs;

              result := DISP_E_BADPARAMCOUNT;
              if ((dpcount >= ipCount - defcount) and (dpcount <= ipCount)) then
                result := MethodCall(ident, TDispParams(Params), VarResult)
              else
                PExcepInfo(ExcepInfo)^.bstrDescription := SErrParamsCount;
            end
          else
            case Flags and not DISPATCH_METHOD of
              DISPATCH_PROPERTYGET :
                  if ident.IdentType in [tiprocedure, tifunction] then
                    result := MethodCall(ident, TDispParams(Params), VarResult)
                  else
                    begin
                      result := GetProperty(ident, VarResult);
                      dpcount := TDispParams(params).cArgs;
                      if (dpcount > 0) then
                        begin
                          vt := TVarData(VarResult^).vType;
                          index := POleVariantArray(TDispParams(Params).rgvArg)^[0];
                          if vt and varArray <> 0 then
                            begin
                              v := PVariant(VarResult)^[index];
                              PVariant(VarResult)^ := v;
                            end
                          else if vt = varDispatch then
                            PVariant(VarResult)^ := GetDefaultPropByDispatch(IDispatch(TVarData(VarResult^).vDispatch), index)
                          else
                            PVariant(VarResult)^ := getitem(string(PVariant(VarResult)^), index);
                        end;
                    end;

              DISPATCH_PROPERTYPUT,
              DISPATCH_PROPERTYPUTREF,
              DISPATCH_PROPERTYPUT + DISPATCH_PROPERTYPUTREF :
                result := PutProperty(ident, TDispParams(Params));
            end;
        end
      else  // constant
        begin
          result := S_OK;
          if (VarResult <> nil) and (Flags and DISPATCH_PROPERTYGET <> 0) then
            POleVariant(VarResult)^ := TVariantHolder(THalCompiler(fHalCompiler).fDeclConsts.Objects[DispID - FirstConstID]).Value;
        end
    else if DWORD(-DispID) < DWORD($FFFF) then  // NamedItem
      begin
        result := S_OK;
        if (VarResult <> nil) and (Flags and (DISPATCH_PROPERTYGET or DISPATCH_METHOD) <> 0) then
          POleVariant(VarResult)^ := IDispatch(pointer(NamedItems.Objects[-DispID - 1]));
      end;
  except
    result := DISP_E_EXCEPTION;
    if Scripter.UseExceptions then
      raise
    else
      begin
        with PExcepInfo(ExcepInfo)^ do
          begin
            bstrDescription := DCStringToOleSt((ExceptObject as Exception).Message);
            bstrSource      := DCStringToOleSt(AName);
          end;
        InvokeError('', result, PExcepInfo(ExcepInfo)^);
      end;
  end;
end;

{-----------------------------------------------------------}

procedure TDelphiRunner.FreeRunner;
begin
  if fRefCount = 0 then
    Free
  else
    fFreeOnRelease := true;
end;

{-----------------------------------------------------------}

function TDelphiRunner._AddRef: Integer;
begin
  result := InterlockedIncrement(FRefCount);
end;

{-----------------------------------------------------------}

function TDelphiRunner._Release: Integer;
begin
  result := InterlockedDecrement(FRefCount);
  if (result = 0) and fFreeOnRelease then
    Free;
end;

{---------------------------------------------------}

function TDelphiRunner.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    result := 0;
end;

{---------------------------------------------------}

constructor TDelphiRunner.Create(AScripter : TDCScripter; const AScriptName : string);
begin
  inherited;
{$IFDEF ACTIVESCRIPTING}
  FDSUnit := TDSUnit.Create (self);
{$ENDIF}
end;

{---------------------------------------------------}

destructor TDelphiRunner.Destroy;
begin
{$IFDEF ACTIVESCRIPTING}
  if FDSUnit.DSProject <> nil then
    begin
      FDSProject.OnFirstUnitUnLoaded;
      if not ScripterDestroyed then
        with FDSUnit.GetDebugDCScripter do
          begin
            DebugProject := 0;
            OnLastUnitLoaded := nil;
          end;
    end;

  FDSUnit.Free;
{$ENDIF}
  FreeProg;
  inherited;
end;

{---------------------------------------------------}

function IsKnownInvokeError(Status : TDCErrorStatus) : boolean;
begin
  case Status of
    DISP_E_BADPARAMCOUNT, DISP_E_OVERFLOW, DISP_E_BADVARTYPE,
    DISP_E_MEMBERNOTFOUND, DISP_E_NONAMEDARGS, DISP_E_PARAMNOTFOUND,
    DISP_E_TYPEMISMATCH, DISP_E_UNKNOWNINTERFACE, DISP_E_PARAMNOTOPTIONAL,
    E_OUTOFMEMORY, S_UnknownIdent : result := true;
  else
    result := false;
  end;  
end;

{---------------------------------------------------}

function  InvokeStatusToString(Const Status : {$IFDEF D5}integer{$ELSE}DWORD{$ENDIF}) :string;
begin
  case Status of
    DISP_E_BADPARAMCOUNT,DISP_E_OVERFLOW  : result := SErrInvalidParams;
    DISP_E_BADVARTYPE       : result := SErrInvalidType;
    DISP_E_MEMBERNOTFOUND   : result := SErrInvalidProperty;
    DISP_E_NONAMEDARGS      : result := SErrInvalidCall;
    DISP_E_PARAMNOTFOUND    : result := SErrParamNotFound;
    DISP_E_TYPEMISMATCH     : result := SErrTypeMismatch;
    DISP_E_UNKNOWNINTERFACE : result := SErrInvalidInterface;
    DISP_E_PARAMNOTOPTIONAL : result := SErrParamOmitted;
    E_OUTOFMEMORY           : result := SErrOutOfMem;
    S_UnknownIdent          : result := Format(SErrunkn_id,[''])
    else
      result := SErrUnknown;
  end;
end;

{---------------------------------------------------}

procedure TDelphiRunner.InvokeError(const AName : string; const Status : {$IFDEF D5}integer{$ELSE}DWORD{$ENDIF}; var ExcepInfo : TExcepInfo);
var
  Handled : boolean;
  errmsg : string;
begin
  if not TBinProg(fBinProg).ThreadVars.fExceptPos.IsEmpty or Scripter.UseExceptions then
    with ExcepInfo do
      begin
        errmsg := bstrSource;
        if errmsg <> '' then
          errmsg := errmsg + #13#10;
        errmsg := errmsg + bstrDescription;
        raise Exception.Create(errmsg);
      end;

  Handled:= false;
  if Assigned(OnError) then
    with TBinProg(FBinProg), prog^[ThreadVars.fErrorPos] do
    begin
      if Status <> DISP_E_EXCEPTION then
        with ExcepInfo do
        begin
           BstrDescription := DCStringToOleSt(AName);
           bstrSource      := DCStringToOleSt(InvokeStatusToString(Status));
        end;
      OnError(Self, ExcepInfo, charpos, linepos, Handled);
      FStop := not Handled;
   end;
end;

{---------------------------------------------------}

function TDelphiRunner.ProcessProcedureCall(const AName:string; Params : Pointer; const  ParamCount : integer;
                        const InvKind : integer; var ExcepInfo : TExcepInfo; var Status : TDCErrorStatus; Var Successful : boolean) : variant;
var
  i : integer;
  wName : PWideChar;
begin
  wName := DCStringToOleSt(AName);
  Successful := false;
  try
    with TBinProg(fBinProg).ThreadVars.fWithObjects do
      for i := Count - 1 downto 0 do
        begin
          Result := ProcessMethodCall(IDispatch(Pointer(List[i])), wName, Params, ParamCount, InvKind,
                                ExcepInfo, Status, Successful);

          if Successful or (Status <> S_Ok) then
            exit;
        end;

    with GlobalItems do
      for i := {0 to Count - 1} Count - 1 downto 0 do
        begin
          Result := ProcessMethodCall(IDispatch(Pointer(Objects[i])), wName, Params, ParamCount, InvKind,
                                ExcepInfo, Status, Successful);

          if Successful or (Status <> S_Ok) then
            exit;
        end;

    if (InvKind = (DISPATCH_METHOD or DISPATCH_PROPERTYGET)) and
       (CompareText(wName, 'ExceptionMessage') = 0) and (Assigned(FBinProg))then
       begin
         Result := TBinProg(FBinProg).ThreadVars.fExceptMessage;
         Successful := true;
         exit;
       end;

  finally
    {$IFDEF WIN32}
      SysFreeString(wName);
    {$ENDIF}
  end;

  VarClear(result);
end;

{-------------------------------------------}

procedure TDelphiRunner.FreeProg;
begin
  FreeObject(FBinProg,FBinProg);
  FreeObject(FHalCompiler,FHalCompiler);
end;

{---------------------------------------------------}

procedure TDelphiRunner.SetOnExecuteLine(val : TExecuteLineEvent);
begin
  fOnExecuteLine := val;
  if fBinProg <> nil then
    TBinProg(fBinProg).fDebugging := Assigned(val);
end;

{---------------------------------------------------}

function TDelphiRunner.ParseScript(const Script : string) : boolean;
Var
  FBinStream:TMemoryStream;
begin
  FreeProg;
  FBinStream:=TMemoryStream.Create;
  try
    FHalCompiler:=THalCompiler.Create(Script,FBinStream,Self);
    THalCompiler(FHalCompiler).Compile;
    FBinProg:=TBinProg.Create(FBinStream,Self);
    Result:=True;
    fParsedScript := Script;
{$IFDEF ACTIVESCRIPTING}
    with FDSUnit do
    begin
      Init(fParsedScript);
      FDSProject := DSProject;
      OnDebuggerConnect := _OnDebuggerConnect;
      OnDebuggerDisconnect := _OnDebuggerDisconnect;
    end;
{$ENDIF}
  finally
    FBinStream.Free;
  end;
end;

{-------------------------------}

{$IFDEF ACTIVESCRIPTING}
procedure TDelphiRunner.ChangeTraceLine (ADebugInfo: TLineDebugInfo);
var
  NextProgItem, CurProgItem: TBinprogitem;

  function CheckUnitAndLine(AUnit: TDSUnit; ALine: integer): boolean;
  begin
    Result := AUnit = FDSUnit;
    if Result then
      Result :=  ALine <> NextProgItem.linepos;
  end;

  function EndOfStepOver: boolean;
  begin
    Result := false;
    with FDSProject do
    begin
      if CallStackState = CallsCount then
        Result := CheckUnitAndLine(CurrentUnit, CurrentLine) and CheckUnitAndLine(CurrentUnit, LastLineFromStack) //for recurse
      else
        if CallStackState >= CallsCount + 1 then //for stepout  added >
          if CurProgItem.opcode = ocReturn then
            if LastLineFromStack <> CurrentLine then
            begin
              StopAtNextLine := LastLineFromStack = NextProgItem.linepos; //for recurse
              Result := not StopAtNextLine;
            end;
    end;
  end;

  function EndOfStepInto: boolean;
  begin
    with FDSProject do
    begin
      Result := CurProgItem.opcode <> ocReturn;
      if Result then
      begin
        if ResumeAction = brtStepOver then // for recurse
          Result := CallStackState = CallsCount + 1
      end
      else
        Result := CheckUnitAndLine(LastUnitFromStack, LastLineFromStack); //StepOut for both: function and procedure
    end;
  end;

begin
  with FDSProject do
  begin
    if (ResumeAction = brtEvaluate) then
      exit;
    NextProgItem := TBinprogitem(ADebugInfo.PNextProgItem^);
    CurProgItem := TBinprogitem(ADebugInfo.PCurProgItem^);
    SetPrevParams(FDSUnit, NextProgItem.linepos);
    if StopAtNextLine then
    begin
      if EndOfStepInto then
        SuspendThread(FDSUnit, NextProgItem.linepos, false);
    end
    else
    begin
      if ResumeAction = brtStepOver then
        if EndOfStepOver then
        begin
          SuspendThread(FDSUnit, NextProgItem.linepos, false);
          exit;
        end;
      if CheckBreakPoint(FDSUnit, NextProgItem.linepos) then
      begin
//        if (CurProgItem.opcode <> ocReturn) then // 
          SuspendThread(FDSUnit, NextProgItem.linepos, false)
      end
      else
      with RunToLineInfo^ do
        if Stop and
           (AtLine = NextProgItem.linepos) and
           (TDSUnit(AtUnit) = FDSUnit) then
          SuspendThread(FDSUnit, NextProgItem.linepos, false);
    end;
  end;
end;

{-------------------------------}

procedure TDelphiRunner.FunctionEnter(const ANewLine, AOldLine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList);
begin
  with FDSProject do
  begin
    if CallsCount = 0 then //for add to Stack First Call Level
      SetPrevParams(FDSUnit, ANewLine);
    OnEnterProcedure (FDSUnit, AOldLine, ACallName, cArgs, pArgs);
  end;
end;

{-------------------------------}

procedure TDelphiRunner.FunctionExit(const ANewLine, AOldLine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList);
begin
  FDSProject.OnLeaveProcedure;
end;

{-------------------------------}

procedure TDelphiRunner.CatchException (AExeption: Exception; ADebugInfo: TLineDebugInfo);
begin
  with FDSProject do
    if (ResumeAction <> brtEvaluate) and BreakOnException then
      OnException(AExeption, FDSUnit, TBinprogitem(ADebugInfo.PNextProgItem^).LinePos);
end;

{-------------------------------}

function  TDelphiRunner.GetStackState: integer;
begin
  if FDSProject <> nil then
    Result := FDSProject.GetStackState
  else
    Result := 0;
end;

{-------------------------------}

procedure TDelphiRunner.SetStackState(ANewState: integer);
begin
  if FDSProject <> nil then
    FDSProject.SetStackState(ANewState);
end;

{-------------------------------}

procedure TDelphiRunner._OnDebuggerConnect (Sourse: TObject);
begin
  with TBinProg(FBinProg) do
  begin
    Debugging := true;
    OnChangeTraceLine := ChangeTraceLine;
    OnFunctionEnter := FunctionEnter;
    OnFunctionExit := FunctionExit;
    OnException := CatchException;
  end;
end;

{-------------------------------}

procedure TDelphiRunner._OnDebuggerDisconnect (Sourse: TObject);
begin
  with TBinProg(FBinProg) do
    begin
      Debugging := false;
      OnChangeTraceLine := nil;
      OnFunctionEnter := nil;
      OnFunctionExit := nil;
      OnException := nil;
    end;
end;

{$ENDIF WIN}

{-------------------------------}

type
  TMRunner = class(TScriptRunner)
  end;

  TMScripter = class(TDCScripter)
  end;

Procedure RunnerError(Sender : TObject ; Runner : TScriptRunner; Const S : string; LinePos, CharPos : integer);
var
  Handled : boolean;
  ExcepInfo : TExcepInfo;
Begin
  Handled := false;
  if Assigned(Runner) then
    begin
      FillChar(ExcepInfo, sizeof(ExcepInfo), #0);
      with ExcepInfo do
        BstrDescription := DCStringToOleSt(S);
      TMRunner(Runner).ScriptError(Sender, ExcepInfo, charpos, linepos, Handled);
      if Handled or Runner.Silent then
        Abort;
    end;

  raise ECompilerError.CreateFmt(SErrsynt_err,[LinePos,CharPos,S]);
End;

{-------------------------------}
{
Procedure outbyte(s: TStream; c: byte);
Begin
  s.Writebuffer(c, sizeof(byte));
End;
}
{-----------------------------------------------------------}
{
procedure OutSingle(S : TStream; const val : single);
begin
  OutByte(S, wSingle);
  S.WriteBuffer(s, sizeof(single));
end;
}
{-------------------------------}
{
procedure OutDouble(s: TStream; const val : double);
begin
  OutByte(S, wDouble);
  s.Writebuffer(val, sizeof(double));
end;
}
{-----------------------------------------------------------}
{
procedure OutInteger(S : TStream; val : integer);
begin
  if (val >= Low(ShortInt)) and (val <= High(ShortInt)) then
    begin
      OutByte(S, wInt8);
      S.WriteBuffer(val, SizeOf(Shortint));
    end
  else if (val >= Low(SmallInt)) and (val <= High(SmallInt)) then
    begin
      OutByte(S, wInt16);
      S.WriteBuffer(val, SizeOf(Smallint));
    end
  else
    begin
      OutByte(S, wInt32);
      S.WriteBuffer(val, SizeOf(Integer));
    end;
end;
}
{-----------------------------------------------------------}
{
Procedure outint(s: TStream; c: integer);
Begin
  s.Writebuffer(c, sizeof(integer));
End;
}
{-----------------------------------------------------------}
{
procedure outstr(s : TStream; const st : string);
begin
  OutInt(s, length(st));
  s.WriteBuffer(st[1], length(st));
end;
}
{-----------------------------------------------------------}
{
procedure outstring(s: TStream; Const mys: String);
begin
  OutByte(S, wString);
  outstr(s, mys);
end;
}
{-----------------------------------------------------------}
{
Function getbyte(S: Tstream): byte;
Begin
  s.ReadBuffer(Result, sizeof(byte));
End;
}
{-----------------------------------------------------------}
{
Function getdouble(S: Tstream): double;
Begin
  s.ReadBuffer(Result, sizeof(double));
End;
}
{-----------------------------------------------------------}
{
Function getsingle(S: Tstream): single;
Begin
  s.ReadBuffer(Result, sizeof(single));
End;
}
{-----------------------------------------------------------}
{
function getint8(S : TStream) : shortint;
begin
  s.ReadBuffer(result, sizeof(result));
end;
}
{-----------------------------------------------------------}
{
function getint16(S : TStream) : smallint;
begin
  S.ReadBuffer(result, sizeof(result));
end;
}
{-----------------------------------------------------------}
{
function getint32(S : TStream) : integer;
begin
  S.ReadBuffer(result, sizeof(result));
end;
}
{-----------------------------------------------------------}
{
Function getint(S: Tstream): integer;
Begin
  s.ReadBuffer(Result, sizeof(integer));
End;
}
{------------------------------------}
{
Function getstring(S: Tstream): String;
var
  stlen : integer;
begin
  stlen := getint(s);
  SetLength(result, stlen);
  s.ReadBuffer(result[1], stlen);
end;
}
{-----------------------------------------------------------}

Function Hex2Dec(Const S: String): Longint;
Var
  HexStr: String;
Begin
  if (length(s) > 0) and (s[1] = '$') then
    HexStr := '$' + S
  else
    HexStr := S;
  Result := StrToIntDef(HexStr, 0);
End;

{---------------------------------------------------}

Procedure _ocvarraycreate(Var A: OleVariant; B: Integer);
Begin
{$IFDEF WIN}
  a := VarArrayCreate([0, b - 1], varVariant);
{$ELSE}
  a := UnAssigned;
{$ENDIF}
End;

{---------------------------------------------------}

function v2i(PV : POleVariant) : integer;
begin
  with TVarData(PV^) do
    case vtype of
      varNULL     : result := 0;
      varSmallInt : result := VSmallInt;
      varInteger  : result := VInteger;
      varDispatch : result := integer(vDispatch);
    else
      result := -1;
    end;
end;

{---------------------------------------------------}

function __Ord(const value : OleVariant) : integer;
begin
  result := 0;
  with TVarData(value) do
    case vType of
      varSmallint : result := vSmallInt;
      varInteger  : result := vInteger;
      varBoolean  : result := ord(boolean(vBoolean));
      varByte     : result := vByte;
      varOleStr   : if vOleStr <> nil then
                      result := ord(vOleStr^);
      varString   : if vString <> nil then
                      result := ord(PAnsiString(vString)^[1]);
    end;
end;

{----------------------------------------------}

function VariantsEqual(PA, PB : POleVariant) : boolean;
const
  SpecialCmpTypes = [varEmpty, varNULL, varSmallInt, varInteger, varDispatch];
  IntTypes = [varSmallInt, varInteger, varByte];
var
  atype  : integer;
  btype  : integer;
  o1     : TObject;
begin
  atype := TVarData(PA^).vType;
  btype := TVarData(PB^).vType;
  if (atype = varDispatch) and (btype = varDispatch) then
    begin
      o1 := Disp2Object(IDispatch(TVarData(PA^).vDispatch));
      if (o1 <> nil) and (o1 = Disp2Object(IDispatch(TVarData(PB^).vDispatch))) then
        begin
          result := true;
          exit;
        end;
    end;

  if (atype in SpecialCmpTypes) and (btype in SpecialCmpTypes) then
    if atype = varEmpty then
      result := bType = varEmpty
    else
      result := (bType <> varEmpty) and (v2i(PA) = v2i(PB))
(*
   else if ((atype in IntTypes) and ((btype = varOleStr) or (btype = varString))) or
          ((btype in IntTypes) and ((atype = varOleStr) or (atype = varString))) then
    result := __Ord(PA^) = __Ord(PB^)
*)
  else
    result := PA^ = PB^;
end;

{---------------------------------------------------}

procedure cmpVariants(PA, PB : POleVariant; Invert : boolean);
begin
  PA^ := VariantsEqual(PA, PB) xor Invert;
end;

{---------------------------------------------------}

procedure WriteIdentList(w : TWriter; IdentList : TStrings);
var
  i : integer;
  j : integer;
  ParCount : integer;
begin
  with w, IdentList do
    begin
      WriteInteger(Count);
      WriteString(Text);
      for i := 0 to Count - 1 do
        with TIdentListItem(IdentList.Objects[i]) do
          begin
            WriteInteger(Address);
            WriteInteger(ord(IdentType));
            ParCount := ParamNames.Count;
            WriteInteger(ParCount);
            WriteString(ParamNames.Text);
            for j := 0 to ParCount - 1 do
              WriteInteger(integer(ParamNames.Objects[j]));
          end;
    end;
end;

{-----------------------------------------------------------}

procedure ReadIdentList(r : TReader; IdentList : TStrings; version : integer);
var
  i : integer;
  j : integer;
  item : TIdentListItem;
begin
  with r, IdentList do
    begin
      ReadInteger; // count
      Text := ReadString;
      for i := 0 to Count - 1 do
        begin
          item := TIdentListItem.Create;
          with item do
            try
              Address := ReadInteger;
              IdentType := TIdentType(ReadInteger);
              with ParamNames do
                begin
                  ReadInteger; // count;
                  Text := ReadString;
                  for j := 0 to Count - 1 do
                    Objects[j] := TObject(ReadInteger);
                end;
              Name := Strings[i];
            except
              item.Free
            end;
          Objects[i] := item;
        end;
    end;
end;

{-----------------------------------------------------------}

type
  TMWriter = class(TWriter)
  end;

procedure WriterWriteValue(w : TWriter; Value: TValueType);
begin
  w.Write(Value, SizeOf(Value));
end;

{-----------------------------------------------------------}


const
  vaDouble  = 200;
  _vaDouble : byte = vaDouble;

procedure WriteDouble(w : TWriter; d : double);
begin
  w.Write(_vaDouble, 1);
  w.Write(d, sizeof(double));
end;

function ReadDouble(r : TReader) : double;
begin
  r.ReadValue;
  r.Read(result, sizeof(double));
end;

{-----------------------------------------------------------}

procedure WriteVariant(W : TWriter; const V : Variant);
{$IFDEF D6}
begin
  W.WriteVariant(V);
end;
{$ELSE}
begin
  with TMWriter(w) do
    case TVarData(V).vType and varTypeMask of
      varEmpty    : WriterWriteValue(w, vaNil);

      varNull     : WriterWriteValue(w, vaNull);

{$IFDEF D4}
      varOleStr   : WriteWideString(V);
{$ENDIF}

      varString   : WriteString(V);

      varByte,
      varSmallInt,
      varInteger  : WriteInteger(V);

      varSingle,
      varDouble   : WriteDouble(w, V);

{$IFDEF D4}
      varCurrency : WriteCurrency(V);
{$ELSE}
      varCurrency : WriteFloat(V);
{$ENDIF}

{$IFDEF D4}
      varDate     : WriteDate(V);
{$ELSE}
      varDate     : WriteFloat(V);
{$ENDIF}

      varBoolean  : if V then
                      WriterWriteValue(w, vaTrue)
                    else
                      WriterWriteValue(w, vaFalse);
      else
        WriteString(V);
    end;
end;
{$ENDIF}
{-----------------------------------------------------------}

type
  TMReader = class(TReader)
  end;

function ReadVariant(r : TReader) : Variant;
{$IFDEF D6}
var
  ValType: TValueType;
begin
  ValType:=R.NextValue;
  If ValType=vaUTF8String then
    Result:=R.ReadString
  else
    Result:=R.ReadVariant;
end;
{$ELSE}
const
  ValTtoVarT: array[TValueType] of Integer = (varNull, varError, {$IFNDEF D4}varInteger{$ELSE}varByte{$ENDIF},
    varSmallInt, varInteger, varDouble, varString, varError, varBoolean,
    varBoolean, varError, varError, varString, varEmpty, varError{$IFDEF D4}, varSingle,
    varCurrency, varDate, varOleStr{$ENDIF}{$IFDEF D5}, varError{$ENDIF}{$IFDEF D6}, varError{$ENDIF});
var
  ValType: TValueType;
begin
  with TMReader(R), TVarData(result) do
    begin
      ValType := NextValue;

      If Integer(ValType)=vaDouble then
      begin
        result := ReadDouble(r);
        exit;
      end;

      case ValType of
        vaNil, vaNull: if ReadValue  = vaNil then
                         VarClear(result)
                       else
                         result  := NULL;

        vaInt8: VInteger := ReadInteger;

        vaInt16: VSmallint := Smallint(ReadInteger);

        vaInt32: VInteger := ReadInteger;

        vaExtended: VDouble := ReadFloat;

{$IFDEF D4}
        vaSingle: VSingle := ReadSingle;

        vaCurrency: VCurrency := ReadCurrency;

        vaDate: VDate := ReadDate;
{$ENDIF}
        vaString, vaLString: result  := ReadString;

{$IFDEF D4}
        vaWString: result  := ReadWideString;
{$ENDIF}

        vaFalse, vaTrue: VBoolean := ReadValue  = vaTrue;
      else
        raise EReadError.Create(ResStr(SReadError));
      end;

      TVarData(result).VType := ValTtoVarT[ValType];
    end;
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure THalCompiler.ErrSymbolExpected(const Symbol : string);
begin
  Error(Format(ResStr(SSymbolExpected),[Symbol]));
end;

{-------------------------------------------------------------------------}

procedure THalCompiler.ErrSymbolExpectedButFound(const Expected, Found : string);
begin
  Error(Format(SErrExpectedButFound, [Expected, Found]));
end;

{-------------------------------------------------------------------------}

constructor THalCompiler.CreateFromStream(S : TStream; Runner : TScriptRunner);
var
  r : TReader;
  cCount : integer;
  i      : integer;
  pversion : integer;
begin
  Create('', nil, Runner);
  r := TReader.Create(S, 4096);
  with r do
    try
      spoint := r.ReadInteger;
      if DWORD(spoint) = $FFFFFFFF then
        begin
          pversion := r.ReadInteger;
          spoint := r.ReadInteger
        end
      else
        pversion := 2;

      ReadIdentList(r, Labels, pversion);
      ReadIdentList(r, Variables, pversion);

      cCount := ReadInteger;
      for i := 0 to cCount - 1 do
        consts.NewItem(dcpascal.ReadVariant(r));

      cCount := ReadInteger;
      for i := 0 to cCount - 1 do
        with TIDLabelItem(IDLabels.Add) do
          begin
            Referenced := ReadBoolean;
            Exist := ReadBoolean;
            Place := ReadInteger;
          end;

      cCount := ReadInteger;
      for i := 0 to cCount - 1 do
        with TProgItem(Prog.Add) do
          begin
            OpCode := ReadInteger;
            A := ReadInteger;
            B := ReadInteger;
            LinePos := ReadInteger;
            CharPos := ReadInteger;
          end;

    finally
      r.Free;
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.SaveToStream(S : TStream);
var
  w : TWriter;
  i : integer;
begin
  w := TWriter.Create(S, 4096);
  with w do
    try
      WriteInteger(integer($FFFFFFFF)); //new version
      WriteInteger(ParserVersion);
      WriteInteger(spoint);

      WriteIdentList(w, Labels);
      WriteIdentList(w, Variables);

      WriteInteger(Consts.Count);
      for i := 0 to Consts.Count - 1 do
        dcpascal.WriteVariant(w, TConstItem(Consts.Items[i]).Data);

      with IDLabels do
        begin
          WriteInteger(Count);
          for i := 0 to Count - 1 do
            with TIDLabelItem(Items[i]) do
              begin
                WriteBoolean(Referenced);
                WriteBoolean(Exist);
                WriteInteger(Place);
              end;
        end;

      with Prog do
        begin
          WriteInteger(Count);
          for i := 0 to Count - 1 do
            with TProgItem(Items[i]) do
              begin
                WriteInteger(OpCode);
                WriteInteger(A);
                WriteInteger(B);
                WriteInteger(LinePos);
                WriteInteger(CharPos);
              end;
        end;

    finally
      Free;
    end;
end;

{----------------------------------------------}

Procedure THalCompiler.Error(Const s: String);
Begin
  With FParser do
    RunnerError(Self, FRunner, S, LinePos, CharPos);
End;

{-----------------------------------------------------------}

Function THalCompiler.NextToken: TToken;
begin
  With FParser do
  begin
    PushState;
    Result := Self.ReadToken;
    PopState;
  end;
end;

{-----------------------------------------------------------}

function THalCompiler.NextTokenID : integer;
begin
  result := NextToken.TokenID;
end;

{-----------------------------------------------------------}

Function THalCompiler.NextToken2 : TToken;
begin
  With FParser do
    begin
      PushState;
      Self.ReadToken;
      Result:=Self.ReadToken;
      PopState;
    end;
end;

{-----------------------------------------------------------}

function THalCompiler.ReadToken: TToken;
var
  tokenType : integer;
  ConvertResult : integer;
{$IFDEF D4}
  i64   : int64;
{$ENDIF}
begin
  tokenType := FParser.NextValidToken;
  with FParser, Result do
    begin
      stValue := TokenString;
      case tokenType of
        tokEOF : TokenID := idEndOfFile;

        tokString : begin
                      TokenID := idStringConst;
                      if UnterminatedString then
                        self.Error(SErrUnterminated);
                    end;

        tokSymbol : TokenID := idIdentifier;

        tokInteger:
          begin
            TokenID := idNumberConst;
            {$IFDEF D4}
            Val(stValue, i64, ConvertResult);
            iValue := i64;
            {$ELSE}
            Val(stValue, iValue, ConvertResult);
            {$ENDIF}
            if (ConvertResult <> 0) {$IFDEF D4} or (-i64 > 2147483648) or (i64 > 4294967295){$ENDIF} then
              self.Error(SErrInvalidConstant);
          end;

        tokFloat:
          begin
            TokenID := idFloatConst;
            fValue := GetFloatFromString(TokenString);
          end;

        tokResWord :
        begin
          if (CompareText(stValue, 'read') = 0) or (CompareText(stValue, 'write') = 0) then //don't resource
            TokenID := idIdentifier
          else
            TokenID := ResWordID;
        end;
        tokWhiteChar : TokenID := Integer(TokenPtr^) + idCharBase;
      end;
    end;
end;

{----------------------------------------}

function THalCompiler.putcode(aid, aa, bb: integer) : TProgItem;
begin
  result := tprogitem(prog.add);
  with result do
    begin
      opcode := aid;
      a := aa;
      b := bb;
      charpos := FParser.CharPos;
      linepos := FParser.LinePos;
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.ExpectID(id : integer; const ErrStr : string);
begin
  if Token.TokenID <> id then
    ErrSymbolExpected(ErrStr);
end;

{-----------------------------------------------------------}

procedure THalCompiler.ExpectNextID(id : integer; const ErrStr : string);
begin
  _readToken;
  if Token.TokenID <> id then
    Error(Format(ResStr(SSymbolExpected),[ErrStr]));
end;

{-----------------------------------------------------------}

procedure THalCompiler._readtoken;
begin
  Token := ReadToken;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getdelimiter;
begin
  ExpectNextID(idDelimiter, ';');
end;

{-----------------------------------------------------------}

function THalCompiler.iexpression: integer;
var
  IsAllConst : boolean;
  ConstValue : Variant;
begin
  result := iexpression2(IsAllConst, ConstValue, false);
end;

{-----------------------------------------------------------}


procedure THalCompiler.putloadconst(const Value : Variant);

  function isint(d : double) : boolean;
  var
    ival : integer;
  begin
    result := false;
    if (d > MaxInt) or (d < -MaxInt) then
      exit;
    ival := round(d);
    if ival = d then
      begin
        result := true;
        putcode(ocloadintconst, spoint, ival);
      end;
  end;

begin
  with TVarData(Value) do
    case vType of
      varSmallInt : begin
                      putcode(ocloadintconst, spoint, vSmallInt);
                      exit;
                    end;

      varInteger : begin
                     putcode(ocloadintconst, spoint, vInteger);
                     exit;
                   end;

      varBoolean : begin
                     putcode(ocloadboolconst, spoint, ord(vBoolean));
                     exit;
                   end;

      varsingle  : if isint(vsingle) then
                     exit;

      vardouble  : if isint(vdouble) then
                     exit;
    end;

  putcode(ocloadconst, spoint, Consts.newitem(Value));
end;

{-----------------------------------------------------------}

(*
procedure THalCompiler.OpWithIntConst(ACode, Op1, constval : integer);
begin
  putcode(ACode + IntOpsBase, Op1, constval);
end;
*)
{-----------------------------------------------------------}

procedure THalCompiler.OpWithConst(ACode : integer; Op1 : integer; const ConstVal : Variant);
{var
  ival : integer;}
begin
  if ACode = ocSlash then
    begin
      if ConstVal = 0 then
        Error(SErrDivByZero);

      putcode(ocMul + ConstOpsBase, Op1, Consts.newitem(1 / ConstVal)); //opt: Multiplication is faster than division
    end
  else
    begin
      if (ACode = ocAdd) and (TVarData(ConstVal).vType in [varSmallInt, varInteger, varSingle, varDouble]) and (ConstVal = 1) then   //opt: x := x + 1 -> inc(x)
        putcode(ocIncVar, Op1, 0)
      else
        putcode(ACode + ConstOpsBase, Op1, Consts.newitem(ConstVal));
    end;
{  with TVarData(ConstVal) do
    case vType of
      varSmallInt : OpWithIntConst(ACode, Op1, vSmallInt);
      varInteger  : OpWithIntConst(ACode, Op1, vInteger);
      varBoolean  : OpWithIntConst(ACode, Op1, ord(vBoolean));
    else
      putcode(ACode + ConstOpsBase, Op1, Consts.newitem(ConstVal));
    end;
}
end;

{-----------------------------------------------------------}

procedure THalCompiler._DoProc(ACode : integer; var isconst, isallconst : boolean;
                               var ConstValue : Variant; var Result : integer;
                               iProc : TGetExpressionProc);
var
  factor2 : integer;
  aa      : integer;
  bb      : integer;
  vconst  : variant;

  procedure calccurval(ACode : integer; const Val : Variant);
  begin
    case ACode of
      ocadd   : ConstValue := ConstValue + Val;
      ocsub   : ConstValue := ConstValue - Val;
      ocmul   : ConstValue := ConstValue * Val;
      ocdiv   : ConstValue := ConstValue div Val;
      ocmod   : ConstValue := ConstValue mod Val;
      ocSlash : ConstValue := ConstValue / Val;
      ocshl   : ConstValue := ConstValue shl Val;
      ocshr   : ConstValue := ConstValue shr Val;
      ocor    : ConstValue := ConstValue or Val;
      ocxor   : ConstValue := ConstValue xor Val;
      ocAnd   : ConstValue := ConstValue and Val;
      ocGreaterEqual   : ConstValue := ConstValue >= val;
      ocEqual          : ConstValue := ConstValue = val;
      ocLessEqual      : ConstValue := ConstValue <= val;
      ocNotEqual       : ConstValue := ConstValue <> val;
      ocGreater        : ConstValue := ConstValue > val;
      ocLess           : ConstValue := ConstValue < val;
    end;
  end;

  procedure returncurval;
  begin
    putloadconst(ConstValue);
    result := spoint;
    inc(spoint);
  end;

var
  _pc : integer;
  _sp : integer;
begin
  _ReadToken;
  _pc := prog.count;
  _sp := spoint;
  factor2 := iProc(isconst, vconst);
  if isconst then
    if isallconst then
      begin
        calccurval(Acode, vconst);
        exit;
      end
    else
      begin
        OpWithConst(ACode, result, vconst);
        exit;
        {a := result;
        putloadconst(vconst);
        b := spoint;
        inc(spoint);}
      end
  else
    if isallconst then
      begin
        returncurval;
        aa := result;
        bb := factor2;
        isallconst := false
      end
    else
      begin
        aa := result;
        //opt:  mov tmp, b -> op a, b
        //      op  a, tmp
        bb := factor2;
        if (_pc = prog.count - 1) then
          with TProgItem(prog.Items[_pc]) do
            if (opcode = ocMov) and (a = bb) then
              begin
                bb := b;
                spoint := _sp;
                Free;
              end;
      end;

  putcode(ACode, aa, bb);
end;

{-----------------------------------------------------------}

function THalCompiler.iexpression2(var IsAllConst : boolean; var ConstValue : Variant; OnlyCalc : boolean) : integer;
var
  isconst : boolean;
  vconst : variant;

  procedure returncurval;
  begin
    putloadconst(ConstValue);
    result := spoint;
    inc(spoint);
  end;

  procedure DoProc(ACode:Integer);
  begin
    _DoProc(ACode, isConst, isAllConst, ConstValue, Result, isimpleexpression);
  end;

begin
  Result := isimpleexpression(isconst, vconst);
  isallconst := isconst;
  if isconst then
    ConstValue := vconst;

  Case NextTokenID of
    idequal : DoProc(ocEqual);

    idgreater : begin
                  if nexttoken2.TokenID = idequal then
                    begin
                      _readtoken;
                      DoProc(ocgreaterequal);
                    end
                  else
                    DoProc(ocgreater);
                end;

    idless : begin
               case nexttoken2.TokenID of
                 idequal :
                   begin
                     _readtoken;
                     DoProc(oclessequal);
                   end;

                 idgreater :
                   begin
                     _readtoken;
                     DoProc(ocnotequal);
                   end;
                 else
                   DoProc(ocless);
               end;
             end;
  end;

  if IsAllConst and not OnlyCalc then
    returncurval;
end;

{-----------------------------------------------------------}

procedure THalCompiler.PlaceLabelHere(LabelID : integer);
begin
  IDLabels.setplace(LabelID, prog.count);
end;

{-----------------------------------------------------------}

Function THalCompiler.isimpleexpression(var IsAllConst : boolean; var ConstValue : Variant): integer;
var
  vconst : variant;
  isconst : boolean;
  l0      : integer;

  procedure DoProc(ACode : Integer);
  begin
    _DoProc(ACode, isConst, isAllConst, ConstValue, Result, iterm);
  end;

Begin
  Result := iterm(isconst, vconst);
  isallconst := isconst;
  if isconst then
    ConstValue := vconst;

  While True do
    Case NextTokenID of
      idPlus:  DoProc(ocadd);
      idMinus: DoProc(ocsub);
      id_Or:   begin
                 if isallconst and
                   (TVarData(ConstValue).vType = varBoolean) and TVarData(ConstValue).vBoolean then
                    break
                 else
                   begin
                     l0 := IDLabels.NewReferencedItem;
                     fRefs.Add(@(putcode(ocTrueCheck, result, l0).b));
                     DoProc(ocor);
                     PlaceLabelHere(l0);
                   end;
               end;
      id_Xor:  DoProc(ocxor);
    else
      break;
    End;
End;

{-----------------------------------------------------------}

Function THalCompiler.iterm(var IsAllConst : boolean; var ConstValue : Variant): integer;
var
  vconst : variant;
  l0     : integer;
  isconst : boolean;

  procedure returncurval;
  begin
    putloadconst(ConstValue);
    result := spoint;
    inc(spoint);
  end;

  procedure DoProc(ACode : Integer);
  begin
    _DoProc(ACode, isConst, isAllConst, ConstValue, Result, ifactor);
  end;

Begin
  Result := ifactor(isconst, vconst);
  isallconst := isconst;
  if isconst then
    ConstValue := vconst;

  While True do
    Case NextTokenID of
      id_shl:  DoProc(ocshl);
      id_shr:  DoProc(ocshr);
      id_And:  begin
                 if isallconst and
                    (TVarData(ConstValue).vType = varBoolean) and not TVarData(ConstValue).vBoolean then
                       break
                 else
                   begin
                     l0 := IDLabels.NewReferencedItem;
                     fRefs.Add(@(putcode(ocFalseCheck, result, l0).b));
                     DoProc(ocAnd);
                     PlaceLabelHere(l0);
                   end;
               end;
      idStar:  DoProc(ocmul);
      idSlash: DoProc(ocSlash);
      id_div:  DoProc(ocdiv);
      id_mod:  DoProc(ocmod);
    else
      break;
    End;
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getopenbracket;
Begin
  _readtoken;
  If (token.TokenID <> idOpenBracket) and (token.TokenID <> idsqOpenBracket) then
    ErrSymbolExpected('(');
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getclosebracket;
Begin
  _readtoken;
  If (token.TokenID <> idcloseBracket) and (token.TokenID <> idsqcloseBracket) then
   ErrSymbolExpected(')');
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getcoma;
Begin
  ExpectNextID(idComma, 'Comma');
End;

{-----------------------------------------------------------}

Function THalCompiler.GetOpenArray(NeedSq: boolean): Integer;
Var
  ints: Array[0..200] of integer;
  i, maxints: integer;
  ospoint: integer;

Begin
  if NeedSq or (NextTokenID = idsqopenbracket) then
    Begin
      _readtoken;
      If token.TokenID <> idsqopenbracket then
        ErrSymbolExpectedButFound('[',token.stValue);
    End;
{----}
  maxints := 0;
  ospoint := spoint;
  inc(spoint);

  while true do
    begin
      with nexttoken do
        if (TokenID = idsqclosebracket) or (TokenID = idclosebracket) then
          break;

        If maxints > 0 then
          getcoma;

        ints[maxints] := iexpression;
        inc(maxints);
    end;

  if maxints = 0 then
    ErrSymbolExpectedButFound(SExpression, ']');

  putcode(ocvarraycreate, ospoint, maxints);

{  putcode(ocloadconst, spoint, Consts.newitem(maxints));

  putcode(ocsetvarray, 0, spoint);
  inc(spoint);
  putcode(0, ospoint, 0);
}
  For i := 0 to maxints - 1 do
    Begin
      putcode(ocsetvarray, i {+ 1}, ints[i]);
      putcode(0, ospoint, 0);
    End;

  Result := ospoint;
{----}
  If NeedSq or (NextTokenID = idsqclosebracket) then
    Begin
      _readtoken;
      If token.TokenID <> idsqclosebracket then
        ErrSymbolExpectedButFound(']',token.stValue);
    End;
End;

{-----------------------------------------------------------}

function THalCompiler.AddVariable(const AName: string; ID: integer) : TIdentListItem;
var
  fullname : string;
begin
  fullname := IdentPrefix + AName;
  If Variables.IndexOf(fullname) >= 0 then
    Error(Format(SErrIdentifierRedeclared, [AName]));
  Result := Variables.additem2(fullname, ID);
end;

{-----------------------------------------------------------}

function pointcount(const s : string) : integer;
var
  i : integer;
begin
  result := 0;
  i := length(s) - 1;
  while i > 0 do
    begin
      if s[i + 1] = '.' then
        inc(result);
      dec(i);  
    end;
end;

{-----------------------------------------------------------}

function THalCompiler.VarIDByName(const AName: string; var Id: Integer): boolean;
var
  s : string;
  i : integer;
begin
  s := IdentPrefix;
  repeat
    result := Variables.Find(s + Aname, id);
    if s = '' then
      exit;

    if result then
      begin
        if pointcount(s) <> pointcount(IdentPrefix) then
          begin
            if fDeclaredClasses.IndexOf(s) < 0 then
              Error(SErrTopLevelVar);
          end;
        exit;
      end;

    i := length(s);
    if S[i] = '.' then
      dec(i);
    while (i > 0) and (S[i] <> '.') do
      dec(i);
    setlength(s, i);
  until false;
end;

{-----------------------------------------------------------}

Function THalCompiler.VarByName(Const AName: String; Var Ident: TIdentListItem): boolean;
Var
  i: integer;
Begin
  Result := VarIDByName(aname, i);
  if result then
    ident := TIdentListItem(Variables.Objects[i])
  else
    ident := nil;
End;

{-----------------------------------------------------------}

procedure THalCompiler.PutSingleCode(code:integer);
begin
  with Prog do
    case  FCodeCount of
      0 : putCode(code, 0, 0);
      1 : TProgItem(Items[Count - 1]).A := code;
      2 : TProgItem(Items[Count - 1]).B := code;
    end;

  if FCodeCount < 2 then
    inc(FCodeCount)
  else
    FCodeCount := 0;
end;

{-----------------------------------------------------------}

function THalCompiler.ReadParam : integer;
var
  oldcount : integer;
begin
  _readtoken;  // read bracket or comma

  fPutReference := false;
  oldcount := prog.count;
  StartUseStack;

  result := iexpression;
  if fPutReference and (prog.count = oldcount + 1) then
    tprogitem(prog.items[oldcount]).opcode := ocMovRef;

  StopUseStack;

  with NextToken do
   if (TokenID <> idCloseBracket) and
      (TokenID <> idsqClosebracket) and
      (TokenID <> idComma) then
     Error(Format(SErrOrExpected,[')',']']));
end;

{-----------------------------------------------------------}

function THalCompiler.ReadIdent(const ACode : integer) : integer;
var
  firsttime : boolean;
  i         : integer;
  idx       : integer;
  params    : array[0 .. maxparams] of integer;

  function emptybrackets : boolean;
  begin
    with fParser do
      begin
        PushState;
        result := (self.ReadToken.TokenID = idOpenBracket) and
                  (self.ReadToken.TokenID = idCloseBracket);
        PopState;
        if result then
          begin
            self.ReadToken;
            self.ReadToken;
          end;
      end;
  end;

var
  ExpectedCloseBracketID : integer;
  expectedstr            : string;
begin
  result := AddStringConst(Token.stValue);
  firsttime := true;
  idx := 0;
  ExpectedCloseBracketID := 0;

  if not emptybrackets then
    while true do
      begin
        with NextToken do
          begin
            case TokenID of
              idOpenBracket     : if firsttime then
                                    ExpectedCloseBracketID := idCloseBracket;

              idsqopenbracket   : if firsttime then
                                    ExpectedCloseBracketID := idsqCloseBracket;

              idComma           : if firsttime then
                                    break;

              idCloseBracket,
              idsqClosebracket  : begin
                                    if (ExpectedCloseBracketID <> 0) and
                                       (TokenID <> ExpectedCloseBracketID) then
                                      begin
                                        if TokenID = idsqCloseBracket then
                                          expectedstr := ')'
                                        else
                                          expectedstr := ']';

                                        ErrSymbolExpected(expectedstr);
                                      end;

                                    if not firsttime then
                                      _readtoken;

                                    break;
                                  end;
            else
              break;
            end;

            firsttime := false;
            params[idx] := ReadParam;
            inc(idx);
          end;
      end;

  if not fIgnoreAssignment and (NextTokenID = id2Points) then
    begin
      _readtoken;
      ExpectNextID(idEqual, '=');
      StartUseStack;
      params[idx] := iexpression;
      StopUseStack;
      inc(idx);
      PutCode(ocDispAssign,result,idx);
      FCodeCount := 0;
      for i := 0 to idx - 1 do
        PutSingleCode(params[i]);
    end
  else
    begin
      inc(spoint);
      if idx = 0 then
        PutCode(ACode + 1, spoint, result) // ocScriptDispatch -> ocScriptDispatch2
      else
        begin
          PutCode(Acode, spoint, idx);
          FCodeCount := 0;
          PutSingleCode(result);
          for i := 0 to idx - 1 do
            PutSingleCode(params[i]);
        end;
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.ProcessProcIdent(BeginCode:Integer);
var
  mname     : string;
begin
  mname := fParser.TokenString;

  if (BeginCode = ocScriptInvoke) and (fRunner.StrictSyntaxCheck and (TMScripter(fRunner.Scripter).GetUserVarID(mname) = -1)) then
    if not (IsIdentRegistered(mname) or (TMRunner(fRunner).NamedItems.IndexOf(mname) >= 0)) then
      Error(Format(SErrunkn_id, [mname]));

  ReadIdent(BeginCode);
  while NextTokenID = idpoint do
    begin
      _readtoken;
//      if NextTokenID = idIdentifier then
        begin
          _readtoken;
          ReadIdent(ocScriptDispatch);
        end
{
      else
        break;
}
    end;

  PutCode(ocPopIDisp,0,0);
end;

{-----------------------------------------------------------}

function THalCompiler.IsTypeCast(const stToken : string) : boolean;
begin
  result := isClassRegistered(stToken) and (NextTokenID = idOpenBracket);
end;

{-----------------------------------------------------------}

procedure THalCompiler.StartUseStack;
begin
//  fspoints.Push(spoint);
end;

{-----------------------------------------------------------}

procedure THalCompiler.StopUseStack;
begin
//  if spoint > maxspoint then
//    maxspoint := spoint;

//  spoint := fspoints.Pop;    
end;

{-----------------------------------------------------------}

function THalCompiler.ReturnSPoint : integer;
begin
  Result := spoint;
  inc(spoint);
end;

{-----------------------------------------------------------}

procedure _Neg(PSA : POleVariant);
begin
  PSA^ := -PSA^;
end;

{-----------------------------------------------------------}

procedure _Not(PSA : POleVariant);
begin
  PSA^ := not PSA^;
end;

{-----------------------------------------------------------}

function IsBuiltinFunc(const FuncName : string; var FuncID : integer) : boolean;
var
  fname : string;
begin
  FuncID := 0;
  fname := UpperCase(FuncName);
  if fname = 'COS' then
    FuncID := ocCos
  else if fname = 'SIN' then
    FuncID := ocSin
  else if fname = 'EXP' then
    FuncID := ocExp
  else if fname = 'SQR' then
    FuncID := ocSQR
  else if fname = 'SQRT' then
    FuncID := ocSQRT
  else if fname = 'LN' then
    FuncID := ocLn
  else if fname = 'ARCTAN' then
    FuncID := ocArcTan;
  result := FuncID > 0;  
end;

{-----------------------------------------------------------}

Function THalCompiler.ifactor(var IsConst : boolean; var ConstValue : Variant): integer;
var
  ident : TIdentListItem;

  procedure ReturnIntConst(val : integer);
  begin
    IsConst := True;
    ConstValue := val;
  end;

  procedure ReturnBoolConst(val : boolean);
  begin
    IsConst := True;
    VarClear(ConstValue);
    with TVarData(ConstValue) do
      begin
        vType := varBoolean;
        vBoolean := val;
      end;
  end;

  procedure processVarFunc;
  begin
    case ident.identtype of
      tivariable:
        begin
          fPutReference := true;
          putcode(ocmov, spoint, ident.Address);
          result := ReturnSPoint;
        end;

      tifunction : Result := getinternalfun(Token.stValue, ident);
    else
      Error(SErrin_procuse);
    End
  end;

  procedure ProcessPointOrBracket;
  var
    nextid : integer;
    oldresult : integer;
    indexlist : TList;
  begin
    while true do
      begin
        nextid := NextTokenID;
        if nextid = idpoint then
          begin
            putcode(ocPushIDisp, result, 0);
            _readtoken;
            _readtoken;
            ProcessProcIdent(ocScriptDispatch);
            result := ReturnSPoint;
          end
        else if nextid = idsqopenbracket then
          begin
            ReadToken;
            StartUseStack;
            oldresult := result;
            indexlist := TList.Create;
            try
              repeat
                indexlist.Add(pointer(iExpression));
                if NextTokenID = idComma then
                  ReadToken
                else
                  break;
              until false;
              result := integer(indexlist[0]);
              ReadToken;
              if indexlist.count = 0 then
                putcode(ocGetItem, result, oldresult)
              else
                begin
                  putcode(ocGetItem2, indexlist.count, oldresult);
                  putlisttocodes(indexlist);
                end;
            finally
              indexlist.Free;
            end;
            StopUseStack;
          end
        else
          break;
      end;
  end;

  procedure ProcessInternalFunction(InternalFuncId : integer);
  begin
    result := iExpression2(IsConst, ConstValue, false);
    if IsConst then
      case InternalFuncId of
        ocCos : ConstValue := cos(ConstValue);
        ocSin : ConstValue := sin(ConstValue);
        ocExp : ConstValue := exp(ConstValue);
        ocSqr : ConstValue := sqr(ConstValue);
        ocSqrt : ConstValue := sqrt(ConstValue);
        ocLn : ConstValue := ln(ConstValue);
        ocArcTan : ConstValue := arctan(ConstValue);
      end
    else
      putcode(InternalFuncId, result, 0);
  end;

var
  l : integer;
  tString : string;
  builtinfuncid : integer;
begin
  Result:=0;
  _readtoken;
  l := token.TokenID;
  IsConst := False;
  tString := fParser.TokenString;

  Case l of
    idsqopenbracket : result := GetOpenArray(false);

    ididentifier:
      if CompareText(tString, 'True') = 0 then //don't resource
        ReturnBoolConst(True)
      else if CompareText(tString, 'False') = 0 then //don't resource
        ReturnBoolConst(False)
      else if varbyname(tString, ident) then
        begin
          processVarFunc;
          ProcessPointOrBracket;
        end
      else if fDeclConsts.ConstantExists(tString) then
        begin
          if NextTokenID = idsqopenbracket then
            begin
              fDeclConsts.GetConstValue(tString, ConstValue);
              putcode(ocloadconst, spoint, Consts.newitem(ConstValue));
              result := ReturnSPoint;
              ProcessPointOrBracket;
            end
          else
            begin
              IsConst := true;
              fDeclConsts.GetConstValue(tString, ConstValue);
            end;
        end
      else if CompareText(tString, 'Unassigned') = 0 then //don't resource
        begin
          IsConst := true;
          VarClear(ConstValue);
        end
      else if IsConstRegistered(tString) then
        begin
          IsConst := true;
          GetRegisteredConst(tString, ConstValue);
        end
      else if IsBuiltinFunc(tString, builtinfuncid) then
        ProcessInternalFunction(builtinfuncid)
      else if CompareText(tString, 'Evaluate') = 0 then //don't resource
        begin
          result := iExpression2(IsConst, ConstValue, false);
          IsConst := false;
          putcode(ocEvaluate, result, 0);
        end
      else if IsTypeCast(tString) then
        begin
          getopenbracket;
          result := iFactor(IsConst, ConstValue);
          getclosebracket;
          ProcessPointOrBracket;
        end
      else
        begin
          ProcessProcIdent(ocScriptInvoke);
          result := ReturnSPoint;
        end;

    id_nil: ReturnIntConst(0);

    idDollar :
      begin
        _readtoken;
        if token.TokenID <> idnumberconst then
          Error(SErrbad_hex);
        ReturnIntConst(Hex2Dec(tString));
      end;

    idhexconst: ReturnIntConst(Hex2Dec(tString));

    idnumberconst: ReturnIntConst(Token.iValue);

    idFloatConst : begin
                     IsConst := true;
                     ConstValue := Token.fValue;
                   end;

    idnotequal:
      begin
        _readtoken;
        if token.TokenID <> idnumberconst then
          Error(SErrbad_charconst);
        IsConst := true;
        ConstValue := Char(token.iValue);
      end;

    idstringconst: begin
                     IsConst := true;
                     ConstValue := ExtractQuotedStr('''' + tString + '''', '''');
                   end;

    idopenbracket:
      begin
        Result := iexpression;
        getclosebracket;
      end;

    idplus : Result := ifactor(IsConst, ConstValue);

    idminus:
       begin
         Result := ifactor(IsConst, ConstValue);
         if IsConst then
           _Neg(POleVariant(@ConstValue))
         else
           putcode(ocneg, Result, 0);
       end;

    id_not:
       begin
         Result := ifactor(IsConst, ConstValue);
         if IsConst then
           _Not(POleVariant(@ConstValue))
         else
           putcode(ocnot, Result, 0);
       end;
    else
      ErrSymbolExpectedButFound(SExpression,token.stValue);
  End;
End;

{-----------------------------------------------------------}

Procedure THalCompiler.labeldispatch(Const labelname: String);
var
  i : integer;
Begin
  if not Labels.IDByName(labelname, i) then
    Error(Format(SErrlab_notdef, [labelname]));

  PlaceLabelHere(i);
End;

{-----------------------------------------------------------}

procedure THalCompiler.getprogramname;
begin
  if NextTokenID in [id_Program, id_unit] then
    begin
      _readtoken;
      getidentifier;
      getdelimiter;
    end;
end;

{-----------------------------------------------------------}

Procedure THalCompiler.getidentifier;
Begin
  ExpectNextID(idIdentifier, 'Program name'); //don't resource
End;

{-----------------------------------------------------------}

{if WasDeclared then ProcIdent = nil}
function THalCompiler.getprocparams(WasDeclared : boolean; ProcIdent : TIdentListItem) : integer;
var
  ptype  : TDCParamType;
  i      : integer;
  plist  : TList;
  id     : integer;
  IsConst : boolean;
  cvalue : Variant;
  pname : string;
  defvalue : boolean;
  defused  : boolean;

  procedure checkdefval;
  begin
    if defvalue and not defused then
      Error(Format(SErrDefValueRequired, [pname]));
  end;
  
begin
  defused := false;
  defvalue := false;
  _readtoken;
  pType := ptNormal;
  plist := TList.Create;
  try
    with fParser do
      while not IsTokenChar(')') do
        begin
          if IsTokenResWord(ID_VAR) or IsTokenResWord(ID_OUT) then
            pType := ptVar
          else if IsTokenResWord(ID_CONST) then
            pType := ptConst
          else if IsTokenChar(';') then
            begin
              checkdefval;
              pType := ptNormal;
              defused := false;
            end
          else if IsTokenChar(':') then
            begin
              NextValidToken; // type
              if PeekValidTokenStr = '=' then
                begin // default value
                  if ptype = ptVar then
                    Error(Format(SErrDefValueIsVar, [pname]));

                  defvalue := true;
                  defused := true;
                  NextValidToken; // =
                  iExpression2(IsConst, cvalue, true);
                  CheckConst(IsConst);
                  if not WasDeclared then
                    ProcIdent.DefaultParams.Add(pointer(Consts.newitem(cValue)));
//!                  putcode(ocloadconst, spoint, );
                end;
            end
          else if not (WasDeclared or IsTokenChar(',')) then
            begin
              pname := TokenString;
              ProcIdent.ParamNames.AddObject(pname, TObject(pType));
              plist.Add(Variables.Objects[AddVars(TokenString, 0)]);

              pushstate;
              try
                NextValidToken;
                if (Token <> tokResWord) and
                   not ((Token = tokWhiteChar) and (TokenPtr^ in [';', ':', ',', ')'])) then
                  ErrSymbolExpectedButFound(''':'', '')'' or '',''', TokenString);
              finally
                popstate;
              end;
            end;

          NextValidToken;
        end;

      checkdefval;
      result := plist.Count;
      for i := 0 to result - 1 do
        begin
          id := i - result;

          if ProcIdent.Params[i] = ptVar then
            id := MaxStackSize - id;

          TIdentListItem(plist.List[i]).Address := id;
        end;
  finally
    plist.Free;
  end;
end;

{-----------------------------------------------------------}

function THalCompiler.getprocdef(askip: boolean): Integer;
var
  ProcName       : string;
  pindex         : integer;
  ProcIdent      : TIdentListItem;
  WasDeclared    : boolean;
  pcount         : integer;
  oidentpref     : string;
  isFunc         : boolean;
  hasResult      : boolean;
begin
  isFunc := fParser.IsTokenResWord(ID_FUNCTION);
  getidentifier;
  ProcName := token.stValue;
  while NextTokenID = idpoint do
    begin
      _readtoken;
      getidentifier;
      ProcName := ProcName + '.' + token.stValue;
    end;

  WasDeclared := varidbyname(ProcName, pindex);

  if not WasDeclared then
    begin
      Result := AddVars(ProcName, IDLabels.newitem);
      ProcIdent := TIdentListItem(Variables.Objects[Result]);
    end
  else
    ProcIdent := nil;

  if NextTokenID = idopenbracket then
    begin
      getopenbracket;
      oidentpref := identprefix;
      identprefix := identprefix + ProcName + '.';
      pcount := getprocparams(WasDeclared, ProcIdent);
      identprefix := oidentpref;
    end
  else
    pcount := 0;

  if not WasDeclared then
    begin
      hasresult := NextTokenID = id2points;

      if isFunc then
        begin
          if hasresult then
            begin
              _readtoken;
              getvartype;
            end;

          ProcIdent.IdentType := tifunction;
          AddVars(ProcName + coProcResult, - pcount - 1);
        end
      else
        begin
          if hasresult then
            Error(SErrProcedureResult)
          else
            ProcIdent.IdentType := tiprocedure;
        end;

      //inc(spoint);
    end
  else
    if NextTokenID = id2points then
      begin
        _readtoken;
        getvartype;
      end;

  varidbyname(ProcName, Result);
  getdelimiter;
  getafterproc;
end;

{-----------------------------------------------------------}

Procedure THalCompiler.getafterproc;
Begin
  while NextTokenID in
  [ID_Register, ID_Pascal, ID_Cdecl, ID_StdCall, ID_SafeCall,
   ID_Abstract, ID_Dynamic, ID_Message, ID_OVERLOAD, ID_Override,
   ID_Reintroduce, ID_Virtual] do
    Begin
      _readtoken;
      getdelimiter;
    End;
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getclassdef(Const cname: String);
var
  OIdentPrefix : string;
  _addvars : boolean;
Begin
  OIdentPrefix := IdentPrefix;
  _addvars := false;
  try
    IdentPrefix := cname + '.';
    fDeclaredClasses.Add(IdentPrefix);
    if NextTokenID = idopenbracket then
      begin
        _readtoken;
        ExpectNextID(idIdentifier, 'Parent name'); //don't resource
        ExpectNextID(idclosebracket, ')');
      end;

    with fParser do
      begin
        NextValidToken;

        while not (ParserEOF or IsTokenResWord(ID_END)) do
          begin
            if Token = tokResWord then
              begin
                case ResWordID of
                  ID_PRIVATE,
                  ID_PROTECTED,
                  ID_PUBLIC,
                  ID_PUBLISHED : begin
                                   _addvars := true;
                                   NextValidToken;
                                 end;

                  ID_CONSTRUCTOR,
                  ID_DESTRUCTOR,
                  ID_PROCEDURE,
                  ID_FUNCTION  : getprocdef(false);

                  ID_PROPERTY : Error(SErrno_props);
                else
                  NextValidToken;
                end;
              end
            else if Token = tokSymbol then
              getmyvariables(_addvars)
            else
              NextValidToken;
          end;
        NextValidToken; // ;
      end;
   finally
     IdentPrefix := OIdentPrefix;
   end;
End;

{-----------------------------------------------------------}

Procedure THalCompiler.gettypeidentifier;
Var
  s: String;
Begin
  _readtoken;
  S := Token.stValue;
  _readtoken;
  if Token.TokenID <> idequal then
    Error(Format(SErr_decl, [s]));
  _readtoken;
  if Token.TokenID in [id_record, id_class] then
    getclassdef(s)
  else
    Error(SErronly_class);
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getvartype;
Begin
  _readtoken;
End;

{-----------------------------------------------------------}

function _makevarid(var spoint : integer; IsGlobal : boolean; var StaticVarCount : integer) : integer;
begin
  result := spoint;
  if IsGlobal then
    begin
      inc(StaticVarCount);
      inc(result, MaxStackSize * 2);
    end
  else
    inc(spoint);
end;

{-----------------------------------------------------------}

function THalCompiler.AddVars(const AName: string; ID: integer) : integer;
begin
  Result := Variables.additem(IdentPrefix + AName, ID);
end;

{-----------------------------------------------------------}

procedure THalCompiler.getmyvariables(b: boolean);

  procedure dotsexpected;
  begin
    with fParser do
      if not IsTokenChar('.') then
        ErrSymbolExpectedButFound('..', TokenString);
  end;

var
  vlist   : TList;
  blist   : TList;

  function addbound : integer;
  var
    IsConst : boolean;
    cvalue  : Variant;
  begin
    iExpression2(IsConst, cvalue, true);
    CheckConst(IsConst);
    result := 0;
    try
      result := cvalue;
    except
      Error(SErrOrdinalTypeExpected);
    end;
    blist.Add(pointer(result));
  end;

var
  i : integer;
  vitem : TIdentListItem;
  lowbound : integer;
  highbound : integer;
begin
  with fParser do
    begin
      if Token <> tokSymbol then
        ExpectID(idIdentifier, 'Variable name'); //don't resource

       vlist := TList.Create;
      blist := TList.Create;
      try
        repeat
          vlist.Clear;
          blist.Clear;
          while not (ParserEOF or IsTokenChar(':')) do
            begin
              if b and (TDelphiRunner(FRunner).NamedItems.IndexOf(TokenString) < 0) then
                begin
                  vlist.Add(AddVariable(TokenString, _makevarid(spoint, fGlobalVars, StaticVarCount)));
                  inc(spoint);
                end;

              NextValidToken;
              if TokenString = ',' then
                NextValidToken
              else if IsTokenChar(';') then
                break;
            end;

            if not IsTokenChar(';') then
              begin
                _readtoken; //vartype

                if IsTokenResWord(ID_ARRAY) then
                  begin
                    NextValidToken;
                    if not IsTokenChar('[') then
                      ErrSymbolExpectedButFound('[', TokenString);

                    repeat
                      lowbound := addbound;

                      NextValidToken;
                      dotsexpected;
                      NextToken;
                      dotsexpected;
                      highbound := addbound;
                      if lowbound > highbound then
                        Error(SErrLowBoundExceedsHighBound);
                      NextValidToken;
                      if IsTokenChar(',') then
                        continue
                      else if IsTokenChar(']') then
                        break
                      else
                        ErrSymbolExpectedButFound(']', TokenString);
                    until false;
                  end;

                if blist.Count > 0 then
                  for i := vlist.Count - 1 downto 0 do
                    begin
                      vitem := TIdentListItem(vlist.list[i]);
                      with vitem do
                        begin
                          if Bounds = nil then
                            Bounds := TList.Create;

                          CopyList(blist, Bounds);
                          farrays.Add(vitem);
                        end;
                    end;

                if self.NextTokenID = ID_OF then
                  begin
                    NextToken;
                    NextValidToken;
                  end;

                GetDelimiter;
              end;

          while IsTokenChar(';') do
            NextValidToken;
        until ParserEOF or (Token = tokResWord);
      finally
        vlist.Free;
        blist.Free;
      end;
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler._mkcreatearray(item : TIdentListItem);
begin
  putcode(ocCreateArray, item.Address, item.Bounds.Count div 2);
  putlisttocodes(item.Bounds);
end;

{-----------------------------------------------------------}

procedure THalCompiler.CheckNotEOF;
begin
  if fParser.ParserEOF then
    Error(SErrUnexpectedEOF);
end;

{-----------------------------------------------------------}

procedure THalCompiler.getprocbody(i: integer);
var
  oidentpref : String;
  l1         : integer;
  pItem      : TIdentListItem;
  savespoint : integer;
  Enteritem  : TProgItem;
  procname   : string;
  FirstArray : integer;
  arritem    : TIdentListItem;
  ai         : integer;
begin
  if NextTokenID = id_forward then
    begin
      _readtoken;
      getdelimiter;
      exit;
    end;

  savespoint := spoint;
  with Variables do
    begin
      procname := strings[i];
      pItem := TIdentListItem(Objects[i]);
    end;

  oidentpref := identprefix;
//  spoint := ord(varbyname(procname + coprocresult, im));
  spoint := 0;
  maxspoint := 0;

  StartUseStack;

  identprefix := procname + '.';

  fGlobalVars := false;
  FirstArray := fArrays.Count;

  while fParser.IsTokenChar(';') do
    _ReadToken;

  CheckNotEOF;

  if fParser.Token <> tokResWord then
    Error(SErrUnknownDirective + ' : ' + Token.stValue);

  getdeclarations;
  fGlobalVars := true;

  l1 := pItem.Address;
  PlaceLabelHere(l1);
  IDLabels.SetReference(l1);
  EnterItem := putcode(ocEnterProc, 0, 0);

  for ai := FirstArray to farrays.Count - 1 do
    begin
      arritem := TIdentListItem(fArrays[ai]);
      _mkcreatearray(arritem);
      FreeObject(arritem.Bounds,arritem.Bounds); // no longer required
    end;

  fArrays.Count := FirstArray;

  fEnterProcs.AddObject(procname, TObject(prog.count - 1));
  getoperatorblock(True);
  getdelimiter;
  identprefix := oidentpref;

  StopUseStack;

//  EnterItem.A := maxspoint;
  EnterItem.A := spoint;
  EnterItem.B := i;
  putcode(ocreturn, 0, 0);
  spoint := savespoint;
end;

{-----------------------------------------------------------}

procedure THalCompiler.CheckConst(IsConst : boolean);
begin
  if not IsConst then
    Error(SErrConstantExpected);
end;

{-----------------------------------------------------------}

procedure THalCompiler.getconst;
var
  cname : string;
  cvalue : variant;
  IsConst : boolean;
begin
  with fParser do
    begin
      cname := TokenString;
      NextValidToken;

      if IsTokenChar(':') then
        self.Error(SErrTypedConst)
      else if IsTokenChar('=') then
        begin
          iExpression2(IsConst, cvalue, true);
          CheckConst(IsConst);
          fDeclConsts.AddConst(cname, cvalue)
        end
      else
        ErrSymbolExpected('=');
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getconsts;
begin
  with fParser do
    begin
      NextValidToken; // skip const
      repeat
        getconst;
        _readtoken;
        while IsTokenChar(';') do
          _readtoken;
      until ParserEOF or (Token = tokResWord);
  end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getuses;
begin
  repeat
    getidentifier;
    _readtoken;
  until Token.TokenID <> idComma;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getlabel;
var
  s : string;
  i : integer;
begin
  while not fParser.ParserEOF do
    begin
      ExpectNextID(idIdentifier, 'Label name'); //don't resource
      S := Token.stValue;
      if labels.idbyname(s, i) then
        Error(Format(SErrlabel_already, [s]));
      labels.additem(s, IDLabels.newitem);
      _readtoken;
      case Token.TokenID of
        idDelimiter : exit;
        idComma : ;
      else
        Error(Format(SErrOrExpected,[''',''', ''';''']));   //don't resource
      end;
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetDeclarations;
begin
  with fParser do
    while not ParserEOF do
      begin
        if IsTokenChar(';') then
          begin
            self.Token := self.ReadToken;
            continue;
          end;

        if Token = tokResWord then
          case ResWordID of
            ID_CONST, ID_RESOURCESTRING : getconsts;

            ID_BEGIN, ID_END : exit;

            ID_FUNCTION, ID_PROCEDURE : getprocbody(getprocdef(true));

            ID_INTERFACE, ID_IMPLEMENTATION : NextToken;

            ID_LABEL : getlabel;

            ID_TYPE : if self.NextTokenID = idIdentifier then
                        begin
                          while self.NextTokenID = ididentifier do
                            gettypeidentifier;
                        end
                      else
                        ErrorFmt(SErrExpectedButFound, [SIdentifier, TokenString]);

            ID_THREADVAR, ID_VAR : begin
                                     NextValidToken;
                                     getmyvariables(true);
                                   end;

            ID_USES : getuses;

          else
            Error(SErrdeclpart);
          end
        else
          self.Token := self.ReadToken;
      end;
end;

{-----------------------------------------------------------}

Procedure THalCompiler.getoperatorcoma;
Begin
  if getoperator then
    with NextToken do
      If (TokenID = iddelimiter) or
         ((TokenID <> id2points) and not (TokenID in [id_end, id_until])) then
      getdelimiter;
End;

{-----------------------------------------------------------}

procedure THalCompiler.putinternalgoto(dest : integer);
var
  item : TProgItem;
begin
  item := putcode(ocInternalGoto, dest, 0);
  fGotos.Add(item);
  fRefs.Add(@(item.a));
end;

{-----------------------------------------------------------}

procedure THalCompiler.putgoto(dest : integer);
var
  item : TProgItem;
begin
  item := putcode(ocgoto, dest, 0);
  fGotos.Add(item);
  fRefs.Add(@(item.a));
end;

{-----------------------------------------------------------}

procedure THalCompiler.putif(condition, dest : integer);
begin
  fRefs.Add(@(putcode(ocif, condition, dest).b));
end;

{-----------------------------------------------------------}

Procedure THalCompiler.getwhileoperator;
var
  l2 : integer;
  l1 : integer;
Begin
  with IDLabels do
    begin
      l1 := ContinueID;
      l2 := BreakID;
      ContinueID := NewReferencedItem;
      PlaceLabelHere(ContinueID);
      BreakID := NewReferencedItem;
      _readtoken;
      StartUseStack;
      putif(iexpression, BreakID);
      StopUseStack;
      getDo;
      getoperator;
      putgoto(ContinueID);
      PlaceLabelHere(BreakID);
      ContinueID:=l1;
      BreakID:=l2;
    end;
End;

{-----------------------------------------------------------}

Procedure THalCompiler.getrepeatoperator;
var
  l0 : integer;
  l1 : integer;
  l2 : integer;
Begin
  _readtoken;
  with IDLabels do
    begin
      l0 := NewReferencedItem;
      PlaceLabelHere(l0);
      l1 := ContinueID;
      l2 := BreakID;
      ContinueID := NewReferencedItem;
      BreakID := NewReferencedItem;
    end;

  While (NextTokenID <> id_until) and (NextTokenID <> idendoffile) do
    getoperatorcoma;

  ExpectNextID(id_until, 'Until'); //don't resource

  with IDLabels do
    begin
      PlaceLabelHere(ContinueID);
      StartUseStack;
      putif(iexpression, l0); // until condition
      StopUseStack;
      PlaceLabelHere(BreakID);
      ContinueID := l1;
      BreakID := l2;
    end;
End;

{-----------------------------------------------------------}

procedure THalCompiler.getforoperator;
var
    l, l0, l2, l1, vid : integer;
    ident: tidentlistitem;
    _pc : integer;
    _sp : integer;
    opbase : integer;
    forlimit : integer;
    checklabel : integer;
begin
  _readtoken;
  ExpectNextID(ididentifier, 'Variable name'); //don't resource

  if not varbyname(token.stValue, ident) then
    Error(Format(SErrvar_NotDef, [token.stValue]));

  vid := ident.Address;

  ExpectNextID(id2points, ':');
  ExpectNextID(idequal, '=');

  GetAssignment(ident);

  with IDLabels do
    begin
      l1 := ContinueID;
      l2 := BreakID;
      l0 := NewReferencedItem;
      ContinueID := NewReferencedItem;
      BreakID := NewReferencedItem;
      checklabel := NewReferencedItem;
    end;

  PlaceLabelHere(l0);
  _readtoken;
  l := token.TokenID;

  if not (l in [id_to, id_downto]) then
    Error(Format(SErrOrExpected,['TO','DOWNTO'])); //don't resource

  _pc := prog.count;
  _sp := spoint;

  forlimit := iexpression;

  //opt: mov       tmp, b -> ifGreater a, b
  //     ifGreater a, tmp
  opbase := 0;

  if (_pc = prog.count - 1) then
    with TProgItem(prog.Items[_pc]) do
      if (a = forlimit) and ({(opcode = ocMov) or }(opcode = ocLoadIntConst)) then
        begin
          //if opcode = ocLoadIntConst then
            opbase := IntOpsBase;
          forlimit := b;
          spoint := _sp;
          Free;
        end;

  getDo;

  putgoto(checklabel);

  PlaceLabelHere(l0);

  getoperator;

  PlaceLabelHere(IDLabels.ContinueID);

  if l = id_to then
    putcode(ocincvar, vid, 0)
  else
    putcode(ocdecvar, vid, 0);

  PlaceLabelHere(checklabel);

  if l = id_to then
    putcode(opbase + ocIfLessEqual, vid, forlimit)
  else
    putcode(opbase + ocIfGreaterEqual, vid, forlimit);

  putinternalgoto(l0);

  with IDLabels do
    begin
      PlaceLabelHere(BreakID);
      ContinueID := l1;
      BreakID := l2;
    end;
end;

{-----------------------------------------------------------}

function THalCompiler.OptimizeIfCondition(OldPC, OldSP, IfLabel : integer) : boolean;
//opt:
// mov tmp, V      ->  jcmp V, xxx
// cmp tmp, xxx
// if  tmp
var
  item1 : TProgItem;
  item2 : TProgItem;
  opcode2 : integer;
  opbase2 : integer;
begin
  result := false;

  if prog.count <> OldPC + 2 then
    exit;

  item1 := TProgItem(prog.Items[OldPC]);
  item2 := TProgItem(prog.Items[OldPC + 1]);
  opcode2 := Item2.OpCode;
  if opcode2 >= ConstOpsBase then
    begin
      opbase2 := ConstOpsBase;
      dec(opcode2, ConstOpsBase);
    end
  else
    opbase2 := 0;

  with Item1 do
    if (OpCode = ocMov) and (opcode2 in CmpOps) then
      begin
        OpCode := InvertIfs[opcode2] + opBase2;
        a := b;
        b := Item2.b;

        Item2.OpCode := ocInternalGoto;
        Item2.A := IfLabel;
        fGotos.Add(item2);
        fRefs.Add(@(item2.a));
        spoint := OldSP;

        result := true;
      end;
end;

{-----------------------------------------------------------}

Procedure THalCompiler.getifoperator;
Var
  a: integer;
  l1  : integer;
  l2  : integer;
  _sp : integer;
  _pc : integer;
Begin
  _readtoken;
  l1 := IDLabels.NewReferencedItem;

  _sp := spoint;
  _pc := prog.count;
  StartUseStack;
  a := iexpression;
  if not OptimizeIfCondition(_pc, _sp, l1) then
    putif(a, l1);

  StopUseStack;

  ExpectNextID(id_then, 'Then'); //don't resource

  getoperator;

  with NextToken do
    if (TokenID = iddelimiter) or (TokenID = id_End) then
      begin
        PlaceLabelHere(l1);
        exit;
      end;

  ExpectNextID(id_else, 'Else'); //don't resource
  l2 := IDLabels.NewReferencedItem;
  putInternalGoto(l2);
  PlaceLabelHere(l1);
  getoperator;
  PlaceLabelHere(l2);
End;

{-----------------------------------------------------------}

procedure THalCompiler.getDo;
begin
  ExpectNextID(id_do, 'Do'); //don't resource
end;

{-----------------------------------------------------------}

procedure THalCompiler.getwith;
var
  l0 : integer;
  l1 : integer;
begin
  repeat
    _readtoken;
    StartUseStack;
    putcode(ocAddWith, iexpression, 0);
    StopUseStack;
  until NextTokenID <> idComma;

  getDo;

  l0 := IDLabels.NewReferencedItem;
  l1 := IDLabels.NewReferencedItem;

  fRefs.Add(@(putcode(ocTry, l0, 0).a));

  getoperator;

  putcode(ocNormalFinally, 0, 0);
  PlaceLabelHere(l0);
  putcode(ocEndTry, 0, 0);
  putcode(ocRemoveWith, 0, 0);
  putcode(ocEndFinally, 0, 0);
  PlaceLabelHere(l1);
end;

{-----------------------------------------------------------}

procedure THalCompiler.gettry;
var
  l0 : integer;
  l1 : integer;
  tryitem : TProgItem;
  isExcept : boolean;
begin
  _readtoken;

  l0 := IDLabels.NewReferencedItem;
  l1 := IDLabels.NewReferencedItem;

  tryitem := putcode(ocTry, l0, 0);
  fRefs.Add(@(tryitem.a));

  while (NextTokenID <> idEndOFFile) and not (NextTokenID in [id_end, id_finally, id_except]) do
    getoperatorcoma;

  _readtoken;

  if not (token.TokenID in [id_except, id_finally]) then
    ErrSymbolExpected('EXCEPT or FINALLY'); //don't resource

  isExcept := token.TokenID = id_except;

  tryitem.B := ord(isExcept);

  if isExcept then
    begin
      putcode(ocEndTry, 0, 0);
      putgoto(l1);
    end
  else
    putcode(ocNormalFinally, 0, 0);

  PlaceLabelHere(l0);

  if not IsExcept then
    putcode(ocEndTry, 0, 0);

  while true do
    begin
      with NextToken do
        if (TokenID = idEndOFFile) or (TokenID = id_end) then
          break;

      getoperatorcoma;
    end;

  ExpectNextID(id_end, 'End'); //don't resource

  if not isExcept then
    putcode(ocEndFinally, 0, 0);

  PlaceLabelHere(l1);
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetExit;
begin
  _readtoken;
  putcode(ocReturn,0,0);
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetRaise;
var
  RaiseParam : integer;
begin
  _readtoken; // raise

  StartUseStack;
  if NextTokenID = idOpenBracket then
    RaiseParam := iexpression
  else
    RaiseParam := -1;

  StopUseStack;
  putcode(ocRaise, RaiseParam, 0);
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetBreak;
begin
  _readtoken;

  if IDLabels.BreakID = -1 then
    Error(SErrMisplacedBreak);

  putgoto(IDLabels.BreakID);
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetContinue;
begin
  _readtoken;

  if IDLabels.ContinueID = -1 then
    Error(SErrMisplacedContinue);

  putgoto(IDLabels.ContinueID);
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetGoto;
var
  s : String;
  i : integer;
begin
  _readtoken;
  ExpectNextID(idIdentifier, 'Label name'); //don't resource

  S := Token.stValue;

  if not Labels.IDByName(s, i) then
    Error(Format(SErrlab_notdef, [s]));

  IDLabels.SetReference(i);
  putgoto(i);
end;

{-----------------------------------------------------------}

procedure THalCompiler.getassignment(Ident : TIdentListItem);
var
  oldcount : integer;
  i        : integer;
  iaddr    : integer;
begin
  oldcount := prog.count;
  StartUseStack;
  try
    i := iexpression;
    iaddr := ident.Address;

    if prog.count = oldcount + 1 then                        //opt: mov tmp, val -> mov xxx, val
      with TProgItem(prog.Items[oldcount]) do                //     mov xxx, tmp
        begin
          if opcode in [ocMov, ocLoadConst, ocLoadIntConst] then
            begin
              a := iaddr;
              dec(spoint);
              exit;
            end
        end
    else if prog.count = oldcount + 2 then    //opt: mov tmp, a    -> op a, xxx
                                              //     op  tmp, xxx
      with TProgItem(prog.Items[oldcount]) do //     mov a, tmp
        if (opCode = ocMov) and (b = iaddr) and (a = spoint - 1) and (i = spoint - 1) then
          begin
            opCode := TProgItem(prog.Items[oldcount + 1]).opCode;
            a := iaddr;
            b := TProgItem(prog.Items[oldcount + 1]).b;
            TProgItem(prog.Items[oldcount + 1]).Free;
            dec(spoint);
            exit;
          end;

    putcode(ocmov, iaddr, i);
  finally
    StopUseStack;
  end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetCaseOperator;
var
  expr    : integer;
  lend    : integer;
  lcode   : integer;
  lnext   : integer;
  tokid   : integer;
  const1  : integer;
  const2  : integer;
  cvalue1 : variant;
  cvalue2 : variant;
  IsConst : boolean;

begin
  _readtoken;
  lend := IDLabels.NewReferencedItem;
  expr := iexpression;
  ExpectNextID(id_of, 'OF'); //don't resource

  repeat
    lcode := IDLabels.NewReferencedItem;
    lnext := IDLabels.NewReferencedItem;

    repeat
      fIgnoreAssignment := true;
      try
        iExpression2(IsConst, cvalue1, true);
      finally
        fIgnoreAssignment := false;
      end;

      const1 := Consts.newitem(cValue1);

      if not IsConst then
        Error(SErrConstantExpected);

      _readtoken;

      tokid := Token.TokenID;

      if tokid = idPoint then
        begin
          // cvalue1..cvalue2 :
          _readtoken;
          ExpectID(idPoint, '.');
          fIgnoreAssignment := true;
          try
            iExpression2(IsConst, cvalue2, true);
          finally
            fIgnoreAssignment := false;
          end;

          if not IsConst then
            Error(SErrConstantExpected);

          const2 := Consts.newitem(cValue2);

          if cvalue2 < cvalue1 then
            Error(SErrLowBoundExceedsHighBound);

          putcode(ocIfLessConst, expr, const1);
          putinternalgoto(lnext);
          putcode(ocIfLessEqualConst, expr, const2);
          putinternalgoto(lcode);
          _readtoken;
          tokid := Token.TokenID;
        end;

      if (TokID = id2Points) or (TokID = idComma) then
        begin
          putcode(ocIfEqualConst, expr, const1);
          putinternalgoto(lcode);
          if TokID = idComma then
            NextToken
          else
            begin
              putinternalgoto(lnext);
              PlaceLabelHere(lcode);
              getoperator;
              putinternalgoto(lend);
              if NextTokenID = idDelimiter then
                getdelimiter;
              PlaceLabelHere(lnext);
              break;
            end;
        end
      else
        Error(Format(SErrOrExpected,[',', ':']));
    until false;

    if NextTokenID = id_else then
      begin
        _readtoken;
        getoperator;
        if NextTokenID = idDelimiter then
          getdelimiter;
        break;
      end;
  until NextTokenID = id_end;

  _readtoken;
  ExpectID(id_end, 'END'); // don't resource
  PlaceLabelHere(lend);
end;

{-----------------------------------------------------------}

type
  TMParser = class(TCustomDCParser);


procedure THalCompiler.getOut;
var
  sptr : pchar;
  s    : string;
begin
  _readtoken;
  with TMParser(fParser) do
    begin
      sptr := SourcePtr;
      while ((sptr^ >= #32) or (sptr^ = #9)) do
        inc(sptr);

      SetString(s, SourcePtr, sptr - SourcePtr);
      FSourcePtr := sptr;
      putcode(ocOut, AddStringConst(s), 0);
    end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.putlistToCodes(list : TList);
var
  i : integer;
begin
  fCodeCount := 0;
  for i := 0 to list.Count - 1 do
    putsinglecode(integer(list[i]));
end;

{-----------------------------------------------------------}

const
  ipWrite      = 0;
  ipWriteln    = ipWrite      + 1;
  ipEvaluate   = ipWriteln    + 1;
  ipUseUnit    = ipEvaluate   + 1;
  ipUnloadUnit = ipUseUnit    + 1;
  ipCauseBreak = ipUnloadUnit + 1;
  ipInc        = ipCauseBreak + 1;
  ipDec        = ipInc        + 1;
  ipRead       = ipDec        + 1;
  ipReadln     = ipRead       + 1;

function GetInternalProcCode(const s : string) : integer;
begin
  if CompareText(s, 'Evaluate') = 0 then
    result := ipEvaluate
  else if CompareText(s, 'UseUnit') = 0 then
    result := ipUseUnit
  else if CompareText(s, 'UnloadUnit') = 0 then
    result := ipUnloadUnit
  else if CompareText(s, 'CauseBreak') = 0 then
    result := ipCauseBreak
  else if CompareText(s, 'Inc') = 0 then
    result := ipInc
  else if CompareText(s, 'Dec') = 0 then
    result := ipDec
  else
    result := -1;
end;

{-----------------------------------------------------------}

function THalCompiler.ProcessInternalProc(const s : string) : boolean;
const
  opcodes1 : array[ipWrite..ipUnloadUnit] of integer = (ocWrite, ocWriteln, ocEvaluate, ocUseUnit, ocUnloadUnit);
  opcodes2 : array[ipInc..ipReadLn] of integer = (ocIncVar, ocDecVar, ocRead, ocReadLn);
  opcodes3 : array[ipInc..ipDec] of integer = (ocIncVar2, ocDecVar2);
var
  ipcode : integer;
  ivar   : integer;
begin
  result := true;
  ipcode := GetInternalProcCode(s);
  case ipcode of
    ipWrite, ipWriteln, ipEvaluate, ipUseUnit, ipUnloadUnit : putcode(opcodes1[ipcode], iExpression, 0);

    ipCauseBreak : putcode(ocCauseBreak, 0, 0);

    ipInc, ipDec, ipRead, ipReadLn : begin
                     ExpectNextID(idOpenBracket, '('); //don't resource
                     ivar := getvar;

                     if NextTokenID = idComma then
                       begin
                         ReadToken; // ,
                         putcode(opcodes3[ipcode], ivar, iExpression);
                       end
                     else
                       putcode(opcodes2[ipcode], ivar, 0);

                     ExpectNextID(idCloseBracket, ')'); //don't resource
                   end;
  else
    result := false;
  end;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getoperatorProcessPointOrBracket(id : integer);
var
  nextid : integer;
  newval : integer;
  indexlist : TList;
begin
  while true do
    begin
      nextid := NextTokenID;
      if nextid = idpoint then
        begin
          putcode(ocPushIDisp, id, 0);
          _readtoken;
          _readtoken;
          ProcessProcIdent(ocScriptDispatch);
          exit;
        end
      else if nextid = idsqopenbracket then
        begin
          ReadToken;
          indexlist := TList.Create;
          try
            repeat
              indexlist.Add(pointer(iExpression));
              if NextTokenID = idComma then
                ReadToken
              else
                break;
            until false;

            ExpectNextID(idsqclosebracket, ']');
            FCodeCount := 0;
            if (NextTokenID = id2points) then
              begin
                _readtoken;
                ExpectNextID(idEqual, '=');
                newval := iExpression;
                FCodeCount := 0;
                if indexlist.count = 1 then
                  putcode(ocSetItem, integer(indexlist[0]), id)
                else
                  begin
                    putcode(ocSetItem2, indexlist.Count, id);
                    putlisttocodes(indexlist);
                  end;

                putsinglecode(newval);
                exit;
              end
            else
              begin
                putcode(ocmov, spoint, id);
                id := ReturnSPoint;
                if indexlist.count = 1 then
                  putcode(ocGetItem, integer(indexlist[0]), id)
                else
                  begin
                    putcode(ocGetItem2, indexlist.count, id);
                    putlisttocodes(indexlist);
                  end;
                id := integer(indexlist[0]);
              end;
          finally
            indexlist.Free;
          end;
        end
      else
        break;
    end;
end;

{-----------------------------------------------------------}

function THalCompiler.getoperator : boolean;
var
  l : integer;
  i : integer;
  s : String;
  ident : TIdentListItem;
  id    : integer;
  typecast : boolean;

{
  if NextTokenID = idPoint then
    begin
      _readtoken;
      putcode(ocPushIDisp, id, 0);
      _readtoken;
      ProcessProcIdent(ocScriptDispatch);
    end;
}

begin
  l := NextTokenID;
  result := true;
  Case l of
    id_begin : begin
                 _readtoken;
                 getoperatorblock(True);
               end;

    id_break : GetBreak;

    id_case : GetCaseOperator;

    id_continue : GetContinue;

    id_exit : GetExit;

    id_for : GetForOperator;

    id_Goto : GetGoto;

    id_if : getifoperator;

    id_out : begin
               getout;
               result := false;
             end;

    id_Raise : getraise;

    id_repeat : getrepeatoperator;

    id_try : gettry;

    id_while : getwhileoperator;

    id_with : getwith;

    idIdentifier :
      Begin
        _readtoken;
        s := Token.stValue;

        if ProcessInternalProc(s) then
          exit;

        typecast := IsTypeCast(s);

        if (NextTokenID = id2points) then
          begin
            if Labels.IDByName(S, i) then
              begin
                _readtoken;
                LabelDispatch(S);
                result := false;
              end
            else if varbyname(S, ident) and (ident.identtype = tivariable) then
              begin
                _readtoken; //:
                ExpectNextID(idequal, '=');
                getassignment(Ident);
              end
            else
              ProcessProcIdent(ocScriptInvoke);
          end
        else if typecast or varByname(S, ident) then
          begin
            if typecast then
              id := iExpression
            else if ident.identtype = tivariable then
              id := ident.Address
            else
              id := getinternalfun(s, ident);

            if NextTokenID = idOpenBracket then
              ProcessExternalFunction(id)
            else
              getoperatorProcessPointOrBracket(id);
          end
        else
          ProcessProcIdent(ocScriptInvoke);
      end;

    idDelimiter : ;


  Else
    Error(Format(SErrunkn_id, [nexttoken.stValue]));
  End;
end;

{-----------------------------------------------------------}

procedure THalCompiler.getoperatorblock(ProcessEnd:boolean);
begin
  with fParser do
    if ParserEOF or IsTokenResWord(ID_END) then
      exit
    else
      if not IsTokenResWord(ID_BEGIN) then
        ErrSymbolExpected('begin'); //don't resource

  while true do
    begin
      with nexttoken do
        if (TokenID = id_end) or (TokenID = idEndOFFile) then
          break;

        getoperatorcoma;
    end;

  _readtoken;

  if token.TokenID <> id_end then
    ErrSymbolExpected('End'); //don't resource
end;

{-----------------------------------------------------------}

procedure THalCompiler.GetMainProc;
var
  idx : integer;
begin
  idx := AddVars('', IDLabels.newitem);
  with TIdentListItem(Variables.Objects[idx]) do
    IdentType := tiprocedure;
end;

{-----------------------------------------------------------}

procedure THalCompiler.compileprogram;
var
  i  : integer;
  ai : integer;
  EnterItem : TProgItem;
  arritem    : TIdentListItem;
begin
  StaticVarCount := 0;
  fGlobalVars := true;
  i := IDLabels.NewReferencedItem;
  putgoto(i);
  getprogramname;
  GetMainProc;
  getdeclarations;
  PlaceLabelHere(i);

  EnterItem := putcode(ocEnterProc, 0, 0);

  getoperatorblock(False);
  EnterItem.A := spoint + 1;
  EnterItem.B := -1;
  putcode(ochalt, 0, 0);

  fInitializePos := prog.count;
  putcode(ocEnterProc, 0, 0);
  for ai := 0 to farrays.Count - 1 do
    begin
      arritem := TIdentListItem(fArrays[ai]);
      _mkcreatearray(arritem);
      FreeObject(arritem.Bounds,arritem.Bounds); // no longer required
    end;
  fArrays.Count := 0;
  putcode(ocHalt, 0, 0);  
end;

{-----------------------------------------------------------------------}

procedure THalCompiler.LinkProgram;
var
  i : integer;
  p : PInteger;
begin
  with fEnterProcs do
    for i := 0 to Count - 1 do
      Variables.Find(Strings[i], TProgItem(prog.Items[integer(Objects[i])]).b);

  with fRefs do
    for i := 0 to Count - 1 do
      begin
        p := List[i];
        p^ := TIDLabelItem(idlabels.items[p^]).Place;
      end;

  for i := 0 to Variables.Count - 1 do
    with TIdentListItem(Variables.Objects[i]) do
      if IdentType in [tiProcedure, tiFunction] then
        Address := TIDLabelItem(idlabels.items[Address]).Place;
end;

{-----------------------------------------------------------------------}

procedure THalCompiler.OptimizeProgram;
var
  i : integer;
  DestItem : TProgItem;
begin
  with fGotos do
    for i := 0 to Count - 1 do
      with TProgItem(fGotos[i]) do
        begin
          DestItem := TProgItem(Prog.Items[a]);
          if DestItem.OpCode in [ocGoto, ocInternalGoto] then //opt: jmp @l      -> jmp @l2
            a := DestItem.a                                   //     ...
                                                              //     @l: jmp @l2

          else if DestItem.OpCode = ocReturn then             //opt: jmp @l      -> ret
            OpCode := ocReturn                                //     ...
                                                              //     @l: ret

          else if a = Index + 1 then                          //opt: jmp @l      -> nop
            OpCode := ocNop                                   //     @l:
        end;
end;

{-----------------------------------------------------------------------}

procedure THalCompiler.writeprogram;

var
  CodeWriter : TWriter;
{-----------}

  procedure writeconsts;
  var
    i: integer;
    {v: variant;}
  begin
      CodeWriter.WriteInteger(consts.count);
      for i := 0 to consts.count - 1 do
        WriteVariant(CodeWriter, tconstitem(consts.items[i]).data);
(*
    outint(fout, consts.count);
    for i := 0 to consts.count - 1 do
      begin
        v := tconstitem(consts.items[i]).data;
        with TVarData(v) do
          case vType of
            varEmpty : OutByte(fout, wEmpty);

            varNULL : OutByte(fout, wNULL);

            varSmallint : OutInteger(fout, vSmallInt);

            varInteger : OutInteger(fout, vInteger);

            varSingle : OutSingle(fout, VSingle);

            varDouble: OutDouble(fout, VDouble);

            varBoolean: if TVarData(v).vBoolean then
                          OutByte(fout, wTrue)
                        else
                          OutByte(fout, wFalse);

            varbyte : OutInt(fout, vByte);

            varstring: OutString(fout, v);
          else
            Error(SErrunexp_writer);
          end;
      end;
*)
  end;

{-----------}

  procedure writestringconsts;
  var
    i : integer;
  begin
    with StringConsts do
      begin
        CodeWriter.WriteInteger(Count);
        for i := 0 to Count - 1 do
          CodeWriter.WriteString(Strings[i]);
      end;
  end;

{-----------}

  procedure writeprog;
  var
    i : integer;
  begin
    CodeWriter.WriteInteger(prog.count);
    for i := 0 to prog.count - 1 do
      with tprogitem(prog.items[i]) do
        begin
          CodeWriter.Write(a, sizeof(integer));
          CodeWriter.Write(b, sizeof(integer));
          CodeWriter.Write(opcode, sizeof(integer));
          CodeWriter.Write(linepos, sizeof(integer));
          CodeWriter.Write(charpos, sizeof(integer));
    	end;
  end;

{-----------}

begin
  CodeWriter := TWriter.Create(fout, 4096);
  try
    writeconsts;
    writestringconsts;
    writeprog;
    CodeWriter.WriteInteger(StaticVarCount);
    CodeWriter.WriteInteger(fInitializePos);
  finally
    CodeWriter.Free;
  end;
end;

{-----------------------------------------------------------}

Constructor THalCompiler.Create(const ScriptStr:String; afout: TStream;Runner:TScriptRunner);
Begin
  Inherited Create;
  FRunner := Runner;

  fArrays := TList.Create;
  
  Labels := TIdentList.Create;
  Variables := TIdentList.Create;
  Variables.Sorted := False;
  Consts := TConstList.Create(tconstitem);
  StringConsts := TStringList.Create;
  IDLabels := TIDLabelList.Create(tidlabelitem);
  IDLabels.BreakID := -1;
  IDLabels.ContinueID := -1;
  Prog := TCollection.Create(tprogitem);
  fDeclConsts := TDeclConstList.Create;

  fout := afout;
  if afout <> nil then
    begin
      FParser:=TDCIncludeParser.Create(nil);
      FParser.Defines.Add('DCPASCAL');
      FParser.LinePtr:=PChar(ScriptStr);
    end;
End;

{-----------------------------------------------------------}

Destructor THalCompiler.Destroy;
Begin
  fArrays.Free;
  Variables.Free;
  Consts.Free;
  StringConsts.Free;
  Labels.Free;
  IDLabels.Free;
  Prog.Free;
  FParser.Free;
  fDeclConsts.Free;
  inherited;
End;

{-----------------------------------------------------------}

procedure THalCompiler.CheckLabels;
var
  i : integer;
begin
  with IDLabels do
    for i := 0 to count - 1 do
      with tidlabelitem(items[i]) do
        if referenced and not exist then
          begin
            Error(SErrLabelNotSet);
            exit;
          end;
end;

{-----------------------------------------------------------}

function  THalCompiler.AddStringConst(const Value : string) : integer;
begin
  result := StringConsts.IndexOf(Value);
  if result < 0 then
    result := StringConsts.Add(Value);
end;

{-----------------------------------------------------------}

Procedure THalCompiler.compile;
Begin
  fEnterProcs := TStringList.Create;
  fRefs       := TList.Create;
  fGotos      := TList.Create;
  fspoints    := TIntStack.Create;
  fDeclaredClasses := CreateSortedStringList;
  try
    compileprogram;
    LinkProgram;
    OptimizeProgram;
  finally
    fEnterProcs.Free;
    fRefs.Free;
    fGotos.Free;
    fSpoints.Free;
    fDeclaredClasses.Free;
  end;

  CheckLabels;
  WriteProgram;
End;

{=======================================================}

type
  TBinProgState = class
    cpos      : integer;
    gpos      : integer;
    inlist    : PIntArray;
    insize    : integer;
    exlist    : PIntArray;
    exsize    : integer;
    clist     : PIntArray;
    csize     : integer;
    flist     : PIntArray;
    fsize     : integer;

    freason   : TFinallyReason;
  end;

procedure savelist(list : TList; var lsize : integer; var slist : PIntArray);
begin
  lsize := list.Count;
  if lsize > 0 then
    begin
      GetMem(slist, lsize * sizeof(pointer));
      Move(list.List^, slist^, lsize * sizeof(pointer));
      list.Clear;
    end;
end;

procedure restorelist(list : TList; var lsize : integer; var slist : PIntArray);
begin
  list.Count := lsize;
  if lsize > 0 then
    begin
      Move(slist^, list.List^, lsize * sizeof(pointer));
      FreeMem(slist);
    end;
end;

{***********************************************************}
{$IFDEF THREADSAFE}
function  TBinProgThreadVarList.Compare(Item1, Item2 : pointer) : integer;
begin
  result := integer(TBinProgThreadVars(Item1).fThreadID) - integer(TBinProgThreadVars(Item2).fThreadID);
end;

{-----------------------------------------------------------}

function TBinProgThreadVarList.CompareWithKey(Item, Key : pointer) : Integer;
begin
  result := integer(TBinProgThreadVars(Item).fThreadID) - integer(Key);
end;

{$ENDIF}
{-----------------------------------------------------------}


constructor TBinProgThreadVars.Create;
begin
  inherited;
  fThreadID    := GetCurrentThreadID;
  fdispatch    := TIntStack.Create;
  CallStack    := TIntStack.Create;
  fStacks      := TIntStack.Create;
  fWithObjects := TIntStack.Create;
  fExceptPos   := TIntStack.Create;
  fFinallyList := TIntStack.Create;
  fStack       := TVariantStack.Create;
  fFuncStack   := TStringList.Create;
  fErrorPos    := -1;
end;

{-----------------------------------------------------------}

destructor  TBinProgThreadVars.Destroy;
begin
  inherited;
  fdispatch.Free;
  CallStack.Free;
  fStacks.Free;
  fWithObjects.Free;
  fExceptPos.Free;
  fFinallyList.Free;
  fStack.Free;
  fFuncStack.Free;
end;

{***********************************************************}

{$IFDEF THREADSAFE}
function TBinProg.ThreadVars : TBinProgThreadVars;
var
  ThreadID : DWORD;
  i : integer;
begin
  ThreadID := GetCurrentThreadID;
  result := fMainThreadVars;
  if ThreadID <> MainThreadID then
    begin
      EnterCriticalSection(fTVarsLock);
      try
        i := fTVarsList.IndexOfKey(pointer(ThreadID));
        if i >= 0 then
          result := fTVarsList[i];
      finally
        LeaveCriticalSection(fTVarsLock);
      end;
    end;
end;
{$ENDIF}

function  TBinProg.SaveState : pointer;
var
  state : TBinProgState;
begin
  state := TBinProgState.Create;
  with state, ThreadVars do
    begin
      cpos := curpos;
      gpos := fGotoPos;
      fReason := fFinallyReason;

      savelist(fFinallyList, insize, inlist);
      savelist(fExceptPos, exsize, exlist);
      savelist(CallStack, csize, clist);
    end;
  result := state;
end;

{-----------------------------------------------------------}

procedure TBinProg.RestoreState(state : pointer);
begin
  with ThreadVars, TBinProgState(state) do
    begin
      curpos := cpos;
      fGotoPos := gpos;
      fFinallyReason := fReason;

      RestoreList(fFinallyList, insize, inlist);
      RestoreList(fExceptPos, exsize, exlist);
      RestoreList(CallStack, csize, clist);
    end;
  FreeMem(state);
end;

{-----------------------------------------------------------}

function  TBinProg.GetStackPointer : integer;
begin
  result := ThreadVars.fStack.Count;
end;

{-----------------------------------------------------------}

procedure TBinProg.Error(const s : string);
begin
  if FLoaded then
    with prog^[ThreadVars.Curpos] do
       RunnerError(Self, FRunner, S, LinePos, CharPos)
  else
    RunnerError(Self, FRunner, S, 0, 0);
end;

{-----------------------------------------------------------}

destructor TBinProg.Destroy;
var
  i : integer;
begin
  fDestroyed := true;
  fStop      := true;

  sConsts.Free;
  fMainThreadVars.Free;

  if StaticVars <> nil then
    begin
      for i := 0 to sVarCount - 1 do
        VarClear(StaticVars[i]);

      FreeMem(StaticVars);
    end;

  if assigned(prog) then
    freemem(prog);

  if assigned(fConsts) then
    begin
      for i := 0 to constsize - 1 do
        VarClear(fConsts^[i]);

      freemem(fConsts);
    end;

  fCompiledProg.Free;
  FreeMem(OpCodesAddr);
  fBinCodes.Free;
  {$IFDEF THREADSAFE}
  fTVarsList.Free;
  DeleteCriticalSection(fTVarsLock);
  {$ENDIF}
  inherited destroy;
end;

{-----------------------------------------------------------}

constructor TBinProg.Create(CodeStream : TStream; Runner : TDelphiRunner);
var
  CodeReader : TReader;
  
  procedure readconsts;
  var
    i  : integer;
    {b  : byte;}
    pv : POlevariant;
    {r  : TReader;}
  begin
//    constsize := getint(CodeStream);
    constsize := CodeReader.ReadInteger;
    getmem0(fConsts, constsize * sizeof(variant));
    pv := @(fConsts^[0]);
    for i := 0 to constsize - 1 do
      begin
        pv^ := ReadVariant(CodeReader);
{
        b := getbyte(CodeStream);
        case b of
          wInt8    : pv^ := getint8(CodeStream);
          wInt16   : pv^ := getint16(CodeStream);
          wInt32   : pv^ := getint32(CodeStream);
          wDouble  : pv^ := getdouble(CodeStream);
          wString  : pv^ := getstring(CodeStream);
          wEmpty   : pv^ := Unassigned;
          wNULL    : pv^ := Null;
          wTrue    : pv^ := True;
          wFalse   : pv^ := False;
          wSingle  : pv^ := getsingle(CodeStream);
          else
            Error(SErrUnknReaderType);
        end;
}
      inc(integer(pv), sizeof(OleVariant));
    end;
  end;

  procedure readstringconsts;
  var
    i : integer;
  begin
    i := CodeReader.ReadInteger;
    while i > 0 do
      begin
        sConsts.Add(CodeReader.ReadString);
        dec(i);
      end;
  end;

{--}

  procedure readprogram;
  begin
    progsize := CodeReader.ReadInteger;
    getmem(prog, progsize * sizeof(tbinprogitem));
    CodeReader.Read(Prog^, progsize * sizeof(tbinprogitem));
  end;

{--}

begin
  inherited create;

  LastLine := -1;
  {$IFDEF THREADSAFE}
  InitializeCriticalSection(FTVarsLock);
  fTVarsList := TBinProgThreadVarList.Create;
  {$ENDIF}
  fMainThreadVars := TBinProgThreadVars.Create;
  sConsts      := TStringList.Create;
  CodeStream.Position := 0;
  FRunner   := Runner;

  CodeReader := TReader.Create(CodeStream, 4096);
  try
    readconsts;
    readstringconsts;
    readprogram;
    sVarCount := CodeReader.ReadInteger;
    fInitializePos := CodeReader.ReadInteger;
  finally
    CodeReader.Free;
  end;

  if svarcount > 0 then
    GetMem0(StaticVars, svarcount * sizeof(OleVariant));

  FLoaded := true;

  fCompiledProg := TMemoryStream.Create;
  fCompiledProg.SetSize(CodeStream.Position);
  CodeStream.Position := 0;
  CodeStream.Read(fCompiledProg.Memory^, fCompiledProg.Size);

  fBinCodes := TMemoryStream.Create;
  {$IFDEF USECOMPILER}
  RealCompile;
  {$ENDIF}
  if Assigned(fRunner.OnExecuteLine) then
    fDebugging := true;
end;

{-----------------------------------------------------------}

function TBinProg.GetSingleCode : integer;
var
  cc : integer;
begin
  with ThreadVars do
    begin
      cc := fCodeCount;
      with prog^[curpos] do
        case cc of
          0 : result := opcode;
          1 : result := a;
        else
          result := b;
        end;

      if cc < 2 then
        inc(cc)
      else
        begin
          cc := 0;
          inc(curpos);
        end;

      fCodeCount := cc;
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg.FillParamsFromCode(Params : POleVariantArray; ParamCount : integer);
var
  j : integer;
  pparam     : POleVariant;
  pstack     : POleVariant;
begin
  with ThreadVars do
    begin
      j := ParamCount - 1;
      pparam := @(Params^[j]);
      while j >= 0 do
        begin
          pstack := fStack.Items(fBaseStackPointer + GetSingleCode);

          if TVarData(pStack^).vType = varByRef + varVariant then
            begin
              TVarData(pparam^).vType := varByRef + varVariant;
              TVarData(pparam^).vPointer := TVarData(pStack^).vPointer;
            end
          else
            pparam^ := pStack^;

          dec(j);
          dec(integer(pparam), sizeof(OleVariant));
        end;

      if FCodeCount <> 0 then
        inc(curpos);
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg.ClearParams(Params : POleVariantArray; ParamCount : integer);
var
  j : integer;
  pparam     : POleVariant;
begin
  j := ParamCount - 1;
  pparam := @(Params[j]);
  while j >= 0 do
    begin
      if TVarData(pparam^).vType <> varByRef + varVariant then
        VarClear(pparam^);
      dec(j);
      dec(integer(pparam), sizeof(OleVariant));
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg._ProcessProc(const AName : string; const Acode, StackPoint, ParamCount : integer; const InvKind : integer);
var
  i          : integer;
  Params     : POleVariantArray;
  paramssize : integer;
  FDisp      : IDispatch;
  V          : Variant;
  ExcepInfo  : TExcepInfo;
  Status     : TDCErrorStatus;
  disp       : IDispatch;
  wName      : PWideChar;
  Successful : boolean;
  pv         : POleVariant;

  _dispatch  : TIntStack;
  _stack     : TVariantStack;
  _bspointer : integer;
begin
  with ThreadVars do
    begin
      _dispatch := fdispatch;
      _stack    := fStack;
      _bspointer := fBaseStackPointer;
    end;
  Successful := false;
  params := nil;
  paramssize := ParamCount * sizeof(OleVariant);
  if paramssize <> 0 then
    GetMem0(Params, paramssize);

//  ExcepInfo.bstrSource := AName;

  try
    FillParamsFromCode(Params, ParamCount);
    Status := S_Ok;

    with FRunner do
      begin
        if (ACode in [ocScriptInvoke, ocScriptInvoke2]) or (_dispatch.Count = 0) then
          begin
            if NamedItems.Find(AName, i) then
              begin
                V := VarFromInterface(IDispatch(Pointer(NamedItems.Objects[i])));
                Successful := true;
              end
            else
              V := ProcessProcedureCall(AName, Params, ParamCount, InvKind, ExcepInfo, Status, Successful)
          end
        else
          begin
            FDisp := IDispatch(_dispatch.Pop);
            if fdisp <> nil then
              begin
                wName := DCStringToOleSt(AName);
                try
                  V := ProcessMethodCall(FDisp, wName, Params, ParamCount, InvKind, ExcepInfo, Status, Successful);
                finally
                  {$IFDEF WIN32}
                    SysFreeString(wName);
                  {$ENDIF}
                end;
                fdisp._Release;
              end;
          end;

        if fDestroyed then
          exit;

        if Acode <> ocDispAssign then
          begin
            pv := _stack.Items(_bspointer + StackPoint);
            if pv <> nil then
              pv^ := V;
          end;

        disp := DCVarToInterFace(V);

        if disp <> nil then
          disp._AddRef;

        _dispatch.Push(integer(disp));
    //    pointer(disp) := nil;

        if not (Successful or fStop) or (Status <> S_OK) then
          begin
            with ThreadVars do
              fErrorPos := curpos;

            if (ExcepInfo.bstrDescription = '') and not IsKnownInvokeError(Status) then        
              begin
                ExcepInfo.bstrDescription := Format(SErrUndeclaredIdentifier, [AName]);
                Status := DISP_E_EXCEPTION;
              end;

            InvokeError(AName, Status, ExcepInfo);
          end;

        ClearParams(Params, ParamCount);
      end;
  finally
    FreeMem(Params);
  end;
end;

{-----------------------------------------------------------}

procedure TBinProg._ProcessPutProc(const AName : string; const ParamCount : integer);
begin
  ThreadVars.FCodeCount := 0;
  _ProcessProc(AName, ocDispAssign, -1, ParamCount, DISPATCH_PROPERTYPUT);
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}
procedure TBinProg._DispAssign(a, b : integer);
begin
  _ProcessPutProc(sConsts[a], b);
end;
{$ENDIF}

{-----------------------------------------------------------}

procedure TBinProg._ProcessGetProc2(const Acode, StackPoint : integer; ProcNameIndex : integer);
begin
  ThreadVars.FCodeCount := 0;
  _ProcessProc(sConsts[ProcNameIndex], ACode, StackPoint, 0, DISPATCH_METHOD or DISPATCH_PROPERTYGET);
end;

{-----------------------------------------------------------}

procedure TBinProg._ProcessGetProc(const Acode, StackPoint : integer; ParamCount : integer);
begin
  ThreadVars.FCodeCount := 0;
  _ProcessProc(sConsts[GetSingleCode], ACode, StackPoint, ParamCount, DISPATCH_METHOD or DISPATCH_PROPERTYGET);
end;

{-----------------------------------------------------------}

function TBinProg.OutsideFinally(newpos : integer) : boolean;
begin
  with ThreadVars do
    begin
      with fFinallyList do
        if not IsEmpty then
          with TFinalInfo(Last) do
            if  (CodeStart <= curpos) and (CodeEnd >= curpos) and
            not ((CodeStart <= newpos) and (CodeEnd >= newpos)) then
              begin
                result := true;
                exit;
              end;
    end;
  result := false;
end;

{-----------------------------------------------------------}

procedure TBinProg.GotoNewPlace(newpos : integer);
begin
  with ThreadVars do
    if OutsideFinally(newpos) then
      begin
        fFinallyReason := frGoto;
        fGotoPos := newpos;
        curpos := TFinalInfo(fFinallyList.Last).CodeEnd;
      end
    else
      curpos := newpos;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}
function  TBinProg.GotoNewPlace2(newpos : integer) : pointer;
begin
  GotoNewPlace(newpos);
  result := OpcodesAddr[ThreadVars.curpos];
end;

{-----------------------------------------------------------}

function TBinProg.DoReturn2 : integer;
begin
  result := DoReturn;
  if result > 0 then
    result := integer(OpcodesAddr[result])
  else if result < 0 then
    result := -integer(OpcodesAddr[-result]);
end;

{-----------------------------------------------------------}
{$ENDIF}

function TBinProg.DoReturn : integer;
var
  newpos : integer;
begin
  with ThreadVars do
    begin
      if not CallStack.IsEmpty then
        newpos := integer(CallStack.Last)
      else
        newpos := progsize + 1;

      if OutSideFinally(newpos) then
        begin
          if TFinalInfo(fFinallyList.Last).IsFinal then
            begin
              fFinallyReason := frReturn;
              curpos := TFinalInfo(fFinallyList.Last).CodeEnd;
              result := curpos;
            end
          else
            begin
              _EndTry;
              result := DoReturn;
            end;
        end
      else
        begin
          LeaveProc;
          if newpos <= progsize then
            begin
              CallStack.Pop;
              curpos := newpos;
              result := -curpos;
            end
          else
            result := 0;
        end;
    end;
end;

{-----------------------------------------------------------}

function TBinProg.FindExceptHandler : boolean;
var
  fInfo : TFinalInfo;
begin
  with ThreadVars do
    begin
      result := not fExceptPos.IsEmpty;
      if result then
        begin
          CallMax := fExceptPos.Pop;
          CurPos := fExceptPos.Pop;
          fInfo := TFinalInfo(fFinallyList.Pop);
          CallStack.Count := fInfo.CallPos;
          fStack.Collapse(StackPointer - fInfo.StackPos);
          fBaseStackPointer := fInfo.fBasePointer;
          fStacks.Count := fInfo.fStacksSize;
          {$IFDEF ACTIVESCRIPTING}
          fRunner.SetStackState(fInfo.CallStackState);
          {$ENDIF}
          if fInfo.IsFinal then
            begin
              CurPos := fInfo.CodeEnd + 1; // skip EndTry
              fFinallyReason := frExcept;
            end
          else
            fErrorPos := -1;
        end;
    end;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}
function TBinProg._FinallyExcept : integer;
begin
  if not FindExceptHandler then
    raise Exception.Create(ThreadVars.fExceptMessage);

  result := integer(OpCodesAddr[ThreadVars.curpos]);
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure SetDefaultPropByDispatch(const disp : IDispatch; const index : OleVariant; Value : POleVariant);
var
  dparams : TDispParams;
begin
  FillChar(dparams, sizeof(dparams), 0);
  with dparams do
    begin
      GetMem0(rgvarg, sizeof(OleVariant) * 2);
      OleVariant(rgvarg^[0]) := Value^;
      OleVariant(rgvarg^[1]) := index;
      cArgs := 2;
    end;
  try
    disp.Invoke(0, GUID_NULL, 0, DISPATCH_PROPERTYPUT, dparams, nil, nil, nil);
  finally
    FreeMem(dparams.rgvarg);
  end;
end;

{-----------------------------------------------------------}

procedure TBinProg._EndTry;
begin
  with ThreadVars do
    begin
      with fExceptPos do
        begin
          Pop;
          Pop;
        end;
      TFinalInfo(fFinallyList.Pop).Free;
    end;
end;

{-----------------------------------------------------------}
{$IFDEF DCMBCS}
function getrealcharindex(const s : string; i : integer) : integer;
var
  p1 : pchar;
  p2 : pchar;
begin
  if (i > 0) and (s <> '') then
    begin
      p1 := PChar(s);
      p2 := p1;
      while i > 1 do
        begin
          dec(i);
          p2 := CharNext(p2);
        end;
      result := p2 - p1 + 1;
    end
  else
    result := i;
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure varget(var Value, VarResult : OleVariant; iCount : integer; list : pointer);
asm
  push edi
  push esi
  push ebx
  mov  edi, iCount
  mov  esi, list
  lea  esi, esi + edi * 4 - 4
  mov  ebx, esp
@@l:
  push dword ptr [esi]
  sub  esi, 4
  dec  edi
  jne  @@l

  push iCount
  push Value
  push VarResult
  call System.@VarArrayGet
  mov  esp, ebx
  pop  ebx
  pop  esi
  pop  edi
end;

{-----------------------------------------------------------}

procedure TBinProg._GetItem2(icount : integer; PSB : POleVariant); // PSA^ := PSB^[x1^, x2^,...xn^]
var
  resvalue : POleVariant;
  ilist    : TList;
  i        : integer;
  sp       : POleVariant;
  vt       : integer;      
begin
  ThreadVars.FCodeCount := 0;

  vt := TVarData(PSB^).vType;

  if vt = varDispatch then
    begin
      with ThreadVars do
        begin
          sp := _makestackptr(getsinglecode);
          if FCodeCount <> 0 then
            inc(curpos);
        end;
      sp^ := GetDefaultPropByDispatch(DCVarToInterface(PSB^), sp^);
      exit;
    end
  else if vt and varArray <> 0 then
    begin
      ilist := TList.Create;
      try
        resvalue := nil;
        with ThreadVars do
          begin
            for i := 0 to icount - 1 do
              begin
                sp := _makestackptr(getsinglecode);
                if i = 0 then
                  resvalue := sp;
                ilist.Add(pointer(integer(sp^)));
              end;

            if FCodeCount <> 0 then
              inc(curpos);
          end;

        if resvalue <> nil then
          varget(PSB^, resvalue^, iCount, ilist.List);

      finally
        ilist.Free;
      end;
    end
  else
    begin
      with ThreadVars do
        begin
          sp := _makestackptr(getsinglecode);
          sp^ := getitem(string(PSB^), sp^);
          if FCodeCount <> 0 then
            inc(curpos);
        end;
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg._SetItem2(icount : integer; PSB : POleVariant);
var
  i     : integer;
  Value : POleVariant;
  ilist : TList;
begin
  ilist := TList.Create;
  try
    with ThreadVars do
      begin
        FCodeCount := 0;
        for i := icount - 1 downto 0 do
          ilist.Add(pointer(integer(_makestackptr(getsinglecode)^)));
        Value := _makestackptr(getsinglecode);

        if FCodeCount <> 0 then
          inc(curpos);
      end;

    varput(PSB^, Value^, iCount, ilist.List);
  finally
    ilist.Free;
  end;
end;

{-----------------------------------------------------------}

procedure _GetItem(PSA, PSB : POleVariant);      // PSA^ := PSB^[PSA^]
var
  index : integer;
  vt    : integer;
begin
  index := integer(PSA^);
  vt := TVarData(PSB^).vType;
  if vt and varArray <> 0 then
    PSA^ := PSB^[index]
  else if vt = varDispatch then
    PSA^ := GetDefaultPropByDispatch(IDispatch(TVarData(PSB^).vDispatch), index)
  else
    PSA^ := getitem(string(PSB^), index);
end;

{-----------------------------------------------------------}

procedure setstritem(PSA : POleVariant; index : integer; const newval : string);
var
{$IFDEF DCMBCS}
  index2 : integer;
{$ENDIF}
  s : string;
begin
  s := PSA^;
{$IFDEF DCMBCS}
  if LeadBytes = [] then
{$ENDIF}
    begin
      if (index <= 0) or (index > length(s)) then
        Error(SRangeError);

      if newval <> '' then
        s[index] := newval[1];
{$IFNDEF DCMBCS}
    end;
{$ELSE}
    end
  else
    begin
      index2 := getrealcharindex(s, index + 1);
      index := getrealcharindex(s, index);
      delete(s, index, index2 - index);
      s[index] := newval[1]; //!!!!!!!!!!!!
    end;
{$ENDIF}
  PSA^ := s;
end;

{-----------------------------------------------------------}

procedure _SetItem(PSA, PSB, PSC : POleVariant); // PSB^[PSA^] := PSC^
var
  index : integer;
  vt    : integer;
begin
  vt := TVarData(PSB^).vType;
  if vt = varDispatch then
    SetDefaultPropByDispatch(IDispatch(TVarData(PSB^).vDispatch), PSA^, PSC)
  else
    begin
      index := integer(PSA^);
      if vt and varArray <> 0 then
        PSB^[index] := PSC^
      else
        setstritem(PSB, index, PSC^);
    end;
end;

{-----------------------------------------------------------}

{$IFNDEF D6}
function SafeArrayCreate(VarType, DimCount: Integer; const Bounds): PVarArray; stdcall; external 'oleaut32.dll' name 'SafeArrayCreate';
{$ENDIF}

procedure TBinProg._CreateArray(PSA : POleVariant; arrCount : integer);
var
  i : integer;
  VarBounds   : array[0 .. 63] of TVarArrayBound;
  VarArrayRef : PVarArray;
begin
  with ThreadVars do
    begin
      FCodeCount := 0;

      for i := 0 to arrCount - 1 do
        with VarBounds[i] do
          begin
            LowBound := getsinglecode;
            ElementCount := getsinglecode - LowBound + 1;
          end;

      VarArrayRef := SafeArrayCreate(varVariant, arrcount, {$IFDEF D6}PVarArrayBoundArray(@VarBounds)^{$ELSE}VarBounds{$ENDIF});
      if VarArrayRef = nil then
        Error(SVarArrayCreate);

      VarClear(PSA^);
      with TVarDatA(PSA^) do
        begin
          VType := varVariant or varArray;
          VArray := VarArrayRef;
        end;

      if FCodeCount <> 0 then
        inc(curpos);
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg.LeaveProc;
begin
  with ThreadVars do
    begin
      with fStacks do
        begin
          fStack.Collapse(Pop); //clear local vars and params
          fBaseStackPointer := Pop;
        end;
    {$IFDEF ACTIVESCRIPTING}
      if FDebugging then
        DoFunctionExit (nil);
    {$ENDIF}
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg.EnterProc(a, b : integer);
var
  Item : TIdentListItem;
begin
  with ThreadVars do
    begin
      fStacks.Push(fBaseStackPointer);
      fBaseStackPointer := StackPointer;
      if b >= 0 then
        begin
          Item := TIdentListItem(THalCompiler(fRunner.FHalCompiler).Variables.Objects[b]);
          b := a + item.ParamNames.Count;
        end
      else
        begin
    {$IFDEF ACTIVESCRIPTING}
          Item := nil;
    {$ENDIF}
          b := a;
        end;
    {$IFDEF ACTIVESCRIPTING}
      if FDebugging then
        DoFunctionEnter (item);
    {$ENDIF}
      if a > 0 then
        begin
          inc(b);
          fStack.Expand(a + 1); //local vars
        end;

      fStacks.Push(b);
   end;
end;

{-----------------------------------------------------------}

procedure TBinProg._DoTry(a, b : integer);
var
  fInfo : TFinalInfo;
begin
  with ThreadVars do
    begin
      with fExceptPos do
        begin
          Push(a);
          Push(CallMax);
        end;
      fInfo := TFinalInfo.Create;
      fInfo.CodeStart := CurPos;
      fInfo.CodeEnd := a;
      fInfo.IsFinal := not boolean(b);
      fInfo.CallPos := CallStack.Count;
      fInfo.fStacksSize := fStacks.Count;
      fInfo.StackPos := StackPointer;
      fInfo.fBasePointer := fBaseStackPointer;
      {$IFDEF ACTIVESCRIPTING}
      fInfo.CallStackState := fRunner.GetStackState;
      {$ENDIF}
      fFinallyList.Push(integer(finfo));
    end;
end;

{-----------------------------------------------------------}

procedure _Add(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ + PSB^;
  {$IFNDEF D5}  // RTL bug workaround
  if TVarData(PSA^).vType = varString then
    PSA^ := WideString(PSA^);
  {$ENDIF}
end;

{-----------------------------------------------------------}

procedure _Sub(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ - PSB^;
end;

{-----------------------------------------------------------}

{$IFNDEF USECOMPILER}

procedure _If(PSA : POleVariant; var curpos : integer; newpos : integer);
begin
  if not PSA^ then
    curpos := newpos;
end;

{-----------------------------------------------------------}

procedure _Mul(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ * PSB^;
end;

{-----------------------------------------------------------}

procedure _Div(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ div PSB^;
end;

{-----------------------------------------------------------}

procedure _Mod(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ mod PSB^;
end;

{-----------------------------------------------------------}

procedure _Shl(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ shl PSB^;
end;

{-----------------------------------------------------------}

procedure _Shr(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ shr PSB^;
end;

{-----------------------------------------------------------}

procedure _Or(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ or PSB^;
end;

{-----------------------------------------------------------}

procedure _Xor(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ xor PSB^;
end;

{-----------------------------------------------------------}

procedure _And(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ and PSB^;
end;

{-----------------------------------------------------------}
{$ENDIF}

{$IFDEF USECOMPILER}

procedure _Mov(PSA, PSB : POleVariant);
begin
  PSA^ := PSB^;
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure _Slash(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ / PSB^;
end;

{-----------------------------------------------------------}

procedure _GreaterEqual(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ >= PSB^;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}

procedure _NotEqual(PSA, PSB : POleVariant);
begin
  cmpVariants(PSA, PSB, true);
end;

{-----------------------------------------------------------}

procedure _Equal(PSA, PSB : POleVariant);
begin
  cmpVariants(PSA, PSB, false);
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure _LessEqual(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ <= PSB^;
end;

{-----------------------------------------------------------}

procedure _Greater(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ > PSB^;
end;

{-----------------------------------------------------------}

procedure _Less(PSA, PSB : POleVariant);
begin
  PSA^ := PSA^ < PSB^;
end;

{-----------------------------------------------------------}

procedure _Inc(PSA : POleVariant);
begin
  PSA^ := PSA^ + 1;
end;

{-----------------------------------------------------------}

procedure _Dec(PSA : POleVariant);
begin
  PSA^ := PSA^ - 1;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}

procedure _LoadIntConst(PSA : POleVariant; i : integer);
begin
  PSA^ := i;
end;

{-----------------------------------------------------------}

procedure _LoadBoolConst(PSA : POleVariant; b : WordBool);
begin
  PSA^ := b;
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure _PopIDisp(FDispatch : TIntStack);
var
  fdisp : pointer;
begin
  fdisp := pointer(FDispatch.Pop);
  if fdisp <> nil then
    IDispatch(fDisp)._Release;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}
function _IsGreater(PSA, PSB : POleVariant) : boolean;
begin
  result := PSA^ > PSB^;
end;

{-----------------------------------------------------------}

function _IsLess(PSA, PSB : POleVariant) : boolean;
begin
  result := PSA^ < PSB^
end;

{-----------------------------------------------------------}

function _IsNotEqual(PSA, PSB : POleVariant) : boolean;
begin
  result := not VariantsEqual(PSA, PSB);
end;

{-----------------------------------------------------------}

function _IsEqual(PSA, PSB : POleVariant) : boolean;
begin
  result := VariantsEqual(PSA, PSB);
end;

{-----------------------------------------------------------}

function _IsLessEqual(PSA, PSB : POleVariant) : boolean;
begin
  result := PSA^ <= PSB^;
end;

{-----------------------------------------------------------}

function _IsGreaterEqual(PSA, PSB : POleVariant) : boolean;
begin
  result := PSA^ >= PSB^;
end;

{-----------------------------------------------------------}
{$ENDIF USECOMPILER}

procedure TBinProg._AddWith(PSA : POleVariant);
var
  fDisp : IDispatch;
begin
  with ThreadVars do
    begin
      fDisp := DCVarToInterface(PSA^);
      fWithObjects.Push(Integer(fDisp));
      if fDisp = nil then
        exit;
      fDisp._AddRef;
      pointer(fDisp) := nil;
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg._RemoveWith;
var
  fDisp : IDispatch;
begin
  with ThreadVars do
    begin
      integer(fDisp) := fWithObjects.Pop;
      if fDisp <> nil then
        begin
          fDisp._Release;
        end;
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg._setvararray(a : integer; PSB : POleVariant);
var
  a1 : integer;
begin
  with ThreadVars do
    begin
      a1 := prog^[curpos].a;
      inc(curpos);
      fStack.Items(fBaseStackPointer + a1)^[a] := PSB^;
    end;
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}

function _VarIsTrue(PSA : POleVariant) : boolean;
begin
  result := PSA^;
end;

{$ENDIF}

{-----------------------------------------------------------}

function TBinProg._Raise(a : integer; PSA : POleVariant) : pointer;
begin
  with ThreadVars do
    begin
      if a <> -1 then
        fExceptMessage := PSA^;

      if not FindExceptHandler then
        raise Exception.Create(fExceptMessage);

      if OpcodesAddr <> nil then
        result := OpcodesAddr[curpos]
      else
        result := nil;  
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg._PushIDisp(PSA : POleVariant);
var
  fdisp : IDispatch;
begin
  with ThreadVars do
    begin
      fdisp := DCVarToInterface(PSA^);
      if fdisp <> nil then
        fdisp._AddRef;

      FDispatch.Push(Integer(fdisp));
    end;
end;

{-----------------------------------------------------------}

{$IFNDEF USECOMPILER}

procedure InvCodeError;
begin
  Error(SErrInvCode);
end;

{$ENDIF}

{-----------------------------------------------------------}

function TBinProg._makestackptr(i : integer) : POleVariant;
begin
  if i >= MaxStackSize * 2 then // global var
    result := @(StaticVars[i - MaxStackSize * 2])
  else if i >= MaxStackSize then // ref var
    with ThreadVars do
      result := pointer(integer(fStack.Items(fBaseStackPointer + MaxStackSize - i)^))
  else with ThreadVars do
    result := fStack.Items(fBaseStackPointer + i);
end;

{-----------------------------------------------------------}

{$IFDEF USECOMPILER}
procedure TBinProg._Push(PSA : POleVariant);
begin
  ThreadVars.fStack.Push(PSA^);
end;

{-----------------------------------------------------------}

procedure TBinProg._PushRef(PSA : POleVariant);
begin
  ThreadVars.fStack.PushInt(integer(PSA));
end;

{-----------------------------------------------------------}

procedure TBinProg._Pop(PSA : POleVariant);
begin
  ThreadVars.fStack.PopLast(PSA);
end;
{$ENDIF}

{-----------------------------------------------------------}

procedure TBinProg._UseUnit(PSA : POleVariant);
begin
  fRunner.Scripter.UseUnit(PSA^);
end;

{-----------------------------------------------------------}

procedure TBinProg._UnloadUnit(PSA : POleVariant);
begin
  fRunner.Scripter.UnloadUnit(PSA^);
end;

{-----------------------------------------------------------}

procedure TBinProg._Evaluate(PSA : POleVariant);
begin
  PSA^ := fRunner.EvaluateExpression(PSA^);
end;

{-----------------------------------------------------------}

procedure TBinProg.CauseBreak;
begin
{$IFDEF ACTIVESCRIPTING}
  with fRunner.fDSProject do
    begin
      ConnectToDebugger;
      CauseBreak;
    end;
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure TBinProg._CallExternal(PSA : POleVariant; ParamCount : integer);
var
  Params : POleVariantArray;
  obj    : TObject;
begin
  ThreadVars.FCodeCount := 0;
  GetMem0(Params, ParamCount * sizeof(OleVariant));
  try
    FillParamsFromCode(Params, ParamCount);
    obj := VarToObject(PSA^);
    if obj is TDCExternalProcLauncher then
      TDCExternalProcLauncher(obj).Execute(ParamCount, PVariantArgList(Params));
  finally
    ClearParams(Params, ParamCount);
  end;
end;

{-----------------------------------------------------------}

{$IFNDEF USECOMPILER}
function TBinProg._dispatch(opcode, a, b: integer): boolean;
var
  PSA    : POleVariant;
  PSB    : POleVariant;
  bint   : integer;
  btyp   : integer;
  allint : boolean;
begin
//  inc(curpos);
  Result := true;

  if OpCode = ocNop then
    exit;

  PSA := _makestackptr(a);

  if (opcode >= MinConstOp) and (opcode <= MaxConstOp) then
    begin
      PSB := @(fConsts[b]);
      dec(opcode, ConstOpsBase);
    end
  else if (OpCode in SingleParamOpCodes) or (opCode >= IntOpsBase) then
    PSB := nil
  else
    PSB := _makestackptr(b);

  if PSB <> nil then
    with TVarData(PSB^) do
      begin
        btyp := VType;
        bint := vInteger;
      end
  else
    begin
      btyp := varInteger;
      bint := 0;
    end;

  with TVarData(PSA^) do
    begin
      allint := (PSA <> nil) and (btyp = varInteger) and (VType = varInteger);

      case opcode of
        ocAdd : if allint then
                  inc(vInteger, bint)
                else
                  _Add(PSA, PSB);

        ocSub : if allint then
                  dec(vInteger, bint)
                else
                  _Sub(PSA, PSB);

        ocMul : if allint then
                  vInteger := vInteger * bint
                else
                  _Mul(PSA, PSB);

        ocDiv : if allint then
                  vInteger := vInteger div bint
                else
                  _Div(PSA, PSB);

        ocMod : if allint then
                  vInteger := vInteger mod bint
                else
                  _Mod(PSA, PSB);

        ocSlash : _Slash(PSA, PSB);

        ocShl : if allint then
                  vInteger := vInteger shl bint
                else
                  _Shl(PSA, PSB);

        ocShr : if allint then
                  vInteger := vInteger shr bint
                else
                  _Shr(PSA, PSB);

        ocNot : if allint then
                  vInteger := not vInteger
                else if VType = varBoolean then
                  if word(vBoolean) = 0 then
                    vBoolean := true
                  else
                    vBoolean := false
                else
                  _Not(PSA);

        ocOr :  if allint then
                  vInteger := vInteger or bint
                else if (VType = varBoolean) and (btyp = varBoolean) then
                  vBoolean := vBoolean or TVarData(PSB^).vBoolean
                else
                  _Or(PSA, PSB);

        ocXor : if allint then
                  vInteger := vInteger xor bint
                else if (VType = varBoolean) and (btyp = varBoolean) then
                  vBoolean := vBoolean xor TVarData(PSB^).vBoolean
                else
                  _Xor(PSA, PSB);

        ocAnd : if allint then
                  vInteger := vInteger and bint
                else if (VType = varBoolean) and (btyp = varBoolean) then
                  vBoolean := vBoolean and TVarData(PSB^).vBoolean
                else
                  _And(PSA, PSB);

        ocGreaterEqual : if allint then
                           begin
                             vType := varBoolean;
                             if vInteger >= bint then
                               vBoolean := true
                             else
                               vBoolean := false;
                           end
                         else
                           _GreaterEqual(PSA, PSB);

        ocEqual : cmpvariants(PSA, PSB, false);

        ocLessEqual : if allint then
                        begin
                          vType := varBoolean;
                          if vInteger <= bint then
                            vBoolean := true
                          else
                            vBoolean := false;
                        end
                      else
                        _LessEqual(PSA, PSB);

        ocNotEqual : cmpvariants(PSA, PSB, true);

        ocGreater : if allint then
                      begin
                        vType := varBoolean;
                        if vInteger > bint then
                          vBoolean := true
                        else
                          vBoolean := false;
                      end
                    else
                      _Greater(PSA, PSB);

        ocLess : if allint then
                   begin
                     vType := varBoolean;
                     if vInteger < bint then
                       vBoolean := true
                     else
                       vBoolean := false;
                   end
                 else
                   _Less(PSA, PSB);

        ocNeg : if allint then
                  vInteger := -vInteger
                else
                  _Neg(PSA);

        ocCos : PSA^ := Cos(PSA^);

        ocSin : PSA^ := Sin(PSA^);

        ocExp : PSA^ := Exp(PSA^);

        ocSqr : PSA^ := Sqr(PSA^);

        ocSqrt : PSA^ := Sqrt(PSA^);

        ocLn : PSA^ := Ln(PSA^);

        ocArcTan : PSA^ := ArcTan(PSA^);

        ocGoto : GotoNewPlace(a);

        ocInternalGoto : ThreadVars.curpos := a;

        ocif : if vType = varBoolean then
                 begin
                   if not vBoolean then
                     ThreadVars.curpos := b
                 end
               else
                 _If(PSA, ThreadVars.curpos, b);

        ocloadconst : PSA^ := fConsts[b];

        ocloadintconst : PSA^ := b;

        ocloadboolconst : PSA^ := WordBool(b);

        ochalt : begin
                   LeaveProc;
                   Result := false;
                 end;

        ocincvar : if allint then
                     inc(vInteger)
                   else
                     _Inc(PSA);

        ocIncVar2 : if allint then
                      inc(vInteger, bint)
                    else
                      _Add(PSA, PSB);

        ocdecvar : if allint then
                     dec(vInteger)
                   else
                     _Dec(PSA);

        ocDecVar2 : if allint then
                      dec(vInteger, bint)
                    else
                      _Sub(PSA, PSB);

        ocCallExternal : _CallExternal(PSA, b);

        ocmov : if allint then
                  vInteger := bint
                else if (btyp = varInteger) and (vType = varEmpty) then
                  begin
                    vType := varInteger;
                    vInteger := bint;
                  end
                else
                  PSA^ := PSB^;

        occall : begin
                   with ThreadVars do
                     begin
                       CallStack.Push(curpos);
                       Curpos := a;
                     end;
                 end;

        ocreturn : result := DoReturn <> 0;

        ocEnterProc : EnterProc(a, b);

        ocvarraycreate : _ocvarraycreate(PSA^, b);

        ocsetvarray : _setvararray(a, PSB);

        ocScriptInvoke : _ProcessGetProc(opcode, a, b);

        ocScriptInvoke2 : _ProcessGetProc2(opcode, a, b);

        ocScriptDispatch : _ProcessGetProc(opcode, a, b);

        ocScriptDispatch2 : _ProcessGetProc2(opcode, a, b);

        ocPopIDisp : _PopIDisp(ThreadVars.FDispatch);

        ocDispAssign : _ProcessPutProc(sConsts[a], b);

        ocPushIDisp : _PushIDisp(PSA);

        ocTry : _DoTry(a, b);

        ocEndFinally : case ThreadVars.fFinallyReason of
                         frNormal : ;
                         frGoto : GotoNewPlace(ThreadVars.fGotoPos);
                         frReturn : result := DoReturn <> 0;
                         frExcept : if not FindExceptHandler then
                                      raise Exception.Create(ThreadVars.fExceptMessage);
                       end;


        ocNormalFinally : ThreadVars.fFinallyReason := frNormal;

        ocEndTry : _EndTry;

        ocRaise : _Raise(a, PSA);

        ocGetItem : _GetItem(PSA, PSB);

        ocGetItem2 : _GetItem2(a, PSB);

        ocSetItem : begin
                      _SetItem(PSA, PSB, _makestackptr(prog[ThreadVars.curpos].opcode));
                      inc(ThreadVars.curpos);
                    end;

        ocSetItem2 : _SetItem2(a, PSB);

        ocAddWith : _AddWith(PSA);

        ocRemoveWith : _RemoveWith;

        ocTrueCheck : if ((vType = varBoolean) and vBoolean) or
                         ((vType = varInteger) and (vInteger = -1)) then
                          ThreadVars.curpos := b;

        ocFalseCheck : if ((vType = varBoolean) and not vBoolean) or
                          ((vType = varInteger) and (vInteger = 0)) then
                          ThreadVars.curpos := b;

//        ocClearStack : ;PSA^ := Unassigned;

        ocMovRef     : begin
                         if vType >= varOleStr then
                           VarClear(PSA^);

                         vPointer := PSB;
                         vType := VarByRef or VarVariant;
                       end;

        ocPush       : ThreadVars.fStack.Push(PSA^);

        ocPushRef    : ThreadVars.fStack.PushInt(integer(PSA));

        ocPushConst  : ThreadVars.fStack.Push(fConsts[a]);

//        ocOut        : DoOut(sConsts[a]);
        ocEvaluate   : _Evaluate(PSA);

        ocUseUnit    : _UseUnit(PSA);

        ocUnloadUnit : _UnloadUnit(PSA);

        ocCauseBreak : CauseBreak;

        ocPop        : ThreadVars.fStack.PopLast(PSA);

        ocPush0      : ThreadVars.fStack.Expand(1);

        ocIfGreater  : if allint then
                         begin
                           if vinteger <= bint then
                             inc(ThreadVars.CurPos)
                         end
                       else if PSA^ <= PSB^ then
                         inc(ThreadVars.CurPos);

        ocIfLess     : if allint then
                         begin
                           if vinteger >= bint then
                             inc(ThreadVars.CurPos)
                         end
                       else if PSA^ >= PSB^ then
                         inc(ThreadVars.CurPos);

        ocIfNotEqual : if allint then
                         begin
                           if vinteger = bint then
                             inc(ThreadVars.CurPos)
                         end
                       else if VariantsEqual(PSA, PSB) then
                         inc(ThreadVars.CurPos);

        ocIfEqual    : if allint then
                         begin
                           if vinteger <> bint then
                             inc(ThreadVars.CurPos)
                         end
                       else if not VariantsEqual(PSA, PSB) then
                           inc(ThreadVars.CurPos);

        ocIfLessEqual : if allint then
                          begin
                            if vinteger > bint then
                              inc(ThreadVars.CurPos)
                          end
                        else if PSA^ > PSB^ then
                          inc(ThreadVars.CurPos);

        ocIfGreaterEqual : if allint then
                             begin
                               if vinteger < bint then
                                 inc(ThreadVars.CurPos)
                             end
                           else if PSA^ < PSB^ then
                             inc(ThreadVars.CurPos);

        ocIfGreaterInt   : if allint then
                             begin
                               if vinteger <= b then
                                 inc(ThreadVars.CurPos)
                             end;
                           {else if PSA^ <= b then
                             inc(CurPos);}

        ocIfLessInt      : if allint then
                             begin
                               if vinteger >= b then
                                 inc(ThreadVars.CurPos)
                             end;
                           {else if PSA^ >= b then
                             inc(CurPos);}

        ocIfLessEqualInt : if allint then
                             begin
                               if vinteger > b then
                                 inc(ThreadVars.CurPos);
                             end;

        ocIfGreaterEqualInt: if allint then
                               begin
                                 if vinteger < b then
                                   inc(ThreadVars.CurPos)
                               end;

        ocCreateArray : _CreateArray(_makestackptr(a), b);

        ocWrite : classname;//write(PSA^);

        ocWriteln : classname;//writeln(PSA^);

      else InvCodeError;

      end;
    end;
end;
{$ENDIF}
{-----------------------------------------------------------}

{$IFDEF USECOMPILER}

procedure callcompiledcode(p : pointer); assembler;
asm
  push ebx
  call p
  pop  ebx
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure TBinProg.DoRun;
{$IFNDEF USECOMPILER}
var
  _prog : pprogarray;
  ppos  : PInt;
  pfStop : pbyte;
{$ENDIF}
begin
  fStop := false;
{$IFDEF ACTIVESCRIPTING}
  if FDebugging then
  begin
    FPrevLinePos := 0;
    FPrevCurPos := 0;
  end;
{$ENDIF}
  repeat
    try
{$IFDEF USECOMPILER}
      callcompiledcode(OpcodesAddr[ThreadVars.curpos]);

      if not fStop then
        exit;
{$ELSE}
      _prog := prog;
      ppos  := @ThreadVars.CurPos;
      pfstop := @fStop;

      repeat
        {$IFDEF WIN}
        if fdebugging then
          BeforeDispatch;
        {$ENDIF}
        with _prog^[ppos^] do
          if opcode = ocInternalGoto then
            ppos^ := a
          else
            begin
              inc(ppos^);
              if not _dispatch(opcode, a, b) then
                exit;
            end;
      until pfStop^ <> 0{fStop};
{$ENDIF}
    except
      with ThreadVars do
        begin
          if fErrorPos = -1 then
            fErrorPos := curpos;

          fExceptMessage := Exception(ExceptObject).Message;
        end;
{$IFDEF ACTIVESCRIPTING}
      if FDebugging then
      begin
        if not DoException(Exception(ExceptObject)) then
          if not FindExceptHandler then
            raise;
        FindExceptHandler;
      end
      else
        if not FindExceptHandler then
          raise;
{$ENDIF}
    end;
  until fStop;
end;

{-----------------------------------------------------------}
{$IFDEF THREADSAFE}
procedure TBinProg.AddScriptThread;
var
  tvars : TBinProgThreadVars;
  tid   : DWORD;
  i     : integer;
begin
  tid := GetCurrentThreadID;
  if tid <> MainThreadID then
    begin
      EnterCriticalSection(fTVarsLock);
      try
        i := fTVarsList.IndexOfKey(pointer(GetCurrentThreadID));
        if i < 0 then
          begin
            tvars := TBinProgThreadVars.Create;
            tvars.fRefCount := 1;
            fTVarsList.Add(tvars);
          end
        else
          inc(TBinProgThreadVars(fTVarsList[i]).fRefCount);
      finally
        LeaveCriticalSection(fTVarsLock);
      end;
    end;
end;

{-----------------------------------------------------------}

procedure TBinProg.RemoveScriptThread;
var
  i : integer;
  tid   : DWORD;
begin
  tid := GetCurrentThreadID;
  if tid <> MainThreadID then
    begin
      EnterCriticalSection(fTVarsLock);
      try
        i := fTVarsList.IndexOfKey(pointer(GetCurrentThreadID));
        if i >= 0 then
          begin
            with TBinProgThreadVars(fTVarsList[i]) do
              begin
                dec(fRefCount);
                if fRefCount = 0 then
                  Free;
              end;    
            fTVarsList.Delete(i);
          end;
      finally
        LeaveCriticalSection(fTVarsLock);
      end;
    end;
end;
{$ENDIF}
{-----------------------------------------------------------}

procedure TBinProg.TraceInto;
begin
  fTraced := true;
  DoRun;
end;

{-----------------------------------------------------------}

procedure TBinProg.StepOver;
begin
  ; //
end;

{-----------------------------------------------------------}

procedure TBinProg.RunFrom(Acurpos: Integer; var Params : TDispParams;
                           VarResult : POleVariant; im : TIdentListItem);
var
  state : pointer;
  i     : integer;
  k     : integer;
  pcount     : integer;
  pv         : POleVariant;
  lastparam  : integer;
  argcount   : integer;
  IsFunction : boolean;
begin
  {$IFDEF THREADSAFE}
    AddScriptThread;
  try
  {$ENDIF}
    state := SaveState;
    with ThreadVars do
      try
        curpos := ACurPos;
        fStop := false;

        IsFunction := (im <> nil) and (im.IdentType = tifunction);

        if IsFunction then
          fStack.Expand(1); // result value

        if im <> nil then
          begin
            k := 0;
            pcount := im.ParamNames.Count;

            with Params do
              begin
                argcount := Params.cArgs;
                for i := min(argcount, pcount) - 1 downto 0 do
                  begin
                    pv := @(rgvarg[i]);
                    if TVarData(pv^).vType = varByRef + varVariant then
                      pv := TVarData(pv^).vPointer;

                    if im.Params[k] = ptVar then
                      fStack.PushInt(integer(pv))
                    else
                      fStack.Push(pv^);

                    inc(k);
                  end;
              end;

            lastparam := pcount - im.DefaultParams.Count;
            for i := argcount to pCount - 1 do
              fStack.Push(fConsts[integer(im.DefaultParams[i - lastparam])]);
          end;

        try
          if not fInitialized then
            begin
              fInitialized := true;
              Curpos := fInitializePos;
              DoRun;
              curpos := ACurPos;
            end;

          DoRun;
        finally
          if IsFunction and (VarResult <> nil) then
            VarResult^ := fStack.Pop;
        end;

      finally
        if not fDestroyed then
          RestoreState(state)
        else
          FreeMem(state);
      end;
  {$IFDEF THREADSAFE}
  finally
    RemoveScriptThread;
  end;
  {$ENDIF}
end;

{-----------------------------------------------------------}

{$IFDEF ACTIVESCRIPTING}
procedure TBinProg.BeforeDispatch;
var
  curline : integer;
  cpos    : integer;
  dobj    : TDebugObject;
begin
  dobj := TDebugObject(FRunner.Scripter.DebugObject);
  if dobj <> nil then
    dobj.SetCurrentScripter(FRunner.Scripter);

  with prog^[ThreadVars.curpos] do
    begin
      if Assigned(fRunner.fOnExecuteLine) then
        fRunner.fOnExecuteLine(fRunner, LinePos);
        
      FCurLinePos := linepos;
      if not ((opcode = ocHalt) or (opcode = ocEnterProc)) then
        begin
          if FPrevLinePos <> linepos then
            DoChangeTraceLine;
          FPrevCurPos := ThreadVars.curpos;
        end;
    end;

  cpos := ThreadVars.curpos;
  curline := prog^[cpos].LinePos;

  if fTraced then
    begin
      if (LastLine <> CurLine) or (cpos < LastPos) then
        fStop := true;
    end;

  if (dobj <> nil) and dobj.IsBreakPoint(FRunner.Scripter, CurLine) then
    fStop := true;

  LastLine := CurLine;
  LastPos := cpos;
end;

{-----------------------------------------------------------}

procedure TBinProg.DoChangeTraceLine;
begin
  if Assigned(FOnChangeTraceLine) then
  begin
    with FDebugInfo do
    begin
      PCurProgItem := @prog^[FPrevCurPos];
      PNextProgItem := @prog^[ThreadVars.curpos];
      FPrevLinePos := TBinprogitem(PNextProgItem^).linepos;
    end;
    FOnChangeTraceLine(FDebugInfo);
  end;
end;

{-----------------------------------------------------------}

function  TBinProg.DoException (AExeption: Exception): boolean;
begin
  Result := ThreadVars.fFinallyReason <> frExcept;
  if Result then
  begin
    with FDebugInfo do
    begin
      PCurProgItem := @prog^[FPrevCurPos];
      PNextProgItem := @prog^[ThreadVars.curpos];
    end;
    if Assigned(FOnException) then
      FOnException(AExeption,FDebugInfo);
  end;
end;

{-----------------------------------------------------------}

procedure TBinProg.DoFunctionEnter(const AItem: TIdentListItem);
var
  pArgs : POleVariantArray;
  cArgs, i : integer;
  PVal     : POleVariant;
begin
  if AItem = nil then
    exit;
  if Assigned(FOnFunctionEnter) then
  begin
    cArgs := AItem.ParamNames.Count;
    try
      if cArgs > 0 then
      begin
        GetMem0(pArgs, SizeOf(OleVariant) * cArgs);
        for i := 0 to cArgs - 1 do
        begin
          PVal := ThreadVars.fStack.Items(ThreadVars.fBaseStackPointer - cArgs + i);
          if AItem.Params [i] = ptVar then
            PVal := POleVariant(integer(PVal^));
          pArgs^[i] := PVal^;
        end;
      end;
      FOnFunctionEnter(FCurLinePos, FPrevLinepos, AItem.Name, cArgs, PVariantArgList(pArgs));
    finally
      if cArgs > 0 then
      begin
        for i := 0 to cArgs - 1 do
          VarClear(pArgs^[i]);
        FreeMem(pArgs);
      end;
    end;
  end;
  ThreadVars.fFuncStack.Add(AItem.Name);
end;

{-----------------------------------------------------------}

procedure TBinProg.DoFunctionExit(const AItem: TIdentListItem);
begin
  if ThreadVars.fFuncStack.Count = 0 then
    exit;
  with ThreadVars.fFuncStack do
    Delete(Count - 1);

  if Assigned(FOnFunctionExit) then
    FOnFunctionExit(prog^[ThreadVars.curpos].linepos, FPrevLinepos,'',0,nil);
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure TBinProg.Run;
var
  params : TDispParams;
begin
  FillChar(params, sizeof(params), 0);
  RunFrom(0, params, nil, nil);
end;

function  TBinProg.ProgItemToStr(const Index: Integer): string;
var
  Item: TBinProgItem;
const
  MaxLenStr = 21;

  function OpCodeToStr(const AProgItem: TBinProgItem): String;
  var
    Str: string;
  begin
    with AProgItem do
    case opcode of
      ocAdd : Str := 'ocAdd';
      ocSub : Str := 'ocSub';
      ocMul : Str := 'ocMul';
      ocDiv : Str := 'ocDiv';
      ocMod : Str := 'ocMod';
      ocSlash : Str := 'ocSlash';
      ocShl : Str := 'ocShl';
      ocShr : Str := 'ocShr';
      ocNot : Str := 'ocNot';
      ocOr  : Str := 'ocOr ';
      ocXor : Str := 'ocXor';
      ocAnd : Str := 'ocAnd';
      ocGreaterEqual : Str := 'ocGreaterEqual';
      ocEqual : Str := 'ocEqual';
      ocLessEqual : Str := 'ocLessEqual';
      ocNotEqual : Str := 'ocNotEqual';
      ocGreater : Str := 'ocGreater';
      ocLess : Str := 'ocLess';

      ocWrite : Str := 'ocWrite';
      ocWriteln : Str := 'ocWriteln';

      ocRead : Str := 'ocRead';
      ocReadln : Str := 'ocReadln';

      ocIfGreater      : Str := 'ocIfGreater';
      ocIfLess         : Str := 'ocIfLess';
      ocIfNotEqual     : Str := 'ocIfNotEqual';
      ocIfEqual        : Str := 'ocIfEqual';
      ocIfLessEqual    : Str := 'ocIfLessEqual';
      ocIfGreaterEqual : Str := 'ocIfGreaterEqual';

      ocIfGreaterInt   : Str := 'ocIfGreater';
      ocIfLessInt      : Str := 'ocIfLess';

      ocNeg : Str := 'ocNeg';
      ocGoto : Str := 'ocGoto' + ' [' + IntToStr(A)+ ']';
      ocInternalGoto : Str := 'ocInternalGoto' + ' [' + IntToStr(A)+ ']';
      ocIF : Str := 'ocIF' + ' [' + IntToStr(B)+ ']';
      ocloadconst : Str := 'ocloadconst';
      ocloadintconst : Str := 'ocloadintconst';
      ocloadboolconst : Str := 'ocloadboolconst';
      ochalt : Str := 'ochalt';
      ocincvar : Str := 'ocincvar';
      ocdecvar : Str := 'ocdecvar';
      ocmov : Str := 'ocmov';
      occall : Str := 'occall' + ' [' + IntToStr(A)+ ']';
      ocreturn : Str := 'ocreturn';
      ocEnterProc : Str := 'ocEnterProc';
      ocvarraycreate : Str := 'ocvarraycreate';
      ocsetvarray : Str := 'ocsetvarray';
      ocScriptInvoke : Str := 'ocScriptInvoke';
      ocScriptInvoke2 : Str := 'ocScriptInvoke2';
      ocScriptDispatch : Str := 'ocScriptDispatch';
      ocScriptDispatch2 : Str := 'ocScriptDispatch2';
      ocPopIDisp : Str := 'ocPopIDisp';
      ocDispAssign : Str := 'ocDispAssign';
      ocPushIDisp : Str := 'ocPushIDisp';
      ocTry : Str := 'ocTry';
      ocEndFinally : Str := 'ocEndFinally';
      ocNormalFinally : Str := 'ocNormalFinally';
      ocEndTry : Str := 'ocEndTry';
      ocRaise : Str := 'ocRaise';
      ocGetItem : Str := 'ocGetItem';
      ocSetItem : Str := 'ocSetItem';
      ocGetItem2 : Str := 'ocGetItem2';
      ocSetItem2 : Str := 'ocSetItem2';
      ocCreateArray: Str := 'ocCreateArray';

      ocAddWith : Str := 'ocAddWith';
      ocRemoveWith : Str := 'ocRemoveWith';
      ocTrueCheck : Str := 'ocTrueCheck' + ' [' + IntToStr(B)+ ']';
      ocFalseCheck : Str := 'ocFalseCheck' + ' [' + IntToStr(B)+ ']';
//      ocClearStack : Str := 'ocClearStack';
      ocMovRef : Str := 'ocMovRef';
      ocPush : Str := 'ocPush';
      ocPop : Str := 'ocPop';
      ocPushRef : Str := 'ocPushRef';
      ocPush0 : Str := 'ocPush0';

      ocAddInt : Str := 'ocAddInt';
      ocSubInt : Str := 'ocSubInt';
      ocMulInt : Str := 'ocMulInt';
      ocDivInt : Str := 'ocDivInt';
      ocModInt : Str := 'ocModInt';
      ocSlashInt : Str := 'ocSlashInt';
      ocShlInt : Str := 'ocShlInt';
      ocShrInt : Str := 'ocShrInt';
      ocNotInt : Str := 'ocNotInt';
      ocOrInt  : Str := 'ocOrInt ';
      ocXorInt : Str := 'ocXorInt';
      ocAndInt : Str := 'ocAndInt';

      ocGreaterEqualInt : Str := 'ocGreaterEqualInt';
      ocEqualInt : Str := 'ocEqualInt';
      ocLessEqualInt : Str := 'ocLessEqualInt';
      ocNotEqualInt : Str := 'ocNotEqualInt';
      ocGreaterInt : Str := 'ocGreaterInt';
      ocLessInt : Str := 'ocLessInt';

      ocAddConst : Str := 'ocAddConst';
      ocSubConst : Str := 'ocSubConst';
      ocMulConst : Str := 'ocMulConst';
      ocDivConst : Str := 'ocDivConst';
      ocModConst : Str := 'ocModConst';
      ocSlashConst : Str := 'ocSlashConst';
      ocShlConst : Str := 'ocShlConst';
      ocShrConst : Str := 'ocShrConst';
      ocNotConst : Str := 'ocNotConst';
      ocOrConst  : Str := 'ocOrConst';
      ocXorConst : Str := 'ocXorConst';
      ocAndConst : Str := 'ocAndConst';
      ocGreaterEqualConst : Str := 'ocGreaterEqualConst';
      ocEqualConst : Str := 'ocEqualConst';
      ocLessEqualConst : Str := 'ocLessEqualConst';
      ocNotEqualConst : Str := 'ocNotEqualConst';
      ocGreaterConst : Str := 'ocGreaterConst';
      ocLessConst : Str := 'ocLessConst';
    end;
    Result := Str;
  end;

begin
  Item := TBinProgItem(prog^[Index]);
  with Item do
  begin
    Result := OpCodeToStr(Item);
    Result := Result + StringOfChar(' ', MaxLenStr - Length(Result) + 1);
    Result := Result + IntToStr(A) + ',' + StringOfChar(' ', 11 - Length(IntToStr(A))) + IntToStr(B);
  end;
end;

procedure TBinProg.GetProgInCodes(s : TStream);
var
  i: integer;
  Str: String;
  Beg: integer;
begin
  if ProgSize >= 10 then
  begin
    for i := 0 to 9 do
    begin
      Str := IntToStr(i) + ' : ' + ProgItemToStr(i) + #13 + #10;
      s.WriteBuffer(PChar(Str)^, Length(Str));
    end;
    Beg := 10;
  end
  else
    Beg := 0;
  for i:= Beg to ProgSize - 1 do
  begin
    Str := IntToStr(i) + ': ' + ProgItemToStr(i) + #13 + #10;
    s.WriteBuffer(PChar(Str)^, Length(Str));
  end;
end;

{***********************************************************}

{$IFDEF USECOMPILER}

procedure __VarClear(PV : POleVariant);
begin
  VarClear(PV^);
end;

type
//              =      <>     >     <     >=     <=
  TCondJump = (jtJE, jtJNE, jtJG, jtJL, jtJGE, jtJLE);

  TRegister = (rEAX, rEBX, rECX, rEDX);

  TRealCompiler = class(TWriter)
  private
    fStream  : TMemoryStream;
    fBinProg : TBinProg;
    JMPList  : TList;

    function _CurPosition : integer;
    function CreateJx(ofs : integer) : integer;

    procedure _CMPRegWordREF(reg : TRegister; ofs : integer; w : word); // cmp word ptr [reg + ofs], w

    procedure GetStackPtr(i : integer);
    procedure writebyte(b : byte);
    procedure WriteWord(w : word);
    procedure PutInt(p : integer);
    procedure WriteFPUOpcode(opcode : byte);
    procedure _MOVEAXVAL(i : integer);
    procedure _MOVEBXVAL(i : integer);
    procedure _MOVEDXVAL(i : integer);
    procedure _MOVECXVAL(i : integer);
    procedure _MOVEBXEAX;
    procedure _MOVEAXEBX;
    procedure _MOVEDXEBX;
    procedure _MOVEDXEAX;
    procedure _MOVECXEAX;
    procedure _MOVEDXECX;
    procedure _MOVECXEDX;
    procedure _SHLEAXCL;
    procedure _SHREAXCL;
    procedure _MOVEAXRefByte(ofs : integer; b : byte); // move byte ptr [eax + ofs], b

    procedure _MOVEAXREFWord(w : word);
    procedure _XCHGEAXEDX;
    procedure _XCHGEAXEBX;
    procedure _PUSHEAX;
    procedure _PUSHEDX;
    procedure _POPEDX;
    procedure _POPECX;
    procedure _ADDEDXVAL(i : integer);
//    procedure _ADDEBXVAL(i : integer);
//    procedure _INCEAX;
    procedure _DECEDX;
    procedure _INCEDX;
//    procedure _DECEBX;
//    procedure _INCEBX;
//    procedure _JMP(p : pointer);
    procedure _JMPEAX;
    procedure _JMPEBX;
    procedure _JMPEAXRef;
    procedure _RET;
    function  _JE(ofs : byte) : integer; // je +ofs
    function  _JNE(ofs : byte) : integer;
    function  _JLE(ofs : byte) : integer;
    function  _JL(ofs : byte) : integer;
    function  _JShort(ofs : byte) : integer;
    procedure _CDQ;
    procedure _ReferenceJump(jneaddr : integer);
    procedure _MOVEAXEAXREF(ofs : integer);
    procedure _MOVECXREFEAX(ofs : integer);
    procedure _MOVECXEBXREF(ofs : integer); // mov ecx, [ebx + ofs]
//    procedure _MOVEAXESPREF(ofs : integer);
    procedure _MOVEBXEDXREF(ofs : integer);
    procedure _MOVEAXREFEBX(ofs : integer);
    procedure _MOVECXREFWord(w : word);
    procedure _MOVEAXREFVal(ofs, val : integer); // mov [eax + ofs], val
    procedure _MOVEDXREFEAX(ofs : integer); // mov [edx + ofs], eax    
    procedure _CMPEAXREF(ofs, val : integer); // cmp [eax + ofs], val
    procedure _MOVMEMVAL(addr, val : integer);
//    procedure _ADDESPEAX;
//    procedure _SHLEAX(i : integer);
    procedure _NEGEBX;
    procedure _CMPMEMByte(addr : integer; val : byte); // cmp byte ptr [mem], val

    procedure UpdateCurPos(cpos : integer);

    procedure _NOP;
    procedure _ORALAL;
    procedure _NEGAL; // neg al
    procedure _MOVALMEM(addr : integer);
    procedure _MOVEDXMEM(addr : integer);
//    procedure _MOVEBXMEM(addr : integer);
    procedure _OREAXEAX;
    procedure CMPEBXWordRef(v : word);
    procedure CMPEDXWordRef(v : word); // cmp word ptr [eax], v
    procedure CMPEAXEBXREF(ofs : integer);
    procedure _MOVEBXREFEAX(ofs : integer); // mov [ebx + ofs], eax
    procedure _MOVEBXWordRef(v : word);
    procedure _CMPEAXWordREF(ofs : integer; w : word); // cmp word ptr [eax + ofs], w
    procedure _CMPEBXWordREF(ofs : integer; w : word); // cmp word ptr [ebx + ofs], w
    procedure _JMPOPCODE(a : integer);
    procedure _PUSHVAL(v : integer);
    procedure _SUBEAXEAX;
    procedure _SUBEDXEDX;
    procedure _SBBEAXEAX; // sbb eax, eax
    procedure _CMPAL(b : byte);

    procedure ProcessOp2(a, b, OpCode : integer);
    procedure Op2(OpCode : integer); // EAX and [EBX + 8]
    procedure _DoMove;
    procedure ProcessCMP(a, b, opcode : integer);
    procedure ProcessIfCondition(a, b, opcode : integer; cpos : integer);
    procedure ProcessLoadIntConst(a, b : integer);
    function  _JCond(JType : TCondJump; ofs : byte) : integer;
    procedure ProcessEndFinally;
    procedure ProcessReturn;
    procedure ProcessTrueFalseCheck(a, b : integer; val : boolean);
    procedure _AddCallItem(p : pointer);
    procedure ProcessIf(a, b : integer);
    procedure ProcessIncDecVar(opcode, a : integer);
    procedure ProcessIncDecVar2(opcode, a, b : integer);
    procedure ProcessMovRef(a, b : integer);
    procedure ProcessCallExternal(a, b : integer);
  public
    procedure _CallMethod(p : pointer);
    procedure _CallObjectMethod(p : pointer; Instance : TObject);
    procedure _CallProc(p : pointer);
    constructor Create(ABinProg : TBinProg; S : TMemoryStream);
    destructor Destroy; override;
    procedure   CompileOpCode(prog : pprogarray; cpos : integer);
    procedure   Link;
    procedure   ProcessArithFunc(opcode, a : integer);
  end;

type
  TJMPItemKind = (jkJx, jkJMPShort, jkJMPOpCode, jkCall);

  TJMPItem = class
    Position    : integer;
    Destination : integer;
    kind        : TJMPItemKind;
  end;

const
  CondJumpOpCodes: array[TCondJump] of byte = ($74, $75, $7F, $7C, $7D, $7E);

constructor TRealCompiler.Create(ABinProg : TBinProg; S : TMemoryStream);
begin
  inherited Create(S, 4096);
  fStream := S;
  fBinProg := ABinProg;

  JMPList := TList.Create;
end;

{-----------------------------------------------------------}

destructor TRealCompiler.Destroy;
var
  i : integer;
begin
  inherited;
  Link;
  for i := 0 to JMPList.Count - 1 do
    TObject(JMPList[i]).Free;

  JMPList.Free;
end;

{-----------------------------------------------------------}

function TRealCompiler._CurPosition : integer;
begin
  result := Position;
end;

{-----------------------------------------------------------}

procedure TRealCompiler.WriteByte(b : byte);
begin
  Write(b, 1);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.WriteWord(w : word);
begin
  WriteByte(w);
  WriteByte(w shr 8);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.PutInt(p : integer);
var
  i : integer;
begin
  for i := 1 to 4 do
    begin
      WriteByte(p);
      p := p shr 8;
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler.WriteFPUOpcode(opcode : byte);
begin
  WriteByte($D9);
  WriteByte(opcode);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXRefByte(ofs : integer; b : byte); // move byte ptr [eax], b
begin
  WriteByte($C6);
  if ofs = 0 then
    WriteByte($00)
  else if ofs < $7F then
    begin
      WriteByte($40);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($80);
      PutInt(ofs);
    end;
  WriteByte(b);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXREFWord(w : word);
begin
  WriteByte($66);
  WriteByte($C7);
  WriteByte($00);
  WriteWord(w);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXREFEAX(ofs : integer); // mov [edx + ofs], eax
begin
  WriteByte($89);
  if ofs = 0 then
    WriteByte($02)
  else if ofs < $7F then
    begin
      WriteByte($42);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($82);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXREFVal(ofs, val : integer); // mov [eax + ofs], val
begin
  WriteByte($C7);
  if ofs = 0 then
    WriteByte($00)
  else if ofs < $7F then
    begin
      WriteByte($40);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($80);
      PutInt(ofs);
    end;
  PutInt(val);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXVAL(i : integer); // mov eax, i
begin
  if i = 0 then
    _SUBEAXEAX
  else
    begin
      WriteByte($B8);
      PutInt(i);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEBXVAL(i : integer);
begin
  WriteByte($BB);
  PutInt(i);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXVAL(i : integer); // mov edx, i
begin
  if i = 0 then
    _SUBEDXEDX
  else
    begin
      WriteByte($BA);
      PutInt(i);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXVAL(i : integer); // mov ecx, i
begin
  WriteByte($B9);
  PutInt(i);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEBXEAX;  // mov ebx, eax
begin
  WriteByte($8B);
  WriteByte($D8);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXEBX; // mov eax, ebx
begin
  WriteByte($8B);
  WriteByte($C3);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXEBX; // mov edx, ebx
begin
  WriteByte($8B);
  WriteByte($D3);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXEAX; // mov edx, eax
begin
  WriteByte($8B);
  WriteByte($D0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXEAX;
begin
  WriteByte($8B);
  WriteByte($C8);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXECX;
begin
  WriteByte($8B);
  WriteByte($D1);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXEDX;
begin
  WriteByte($8B);
  WriteByte($CA);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._XCHGEAXEDX;
begin
  WriteByte($92);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._SHLEAXCL;
begin
  WriteByte($D3);
  WriteByte($E0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._SHREAXCL;
begin
  WriteByte($D3);
  WriteByte($E8);
end;

{
procedure TRealCompiler._JMP(p : pointer);
begin
  WriteByte($E9);
  PutInt(integer(p) - integer(CurPosition) - 4);
end;
}
{-----------------------------------------------------------}

procedure TRealCompiler._JMPEAX; // jmp eax
begin
  WriteByte($FF);
  WriteByte($E0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._JMPEAXRef; // jmp [eax]
begin
  WriteByte($FF);
  WriteByte($20);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._JMPEBX; // jmp ebx
begin
  WriteByte($FF);
  WriteByte($E3);  
end;

{-----------------------------------------------------------}

procedure TRealCompiler._RET; // ret
begin
  WriteByte($C3);
end;

{-----------------------------------------------------------}

function TRealCompiler.CreateJx(ofs : integer) : integer;
var
  jmpitem : TJMPItem;
begin
  jmpitem := TJMPItem.Create;
  jmpitem.kind := jkJx;
  jmpitem.Position := _CurPosition;
  jmpitem.Destination := _CurPosition + 2 + ofs;
  result := JMPList.Add(jmpitem);
end;

{-----------------------------------------------------------}

function TRealCompiler._JCond(JType : TCondJump; ofs : byte) : integer;
begin
  result := Createjx(ofs);
  WriteByte(CondJumpOpCodes[JType]);
  WriteByte(ofs);
end;

{-----------------------------------------------------------}

function  TRealCompiler._JE(ofs : byte) : integer; // je +ofs
begin
  result := _JCond(jtJE, ofs);
end;

{-----------------------------------------------------------}

function TRealCompiler._JNE(ofs : byte) : integer; // jne +ofs
begin
  result := _JCond(jtJNE, ofs);
end;

{-----------------------------------------------------------}

function  TRealCompiler._JLE(ofs : byte) : integer;
begin
  result := _JCond(jtJLE, ofs);
end;

{-----------------------------------------------------------}

function  TRealCompiler._JL(ofs : byte) : integer;
begin
  result := _JCond(jtJL, ofs);
end;

{-----------------------------------------------------------}

function  TRealCompiler._JShort(ofs : byte) : integer;
var
  jmpitem : TJMPItem;
begin
  jmpitem := TJMPItem.Create;
  jmpitem.kind := jkJMPShort;
  jmpitem.Position := _CurPosition;
  jmpitem.Destination := _CurPosition + 2 + ofs;
  result := JMPList.Add(jmpitem);
  WriteByte($EB);
  WriteByte(ofs);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._NOP; // nop
begin
  WriteByte($90);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._ORALAL; // or al, al
begin
  WriteByte($0A);
  WriteByte($C0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._OREAXEAX; // or eax, eax
begin
  WriteByte($0B);
  WriteByte($C0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEBXREFEAX(ofs : integer); // mov [ebx + ofs], eax
begin
  if ofs < $7F then
    begin
      WriteByte($89);
      WriteByte($43);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($89);
      WriteByte($83);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEBXWordRef(v : word);
begin
  WriteByte($66);
  WriteByte($C7);
  WriteByte($03);
  WriteWord(v);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPRegWordREF(reg : TRegister; ofs : integer; w : word); // cmp word ptr [reg + ofs], w
const
  ofs0codes : array[TRegister] of byte = ($38, $3B, $39, $3A);
  ofscodes  : array[TRegister] of byte = ($78, $7B, $79, $7A);
begin
  if w <= $7F then
    begin
      WriteByte($66);
      WriteByte($83);
      if ofs = 0 then
        WriteByte(ofs0codes[reg])
      else
        begin
          WriteByte(ofscodes[reg]);
          WriteByte(ofs);
        end;

      WriteByte(w);
    end
  else
    begin
      WriteByte($66);
      WriteByte($81);
      if ofs = 0 then
        WriteByte(ofs0codes[reg])
      else
        begin
          WriteByte(ofscodes[reg]);
          WriteByte(ofs);
        end;
      WriteWord(w);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPEAXWordREF(ofs : integer; w : word); // cmp word ptr [eax + ofs], w
begin
  _CMPRegWordREF(rEAX, ofs, w);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPEBXWordREF(ofs : integer; w : word); // cmp word ptr [ebx + ofs], w
begin
  _CMPRegWordREF(rEBX, ofs, w);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.CMPEBXWordRef(v : word); // cmp word ptr [ebx], v
begin
  if v <= $7F then
    begin
      WriteByte($66);
      WriteByte($83);
      WriteByte($3B);
      WriteByte(v);
    end
  else
    begin
      WriteByte($66);
      WriteByte($81);
      WriteByte($3B);
      WriteWord(v);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler.CMPEAXEBXREF(ofs : integer); // cmp eax, [ebx + ofs]
begin
  WriteByte($3B);
  if ofs = 0 then
    WriteByte($03)
  else if ofs < $7F then
    begin
      WriteByte($43);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($83);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._SUBEAXEAX;
begin
  WriteByte($2B);
  WriteByte($C0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._SUBEDXEDX;
begin
  WriteByte($2B);
  WriteByte($D2);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._AddCallItem(p : pointer);
var
  jmpitem : TJMPItem;
begin
  WriteByte($E8);

  jmpitem := TJMPItem.Create;
  jmpitem.kind := jkCall;
  jmpitem.Position := _CurPosition;
  jmpitem.Destination := integer(p);
  JMPList.Add(jmpItem);

  PutInt(0); //integer(p) - integer(CurPosition) - 4);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CallObjectMethod(p : pointer; Instance : TObject);
begin
  _MOVEAXVAL(integer(Instance));
  _AddCallItem(p);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CallMethod(p : pointer);
begin
  _CallObjectMethod(p, fBinProg);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CallProc(p : pointer);
begin
  _AddCallItem(p);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._JMPOPCODE(a : integer);
var
  jmpitem : TJmpItem;
begin
  jmpitem := TJMPItem.Create;
  jmpitem.kind := jkJmpOpCode;
  jmpitem.Position := integer(_CurPosition);
  jmpitem.Destination := a;
  JMPList.Add(jmpitem);
  _NOP; // jmp
  _NOP;
  _NOP;
  _NOP;
  _NOP;
{  _MOVEAXVAL(integer(fBinProg.OpcodesAddr) + a * sizeof(pointer));
  _JMPEAXRef;
}
end;

{-----------------------------------------------------------}

procedure TRealCompiler._PUSHVAL(v : integer);
begin
  if v < $80 then
    begin
      WriteByte($6A);
      WriteByte(v);
    end
  else
    begin
      WriteByte($68);
      PutInt(v);
    end;
end;

{-----------------------------------------------------------}

type
  TOp2Procs = array[ocNop..ocLess] of pointer;

var
  Op2Procs : ^TOp2Procs;
  VarToRealAddr : pointer;
  VarFromRealAddr : pointer;

procedure FillOpProcs; assembler;
asm
  DD    0
  DD    System.@VarAdd
  DD    System.@VarSub
  DD    System.@VarMul
  DD    System.@VarDiv
  DD    System.@VarMod
  DD    System.@VarShl
  DD    System.@VarShr
  DD    System.@VarNot
  DD    System.@VarOr
  DD    System.@VarXor
  DD    System.@VarAnd
  DD    _Slash // not used
  DD    _GreaterEqual
  DD    _Equal
  DD    _LessEqual
  DD    _NotEqual
  DD    _Greater
  DD    _Less
end;

type
  TArithProcs = array[ocCos..ocExp] of pointer;

var
  ArithProcs : ^TArithProcs;

procedure FillArithProcs; assembler;
asm
  DD    System.@Cos
  DD    System.@Sin
  DD    System.@Exp
end;

procedure VarToRealProc; assembler;
asm
  DD System.@VarToReal
end;

procedure VarFromRealProc; assembler;
asm
  DD System.@VarFromReal
end;

const
  PushProcs : array[ocPush..ocPushRef] of pointer =
(
 @TBinProg._Push,
 @TBinProg._Pop,
 @TBinProg._PushRef
);

  InternalProcs : array[ocEvaluate .. ocUnloadUnit] of pointer =
(
 @TBinProg._Evaluate,
 @TBinProg._UseUnit,
 @TBinProg._UnloadUnit
);


  ifjmpcode : array[ocIfGreaterInt .. ocIfGreaterEqualInt] of byte =
(
  $7F,  // ocIfGreaterInt       jg
  $7C,  // ocIfLessInt          jl
  $75,  // ocIfNotEqualInt      jne
  $74,  // ocIfEqualInt         je
  $7E,  // ocIfLessEqualInt     jle
  $7D   // ocIfGreaterEqualInt  jnl
);

  cmpprocs : array[ocIfGreater .. ocIfGreaterEqual] of pointer =
(
 @_IsGreater,
 @_IsLess,
 @_IsNotEqual,
 @_IsEqual,
 @_IsLessEqual,
 @_IsGreaterEqual
);

  CondJumps : array[ocIfGreater .. ocIfGreaterEqual] of TCondJump =
  (jtJG, jtJL, jtJNE, jtJE, jtJLE, jtJGE);

{-----------------------------------------------------------}

procedure TRealCompiler.GetStackPtr(i : integer);
begin
  if i >= MaxStackSize * 2 then // global var
    _MOVEAXVAL(integer(@(fBinProg.StaticVars[i - MaxStackSize * 2])))
  else if i >= MaxStackSize then // ref var
    begin
      _MOVEDXVAL(i);
      _CallMethod(Addr(TBinProg._makestackptr));
    end
{  else if i >= 0 then
    _MOVEAXESPREF(i * 4)}
  else
    begin
      _MOVEDXMEM(integer(@fBinProg.fMainThreadVars.fBaseStackPointer));
      _ADDEDXVAL(i);
      _CallObjectMethod(@TVariantStack.Items, fBinProg.fMainThreadVars.fStack);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._ReferenceJump(jneaddr : integer);
begin
  TJMPItem(JMPList[jneaddr]).Destination := integer(_CurPosition);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._XCHGEAXEBX;
begin
  WriteByte($93);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXREFEBX(ofs : integer); // mov [eax + ofs], ebx
begin
  WriteByte($89);
  if ofs = 0 then
    WriteByte($18)
  else if ofs < $7F then
    begin
      WriteByte($58);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($98);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEBXEDXREF(ofs : integer); // mov ebx, [edx + ofs]
begin
  WriteByte($8B);
  if ofs = 0 then
    WriteByte($1A)
  else if ofs < $7F then
    begin
      WriteByte($5A);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($9A);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXREFWord(w : word); // mov word ptr [ecx], w
begin
  WriteByte($66);
  WriteByte($C7);
  WriteByte($01);
  WriteWord(w);
end;

{-----------------------------------------------------------}

(*
procedure TRealCompiler._MOVEAXESPREF(ofs : integer);
begin
  WriteByte($8B);
  if ofs = 0 then
    begin
      WriteByte($04);
      WriteByte($24);
    end
  else if ofs < $7F then
    begin
      WriteByte($44);
      WriteByte($24);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($84);
      WriteByte($24);
      PutInt(ofs);
    end;
end;
*)
{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXEBXREF(ofs : integer); // mov ecx, [ebx + ofs]
begin
  WriteByte($8B);
  if ofs = 0 then
    WriteByte($0B)
  else if ofs < $7F then
    begin
      WriteByte($4B);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($8B);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVECXREFEAX(ofs : integer); // mov [ecx + ofs], eax
begin
  WriteByte($89);
  if ofs = 0 then
    WriteByte($01)
  else if ofs < $7F then
    begin
      WriteByte($41);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($81);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVEAXEAXREF(ofs : integer); // mov eax, [eax + ofs]
begin
  WriteByte($8B);
  if ofs = 0 then
    WriteByte($00)
  else if ofs < $7F then
    begin
      WriteByte($40);
      WriteByte(ofs);
    end
  else
    begin
      WriteByte($80);
      PutInt(ofs);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._SBBEAXEAX; // sbb eax, eax
begin
  WriteByte($1B);
  WriteByte($C0);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._NEGAL; // neg al
begin
  WriteByte($F6);
  WriteByte($D8);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPAL(b : byte);
begin
  WriteByte($3C);
  WriteByte(b);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._PUSHEDX;
begin
  WriteByte($52);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._POPECX;
begin
  WriteByte($59);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._POPEDX;
begin
  WriteByte($5A);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._DECEDX;
begin
  WriteByte($4A);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._INCEDX;
begin
  WriteByte($42);
end;

{-----------------------------------------------------------}
(*
procedure TRealCompiler._DECEBX;
begin
  WriteByte($4B);
end;
*)
{-----------------------------------------------------------}
(*
procedure TRealCompiler._INCEBX;
begin
  WriteByte($43);
end;
*)
{-----------------------------------------------------------}

(*
procedure TRealCompiler._INCEAX;
begin
  WriteByte($40);
end;
*)
{-----------------------------------------------------------}
(*
procedure TRealCompiler._ADDEBXVAL(i : integer);
begin
  case i of
    -1 : _DECEBX;
    0  : exit;
    1  : _INCEBX;
  else
    if (i < $80) and (i > - $7F) then
      begin
        WriteByte($83);
        WriteByte($C3);
        WriteByte(i);
      end
    else
      begin
        WriteByte($81);
        WriteByte($C3);
        PutInt(i);
      end;
  end;
end;
*)
{-----------------------------------------------------------}

procedure TRealCompiler._ADDEDXVAL(i : integer);
begin
  case i of
    -1 : _DECEDX;
    0  : exit;
    1  : _INCEDX;
  else
    if (i < $80) and (i > - $7F) then
      begin
        WriteByte($83);
        WriteByte($C2);
        WriteByte(i);
      end
    else
      begin
        WriteByte($81);
        WriteByte($C2);
        PutInt(i);
      end;
  end;
end;

{-----------------------------------------------------------}
(*
procedure TRealCompiler._SHLEAX(i : integer);
begin
  WriteByte($C1);
  WriteByte($E0);
  WriteByte(i);
end;
*)
{-----------------------------------------------------------}
(*
procedure TRealCompiler._ADDESPEAX;
begin
  WriteByte($03);
  WriteByte($E0);
end;
*)
{-----------------------------------------------------------}

procedure TRealCompiler._NEGEBX;
begin
  WriteByte($F7);
  WriteByte($DB);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVALMEM(addr : integer); // mov al, [addr]
begin
  WriteByte($A0);
  PutInt(addr);
end;

{-----------------------------------------------------------}
(*
procedure TRealCompiler._MOVEBXMEM(addr : integer); // mov ebx, [addr]
begin
  WriteByte($8B);
  WriteByte($1D);
  PutInt(addr);
end;
*)
{-----------------------------------------------------------}

procedure TRealCompiler._MOVEDXMEM(addr : integer); // mov eax, [addr]
begin
  WriteByte($8B);
  WriteByte($15);
  PutInt(addr);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.CMPEDXWordRef(v : word); // cmp word ptr [edx], v
begin
  if v <= $7F then
    begin
      WriteByte($66);
      WriteByte($83);
      WriteByte($3A);
      WriteByte(v);
    end
  else
    begin
      WriteByte($66);
      WriteByte($81);
      WriteByte($3A);
      WriteWord(v);
    end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._MOVMEMVAL(addr, val : integer); // mov [mem], val
begin
  WriteByte($C7);
  WriteByte($05);
  PutInt(addr);
  PutInt(val);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPMEMByte(addr : integer; val : byte); // cmp byte ptr [mem], val
begin
  WriteByte($80);
  WriteByte($3D);
  PutInt(addr);
  WriteByte(val);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.UpdateCurPos(cpos : integer);
var
  j1 : integer;
  j2 : integer;
begin
  _CMPMEMByte(integer(@fBinProg.fStop), 0);
  j1 := _JE(0);

  _CallMethod(@TBinProg.LeaveProc);
  //_CallObjectMethod(@TIntStack.Pop, fBinProg.fStacks);
  _RET;

  _ReferenceJump(j1);
  _CMPMEMByte(integer(@fBinProg.fDebugging), 0);
  j2 := _JE(0);
  _MOVMEMVAL(integer(@fBinProg.fMainThreadVars.curpos), cpos - 1);
{$IFDEF ACTIVESCRIPTING}
  _CallMethod(@TBinProg.BeforeDispatch);
{$ENDIF}
  _ReferenceJump(j2);
  _MOVMEMVAL(integer(@fBinProg.fMainThreadVars.curpos), cpos);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.Link;
var
  i        : integer;
  delta    : integer;
  memstart : integer;
begin
  memstart := integer(fStream.Memory);
  for i := 0 to JMPList.Count - 1 do
    with TJMPItem(JMPList[i]) do
      begin
        case kind of
          jkJx, jkJMPShort : begin
                               delta := Destination - Position - 2;
                               (PChar(Position) + memstart + 1)^ := char(delta);
                             end;
          jkJMPOpCode :
                        begin
                          delta := integer(fBinProg.OpCodesAddr[Destination]) - Position - 2;
                          inc(Position, memstart);
                          if (delta > 127) or (delta < -127) then
                            begin
                              dec(delta, 3);
                              PChar(Position)^ := char($E9);
                              PInt(PChar(Position) + 1)^ := delta;
                            end
                          else
                            begin
                              PChar(Position)^ := char($EB);
                              (PChar(Position) + 1)^ := char(delta);
                            end;
                        end;

           jkCall :     begin
                          delta := Destination - Position - memstart;
                          PInt(Pchar(Position) + memstart)^ := delta - 4;
                        end;
        end;
      end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CDQ;
begin
  WriteByte($99);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._CMPEAXREF(ofs, val : integer); // cmp [eax + ofs], val
begin
  if val < $80 then
    WriteByte($83)
  else
    WriteByte($81);

  WriteByte($78);
  WriteByte($08);

  if val < $80 then
    WriteByte(val)
  else
    PutInt(val);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.Op2(OpCode : integer); // EAX and [EBX + 8]
begin
  case OpCode of
    ocAdd : begin
              WriteByte($03);  // add eax, [ebx + 8]
              WriteByte($43);
              WriteByte($08);
            end;

    ocSub : begin
              WriteByte($2B);  // sub eax, [ebx + 8]
              WriteByte($43);
              WriteByte($08);
            end;

    ocMul : begin
              WriteByte($0F);  // imul eax, [ebx + 8]
              WriteByte($AF);
              WriteByte($43);
              WriteByte($08);
            end;

    ocDiv, ocMod :
            begin
              _CDQ;
              WriteByte($F7); // idiv [ebx + 8]
              WriteByte($7B);
              WriteByte($08);

              if OpCode = ocMod then
                _XCHGEAXEDX;
            end;


    ocShl, ocShr : begin
                     _MOVEDXECX;
                     _MOVECXEBXREF(8);
                     if OpCode = ocShl then
                       _SHLEAXCL
                     else
                       _SHREAXCL;
                     _MOVECXEDX;
                   end;

    ocNot   : begin                 // not eax
                WriteByte($F7);
                WriteByte($D0);
              end;

    ocOr    : begin
                WriteByte($0B); // or eax, [ebx + 8]
                WriteByte($43);
                WriteByte($08);
              end;

    ocXor   : begin
                WriteByte($33); // xor eax, [ebx + 8]
                WriteByte($43);
                WriteByte($08);
              end;

    ocAnd   : begin
                WriteByte($23); // and eax, [ebx + 8]
                WriteByte($43);
                WriteByte($08);
              end;
  end;
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessOp2(a, b, OpCode : integer);
var
  j1, j2, j3 : integer;
begin
      {
       getPSA
       mov ebx, eax
       getPSB
       cmp word ptr [eax], varInteger
       jne l1
       cmp word ptr [ebx], varInteger
       jne l1

       mov ecx, eax
       mov eax, [eax + 8]
       op  eax, [ebx + 8]
       mov [ecx + 8], eax
       jmp q
    l1:
       ;eax = b
       ;ebx = a
       mov edx, eax
       xchg eax, edx
       Op2Procs[OpCode]
    q:
      }
  GetStackPtr(a);
  _MOVEBXEAX;

  if OpCode > ConstOpsBase then
    begin
      _MOVEAXVAL(integer(@fBinProg.fConsts[b]));
      dec(OpCode, ConstOpsBase);
    end
  else
    GetStackPtr(b);

  _CMPEAXWordRef(0, varInteger);
  j1 := _JNE(0);
  CMPEBXWordRef(varInteger);
  j2 := _JNE(0);

  _XCHGEAXEBX;
  _MOVECXEAX;
  _MOVEAXEAXREF(8);
  Op2(OpCode);
  _MOVECXREFEAX(8);

  j3 := _JShort(0);

  _ReferenceJump(j1);
  _ReferenceJump(j2);
  _MOVEDXEBX;
  _XCHGEAXEDX;

  _CallProc(Op2Procs[OpCode]);

  _ReferenceJump(j3);
end;

{-----------------------------------------------------------}

const setcmpcodes : array[ocGreaterEqual .. ocLess] of byte =
(
 $9D, // >= setnl
 $94, // =  sete
 $9E, // <= setle
 $95, // <> setne
 $9F, // >  setg
 $9C  // <
);

procedure TRealCompiler.ProcessCMP(a, b, opcode : integer);
var
  j1, j2, j3 : integer;
begin
{
 getPSB
 mov ebx, eax
 getPSA
 cmp word ptr [eax], varInteger
 jne l1
 cmp word ptr [ebx], varInteger
 jne l1
 mov ecx, eax
 mov eax, [eax + 8]
 cmpop eax, [ebx + 8]
 setcmp al
 neg al
 sbb eax, eax
 mov word ptr [ecx + 8], eax
 jmp q
l1:
 Op2Procs
q:
}
  if OpCode > ConstOpsBase then
    begin
      _MOVEBXVAL(integer(@fBinProg.fConsts[b]));
      dec(OpCode, ConstOpsBase);
    end
  else
    begin
      GetStackPtr(b);
      _MOVEBXEAX;
    end;

  GetStackPtr(a);
  _CMPEAXWORDREF(0, varInteger);
  j1 := _JNE(0);
  CMPEBXWORDREF(varInteger);
  j2 := _JNE(0);


  _MOVECXEAX;
  _MOVEAXEAXREF(8);
  CMPEAXEBXREF(8);

  WriteByte($0F);
  WriteByte(setcmpcodes[OpCode]);
  WriteByte($C0);

  _NEGAL;
  _SBBEAXEAX;
  _MOVECXREFEAX(8);
  _MOVECXREFWORD(varBoolean);

  j3 := _JShort(0);

  _ReferenceJump(j1);
  _ReferenceJump(j2);
  _MOVEDXEBX;
  _CallProc(Op2Procs[OpCode]);
  _ReferenceJump(j3);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._DoMove;  // eax <- edx
{
  cmp word ptr [edx], varInteger
  jne l2
  cmp word ptr [eax], varInteger
  jne l1
  mov ebx, [edx + 8]
  mov [eax + 8], ebx
  jmp q
l1:
  cmp  word ptr [eax], varOleStr
  jl   l3
  mov  ebx,eax
  push edx
  VarClear
  pop  edx
  mov  eax, ebx
l3:
  mov word ptr [eax], varInteger
  mov ebx, [edx + 8]
  mov [eax + 8], ebx
  jmp q
l2:
  _Mov
q:
}
var
  j1, j2, j3, j4 : integer;
begin
  CMPEDXWordRef(varInteger);
  j1 := _JNE(0);

  _CMPEAXWordRef(0, varInteger);
  j2 := _JNE(0);

  _MOVEBXEDXREF(8);
  _MOVEAXREFEBX(8);

  j3 := _JShort(0);

  {l1}
  _ReferenceJump(j2);

  _CMPEAXWordRef(0, varOleStr);
  j4 := _JL(0);
  _MOVEBXEAX;
  _PUSHEDX;
  _CallProc(@__VarClear);
  _POPEDX;
  _MOVEAXEBX;
  {l3}
  _ReferenceJump(j4);
  _MOVEAXREFWord(varInteger);
  _MOVEBXEDXREF(8);
  _MOVEAXREFEBX(8);
  j4 := _JShort(0);
  {l2}
  _ReferenceJump(j1);
  _CallProc(@_Mov);
  {q}
  _ReferenceJump(j3);
  _ReferenceJump(j4);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessIfCondition(a, b, opcode : integer; cpos : integer);
{
if allint then
                         begin
                           if vinteger <= bint then
                             inc(CurPos)
                         end
                       else if PSA^ <= PSB^ then
                         inc(CurPos);

 getPSB
 mov ebx, eax
 getPSA
 cmp word ptr [eax], varInteger
 jne l1
 cmp word ptr [ebx], varInteger
 jne l1
 mov eax, [eax + 8]
 cmp eax, [ebx + 8]
 jcond q
 jmp cpos + 2
l1:
 _VarCMPProc
 or al, al
 jne q
 jmp cpos + 2
q:

}
var
  j1 : integer;
  j2 : integer;
  jc : integer;
begin
  if OpCode > ConstOpsBase then
    begin
      _MOVEBXVAL(integer(@fBinProg.fConsts[b]));
      dec(OpCode, ConstOpsBase);
    end
  else
    begin
      GetStackPtr(b);
      _MOVEBXEAX;
    end;

  GetStackPtr(a);
  _CMPEAXWORDREF(0, varInteger);
  j1 := _JNE(0);
  CMPEBXWORDREF(varInteger);
  j2 := _JNE(0);
  _MOVEAXEAXREF(8);
  CMPEAXEBXREF(8);

  jc := _JCond(CondJumps[opcode], 0);
  _JMPOPCODE(cpos + 2);

  {l1: }
  _ReferenceJump(j1);
  _ReferenceJump(j2);

  _MOVEDXEBX;
  _CallProc(CmpProcs[opCode]);
  _ORALAL;
  j1 := _JNE(0);
  _JMPOPCODE(cpos + 2);
  {q: }
  _ReferenceJump(j1);
  _ReferenceJump(jc);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessLoadIntConst(a, b : integer);
{
  getpsa
  cmp word ptr [eax], varOleStr
  jl  l1
  mov edx, b
  _LoadIntConst
  jmp q
l1:
  mov word ptr [eax], varInteger
  mov [eax + 8], b
q:
}
var
  j1 : integer;
  j2 : integer;
begin
  GetStackPtr(a);
  _CMPEAXWordRef(0, varOleStr);
  j1 := _JL(0);
  _MOVEDXVAL(b);
  _CallProc(@_LoadIntConst);

  j2 := _JShort(0);
  {l1}
  _ReferenceJump(j1);
  _MOVEAXREFWord(varInteger);
  _MOVEAXREFVal(8, b);
  _ReferenceJump(j2);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessReturn;
  { call DoReturn2
    or   eax, eax
    jle  l1
    jmp  [eax]
 l1:
    mov  ebx, eax
    call fStacks.Pop
    add  esp, eax
    neg  ebx
    jne  l2
    ret
 l2:
    jmp  ebx
  }
var
  j1 : integer;
begin
  _CallMethod(@TBinProg.DoReturn2);
  _OREAXEAX;
  j1 := _JLE(0);
  _JMPEAX;
  _ReferenceJump(j1);
  _MOVEBXEAX;

  (*
  _CallObjectMethod(@TIntStack.Pop, fBinProg.fStacks);
  _INCEAX;
  _SHLEAX(2);
  _ADDESPEAX;
  *)
  
  _NEGEBX;
  j1 := _JNE(0);
  _RET;
  _ReferenceJump(j1);
  _JMPEBX;
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessEndFinally;
var
  jgoto   : integer;
  jreturn : integer;
  jq      : integer;
begin
{
case fFinallyReason of
  frNormal : ;
  frGoto : GotoNewPlace(fGotoPos);
  frReturn : result := DoReturn > 0;
  frExcept : if not FindExceptHandler then
              raise Exception.Create(fExceptMessage);
end;
}
{
 mov al, fFinallyReason
 cmp al, frGoto
 je  @goto
 cmp al, frReturn
 je  @return
 cmp al, frExcept
 jne q
 _FinallyExcept

@goto:
 _JMPOPCODE(fgotopos);
@return
 ... // ProcessReturn
q:
}
  _MOVALMEM(integer(@fBinProg.fMainThreadVars.fFinallyReason));
  _CMPAL(byte(frGoto));
  jgoto := _JE(0);

  _CMPAL(byte(frReturn));
  jreturn := _JE(0);

  _CMPAL(byte(frExcept));
  jq := _JNE(0);

  _CallMethod(@TBinProg._FinallyExcept);
  _JMPEAX;

  {@goto}
  _ReferenceJump(jgoto);

  _MOVEAXVAL(integer(@fBinProg.fMainThreadVars.fGotoPos));
  _MOVEDXVAL(integer(fBinProg.OpcodesAddr));
  _MOVEAXEAXREF(0);

  WriteByte($8B);                       // mov eax, [edx + eax * 4]
  WriteByte($04);
  WriteByte($82);
  _JMPEAX;

  {@return}
  _ReferenceJump(jreturn);
  ProcessReturn;

  {q}
  _ReferenceJump(jq);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessTrueFalseCheck(a, b : integer; val : boolean);
var
  j1 : integer;
  j2 : integer;
begin
{
  getpsa
  cmp  word ptr [eax], varBoolean
  jne q
  cmp word ptr [eax + 8], 0
  jne/je  q
  _JMPOPCODE(b)
q:
}
  GetStackPtr(a);
  _CMPEAXWordRef(0, varBoolean);
  j1 := _JNE(0);
  _CMPEAXWordRef(8, 0);
  if val then
    j2 := _JE(0)
  else
    j2 := _JNE(0);
  _JMPOPCODE(b);
  {q:}
  _ReferenceJump(j2);
  _ReferenceJump(j1);
end;

{-----------------------------------------------------------}

procedure TRealCompiler._PUSHEAX;
begin
  WriteByte($50);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessIf(a, b : integer);
var
  j1 : integer;
  j2 : integer;
  j3 : integer;
{
   getPSA
   cmp [eax], varBoolean
   jne li
   cmp word ptr [eax + 8], 0
   jne q
   jmp [b]
li:
   cmp [eax], varInteger
   jne l1
   cmp [eax + 8], 0
   jne q
   jmp [b]
l1:
   call VarIsTrue
   or al, al
   jne q
   jmp [b]
q:
}
begin
  GetStackPtr(a);
  _CMPEAXWordRef(0, varBoolean);
  j1 := _JNE(0); // l1
  _CMPEAXWordRef(8, 0);
  j2 := _JNE(0); // quit
  _JMPOPCODE(b);

  // l1:
  _ReferenceJump(j1);

  _CallProc(@_VarIsTrue);
  _ORALAL;
  j3 := _JNE(0); //q
  _JMPOPCODE(b);
  _ReferenceJump(j2);
  _ReferenceJump(j3);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessIncDecVar2(opcode, a, b : integer);
{
  getPSB
  mov ebx, eax
  getPSA
  cmp word ptr [eax], varInteger
  jne l
  cmp word ptr [ebx], varInteger
  jne l
  mov edx, eax
  mov eax, [eax + 8] // a
  add/sub eax, [ebx + 8]
  mov [edx + 8], eax
  jmp q
l:
  mov edx, ebx
  call _Add/_Sub
q:
}
var
  j1 : integer;
  j2 : integer;
  j3 : integer;
begin
  GetStackPtr(b);
  _MOVEBXEAX;
  GetStackPtr(a);
  _CMPEAXWordRef(0, varInteger);
  j1 := _JNE(0);

  _CMPEBXWordRef(0, varInteger);
  j2 := _JNE(0);

  _MOVEDXEAX;

  _MOVEAXEAXREF(8);
  if OpCode = ocIncVar2 then
    WriteByte($03) // add eax, [ebx + 8]
  else
    WriteByte($2B);// sub eax, [ebx + 8]

  WriteByte($43);
  WriteByte($08);

  _MOVEDXREFEAX(8);
  j3 := _JShort(0);

  _ReferenceJump(j1);
  _ReferenceJump(j2);
  _MOVEDXEBX;
  if OpCode = ocIncVar2 then
    _CallProc(@_Add)
  else
    _CallProc(@_Sub);

  _ReferenceJump(j3);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessIncDecVar(opcode, a : integer);
var
  j1 : integer;
  j2 : integer;
begin
{
 getstackptr
 cmp [eax], varinteger
 jne l
 inc [eax + 8]
 jmp q
l:
 call _Inc
q:
}
  GetStackPtr(a);
  _CMPEAXWordRef(0, varInteger);
  j1 := _JNE(0);

  WriteByte($FF);
  if opCode = ocIncVar then
   WriteByte($40)  // inc dword ptr [eax + 8]
  else
   WriteByte($48); // dec dword ptr [eax + 8]

  WriteByte($8);

  j2 := _JShort(0);
  _ReferenceJump(j1);

  if opCode = ocIncVar then
   _CallProc(@_Inc)
  else
   _CallProc(@_Dec);

  _ReferenceJump(j2);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessMovRef(a, b : integer);
{
  GetPSA
  mov ebx, eax
  cmp word ptr [eax], varOleStr
  jl  l1
  call VarClear
l1:
  GetPSB
  mov [ebx + 8], eax
  mov [ebx], VarByRef or VarVariant
}
var
  j1 : integer;
begin
  GetStackPtr(a);
  _MOVEBXEAX;
  _CMPEAXWordRef(0, varOleStr);
  j1 := _JL(0);
  _CallProc(@__VarClear);
  _ReferenceJump(j1);
  GetStackPtr(b);
  _MOVEBXREFEAX(8);
  _MOVEBXWordRef(VarByRef or VarVariant);
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessCallExternal(a, b : integer);
{
 getpsa
 mov edx, b

}
begin
  GetStackPtr(a);
  _MOVECXVAL(b);
  _MOVEDXEAX;
  _CallMethod(Addr(TBinProg._CallExternal));
end;

{-----------------------------------------------------------}

procedure TRealCompiler.ProcessArithFunc(opcode, a : integer);
{
  GetPSA
  mov ebx, eax
  call _VarToReal
  call Func
  mov  eax, ebx
  call _VarFromReal
}
begin
  GetStackPtr(a);
  _MOVEBXEAX;
  _CallProc(VarToRealAddr);
  case opcode of
    ocCos, ocSin, ocExp : _CallProc(ArithProcs[opcode]);

    ocLn : begin
             WriteFPUOpCode($ED); // fldln2
             WriteFPUOpCode($C9); // fxchst(1)
             WriteFPUOpCode($F1); // fylx2
           end;

    ocArcTan : begin
                 WriteFPUOpCode($E8); // fld1
                 WriteFPUOpCode($F3); // fpatan
               end;

    ocSqr : WriteFPUOpCode($C8); // fmul st(0)

    ocSqrt : WriteFPUOpCode($FA); // fsqrt
  end;
  _CallProc(VarFromRealAddr);
end;

{-----------------------------------------------------------}

procedure   TRealCompiler.CompileOpCode(prog : pprogarray; cpos : integer);
var
  Item : TBinProgItem;
begin
  Item := prog^[cpos];
  with Item do
    case OpCode of
      ocNop : exit;

      ocAdd .. ocAnd : ProcessOp2(a, b, OpCode);

      ocSlash          : begin
                           GetStackPtr(b);
                           _MOVEBXEAX;
                           GetStackPtr(a);
                           _MOVEDXEBX;
                           _CallProc(@_Slash);
                         end;

      ocGreaterEqual .. ocLess : ProcessCMP(a, b, OpCode);

      ocIfGreater .. ocIfGreaterEqual : ProcessIfCondition(a, b, OpCode, cpos);

      ocIF              : ProcessIf(a, b);

      ocloadconst       : begin
                            GetStackPtr(a);
                            _MOVEDXVAL(integer(@fBinProg.fConsts[b]));
                            _DoMove;
                          end;

      ocmov             : begin
                            GetStackPtr(b);
                            _MOVEBXEAX;
                            GetStackPtr(a);
                            _MOVEDXEBX;
                            _DoMove;
                          end;


      ocreturn          : ProcessReturn;

      ocEnterProc       : begin
                            _MOVEBXVAL(a);
                            _MOVEDXEBX;
                            //_CALLObjectMethod(@TIntStack.Push, fBinProg.fStacks);
                            _MOVECXVAL(b);
                            _MOVEDXEBX;
                            _CallMethod(@TBinProg.EnterProc);

                            {_SUBESP((a + 1) * 4);
                            _MOVEDXESP;
                            _MOVECXMEM(integer(@fBinProg.fBaseStackPointer));
                            _PUSH(a + 1);
                            _CallObjectMethod(@TVariantStack.FillWithItems, fBinProg.fStack);}

                            {
                            _MOVEBXMEM(integer(@fBinProg.fBaseStackPointer));
                            _ADDEBXVAL(a);
                            for i := a downto 0 do
                              begin
                                _MOVEDXEBX;
                                _CallObjectMethod(@TVariantStack.Items, fBinProg.fStack);
                                _PUSHEAX;
                                if i > 0 then
                                  _DECEBX;
                              end;
                            }
                          end;

      ocvarraycreate    : begin
                            GetStackPtr(a);
                            _MOVEDXVAL(b);
                            _CallProc(@_ocvarraycreate);
                          end;

      ocsetvarray       : begin
                            GetStackPtr(b);
                            _MOVECXEAX;
                            _MOVEDXVAL(a);
                            _CallMethod(@TBinProg._setVarArray);
                          end;

      ocScriptInvoke .. ocScriptDispatch2 :
                          begin //_ProcessGetProc2(opcode, a, b);      opcode - edx a - ecx b -
                            _PUSHVAL(b);
                            _MOVECXVAL(a);
                            _MOVEDXVAL(OpCode);
                            if OpCode in [ocScriptInvoke, ocScriptDispatch] then
                              _CallMethod(@TBinProg._ProcessGetProc)
                            else
                              _CallMethod(@TBinProg._ProcessGetProc2);
                          end;

      ocDispAssign : begin
                       _MOVECXVAL(b);
                       _MOVEDXVAL(a);
                       _CALLMETHOD(@TBinProg._DispAssign);
                     end;

      ocPushIDisp  : begin
                       GetStackPtr(a);
                       _MOVEDXEAX;
                       _CALLMETHOD(@TBinProg._PushIDisp);
                     end;

      ocTry        : begin
                       _MOVECXVAL(b);
                       _MOVEDXVAL(a);
                       _CALLMETHOD(@TBinProg._DoTry);
                     end;

      ocGetItem    : begin
                       GetStackPtr(b);
                       _MOVEBXEAX;
                       GetStackPtr(a);
                       _MOVEDXEBX; // edx = PSB, eax = PSA
                       _CallProc(@_GetItem)
                     end;

      ocGetItem2 : begin
                     GetStackPtr(b);
                     _MOVECXEAX;
                     _MOVEDXVAL(a);
                     _CALLMETHOD(@TBinProg._GetItem2);
                   end;

      ocSetItem :    begin
                       //_MOVEAXVAL(prog^[cpos + 1].OpCode);

                       GetStackPtr(prog^[cpos + 1].OpCode);
                       _PUSHEAX;

                       GetStackPtr(b);
                       //_MOVEAXVAL(b);

                       _MOVEBXEAX;

                       //_MOVEAXVAL(a);
                       GetStackPtr(a);

                       _MOVEDXEBX; // edx = PSB, eax = PSA
                       _POPECX;
                       _CallProc(@_SetItem)
                     end;

      ocSetItem2 : begin
                     GetStackPtr(b);
                     _MOVECXEAX;
                     _MOVEDXVAL(a);
                     _CALLMETHOD(@TBinProg._SetItem2);
                   end;

      ocTrueCheck   : ProcessTrueFalseCheck(a, b, true);

      ocFalseCheck  : ProcessTrueFalseCheck(a, b, false);

      ocMovRef      : ProcessMovRef(a, b);

      //single param codes
      ocNeg            : begin
                           GetStackPtr(a);
                           _CallProc(@_Neg);
                         end;

      ocGoto           : begin
                           _MOVEDXVAL(a);
                           _CallMethod(@TBinProg.GotoNewPlace2);
                           _JMPEAX;
                         end;

      ocInternalGoto   : _JMPOPCODE(a);

      ocloadintconst   : ProcessLoadIntConst(a, b);

      ocloadboolconst  : begin
                           GetStackPtr(a);
                           _MOVEDXVAL(b);
                           _CallProc(@_LoadBoolConst);
                         end;

      ochalt           : begin
                           _CallMethod(@TBinProg.LeaveProc);
                           // _CallObjectMethod(@TIntStack.Pop, fBinProg.fStacks);

                           {
                           _INCEAX;
                           _SHLEAX(2);
                           _ADDESPEAX;}
                           _RET;
                         end;

      ocincvar, ocdecvar : ProcessIncDecVar(opCode, a);

      occall           : begin
                           _MOVEDXVAL(cpos + 1);
                           _CALLObjectMethod(@TIntStack.Push, fBinProg.fMainThreadVars.CallStack);
                           _JMPOPCODE(a);
                         end;

      ocPopIDisp       : begin
                           _MOVEAXVAL(integer(fBinProg.fMainThreadVars.fDispatch));
                           _CALLPROC(@_PopIDisp);
                         end;

      ocEndFinally     : ProcessEndFinally;

      ocNormalFinally  : begin // ThreadVars.fFinallyReason := frNormal;
                           _MOVEAXVAL(integer(@fBinProg.fMainThreadVars.fFinallyReason));
                           _MOVEAXRefByte(0, byte(frNormal));
                         end;

      ocEndTry         : _CallMethod(@TBinProg._EndTry);

      ocRaise          : begin
                           GetStackPtr(a);
                           _MOVECXEAX;
                           _MOVEDXVAL(a);
                           _CallMethod(@TBinProg._Raise);
                           _JMPEAX;
                         end;

      ocAddWith        : begin
                           GetStackPtr(a);
                           _MOVEDXEAX;
                           _CallMethod(@TBinProg._AddWith);
                         end;
//no params
      ocRemoveWith : _CallMethod(@TBinProg._RemoveWith);

      ocPush0      : begin
                       //fStack.Expand(1);
                       _MOVEDXVAL(1);
                       _CallObjectMethod(@TVariantStack.Expand, fBinProg.fMainThreadVars.fStack);
                     end;

      ocPush ..ocPushRef : begin
                             GetStackptr(a);
                             _MOVEDXEAX;
                             _CallMethod(PushProcs[opCode]);
                           end;

      ocPushConst : begin
                      //fStack.Push(c[a]);
                      _MOVEDXVAL(integer(@fBinProg.fConsts[a]));
                      _CallObjectMethod(@TVariantStack.Push, fBinProg.fMainThreadVars.fStack);
                    end;

      ocOut       : begin
                      _MOVEDXVAL(a);
                      _CallMethod(@TBinProg._DoOut);
                    end;

      ocEvaluate, ocUseUnit, ocUnloadUnit  :
                    begin
                      GetStackPtr(a);
                      _MOVEDXEAX;
                      _CallMethod(InternalProcs[opCode]);
                    end;

      ocCauseBreak : _CallMethod(@TBinProg.CauseBreak);

      ocIncVar2, ocDecVar2 : ProcessIncDecVar2(opcode, a, b);

      ocCallExternal : ProcessCallExternal(a, b);

      ocIfGreaterInt .. ocIfGreaterEqualInt :
                         begin
                           GetStackptr(a);
                           _CMPEAXREF(8, b);
                           WriteByte(ifjmpcode[OpCode]);
                           WriteByte(7); // skip jump
                           _MOVEAXVAL(integer(fBinProg.OpcodesAddr) + (cpos + 2) * sizeof(pointer));
                           _JMPEAXRef;
                         end;

      ocCreateArray : begin // _CreateArray(_makestackptr(a), b);
                        GetStackPtr(a);
                        _MOVEDXEAX;
                        _MOVECXVAL(b);
                        _CallMethod(@TBinProg._CreateArray);
                      end;

      ocAddConst .. ocAndConst : ProcessOp2(a, b, OpCode);

      ocGreaterEqualConst .. ocLessConst : ProcessCMP(a, b, opcode);

      ocIfGreaterConst .. ocIfGreaterEqualConst : ProcessIfCondition(a, b, opcode, cpos);

      ocCos .. ocArcTan : ProcessArithFunc(opcode, a);
    end;
end;

{***********************************************************}

procedure TBinProg._DoOut(i : integer);
begin
  fRunner.DoOut(sConsts[i]);
end;

{-----------------------------------------------------------}

procedure TBinProg.RealCompile;
var
  i        : integer;
  j        : integer;
  progstart : integer;
begin
  fBinCodes.Size := 0;

  FreeMem(OpCodesAddr);

  if ProgSize = 0 then
    begin
      OpCodesAddr := nil;
      exit;
    end;

  GetMem(OpcodesAddr, ProgSize * sizeof(pointer));

  with TRealCompiler.Create(self, fBinCodes) do
    try
      i := 0;
      while i < ProgSize do
        begin
          OpcodesAddr[i] := pointer(_CurPosition);
          UpdateCurPos(i + 1);
          CompileOpCode(prog, i);
          with prog^[i] do
            begin
              if opCode = ocSetItem then
                inc(i)
              else if OpCode in [ocSetItem2, ocGetItem2] then
                inc(i, (a div 3) + 1)
              else if OpCode = ocCreateArray then
                inc(i, (b * 2 div 3) + 1)
              else if OpCode = ocCallExternal then
                inc(i, (b div 3) + 1)
              else if (b > 0) and (opCode in [ocScriptInvoke, ocScriptDispatch, ocDispAssign]) then
                begin
                  j := b;
                  if opCode = ocDispAssign then
                    dec(j); // result is not used
                  inc(i, (j div 3) + 1);
                end;
            end;

          inc(i);
        end;
    finally
      Free;
    end;

  progstart := integer(fBinCodes.Memory);
  for i := 0 to ProgSize - 1 do
    inc(integer(OpcodesAddr[i]), progstart);
end;
{$ENDIF USECOMPILER}

{***********************************************************}

function TIdentListItem.GetParam (i : integer) : TDCParamType;
begin
  result := TDCParamType(ParamNames.Objects[i]);
end;

{-----------------------------------------------------------}

Procedure TIdentListItem.Assign(Source: TIdentlistItem);
Begin
  Address := Source.Address;
  IdentType := Source.IdentType;
  ParamNames.Assign(Source.ParamNames);
End;

{-----------------------------------------------------------}

Constructor TIdentListItem.Create;
Begin
  Inherited;
  ParamNames := TStringList.Create;
  DefaultParams := TList.Create;
End;

{-----------------------------------------------------------}

Destructor TIdentListItem.Destroy;
Begin
  Bounds.Free;
  ParamNames.Free;
  DefaultParams.Free;
  Inherited;
End;

{-----------------------------------------------------------}

procedure TIdentListItem.SetParam(i : integer; val : TDCParamType);
begin
  ParamNames.Objects[i] := pointer(val);
end;

{-----------------------------------------------------------}

function   TIdentListItem.HasParams : boolean;
begin
  result := ParamNames.Count > 0;
end;

{-----------------------------------------------------------}

function TIDLabelList.NewReferencedItem : integer;
begin
  with TIDLabelItem(Add) do
    begin
      referenced := true;
      result := Index;
    end;
end;

{-----------------------------------------------------------}

Function TIDLabelList.newitem: integer;
Begin
  Result := TIDLabelItem(Add).Index;
End;

{-----------------------------------------------------------}

Procedure TIdLabelList.SetReference(index: integer);
Begin
  tidlabelitem(items[index]).referenced := true;
End;

{-----------------------------------------------------------}

procedure TIdLabelList.SetPlace(index, aplace: integer);
begin
  with tidlabelitem(items[index]) do
    begin
      place := aplace;
      exist := true;
    end;
end;

{-----------------------------------------------------------}

function tconstlist.newitem(const adata: Variant): integer;
begin
  with tconstitem(Add) do
    begin
      data := adata;
      result := index;
    end;
end;

{-----------------------------------------------------------}

function TIdentList.IDByName(Const AName: String; Var AID: integer): boolean;
var
  i: integer;
begin
  Result := Find(aname, i);
  if result then
    AID := TIdentListItem(Objects[i]).Address;
end;

{-----------------------------------------------------------}

function TIdentList.Find(const s : string; var index : integer): boolean;
begin
  if not Sorted then
    begin
      Index := IndexOf(S);
      result := Index >=0;
      exit;
    end
  else
    result := inherited Find(s, index);
end;

{-----------------------------------------------------------}
                                                             
constructor TIdentList.Create;
begin
  inherited;
  Sorted := true;
end;

{-----------------------------------------------------------}

Function THalCompiler.getvar: integer;
Var
  t: tidentlistitem;
Begin
  ExpectNextID(ididentifier, 'Variable name'); //don't resource

  if not varbyname(token.stValue, t) then
    Error(Format(SErrvar_NotDef, [token.stValue]));

  result := t.Address;
End;

{-----------------------------------------------------------}

function THalCompiler.ProcessExternalFunction(VarID : integer) : integer;
var
  pcount : integer;
  plist  : TList;
begin
  putcode(ocPush0, 0, 0);
  getopenbracket;
  pcount := 0;
  FCodeCount := 0;

  plist := TList.Create;
  try
    if NextTokenID = idCloseBracket then
      getclosebracket
    else
      while true do
        begin
          StartUseStack;
          plist.Add(pointer(iexpression));

          StopUseStack;
          inc(pcount);

          if NextTokenID = idCloseBracket then
            begin
              getclosebracket;
              break;
            end;
          getcoma;
        end;

    putcode(ocCallExternal, VarID, pcount);
    putlisttocodes(plist);
    
  finally
    plist.Free;
  end;
  putcode(ocPop, spoint, 0);
  result := spoint;
  inc(spoint);
end;

{-----------------------------------------------------------}

function THalCompiler.GetInternalFun(Const sname : string; ident : TIdentListItem) : integer;
var
  i      : integer;
  im     : tidentlistitem;
  ival   : integer;
  pcount : integer;
  defcount : integer;
  hasresult : boolean;

  procedure FillDefaults(i : integer);
  var
    j : integer;
  begin
    if i + defcount < pcount - 1 then
      Error(SErrParamsCount);

    j := i;
    while j < pcount - 1 do
      begin
        inc(j);
        putcode(ocPushConst, integer(ident.DefaultParams[j - (pcount - defcount)]), 0);
      end;
  end;

begin
  with ident do
    begin
      hasresult := varbyname(sname + coprocresult, im);
      if hasresult then
        putcode(ocPush0, 0, 0); // result is stored here

      if HasParams then
        begin
          pcount := ParamNames.Count;
          defcount := DefaultParams.Count;
          if NextTokenID = idOpenBracket then
            begin
              getopenbracket;
              for i := 0 to pcount - 1 do
                begin
                  if params[i] = ptVar then
                    begin
                      ival := getvar;
                      putcode(ocPushRef, ival, 0);
                    end
                  else
                    begin
                      StartUseStack;
                      ival := iexpression;
                      putcode(ocPush, ival, 0);
                      StopUseStack;
                    end;

                  // pind[i] := ival;
                  if i = pcount - 1 then
                    break;

                  if (i < pcount - defcount - 1) or (NextTokenID <> idCloseBracket) then
                    getcoma
                  else
                    begin
                      if NextTokenID = idComma then
                        _readtoken
                      else
                        begin
                          FillDefaults(i);
                          break;
                        end;
                    end;
                end;

              getclosebracket;
            end
          else
            FillDefaults(-1);
        end
      else if NextTokenID = idOpenBracket then
        begin
          getopenbracket;
          getclosebracket;
        end;

      if varbyname(sname, im) then
        fRefs.Add(@(putcode(occall, im.Address, 0).a))
      else
        Error(Format(SErrproc_notfound, [sname]));

      if hasresult then
        begin
          putcode(ocPop, spoint, 0);
          result := spoint;
          inc(spoint);
        end
      else
        result := -1;
    end;
end;

{-----------------------------------------------------------}

function TIdentList.AddItem2(const AName : string; ID : integer) : TIdentListItem;
begin
  result := TIdentListItem.Create;
  result.Address := id;
  result.Name := aname;
  addobject(aname, result);
end;

{-----------------------------------------------------------}

function TIdentList.AddItem(Const Aname: String; ID: Integer): Integer;
var
  t: TIdentListItem;
begin
  t := TIdentListItem.Create;
  t.Address := id;
  t.Name := aname;
  Result := addobject(t.Name, t);
end;

{----------------------------------------------------------------------------}

destructor TIdentList.Destroy;
begin
  FreeStringsObjects(Self);
  inherited;
end;

{-----System Wrapper---------------------------}

procedure __ChDir(const S: string);
begin
  ChDir(S);
end;

{----------------------------------------------}

procedure __GetDir(D: Byte; var S: string);
begin
  GetDir(D,S);
end;

{----------------------------------------------}

procedure __MkDir(const S: string);
begin
  MkDir(S);
end;

{----------------------------------------------}

procedure __RmDir(const S: string);
begin
  RmDir(S);
end;

{----------------------------------------------}
{
function __Cos(X: Extended): Extended;
begin
  result := Cos(X);
end;
}
{----------------------------------------------}
{
function __Exp(X: Extended): Extended;
begin
  result := Exp(X);
end;
}
{----------------------------------------------}
{
function __Ln(x : extended) : extended;
begin
  result := Ln(x);
end;
}
{----------------------------------------------}

function __Int(X: Extended): Extended;
begin
  result := Int(X);
end;

{----------------------------------------------}
{
function __Sin(X: Extended): Extended;
begin
  result := Sin(X);
end;
}
{----------------------------------------------}
{
function __ArcTan(X: Extended): Extended;
begin
  result := ArcTan(X);
end;
}
{----------------------------------------------}

function __Frac(X: Extended): Extended;
begin
  result := Frac(X);
end;

{----------------------------------------------}

function __Round(X: Extended): Longint;
begin
  result := Round(X);
end;

{----------------------------------------------}
{
function __Sqrt(X: Extended): extended;
begin
  result := sqrt(X);
end;
}
{----------------------------------------------}
{
function __Sqr(X: Extended): extended;
begin
  result := sqr(X);
end;
}
{----------------------------------------------}

function __Random(cArgs : integer; pArgs : PArgList) : OleVariant;
begin
  if cArgs = 0 then
    result := Random
  else
    result := Random(Integer(OleVariant(pArgs^[0])));
end;

{----------------------------------------------}

function __Trunc(X: Extended): Longint;
begin
  result := Trunc(X);
end;

{----------------------------------------------}

procedure __FillChar(var X; Count: Integer; value: Byte);
begin
  FillChar(X,Count,Value);
end;

{----------------------------------------------}

procedure __FreeMem(var P: Pointer);
begin
  FreeMem(P);
end;

{----------------------------------------------}

procedure __GetMem(var P: Pointer; Size: Integer);
begin
  GetMem(P,Size);
end;

{----------------------------------------------}

procedure __ReallocMem(var P: Pointer; Size: Integer);
begin
  ReallocMem(P, Size);
end;

{----------------------------------------------}

procedure __Release(var P: Pointer);
begin
{$IFNDEF D6}
  Release(P);
{$ENDIF}
end;

{----------------------------------------------}

function __Copy(const S: string; Index, Count: Integer): string;
{$IFNDEF DCMBCS}
begin
  result := Copy(s, index, count);
end;  
{$ELSE}
var
  i1 : integer;
  i2 : integer;
begin
  if LeadBytes = [] then
    result := Copy(s, index, count)
  else
    begin
      i1 := getrealcharindex(s, index);
      i2 := getrealcharindex(s, index + count);
      result := Copy(s, i1, i2 - i1);
    end;
end;
{$ENDIF}

{----------------------------------------------}

procedure __Delete(var S: string; Index, Count : Integer);
{$IFNDEF DCMBCS}
begin
  Delete(S, Index, Count);
end;
{$ELSE}
var
  i1 : integer;
  i2 : integer;
begin
  if LeadBytes = [] then
    Delete(S, Index, Count)
  else
    begin
      i1 := getrealcharindex(s, index);
      i2 := getrealcharindex(s, index + count);
      Delete(s, i1, i2 - i1);
    end;
end;
{$ENDIF}
{----------------------------------------------}

procedure __Insert(const Source: string; var S: string; Index: Integer);
{$IFNDEF DCMBCS}
begin
  Insert(Source, S, Index)
end;
{$ELSE}
var
  i : integer;
begin
  if LeadBytes = [] then
    Insert(Source, S, Index)
  else
    begin
      i := getrealcharindex(s, index);
      Insert(Source, S, i);
    end;
end;
{$ENDIF}
{----------------------------------------------}

function __Pos(const Substr, S : string): Integer;
begin
  result := Pos(Substr, S);
end;

{----------------------------------------------}

procedure __SetLength(var S: string; NewLength: Integer);
begin
  SetLength(S,NewLength);
end;

{----------------------------------------------}

{procedure __SetString(var s: string; buffer: PChar; len: Integer);
begin
  SetString(S, buffer,len);
end;}

{----------------------------------------------}

procedure __New(var P: Pointer);
begin
  New(P);
end;

{----------------------------------------------}

procedure __Dispose(var P: Pointer);
begin
  Dispose(P);
end;


{----------------------------------------------}
{$IFDEF DCMBCS}
function getmcbsstrlen(const s : string) : integer;
var
  p : pchar;
begin
  result := 0;
  p := pchar(s);
  while p^ <> #0 do
    begin
      inc(result);
      p := CharNext(p);
    end;
end;
{$ENDIF}

{----------------------------------------------}

function __Length(const s : string) : integer;
begin
{$IFDEF DCMBCS}
  if LeadBytes <> [] then
    result := getmcbsstrlen(s)
  else
{$ENDIF}
    result := length(s);
end;

{----------------------------------------------}

function __Assigned(Value: pointer): boolean;
begin
  result := Assigned(Value);
end;

{----------------------------------------------}

function __Abs(const X : Extended) : Extended;
begin
  result := Abs(X);
end;

{----------------------------------------------}

function __Pred(value : integer) : integer;
begin
  result := value - 1;
end;

{----------------------------------------------}

function __Succ(value : integer) : integer;
begin
  result := value + 1;
end;

type
  PFile = ^File;
  PTextFile = ^Text;
  IGetFileFromVar = interface
  ['{26F26A11-6DD1-11D3-ACE5-0000E8DC5099}']
    function  GetFile : PFile;
    function  GetTextFile: PTextFile;
    function  IsTextFile: boolean;
    procedure SetFileType(AIsTextFile: boolean);
  end;

  TFileVariant = class(TObject, IUnknown, IGetFileFromVar)
  private
    FRefCount : integer;
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    FFile: File;
    FTextFile: Text;
    FIsTextFile: boolean;
    function  GetFile : PFile;
    function  GetTextFile: PTextFile;
    function  IsTextFile: boolean;
    procedure SetFileType(AIsTextFile: boolean);

  end;

//************************************************************//
//****************   TFileVariant   **************************//
//************************************************************//

function TFileVariant.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    result := 0;
end;

function TFileVariant._AddRef: Integer;
begin
  inc(FRefCount);
  Result := FRefCount;
end;

function TFileVariant._Release: Integer;
begin
  dec(FRefCount);
  Result := FRefCount;
  if result = 0 then
    Free;
end;

function TFileVariant.GetFile : PFile;
begin
  Result := @FFile;
end;

{---------------------------------------------}

function TFileVariant.GetTextFile: PTextFile;
begin
  Result := @FTextFile;
end;

{---------------------------------------------}

function TFileVariant.IsTextFile: boolean;
begin
  Result := FIsTextFile;
end;

{---------------------------------------------}

procedure TFileVariant.SetFileType(AIsTextFile: boolean);
begin
  FIsTextFile := AIsTextFile;
end;

//************************************************************//
//****************     SystemIO     **************************//
//************************************************************//

function GetIFileFromVar(const v : OleVariant) : IGetFileFromVar;
var
  vv : POleVariant;
begin
  result := nil;
  vv := GetRefVariant(@v);
  if TVarData(vv^).vType in [varDispatch, varUnknown] then
    result := IGetFileFromVar(IUnknown(vv^));
end;

{---------------------------------------------}

procedure __Append(var F: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I <> nil then
    begin
      I.SetFileType (True);             // only for Text - file
      Append (I.GetTextFile^);
    end;
end;

{---------------------------------------------}

procedure __AssignFile(var F : OleVariant; const FileName : OleVariant);
var
  I: IGetFileFromVar;
  fname : string;
begin
  I := TFileVariant.Create;
  fname := VarToStr(GetRefVariant(@FileName)^);
  AssignFile(I.GetTextFile^, fname);
  AssignFile(I.GetFile^, fname);
  F := I;
end;

{---------------------------------------------}

procedure __BlockRead(cArgs : integer; pArgs : PArgList);
var
  I: IGetFileFromVar;
  Count, AmtTransferred : integer;
  PF: PFile;
  Buff : pointer;
begin
  I := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if I = nil then
    exit;
    
  Buff := VarToPointer(GetRefVariant(@(OleVariant(pArgs^[cArgs - 2])))^);
  Count := OleVariant(pArgs^[cArgs - 3]);
  if not I.IsTextFile then // only for untyped files
  begin
    PF := I.GetFile;
    case cArgs of
      3: BlockRead(PF^,Buff^,Count);
      4:begin
          BlockRead(PF^,Buff^,Count,AmtTransferred);
          with TVarData(OleVariant(pArgs^[0])) do
            if vType = varByRef + varVariant then
              POleVariant(VPointer)^ := AmtTransferred;
        end;
    end;
  end;
end;

{---------------------------------------------}

procedure __BlockWrite(cArgs : integer; pArgs : PArgList);
var
  I: IGetFileFromVar;
  Count, AmtTransferred : integer;
  PF: PFile;
  Buff : pointer;
begin
  I := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if I = nil then
     exit;

  Buff := VarToPointer(GetRefVariant(@(OleVariant(pArgs^[cArgs - 2])))^);
  Count := OleVariant(pArgs^[cArgs - 3]);
  if not I.IsTextFile then // only for untyped files
  begin
    PF := I.GetFile;
    case cArgs of
      3: BlockWrite(PF^,Buff^,Count);
      4:begin
          BlockWrite(PF^,Buff^,Count,AmtTransferred);
          with TVarData(OleVariant(pArgs^[0])) do
            if vType = varByRef + varVariant then
              POleVariant(VPointer)^ := AmtTransferred;
        end;
    end;
  end;
end;

{---------------------------------------------}

procedure __CloseFile(var F: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    CloseFile(I.GetTextFile^)
  else
    CloseFile(I.GetFile^);
end;

{---------------------------------------------}

function __Eof(var F: OleVariant): OleVariant;
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Result := OleVariant(Eof(I.GetTextFile^))
  else
    Result := OleVariant(Eof(I.GetFile^));
end;

{---------------------------------------------}

procedure __Erase(var F: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Erase(I.GetTextFile^)
  else
    Erase(I.GetFile^);
end;

{---------------------------------------------}

function __FilePos(var F: OleVariant): OleVariant;
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Result := OleVariant(FilePos(I.GetTextFile^))
  else
    Result := OleVariant(FilePos(I.GetFile^))
end;

{---------------------------------------------}

function __FileSize(var F: OleVariant): OleVariant;
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if not I.IsTextFile then
    Result := OleVariant(FileSize(I.GetFile^));
end;

{---------------------------------------------}

procedure __Flush(var F: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Flush(I.GetTextFile^);
end;

{---------------------------------------------}

procedure __Read(cArgs : integer; pArgs : PArgList);
var
  IFile: IGetFileFromVar;
  PT: PTextFile;
  i: integer;
  Res: string;
begin
  if cArgs = 0 then
    begin
      Read;
      exit;
    end;

  IFile := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if (IFile = nil) or IFile.IsTextFile then
  begin
    PT := nil;
    if IFile <> nil then
      begin
        PT := IFile.GetTextFile;
        dec(cArgs);
      end;


    for i:= cArgs - 1 downto 0 do
    begin
      if PT <> nil then
        Read (PT^,Res)
      else
        Read(Res);

      (POleVariant(TVarData(OleVariant(pArgs^[0])).VPointer))^ := Res;
    end;
  end;
end;

{---------------------------------------------}

procedure __Readln(cArgs : integer; pArgs : PArgList);
var
  IFile: IGetFileFromVar;
  PT: PTextFile;
  i: integer;
  Res: String;
begin
  if cArgs = 0 then
    begin
      Readln;
      exit;
    end;

  IFile := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if (IFile = nil) or IFile.IsTextFile then
  begin
    PT := nil;
    if IFile <> nil then
      begin
        PT := IFile.GetTextFile;
        dec(cArgs);
      end;

    for i:= cArgs - 1 downto 0 do
    begin
      if PT = nil then
        Readln(Res)
      else
        Readln (PT^,Res);

      if Res = '' then
        (POleVariant(TVarData(OleVariant(pArgs^[i])).VPointer))^ := NULL
      else
        (POleVariant(TVarData(OleVariant(pArgs^[i])).VPointer))^ := Res;
    end;
  end;
end;

{---------------------------------------------}

procedure __Rename(var F: OleVariant; const Newname: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Rename(I.GetTextFile^,VarToStr(Newname))
  else
    Rename(I.GetFile^,VarToStr(Newname));
end;

{---------------------------------------------}

procedure __Reset(cArgs : integer; pArgs : PArgList);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if I = nil then
    exit;

  case cArgs of
    1: begin
         I.SetFileType (True);
         Reset(I.GetTextFile^);
       end;
    2: begin
         I.SetFileType (False);
         Reset(I.GetFile^,Integer(GetRefVariant(@(OleVariant(pArgs^[0])))^));
       end;
  end;
end;

{---------------------------------------------}

procedure __Rewrite(cArgs : integer; pArgs : PArgList);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if I = nil then
    exit;

  case cArgs of
    1: begin
         I.SetFileType (True);
         Rewrite(I.GetTextFile^);
       end;

    2: begin
         I.SetFileType (False);
         Rewrite(I.GetFile^,Integer(GetRefVariant(@(OleVariant(pArgs^[0])))^));
       end;
  end;
end;

{---------------------------------------------}

procedure __Seek(var F, N: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if not I.IsTextFile then
    Seek (I.GetFile^,Integer(N));
end;

{---------------------------------------------}

function  __SeekEof (var F: OleVariant): OleVariant;
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Result := OleVariant(SeekEof (I.GetTextFile^));
end;

{---------------------------------------------}

function  __SeekEoln (var F: OleVariant): OleVariant;
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if I.IsTextFile then
    Result := OleVariant(SeekEoln (I.GetTextFile^));
end;

{---------------------------------------------}

procedure __Truncate(var F: OleVariant);
var
  I: IGetFileFromVar;
begin
  I := GetIFileFromVar(F);
  if I = nil then
    exit;

  if not I.IsTextFile then
    Truncate (I.GetFile^);
end;

{---------------------------------------------}

procedure __Write(cArgs : integer; pArgs : PArgList);
var
  PT: PTextFile;
  i: integer;
  IFile: IGetFileFromVar;
begin
  if cArgs = 0 then
    begin
      Write;
      exit;
    end;

  IFile := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if (IFile = nil) or (IFile.IsTextFile) then
    begin
      PT := nil;
      if IFile <> nil then
        begin
          PT := IFile.GetTextFile;
          dec(cArgs);
        end;

      for i:= cArgs - 1 downto 0 do
        if PT <> nil then
          Write (PT^,VarToStr(GetRefVariant(@(OleVariant(pArgs^[i])))^))
        else
          Write (VarToStr(GetRefVariant(@(OleVariant(pArgs^[i])))^));
    end;
end;

{---------------------------------------------}

procedure __Writeln(cArgs : integer; pArgs : PArgList);
var
  PT: PTextFile;
  i: integer;
  IFile: IGetFileFromVar;
begin
  if cArgs  = 0 then
    begin
      Writeln;
      exit;
    end;

  IFile := GetIFileFromVar(OleVariant(pArgs^[cArgs - 1]));
  if (IFile = nil) or IFile.IsTextFile then
    begin
      PT := nil;
      if IFile <> nil then
        begin
          PT := IFile.GetTextFile;
          dec(cArgs);
        end;

      if cArgs > 0 then         
      begin
        for i:= cArgs - 1 downto 0 do
          if PT <> nil then
            Write (PT^,VarToStr(GetRefVariant(@(OleVariant(pArgs^[i])))^))
          else
            Write(VarToStr(GetRefVariant(@(OleVariant(pArgs^[i])))^));

	if PT <> nil then
	  Writeln(PT^)
	else 
	  Writeln;
      end;	    
    end;
end;

{----------------------------------------------}

procedure  __Include(var ASet : integer; elem : integer);
begin
  ASet := ASet or (1 shl elem);
end;

{----------------------------------------------}

procedure  __Exclude(var ASet : integer; elem : integer);
begin
  ASet := ASet and not (1 shl elem);
end;

{----------------------------------------------}

type
  _T0 = procedure (const p0 : string) of object;
  _T1 = procedure (p0 : Byte; var p1 : string) of object;
  _T2 = _T0;
  _T3 = _T0;
  _T4 = function (p0 : Extended): Extended of object;
  _T5 = _T4;
  _T6 = _T4;
  _T7 = _T4;
  _T8 = _T4;
  _T9 = function (p0 : Extended): Longint of object;
  _T10 = _T9;
  _T11 = procedure (p0 : Integer; p1 : Integer; p2 : Byte) of object;
  _T12 = procedure (var p0 : Pointer) of object;
  _T13 = procedure (var p0 : Pointer; p1 : Integer) of object;
  _T14 = _T13;
  _T15 = _T12;
  _T16 = function (const p0 : string; p1 : Integer; p2 : Integer): string of object;
  _T17 = procedure (var p0 : string; p1 : Integer; p2 : Integer) of object;
  _T18 = procedure (const p0 : string; var p1 : string; p2 : Integer) of object;
  _T19 = function (const p0 : string; const p1 : string): Integer of object;
  _T20 = procedure (var p0 : string; p1 : Integer) of object;
  {_T21 = procedure (var p0 : string; p1 : PChar; p2 : Integer) of object;}
  _T22 = _T12;
  _T23 = _T12;

  _T24 = function(const S:String):Integer of object;
  __DC__T_Random  = function (cArgs : integer; pArgs : PArgList) : OleVariant of object;

  _T25 = function (p : pointer) : boolean of object;
  _T26 = function (const x : extended) : boolean of object;
  _T30 = procedure (var p0: OleVariant) of object;
  _T31 = procedure (var p0: OleVariant; const p1: OleVariant) of object;
  _T32 = function  (var p0: OleVariant): OleVariant of object;
  _T33 = procedure (var p0, p1: OleVariant) of object;
  __TT__ = procedure (cArgs : integer; pArgs : PArgList) of object;
  _TI = function(value : integer) : integer of object;
  _TOrd = function (const v : OleVariant) : OleVariant of object;

  _TInclude = procedure(var ASet : integer; elem : integer) of object;

{$IFNDEF CLX}
  _TLoadExternalProc = function (p0 : HInst; const p1 : String; const p2 : String): TDCExternalProcLauncher of object;
{$ENDIF}
//BeginSkipConst

procedure _regproc(const MName : string; ProcInfo : PTypeInfo; const Params : array of PTypeInfo; addr : pointer);
begin
  RegisterReservedProc(TDelphiRunner, MName, ProcInfo, Params, addr, cRegister);
end;

procedure  SysRegister;

procedure IOSysRegister;
var
  OleVarOleVar : array[0..1] of PTypeInfo;
  OleVar       : array[0..0] of PTypeInfo;
begin
  OleVarOleVar[1] := TypeInfo(OleVariant);
  OleVarOleVar[0] := TypeInfo(OleVariant);
  OleVar[0]       := TypeInfo(OleVariant);

  _regproc('Append',TypeInfo(_T30), OleVar, Addr(__Append));

  _regproc('AssignFile', TypeInfo(_T31), OleVarOleVar, Addr(__AssignFile));

  RegisterReservedProcEx(TDelphiRunner, 'BlockRead', TypeInfo(__TT__),
                         NoParams, Addr(__BlockRead), cRegister, mtScriptProc);

  RegisterReservedProcEx(TDelphiRunner, 'BlockWrite', TypeInfo(__TT__),
                         NoParams, Addr(__BlockWrite), cRegister, mtScriptProc);

  _regproc('CloseFile', TypeInfo(_T30), OleVar, Addr(__CloseFile));

  _regproc('Eof', TypeInfo(_T32), OleVarOleVar, Addr(__Eof));

  _regproc('Erase', TypeInfo(_T30), OleVar, Addr(__Erase));

  _regproc('FilePos', TypeInfo(_T32), OleVarOleVar, Addr(__FilePos));

  _regproc('FileSize', TypeInfo(_T32), OleVarOleVar, Addr(__FileSize));

  _regproc('Flush', TypeInfo(_T30), OleVar, Addr(__Flush));

  RegisterReservedProcEx(TDelphiRunner, 'Read', TypeInfo(__TT__),
                         NoParams, Addr(__Read), cRegister, mtScriptProc);

  RegisterReservedProcEx(TDelphiRunner, 'Readln', TypeInfo(__TT__),
                         NoParams, Addr(__Readln), cRegister, mtScriptProc);

  _regproc('Rename', TypeInfo(_T31), OleVarOleVar, Addr(__Rename));

  RegisterReservedProcEx(TDelphiRunner, 'Reset', TypeInfo(__TT__),
                         NoParams, Addr(__Reset), cRegister, mtScriptProc);

  RegisterReservedProcEx(TDelphiRunner, 'Rewrite', TypeInfo(__TT__),
                         NoParams, Addr(__Rewrite), cRegister, mtScriptProc);

  _regproc('Seek', TypeInfo(_T33), OleVarOleVar, Addr(__Seek));

  _regproc('SeekEof', TypeInfo(_T32), OleVarOleVar, Addr(__SeekEof));

  _regproc('SeekEoln', TypeInfo(_T32), OleVarOleVar, Addr(__SeekEoln));

  _regproc('Truncate', TypeInfo(_T30), OleVar, Addr(__Truncate));

  RegisterReservedProcEx(TDelphiRunner, 'Write', TypeInfo(__TT__),
                         NoParams, Addr(__Write), cRegister, mtScriptProc);

  RegisterReservedProcEx(TDelphiRunner, 'Writeln', TypeInfo(__TT__),
                         NoParams, Addr(__Writeln), cRegister, mtScriptProc);
end;

var
  ExtExt  : array[0..1] of PTypeInfo;
  IntInt  : array[0..1] of PTypeInfo;
  PtrInfo : array[0..0] of PTypeInfo;
  StrInfo : array[0..0] of PTypeInfo;
begin
  ExtExt[1] := TypeInfo(Extended);
  ExtExt[0] := TypeInfo(Extended);

  IntInt[1] := TypeInfo(Integer);
  IntInt[0] := TypeInfo(Integer);

  PtrInfo[0] := TypeInfoPointer;
  StrInfo[0] := TypeInfo(string);


  _regproc('ChDir', TypeInfo(_T0), [TypeInfo(string)], Addr(__ChDir));

  _regproc('GetDir', TypeInfo(_T1),[TypeInfo(Byte), TypeInfo(string)], Addr(__GetDir));

  _regproc('MkDir', TypeInfo(_T2), StrInfo, Addr(__MkDir));

  _regproc('RmDir', TypeInfo(_T3), StrInfo, Addr(__RmDir));

  _regproc('Int', TypeInfo(_T6), ExtExt, Addr(__Int));

  _regproc('Frac', TypeInfo(_T8), ExtExt, Addr(__Frac));

  _regproc('Round', TypeInfo(_T9), [TypeInfo(Extended), TypeInfo(Longint)], Addr(__Round));


  _regproc('Randomize', TypeInfo(TSimpleObjectProc), NoParams, Addr(Randomize));

  RegisterReservedProcEx(TDelphiRunner, 'Random', TypeInfo(__DC__T_Random),
                         NoParams, Addr(__Random), cRegister, mtScriptProc);

  _regproc('Trunc',TypeInfo(_T10),[TypeInfo(Extended), TypeInfo(Longint)],Addr(__Trunc));

  _regproc('FillChar', TypeInfo(_T11), [TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Byte)], Addr(__FillChar));

  _regproc('FreeMem', TypeInfo(_T12), PtrInfo, Addr(__FreeMem));

  _regproc('GetMem', TypeInfo(_T13), [TypeInfoPointer, TypeInfo(Integer)], Addr(__GetMem));

  _regproc('ReallocMem',TypeInfo(_T14),[TypeInfoPointer, TypeInfo(Integer)], Addr(__ReallocMem));

  _regproc('Release',TypeInfo(_T15), PtrInfo, Addr(__Release));

  _regproc('Copy',TypeInfo(_T16),[TypeInfo(string), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(string)], Addr(__Copy));

  _regproc('Delete',TypeInfo(_T17),[TypeInfo(string),TypeInfo(Integer), TypeInfo(Integer)], Addr(__Delete));

  _regproc('Insert',TypeInfo(_T18),[TypeInfo(string), TypeInfo(string), TypeInfo(Integer)], Addr(__Insert));

  _regproc('Pos',TypeInfo(_T19),[TypeInfo(string), TypeInfo(string),TypeInfo(Integer)], Addr(__Pos));

  _regproc('SetLength',TypeInfo(_T20),[TypeInfo(string), TypeInfo(Integer)], Addr(__SetLength));

  _regproc('New',TypeInfo(_T22), PtrInfo, Addr(__New));

  _regproc('Dispose', TypeInfo(_T23), PtrInfo, Addr(__Dispose));

  _regproc('Length',TypeInfo(_T24),[TypeInfo(String), TypeInfo(Integer)], Addr(__Length));

  _regproc('Assigned',TypeInfo(_T25),[TypeInfoPointer, TypeInfo(boolean)], Addr(__Assigned));

  _regproc('Abs', TypeInfo(_T26), ExtExt, Addr(__Abs));

  _regproc('Ord', TypeInfo(_TOrd), [TypeInfo(OleVariant), TypeInfo(integer)], Addr(__Ord));

  _regproc('Pred', TypeInfo(_TI), IntInt ,Addr(__Pred));

  _regproc('Succ', TypeInfo(_TI), IntInt, Addr(__Succ));

  _regproc('Include', TypeInfo(_TInclude), IntInt, Addr(__Include));
  _regproc('Exclude', TypeInfo(_TInclude), IntInt, Addr(__Exclude));

{$IFNDEF CLX}
  _regproc('LoadExternalProc', TypeInfo(_TLoadExternalProc),
           [TypeInfo(HInst), TypeInfo(String), TypeInfo(String), TypeInfo(TDCExternalProcLauncher)],
           Addr(LoadExternalProc));
{$ENDIF}

  IOSysRegister;
  {_regproc('SetString',TypeInfo(_T21),[
  TypeInfo(string),
  TypeInfo(PChar),
  TypeInfo(Integer)],Addr(__SetString),cRegister);}

end;

{-----------------------------------------------------------}

procedure _Register;
begin
  RegisterScriptRunner(TDelphiRunner, SExtPas, SLangDelphiScript);
end;

//EndSkipConst
{-----------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{----------------------------------------------}

procedure TDelphiRunner.DoOut(const s : string);
begin
//  ShowMessage(s);
end;

initialization

{$IFDEF USECOMPILER}
  Op2Procs := @FillOpProcs;
  ArithProcs := @FillArithProcs;
  DWORD(VarToRealAddr) := PDWORD(@VarToRealProc)^;
  DWORD(VarFromRealAddr) := PDWORD(@VarFromRealProc)^;
{$ENDIF}
  RunRegister;
  SysRegister;

finalization
  DCTypesList.Free;
  DCTypesList := nil;

{

Some info:
------------
#define opAdd	(0)
#define opSub	(opAdd    + 1)
#define	opMul   (opSub   + 1)
#define	opDiv   (opMul   + 1)
#define	opMod   (opDiv   + 1)
#define	opSlash (opMod   + 1)
#define	opShl   (opSlash + 1)
#define	opShr   (opShl   + 1)
#define	opNot   (opShr   + 1)
#define	opOr    (opNot   + 1)
#define	opXor   (opOr    + 1)
#define	opAnd   (opXor   + 1)

}
end.

