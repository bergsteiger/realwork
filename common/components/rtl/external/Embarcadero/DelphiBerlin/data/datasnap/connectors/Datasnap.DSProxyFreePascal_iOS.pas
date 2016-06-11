{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyFreePascal_iOS;

interface

uses
  Data.DBXPlatform,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  Datasnap.DSCustomConnectorProxyWriter,
  System.Classes;

type

  TFilePart = (fpInterface, fpImplementation);

  TDSClientProxyWriterFreePascaliOS42 = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;
  TDSClientProxyWriterFreePascaliOS50 = class(TDSClientProxyWriterFreePascaliOS42)
    function Properties: TDSProxyWriterProperties; override;

  end;

  TDSCustomFreePascaliOSProxyWriter = class abstract
    (TDSCustomConnectorProxyWriter)
  public
    procedure WriteProxy; override;
  private
    FGenerateURLFunctions: Boolean;
  protected
    FCurrFilePart: TFilePart;
    function GetCreateDataSetReader(const Param: TDSProxyParameter)
      : UnicodeString; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter)
      : UnicodeString; override;
    procedure WriteInterface; override;
    procedure WriteFreePascalLine(const Line: UnicodeString); overload; virtual;
    procedure WriteFreePascalLine; overload; virtual;
    procedure WriteImplementation; override;
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass;
      const ProxyClassNameList: TDBXStringList); virtual;
    procedure WriteClassInterface(const ProxyClass: TDSProxyClass;
      const ProxyClassNameList: TDBXStringList); virtual;
    procedure WriteMethodComment(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;
    procedure WriteMethodInterface(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;

    procedure WriteClassInitImplementation(const ProxyClass
      : TDSProxyClass); virtual;
    procedure WriteClassDeallocImplementation(const ProxyClass
      : TDSProxyClass); virtual;

    procedure WriteParamImplementation(const ProxyClass: TDSProxyClass;
      const ProxyMethod: TDSProxyMethod); virtual;

    function GetFreePascalType(Param: TDSProxyParameter): String;
    function GetCastType(Param: TDSProxyParameter): String;
    function HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
    procedure WriteSetterForInputParams(const ProxyMethod: TDSProxyMethod);
    procedure WriteGetterForOutputParams(const ProxyMethod
      : TDSProxyMethod); overload;
    function GetParameterTypePrefix: string; override;
    function GetParameterDirectionPrefix: String; override;
    function GetGetter(const Param: TDSProxyParameter): UnicodeString;
      reintroduce;
    function GetSetter(const Param: TDSProxyParameter): UnicodeString;
      reintroduce;

  public
    property GenerateURLFunctions: Boolean read FGenerateURLFunctions
      write FGenerateURLFunctions;
  end;

  /// <summary> Writes a FreePascal_iOS proxy for a server application. </summary>
  TDSIOSProxyWriter = class(TDSCustomFreePascaliOSProxyWriter)
  private
    FStreamWriter: TStreamWriter;
    FTargetUnitName: String;
    FIncludeClasses: TDBXStringArray;
    FExcludeClasses: TDBXStringArray;
    FIncludeMethods: TDBXStringArray;
    FExcludeMethods: TDBXStringArray;
  protected
    procedure DerivedWrite(const Line: UnicodeString); override;
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
  sFreePascaliOS42_RESTProxyWriter = 'FreePascal iOS 4.2 REST';
  sFreePascaliOS50_RESTProxyWriter = 'FreePascal iOS 5.0 REST';

implementation

uses
  Data.DBXCommon,
  Datasnap.DSProxyUtils,
  System.SysUtils;

const
  sDSProxyFreePascaliOS42Language = 'freepascal_ios42';
  sDSProxyFreePascaliOS50Language = 'freepascal_ios50';

function TDSCustomFreePascaliOSProxyWriter.GetCastType
  (Param: TDSProxyParameter): String;
begin
  if IsDBXValueTypeParameter(Param) then
    Exit(Param.TypeName);
  case Param.DataType of
    TDBXDataTypes.JsonValueType:
      begin
        if Param.TypeName = 'TJSONObject' then
          Exit('TJSONObject');
        if Param.TypeName = 'TJSONArray' then
          Exit('TJSONArray');
        if Param.TypeName = 'TJSONValue' then
          Exit('TJSONValue');
        if Param.TypeName = 'TJSONTrue' then
          Exit('TJSONTrue');
        if Param.TypeName = 'TJSONFalse' then
          Exit('TJSONFalse');
        if Param.TypeName = 'TJSONNull' then
          Exit('TJSONNull');
        Exit('TJSONObject'); // it's a user defined type
      end;
    TDBXDataTypes.TableType:
      begin
        if Param.TypeName = 'TParams' then
          Exit('TDSParams');
        if Param.TypeName = 'TDBXReader' then
          Exit('TDBXReader');
        if Param.TypeName = 'TDataSet' then
          Exit('TDataSet');
        Exit('UNKNOWN-' + Param.TypeName);
      end;
  else
    Result := '';
  end;
end;

function TDSCustomFreePascaliOSProxyWriter.GetCreateDataSetReader
  (const Param: TDSProxyParameter): UnicodeString;
begin
  Result := NullString;
end;

function TDSCustomFreePascaliOSProxyWriter.GetCreateParamsReader
  (const Param: TDSProxyParameter): UnicodeString;
begin
  Result := NullString;
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteInterface;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  FCurrFilePart := fpInterface;
  WriteLine('unit DSProxy;');

  WriteLine;
  WriteLine('interface');
  indent;
  WriteLine('uses');
  indent;

  WriteLine('Classes,');
  WriteLine('DB,');
  WriteLine('DSAdmin,');
  WriteLine('DSRESTParameterMetaData,');
  WriteLine('DBXFPCJson,');
  WriteLine('DBXValue,');
  WriteLine('DBXFPCCommon,');
  WriteLine('DSRESTConnection, DSRestTypes;');
  outdent;
  WriteLine;
  WriteLine('type');
  indent;

  ProxyClassNameList := TDBXStringList.Create;
  try
    Item := FirstClass;
    while Item <> nil do
    begin
      if ExtendedIncludeClass(Item)
      // Uncomment this line to generate the DSAdmin
      // or (Item.ProxyClassName = 'DSAdmin')
      then
        WriteClassInterface(Item, ProxyClassNameList);
      Item := Item.Next;
    end;
  finally
    FreeAndNil(ProxyClassNameList);
  end;
  outdent;
  outdent;

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteFreePascalLine
  (const Line: UnicodeString);
begin
  inherited WriteLine(Line);
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteFreePascalLine;
begin
  inherited WriteLine;
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteClassInitImplementation
  (const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if ExtendedIncludeMethod(Methods) then
    begin
      WriteParamImplementation(ProxyClass, Methods);

    end;
    Methods := Methods.Next;
  end;

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteClassDeallocImplementation
  (const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  WriteFreePascalLine('destructor ' + ProxyClass.ProxyClassName + '.Destroy;');
  WriteFreePascalLine('begin');
  indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if ExtendedIncludeMethod(Methods) then
      WriteFreePascalLine(' TDSRESTParameterMetaData.releaseArray(F' +
        ProxyClass.ProxyClassName + '_' + Methods.ProxyMethodName + ');');
    Methods := Methods.Next;
  end;

  WriteFreePascalLine('inherited;');
  outdent;
  WriteFreePascalLine('end;');

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteParamImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  MetadataParam: String;
  sname, VarName: String;
  paramIndex: Integer;
begin
  WriteFreePascalLine('');
  sname := ProxyClass.ProxyClassName + '_' + ProxyMethod.ProxyMethodName;
  WriteFreePascalLine('procedure ' + ProxyClass.ProxyClassName + '.' + sname + ';');
  WriteFreePascalLine('begin');
  indent;

  VarName := 'F' + ProxyClass.ProxyClassName + '_' +
    ProxyMethod.ProxyMethodName;

  WriteFreePascalLine('if Length(' + VarName + ') = 0 then');
  WriteFreePascalLine('begin');
  indent;
  WriteFreePascalLine('SetLength(' + VarName + ', ' +
    IntToStr(ProxyMethod.ParameterCount) + ');');
  paramIndex := 0;
  Param := ProxyMethod.Parameters;
  while Param <> nil do
  begin
    MetadataParam := VarName + '[' + IntToStr(paramIndex) +
      '] := TDSRESTParameterMetaData.CreateParam( ';
    MetadataParam := MetadataParam + QuotedStr(Param.ParameterName) + ',';
    MetadataParam := MetadataParam + GetParameterDirection
      (Param.ParameterDirection) + ',';
    MetadataParam := MetadataParam + GetParameterType(Param.DataType) + ',';
    MetadataParam := MetadataParam + QuotedStr(GetFreePascalType( Param)) + ');';
    WriteFreePascalLine(MetadataParam);
    inc(paramIndex);
    Param := Param.Next;
  end;
  outdent;
  WriteFreePascalLine('end;');
  //WriteFreePascalLine('else');
  //indent;
  //WriteFreePascalLine('result:= F' + sname + ';');
  //outdent;
  outdent;
  WriteFreePascalLine('end;');

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteProxy;
begin
  inherited;

end;

function TDSCustomFreePascaliOSProxyWriter.GetFreePascalType
  (Param: TDSProxyParameter): String;
begin
  if Param = nil then
    Exit('nil');

  if IsDBXValueTypeParameter(Param) then
    Exit(Param.TypeName);

  case Param.DataType of
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType:
      begin
        Exit('string');
      end;
    TDBXDataTypes.DatetimeType:
      Exit('TDateTime');
    // TDBXDataTypes.BlobType:
    TDBXDataTypes.BinaryBlobType:
      Exit('TStream');
    TDBXDataTypes.BooleanType:
      begin
        Exit('boolean');
      end;
    TDBXDataTypes.Int8Type:
      begin
        Exit('Int8');
      end;
    TDBXDataTypes.UInt8Type:
      begin
        Exit('UInt8');
      end;
    TDBXDataTypes.Int16Type:
      begin
        Exit('Int16');
      end;
    TDBXDataTypes.UInt16Type:
      begin
        Exit('UInt16');
      end;
    TDBXDataTypes.Int32Type:
      begin
        Exit('Int32');
      end;
    TDBXDataTypes.UInt32Type:
      begin
        Exit('UInt32');
      end;
    TDBXDataTypes.Int64Type:
      begin
        Exit('Int64');
      end;
    TDBXDataTypes.UInt64Type:
      begin
        Exit('UInt64');
      end;
    TDBXDataTypes.DoubleType:
      begin
        Exit('double');
      end;
    TDBXDataTypes.SingleType:
      begin
        Exit('single');
      end;
    TDBXDataTypes.CurrencyType:
      Exit('currency');
    TDBXDataTypes.TimeType:
      Exit('integer');
    TDBXDataTypes.DateType:
      begin
        Exit('integer');
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
      begin
        Result := Param.TypeName;
        if Result = 'TParams' then
          Result := 'TDSParams';

        Exit(Result);
      end
  else
    raise EDSProxyException.Create('Unknown param type for ' + Param.TypeUnit +
      '.' + Param.TypeName);
  end;
end;

function TDSCustomFreePascaliOSProxyWriter.GetGetter
  (const Param: TDSProxyParameter): UnicodeString;
begin
  Result := inherited GetGetter(Param);
  Result := StringReplace(Result, 'GetAs', 'As', [rfIgnoreCase]);
  Result := StringReplace(Result, 'Get', 'As', [rfIgnoreCase]);

end;

function TDSCustomFreePascaliOSProxyWriter.GetParameterDirectionPrefix: String;
begin
  Result := '';
end;

function TDSCustomFreePascaliOSProxyWriter.GetParameterTypePrefix: string;
begin
  Result := '';
end;

function TDSCustomFreePascaliOSProxyWriter.GetSetter
  (const Param: TDSProxyParameter): UnicodeString;
begin
  Result := inherited GetSetter(Param);
  Result := StringReplace(Result, 'SetAs', 'As', [rfIgnoreCase]);
  Result := StringReplace(Result, 'Set', 'As', [rfIgnoreCase]);

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteImplementation;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin

  FCurrFilePart := fpImplementation;
  WriteFreePascalLine('implementation');
  WriteFreePascalLine('');

  ProxyClassNameList := TDBXStringList.Create;
  try
    Item := FirstClass;
    while Item <> nil do
    begin
      if ExtendedIncludeClass(Item)
      // Uncomment this line to generate the DSAdmin
      // or (Item.ProxyClassName = 'DSAdmin')
      then
        WriteClassImplementation(Item, ProxyClassNameList);
      Item := Item.Next;
    end;
  finally
    FreeAndNil(ProxyClassNameList);
  end;
  WriteFreePascalLine('end.');
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteClassImplementation
  (const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList);
var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
begin
  WriteFreePascalLine('');
  WriteFreePascalLine('{' + ProxyClass.ProxyClassName + '}');
  // indent;
  WriteClassInitImplementation(ProxyClass);
  WriteClassDeallocImplementation(ProxyClass);
  // outdent;
  ClassMethodString := TStringBuilder.Create;
  try

    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then
      begin
        WriteMethodComment(ProxyClass, Methods);
        WriteMethodImplementation(ProxyClass, Methods);
      end;
      Methods := Methods.Next;
    end;
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteClassInterface(const ProxyClass
  : TDSProxyClass; const ProxyClassNameList: TDBXStringList);

var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
begin

  ClassMethodString := TStringBuilder.Create;
  try
    WriteFreePascalLine(ProxyClass.ProxyClassName + ' = class(TDSAdmin)');
    WriteFreePascalLine('private');
    indent;
    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then

        WriteFreePascalLine('F' + ProxyClass.ProxyClassName + '_' +
          Methods.ProxyMethodName + ': TDSRESTParameterMetaDataArray;');
      Methods := Methods.Next;
    end;
    outdent;
    WriteFreePascalLine('protected');
    indent;
    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then

        WriteFreePascalLine('procedure ' + ProxyClass.ProxyClassName + '_' +
          Methods.ProxyMethodName + ';');
      Methods := Methods.Next;
    end;
    outdent;
    WriteFreePascalLine('public');
    indent;
    WriteFreePascalLine('destructor Destroy;override;');
    Methods := ProxyClass.FirstMethod;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then
      begin
        WriteMethodComment(ProxyClass, Methods);
        WriteMethodInterface(ProxyClass, Methods);
      end;
      Methods := Methods.Next;
    end;
    outdent;

    WriteFreePascalLine('end;');

    WriteFreePascalLine;
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteGetterForOutputParams
  (const ProxyMethod: TDSProxyMethod);
var
  index: Integer;
  CastTo: sTring;
begin
  index := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      CastTo := '';
      if Assigned(Param) then // could be also a procedure without return value
      begin
        if IsOutputParameter(Param) then
        begin
          if (Param.DataType in [TDBXDataTypes.TableType,
            TDBXDataTypes.JsonValueType]) or (IsDBXValueTypeParameter(Param))
          then
            CastTo := ' as ' + GetCastType(Param);

          if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter
          then
          begin
            WriteFreePascalLine('');

            WriteFreePascalLine('result:= ' + 'cmd.parameters.items[' +
              IntToStr(index) + '].Value.' + GetGetter(Param) + CastTo + ';');
          end
          else
            WriteFreePascalLine(lowercase(Param.ParameterName) + ' :=  ' +
              ' cmd.parameters.items[' + IntToStr(index) + '].Value.' +
              GetGetter(Param) + CastTo + ';');

        end;
      end;
      inc(index);
    end);
end;

function TDSCustomFreePascaliOSProxyWriter.HasOnlyURLParams
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

procedure TDSCustomFreePascaliOSProxyWriter.WriteMethodComment(const ProxyClass
  : TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  PName: UnicodeString;
  TypeName: UnicodeString;
  Direction: UnicodeString;
  IsReturn: Boolean;
  AtTag: UnicodeString;
begin
  WriteFreePascalLine;
  Param := ProxyMethod.Parameters;
  if Param <> nil then
  begin
    WriteFreePascalLine('(*');
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
      WriteFreePascalLine(' * ' + AtTag + PName + Direction +
        ' - Type on server: ' + GetFreePascalType(Param));
      Param := Param.Next;
    end;
    WriteFreePascalLine(' *)');
  end;
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteMethodImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  sb: TStringBuilder;
  sPointer, sout: string;
begin
  sb := TStringBuilder.Create;
  try
    if ProxyMethod.HasReturnValue then

      sb.Append('function ' + ProxyClass.ProxyClassName + '.' +
        ProxyMethod.ProxyMethodName + '(')
    else
      sb.Append('procedure ' + ProxyClass.ProxyClassName + '.' +
        ProxyMethod.ProxyMethodName + '(');
    ForEachParameter(ProxyMethod,
      procedure(Param: TDSProxyParameter)
      begin
        if Assigned(Param) and (IsInputParameter(Param) or
          (Param.ParameterDirection = TDBXParameterDirections.OutParameter))
        then
        begin
          sout := '';
          sPointer := '';
          if Param.ParameterDirection
            in [TDBXParameterDirections.ReturnParameter,
            TDBXParameterDirections.OutParameter,
            TDBXParameterDirections.InOutParameter] then

            sout := 'var';
          if Param.ParameterDirection = TDBXParameterDirections.OutParameter
          then
            sout := 'out ';
          sb.Append(sout + ' ' + lowercase(Param.ParameterName) + ':' +
            GetFreePascalType(Param) + ';');

        end;

      end);
    sout := sb.ToString;
    if sout[Length(sout)] = ';' then
      sout[Length(sout)] := ' ';
    sout := trim(sout);

    if ProxyMethod.HasReturnValue then
      WriteFreePascalLine(sout + '):' + GetFreePascalType
        (GetReturnParam(ProxyMethod)) + ';')
    else
      WriteFreePascalLine(sout + ');');

    WriteFreePascalLine('var');
    indent;
    WriteFreePascalLine('cmd: TDSRestCommand;');
    outdent;

    WriteFreePascalLine('begin');
    // METHOD BODY
    /// ////////////////
    indent;
    WriteFreePascalLine('cmd := Connection.createCommand;');
    WriteFreePascalLine('try');
    indent;
    if HasOnlyURLParams(ProxyMethod) then
      WriteFreePascalLine('cmd.RequestType := GET;')
    else
      WriteFreePascalLine('cmd.RequestType := POST;');

    WriteFreePascalLine('cmd.text := ' + QuotedStr(ProxyClass.ProxyClassName +
      '.' + ProxyMethod.ProxyMethodName) + ';');
    WriteFreePascalLine(ProxyClass.ProxyClassName + '_' + ProxyMethod.ProxyMethodName + ';');
    WriteFreePascalLine('cmd.prepare(F' + ProxyClass.ProxyClassName + '_' +
      ProxyMethod.ProxyMethodName + ');');
    WriteSetterForInputParams(ProxyMethod);
    WriteFreePascalLine('Connection.execute(cmd);');
    WriteGetterForOutputParams(ProxyMethod);
    outdent;
    WriteFreePascalLine('finally');
    indent;
    WriteFreePascalLine('cmd.free;');
    outdent;
    WriteFreePascalLine('end;');

    // END METHOD BODY
    //////////////////
    outdent;
    WriteFreePascalLine('end;');
  finally
    sb.Free;
  end;
  // outdent;
end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteMethodInterface
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  sb: TStringBuilder;
  sout: string;
begin
  sb := TStringBuilder.Create;
  try
    if ProxyMethod.HasReturnValue then
      sb.Append('function ' + ProxyMethod.ProxyMethodName + '(')
    else
      sb.Append('procedure ' + ProxyMethod.ProxyMethodName + '(');

    ForEachParameter(ProxyMethod,
      procedure(Param: TDSProxyParameter)
      begin
        if Assigned(Param) and (IsInputParameter(Param) or
          (Param.ParameterDirection = TDBXParameterDirections.OutParameter))
        then
        begin
          sout := '';

          if Param.ParameterDirection
            in [TDBXParameterDirections.ReturnParameter,
            TDBXParameterDirections.OutParameter,
            TDBXParameterDirections.InOutParameter] then

            sout := 'var ';
          if Param.ParameterDirection = TDBXParameterDirections.OutParameter
          then
            sout := 'out ';

          sb.Append(sout + Param.ParameterName + ': ' +
            GetFreePascalType(Param) + ';');

        end;

      end);
    sout := sb.ToString;
    if sout[Length(sout)] = ';' then
      sout[Length(sout)] := ' ';
    sout := trim(sout);

    if ProxyMethod.HasReturnValue then
      WriteFreePascalLine(sout + '):' + GetFreePascalType
        (GetReturnParam(ProxyMethod)) + ';')
    else
      WriteFreePascalLine(sout + ');');
  finally
    sb.Free;
  end;

end;

procedure TDSCustomFreePascaliOSProxyWriter.WriteSetterForInputParams
  (const ProxyMethod: TDSProxyMethod);
var
  ParIndex: Integer;
begin
  ParIndex := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if IsInputParameter(Param) then
      begin
        if IsDBXValueTypeParameter(Param) then
        begin
          WriteFreePascalLine('if assigned(' + lowercase(Param.ParameterName) +
            ') then');
          indent;
          WriteFreePascalLine('cmd.parameters.items[' + IntToStr(ParIndex) +
            '].Value.AsDBXValue:=' + lowercase(Param.ParameterName));
          outdent;
          WriteFreePascalLine('else');
          indent;
          WriteFreePascalLine('cmd.parameters.items[' + IntToStr(ParIndex) +
            '].Value.setTDBXNull(' + QuotedStr(Param.TypeName) + ');');
          outdent;
          inc(ParIndex);
        end
        else
        begin
          WriteFreePascalLine('cmd.parameters.items[' + IntToStr(ParIndex) +
            '].Value.' + GetSetter(Param) + ':=' +
            lowercase(Param.ParameterName) + ';');
          inc(ParIndex);
        end;
      end;

    end);
end;

{ TDSIOSProxyWriter }
procedure TDSIOSProxyWriter.DerivedWrite(const Line: UnicodeString);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else if FCurrFilePart = fpImplementation then

    ProxyWriters[sImplementation].Write(Line)
  else if FCurrFilePart = fpInterface then
    ProxyWriters[sImplementation].Write(Line)
end;

procedure TDSIOSProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else if FCurrFilePart = fpImplementation then

    ProxyWriters[sImplementation].WriteLine

  else if FCurrFilePart = fpInterface then
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSIOSProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;

function TDSClientProxyWriterFreePascaliOS42.CreateProxyWriter
  : TDSCustomProxyWriter;
begin
  Result := TDSIOSProxyWriter.Create();
  TDSIOSProxyWriter(Result).GenerateURLFunctions := True;
end;

function TDSClientProxyWriterFreePascaliOS42.FileDescriptions
  : TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation;
  Result[0].DefaultFileExt := '.pas';

end;

function TDSClientProxyWriterFreePascaliOS42.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyFreePascal_iOS';
  Result.DefaultExcludeClasses := sDSMetadataClassName + ',' +
    sDSAdminClassName;

  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language := sDSProxyFreePascaliOS42Language;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

{ TDSClientProxyWriterFreePascaliOS50 }

function TDSClientProxyWriterFreePascaliOS50.Properties: TDSProxyWriterProperties;
begin
  inherited;
  Result.Language := sDSProxyFreePascaliOS50Language;

end;

initialization

TDSProxyWriterFactory.RegisterWriter(sFreePascaliOS42_RESTProxyWriter,
  TDSClientProxyWriterFreePascaliOS42);
TDSProxyWriterFactory.RegisterWriter(sFreePascaliOS50_RESTProxyWriter,
  TDSClientProxyWriterFreePascaliOS50);

finalization

TDSProxyWriterFactory.UnregisterWriter(sFreePascaliOS42_RESTProxyWriter);
TDSProxyWriterFactory.UnregisterWriter(sFreePascaliOS50_RESTProxyWriter);

end.
