{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC DataSnap driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.DSProxyDelphi;

interface

uses
  System.Classes, Datasnap.DSCommonProxy, Datasnap.DSProxyWriter;

type
  TDSClientProxyWriterDelphi = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomExtendedProxyWriter = class abstract(TDSCustomProxyWriter)
  protected
    function GetClassNameSuffix: string; virtual;
  public
    function GetProxyClassNames: TArray<string>; virtual;
  end;

  TDSCustomDelphiProxyWriter = class abstract(TDSCustomExtendedProxyWriter)
  public
    constructor Create;
    procedure WriteProxy; override;
  protected
    FUnitName: string;
    procedure WriteInterface; override;
    procedure WriteImplementation; override;
    function GetAssignmentString: String; override;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): String; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter): String; override;
  private
    procedure WriteInterfaceUses;
    procedure WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean);
    procedure WriteClassInterface(const ProxyClass: TDSProxyClass);
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
    procedure WriteOutgoingParameter(const Lhs: String; const InRhs: String; const Param: TDSProxyParameter; const CommandName: String; const ParamName: String);
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass);
  end;

  TDSDelphiProxyWriter = class(TDSCustomDelphiProxyWriter)
  private
    FStreamWriter: TStreamWriter;
  protected
    procedure DerivedWrite(const Line: String); override;
    procedure DerivedWriteLine; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
    destructor Destroy; override;
  end;

const
  sDelphiFireDACProxyWriter = 'Delphi FireDAC';

implementation

uses
  Data.DBXCommon, Data.DBXPlatform, System.SysUtils,
  FireDAC.Stan.Util;

constructor TDSCustomDelphiProxyWriter.Create;
begin
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
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
  UnitName: String;
  Line: String;
begin
  Line := 'uses Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, FireDAC.Stan.Util, FireDAC.Comp.Client,';
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
          UnitName := PParam.TypeUnit;
          if (Length(UnitName) > 0) and (not (CompareText('system', UnitName) = 0)) then
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
  Line: String;
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
  WriteLine('constructor Create(AADConnection: TFDConnection); overload;');
  WriteLine('constructor Create(AADConnection: TFDConnection; AInstanceOwner: Boolean); overload;');
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
  CommandName: String;
  ParamCount: Integer;
  Params: TDSProxyParameter;
  Param: TDSProxyParameter;
  InputCount: Integer;
  OutputCount: Integer;
  Ordinal: Integer;
  Rhs: String;
  Lhs: String;
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
          WriteLine('FDFree(' + Param.ParameterName + ');');
          Outdent;
          Outdent;
          WriteLine('finally');
          Indent;
          WriteLine('FDFreeAndNil(FMarshal);');
          Outdent;
          WriteLine('end;');
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
          WriteLine('FDFreeAndNil(FUnMarshal)');
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
      WriteLine('FDFreeAndNil(FUnMarshal)');
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

procedure TDSCustomDelphiProxyWriter.WriteOutgoingParameter(const Lhs: String; const InRhs: String; const Param: TDSProxyParameter; const CommandName: String; const ParamName: String);
var
  Rhs: String;
begin
  Rhs := InRhs;
  if (Param.DataType = TDBXDataTypes.TableType) and IsKnownTableTypeName(Param.TypeName) then
  begin
    if CompareText(Param.TypeName, 'TDataSet') = 0 then
    begin
      Rhs := 'TCustomSQLDataSet.Create(nil, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
      WriteLine(ParamName + '.Open;');
    end
    else if CompareText(Param.TypeName, 'TParams') = 0 then
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
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(AADConnection: TFDConnection);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(TObject(AADConnection.CliObj) as TDBXConnection);');
  Outdent;
  WriteLine('end;');
  WriteLine;
  WriteLine;
  WriteLine('constructor ' + ProxyClass.ProxyClassName + 'Client.Create(AADConnection: TFDConnection; AInstanceOwner: Boolean);');
  WriteLine('begin');
  Indent;
  WriteLine('inherited Create(TObject(AADConnection.CliObj) as TDBXConnection, AInstanceOwner);');
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
      WriteLine('FDFreeAndNil(F' + Methods.ProxyMethodName + 'Command);');
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

function TDSCustomDelphiProxyWriter.GetAssignmentString: String;
begin
  Result := ':=';
end;


function TDSCustomDelphiProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): String;
begin
  Result := '(TDBXDataSetReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

function TDSCustomDelphiProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): String;
begin
  Result := '(TDBXParamsReader.Create(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

{ TDSDelphiProxyWriter }

procedure TDSDelphiProxyWriter.DerivedWrite(const Line: String);
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
  FDFreeAndNil(FStreamWriter);
  inherited;
end;

{ TDSClientProxyWriterDelphi }

function TDSClientProxyWriterDelphi.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSDelphiProxyWriter.Create;
end;

function TDSClientProxyWriterDelphi.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'FireDAC.Phys.DSProxyDelphi';
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

{ TDSCustomExtendedProxyWriter }

function TDSCustomExtendedProxyWriter.GetClassNameSuffix: string;
begin
  Result := 'Client';
end;

function TDSCustomExtendedProxyWriter.GetProxyClassNames: TArray<string>;
var
  Item: TDSProxyClass;
begin
  SetLength(Result, 0);
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
    begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := Item.ProxyClassName + GetClassNameSuffix;
    end;
    Item := Item.Next;
  end;
end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sDelphiFireDACProxyWriter, TDSClientProxyWriterDelphi);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sDelphiFireDACProxyWriter);

end.
