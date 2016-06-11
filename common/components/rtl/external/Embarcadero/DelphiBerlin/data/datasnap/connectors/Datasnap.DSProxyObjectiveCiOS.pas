{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyObjectiveCiOS;

interface

uses
  Data.DBXPlatform,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  Datasnap.DSCustomConnectorProxyWriter,
  System.Classes;

type

  TFilePart = (fpInterface, fpImplementation);

  TDSClientProxyWriterObjectiveCiOS = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  /// <summary> Returns properties specific to an ObjectiveC_iOS 4.2 implementation.</summary>
  TDSClientProxyWriterObjectiveCiOS42 = class(TDSClientProxyWriterObjectiveCiOS)
  public
    function Properties: TDSProxyWriterProperties; override;
  end;
  /// <summary> Returns properties specific to an ObjectiveC_iOS 7.1 implementation.</summary>
  TDSClientProxyWriterObjectiveCiOS71 = class(TDSClientProxyWriterObjectiveCiOS)
  public
    function Properties: TDSProxyWriterProperties; override;
  end;
  /// <summary> Returns properties specific to an ObjectiveC_iOS 8.1 implementation.</summary>
  TDSClientProxyWriterObjectiveCiOS81 = class(TDSClientProxyWriterObjectiveCiOS)
  public
    function Properties: TDSProxyWriterProperties; override;
  end;

  TDSCustomObjectiveCiOSProxyWriter = class abstract
    (TDSCustomConnectorProxyWriter)
  public
    procedure WriteProxy; override;
  protected
    FCurrFilePart: TFilePart;
    function GetCreateDataSetReader(const Param: TDSProxyParameter)
      : string; override;
    function GetCreateParamsReader(const Param: TDSProxyParameter)
      : string; override;
    procedure WriteInterface; override;
    procedure WriteObjectiveCLine(const Line: string); overload; virtual;
    procedure WriteObjectiveCLine; overload; virtual;
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

    function GetObjectiveCType(Param: TDSProxyParameter): String;
    function GetCastType(Param: TDSProxyParameter): String;
    function HasOnlyURLParams(const Method: TDSProxyMethod): Boolean;
    procedure WriteSetterForInputParams(const ProxyMethod: TDSProxyMethod);
    procedure WriteGetterForOutputParams(const ProxyMethod
      : TDSProxyMethod); overload;
    function GetParameterTypePrefix:string;override;
    function GetParameterDirectionPrefix:String;override;

  public
    property GenerateURLFunctions: Boolean read FGenerateURLFunctions
      write FGenerateURLFunctions;
  end;

  /// <summary> Writes a ObjectiveC_iOS proxy for a server application. </summary>
  TDSIOSProxyWriter = class(TDSCustomObjectiveCiOSProxyWriter)
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
  sObjectiveCiOS_RESTProxyWriter42 = 'Objective-C iOS 4.2 REST';
  sObjectiveCiOS_RESTProxyWriter71 = 'Objective-C iOS 7.1 REST';
  sObjectiveCiOS_RESTProxyWriter81 = 'Objective-C iOS 8.1 REST';

implementation

uses
  Data.DBXCommon,
  Datasnap.DSProxyUtils,
  System.SysUtils;

const
  sDSProxyObjectiveCiOSLanguage42 = 'objectivec_ios42';
  sDSProxyObjectiveCiOSLanguage71 = 'objectivec_ios71';
  sDSProxyObjectiveCiOSLanguage81 = 'objectivec_ios81';

function TDSCustomObjectiveCiOSProxyWriter.GetCastType
  (Param: TDSProxyParameter): String;
begin
  if IsDBXValueTypeParameter(Param) then
    Exit('(' + Param.TypeName + '*)');
  case Param.DataType of
    TDBXDataTypes.JsonValueType:
      begin
        if Param.TypeName = 'TJSONObject' then
          Exit('(TJSONObject *)');
        if Param.TypeName = 'TJSONArray' then
          Exit('(TJSONArray *)');
        if Param.TypeName = 'TJSONValue' then
          Exit('(TJSONValue *)');
        if Param.TypeName = 'TJSONTrue' then
          Exit('(TJSONTrue *)');
        if Param.TypeName = 'TJSONFalse' then
          Exit('(TJSONFalse *)');
        if Param.TypeName = 'TJSONNull' then
          Exit('(TJSONNull *)');
        Exit('(TJSONObject *)'); // it's a user defined type
      end;
    TDBXDataTypes.TableType:
      begin
        if Param.TypeName = 'TParams' then
          Exit('(TParams*)');
        if Param.TypeName = 'TDBXReader' then
          Exit('(TDBXReader*)');
        if Param.TypeName = 'TDataSet' then
          Exit('(TDataSet*)');
        Exit('UNKNOWN-' + Param.TypeName);
      end;
  else
    Result := '';
  end;
end;

function TDSCustomObjectiveCiOSProxyWriter.GetCreateDataSetReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

function TDSCustomObjectiveCiOSProxyWriter.GetCreateParamsReader
  (const Param: TDSProxyParameter): string;
begin
  Result := NullString;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteInterface;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  FCurrFilePart := fpInterface;
  WriteLine('#import <Foundation/Foundation.h>');
  WriteLine('#import "DSAdmin.h"');
  WriteLine('#import "DSRESTParameterMetaData.h"');
  WriteLine('#import "DBException.h"');
  WriteLine('#import "TParams.h"');
  WriteLine('#import "TDBXReader.h"');
  WriteLine('#import "TDataSet.h"');
  WriteLine('#import "TJSONNull.h"');
  WriteLine('#import "TJSONValue.h"');
  WriteLine('#import "TJSONObject.h"');
  WriteLine('#import "TJSONArray.h"');
  WriteLine('#import "TJSONTrue.h"');
  WriteLine('#import "TJSONFalse.h"');
  WriteLine('#import "DBXProtocols.h"');
  WriteLine('#import "TDBXAnsiStringValue.h"');
  WriteLine('#import "TDBXAnsiCharsValue.h"');
  WriteLine('#import "TDBXBooleanValue.h"');
  WriteLine('#import "TDBXDoubleValue.h"');
  WriteLine('#import "TDBXUInt8Value.h"');
  WriteLine('#import "TDBXInt8Value.h"');
  WriteLine('#import "TDBXUInt16Value.h"');
  WriteLine('#import "TDBXInt16Value.h"');
  WriteLine('#import "TDBXInt32Value.h"');
  WriteLine('#import "TDBXInt64Value.h"');
  WriteLine('#import "TDBXSingleValue.h"');
  WriteLine('#import "TDBXStringValue.h"');
  WriteLine('#import "TDBXTimeValue.h"');
  WriteLine('#import "TDBXTimeStampValue.h"');
  WriteLine('#import "TDBXWideStringValue.h"');
  WriteLine('#import "TDBXDateValue.h"');
  WriteLine('#import "TDBXReaderValue.h"');
  WriteLine('#import "TDBXStreamValue.h"');
  WriteLine('#import "TDBXBcdValue.h"');

  WriteLine;
  ProxyClassNameList := TDBXStringList.Create;
  try
    Item := FirstClass;
    while Item <> nil do
    begin
      if ExtendedIncludeClass(Item) then
        WriteClassInterface(Item, ProxyClassNameList);
      Item := Item.Next;
    end;
  finally
    FreeAndNil(ProxyClassNameList);
  end;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteObjectiveCLine
  (const Line: string);
begin
  inherited WriteLine(Line);
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteObjectiveCLine;
begin
  inherited WriteLine;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteClassInitImplementation
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

procedure TDSCustomObjectiveCiOSProxyWriter.WriteClassDeallocImplementation
  (const ProxyClass: TDSProxyClass);
begin
  WriteObjectiveCLine('-(void) dealloc {');
  indent;
  WriteObjectiveCLine('[super dealloc];');
  outdent;
  WriteObjectiveCLine('}');

end;


procedure TDSCustomObjectiveCiOSProxyWriter.WriteParamImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  MetadataParam: String;
  sname: String;
begin
  sname := ProxyClass.ProxyClassName + '_' + ProxyMethod.ProxyMethodName;

  WriteObjectiveCLine('-(id) get' + sname + ' {');
  indent;
  WriteObjectiveCLine('return  [NSArray arrayWithObjects:');

  Param := ProxyMethod.Parameters;

  while Param <> nil do
  begin
    indent;
    MetadataParam := '[DSRESTParameterMetaData parameterWithName: ';
    MetadataParam := MetadataParam + '@"' + Param.ParameterName + '"';
    MetadataParam := MetadataParam + ' withDirection:' +
      GetParameterDirection(Param.ParameterDirection);
    MetadataParam := MetadataParam + ' withDBXType:' +
      GetParameterType(Param.DataType);
    MetadataParam := MetadataParam + ' withTypeName:@"' + Param.TypeName + '"]';
    WriteObjectiveCLine(MetadataParam + ',');
    Param := Param.Next;
    outdent;
  end;
  WriteObjectiveCLine('nil];');
  outdent;
  WriteObjectiveCLine('}');
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteProxy;
begin
  inherited;

end;

function TDSCustomObjectiveCiOSProxyWriter.GetObjectiveCType
  (Param: TDSProxyParameter): String;
begin
  if Param = nil then
    Exit('void');

  if IsDBXValueTypeParameter(Param) then
    Exit(Param.TypeName + ' *');

  case Param.DataType of
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType:
      begin
        Exit('NSString *');
      end;
    TDBXDataTypes.DatetimeType:
      Exit('NSDate *');
    // TDBXDataTypes.BlobType:
    TDBXDataTypes.BinaryBlobType:
      Exit('NSData *');
    TDBXDataTypes.BooleanType:
      begin
        Exit('bool');
      end;
    TDBXDataTypes.Int8Type:
      begin
        Exit('int');
      end;
    TDBXDataTypes.UInt8Type:
      begin
        Exit('unsigned int');
      end;
    TDBXDataTypes.Int16Type:
      begin
        Exit('int');
      end;
    TDBXDataTypes.UInt16Type:
      begin
        Exit('unsigned int');
      end;
    TDBXDataTypes.Int32Type:
      begin
        Exit('long');
      end;
    TDBXDataTypes.UInt32Type:
      begin
        Exit('unsigned long');
      end;
    TDBXDataTypes.Int64Type:
      begin
        Exit('long long');
      end;
    TDBXDataTypes.UInt64Type:
      begin
        Exit('unsigned long long');
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
      Exit('long');
    TDBXDataTypes.DateType:
      begin
        Exit('long');
      end;
    TDBXDataTypes.JsonValueType:
      begin
        if (Param.TypeName = 'TJSONObject') or (Param.TypeName = 'TJSONArray')
          or (Param.TypeName = 'TJSONValue') or (Param.TypeName = 'TJSONTrue')
          or (Param.TypeName = 'TJSONFalse') or (Param.TypeName = 'TJSONNull')
        then
          Exit(Param.TypeName + ' *');
        Exit('TJSONObject *');
      end;
    TDBXDataTypes.BcdType:
      Exit('???' + Param.TypeName + '???');
    TDBXDataTypes.TimeStampType:
      Exit('???' + Param.TypeName + '???');
    TDBXDataTypes.TableType:
      Exit(Param.TypeName + '*');
  else
    raise EDSProxyException.Create('Unknown param type for ' + Param.TypeUnit +
      '.' + Param.TypeName);
  end;
end;


function TDSCustomObjectiveCiOSProxyWriter.GetParameterDirectionPrefix: String;
begin
  result:= '';
end;

function TDSCustomObjectiveCiOSProxyWriter.GetParameterTypePrefix: string;
begin
 result:= '';
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteImplementation;
var
  ProxyClassNameList: TDBXStringList;
  Item: TDSProxyClass;
begin
  FCurrFilePart := fpImplementation;
  WriteObjectiveCLine('#import "DSProxy.h"');
  WriteObjectiveCLine('');

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
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteClassImplementation
  (const ProxyClass: TDSProxyClass; const ProxyClassNameList: TDBXStringList);
var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
begin
  WriteObjectiveCLine('');
  WriteObjectiveCLine('@implementation ' + ProxyClass.ProxyClassName);
  indent;
  WriteClassInitImplementation(ProxyClass);
  WriteClassDeallocImplementation(ProxyClass);
  outdent;
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
  WriteObjectiveCLine('@end');

end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteClassInterface(const ProxyClass
  : TDSProxyClass; const ProxyClassNameList: TDBXStringList);

var
  ClassMethodString: TStringBuilder;
  Methods: TDSProxyMethod;
begin
  ClassMethodString := TStringBuilder.Create;
  try
    WriteObjectiveCLine('@interface ' + ProxyClass.ProxyClassName +
      ':DSAdmin{');
    indent;
    outdent;
    WriteObjectiveCLine('}');
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
    WriteObjectiveCLine('@end');

    WriteObjectiveCLine;
    ProxyClassNameList.Add(ClassMethodString.ToString);
  finally
    FreeAndNil(ClassMethodString);
  end;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteGetterForOutputParams
  (const ProxyMethod: TDSProxyMethod);
var
  index: Integer;
  CastTo: sTring;
begin
  index := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin

      if Assigned(Param) then // could be also a procedure without return value
      begin
        if IsOutputParameter(Param) then
        begin
          if (Param.DataType in [TDBXDataTypes.TableType,
            TDBXDataTypes.JsonValueType]) or (IsDBXValueTypeParameter(Param))
          then
            CastTo := GetCastType(Param);

          if Param.ParameterDirection = TDBXParameterDirections.ReturnParameter
          then
          begin
            WriteObjectiveCLine('');

            WriteObjectiveCLine('return ' + GetCastType(Param) +
              '[[[cmd.parameters objectAtIndex:' + IntToStr(index) +
              ']getValue]' + GetGetter(Param) + '];');
          end
          else
            WriteObjectiveCLine('*' + lowercase(Param.ParameterName) + ' =  ' +
              CastTo + ' [[[cmd.parameters objectAtIndex:' + IntToStr(index) +
              ']getValue]' + GetGetter(Param) + '];');

        end;
      end;
      inc(index);
    end);
end;

function TDSCustomObjectiveCiOSProxyWriter.HasOnlyURLParams
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

procedure TDSCustomObjectiveCiOSProxyWriter.WriteMethodComment(const ProxyClass
  : TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  Param: TDSProxyParameter;
  PName: string;
  TypeName: string;
  Direction: string;
  IsReturn: Boolean;
  AtTag: string;
begin
  WriteObjectiveCLine;
  Param := ProxyMethod.Parameters;
  if Param <> nil then
  begin
    WriteObjectiveCLine('/**');
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
      WriteObjectiveCLine(' * ' + AtTag + PName + Direction +
        ' - Type on server: ' + TypeName);
      Param := Param.Next;
    end;
    WriteObjectiveCLine(' */');
  end;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteMethodImplementation
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  sb: TStringBuilder;
  sPointer, sout: string;
  First: Boolean;
begin
  indent;
  First := True;
  sb := TStringBuilder.Create;
  try

    sb.Append('-(' + GetObjectiveCType(GetReturnParam(ProxyMethod)) + ') ' +
      ProxyMethod.ProxyMethodName);

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

            sPointer := '*';
          if Param.ParameterDirection = TDBXParameterDirections.OutParameter
          then
            sout := 'out ';
          if First then

            sb.Append(': (' + sout + GetObjectiveCType(Param) + sPointer + ') '
              + lowercase(Param.ParameterName) + ' ')
          else
            sb.Append(' with' + Param.ParameterName + ': (' + sout +
              GetObjectiveCType(Param) + sPointer + ') ' +
              lowercase(Param.ParameterName));
          First := False;
        end;
      end);
    WriteObjectiveCLine(sb.ToString + '{');
    // METHOD BODY
    /// ////////////////
    indent;
    WriteObjectiveCLine('');
    WriteObjectiveCLine
      ('DSRESTCommand * cmd = [[self Connection ] CreateCommand];');
    if HasOnlyURLParams(ProxyMethod) then
      WriteObjectiveCLine('cmd.RequestType =  GET;')
    else

      WriteObjectiveCLine('cmd.RequestType =  POST;');

    WriteObjectiveCLine('cmd.text= @"' + ProxyClass.ProxyClassName + '.' +
      ProxyMethod.ProxyMethodName + '";');
    WriteObjectiveCLine('[cmd  prepare:[self get' + ProxyClass.ProxyClassName +
      '_' + ProxyMethod.ProxyMethodName + ']];');
    WriteObjectiveCLine('');

    WriteSetterForInputParams(ProxyMethod);
    WriteObjectiveCLine('');

    WriteObjectiveCLine('[Connection execute: cmd];');

    WriteGetterForOutputParams(ProxyMethod);
    outdent;
    // END METHOD BODY
    /// ////////////////
    WriteObjectiveCLine('}');
  finally
    sb.Free;
  end;
  outdent;
end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteMethodInterface
  (const ProxyClass: TDSProxyClass; const ProxyMethod: TDSProxyMethod);
var
  First: Boolean;
  sb: TStringBuilder;
  sPointer, sout: string;
begin
  indent;
  First := True;
  sb := TStringBuilder.Create;
  try

    sb.Append('-(' + GetObjectiveCType(GetReturnParam(ProxyMethod)) + ') ' +
      ProxyMethod.ProxyMethodName);

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

            sPointer := '*';
          if Param.ParameterDirection = TDBXParameterDirections.OutParameter
          then
            sout := 'out ';
          if First then

            sb.Append(': (' + sout + GetObjectiveCType(Param) + sPointer + ') '
              + lowercase(Param.ParameterName) + ' ')
          else
            sb.Append(' with' + Param.ParameterName + ': (' + sout +
              GetObjectiveCType(Param) + sPointer + ') ' +
              lowercase(Param.ParameterName));
          First := False;
        end;
      end);
    WriteObjectiveCLine(sb.ToString + ';');
  finally
    sb.Free;
  end;
  outdent;

end;

procedure TDSCustomObjectiveCiOSProxyWriter.WriteSetterForInputParams
  (const ProxyMethod: TDSProxyMethod);
var
  ParIndex: Integer;
  sPointer: string;
begin
  ParIndex := 0;
  ForEachParameter(ProxyMethod,
    procedure(Param: TDSProxyParameter)
    begin
      if IsInputParameter(Param) then
      begin
        sPointer := '';
        if Param.ParameterDirection in [TDBXParameterDirections.ReturnParameter,
          TDBXParameterDirections.OutParameter,
          TDBXParameterDirections.InOutParameter] then
          sPointer := '*';
        if IsDBXValueTypeParameter(Param) then
        begin
          WriteObjectiveCLine('if (' + sPointer +
            lowercase(Param.ParameterName) + ') {');
          indent;
          WriteObjectiveCLine('[[[cmd.parameters objectAtIndex:' +
            IntToStr(ParIndex) + ']getValue] SetAsDBXValue:' + sPointer +
            lowercase(Param.ParameterName) + '];');
          outdent;
          WriteObjectiveCLine('} else {');
          indent;
          WriteObjectiveCLine('[[[cmd.parameters objectAtIndex:' +
            IntToStr(ParIndex) + ']getValue] SetTDBXNull:@"' +
            Param.TypeName + '"];');
          outdent;
          WriteObjectiveCLine('}');
          inc(ParIndex);
        end
        else
        begin
          WriteObjectiveCLine('[[[cmd.parameters objectAtIndex:' +
            IntToStr(ParIndex) + ']getValue]' + GetSetter(Param) + ':' +
            sPointer + lowercase(Param.ParameterName) + '];');
          inc(ParIndex);
        end;
      end;

    end);
end;

{ TDSIOSProxyWriter }
procedure TDSIOSProxyWriter.DerivedWrite(const Line: string);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else if FCurrFilePart = fpImplementation then

    ProxyWriters[sImplementation].Write(Line)
  else if FCurrFilePart = fpInterface then
    ProxyWriters[sInterface].Write(Line)
end;

procedure TDSIOSProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else if FCurrFilePart = fpImplementation then

    ProxyWriters[sImplementation].WriteLine

  else if FCurrFilePart = fpInterface then
    ProxyWriters[sInterface].WriteLine;
end;

destructor TDSIOSProxyWriter.Destroy;
begin
  FreeAndNil(FStreamWriter);
  inherited;
end;


function TDSClientProxyWriterObjectiveCiOS.CreateProxyWriter
  : TDSCustomProxyWriter;
begin
  Result := TDSIOSProxyWriter.Create();
  TDSIOSProxyWriter(Result).GenerateURLFunctions := True;
end;

function TDSClientProxyWriterObjectiveCiOS.FileDescriptions
  : TDSProxyFileDescriptions;
begin
  SetLength(Result, 2);
  Result[0].ID := sInterface; // do not localize
  Result[0].DefaultFileExt := '.h';
  Result[1].ID := sImplementation; // do not localize
  Result[1].DefaultFileExt := '.m';

end;

function TDSClientProxyWriterObjectiveCiOS.Properties: TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyObjectiveCiOS';
  Result.DefaultExcludeClasses := sDSMetadataClassName + ',' + sDSAdminClassName; // do not localize
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

{ TDSClientProxyWriterObjectiveCiOS42 }

function TDSClientProxyWriterObjectiveCiOS42.Properties: TDSProxyWriterProperties;
begin
  inherited;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := ''; // com\embarcadero\objectivec_ios'; // do not localize
  Result.Language := sDSProxyObjectiveCiOSLanguage42;
end;

{ TDSClientProxyWriterObjectiveCiOS71 }

function TDSClientProxyWriterObjectiveCiOS71.Properties: TDSProxyWriterProperties;
begin
  inherited;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := ''; // com\embarcadero\objectivec_ios'; // do not localize
  Result.Language := sDSProxyObjectiveCiOSLanguage71;
end;

{ TDSClientProxyWriterObjectiveCiOS81 }

function TDSClientProxyWriterObjectiveCiOS81.Properties: TDSProxyWriterProperties;
begin
  inherited;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := ''; // com\embarcadero\objectivec_ios'; // do not localize
  Result.Language := sDSProxyObjectiveCiOSLanguage81;
end;

initialization

TDSProxyWriterFactory.RegisterWriter(sObjectiveCiOS_RESTProxyWriter42,
  TDSClientProxyWriterObjectiveCiOS42);
TDSProxyWriterFactory.RegisterWriter(sObjectiveCiOS_RESTProxyWriter71,
  TDSClientProxyWriterObjectiveCiOS71);
TDSProxyWriterFactory.RegisterWriter(sObjectiveCiOS_RESTProxyWriter81,
  TDSClientProxyWriterObjectiveCiOS81);

finalization

TDSProxyWriterFactory.UnregisterWriter(sObjectiveCiOS_RESTProxyWriter42);
TDSProxyWriterFactory.UnregisterWriter(sObjectiveCiOS_RESTProxyWriter71);
TDSProxyWriterFactory.UnregisterWriter(sObjectiveCiOS_RESTProxyWriter81);
end.
