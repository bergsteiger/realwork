{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProxyDelphiNative;

interface

uses
  Datasnap.DSCommonProxy, Datasnap.DSProxyDelphi, DataSnap.DSProxyWriter, System.Classes;


type
  TDSClientProxyWriterDelphi = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomDelphiProxyWriter = class abstract(TDSCustomExtendedProxyWriter)
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
    procedure WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean);
    procedure WriteClassInterface(const ProxyClass: TDSProxyClass);
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
    procedure WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass);
  end;

  TDSDelphiProxyWriter = class(TDSCustomDelphiProxyWriter)
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
  sDelphiDBXProxyWriter = 'Delphi DBX';
  sObjectPascalDBXProxyWriter = 'Object Pascal DBX';

implementation

uses
  Data.DBXCommon, System.SysUtils;

{ TDSClientProxyWriterDelphi }

function TDSClientProxyWriterDelphi.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSDelphiProxyWriter.Create;
end;

function TDSClientProxyWriterDelphi.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyDelphi';
  Result.DefaultExcludeClasses := sDSMetadataClassName + ';' + sDSAdminClassName; // 'DSMetadata;DSAdmin';
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language :=  sDSProxyDelphiLanguage;
  Result.Features :=  [feConnectsWithDSRestConnection, feDBXClient];
  Result.DefaultEncoding := TEncoding.UTF8;

end;

function TDSClientProxyWriterDelphi.FileDescriptions: TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation;
  Result[0].DefaultFileExt := '.pas';
end;

{ TDSCustomDelphiProxyWriter }

constructor TDSCustomDelphiProxyWriter.Create;
begin
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
  AddCustomTypeMap(TDbxDataTypes.AnsiStringType,
    TDSProxyParamAccess.Create('string', 'GetString', 'SetString'));
  AddCustomTypeMap(TDbxDataTypes.BinaryBlobType, TDBXSubDataTypes.JSONStreamSubType,
    TDSProxyParamAccess.Create('TDBXJSONStream', 'GetJSONStream', 'SetJSONStream', 'Data.DBXCommon')); // do not localize
end;

procedure TDSCustomDelphiProxyWriter.WriteProxy;
begin
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
  inherited;
end;

procedure TDSCustomDelphiProxyWriter.WriteInterfaceUses;
var
  Item: TDSProxyClass;
  PMethod: TDSProxyMethod;
  PParam: TDSProxyParameter;
  Line, UnitName: string;
begin
  Line := 'uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders,';
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

procedure TDSCustomDelphiProxyWriter.WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean);
var
  Line: string;
  ParamCount: Integer;
  ProcessedCount: Integer;
  Parameters: TDSProxyParameter;
  Param: TDSProxyParameter;
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
  if ParamCount > 0 then
  begin
    Line := Line + '(';
    Param := Parameters;
    ProcessedCount := 0;
    while (Param <> nil) and (ProcessedCount < ParamCount) do
    begin
      case Param.ParameterDirection of
        TDBXParameterDirections.OutParameter:
          Line := Line + 'out ';
        TDBXParameterDirections.InOutParameter:
          if not IsKnownDBXValueTypeName(Param.TypeName) then
            Line := Line + 'var ';
      end;
      Line := Line + Param.ParameterName + ': ' + GetDelphiTypeName(Param);
      ProcessedCount := ProcessedCount + 1;
      if (ProcessedCount) < ParamCount then
        Line := Line + '; ';
      Param := Param.Next;
    end;
    Line := Line + ')';
  end;
  if Method.HasReturnValue then
  begin
    Param := Method.ReturnParameter;
    Line := Line + ': ' + GetDelphiTypeName(Param);
  end;
  WriteLine(Line + ';');
end;

procedure TDSCustomDelphiProxyWriter.WriteClassInterface(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  Indent;
  WriteLine(ProxyClass.ProxyClassName + 'Client = class(TDSAdminClient)');
  WriteLine('private');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command: TDBXCommand;');
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('public');
  Indent;
  WriteLine('constructor Create(ADBXConnection: TDBXConnection); overload;');
  WriteLine('constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;');
  WriteLine('destructor Destroy; override;');
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodSignature(ProxyClass, Methods, True);
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('end;');
  Outdent;
  WriteLine;
end;

procedure TDSCustomDelphiProxyWriter.WriteInterface;
var
  Item: TDSProxyClass;
begin
  WriteLine('unit ' + FUnitName + ';');
  WriteLine;
  WriteLine('interface');
  WriteLine;
  WriteInterfaceUses;
  WriteLine;
  WriteLine('type');
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassInterface(Item);
    Item := Item.Next;
  end;
end;

procedure TDSCustomDelphiProxyWriter.WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  CommandName: string;
  ParamCount: Integer;
  Params: TDSProxyParameter;
  Param: TDSProxyParameter;
  InputCount: Integer;
  OutputCount: Integer;
  Ordinal: Integer;
  Rhs: string;
  Lhs: string;
begin
  WriteMethodSignature(ProxyClass, ProxyMethod, False);
  WriteLine('begin');
  Indent;
  CommandName := 'F' + ProxyMethod.ProxyMethodName + 'Command';
  WriteLine('if ' + CommandName + ' = nil then');
  WriteLine('begin');
  Indent;
  WriteLine(CommandName + ' := FDBXConnection.CreateCommand;');
  WriteLine(CommandName + '.CommandType := TDBXCommandTypes.DSServerMethod;');
  WriteLine(CommandName + '.Text := ''' + ProxyMethod.MethodAlias + ''';');
  WriteLine(CommandName + '.Prepare;');
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
          WriteLine('FMarshal := TDBXClientCommand(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].ConnectionHandler).GetJSONMarshaler;');
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
  WriteLine(CommandName + '.ExecuteUpdate;');
  if OutputCount > 0 then
  begin
    Param := Params;
    Ordinal := 0;
    while Param <> nil do
    begin
      if (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Param.ParameterDirection = TDBXParameterDirections.OutParameter) then
      begin
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
          WriteLine('FUnMarshal := TDBXClientCommand(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].ConnectionHandler).GetJSONUnMarshaler;');
          WriteLine('try');
          Indent;
          WriteLine(Param.ParameterName + ' := ' + Param.TypeName + '(FUnMarshal.UnMarshal(' + CommandName + '.Parameters[' + IntToStr(Ordinal) + '].Value.GetJSONValue(True)));');
          WriteLine('if FInstanceOwner then');
          Indent;
          WriteLine(CommandName + '.FreeOnExecute(' + Param.ParameterName + ');');
          OutDent;
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
    if ProxyMethod.ReturnParameter.DataType = TDBXDataTypes.DbxConnectionType then
      WriteLine('Result := FDBXConnection;')
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
      WriteLine('FUnMarshal := TDBXClientCommand(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].ConnectionHandler).GetJSONUnMarshaler;');
      WriteLine('try');
      Indent;
      WriteLine('Result := ' + Param.TypeName + '(FUnMarshal.UnMarshal(' + CommandName + '.Parameters[' + IntToStr(ParamCount) + '].Value.GetJSONValue(True)));');
      WriteLine('if FInstanceOwner then');
      Indent;
      WriteLine(CommandName + '.FreeOnExecute(Result);');
      OutDent;
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
  Outdent;
  WriteLine('end;');
  WriteLine;
end;

procedure TDSCustomDelphiProxyWriter.WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
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

procedure TDSCustomDelphiProxyWriter.WriteClassImplementation(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
begin
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodImplementation(ProxyClass, Methods);
    Methods := Methods.Next;
  end;
  WriteLine;
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(ADBXConnection: TDBXConnection);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(ADBXConnection);');
  Outdent;
  WriteLine('end;');
  WriteLine;
  WriteLine;
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(ADBXConnection, AInstanceOwner);');
  Outdent;
  WriteLine('end;');
  WriteLine;
  WriteLine;
  WriteLine('destructor ' + ProxyClass.ProxyClassName + 'Client.Destroy;');
  WriteLine('begin');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('F' + Methods.ProxyMethodName + 'Command.DisposeOf;');
    Methods := Methods.Next;
  end;
  WriteLine('inherited;');
  Outdent;
  WriteLine('end;');
  WriteLine;
end;

procedure TDSCustomDelphiProxyWriter.WriteImplementation;
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

function TDSCustomDelphiProxyWriter.GetAssignmentString: string;
begin
  Result := ':=';
end;

function TDSCustomDelphiProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): string;
begin
  Result := '(TDBXDataSetReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

function TDSCustomDelphiProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): string;
begin
  Result := '(TDBXParamsReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

{ TDSDelphiProxyWriter }

procedure TDSDelphiProxyWriter.DerivedWrite(const Line: string);
begin
  if Assigned(StreamWriter) then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSDelphiProxyWriter.DerivedWriteLine;
begin
  if Assigned(StreamWriter) then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSDelphiProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sDelphiDBXProxyWriter, TDSClientProxyWriterDelphi); //Keept to save compatibility with old apps
  TDSProxyWriterFactory.RegisterWriter(sObjectPascalDBXProxyWriter, TDSClientProxyWriterDelphi);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sDelphiDBXProxyWriter);
  TDSProxyWriterFactory.UnregisterWriter(sObjectPascalDBXProxyWriter);

end.
