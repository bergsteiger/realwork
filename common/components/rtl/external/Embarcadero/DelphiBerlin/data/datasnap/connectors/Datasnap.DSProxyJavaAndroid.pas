{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyJavaAndroid;

interface

uses
  Data.DBXPlatform,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  Datasnap.DSCustomConnectorProxyWriter,
  System.SysUtils,
  System.Classes;

type
  TDSClientProxyWriterJavaAndroid = class(TDSProxyWriter)
  private
    FUTF8Encoding: TEncoding;
    function GetEncoding: TEncoding;
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
    destructor Destroy; override;
  end;

  TDSCustomJavaAndroidProxyWriter = class abstract
    (TDSCustomConnectorProxyWriter)
  protected
    function GetCreateDataSetReader(const Param: TDSProxyParameter)
      : string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter)
      : string; override;
    procedure WriteInterface; override;
    procedure WriteJavaLine(const Line: string); overload; virtual;
    procedure WriteJavaLine; overload; virtual;
    procedure WriteImplementation; override;
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass;
      const ProxyClassNameList: TDBXStringList); virtual;
    procedure WriteMethodComment(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;
    procedure WriteMethodParametersMetadata(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      out MetadataGetterName: String); virtual;
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      const MetadataGetterName: String); virtual;
    function GetJavaType(Param: TDSProxyParameter): String;
    function GetCastType(Param: TDSProxyParameter): String;

    procedure WriteResultObjectClass(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      out ResultObjectClassName: String); virtual;
  private
    procedure WriteSetterForInputParams(const ProxyMethod: TDSProxyMethod);
    procedure WriteGetterForOutputParams(const ProxyMethod
      : TDSProxyMethod); overload;
    procedure WriteGetterForOutputParams(const ProxyMethod: TDSProxyMethod;
      const ResultObjectClassName: String); overload;
  protected
  end;

  /// <summary> Writes a JavaAndroid proxy for a server application. </summary>
  TDSJavaAndroidProxyWriter = class(TDSCustomJavaAndroidProxyWriter)
  private
    FStreamWriter: TStreamWriter;
    FTargetUnitName: String;
    FIncludeClasses: TDBXStringArray;
    FExcludeClasses: TDBXStringArray;
    FIncludeMethods: TDBXStringArray;
    FExcludeMethods: TDBXStringArray;
  protected
    procedure DerivedWrite(const Line: string); override;
    procedure DerivedWriteLine; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
    property TargetUnitName: string read FTargetUnitName write FTargetUnitName;
    /// <summary> Array of classes to include in the generation
    /// </summary>
    property IncludeClasses: TDBXStringArray read FIncludeClasses
      write FIncludeClasses;
    /// <summary> Array of classes to exclude in the generation
    /// </summary>
    property ExcludeClasses: TDBXStringArray read FExcludeClasses
      write FExcludeClasses;
    /// <summary> Array of methods to include in the generation
    /// </summary>
    property IncludeMethods: TDBXStringArray read FIncludeMethods
      write FIncludeMethods;
    /// <summary> Array of methods to exclude in the generation
    /// </summary>
    property ExcludeMethods: TDBXStringArray read FExcludeMethods
      write FExcludeMethods;
    destructor Destroy; override;
  end;

const
  sJavaAndroidRESTProxyWriter = 'Java (Android) REST';

implementation

uses
  Data.DBXCommon,
  Datasnap.DSProxyUtils;

type
  TUTF8EncodingNoBOM = class(TUTF8Encoding)
  public
    function GetPreamble: TBytes; override;
  end;

const
  sDSProxyJavaAndroidLanguage = 'java_android';

function TDSCustomJavaAndroidProxyWriter.GetCastType
  (Param: TDSProxyParameter): String;
begin
  if IsDBXValueTypeParameter(Param) then
    Exit('(' + Param.TypeName + ')');
  case Param.DataType of
    TDBXDataTypes.JsonValueType:
      begin
        if Param.TypeName = 'TJSONObject' then
          Exit('(TJSONObject)');
        if Param.TypeName = 'TJSONArray' then
          Exit('(TJSONArray)');
        if Param.TypeName = 'TJSONValue' then
          Exit('(TJSONValue)');
        if Param.TypeName = 'TJSONTrue' then
          Exit('(TJSONTrue)');
        if Param.TypeName = 'TJSONFalse' then
          Exit('(TJSONFalse)');
        if Param.TypeName = 'TJSONNull' then
          Exit('(TJSONNull)');
        Exit('(TJSONObject)'); // it's a user defined type
      end;
    TDBXDataTypes.TableType:
      begin
        if Param.TypeName = 'TParams' then
          Exit('(TParams)');
        if Param.TypeName = 'TDBXReader' then
          Exit('(TDBXReader)');
        if Param.TypeName = 'TDataSet' then
          Exit('(TDataSet)');
        Exit('UNKNOWN-' + Param.TypeName);
      end;
  else
    Result := '';
  end;
end;

function TDSCustomJavaAndroidProxyWriter.GetCreateDataSetReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

function TDSCustomJavaAndroidProxyWriter.GetCreateParamsReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteInterface;
begin
  WriteLine('package com.embarcadero.javaandroid;');
  WriteLine;
  WriteLine('import java.util.Date;');
  WriteLine;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteJavaLine
  (const Line: string);
begin
  inherited WriteLine(Line);
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteJavaLine;
begin
  inherited WriteLine;
end;

function TDSCustomJavaAndroidProxyWriter.GetJavaType
  (Param: TDSProxyParameter): String;
begin
  if Param = nil then
    Exit('void');

  if IsDBXValueTypeParameter(Param) then
    Exit(Param.TypeName);

  case Param.DataType of
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType:
      begin
        Exit('String');
      end;
    TDBXDataTypes.DatetimeType:
      Exit('Date');
    // TDBXDataTypes.BlobType:
    TDBXDataTypes.BinaryBlobType:
      Exit('TStream');
    TDBXDataTypes.BooleanType:
      begin
        Exit('boolean');
      end;
    TDBXDataTypes.Int8Type, TDBXDataTypes.UInt8Type:
      begin
        Exit('int');
      end;
    TDBXDataTypes.Int16Type, TDBXDataTypes.UInt16Type:
      begin
        Exit('int');
      end;
    TDBXDataTypes.Int32Type, TDBXDataTypes.UInt32Type:
      begin
        Exit('int');
      end;
    TDBXDataTypes.Int64Type, TDBXDataTypes.UInt64Type:
      begin
        Exit('long');
      end;
    TDBXDataTypes.DoubleType:
      begin
        Exit('double');
      end;
    TDBXDataTypes.SingleType:
      begin
        Exit('float');
      end;
    TDBXDataTypes.CurrencyType:
      Exit('double');
    TDBXDataTypes.TimeType:
      Exit('int');
    TDBXDataTypes.DateType:
      begin
        Exit('int');
      end;
    TDBXDataTypes.JsonValueType:
      begin
        if (Param.TypeName = 'TJSONObject') or (Param.TypeName = 'TJSONArray')
          or (Param.TypeName = 'TJSONValue') or (Param.TypeName = 'TJSONTrue')
          or (Param.TypeName = 'TJSONFalse') or (Param.TypeName = 'TJSONNull')
        then
          Exit(Param.TypeName);
        Exit('TJSONObject');
      end;
    TDBXDataTypes.BcdType:
      Exit('???' + Param.TypeName + '???');
    TDBXDataTypes.TimeStampType:
      Exit('???' + Param.TypeName + '???');
    TDBXDataTypes.TableType:
      Exit(Param.TypeName);
  else
    raise EDSProxyException.Create('Unknown param type for ' + Param.TypeUnit +
      '.' + Param.TypeName);
  end;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteImplementation;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  WriteJavaLine('public class DSProxy {');
  Indent;
  ProxyClassNameList := TDBXStringList.Create;
  try
    Item := FirstClass;
    while Item <> nil do
    begin
      if ExtendedIncludeClass(Item) then
        WriteClassImplementation(Item, ProxyClassNameList);
      Item := Item.Next;
    end;
  finally
    FreeAndNil(ProxyClassNameList);
  end;
  Outdent;
  WriteJavaLine('}');
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteClassImplementation
  (const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList);
var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
  MetadataGetterName: String;
begin
  ClassMethodString := TStringBuilder.Create;
  try
    WriteJavaLine('public static class ' + ProxyClass.ProxyClassName +
      ' extends DSAdmin {');
    Indent;
    WriteJavaLine('public ' + ProxyClass.ProxyClassName +
      '(DSRESTConnection Connection) {');
    Indent;
    WriteJavaLine('super(Connection);');
    Outdent;
    WriteJavaLine('}');

    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then
      begin
        WriteJavaLine('');
        WriteJavaLine('');
        WriteMethodParametersMetadata(ProxyClass, Methods, MetadataGetterName);
        WriteMethodComment(ProxyClass, Methods);
        WriteMethodImplementation(ProxyClass, Methods, MetadataGetterName);
      end;
      Methods := Methods.Next;
    end;
    Outdent;
    WriteJavaLine('}');
    WriteJavaLine;
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteGetterForOutputParams
  (const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  CastTo: String;
begin
  CastTo := '';
  Param := GetReturnParam(ProxyMethod);
  if Assigned(Param) then // could be also a procedure without return value
  begin
    if (Param.DataType in [TDBXDataTypes.TableType, TDBXDataTypes.JsonValueType]
      ) or (IsDBXValueTypeParameter(Param)) then
      CastTo := GetCastType(Param);
    WriteJavaLine('return ' + CastTo + ' cmd.getParameter(' +
      IntToStr(ProxyMethod.ParameterCount - 1) + ').getValue().' +
      GetGetter(Param) + '();')
  end
  else
    WriteJavaLine('return;');
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteGetterForOutputParams
  (const ProxyMethod: TDSProxyMethod; const ResultObjectClassName: String);
var
  ParIndex: Integer;
  ParName: String;
begin
  WriteJavaLine(ResultObjectClassName + ' ret = new ' +
    ResultObjectClassName + '();');
  ParIndex := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if IsOutputParameter(Param) then
      begin
        ParName := C_Conditional
          (Param.ParameterDirection = TDBXParameterDirections.ReturnParameter,
          'returnValue', Param.ParameterName);
        WriteJavaLine('ret.' + ParName + ' = ' + GetCastType(Param) +
          'cmd.getParameter(' + IntToStr(ParIndex) + ').getValue().' +
          GetGetter(Param) + '();');
      end;
      inc(ParIndex);
    end);
  WriteJavaLine('return ret;');
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteMethodComment(const ProxyClass
  : TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  PName: string;
  TypeName: string;
  Direction: string;
  IsReturn: Boolean;
  AtTag: string;
begin
  WriteJavaLine;
  Param := ProxyMethod.Parameters;
  if Param <> nil then
  begin
    WriteJavaLine('/**');
    while Param <> nil do
    begin
      PName := Param.ParameterName;
      TypeName := Param.TypeName;
      Direction := NullString;
      IsReturn := False;
      if Param.ParameterDirection = TDBXParameterDirections.InOutParameter then
        Direction := ' [in/out]'
      else if Param.ParameterDirection = TDBXParameterDirections.OutParameter
      then
        Direction := ' [out]'
      else if Param.ParameterDirection = TDBXParameterDirections.InParameter
      then
        Direction := ' [in]'
      else if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter
      then
      begin
        Direction := '';
        PName := 'result';
        IsReturn := True;
      end;
      AtTag := C_Conditional(IsReturn, '@return ', '@param ');
      WriteJavaLine(' * ' + AtTag + PName + Direction + ' - Type on server: ' +
        TypeName);
      Param := Param.Next;
    end;
    WriteJavaLine(' */');
  end;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteMethodImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
const MetadataGetterName: String);
var
  First: Boolean;
  UseResultObject: Boolean;
  ResultObjectClassName: String;
  sb: TStringBuilder;
  OutputParametersCount: Integer;
begin
  OutputParametersCount := GetOutputParametersCount(ProxyMethod);
  UseResultObject := (OutputParametersCount >= 2) or
    (IsProcedure(ProxyMethod) and (OutputParametersCount = 1));

  if UseResultObject then
    WriteResultObjectClass(ProxyClass, ProxyMethod, ResultObjectClassName);

  First := True;
  sb := TStringBuilder.Create;
  try
    if UseResultObject then
      sb.Append('public ' + ResultObjectClassName + ' ' +
        ProxyMethod.ProxyMethodName + '(')
    else
      sb.Append('public ' + GetJavaType(GetReturnParam(ProxyMethod)) + ' ' +
        ProxyMethod.ProxyMethodName + '(');

    ForEachInputParameter(ProxyMethod,
      procedure(Param: TDSProxyParameter)
      begin
        if not First then
          sb.Append(', ');
        sb.Append(GetJavaType(Param) + ' ' + Param.ParameterName);
        First := False;
      end);
    WriteJavaLine(sb.ToString + ') throws DBXException {');
    // METHOD BODY
    /// ////////////////
    Indent;
    WriteJavaLine('DSRESTCommand cmd = getConnection().CreateCommand();');
    if HasOnlyURLParams(ProxyMethod) then
      WriteJavaLine('cmd.setRequestType(DSHTTPRequestType.GET);')
    else
      WriteJavaLine('cmd.setRequestType(DSHTTPRequestType.POST);');
    WriteJavaLine('cmd.setText("' + ProxyClass.ProxyClassName + '.' +
      ProxyMethod.ProxyMethodName + '");');
    // WriteJavaLine('cmd.prepare(' + ProxyClass.ProxyClassName + '_' +
    // ProxyMethod.ProxyMethodName + ');');
    WriteJavaLine('cmd.prepare(' + MetadataGetterName + '());');
    WriteSetterForInputParams(ProxyMethod);
    WriteJavaLine('getConnection().execute(cmd);');

    if UseResultObject then
      WriteGetterForOutputParams(ProxyMethod, ResultObjectClassName)
    else
      WriteGetterForOutputParams(ProxyMethod);
    Outdent;
    // END METHOD BODY
    /// ////////////////
    WriteJavaLine('}');
  finally
    sb.Free;
  end;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteMethodParametersMetadata
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
out MetadataGetterName: String);
var
  MetadataArrName: string;
  Param: TDSProxyParameter;
  MetadataParam: string;
begin
  MetadataArrName := ProxyClass.ProxyClassName + '_' +
    ProxyMethod.ProxyMethodName + '_Metadata';
  WriteJavaLine('private DSRESTParameterMetaData[] ' + MetadataArrName + ';');
  // = new DSRESTParameterMetaData[] {');
  // Indent;

  WriteJavaLine('private DSRESTParameterMetaData[] get_' + MetadataArrName
    + '() {');
  Indent;
  WriteJavaLine('if (' + MetadataArrName + ' == null) {');
  Indent;
  WriteJavaLine(MetadataArrName + ' = new DSRESTParameterMetaData[]{');
  Indent;
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    MetadataParam := '"' + Param.ParameterName + '", ';
    MetadataParam := MetadataParam + GetParameterDirection
      (Param.ParameterDirection) + ', ';
    MetadataParam := MetadataParam + GetParameterType(Param.DataType) + ', ';
    MetadataParam := MetadataParam + '"' + Param.TypeName + '"';
    WriteJavaLine('new DSRESTParameterMetaData(' + MetadataParam + '),');
    Param := Param.Next;
  end;
  Outdent;
  WriteJavaLine('};');
  Outdent;
  WriteJavaLine('}');
  WriteJavaLine('return ' + MetadataArrName + ';');
  Outdent;
  WriteJavaLine('}');
  MetadataGetterName := 'get_' + MetadataArrName;
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteSetterForInputParams
  (const ProxyMethod: TDSProxyMethod);
var
  ParIndex: Integer;
begin
  ParIndex := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if IsInputParameter(Param) then
        if IsDBXValueTypeParameter(Param) then
        begin
          WriteJavaLine('if (' + Param.ParameterName + ' != null) {');
          Indent;
          WriteJavaLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().' + 'SetAsDBXValue(' + Param.ParameterName + ');');
          Outdent;
          WriteJavaLine('} else {');
          Indent;
          WriteJavaLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().SetTDBXNull("' + Param.TypeName + '");');
          Outdent;
          WriteJavaLine('}');
          inc(ParIndex);
        end
        else
        begin
          WriteJavaLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().' + GetSetter(Param) + '(' +
            Param.ParameterName + ');');
          inc(ParIndex);
        end;
    end);
end;

procedure TDSCustomJavaAndroidProxyWriter.WriteResultObjectClass
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
out ResultObjectClassName: String);
var
  MemberName: String;
begin
  ResultObjectClassName := ProxyMethod.ProxyMethodName + 'Returns';
  WriteJavaLine('public static class ' + ResultObjectClassName + ' {');
  Indent;
  ForEachOutputParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter then
        MemberName := 'returnValue'
      else
        MemberName := Param.ParameterName;
      WriteJavaLine('public ' + GetJavaType(Param) + ' ' + MemberName + ';');
    end);
  Outdent;
  WriteJavaLine('}');
end;

{ TDSJavaAndroidProxyWriter }
procedure TDSJavaAndroidProxyWriter.DerivedWrite(const Line: string);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSJavaAndroidProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSJavaAndroidProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;


function TDSClientProxyWriterJavaAndroid.CreateProxyWriter
  : TDSCustomProxyWriter;
begin
  Result := TDSJavaAndroidProxyWriter.Create;
end;

destructor TDSClientProxyWriterJavaAndroid.Destroy;
begin
  FreeAndNil(FUTF8Encoding);
  inherited;
end;

function TDSClientProxyWriterJavaAndroid.FileDescriptions
  : TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation; // do not localize
  Result[0].DefaultFileExt := '.java';
end;

function TDSClientProxyWriterJavaAndroid.GetEncoding: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUTF8Encoding = nil then
  begin
    LEncoding := TUTF8EncodingNoBOM.Create;
    if AtomicCmpExchange(Pointer(FUTF8Encoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
    {$IFDEF AUTOREFCOUNT}
    FUTF8Encoding.__ObjAddRef;
    {$ENDIF AUTOREFCOUNT}
  end;
  Result := FUTF8Encoding;
end;

function TDSClientProxyWriterJavaAndroid.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyJavaAndroid';
  Result.DefaultExcludeClasses := sDSMetadataClassName + ',' + sDSAdminClassName;
  // do not localize
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := 'com\embarcadero\javaandroid'; // do not localize
  Result.Language := sDSProxyJavaAndroidLanguage;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := GetEncoding;
end;

{ TUTF8EncodingNoBOM }

function TUTF8EncodingNoBOM.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

initialization

TDSProxyWriterFactory.RegisterWriter(sJavaAndroidRESTProxyWriter,
  TDSClientProxyWriterJavaAndroid);

finalization

TDSProxyWriterFactory.UnregisterWriter(sJavaAndroidRESTProxyWriter);

end.
