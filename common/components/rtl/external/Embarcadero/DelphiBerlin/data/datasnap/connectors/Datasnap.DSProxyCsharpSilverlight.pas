{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyCsharpSilverlight;

interface

uses
  Data.DBXPlatform,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  Datasnap.DSCustomConnectorProxyWriter,
  System.Classes;

type
  TDSClientProxyWriterCsharpSilverlight = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomCsharpSilverlightProxyWriter = class abstract
    (TDSCustomConnectorProxyWriter)
  protected
    function GetCreateDataSetReader(const Param: TDSProxyParameter)
      : string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter)
      : string; override;
    procedure WriteInterface; override;
    procedure WriteCsharpLine(const Line: string); overload; virtual;
    procedure WriteCsharpLine; overload; virtual;
    procedure WriteMethodParametersMetadata(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      out MetadataGetterName: String); virtual;
    procedure WriteImplementation; override;
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass;
      const ProxyClassNameList: TDBXStringList); virtual;
    procedure WriteMethodComment(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      const MetadataGetterName: String); virtual;
    function GetCsharpType(Param: TDSProxyParameter): String;
    function GetCastType(Param: TDSProxyParameter): String;

    procedure WriteResultObjectClass(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod;
      out ResultObjectClassName: String); virtual;
  private
    function HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
    procedure WriteSetterForInputParams(const ProxyMethod: TDSProxyMethod);
    procedure WriteGetterForOutputParams(const ProxyMethod
      : TDSProxyMethod); overload;
    procedure WriteGetterForOutputParams(const ProxyMethod: TDSProxyMethod;
      const ResultObjectClassName: String); overload;
  protected
    Get: string;
    Post: string;
    Put: string;
    Delete: string;
    FPostPrefix: string;
    FPutPrefix: string;
    FDeletePrefix: string;
    FGenerateURLFunctions: Boolean;
  end;

  /// <summary> Writes a CsharpSilverlight proxy for a server application. </summary>
  TDSCsharpSilverlightProxyWriter = class(TDSCustomCsharpSilverlightProxyWriter)
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
  sCsharpSilverlightRESTProxyWriter = 'C# Silverlight REST';

implementation

uses
  Data.DBXCommon,
  Datasnap.DSProxyUtils,
  System.SysUtils;

const
  sDSProxyCsharpSilverlightLanguage = 'csharp_silverlight';

function TDSCustomCsharpSilverlightProxyWriter.GetCastType
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

function TDSCustomCsharpSilverlightProxyWriter.GetCreateDataSetReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

function TDSCustomCsharpSilverlightProxyWriter.GetCreateParamsReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteInterface;
begin
  WriteLine('using System;');
  WriteLine('using System.Threading;');
  WriteLine;
  WriteLine('namespace Embarcadero.Datasnap.WindowsPhone7');
  WriteLine('{');
  Indent;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteCsharpLine
  (const Line: string);
begin
  inherited WriteLine(Line);
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteCsharpLine;
begin
  inherited WriteLine;
end;

function TDSCustomCsharpSilverlightProxyWriter.GetCsharpType
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
      Exit('DateTime');
    // TDBXDataTypes.BlobType:
    TDBXDataTypes.BinaryBlobType:
      Exit('TStream');
    TDBXDataTypes.BooleanType:
      begin
        Exit('bool');
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

procedure TDSCustomCsharpSilverlightProxyWriter.WriteImplementation;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  WriteCsharpLine('public class DSProxy');
  WriteCsharpLine('{');
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
  WriteCsharpLine('}');
  Outdent;
  WriteCsharpLine('}');
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteClassImplementation
  (const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList);
var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
  MetadataGetterName: String;
begin
  ClassMethodString := TStringBuilder.Create;
  try
    WriteCsharpLine('public class ' + ProxyClass.ProxyClassName + ' : DSAdmin');
    WriteCsharpLine('{');
    Indent;
    WriteCsharpLine('public ' + ProxyClass.ProxyClassName +
      '(DSRESTConnection Connection, ExceptionCallback ExCal)');
    WriteCsharpLine('    : base(Connection, ExCal)');
    WriteCsharpLine('{');
    WriteCsharpLine('}');
    WriteCsharpLine();

    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then
      begin
        WriteMethodParametersMetadata(ProxyClass, Methods, MetadataGetterName);
        WriteMethodComment(ProxyClass, Methods);
        WriteMethodImplementation(ProxyClass, Methods, MetadataGetterName);
      end;
      Methods := Methods.Next;
    end;
    Outdent;
    WriteCsharpLine('}');
    WriteCsharpLine;
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteGetterForOutputParams
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
    WriteCsharpLine('callback.DynamicInvoke(' + CastTo + 'cmd.getParameter(' +
      IntToStr(ProxyMethod.ParameterCount - 1) + ').getValue().' +
      GetGetter(Param) + '());')
  end
  else
    WriteCsharpLine('callback.DynamicInvoke();');
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteGetterForOutputParams
  (const ProxyMethod: TDSProxyMethod; const ResultObjectClassName: String);
var
  ParIndex: Integer;
  ParName: String;
begin
  WriteCsharpLine(ResultObjectClassName + ' ret = new ' +
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
        WriteCsharpLine('ret.' + ParName + ' = ' + GetCastType(Param) +
          'cmd.getParameter(' + IntToStr(ParIndex) + ').getValue().' +
          GetGetter(Param) + '();');
      end;
      inc(ParIndex);
    end);
  WriteCsharpLine('callback.DynamicInvoke(ret);');
end;

function TDSCustomCsharpSilverlightProxyWriter.HasOnlyURLParams
  (const Method: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
begin
  Param := nil;
  if Method <> nil then
    Param := Method.Parameters;
  while Param <> nil do
  begin
    if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or
      (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
    begin
      PtType := Param.DataType;
      if not Contains(SupportedTypes, PtType) or Contains(NonURLTypes, PtType)
      then
        Exit(False);
    end;
    Param := Param.Next;
  end;
  Result := True;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteMethodComment
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  PName: string;
  TypeName: string;
  Direction: string;
  IsReturn: Boolean;
  AtTag: string;
begin
  WriteCsharpLine;
  Param := ProxyMethod.Parameters;
  if Param <> nil then
  begin
    WriteCsharpLine('/**');
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
      WriteCsharpLine(' * ' + AtTag + PName + Direction + ' - Type on server: '
        + TypeName);
      Param := Param.Next;
    end;
    WriteCsharpLine(' */');
  end;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteMethodImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
const MetadataGetterName: String);
var
  UseResultObject: Boolean;
  ResultObjectClassName: String;
  sb: TStringBuilder;
  OutputParametersCount: Integer;
  First: Boolean;
begin
  OutputParametersCount := GetOutputParametersCount(ProxyMethod);
  UseResultObject := (OutputParametersCount >= 2) or
    (IsProcedure(ProxyMethod) and (OutputParametersCount = 1));

  if UseResultObject then
    WriteResultObjectClass(ProxyClass, ProxyMethod, ResultObjectClassName);

  if UseResultObject then
    WriteCsharpLine('public delegate void ' + ProxyMethod.ProxyMethodName +
      'Callback(' + ResultObjectClassName + ' Returns);')
  else if GetCsharpType(GetReturnParam(ProxyMethod)) <> 'void' then
    WriteCsharpLine('public delegate void ' + ProxyMethod.ProxyMethodName +
      'Callback(' + GetCsharpType(GetReturnParam(ProxyMethod)) + ' Result);')
  else
    WriteCsharpLine('public delegate void ' + ProxyMethod.ProxyMethodName +
      'Callback();');

  WriteCsharpLine();

  First := True;
  sb := TStringBuilder.Create;
  try
    sb.Append('public void ' + ProxyMethod.ProxyMethodName + '(');

    ForEachInputParameter(ProxyMethod,
      procedure(Param: TDSProxyParameter)
      begin
        if not First then
          sb.Append(', ');
        sb.Append(GetCsharpType(Param) + ' ' + Param.ParameterName);
        First := False;
      end);
    if not First then
      sb.Append(', ');
    sb.Append(ProxyMethod.ProxyMethodName +
      'Callback callback = null, ExceptionCallback ExCal = null');
    WriteCsharpLine(sb.ToString + ')');
    WriteCsharpLine('{');
    // METHOD BODY
    /// ////////////////
    Indent;
    WriteCsharpLine('DSRESTCommand cmd = getConnection().CreateCommand();');
    if HasOnlyURLParams(ProxyMethod) then
      WriteCsharpLine('cmd.setRequestType(DSHTTPRequestType.GET);')
    else
      WriteCsharpLine('cmd.setRequestType(DSHTTPRequestType.POST);');
    WriteCsharpLine('cmd.setText("' + ProxyClass.ProxyClassName + '.' +
      ProxyMethod.ProxyMethodName + '");');
    // WriteCsharpLine('cmd.prepare(' + ProxyClass.ProxyClassName + '_' +
    // ProxyMethod.ProxyMethodName + ');');
    WriteCsharpLine('cmd.prepare(' + MetadataGetterName + '());');

    WriteCsharpLine('InternalConnectionDelegate ' + ProxyMethod.ProxyMethodName
      + 'Del = () =>');
    WriteCsharpLine('{');
    Indent;
    WriteCsharpLine('if (callback != null)');
    WriteCsharpLine('{');
    Indent;
    WriteCsharpLine('try');
    WriteCsharpLine('{');
    Indent;
    if UseResultObject then
      WriteGetterForOutputParams(ProxyMethod, ResultObjectClassName)
    else
      WriteGetterForOutputParams(ProxyMethod);
    Outdent;
    WriteCsharpLine('}');
    WriteCsharpLine('catch (Exception ex)');
    WriteCsharpLine('{');
    Indent;
    WriteCsharpLine
      ('if (ExCal != null) getConnection().syncContext.Send(new SendOrPostCallback(x => ExCal.DynamicInvoke(ex.InnerException)), null);');
    WriteCsharpLine
      ('else getConnection().syncContext.Send(new SendOrPostCallback(x => BaseExCal.DynamicInvoke(ex.InnerException)), null);');
    Outdent;
    WriteCsharpLine('}');
    Outdent;
    WriteCsharpLine('}');
    Outdent;
    WriteCsharpLine('};');

    WriteSetterForInputParams(ProxyMethod);
    WriteCsharpLine('getConnection().execute(cmd, this, ' +
      ProxyMethod.ProxyMethodName + 'Del, ExCal);');
    Outdent;
    // END METHOD BODY
    /// ////////////////
    WriteCsharpLine('}');
  finally
    sb.Free;
  end;
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteMethodParametersMetadata
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
out MetadataGetterName: String);
var
  MetadataArrName: string;
  Param: TDSProxyParameter;
  MetadataParam: string;
begin
  MetadataArrName := ProxyClass.ProxyClassName + '_' +
    ProxyMethod.ProxyMethodName + '_Metadata';
  WriteCsharpLine('private DSRESTParameterMetaData[] ' + MetadataArrName + ';');
  WriteCsharpLine('private DSRESTParameterMetaData[] get_' +
    MetadataArrName + '()');
  WriteCsharpLine('{');
  Indent;
  WriteCsharpLine('if (' + MetadataArrName + ' == null)');
  WriteCsharpLine('{');
  Indent;
  WriteCsharpLine(MetadataArrName + ' = new DSRESTParameterMetaData[]');
  WriteCsharpLine('{');
  Indent;
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    MetadataParam := '"' + Param.ParameterName + '", ';
    MetadataParam := MetadataParam + GetParameterDirection
      (Param.ParameterDirection) + ', ';
    MetadataParam := MetadataParam + GetParameterType(Param.DataType) + ', ';
    MetadataParam := MetadataParam + '"' + Param.TypeName + '"';
    WriteCsharpLine('new DSRESTParameterMetaData(' + MetadataParam + '),');
    Param := Param.Next;
  end;
  Outdent;
  WriteCsharpLine('};');
  Outdent;
  WriteCsharpLine('}');
  WriteCsharpLine('return ' + MetadataArrName + ';');
  Outdent;
  WriteCsharpLine('}');
  MetadataGetterName := 'get_' + MetadataArrName;

end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteSetterForInputParams
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
          WriteCsharpLine('if (' + Param.ParameterName + ' != null)');
          WriteCsharpLine('{');
          Indent;
          WriteCsharpLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().' + 'SetAsDBXValue(' + Param.ParameterName + ');');
          Outdent;
          WriteCsharpLine('}');
          WriteCsharpLine('else');
          WriteCsharpLine('{');
          Indent;
          WriteCsharpLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().SetTDBXNull("' + Param.TypeName + '");');
          Outdent;
          WriteCsharpLine('}');
          inc(ParIndex);
        end
        else
        begin
          WriteCsharpLine('cmd.getParameter(' + IntToStr(ParIndex) +
            ').getValue().' + GetSetter(Param) + '(' +
            Param.ParameterName + ');');
          inc(ParIndex);
        end;
    end);
end;

procedure TDSCustomCsharpSilverlightProxyWriter.WriteResultObjectClass
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod;
out ResultObjectClassName: String);
var
  MemberName: String;
begin
  ResultObjectClassName := ProxyMethod.ProxyMethodName + 'Returns';
  WriteCsharpLine('public class ' + ResultObjectClassName);
  WriteCsharpLine('{');
  Indent;
  ForEachOutputParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter then
        MemberName := 'returnValue'
      else
        MemberName := Param.ParameterName;
      WriteCsharpLine('public ' + GetCsharpType(Param) + ' ' +
        MemberName + ';');
    end);
  Outdent;
  WriteCsharpLine('}');
end;

{ TDSCsharpSilverlightProxyWriter }
procedure TDSCsharpSilverlightProxyWriter.DerivedWrite
  (const Line: string);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSCsharpSilverlightProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSCsharpSilverlightProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;

function TDSClientProxyWriterCsharpSilverlight.CreateProxyWriter
  : TDSCustomProxyWriter;
begin
  Result := TDSCsharpSilverlightProxyWriter.Create();
end;

function TDSClientProxyWriterCsharpSilverlight.FileDescriptions
  : TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation; // do not localize
  Result[0].DefaultFileExt := '.cs';
end;

function TDSClientProxyWriterCsharpSilverlight.Properties
  : TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyCsharpSilverlight';
  Result.DefaultExcludeClasses := sDSMetadataClassName + ',' + sDSAdminClassName;
  // do not localize
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := ''; // do not localize
  Result.Language := sDSProxyCsharpSilverlightLanguage;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

initialization

TDSProxyWriterFactory.RegisterWriter(sCsharpSilverlightRESTProxyWriter,
  TDSClientProxyWriterCsharpSilverlight);

finalization

TDSProxyWriterFactory.UnregisterWriter(sCsharpSilverlightRESTProxyWriter);

end.
