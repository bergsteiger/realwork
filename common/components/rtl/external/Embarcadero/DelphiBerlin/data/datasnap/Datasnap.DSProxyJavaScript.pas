{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyJavaScript;

interface

uses System.Classes, Data.DBXCommon, Data.DBXPlatform, Datasnap.DSCommonProxy, Datasnap.DSProxyWriter;

type
  TDSClientProxyWriterJavaScript = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomJavaScriptProxyWriter = class abstract(TDSCustomProxyWriter)
  public
    constructor Create;
  protected
    function IsPrimitiveJSONType(ClassName: String): Boolean;
    function GetSupportedTypes: TDBXInt32s; virtual;
    function GetNonURLTypes: TDBXInt32s; virtual;
    function GetAssignmentString: string; override;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter): string; override;
    procedure WriteInterface; override;
    procedure WriteJSLine(const Line: string); overload; virtual;
    procedure WriteJSLine; overload; virtual;
    function ExtendedIncludeClass(const ProxyClass: TDSProxyClass): Boolean; virtual;
    function Contains(const Arr: TDBXInt32s; const Value: Integer): Boolean; virtual;
    function ExtendedIncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean; virtual;
    function GetFirstClass: TDSProxyClass; virtual;
    procedure WriteImplementation; override;
    procedure WriteProxyClassList(const ProxyClassNameList: TDBXStringList); virtual;
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList); virtual;
    function GetMethodRequestType(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod): string; virtual;
    function GetMethodRequestName(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod): string; virtual;
    procedure WriteMethodComment(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod); virtual;
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod); virtual;
  private
    function HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
  protected
    FSupportedTypes: TDBXInt32s;
    FNonURLTypes: TDBXInt32s;
    Get: string;
    Post: string;
    Put: string;
    Delete: string;
    FPostPrefix: string;
    FPutPrefix: string;
    FDeletePrefix: string;
    FGenerateURLFunctions: Boolean;
  public
    property GenerateURLFunctions: Boolean read FGenerateURLFunctions write FGenerateURLFunctions;
  protected
    property SupportedTypes: TDBXInt32s read GetSupportedTypes;
    property NonURLTypes: TDBXInt32s read GetNonURLTypes;
    property FirstClass: TDSProxyClass read GetFirstClass;
  end;

  ///  <summary> Writes a JavaScript proxy for a server application. </summary>
  TDSJavaScriptProxyWriter = class(TDSCustomJavaScriptProxyWriter)
  private
    FStreamWriter: TStreamWriter;
    FTargetUnitName: String;
    FIncludeClasses: TDBXStringArray;
    FExcludeClasses: TDBXStringArray;
    FIncludeMethods: TDBXStringArray;
    FExcludeMethods: TDBXStringArray;
    function GetFileName(OutputFile: string): string;
  protected
    procedure DerivedWrite(const Line: string); override;
    procedure DerivedWriteLine; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
    property TargetUnitName: string read FTargetUnitName write FTargetUnitName;
    ///  <summary> Array of classes to include in the generation
    ///  </summary>
    property IncludeClasses: TDBXStringArray read FIncludeClasses write FIncludeClasses;
    ///  <summary> Array of classes to exclude in the generation
    ///  </summary>
    property ExcludeClasses: TDBXStringArray read FExcludeClasses write FExcludeClasses;
    ///  <summary> Array of methods to include in the generation
    ///  </summary>
    property IncludeMethods: TDBXStringArray read FIncludeMethods write FIncludeMethods;
    ///  <summary> Array of methods to exclude in the generation
    ///  </summary>
    property ExcludeMethods: TDBXStringArray read FExcludeMethods write FExcludeMethods;
    ///  <summary> Generates the JavaScript proxy
    ///  </summary>
    ///  <param name="AConnection">
    ///     Connection to use for retrieving server class/function information
    ///  </param>
    ///  <param name="AStream">The stream to write the proxy out to</param>
    procedure generateJS(AConnection: TDBXConnection; AStream: TStream);
    ///  <summary> Generates the JavaScript proxy
    ///  </summary>
    ///  <param name="AConnection">
    ///     Connection to use for retrieving server class/function information
    ///  </param>
    ///  <param name="AFileName">The file to write the proxy out to</param>
    procedure UpdateJSProxyFile(AConnection: TDBXConnection; const AFileName: string);
    destructor Destroy; override;
  end;

const
  sJavaScriptRESTProxyWriter = 'Java Script REST';

implementation

uses Datasnap.DSClientResStrs, System.SysUtils, System.StrUtils
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

function TDSCustomJavaScriptProxyWriter.GetSupportedTypes: TDBXInt32s;
var
  I: Integer;
begin
  if FSupportedTypes = nil then
  begin
    SetLength(FSupportedTypes,24);
    I := 0;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.AnsiStringType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.WideStringType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BooleanType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int8Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int16Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int32Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.Int64Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt8Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt16Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt32Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.UInt64Type;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DoubleType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.SingleType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.CurrencyType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BcdType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DateType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.DatetimeType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TimeType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TimeStampType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.JsonValueType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.ArrayType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.ObjectType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.TableType;
    FSupportedTypes[IncrAfter(I)] := TDBXDataTypes.BinaryBlobType;
  end;
  Result := FSupportedTypes;
end;

function TDSCustomJavaScriptProxyWriter.GetNonURLTypes: TDBXInt32s;
var
  I: Integer;
begin
  if FNonURLTypes = nil then
  begin
    SetLength(FNonURLTypes,9);
    I := 0;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.JsonValueType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.ObjectType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.TableType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BytesType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.VarBytesType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.ArrayType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.CharArrayType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BlobType;
    FNonURLTypes[IncrAfter(I)] := TDBXDataTypes.BinaryBlobType;
  end;
  Result := FNonURLTypes;
end;

constructor TDSCustomJavaScriptProxyWriter.Create;
begin
  Get := 'GET';
  Post := 'POST';
  Put := 'PUT';
  Delete := 'DELETE';
  FPostPrefix := 'update';
  FPutPrefix := 'accept';
  FDeletePrefix := 'cancel';
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
end;

function TDSCustomJavaScriptProxyWriter.GetAssignmentString: string;
begin
  Result := '=';
end;

function TDSCustomJavaScriptProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

function TDSCustomJavaScriptProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteInterface;
begin
end;

procedure TDSCustomJavaScriptProxyWriter.WriteJSLine(const Line: string);
begin
  inherited WriteLine(Line);
end;

procedure TDSCustomJavaScriptProxyWriter.WriteJSLine;
begin
  inherited WriteLine;
end;

function TDSCustomJavaScriptProxyWriter.ExtendedIncludeClass(const ProxyClass: TDSProxyClass): Boolean;
var
  ProxyMethod: TDSProxyMethod;
begin
  if IncludeClass(ProxyClass) then
  begin
                                                        
    if string.Compare(sDSMetadataClassName, ProxyClass.ProxyClassName, True) = 0 then
      Exit(False);
    ProxyMethod := ProxyClass.FirstMethod;
    while ProxyMethod <> nil do
    begin
      if ExtendedIncludeMethod(ProxyMethod) then
        Exit(True);
      ProxyMethod := ProxyMethod.Next;
    end;
  end;
  Result := False;
end;

function TDSCustomJavaScriptProxyWriter.Contains(const Arr: TDBXInt32s; const Value: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to Length(Arr) - 1 do
  begin
    if Arr[I] = Value then
      Exit(True);
  end;
  Result := False;
end;

function TDSCustomJavaScriptProxyWriter.ExtendedIncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
  PtName: string;
begin
  if IncludeMethod(ProxyMethod) then
  begin
    Param := ProxyMethod.Parameters;
    if Param <> nil then
      while Param <> nil do
      begin
        PtType := Param.DataType;
        if not Contains(SupportedTypes, PtType) then
          Exit(False)
        else if (Param.ParameterDirection = TDBXParameterDirections.ReturnParameter) and (PtType = TDBXDataTypes.WideStringType) then
        begin
          PtName := Param.TypeName;
          if not (PtName.ToLower = 'string') then
            Exit(False);
        end;
        Param := Param.Next;
      end;
    Exit(True);
  end;
  Result := False;
end;

function TDSCustomJavaScriptProxyWriter.GetFirstClass: TDSProxyClass;
begin
  Result := Metadata.Classes;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteImplementation;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  ProxyClassNameList := TDBXStringList.Create;
  try
    Item := FirstClass;
    while Item <> nil do
    begin
      if ExtendedIncludeClass(Item) then
        WriteClassImplementation(Item, ProxyClassNameList);
      Item := Item.Next;
    end;
    WriteProxyClassList(ProxyClassNameList);
  finally
    FreeAndNil(ProxyClassNameList);
  end;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteProxyClassList(const ProxyClassNameList: TDBXStringList);
var
  I: Integer;
  Line: string;
begin
  WriteJSLine('var JSProxyClassList = {');
  Indent;
  for I := 0 to ProxyClassNameList.Count - 1 do
  begin
    Line := string(ProxyClassNameList[I]);
    if I < ProxyClassNameList.Count - 1 then
      Line := Line + ',';
    WriteJSLine(Line);
  end;
  Outdent;
  WriteJSLine('};');
  WriteJSLine;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteClassImplementation(const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList);
var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
  FirstMethod: Boolean;
begin
  ClassMethodString := TStringBuilder.Create;
  try
    ClassMethodString.Append('"' + ProxyClass.ProxyClassName + '": [');
    WriteJSLine('function ' + ProxyClass.ProxyClassName + '(connectionInfo)');
    WriteJSLine('{');
    Indent;
    WriteJSLine('this.executor = new ServerFunctionExecutor("' + ProxyClass.ProxyClassName + '",connectionInfo);');
    Methods := ProxyClass.FirstMethod;
    FirstMethod := True;
    while Methods <> nil do
    begin
      if ExtendedIncludeMethod(Methods) then
      begin
        if not FirstMethod then
          ClassMethodString.Append(',');
        ClassMethodString.Append('"' + Methods.ProxyMethodName + '"');
        WriteMethodComment(ProxyClass, Methods);
        WriteMethodImplementation(ProxyClass, Methods);
        FirstMethod := False;
      end;
      Methods := Methods.Next;
    end;
    Outdent;
    WriteJSLine('}');
    WriteJSLine;
    ClassMethodString.Append(']');
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;
end;

function TDSCustomJavaScriptProxyWriter.HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
begin
  Param := nil;
  if Method <> nil then
    Param := Method.Parameters;
  while Param <> nil do
  begin
    if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
    begin
      PtType := Param.DataType;
      if not Contains(SupportedTypes, PtType) or Contains(NonURLTypes, PtType) then
        Exit(False);
    end;
    Param := Param.Next;
  end;
  Result := True;
end;

function TDSCustomJavaScriptProxyWriter.IsPrimitiveJSONType(ClassName: String): Boolean;
begin
  Result := (ClassName = 'TJSONTrue') or
            (ClassName = 'TJSONFalse') or
            (ClassName = 'TJSONNull') or
            (ClassName = 'TJSONString') or
            (ClassName = 'TJSONNumber');
end;

function TDSCustomJavaScriptProxyWriter.GetMethodRequestType(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod): string;
var
  MName: string;
  Aux, Param: TDSProxyParameter;
  LastType: Integer;
  HadIn: Boolean;
begin
  MName := Method.ProxyMethodName;
  if MName.StartsWith(FPutPrefix, True) and (MName.Length > FPutPrefix.Length) then
    Exit(Put);
  if MName.StartsWith(FPostPrefix, True) and (MName.Length > FPostPrefix.Length) then
    Exit(Post);
  if MName.StartsWith(FDeletePrefix) and (MName.Length > FDeletePrefix.Length) then
    Exit(Delete);
  if (string.Compare(sDSAdminClassName, ProxyClass.ProxyClassName, True) = 0) and (Method.ParameterCount > 0) then
  begin
    HadIn := False;
    Param := Method.Parameters;
    Aux := Param;
    while Aux <> nil do
    begin
      if (Aux <> nil) and ((Aux.ParameterDirection = TDBXParameterDirections.InParameter) or (Aux.ParameterDirection = TDBXParameterDirections.InOutParameter)) then
      begin
        HadIn := True;
        Param := Aux;
      end;
      Aux := Aux.Next;
    end;
    LastType := Param.DataType;
    if HadIn and Contains(NonURLTypes, LastType) then
      Exit(Post);
  end;
  Result := Get;
end;

function TDSCustomJavaScriptProxyWriter.GetMethodRequestName(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod): string;
var
  MName, MType: string;
  PrefixLength: Integer;
begin
  MType := GetMethodRequestType(ProxyClass, Method);
  MName := Method.ProxyMethodName;
  PrefixLength := 0;
  if not (string.Compare(sDSAdminClassName, ProxyClass.ProxyClassName, True) = 0) then
  begin
    if (Put = MType) then
      PrefixLength := FPutPrefix.Length
    else if (Post = MType) then
      PrefixLength := FPostPrefix.Length
    else if (Delete = MType) then
      PrefixLength := FDeletePrefix.Length;
    if (PrefixLength > 0) and (PrefixLength < MName.Length) then
      MName := MName.Substring(PrefixLength, MName.Length - PrefixLength);
  end;
  Result := MName;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteMethodComment(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  PName: string;
  TypeName: string;
  Direction: string;
  IsReturn: Boolean;
  AtTag: string;
begin
  WriteJSLine;
  Param := ProxyMethod.Parameters;
  if Param <> nil then
  begin
    WriteJSLine('/*');
    while Param <> nil do
    begin
      PName := Param.ParameterName;
      TypeName := Param.TypeName;
      Direction := NullString;
      IsReturn := False;
      if Param.ParameterDirection = TDBXParameterDirections.InOutParameter then
        Direction := ' [in/out]'
      else if Param.ParameterDirection = TDBXParameterDirections.OutParameter then
        Direction := ' [out]'
      else if Param.ParameterDirection = TDBXParameterDirections.InParameter then
        Direction := ' [in]'
      else if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter then
      begin
        Direction := '';
        PName := 'result';
        IsReturn := True;
      end;
      AtTag := C_Conditional(IsReturn, '@return ', '@param ');
      WriteJSLine(' * ' + AtTag + PName + Direction + ' - Type on server: ' + TypeName);
      Param := Param.Next;
    end;
    WriteJSLine(' */');
  end;
end;

procedure TDSCustomJavaScriptProxyWriter.WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  ResultObjectLines: TDBXStringList;
  InputParamCSV, LineToAdd, MethodName, MethodNameQuoted, Name, RequestTypeToUse, ReturnVarPrefix: string;
  I, OutIndex, PCount: Integer;
  HasComplexInput, HasComplexResult, HasReturn: Boolean;
begin
  //True if one or more of the out, in/out, or result parameters are a complex type (Table, Stream, Object)
  HasComplexResult := False;

  //True if one or more in or in/out parameters are complex
  HasComplexInput := False;

  Param := ProxyMethod.Parameters;
  ResultObjectLines := TDBXStringList.Create;
  try
    InputParamCSV := NullString;
    OutIndex := 0;
    PCount := 0;
    while Param <> nil do
    begin
      if (Param.DataType = TDBXDataTypes.ObjectType) or
           (Param.DataType = TDBXDataTypes.TableType) or
           (Param.DataType = TDBXDataTypes.BinaryBlobType) or
           (Param.DataType = TDBXDataTypes.BlobType) or
           //JsonValueTypes that aren't primitives (Strings, boolean, numbers) are complex parameter types
           ((Param.DataType = TDBXDataTypes.JsonValueType) and
            (not IsPrimitiveJSONType(Param.TypeName))) then
      begin
        if (Param.ParameterDirection = TDBXParameterDirections.OutParameter) or
           (Param.ParameterDirection = TDBXParameterDirections.ReturnParameter) then
        begin
          HasComplexResult := true;
        end
        else if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) then
        begin
          HasComplexResult := true;
          HasComplexInput := true;
        end
        else if (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
          HasComplexInput := true;
      end;

      LineToAdd := NullString;
      if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
      begin
        InputParamCSV := C_Conditional(InputParamCSV.IsEmpty, '', InputParamCSV + ', ') + Param.ParameterName;
        IncrAfter(PCount);
        if Param.ParameterDirection = TDBXParameterDirections.InParameter then
          LineToAdd := 'resultObject.' + Param.ParameterName + ' = ' + Param.ParameterName + ';';
      end;
      if (Param.ParameterDirection = TDBXParameterDirections.OutParameter) or (Param.ParameterDirection = TDBXParameterDirections.ReturnParameter) or (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) then
      begin
        if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter then
          Name := 'result'
        else
          Name := Param.ParameterName;
        LineToAdd := 'resultObject.' + Name + ' = resultArray[' + IntToStr(OutIndex) + '];';
        IncrAfter(OutIndex);
      end;
      if not LineToAdd.IsEmpty then
        ResultObjectLines.Add(LineToAdd);
      Param := Param.Next;
    end;
    MethodName := GetMethodRequestName(ProxyClass, ProxyMethod);
    WriteJSLine('this.' + ProxyMethod.ProxyMethodName + ' = function(' + InputParamCSV + ') {');
    Indent;
    HasReturn := OutIndex > 0;
    ReturnVarPrefix := C_Conditional(HasReturn, 'var returnObject = ', '');

    //If the function has complex input parameters but the method name isn't prefixed
    //with 'update' or 'accept' then force POST to be used, and put quotes around the method name
    //so the server knows not to prefix the method name with "update" when looking for the matching server method.
    if HasComplexInput and (MethodName = ProxyMethod.ProxyMethodName) then
    begin
      MethodNameQuoted := '"' + MethodName + '"';
      RequestTypeToUse := 'POST';
    end
    else
    begin
      MethodNameQuoted := MethodName;
      RequestTypeToUse := GetMethodRequestType(ProxyClass, ProxyMethod);
    end;

    WriteJSLine(ReturnVarPrefix + 'this.executor.executeMethod(''' + MethodNameQuoted + ''', "' + RequestTypeToUse + '", [' + InputParamCSV + '], arguments[' + IntToStr(PCount) + '], ' + C_Conditional(HasReturn, 'true', 'false') + ', arguments[' + IntToStr((PCount + 1)) + '], arguments[' + IntToStr((PCount + 2)) + ']);');
    if HasReturn then
    begin
      WriteJSLine('if (arguments[' + IntToStr(PCount) + '] == null) {');
      Indent;
      WriteJSLine('if (returnObject != null && returnObject.result != null && isArray(returnObject.result)) {');
      Indent;
      WriteJSLine('var resultArray = returnObject.result;');
      WriteJSLine('var resultObject = new Object();');
      for I := 0 to ResultObjectLines.Count - 1 do
        WriteJSLine(string(ResultObjectLines[I]));

      //if there are complex types being returned then it is possible the cache will be involved,
      //show cache values may need to be populated
      if HasComplexResult then
      begin
        WriteJSLine('if (returnObject.cacheId != null && returnObject.cmdIndex != null) {');
        Indent;
        WriteJSLine('resultObject._cacheId = returnObject.cacheId;');
        WriteJSLine('resultObject._cmdIndex = returnObject.cmdIndex;');
        Outdent;
        WriteJSLine('}');
      end;

      WriteJSLine('return resultObject;');
      Outdent;
      WriteJSLine('}');
      WriteJSLine('return returnObject;');
      Outdent;
      WriteJSLine('}');
    end;
    Outdent;
    WriteJSLine('};');
    if FGenerateURLFunctions and IncludeMethodName(ProxyMethod.ProxyMethodName + '_URL') and HasOnlyURLParams(ProxyMethod) then
    begin
      WriteJSLine;
      WriteJSLine('this.' + ProxyMethod.ProxyMethodName + '_URL = function(' + InputParamCSV + ') {');
      Indent;
      WriteJSLine('return this.executor.getMethodURL("' + MethodName + '", "' + GetMethodRequestType(ProxyClass, ProxyMethod) + '", [' + InputParamCSV + '], arguments[' + IntToStr(PCount) + '])[0];');
      Outdent;
      WriteJSLine('};');
    end;
  finally
    FreeAndNil(ResultObjectLines);
  end;
end;

{TDSJavaScriptProxyWriter}
procedure TDSJavaScriptProxyWriter.DerivedWrite(const Line: string);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSJavaScriptProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSJavaScriptProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;

function TDSJavaScriptProxyWriter.GetFileName(OutputFile: string): string;
var
  EndUnitNamePos, StartUnitNamePos: Integer;
begin
  Result := OutputFile;
  StartUnitNamePos := Result.LastDelimiter(':\/') + 2;
  if StartUnitNamePos < 1 then
    StartUnitNamePos := 1;
  EndUnitNamePos := Result.LastDelimiter('.') + 1;
  TargetUnitName := Result.Substring(StartUnitNamePos - 1, EndUnitNamePos - StartUnitNamePos);
end;

procedure TDSJavaScriptProxyWriter.UpdateJSProxyFile(AConnection: TDBXConnection; const AFileName: string);
var
  LStream: TStream;
begin
  LStream := TFileStream.Create(GetFileName(AFileName), fmCreate);
  try
    generateJS(AConnection, LStream);
  finally
    LStream.Free;
  end;
end;

procedure TDSJavaScriptProxyWriter.generateJS(AConnection: TDBXConnection; AStream: TStream);
begin
  if (AConnection = nil) then
    raise Exception.Create(SJSProxyNoConnection);

  if (AStream = nil) then
    raise Exception.Create(SJSProxyNoStream);

  StreamWriter := nil;
  try
    StreamWriter := TStreamWriter.Create(AStream, TEncoding.UTF8);
    MetaDataLoader := TDSProxyMetaDataLoader.Create(AConnection);
    WriteProxy;
  finally
    FreeAndNil(FStreamWriter);
  end;
end;

function TDSClientProxyWriterJavaScript.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSJavaScriptProxyWriter.Create();
  TDSJavaScriptProxyWriter(Result).GenerateURLFunctions := True;
end;

function TDSClientProxyWriterJavaScript.FileDescriptions: TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation; // do not localize
  Result[0].DefaultFileExt := '.js';
end;

function TDSClientProxyWriterJavaScript.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyJavaScript';
  Result.DefaultExcludeClasses := sDSMetadataClassName; // 'DSMetadata';
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language := sDSProxyJavaScriptLanguage;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sJavaScriptRESTProxyWriter, TDSClientProxyWriterJavaScript);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sJavaScriptRESTProxyWriter);
end.

