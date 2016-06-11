{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyCppRest;

interface

uses System.Classes, Datasnap.DSProxyWriter, Datasnap.DSCommonProxy, Datasnap.DSProxyDelphiRest;

type
  TDSClientProxyWriterCppRest = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomCppRestProxyWriter = class abstract(TDSCustomNativeRestProxyWriter)
  public
    constructor Create;
    procedure WriteProxy; override;
  protected
    FUnitName: string;
    function CanMarshal: Boolean; override;
    procedure StartCppHeader; virtual; abstract;
    procedure EndCppHeader; virtual; abstract;
    procedure WriteFileHeader; override;
    function GetDelphiTypeName(const Param: TDSProxyParameter): string; override;
    procedure WriteInterface; override;
    procedure WriteImplementation; override;
    function GetAssignmentString: string; override;
    function GetCreateDataSetReader(const Param: TDSProxyParameter): string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter): string; override;
    function IncludeMethod(const ProxyMethod: TDSProxyMethod): Boolean; override;
  private
    procedure WriteHeaderUses;
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
    function GetCacheValueInterfaceTypeName(
      const ACachedValueClassName: string): string;
  end;

  TDSCppRestProxyWriter = class(TDSCustomCppRestProxyWriter)
  private
    FStreamWriter: TStreamWriter;
    FHeaderStreamWriter: TStreamWriter;
    FWritingHeader: Boolean;
  protected
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
  sCPlusPlusBuilderRestProxyWriter = 'C++Builder REST';

implementation

uses Data.DBXCommon, System.StrUtils, System.SysUtils;

function TDSCustomCppRestProxyWriter.CanMarshal: Boolean;
begin
  Result := False; // Can't marshal TCustomer as TJSONValue
end;

constructor TDSCustomCppRestProxyWriter.Create;
begin
  inherited Create;
  FIndentIncrement := 2;
  FIndentString := '';
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
end;

procedure TDSCustomCppRestProxyWriter.WriteProxy;
begin
  FUnitName := ChangeFileExt(ExtractFileName(FUnitFileName), '');
  inherited;
end;

procedure TDSCustomCppRestProxyWriter.WriteFileHeader;
begin
  inherited WriteFileHeader;
  WriteLine('#include "' + FUnitName + '.h"');
  WriteLine;
  WriteTDSRestParameterMetaData;
end;

function TDSCustomCppRestProxyWriter. GetCacheValueInterfaceTypeName(const ACachedValueClassName: string): string;
begin
  Result :=  '_di_I' + ACachedValueClassName;
end;

function TDSCustomCppRestProxyWriter.GetDelphiTypeName(const Param: TDSProxyParameter): string;
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

procedure TDSCustomCppRestProxyWriter.WriteHeaderUses;
begin
  WriteLine('#include "Data.DBXCommon.hpp"');
  WriteLine('#include "System.Classes.hpp"');
  WriteLine('#include "System.SysUtils.hpp"');
  WriteLine('#include "Data.DB.hpp"');
  WriteLine('#include "Data.SqlExpr.hpp"');
  WriteLine('#include "Data.DBXDBReaders.hpp"');
  WriteLine('#include "Data.DBXCDSReaders.hpp"');
  WriteLine('#include "DataSnap.DSProxyRest.hpp"');
end;

procedure TDSCustomCppRestProxyWriter.WriteMethodSignature(const ProxyClass: TDSProxyClass; const Method: TDSProxyMethod; const IsInterface: Boolean;
  AOptions: TNativeRestProxyWriterOptions);
var
  LCachedValueClassName, LDelphiTypeName, Line, LRequestFilter: string;
  ParamCount, ProcessedCount: Integer;
  Param, Parameters: TDSProxyParameter;
  LIsPointer, LSupportsRequestFilter: Boolean;
begin
  Parameters := Method.Parameters;
  ParamCount := Method.ParameterCount;
  if Method.HasReturnValue then
  begin
    Dec(ParamCount);
    Param := Method.ReturnParameter;
    Line := GetDelphiTypeName(Param) + ' ';
    if (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) then
      Line := GetCacheValueInterfaceTypeName(LCachedValueClassName) + ' '
    else
      Line := GetDelphiTypeName(Param) + ' ';
  end
  else
    Line := 'void ';
  Line := Line + '__fastcall ';
  if IsInterface then
    Line := Line + Method.ProxyMethodName
  else
    Line := Line + ProxyClass.ProxyClassName + 'Client::' + Method.ProxyMethodName;
  if optCacheParameters in AOptions then
    Line := Line + '_Cache';
  LSupportsRequestFilter := SupportsRequestFilter(Method);
  if LSupportsRequestFilter then
    if IsInterface then
      LRequestFilter := 'const String& ARequestFilter = String()'
    else
      LRequestFilter := 'const String& ARequestFilter';
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
        //Line := Line +  'out ' + Param.ParameterName + ': I' + LCachedValueClassName;
        Line := Line + GetCacheValueInterfaceTypeName(LCachedValueClassName) + ' &' + Param.ParameterName;
      end
      else
      begin
        LDelphiTypeName := GetDelphiTypeName(Param);
        LIsPointer := LDelphiTypeName.Chars[LDelphiTypeName.Length - 1] = '*';
        Line := Line + LDelphiTypeName + ' ';
        if not LIsPointer then
          case Param.ParameterDirection of
            TDBXParameterDirections.OutParameter:
                  Line := Line + ' &';
            TDBXParameterDirections.InOutParameter:
              if not IsKnownDBXValueTypeName(Param.TypeName) then
                if not ((optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName)) then
                  Line := Line + ' &';
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
        if (optCacheParameters in AOptions) and IsCachableParameter(Param, LCachedValueClassName) and
          (Param.ParameterDirection = TDBXParameterDirections.InOutParameter) then
        begin
          Line := Line + ', ';
          //Line := Line +  'out ' + Param.ParameterName + '_Cache: I' + LCachedValueClassName;
          Line := Line + GetCacheValueInterfaceTypeName(LCachedValueClassName) +
                   ' &' +  Param.ParameterName + '_Cache';
        end;
     end;
     Inc(ProcessedCount);
      if ProcessedCount < ParamCount then
        Line := Line + ', ';
      Param := Param.Next;
    end;
    if LSupportsRequestFilter then
    begin
      if ProcessedCount > 0 then
        Line := Line + ', ';
      Line := Line + LRequestFilter;
    end;
    Line := Line + ')';
  end
  else
  begin
    if LSupportsRequestFilter then
      Line := Line + '(' + LRequestFilter + ')'
    else
      Line := Line + '()';
  end;
  if IsInterface then
    Line := Line + ';';
  WriteLine(Line);
end;

procedure TDSCustomCppRestProxyWriter.WriteClassInterface(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
  ClassName: string;
  LAncestor: string;
begin
  LAncestor := GetAncestor(ProxyClass);
  ClassName := ProxyClass.ProxyClassName + 'Client';
  Indent;
  WriteLine('class ' + ClassName + ' : public ' + LAncestor);
  WriteLine('{');
  WriteLine('private:');
  Indent;
  Methods := ProxyClass.FirstMethod;
  while Methods <> nil do
  begin
    if IncludeMethod(Methods) then
      WriteLine('TDSRestCommand *F' + Methods.ProxyMethodName + 'Command;');
    if IncludeCacheMethod(Methods) then
      WriteLine('TDSRestCommand *F' + Methods.ProxyMethodName + 'Command_Cache;');
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('public:');
  Indent;
  WriteLine('__fastcall '  + ClassName + '(TDSRestConnection *ARestConnection);');
  WriteLine('__fastcall '  + ClassName + '(TDSRestConnection *ADBXConnection, bool AInstanceOwner);');
  WriteLine('__fastcall ~' + ClassName + '();');
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
  WriteLine('};');
  Outdent;
  WriteLine;
end;

procedure TDSCustomCppRestProxyWriter.WriteInterface;
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
                     
  //WriteTDSRestParameterMetaData;
  WriteLine('#endif');
  EndCppHeader;
end;

const
  sAcceptServerMethodPrefix = 'accept';
  sUpdateServerMethodPrefix = 'update';
  sCancelServerMethodPrefix = 'cancel';
  sHTTPMethodGet = 'GET';
  sHTTPMethodPost = 'POST';
  sHTTPMethodDelete = 'DELETE';
  sHTTPMethodPut = 'PUT';

procedure TDSCustomCppRestProxyWriter.GetHTTPMethodAndPrefix(Method: TDSProxyMethod; out AServerMethodPrefix, AHTTPMethodName: string);
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
      Result := AMethodAlias.Substring(-1, I) + '\"' + AMethodAlias.Substring(I) + '\"';
end;

procedure TDSCustomCppRestProxyWriter.WriteMethodImplementation(const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions);
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
  WriteLine('{');
  Indent;
  CommandName := 'F' + ProxyMethod.ProxyMethodName + 'Command';
  if optCacheParameters in AOptions then
    CommandName := CommandName + '_Cache';
  WriteLine('if (' + CommandName + ' == NULL)');
  WriteLine('{');
  Indent;
  WriteLine(CommandName + ' = FConnection->CreateCommand();');
  WriteLine(CommandName + '->RequestType = "' + LHTTPMethodName + '";');
  WriteLine(CommandName + '->Text = "' + LMethodAlias + '";');
  if ProxyMethod.ParameterCount > 0 then
    WriteLine(CommandName + '->Prepare(' + MakeTDSRestParameterMetaDataTypeName(ProxyClass, ProxyMethod, AOptions) + ', ' + IntToStr(ProxyMethod.ParameterCount-1) + ');');
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
  if optCacheParameters in AOptions then
    LExecute := 'ExecuteCache'
  else
    LExecute := 'Execute';
  if SupportsRequestFilter(ProxyMethod) then
    WriteLine(CommandName + '->' + LExecute + '(ARequestFilter);')
  else
    WriteLine(CommandName + '->' + LExecute + '();');
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
          //Lhs := Lhs + ' = ';
          WriteLine('{');
          WriteLine('T' + LCachedValueClassName + ' * obj(new T' + LCachedValueClassName + '(' + CommandName + '->Parameters->Parameter[' + IntToStr(Ordinal) + ']->Value->GetString()));');
          WriteLine('obj->GetInterface(' + Lhs + ');');
          WriteLine('}');
        end
        else
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
     if (optCacheParameters in AOptions) and IsCachableParameter(ProxyMethod.ReturnParameter, LCachedValueClassName) then
    begin
      WriteLine(GetCacheValueInterfaceTypeName(LCachedValueClassName) + ' _resultIntf;');
      WriteLine('{');
      WriteLine('T' + LCachedValueClassName + '* obj(new T' + LCachedValueClassName + '(' + CommandName + '->Parameters->Parameter[' + IntToStr(ParamCount) + ']->Value->GetString()));');
      WriteLine('obj->GetInterface(_resultIntf);');
      WriteLine('}');
      WriteLine('return _resultIntf;');
    end
    else
    begin
    if ProxyMethod.ReturnParameter.DataType = TDBXDataTypes.DBXConnectionType then
                                            
      WriteLine('return FRestConnection;')
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
  end;
  Outdent;
  WriteLine('}');
  WriteLine;
end;

procedure TDSCustomCppRestProxyWriter.WriteOutgoingParameter(const Lhs: string; const InRhs: string; const Param: TDSProxyParameter; const CommandName: string; const ParamName: string);
var
  Rhs: string;
  LTypeName: string;
begin
  Rhs := InRhs;
  if (Param.DataType = TDBXDataTypes.TableType) and IsKnownTableTypeName(Param.TypeName) then
  begin
    if CompareText(Param.TypeName, 'TDataSet') = 0 then
    begin
      Rhs := 'new TCustomSQLDataSet(NULL, ' + Rhs + '(False), True)';
      WriteLine(Lhs + Rhs + ';');
      WriteLine(ParamName + '->Open();');
    end
    else if CompareText(Param.TypeName, 'TParams') = 0 then
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

procedure TDSCustomCppRestProxyWriter.WriteClassImplementation(const ProxyClass: TDSProxyClass);
var
  Methods: TDSProxyMethod;
  LCommandName: string;
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
  WriteLine;

  WriteLine('__fastcall  ' + ProxyClass.ProxyClassName + 'Client::' + ProxyClass.ProxyClassName + 'Client(TDSRestConnection *ARestConnection): ' + GetAncestor(ProxyClass) + '(ARestConnection)');
  WriteLine('{');
  WriteLine('}');
  WriteLine;
  WriteLine('__fastcall  ' + ProxyClass.ProxyClassName + 'Client::' + ProxyClass.ProxyClassName + 'Client(TDSRestConnection *ARestConnection, bool AInstanceOwner): ' + GetAncestor(ProxyClass) + '(ARestConnection, AInstanceOwner)');
  WriteLine('{');
  WriteLine('}');
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
    if IncludeCacheMethod(Methods) then
    begin
      LCommandName := 'F' + Methods.ProxyMethodName + 'Command_Cache';
      WriteLine('delete ' + LCommandName + ';');
    end;
    Methods := Methods.Next;
  end;
  Outdent;
  WriteLine('}');
  WriteLine;
end;

function TDSCustomCppRestProxyWriter.MakeTDSRestParameterMetaDataTypeName(ProxyClass: TDSProxyClass; Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions): string;
begin
  Result := ProxyClass.ProxyClassName + '_' + Method.ProxyMethodName;
  if optCacheParameters in AOptions then
    Result := Result + '_Cache';
end;

procedure TDSCustomCppRestProxyWriter.WriteMethodTDSRestParameterMetaData(ProxyClass: TDSProxyClass; Method: TDSProxyMethod; AOptions: TNativeRestProxyWriterOptions);
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
  WriteLine(Format('struct TDSRestParameterMetaData %s[] =',
   [MakeTDSRestParameterMetaDataTypeName(ProxyClass, Method, AOptions)]));
  WriteLine('{');
  Indent;
  if ParamCount > 0 then
  begin
    Param := Method.Parameters;
    while Param <> nil do
    begin
      Line := '{';
      Line := Line + '"' + Param.ParameterName + '", ';
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
      Line := Line + IntToStr(LParameterDirection) + ', ';
      Line := Line + IntToStr(LDataType) + ', ';
      Line := Line + '"' + LTypeName + '"}';
      Param := Param.Next;
      if Param <> nil then
        Line := Line + ',';
      WriteLine(Line);
    end;
  end;
  OutDent;
  WriteLine('};');
  OutDent;
  WriteLine;
end;

procedure TDSCustomCppRestProxyWriter.WriteClassTDSRestParameterMetaData(ProxyClass: TDSProxyClass);
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

procedure TDSCustomCppRestProxyWriter.WriteTDSRestParameterMetaData;
var
  Item: TDSProxyClass;
begin
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
      WriteClassTDSRestParameterMetaData(Item);
    Item := Item.Next;
  end;
end;

procedure TDSCustomCppRestProxyWriter.WriteImplementation;
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

function TDSCustomCppRestProxyWriter.GetAssignmentString: string;
begin
  Result := '=';
end;

function TDSCustomCppRestProxyWriter.GetCreateDataSetReader(const Param: TDSProxyParameter): string;
begin
  Result := '(new TDBXDataSetReader(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

function TDSCustomCppRestProxyWriter.GetCreateParamsReader(const Param: TDSProxyParameter): string;
begin
  Result := '(new TDBXParamsReader(' + Param.ParameterName + ', FInstanceOwner), True)';
end;

{ TDSCppRestProxyWriter }

procedure TDSCppRestProxyWriter.DerivedWrite(const Line: string);
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

procedure TDSCppRestProxyWriter.DerivedWriteLine;
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

destructor TDSCppRestProxyWriter.Destroy;
begin
  FreeAndNil(FHeaderStreamWriter);
  FreeAndNil(FStreamWriter);
  inherited;
end;

procedure TDSCppRestProxyWriter.EndCppHeader;
begin
  FWritingHeader := False;
end;

procedure TDSCppRestProxyWriter.StartCppHeader;
begin
  FWritingHeader := True;
end;

function TDSCustomCppRestProxyWriter.IncludeMethod(
  const ProxyMethod: TDSProxyMethod): Boolean;
begin
  // C++ does not support marshalling/unmarshalling
  // But will support as JSONObject
  Result := inherited; // and not ProxyMethod.HasParametersWithUserType;
end;

{ TDSClientProxyWriterCppRest }

function TDSClientProxyWriterCppRest.CreateProxyWriter: TDSCustomProxyWriter;
begin
  Result := TDSCppRestProxyWriter.Create;
end;

function TDSClientProxyWriterCppRest.FileDescriptions: TDSProxyFileDescriptions;
begin
  SetLength(Result, 2);
  Result[0].ID := sImplementation;
  Result[0].DefaultFileExt := '.cpp';
  Result[1].ID := sInterface;
  Result[1].DefaultFileExt := '.h';
end;

function TDSClientProxyWriterCppRest.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'DSProxyCppRest';
  Result.DefaultExcludeClasses := sDSAdminClassName + ';' + sDSMetadataClassName; // 'DSMetadata;DSAdmin';
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := '';
  Result.Language :=  sDSProxyCppLanguage;
  Result.Features := [feConnectsWithDSRestConnection, feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

initialization
  TDSProxyWriterFactory.RegisterWriter(sCPlusPlusBuilderRestProxyWriter, TDSClientProxyWriterCppRest);
finalization
  TDSProxyWriterFactory.UnregisterWriter(sCPlusPlusBuilderRestProxyWriter);

end.
