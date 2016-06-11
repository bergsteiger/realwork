{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyCpp;

interface

uses System.Classes, Datasnap.DSCommonProxy, Datasnap.DSProxyDelphi, Datasnap.DSProxyWriter;

type
  TDSClientProxyWriterCpp = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomCppProxyWriter = class abstract(TDSCustomExtendedProxyWriter)
  public
    constructor Create;
    procedure WriteProxy; override;
  protected
    FUnitName: string;
    procedure StartCppHeader; virtual; abstract;
    procedure EndCppHeader; virtual; abstract;
    procedure WriteFileHeader; override;
    function GetDelphiTypeName(const Param: TDSProxyParameter): string; override;
    procedure WriteInterface; override;
    procedure WriteImplementation; override;
    function GetAssignmentString: string; override;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter): string; override;
  private
    procedure WriteHeaderUses;
    procedure WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean);
    procedure WriteClassInterface(const ProxyClass: TDSProxyClass);
    procedure WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
    procedure WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
    procedure WriteClassImplementation(const ProxyClass: TDSProxyClass);
  end;

  TDSCppProxyWriter = class(TDSCustomCppProxyWriter)
  private
    FStreamWriter: TStreamWriter;
    FHeaderStreamWriter: TStreamWriter;
    FWritingHeader: Boolean;
  protected
    function IncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean; override;
    procedure DerivedWrite(const Line: string); override;
    procedure DerivedWriteLine; override;
    procedure StartCppHeader; override;
    procedure EndCppHeader; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
    property HeaderStreamWriter: TStreamWriter read FHeaderStreamWriter write FHeaderStreamWriter;
    destructor Destroy; override;
  end;

const
  sCPlusPlusBuilderDBXProxyWriter = 'C++Builder DBX';

implementation

uses Data.DBXClientResStrs, Data.DBXCommon, System.StrUtils, System.SysUtils
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

function CanMarshal: Boolean;
begin
  Result := False;
end;

constructor TDSCustomCppProxyWriter.Create;
begin
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
  AddCustomTypeMap(TDbxDataTypes.AnsiStringType,
    TDSProxyParamAccess.Create('System::string', 'GetString', 'SetString'));
end;

procedure TDSCustomCppProxyWriter.WriteProxy;
begin
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
  inherited;
end;

procedure TDSCustomCppProxyWriter.WriteFileHeader;
begin
  inherited WriteFileHeader;
  WriteLine('#include "' + FUnitName + '.h"');
  WriteLine;
end;

function TDSCustomCppProxyWriter.GetDelphiTypeName(const Param: TDSProxyParameter): string;
var
  Name: string;
begin
  Name := Param.TypeName;
  if SameText(Name, 'string') then
    Result := 'System::UnicodeString'
  else if Name = 'WideString' then
    Result := 'System::WideString'
  else if Name = 'WideString' then
    Result := 'System::WideString'
  else if Name = 'AnsiString' then
    Result := 'System::AnsiString'
  else if Name = 'TDateTime' then
    Result := 'System::TDateTime'
  else if Name = 'Currency' then
    Result := 'System::Currency'
  else if Name = 'ShortInt' then
    Result := 'System::ShortInt' // 'signed char'
  else if Name = 'Byte' then
    Result := 'System::Byte' //  'unsigned char'
  else if Name = 'OleVariant' then
    Result := 'System::OleVariant'
  else if Name = 'TDBXTime' then
    Result := 'Dbxcommon::TDBXTime'
  else if Name = 'TDBXDate' then
    Result := 'Dbxcommon::TDBXDate'
  else if Name = 'SmallInt' then
    Result := 'short'
  else if Name = 'Boolean' then
    Result := 'bool'
  else if Name = 'Int64' then
    Result := '__int64'
  else if Name = 'Single' then
    Result := 'float'
  else if Name = 'Double' then
    Result := 'double'
  else if Name = 'Integer' then
    Result := 'int'
  else if Name = 'Word' then
    Result := 'unsigned short'
  else if Name = 'TDBXReader' then
    Result := 'TDBXReader*'
  else if Name = 'TDBXConnection' then
    Result := 'TDBXConnection*'
  else if (not CanMarshal) and (Param.DataType = TDBXDataTypes.JsonValueType) and (not IsKnownJSONTypeName(Name)) then
    Result := 'TJSONObject*'
  else
    Result := inherited GetDelphiTypeName(Param) + '*';
end;

procedure TDSCustomCppProxyWriter.WriteHeaderUses;
begin
  WriteLine('#include "Data.DBXCommon.hpp"');
  WriteLine('#include "System.Classes.hpp"');
  WriteLine('#include "System.SysUtils.hpp"');
  WriteLine('#include "Data.DB.hpp"');
  WriteLine('#include "Data.SqlExpr.hpp"');
  WriteLine('#include "Data.DBXDBReaders.hpp"');
  WriteLine('#include "Data.DBXCDSReaders.hpp"');
end;

procedure TDSCustomCppProxyWriter.WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean);
var
  LDelphiTypeName, Line: string;
  ParamCount, ProcessedCount: Integer;
  Param, Parameters: TDSProxyParameter;
  LIsPointer: Boolean;
begin
  Parameters := Method.Parameters;
  ParamCount := Method.ParameterCount;
  if Method.HasReturnValue then
  begin
    ParamCount := ParamCount - 1;
    Param := Method.ReturnParameter;
    Line := GetDelphiTypeName(Param) + ' ';
  end
  else
    Line := 'void ';
  Line := Line + '__fastcall ';
  if IsInterface then
    Line := Line + Method.ProxyMethodName
  else
    Line := Line + ProxyClass.ProxyClassName + 'Client::' + Method.ProxyMethodName;
  if ParamCount > 0 then
  begin
    Line := Line + '(';
    Param := Parameters;
    ProcessedCount := 0;
    while (Param <> nil) and (ProcessedCount < ParamCount) do
    begin
      LDelphiTypeName := GetDelphiTypeName(Param);
      LIsPointer := LDelphiTypeName[LDelphiTypeName.Length] = '*';
      Line := Line + LDelphiTypeName + ' ';
      if not LIsPointer then
        case Param.ParameterDirection of
          TDBXParameterDirections.OutParameter,
          TDBXParameterDirections.InOutParameter:
            Line := Line + '&';
        end
      else
        case Param.DataType of
          TDBXDataTypes.JsonValueType,
          TDBXDataTypes.TableType,
          TDBXDataTypes.BlobType,
          TDBXDataTypes.BinaryBlobType:
           case Param.ParameterDirection of
             TDBXParameterDirections.OutParameter,
             TDBXParameterDirections.InOutParameter:
               if not IsKnownDBXValueTypeName(LDelphiTypeName) then
                 // Parameters that are objects, like TStream, need to be passed as a pointer to a reference
                 Line := Line + '&';
           end;
        end;
      Line := Line + Param.ParameterName;
      Inc(ProcessedCount);
      if ProcessedCount < ParamCount then
        Line := Line + ', ';
      Param := Param.Next;
    end;
    Line := Line + ')';
  end
  else
    Line := Line + '()';
  if IsInterface then
    Line := Line + ';';
  WriteLine(Line);
end;

procedure TDSCustomCppProxyWriter.WriteClassInterface(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
  ClassName: string;
begin
  ClassName := ProxyClass.ProxyClassName + 'Client';
  Indent;
  WriteLine('class ' + ClassName + ' : public TObject');
  WriteLine('{');
  WriteLine('private:');
  Indent;
  WriteLine('TDBXConnection *FDBXConnection;');
  WriteLine('bool FInstanceOwner;');
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('TDBXCommand *F' + Methods.ProxyMethodName + 'Command;');
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('public:');
  Indent;
  WriteLine('__fastcall ' +  ClassName + '(TDBXConnection *ADBXConnection);');
  WriteLine('__fastcall ' + ClassName + '(TDBXConnection *ADBXConnection, bool AInstanceOwner);');
  WriteLine('__fastcall ~' + ClassName + '();');
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodSignature(ProxyClass, Methods, True);
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('};');
  Outdent;
  WriteLine;
end;

procedure TDSCustomCppProxyWriter.WriteInterface;
var
  Item: TDSProxyClass;
begin
  StartCppHeader;
  WriteLine('#ifndef ' + FUnitName + 'H');
  WriteLine('#define ' + FUnitName + 'H');
  WriteLine;
  WriteHeaderUses;
  WriteLine;
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassInterface(Item);
    Item := Item.Next;
  end;
  WriteLine('#endif');
  EndCppHeader;
end;

procedure TDSCustomCppProxyWriter.WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
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
  WriteLine('{');
  Indent;
  CommandName := 'F' + ProxyMethod.ProxyMethodName + 'Command';
  WriteLine('if (' + CommandName + ' == NULL)');
  WriteLine('{');
  Indent;
  WriteLine(CommandName + ' = FDBXConnection->CreateCommand();');
  WriteLine(CommandName + '->CommandType = TDBXCommandTypes_DSServerMethod;');
  WriteLine(CommandName + '->Text = "' + ProxyMethod.MethodAlias + '";');
  WriteLine(CommandName + '->Prepare();');
  Outdent;
  WriteLine('}');
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
          WriteLine('if (' + Param.ParameterName + ' == NULL) ');
          Indent;
          WriteLine(CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value->SetNull();');
          Outdent;
          WriteLine('else');
          Indent;
          WriteLine(CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value->SetValue(' + Param.ParameterName + ');');
          Outdent;
        end
        else
          WriteLine(CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value->' + GetSetter(Param) + ';');
      end;
      Ordinal := Ordinal + 1;
      Param := Param.Next;
    end;
  end;
  WriteLine(CommandName + '->ExecuteUpdate();');
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
          WriteLine('if (' + Param.ParameterName + ' != NULL)');
          Indent;
          WriteLine(Param.ParameterName + '->SetValue(' + CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value);');
          Outdent;
        end
        else
        begin
          Lhs := Param.ParameterName + ' = ';
          Rhs := CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value->' + GetGetter(Param);
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
      WriteLine('return FDBXConnection;')
    else if IsKnownDBXValueTypeName(ProxyMethod.ReturnParameter.TypeName) then
    begin
      WriteLine(GetDelphiTypeName(ProxyMethod.ReturnParameter) + ' result = new ' + ProxyMethod.ReturnParameter.TypeName + '();');
      WriteLine('result->SetValue(' + CommandName + '->Parameters->Parameter[' + IntToStr(ParamCount) + ']->Value)');
      WriteLine('return result;');
    end
    else
    begin
      Lhs := GetDelphiTypeName(ProxyMethod.ReturnParameter) + ' result = ';
      Param := ProxyMethod.ReturnParameter;
      Rhs := CommandName + '->Parameters->Parameter[' + IntToStr(ParamCount) + ']->Value->' + GetGetter(Param);
      WriteOutgoingParameter(Lhs, Rhs, Param, CommandName, 'result');
      WriteLine('return result;');
    end;
  end;
  Outdent;
  WriteLine('}');
  WriteLine;
end;

procedure TDSCustomCppProxyWriter.WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
var
  LTypeName, Rhs: string;
begin
  Rhs := InRhs;
  if (Param.DataType = TDBXDataTypes.TableType) and IsKnownTableTypeName(Param.TypeName) then
  begin
    if string.Compare(Param.TypeName, 'TDataSet', True) = 0 then
    begin
      Rhs := 'new TCustomSQLDataSet(NULL, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
      WriteLine(ParamName + '->Open();');
    end
    else if string.Compare(Param.TypeName, 'TParams', True) = 0 then
    begin
      Rhs := 'TDBXParamsReader::ToParams(NULL, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
    end
    else
      WriteLine(Lhs + Rhs + ';');
    WriteLine('if (FInstanceOwner)');
    Indent;
    WriteLine(CommandName + '->FreeOnExecute(' + ParamName + ');');
    Outdent;
  end
  else if (Param.DataType = TDBXDataTypes.TableType) or (Param.DataType = TDBXDataTypes.BinaryBlobType) then
    WriteLine(Lhs + Rhs + '(FInstanceOwner);')
  else if Param.DataType = TDBXDataTypes.JsonValueType then
  begin
    LTypeName := GetDelphiTypeName(Param);
    if not SameText(LTypeName, 'TJSONValue*') then
      WriteLine(Lhs + '(' + LTypeName + ')' + Rhs + '(FInstanceOwner);')
    else
      WriteLine(Lhs + Rhs + '(FInstanceOwner);')
  end
  else if ContainsText(Rhs,'->Get') then
    WriteLine(Lhs + Rhs + '();')
  else
    WriteLine(Lhs + Rhs + ';');
end;

procedure TDSCustomCppProxyWriter.WriteClassImplementation(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
  ConErrorMessage: string;
  LCommandName: string;
begin
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteMethodImplementation(ProxyClass, Methods);
    Methods := Methods.Next;
  end;
  WriteLine;
  WriteLine('__fastcall  ' + ProxyClass.ProxyClassName + 'Client::' + ProxyClass.ProxyClassName + 'Client(TDBXConnection *ADBXConnection)');
  WriteLine('{');
  Indent;
  ConErrorMessage := SConError;
  WriteLine('if (ADBXConnection == NULL)');
  Indent;
  WriteLine('throw EInvalidOperation("' + ConErrorMessage + '");');
  Outdent;
  WriteLine('FDBXConnection = ADBXConnection;');
  WriteLine('FInstanceOwner = True;');
  Outdent;
  WriteLine('}');
  WriteLine;
  WriteLine;
  WriteLine('__fastcall  ' + ProxyClass.ProxyClassName + 'Client::' + ProxyClass.ProxyClassName + 'Client(TDBXConnection *ADBXConnection, bool AInstanceOwner)');
  WriteLine('{');
  Indent;
  ConErrorMessage := SConError;
  WriteLine('if (ADBXConnection == NULL) ');
  Indent;
  WriteLine('throw EInvalidOperation("' + ConErrorMessage + '");');
  Outdent;
  WriteLine('FDBXConnection = ADBXConnection;');
  WriteLine('FInstanceOwner = AInstanceOwner;');
  Outdent;
  WriteLine('}');
  Outdent;
  WriteLine;
  WriteLine;
  WriteLine('__fastcall  ' + ProxyClass.ProxyClassName + 'Client::~' + ProxyClass.ProxyClassName + 'Client()');
  WriteLine('{');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
    begin
      LCommandName := 'F' + Methods.ProxyMethodName + 'Command';
      WriteLine('delete ' + LCommandName + ';');
    end;
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('}');
  WriteLine;
end;

procedure TDSCustomCppProxyWriter.WriteImplementation;
var
  Item: TDSProxyClass;
begin
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassImplementation(Item);
    Item := Item.Next;
  end;
end;

function TDSCustomCppProxyWriter.GetAssignmentString: string;
begin
  Result := '=';
end;

function TDSCustomCppProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): string;
begin
  Result := '(new TDBXDataSetReader(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

function TDSCustomCppProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): string;
begin
  Result := '(new TDBXParamsReader(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

{ TDSCppProxyWriter }

procedure TDSCppProxyWriter.DerivedWrite(const Line: string);
begin
  if FWritingHeader then
    if FHeaderStreamWriter <> nil then
      FHeaderStreamWriter.Write(Line)
    else
      ProxyWriters[sInterface].Write(Line)
  else
    if FStreamWriter <> nil then
      FStreamWriter.Write(Line)
    else
      ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSCppProxyWriter.DerivedWriteLine;
begin
  if FWritingHeader then
    if HeaderStreamWriter <> nil then
      FHeaderStreamWriter.WriteLine
    else
      ProxyWriters[sInterface].WriteLine
  else
    if FStreamWriter <> nil then
      FStreamWriter.WriteLine
    else
      ProxyWriters[sImplementation].WriteLine;
end;

destructor TDSCppProxyWriter.Destroy;
begin
  FreeAndNil(FHeaderStreamWriter);
  FreeAndNil(FStreamWriter);
  inherited;
end;

procedure TDSCppProxyWriter.EndCppHeader;
begin
  FWritingHeader := False;
end;

procedure TDSCppProxyWriter.StartCppHeader;
begin
  FWritingHeader := True;
end;

function TDSCppProxyWriter.IncludeMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
begin
  // C++ does not support marshalling/unmarshalling
  // But will support as JSONObject
  Result := inherited; //  and not ProxyMethod.HasParametersWithUserType;
end;


{ TDSClientProxyWriterCpp }

function TDSClientProxyWriterCpp.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSCppProxyWriter.Create;
end;

function TDSClientProxyWriterCpp.FileDescriptions: TDSProxyFileDescriptions;
begin
  SetLength(Result, 2);
  Result[0].ID := sImplementation;
  Result[0].DefaultFileExt := '.cpp';
  Result[1].ID := sInterface;
  Result[1].DefaultFileExt := '.h';
end;

function TDSClientProxyWriterCpp.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'DSProxyCpp';
  Result.DefaultExcludeClasses := sDSAdminClassName + ';' + sDSMetadataClassName; // 'DSMetadata;DSAdmin';
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language :=  sDSProxyCppLanguage;
  Result.Features := [feConnectsWithDBXConnection, feDBXClient];
  Result.DefaultEncoding := TEncoding.UTF8;

end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sCPlusPlusBuilderDBXProxyWriter, TDSClientProxyWriterCpp);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sCPlusPlusBuilderDBXProxyWriter);

end.
