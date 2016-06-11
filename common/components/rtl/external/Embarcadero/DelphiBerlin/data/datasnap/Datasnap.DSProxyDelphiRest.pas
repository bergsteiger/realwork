{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyDelphiRest;

interface

                                                                      
                                                                                       
// Share "writer code",
uses
  System.Classes,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyDelphi,
  Datasnap.DSProxyWriter,
  System.Generics.Collections,
  System.SysUtils;

type

  TDSClientProxyWriterDelphi = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TNativeRestProxyWriterOption = (optCacheParameters);
  TNativeRestProxyWriterOptions = set of TNativeRestProxyWriterOption;

  TDSCustomNativeRestProxyWriter = class abstract(TDSCustomExtendedProxyWriter)
  private
    FSupportedTypes: TList<integer>;
    function ExtendedIncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean;
    function GetSupportedTypes: TList<integer>;
    function ExtendedIncludeCacheMethod(
      const ProxyMethod: TDSProxyMethod): Boolean;
  protected
    function CanMarshal: Boolean; virtual;
    function GetAncestor(const ProxyClass: TDSProxyClass): string;
    function IncludeClass(const ProxyClass: TDSProxyClass): Boolean; override;
    function IncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean; override;
    function IncludeCacheMethod(const ProxyMethod: TDSProxyMethod): Boolean;
    function SupportsRequestFilter(const ProxyMethod: TDSProxyMethod): Boolean;
    function IsCachableParameter(const ProxyParameter: TDSProxyParameter; out ACachedValueClassName: string): Boolean; overload;
    function IsCachableParameter(const ProxyParameter: TDSProxyParameter; out ACachedValueClassName: string; out AIsCustomType: Boolean): Boolean; overload;
    property SupportedTypes: TList<integer> read GetSupportedTypes;
    function EnumClasses(ACallback: TFunc<TDSProxyClass, Boolean>): Boolean;
    function EnumMethods(AClass: TDSProxyClass; ACallback: TFunc<TDSProxyMethod, Boolean>): Boolean;
    function EnumParams(AMethod: TDSProxyMethod; ACallback: TFunc<TDSProxyParameter, Boolean>): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDSCustomDelphiRestProxyWriter = class abstract(TDSCustomNativeRestProxyWriter)
  public
    constructor Create;
    procedure WriteProxy; override;
  protected
    FUnitName: string;
    procedure WriteInterface; override;
    procedure WriteImplementation; override;
    function GetAssignmentString: string; override;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter): string; override;
  private
    procedure WriteInterfaceUses;
    procedure WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean;
      AOptions: TNativeRestProxyWriterOptions);
    procedure WriteClassInterface(const ProxyClass: TDSProxyClass);
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions = []);
    procedure WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass);
    procedure WriteTDSRestParameterMetaData;
    procedure WriteClassTDSRestParameterMetaData(ProxyClass: TDSProxyClass);
    procedure WriteMethodTDSRestParameterMetaData(ProxyClass: TDSProxyClass;
      Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions = []);
    function MakeTDSRestParameterMetaDataTypeName(ProxyClass: TDSProxyClass;
      Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions = []): string;
    procedure GetHTTPMethodAndPrefix(Method: TDSProxyMethod;
      out AServerMethodPrefix, AHTTPMethodName: string);
    function GetCachedObjectTypes: TDictionary<string, string>;
    procedure WriteCachedObjectTypes(List: TDictionary<string, string>;
      const Forwards: Boolean);
  end;

  TDSDelphiRestProxyWriter = class abstract(TDSCustomDelphiRestProxyWriter)
  private
    FStreamWriter: TStreamWriter;
  protected
    procedure DerivedWrite(const Line: string); override;
    procedure DerivedWriteLine; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
    destructor Destroy; override;
  end;

const
  sDelphiRestProxyWriter = 'Delphi REST';
  sObjectPascalRestProxyWriter = 'Object Pascal REST';
  sDSRestCached = 'DSRestCached';

implementation

uses Data.DBXCommon, Data.DBXPlatform
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

function TDSClientProxyWriterDelphi.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSDelphiRestProxyWriter.Create();
end;

constructor TDSCustomDelphiRestProxyWriter.Create;
begin
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
end;

procedure TDSCustomDelphiRestProxyWriter.WriteProxy;
begin
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
  inherited;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteInterfaceUses;
var
  Item: TDSProxyClass;
  PMethod: TDSProxyMethod;
  PParam: TDSProxyParameter;
  Line, UnitName: string;
begin
  Line := 'uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders,';
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
    begin
      PMethod := Item.FirstMethod;
      while PMethod <> nil do
      begin
        PParam := PMethod.Parameters;
        while PParam <> nil do
        begin
          UnitName := GetDelphiUnitName(PParam);
          if (UnitName.Length > 0) and (not (string.Compare('system', UnitName, True) = 0)) then
          begin
            UnitName := ' ' + UnitName + ',';
            if Line.IndexOf(UnitName) <= 0 then
              Line := Line + UnitName;
          end;
          PParam := PParam.Next;
        end;
        PMethod := PMethod.Next;
      end;
    end;
    Item := Item.Next;
  end;
  Line := Line + ' Data.DBXJSONReflect;';
  WriteLine(Line);
end;

procedure TDSCustomDelphiRestProxyWriter.WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean;
  AOptions: TNativeRestProxyWriterOptions);
var
  Line: string;
  ParamCount: Integer;
  ProcessedCount: Integer;
  Parameters: TDSProxyParameter;
  Param: TDSProxyParameter;
  LSupportsRequestFilter: Boolean;
  LRequestFilter: string;
  LCachedValueClassName: string;
begin
  Parameters := Method.Parameters;
  ParamCount := Method.ParameterCount;
  if Method.HasReturnValue then
  begin
    ParamCount := ParamCount - 1;
    Line := 'function ';
  end
  else
    Line := 'procedure ';
  if IsInterface then
    Line := Line + Method.ProxyMethodName
  else
    Line := Line + ProxyClass.ProxyClassName + 'Client.' + Method.ProxyMethodName;
  if optCacheParameters in AOptions then
    Line := Line + '_Cache';

  LSupportsRequestFilter := SupportsRequestFilter(Method);
  if LSupportsRequestFilter then
    if IsInterface then
      LRequestFilter := 'const ARequestFilter: string = '''''
    else
      LRequestFilter := 'const ARequestFilter: string';
  if ParamCount > 0 then
  begin
    Line := Line + '(';
    Param := Parameters;
    ProcessedCount := 0;
    while (Param <> nil) and (ProcessedCount < ParamCount) do
    begin
      if (Param.ParameterDirection = TDBXParameterDirections.OutParameter) and
       (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) then
      begin
        Line := Line +  'out ' + Param.ParameterName + ': I' + LCachedValueClassName;
      end
      else
      begin
        case Param.ParameterDirection of
          TDBXParameterDirections.OutParameter:
            Line := Line + 'out ';
          TDBXParameterDirections.InOutParameter:
              if not IsKnownDBXValueTypeName(Param.TypeName) then
                if not ((optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName)) then
                  Line := Line + 'var ';
        end;
        Line := Line + Param.ParameterName + ': ' + GetDelphiTypeName(Param);
        if (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) and
          (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) then
        begin
          Line := Line + '; ';
          Line := Line +  'out ' + Param.ParameterName + '_Cache: I' + LCachedValueClassName;
        end;
      end;
      ProcessedCount := ProcessedCount + 1;
      if (ProcessedCount) < ParamCount then
        Line := Line + '; ';
      Param := Param.Next;
    end;
    if LSupportsRequestFilter then
    begin
      if ProcessedCount > 0 then
        Line := Line + '; ';
      Line := Line + LRequestFilter;
    end;

    Line := Line + ')';
  end
  else
  begin
    if LSupportsRequestFilter then
      Line := Line + '(' + LRequestFilter + ')';
  end;

  if Method.HasReturnValue then
  begin
    Param := Method.ReturnParameter;
    if (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) then
      Line := Line + ': I' + LCachedValueClassName
    else
      Line := Line + ': ' + GetDelphiTypeName(Param);
  end;
  WriteLine(Line + ';');
end;

procedure TDSCustomDelphiRestProxyWriter.WriteClassInterface(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
  LAncestor: string;
begin
  Indent;
  LAncestor := GetAncestor(ProxyClass);
  WriteLine(ProxyClass.ProxyClassName + 'Client = class(' + LAncestor + ')');
  WriteLine('private');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command: TDSRestCommand;');
    if IncludeCacheMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command_Cache: TDSRestCommand;');
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('public');
  Indent;
  WriteLine('constructor Create(ARestConnection: TDSRestConnection); overload;');
  WriteLine('constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;');
  WriteLine('destructor Destroy; override;');
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodSignature(ProxyClass, Methods, True, []);
    if IncludeCacheMethod(Methods) then
      WriteMethodSignature(ProxyClass, Methods, True, [optCacheParameters]);
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('end;');
  Outdent;
  WriteLine;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteInterface;
var
  Item: TDSProxyClass;
  List: TDictionary<string, string>;
begin
  WriteLine('unit ' + FUnitName + ';');
  WriteLine;
  WriteLine('interface');
  WriteLine;
  WriteInterfaceUses;
  WriteLine;
  WriteLine('type');
  List := GetCachedObjectTypes;
  try
    WriteCachedObjectTypes(List, True);
    Item := Metadata.Classes;
    while Item <> nil do
    begin
      if IncludeClass(Item) then
        WriteClassInterface(Item);
      Item := Item.Next;
    end;
    WriteCachedObjectTypes(List, False);
  finally
    List.Free;
  end;
  WriteTDSRestParameterMetaData;

end;

const
  sAcceptServerMethodPrefix = 'accept';
  sUpdateServerMethodPrefix = 'update';
  sCancelServerMethodPrefix = 'cancel';
  sHTTPMethodGet = 'GET';
  sHTTPMethodPost = 'POST';
  sHTTPMethodDelete = 'DELETE';
  sHTTPMethodPut = 'PUT';

procedure TDSCustomDelphiRestProxyWriter.GetHTTPMethodAndPrefix(Method: TDSProxyMethod; out AServerMethodPrefix, AHTTPMethodName: string);
var
  ParamCount: Integer;
  Parameters: TDSProxyParameter;
  Param: TDSProxyParameter;
  LTypeName: string;
  LRequiresRequestContent: Boolean;
begin
  LRequiresRequestContent := False;
  Parameters := Method.Parameters;
  ParamCount := Method.ParameterCount;
  if ParamCount > 0 then
  begin
    Param := Parameters;
    while Param <> nil do
    begin
      case Param.ParameterDirection of
        TDBXParameterDirections.InParameter,
        TDBXParameterDirections.InOutParameter:
        begin
          case Param.DataType of
            TDBXDataTypes.TableType, TDBXDataTypes.BinaryBlobType:
                    LRequiresRequestContent := True;
            TDBXDataTypes.JsonValueType:
            begin
              LTypeName := Param.TypeName;
              if not IsKnownJSONTypeName(LTypeName) then // Do not localize
                LRequiresRequestContent := True
              else if SameText(LTypeName, 'TJSONValue') or SameText(LTypeName, 'TJSONObject') or SameText(LTypeName, 'TJSONArray') then  // Do not localize
                LRequiresRequestContent := True;
            end;
          end;
          if LRequiresRequestContent then
            break;
        end;
      end;
      Param := Param.Next;
    end;
  end;
  AServerMethodPrefix := '';
  if LRequiresRequestContent then
    AHTTPMethodName := sHTTPMethodPost
  else
    AHTTPMethodName := sHTTPMethodGet;
{$IFDEF MAPPREFIXES}
  // Accept = PUT
  // Update = POST
  // Cancel = DELETE
  if StrUtils.StartsText(sAcceptServerMethodPrefix, Method.ProxyMethodName) then
  begin
    AServerMethodPrefix := sAcceptServerMethodPrefix;
    AHTTPMethodName := sHTTPMethodPut;
  end
  else if StrUtils.StartsText(sUpdateServerMethodPrefix, Method.ProxyMethodName) then
  begin
    AServerMethodPrefix := sUpdateServerMethodPrefix;
    AHTTPMethodName := sHTTPMethodPost;
  end
  else if StrUtils.StartsText(sCancelServerMethodPrefix, Method.ProxyMethodName) then
  begin
    // May need to ignore prefix in order to pass parameters in http request
    if not LRequiresRequestContent then
    begin
      AServerMethodPrefix := sCancelServerMethodPrefix;
      AHTTPMethodName := sHTTPMethodDelete;
    end;
  end;
{$ENDIF}
end;

function QuoteMethodAlias(const AMethodAlias: string): string;
var
  I: Integer;
begin
  I := AMethodAlias.IndexOf('.') + 1;
  if I > 0 then
    if (AMethodAlias.Chars[I] <> '"') and (AMethodAlias.Chars[I] <> '''') then
      Result := AMethodAlias.Substring(-1, I) + '"' + AMethodAlias.Substring(I) + '"';
end;

procedure TDSCustomDelphiRestProxyWriter.WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions);
var
  CommandName, LCachedValueClassName, LExecute, Lhs, LHTTPMethodName, LMethodAlias, LServerMethodPrefix, Rhs: string;
  InputCount, Ordinal, OutputCount, ParamCount: Integer;
  Param, Params: TDSProxyParameter;
begin
  GetHTTPMethodAndPrefix(ProxyMethod, LServerMethodPrefix, LHTTPMethodName);
  if (LServerMethodPrefix = '') and (LHTTPMethodName <> sHTTPMethodGet) then
    // Quote method name to prevent REST service from prepending "accept", "update" or "delete" for
    // verbs other than "GET"
    LMethodAlias := QuoteMethodAlias(ProxyMethod.MethodAlias)
{$IFDEF MAPPREFIXES}
  else if LServerMethodPrefix <> '' then
    // Remove prefix from method name
    LMethodAlias := ProxyClass.ProxyClassName + '.' + ProxyMethod.ProxyMethodName.Substring(LServerMethodPrefix.Length, MaxInt)
{$ENDIF}
  else
    LMethodAlias := ProxyMethod.MethodAlias;
  WriteMethodSignature(ProxyClass, ProxyMethod, False, AOptions);
  WriteLine('begin');
  Indent;
  CommandName := 'F' + ProxyMethod.ProxyMethodName + 'Command';
  if optCacheParameters in AOptions then
    CommandName := CommandName + '_Cache';
  WriteLine('if ' + CommandName + ' = nil then');
  WriteLine('begin');
  Indent;
  WriteLine(CommandName + ' := FConnection.CreateCommand;');
  WriteLine(CommandName + '.RequestType := ''' + LHTTPMethodName + ''';');
  WriteLine(CommandName + '.Text := ''' + LMethodAlias + ''';');
  if ProxyMethod.ParameterCount > 0 then
    WriteLine(CommandName + '.Prepare(' + MakeTDSRestParameterMetaDataTypeName(ProxyClass, ProxyMethod, AOptions) + ');');
  Outdent;
  WriteLine('end;');
  Params := ProxyMethod.Parameters;
  ParamCount := ProxyMethod.ParameterCount;
  if ProxyMethod.HasReturnValue then
    ParamCount := ParamCount - 1;
  InputCount := ProxyMethod.InputCount;
  OutputCount := ProxyMethod.OutputCount;
  if InputCount > 0 then
  begin
    Param := Params;
    Ordinal := 0;
    while Param <> nil do
    begin
      if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Param.ParameterDirection = TDBXParameterDirections.InParameter) then
      begin
        if IsKnownDBXValueTypeName(Param.TypeName) then
        begin
          WriteLine('if ' + Param.ParameterName + ' = nil then');
          Indent;
          WriteLine(CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.SetNull');
          Outdent;
          WriteLine('else');
          Indent;
          WriteLine(CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.SetValue(' + Param.ParameterName + ');');
          Outdent;
        end
        else if (Param.DataType = TDBXDataTypes.JsonValueType) and not IsKnownJSONTypeName(Param.TypeName) then
        begin
          WriteLine('if not Assigned(' + Param.ParameterName + ') then');
          Indent;
          WriteLine(CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.SetNull');
          Outdent;
          WriteLine('else');
          WriteLine('begin');
          Indent;
          WriteLine('FMarshal := TDSRestCommand(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].ConnectionHandler).GetJSONMarshaler;');
          WriteLine('try');
          Indent;
          WriteLine(CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.SetJSONValue(FMarshal.Marshal(' + Param.ParameterName + '), True);');
          WriteLine('if FInstanceOwner then');
          Indent;
          WriteLine(Param.ParameterName + '.Free');
          Outdent;
          Outdent;
          WriteLine('finally');
          Indent;
          WriteLine('FreeAndNil(FMarshal)');
          Outdent;
          WriteLine('end');
          WriteLine('end;');
          Outdent;
        end
        else
          WriteLine(CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.' + GetSetter(Param) + ';');
      end;
      Ordinal := Ordinal + 1;
      Param := Param.Next;
    end;
  end;
  if optCacheParameters in AOptions then
    LExecute := 'ExecuteCache'
  else
    LExecute := 'Execute';
  if SupportsRequestFilter(ProxyMethod) then
    WriteLine(CommandName + '.' + LExecute + '(ARequestFilter);')
  else
    WriteLine(CommandName + '.' + LExecute + ';');
  if OutputCount > 0 then
  begin
    Param := Params;
    Ordinal := 0;
    while Param <> nil do
    begin
      if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Param.ParameterDirection = TDBXParameterDirections.OutParameter) then
      begin
        if (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) then
        begin
          Lhs := Param.ParameterName;
          if Param.ParameterDirection = TDBXParameterDirections.InOutParameter then
            Lhs := Lhs + '_Cache'; // Add parameter
          Lhs := Lhs + ' := ';
          Rhs := 'T' + LCachedValueClassName + '.Create(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.GetString)';
          WriteLine(Lhs + Rhs + ';');
        end
        else
        if IsKnownDBXValueTypeName(Param.TypeName) then
        begin
          WriteLine('if ' + Param.ParameterName + ' <> nil then');
          Indent;
          WriteLine(Param.ParameterName + '.SetValue(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value);');
          Outdent;
        end
        else if (Param.DataType = TDBXDataTypes.JsonValueType) and not IsKnownJSONTypeName(Param.TypeName) then
        begin
          WriteLine('if not ' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.IsNull then');
          WriteLine('begin');
          Indent;
          WriteLine('FUnMarshal := TDSRestCommand(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].ConnectionHandler).GetJSONUnMarshaler;');
          WriteLine('try');
          Indent;
          WriteLine(Param.ParameterName + ' := ' + Param.TypeName + '(FUnMarshal.UnMarshal(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.GetJSONValue(True)));');
          WriteLine('if FInstanceOwner then');
          Indent;
          WriteLine(CommandName + '.FreeOnExecute(' + Param.ParameterName + ');');
          Outdent;
          Outdent;
          WriteLine('finally');
          Indent;
          WriteLine('FreeAndNil(FUnMarshal)');
          Outdent;
          WriteLine('end;');
          Outdent;
          WriteLine('end');
          WriteLine('else');
          Indent;
          WriteLine(Param.ParameterName + ' := nil;');
          Outdent;
        end
        else
        begin
          Lhs := Param.ParameterName + ' := ';
          Rhs := CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.' + GetGetter(Param);
          WriteOutgoingParameter(Lhs, Rhs, Param, CommandName, Param.ParameterName);
        end;
      end;
      Ordinal := Ordinal + 1;
      Param := Param.Next;
    end;
  end;
  if ProxyMethod.HasReturnValue then
  begin
    if (optCacheParameters in AOptions) and IsCachableParameter(ProxyMethod.ReturnParameter, LCachedValueClassName) then
    begin
      Lhs := 'Result := ';
      Rhs := 'T' + LCachedValueClassName + '.Create(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value.GetString)';
      WriteLine(Lhs + Rhs + ';');
    end
    else
    begin
      if ProxyMethod.ReturnParameter.DataType = TDBXDataTypes.DbxConnectionType then
        Assert(False)//WriteLine('Result := FDBXConnection;')
      else if IsKnownDBXValueTypeName(ProxyMethod.ReturnParameter.TypeName) then
      begin
        WriteLine('Result := ' + ProxyMethod.ReturnParameter.TypeName + '.Create;');
        WriteLine('Result.SetValue(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value)');
      end
      else if (ProxyMethod.ReturnParameter.DataType = TDBXDataTypes.JsonValueType) and not IsKnownJSONTypeName(ProxyMethod.ReturnParameter.TypeName) then
      begin
        Param := ProxyMethod.ReturnParameter;
        WriteLine('if not ' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value.IsNull then');
        WriteLine('begin');
        Indent;
        WriteLine('FUnMarshal := TDSRestCommand(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].ConnectionHandler).GetJSONUnMarshaler;');
        WriteLine('try');
        Indent;
        WriteLine('Result := ' + Param.TypeName + '(FUnMarshal.UnMarshal(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value.GetJSONValue(True)));');
        WriteLine('if FInstanceOwner then');
        Indent;
        WriteLine(CommandName + '.FreeOnExecute(Result);');
        Outdent;
        Outdent;
        WriteLine('finally');
        Indent;
        WriteLine('FreeAndNil(FUnMarshal)');
        Outdent;
        WriteLine('end');
        Outdent;
        WriteLine('end');
        WriteLine('else');
        Indent;
        WriteLine('Result := nil;');
        Outdent;
      end
      else
      begin
        Lhs := 'Result := ';
        Param := ProxyMethod.ReturnParameter;
        Rhs := CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value.' + GetGetter(Param);
        WriteOutgoingParameter(Lhs, Rhs, Param, CommandName, 'Result');
      end;
    end;
  end;
  Outdent;
  WriteLine('end;');
  WriteLine;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
var
  Rhs: string;
begin
  Rhs := InRhs;
  if (Param.DataType = TDBXDataTypes.TableType) and IsKnownTableTypeName(Param.TypeName) then
  begin
    if string.Compare(Param.TypeName, 'TDataSet', True) = 0 then
    begin
      Rhs := 'TCustomSQLDataSet.Create(nil, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
      WriteLine(ParamName + '.Open;');
    end
    else if string.Compare(Param.TypeName, 'TParams', True) = 0 then
    begin
      Rhs := 'TDBXParamsReader.ToParams(nil, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
    end
    else
      WriteLine(Lhs + Rhs + ';');
    WriteLine('if FInstanceOwner then');
    Indent;
    WriteLine(CommandName + '.FreeOnExecute(' + ParamName + ');');
    Outdent;
  end
  else if (Param.DataType = TDBXDataTypes.TableType) or (Param.DataType = TDBXDataTypes.BinaryBlobType) then
    WriteLine(Lhs + Rhs + '(FInstanceOwner);')
  else if Param.DataType = TDBXDataTypes.JsonValueType then
    WriteLine(Lhs + Param.TypeName + '(' + Rhs + '(FInstanceOwner)' + ');')
  else
    WriteLine(Lhs + Rhs + ';');
end;


procedure TDSCustomDelphiRestProxyWriter.WriteClassImplementation(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodImplementation(ProxyClass, Methods);
    if IncludeCacheMethod(Methods) then
      WriteMethodImplementation(ProxyClass, Methods, [optCacheParameters]);
    Methods := Methods.Next;
  end;
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(ARestConnection: TDSRestConnection);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(ARestConnection);');
  Outdent;
  WriteLine('end;');
  WriteLine;
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(ARestConnection, AInstanceOwner);');
  Outdent;
  WriteLine('end;');
  WriteLine;
  WriteLine('destructor ' + ProxyClass.ProxyClassName + 'Client.Destroy;');
  WriteLine('begin');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command.DisposeOf;');
    if IncludeCacheMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command_Cache.DisposeOf;');
    Methods := Methods.Next;
  end;
  WriteLine('inherited;');
  Outdent;
  WriteLine('end;');
  WriteLine;
end;

function TDSCustomDelphiRestProxyWriter.MakeTDSRestParameterMetaDataTypeName(ProxyClass: TDSProxyClass; Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions): string;
begin
  Result := ProxyClass.ProxyClassName + '_' + Method.ProxyMethodName;
  if optCacheParameters in AOptions then
    Result := Result + '_Cache';
end;

procedure TDSCustomDelphiRestProxyWriter.WriteMethodTDSRestParameterMetaData(ProxyClass: TDSProxyClass; Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions);
var
  Param: TDSProxyParameter;
  ParamCount: Integer;
  Line: string;
  LClassName: string;
  LParameterDirection: Integer;
  LDataType: Integer;
  LTypeName: string;
begin
  ParamCount := Method.ParameterCount;
  if ParamCount = 0 then
    Exit;
  Indent;
  WriteLine(Format('%s: array [0..%d] of TDSRestParameterMetaData =',
   [MakeTDSRestParameterMetaDataTypeName(ProxyClass, Method, AOptions), ParamCount - 1]));
  WriteLine('(');
  Indent;
  if ParamCount > 0 then
  begin
    Param := Method.Parameters;
    while Param <> nil do
    begin
      Line := '(';
      Line := Line + 'Name: ''' + Param.ParameterName + '''; ';
      if (optCacheParameters in AOptions) and IsCachableParameter(Param, LClassName) then
      begin
        LTypeName := 'String';
        if Param.ParameterDirection <> TDBXParameterDirections.ReturnParameter then
          LParameterDirection := TDBXParameterDirections.OutParameter
        else
          LParameterDirection := Param.ParameterDirection;
        LDataType := TDBXDataTypes.WideStringType;
      end
      else
      begin
        LParameterDirection := Param.ParameterDirection;
        LDataType := Param.DataType;
        LTypeName := Param.TypeName;
      end;
      Line := Line + 'Direction: ' + IntToStr(LParameterDirection) + '; ';
      Line := Line + 'DBXType: ' + IntToStr(LDataType) + '; ';
      Line := Line + 'TypeName: ''' + LTypeName + ''')';
      Param := Param.Next;
      if Param <> nil then
        Line := Line + ',';
      WriteLine(Line);
    end;
  end;
  OutDent;
  WriteLine(');');
  OutDent;
  WriteLine;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteClassTDSRestParameterMetaData(ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodTDSRestParameterMetaData(ProxyClass, Methods);
    if IncludeCacheMethod(Methods) then
      WriteMethodTDSRestParameterMetaData(ProxyClass, Methods, [optCacheParameters]);

    Methods := Methods.Next;
  end;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteTDSRestParameterMetaData;
var
  Item: TDSProxyClass;
begin
  WriteLine('const');
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassTDSRestParameterMetaData(Item);
    Item := Item.Next;
  end;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteImplementation;
var
  Item: TDSProxyClass;
begin
  WriteLine('implementation');
  WriteLine;
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassImplementation(Item);
    Item := Item.Next;
  end;
  WriteLine('end.');
end;

function TDSCustomDelphiRestProxyWriter.GetAssignmentString: string;
begin
  Result := ':=';
end;

function TDSCustomDelphiRestProxyWriter.GetCachedObjectTypes: TDictionary<string, string>;
var
  LClassName: string;
  LResult: TDictionary<string, string>;
  LIsCustomType: Boolean;
begin
  LResult := TDictionary<string, string>.Create;
  try
    EnumClasses(
      function(AClass: TDSProxyClass): Boolean
      begin
        Result := True;
        if IncludeClass(AClass) then
          EnumMethods(AClass,
            function(AMethod: TDSProxyMethod): Boolean
            begin
              Result := True;
              if IncludeMethod(AMethod) then
                EnumParams(AMethod,
                  function(AParam: TDSProxyParameter): Boolean
                  begin
                    Result := True;
                    if IsCachableParameter(AParam, LClassName, LIsCustomType) and LIsCustomType then
                    begin
                      if not LResult.ContainsKey(LClassName) then
                        LResult.Add(LClassName, AParam.TypeName);
                    end;

                  end)
            end)
      end);
  except
    LResult.Free;
    raise;
  end;
  Result := LResult;
end;

procedure TDSCustomDelphiRestProxyWriter.WriteCachedObjectTypes(
  List: TDictionary<string, string>; const Forwards: Boolean);
var
  LClassName: TPair<string, string>;
begin
  if List.Count > 0 then
  begin
    if Forwards then
      WriteLine;
    Indent;
    for LClassName in List do
      if Forwards then
        WriteLine('I' + LClassName.Key + ' = interface;')
      else
      begin
        WriteLine('I' + LClassName.Key + ' = interface(IDSRestCachedObject<' + LClassName.Value + '>)');
        WriteLine('end;');
        WriteLine;
        WriteLine('T' + LClassName.Key + ' = class(TDSRestCachedObject<' + LClassName.Value + '>, IDSRestCached' + LClassName.Value + ', IDSRestCachedCommand)');
        WriteLine('end;')
      end;
    Outdent;
    WriteLine;
  end;
end;

function TDSCustomDelphiRestProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): string;
begin
  Result := '(TDBXDataSetReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

function TDSCustomDelphiRestProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): string;
begin
  Result := '(TDBXParamsReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

{ TDSDelphiRestProxyWriter }

procedure TDSDelphiRestProxyWriter.DerivedWrite(const Line: string);
begin
  if Assigned(StreamWriter) then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSDelphiRestProxyWriter.DerivedWriteLine;
begin
  if Assigned(StreamWriter) then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSDelphiRestProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;

function TDSClientProxyWriterDelphi.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyDelphiRest';
  Result.DefaultExcludeClasses := sDSAdminClassName + ';' + sDSMetadataClassName; // 'DSMetadata;DSAdmin';
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language := sDSProxyDelphiLanguage;
  Result.Features := [feConnectsWithDSRestConnection, feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

function TDSClientProxyWriterDelphi.FileDescriptions: TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation;
  Result[0].DefaultFileExt := '.pas';
end;

{ TDSCustomNativeRestProxyWriter }

function TDSCustomNativeRestProxyWriter.IncludeClass(
  const ProxyClass: TDSProxyClass): Boolean;
var
  ProxyMethod: TDSProxyMethod;
begin
  Result := inherited;
  if Result then
  begin
    ProxyMethod := ProxyClass.FirstMethod;
    while ProxyMethod <> nil do
    begin
      if IncludeMethod(ProxyMethod) or IncludeCacheMethod(ProxyMethod) then
        Exit(True);
      ProxyMethod := ProxyMethod.Next;
    end;
  end;
  Result := False;
end;

function TDSCustomNativeRestProxyWriter.IncludeMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
begin
  Result := inherited and ExtendedIncludeMethod(ProxyMethod);
end;

function TDSCustomNativeRestProxyWriter.IncludeCacheMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
begin
  Result := IncludeMethodName(ProxyMethod.ProxyMethodName + '_Cache') and
    ExtendedIncludeMethod(ProxyMethod) and
    ExtendedIncludeCacheMethod(ProxyMethod);
end;

function TDSCustomNativeRestProxyWriter.IsCachableParameter(
  const ProxyParameter: TDSProxyParameter; out ACachedValueClassName: string): Boolean;
var
  LIsCustomType: Boolean;
begin
  Result := IsCachableParameter(ProxyParameter, ACachedValueClassName, LIsCustomType);
end;

function TDSCustomNativeRestProxyWriter.IsCachableParameter(
  const ProxyParameter: TDSProxyParameter; out ACachedValueClassName: string; out AIsCustomType: Boolean): Boolean;
var
  LTypeName: string;
begin
  ACachedValueClassName := '';
  AIsCustomType := False;
  case ProxyParameter.ParameterDirection of
    TDBXParameterDirections.InOutParameter,
    TDBXParameterDirections.ReturnParameter,
    TDBXParameterDirections.OutParameter:
    begin
      case ProxyParameter.DataType of
        TDBXDataTypes.TableType:
        begin
          if SameText(ProxyParameter.TypeName, 'TDataSet') then // do not localize
            ACachedValueClassName := 'DSRestCachedDataSet'
          else if SameText(ProxyParameter.TypeName, 'TParams') then // do not localize
            ACachedValueClassName := 'DSRestCachedParams'
          else
            ACachedValueClassName := 'DSRestCachedDBXReader';
        end;
        TDBXDataTypes.BinaryBlobType:
          ACachedValueClassName := 'DSRestCachedStream';
        TDBXDataTypes.JsonValueType:
        begin
          LTypeName := ProxyParameter.TypeName;
          if not IsKnownJSONTypeName(LTypeName) then // Do not localize
          begin
            if CanMarshal then
            begin
              ACachedValueClassName := sDSRestCached + LTypeName;
              AIsCustomType := True;
            end
            else
              ACachedValueClassName := 'DSRestCachedJSONObject';
          end
          else if SameText(LTypeName, 'TJSONValue') then
            ACachedValueClassName := 'DSRestCachedJSONValue'
          else if SameText(LTypeName, 'TJSONObject') then
            ACachedValueClassName := 'DSRestCachedJSONObject'
          else if SameText(LTypeName, 'TJSONArray') then  // Do not localize
            ACachedValueClassName := 'DSRestCachedJSONArray'
        end;
      end;
    end;
  end;
  Result := ACachedValueClassName <> '';
end;

function TDSCustomNativeRestProxyWriter.SupportsRequestFilter(
  const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
begin
  Param := ProxyMethod.Parameters;
  if Param <> nil then
    while Param <> nil do
    begin
      case Param.ParameterDirection of
        TDBXParameterDirections.OutParameter,
        TDBXParameterDirections.InOutParameter,
        TDBXParameterDirections.ReturnParameter:
          Exit(True);
      end;
      Param := Param.Next;
    end;
  Result := False;
end;

function TDSCustomNativeRestProxyWriter.CanMarshal: Boolean;
begin
  Result := True;
end;

constructor TDSCustomNativeRestProxyWriter.Create;
begin
  inherited Create;
  AddCustomTypeMap(TDbxDataTypes.BinaryBlobType, TDBXSubDataTypes.JSONStreamSubType,
    TDSProxyParamAccess.Create('TDBXJSONStream', 'GetJSONStream', 'SetJSONStream', 'Data.DBXCommon')); // do not localize
end;

destructor TDSCustomNativeRestProxyWriter.Destroy;
begin
  FSupportedTypes.Free;
  inherited;
end;

function TDSCustomNativeRestProxyWriter.ExtendedIncludeMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  PtType: Integer;
  PtName: string;
begin
  Param := ProxyMethod.Parameters;
  if Param <> nil then
    while Param <> nil do
    begin
      PtType := Param.DataType;
      if not SupportedTypes.Contains(ptType) then
        Exit(False)
      else if (Param.ParameterDirection = TDBXParameterDirections.ReturnParameter) and (PtType = TDBXDataTypes.WideStringType) then
      begin
        PtName := Param.TypeName;
        if not (PtName.ToLower = 'string') then
          Exit(False);
      end;
      Param := Param.Next;
    end;
  Result := True;
end;

function TDSCustomNativeRestProxyWriter.EnumClasses(
  ACallback: TFunc<TDSProxyClass, Boolean>): Boolean;
var
  Item: TDSProxyClass;
begin
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if not ACallback(Item) then
      Exit(False);
    Item := Item.Next;
  end;
  Result := True;
end;

function TDSCustomNativeRestProxyWriter.EnumMethods(AClass: TDSProxyClass;
  ACallback: TFunc<TDSProxyMethod, Boolean>): Boolean;
var
  Item: TDSProxyMethod;
begin
  Item := AClass.FirstMethod;
  while Item <> nil do
  begin
    if not ACallback(Item) then
      Exit(False);
    Item := Item.Next;
  end;
  Result := True;
end;

function TDSCustomNativeRestProxyWriter.EnumParams(AMethod: TDSProxyMethod;
  ACallback: TFunc<TDSProxyParameter, Boolean>): Boolean;
var
  Param: TDSProxyParameter;
begin
  Param := AMethod.Parameters;
  while Param <> nil do
  begin
    if not ACallback(Param) then
      Exit(False);
    Param := Param.Next;
  end;
  Result := True;
end;

function TDSCustomNativeRestProxyWriter.ExtendedIncludeCacheMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
var
  Param: TDSProxyParameter;
  LClassName: string;
begin
  Param := ProxyMethod.Parameters;
  if Param <> nil then
    while Param <> nil do
    begin
      if IsCachableParameter(Param, LClassName) then
        Exit(True);
      Param := Param.Next;
    end;
  Result := False;
end;

function TDSCustomNativeRestProxyWriter.GetAncestor(
  const ProxyClass: TDSProxyClass): string;
begin
  if (ProxyClass.ProxyClassName = 'TDSAdminClient') or (ProxyClass.ProxyClassName = 'TDSMetadataClient') then
    Result := 'TDSRestClient'
  else
    Result := 'TDSAdminRestClient';
end;

function TDSCustomNativeRestProxyWriter.GetSupportedTypes: TList<integer>;
begin
  if FSupportedTypes = nil then
  begin
    FSupportedTypes := TList<integer>.Create();
    FSupportedTypes.Add(TDBXDataTypes.AnsiStringType);
    FSupportedTypes.Add(TDBXDataTypes.WideStringType);
    FSupportedTypes.Add(TDBXDataTypes.BooleanType);
    FSupportedTypes.Add(TDBXDataTypes.Int8Type);
    FSupportedTypes.Add(TDBXDataTypes.Int16Type);
    FSupportedTypes.Add(TDBXDataTypes.Int32Type);
    FSupportedTypes.Add(TDBXDataTypes.Int64Type);
    FSupportedTypes.Add(TDBXDataTypes.UInt8Type);
    FSupportedTypes.Add(TDBXDataTypes.UInt16Type);
    FSupportedTypes.Add(TDBXDataTypes.UInt32Type);
    FSupportedTypes.Add(TDBXDataTypes.UInt64Type);
    FSupportedTypes.Add(TDBXDataTypes.DoubleType);
    FSupportedTypes.Add(TDBXDataTypes.SingleType);
    FSupportedTypes.Add(TDBXDataTypes.CurrencyType);
    FSupportedTypes.Add(TDBXDataTypes.BcdType);
    FSupportedTypes.Add(TDBXDataTypes.DateType);
    FSupportedTypes.Add(TDBXDataTypes.DatetimeType);
    FSupportedTypes.Add(TDBXDataTypes.TimeType);
    FSupportedTypes.Add(TDBXDataTypes.TimeStampType);
    FSupportedTypes.Add(TDBXDataTypes.JsonValueType);
    FSupportedTypes.Add(TDBXDataTypes.ArrayType);
    FSupportedTypes.Add(TDBXDataTypes.ObjectType);
    FSupportedTypes.Add(TDBXDataTypes.TableType);
    FSupportedTypes.Add(TDBXDataTypes.BinaryBlobType);
  end;
  Result := FSupportedTypes;
end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sDelphiRestProxyWriter, TDSClientProxyWriterDelphi); //Keept to save compatibility with old apps
  TDSProxyWriterFactory.RegisterWriter(sObjectPascalRestProxyWriter, TDSClientProxyWriterDelphi);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sDelphiRestProxyWriter);
  TDSProxyWriterFactory.UnregisterWriter(sObjectPascalRestProxyWriter);
end.

