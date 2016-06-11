{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{       Web services description language (WSDL)        }
{       generation from RTTI                            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Soap.WebServExp;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo,
  Soap.IntfInfo, Soap.InvokeRegistry, Soap.WSDLBind, Soap.WSDLIntf,
  Xml.XMLIntf, Xml.XmlSchema;

type
  ArgumentType = (argIn, argOut, argInOut, argReturn);
  MessageType  = (mtInput, mtOutput, mtHeaderInput, mtHeaderOutput,
                  mtFault);

  TSchemaType = record
    TypeName: InvString;
    NameSpace: InvString;
    TypeInfo: PTypeinfo;
    NSPrefix: InvString;
    XSGenerated: Boolean;
  end;

  TSchemaTypeArray = array of TSchemaType;

  IWebServExp = interface
  ['{77099743-C063-4174-BA64-53847693FB1A}']
    function  FindOrAddSchema(const ATypeInfo: PTypeinfo; const TnsURI: string): Boolean;
    procedure GenerateXMLSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo, ParentInfo: PTypeinfo; Namespace: InvString);
  end;

  TBeforePublishingTypesEvent = procedure(const WebServ: IWebServExp) of object;
  TPublishingTypeEvent = procedure(const WebServ: IWebServExp; const SchemaDef: IXMLSchemaDef;
                                   const ATypeInfo: PTypeinfo; Namespace: InvString) of object;
  TAfterPublishingWSDLEvent = procedure(const WSDLDoc: IWSDLDocument) of object;

{$M+}
  TWebServExp = class;
{$M-}

  IWebServExpAccess = interface
  ['{1BB5EB76-AC77-47EE-BCF2-99C7B54386C3}']
    function GetWebServExp: TWebServExp;
  end;

{$M+}
  TWebServExp = class(TInterfacedObject, IWebServExp, IWebServExpAccess)
  private
    Definition: IDefinition;
    ComplexTypeList: TStringList;
    bHasComplexTypes: Boolean;
    FServiceAddress: InvString;
    FBindingType: TWebServiceBindingType;
    FWSDLElements: TWSDLElements;
    FImportNames: TDOMStrings;
    FImportLocation: TDOMStrings;
    FArrayAsComplexContent: Boolean;
    SchemaArray: TSchemaTypeArray;
    FTargetNameSpace: InvString;

    FOnBeforePublishingTypes: TBeforePublishingTypesEvent;
    FOnPublishingType: TPublishingTypeEvent;
    FOnAfterPublishingWSDL: TAfterPublishingWSDLEvent;

    procedure GenerateWSDL(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument;  PortNames, Locations: array of InvString);
    procedure GenerateNestedArraySchema(SchemaDef: IXMLSchemaDef; ComplexType: IXMLComplexTypeDef; const ATypeInfo: PTypeinfo; var Dimension: Integer; Namespace: InvString);
    procedure AddImports(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
    procedure AddTypes(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
    function  GetMessageName(const MethName: InvString; MethIndex: Integer; MsgType: MessageType; const ASuffix: InvString = ''): InvString;
    function  AddMessage(const Messages: IMessages; const Name: InvString): IMessage;
    procedure AddMessages(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
    procedure AddHeaders(const IntfMD: TIntfMetaData; MethIndex: Integer;
                         const Messages: IMessages; const MethodExtName: InvString);
    procedure AddFaultMessages(const IntfMD: TIntfMetaData; MethIndex: Integer;
                         const Messages: IMessages; const MethodExtName: InvString;
                         WSDLDoc: IWSDLDocument);
    procedure AddPortTypes(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
    procedure AddBinding(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
    procedure AddServices(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument; PortNames: array of InvString; Locations: array of InvString);
    function  GetXMLSchemaType(const ParamTypeInfo: PTypeInfo): string;
    function  GetXMLSchemaTypeName(const ParamTypeInfo: PTypeInfo): InvString;
    function  IsComplexType(const ParamType: TTypeKind ):Boolean; overload;
    function  IsComplexType(const ParamTypeInfo: PTypeInfo): Boolean; overload;
    procedure SetBindingType(const Value: TWebServiceBindingType);
    procedure SetServiceAddress(const Value: InvString);
    function  GetImportNamespace(const Index: Integer): InvString;
    procedure SetImportNamespace(const Index: Integer; const Value: InvString);
    function  GetImportLocation(const Index: Integer): InvString;
    procedure SetImportLocation(const Index: Integer; const Value: InvString);
    procedure SetArrayType(const Value: Boolean);
    function  GetPrefixForURI(SchemaDef: IXMLSchemaDef; const URI: InvString): InvString; overload;
    function  GetPrefixForURI(Def: IDefinition; const URI: InvString): InvString; overload;
    function  GetPrefixForTypeInfo(const ATypeInfo: PTypeinfo): InvString; overload;
    function  AddNamespaceURI(RootNode: IXMLNode; const URI: InvString): InvString;
    function  GetNodeNameForURI(SchemaDef: IXMLSchemaDef; const URI: InvString): InvString;
    procedure GenerateArraySchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString);
    procedure GenerateEnumSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString);
    procedure GenerateAliasSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString;
                                  const ABaseTypeInfo: PTypeInfo = nil);
    procedure GenerateClassSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo, ParentInfo: PTypeinfo; const Namespace: InvString);
    procedure GenerateDerivedClassSchema(SchemaDef: IXMLSchemaDef; const ParentTypeInfo: PTypeinfo; const Namespace: InvString);
    procedure GetAllSchemaTypes(const IntfMD: TIntfMetaData);
    procedure GetSchemaTypes(const ATypeInfo, ParentInfo: PTypeinfo);
    function  FindOrAddSchema(const ATypeInfo: PTypeinfo; const TnsURI: string): Boolean;
    procedure GetClassSchema(const ATypeInfo, ParentInfo: PTypeinfo);
    procedure GetDerivedClassSchema(const ParentTypeInfo: PTypeinfo);
    function  IsSchemaGenerated(const ATypeInfo: PTypeinfo; const TnsURI: InvString): Boolean;
    procedure GetArraySchema(const ATypeInfo: PTypeinfo);

  public
    constructor Create;
    destructor Destroy; override;
    procedure  GetWSDLForInterface(const IntfTypeInfo: Pointer; WSDLDoc: IWSDLDocument; PortNames, Locations: array of InvString);
    procedure  GenerateXMLSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo, ParentInfo: PTypeinfo; Namespace: InvString);

    function GetWebServExp: TWebServExp;

    property ImportNames [const Index: Integer]: InvString read GetImportNamespace write SetImportNamespace;
    property ImportLocations[const Index: Integer]: InvString read GetImportLocation write SetImportLocation;
    property TargetNameSpace: InvString read FTargetNameSpace write FTargetNameSpace;

  published
    property ArrayAsComplexContent: Boolean read FArrayAsComplexContent write SetArrayType;
    property BindingType: TWebServiceBindingType read FBindingType write SetBindingType;
    property ServiceAddress: InvString read FServiceAddress write SetServiceAddress;
    property WSDLElements: TWSDLElements read FWSDLElements write FWSDLElements default [weServiceIntf];

    property OnBeforePublishingTypes: TBeforePublishingTypesEvent read FOnBeforePublishingTypes write FOnBeforePublishingTypes;
    property OnPublishingType: TPublishingTypeEvent read FOnPublishingType write FOnPublishingType;
    property OnAfterPublishingWSDL: TAfterPublishingWSDLEvent read FOnAfterPublishingWSDL write FOnAfterPublishingWSDL;
  end;
{$M-}

{ Returns the BindingType of a particular Method. Input species whether the
  request/call or response/return since a method may have one input binding
  and another binding for output }
function GetBindingType(const MethEntry: TIntfMethEntry; Input: Boolean): TWebServiceBindingType; overload;

{ Returns the underlying of an alias of the specified TypeKind, if any }
function GetAliasBaseTypeInfo(const ParamType: TTypeKind): PTypeInfo;

function IsBaseClassTypeInfo(const ATypeInfo: PTypeInfo): Boolean;

implementation

uses
  Soap.SOAPConst, Soap.XSBuiltIns, Xml.XMLDoc, Xml.xmldom, Xml.XMLSchemaTags;

{$IFDEF POSIX}
{$IFNDEF OPENDOM}
{$DEFINE OPENDOM}
{$ENDIF}
{$ENDIF}
{$IFDEF MSWINDOWS}
//{$DEFINE OPENDOM}
{$ENDIF}

{$IFDEF NEXTGEN}
function TypeInfoName(const b: array of Byte): string;
begin
  Result := UTF8ToString(b);
end;
{$ELSE !NEXTGEN}
function TypeInfoName(const s: ShortString): string; inline;
begin
{$IFDEF UNICODE}
  Result := UTF8ToString(s);
{$ELSE}
  Result := s;
{$ENDIF}
end;
{$ENDIF NEXTGEN}

function IsBaseClassTypeInfo(const ATypeInfo: PTypeInfo): Boolean;
begin
  Result := (ATypeInfo = TypeInfo(TObject)) or
            (ATypeInfo = TypeInfo(TRemotable)) or
            (ATypeInfo = TypeInfo(TSOAPHeader)) or
            (ATypeInfo = TypeInfo(ERemotableException));
end;

{ WebServExp Implementation }
constructor TWebServExp.Create;
begin
  ComplexTypeList := TStringList.Create;
  FWSDLElements := [weServiceIntf];
  FImportNames := TDOMStrings.Create;
  FImportLocation := TDOMStrings.Create;
  FArrayAsComplexContent := True;
end;

destructor TWebServExp.Destroy;
begin
  ComplexTypeList.Free;
  FImportNames.Free;
  FImportLocation.Free;
  inherited Destroy;
end;

procedure TWebServExp.SetArrayType(const Value: Boolean);
begin
  FArrayAsComplexContent := Value;
end;

{ Set default binding type }
procedure TWebServExp.SetBindingType(const Value: TWebServiceBindingType);
begin
  FBindingType := Value;
end;

procedure TWebServExp.SetServiceAddress(const Value: InvString);
begin
  FServiceAddress := Value;
end;

function  TWebServExp.GetImportNamespace(const Index: Integer): InvString;
begin
  if FImportNames.Count > Index  then
    Result := FImportNames.Strings[Index]
  else
    Result := '';
end;

function  TWebServExp.GetImportLocation(const Index: Integer): InvString;
begin
  if FImportLocation.Count > Index  then
    Result := FImportLocation.Strings[Index]
  else
    Result := '';
end;

procedure TWebServExp.SetImportNamespace(const Index: Integer; const Value: InvString);
begin
  FImportNames.Insert(Index, Value);
end;

procedure TWebServExp.SetImportLocation(const Index: Integer; const Value: InvString);
begin
  FImportLocation.Insert(Index, Value);
end;

procedure TWebServExp.GetWSDLForInterface(const IntfTypeInfo: Pointer; WSDLDoc: IWSDLDocument; PortNames,  Locations: array of InvString);
var
  IntfMD: TIntfMetaData;
begin
  bHasComplexTypes := False;
  GetIntfMetaData(IntfTypeInfo, IntfMD);
  GenerateWSDL(IntfMD, WSDLDoc, PortNames,  Locations);
end;


procedure TWebServExp.GenerateWSDL(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument; PortNames, Locations: array of InvString);
var
  Encoding: InvString;
begin
  if IntfMD.Name <> '' then
  begin
    { Add WSDL:Definitions and its attributes }
    Definition := WSDLDoc.Definition;
    Definition.Attributes[Sname] := IntfMD.Name+SService;
    if (TargetNamespace <> '') then
    begin
      Definition.Attributes[Stns]  := TargetNamespace;
{$IFDEF OPENDOM}
      Definition.DeclareNameSpace('tns', TargetNameSpace);
{$ELSE}
      Definition.Attributes['xmlns:tns'] := TargetNamespace;
{$ENDIF}
    end;
{$IFDEF OPENDOM}
    Definition.DeclareNameSpace('soap', Soapns);                { do not localize }
    Definition.DeclareNameSpace('soapenc', SSoap11EncodingS5);  { do not localize }
    Definition.DeclareNamespace('mime', SWSDLMIMENamespace);    { do not localize }
{$ELSE}
    Definition.Attributes['xmlns:soap'] := Soapns;
    Definition.Attributes['xmlns:soapenc'] := SSoap11EncodingS5;
    Definition.Attributes['xmlns:mime'] := SWSDLMIMENamespace;
{$ENDIF}

    { Add Encoding }
    if WSDLDoc.Encoding = '' then
    begin
      Encoding := InvRegistry.GetWSDLEncoding(IntfMD.Info, '', IntfMD.Name);
      if Encoding <> '' then
        WSDLDoc.Encoding := Encoding
      else
        WSDLDoc.Encoding := 'utf-8';
    end;

     { Set the Namespace prefix }
    (WSDLDoc as IXMLDocumentAccess).DocumentObject.NSPrefixBase := SNsPrefix;

     { Add WSDL Types }
    if (WeTypes in FWSDLElements) or (WeServiceIntf in FWSDLElements) then
      AddTypes(IntfMD, WSDLDoc);
     { Add Imports }
    if (WeImport in FWSDLElements) or (WeServiceImpl in FWSDLElements) then
      if (FImportNames.Count = FImportLocation.Count) then
        AddImports(IntfMD, WSDLDoc);
    { Add WSDL Message and its parts }
    if ((weMessage in FWSDLElements) or (weServiceIntf in FWSDLElements) ) then
      AddMessages(IntfMD, WSDLDoc);
    { Add WSDL PortType and its Operations }
    if ((wePortType in FWSDLElements) or (weServiceIntf in FWSDLElements) ) then
      AddPortTypes(IntfMD, WSDLDoc);
    { Add WSDL Binding for operations }
    if (WeBinding in FWSDLElements) or (weServiceIntf in FWSDLElements) then
      AddBinding(IntfMD, WSDLDoc);
    { Add WSDL Service and its port }
    if (WeService in FWSDLElements) or (WeServiceImpl in FWSDLElements) then
      AddServices(IntfMD, WSDLDoc, PortNames, Locations);
    { Give user a chance to customize WSDL }
    if Assigned(FOnAfterPublishingWSDL) then
      FOnAfterPublishingWSDL(WSDLDoc);
  end;
end;

procedure TWebServExp.AddImports(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
var
  Imports: IImports;
  Index: Integer;
begin
  Imports := WSDLDoc.Definition.Imports;
  for Index := 0 to FImportNames.Count -1 do
    Imports.Add(FImportNames.Strings[Index], FImportLocation.Strings[Index]);
end;

function HeaderUsedWithMethod(HeaderItem: IntfHeaderItem;
         MethodExtName: InvString; MType: EHeaderMethodType): Boolean;
var
  Methods: TStrings;
  I: Integer;
begin
  Result := HeaderItem.MethodNames = '';
  if not Result then
  begin
    Methods := TStringList.Create;
    try
      Methods.CommaText := HeaderItem.MethodNames;
      for I := 0 to Methods.Count -1 do
      begin
        if SameText(Methods[I], MethodExtName) then
        begin
          if (not Assigned(HeaderItem.MethodTypes)) or
             (HeaderItem.MethodTypes[I] in [hmtAll, MType]) then
            Result := True;
          break;
        end;
      end;
    finally
      Methods.Free;
    end;
  end;  
end;

function ExceptionUsedWithMethod(ExceptItem: IntfExceptionItem; MethodExtName: InvString): Boolean;
var
  Methods: TStrings;
  I: Integer;
begin
  Result := ExceptItem.MethodNames = '';
  if not Result then
  begin
    Methods := TStringList.Create;
    try
      Methods.CommaText := ExceptItem.MethodNames;
      for I := 0 to Methods.Count -1 do
      begin
        if SameText(Methods[I], MethodExtName) then
        begin
          Result := True;
          break;
        end;
      end;
    finally
      Methods.Free;
    end;
  end;
end;

function TWebServExp.GetMessageName(const MethName: InvString; MethIndex: Integer;
                                    MsgType: MessageType; const ASuffix: InvString): InvString;
var
  Prefix: InvString;
begin
  Prefix := IntToStr(MethIndex);
  case MsgType of
    mtInput:        Result := MethName + Prefix + SRequest;
    mtOutput:       Result := MethName + Prefix + SResponse;
    mtHeaderInput:  Result := MethName + Prefix + SHeader + SRequest;
    mtHeaderOutput: Result := MethName + Prefix + SHeader + SResponse;
    mtFault:        Result := MethName + Prefix + SFault;
  end;
  { Use suffix for Operations with multiple faults since
    the fault message can have only a single part. }
  Result := Result + ASuffix;
end;

function TWebServExp.AddMessage(const Messages: IMessages; const Name: InvString): IMessage;
begin
  Result := Messages.Add(Name);
end;

procedure TWebServExp.AddFaultMessages(const IntfMD: TIntfMetaData; MethIndex: Integer;
                                       const Messages: IMessages; const MethodExtName: InvString;
                                       WSDLDoc: IWSDLDocument);
var
  I: Integer;
  TnsPre: InvString;
  ExceptItems: TExceptionItemArray;
  NewMessage: IMessage;
  Parts: IParts;
  MessageName: InvString;
begin
  TnsPre := GetPrefixForURI(WSDLDoc.Definition, TargetNameSpace);
  ExceptItems := InvRegistry.GetExceptionInfoForInterface(IntfMD.Info);

  { Publish fault messages }
  for I := 0 to Length(ExceptItems) -1 do
  begin
    if ExceptionUsedWithMethod(ExceptItems[I], MethodExtName) then
    begin
      MessageName := GetMessageName(MethodExtName, MethIndex, mtFault, IntToStr(I));
      NewMessage := AddMessage(Messages, MessageName);
      Parts := NewMessage.Parts;
      Parts.Add(ExceptItems[I].ClassType.ClassName,  '',
                           GetXMLSchemaType(ExceptItems[I].ClassType.ClassInfo));
    end;
  end;
end;

procedure TWebServExp.AddHeaders(const IntfMD: TIntfMetaData; MethIndex: Integer;
                                 const Messages: IMessages; const MethodExtName: InvString);
var
  NewMessage: IMessage;
  Parts: IParts;
  HeaderItems: THeaderItemArray;
  I: Integer;
  HeaderName, TypeName: InvString;
  AClass: TClass;
begin
  HeaderItems := InvRegistry.GetRequestHeaderInfoForInterface(IntfMD.Info);
  NewMessage := nil;
  for I := 0 to Length(HeaderItems)-1 do
  begin
    if HeaderUsedWithMethod(HeaderItems[I], MethodExtName, hmtRequest) then
    begin
      if not Assigned(NewMessage) then
        NewMessage := AddMessage(Messages, GetMessageName(MethodExtName, MethIndex, mtHeaderInput));
      AClass := HeaderItems[I].ClassType;
      HeaderName := InvRegistry.GetHeaderName(IntfMD.Info, AClass);
      TypeName := GetXMLSchemaType(AClass.ClassInfo);
      Parts := NewMessage.Parts;
      Parts.Add(HeaderName, '', TypeName);
    end;
  end;
  HeaderItems := InvRegistry.GetResponseHeaderInfoForInterface(IntfMD.Info);
  NewMessage := nil;
  for I := 0 to Length(HeaderItems) -1 do
  begin
    if HeaderUsedWithMethod(HeaderItems[I], MethodExtName, hmtResponse) then
    begin
      if not Assigned(NewMessage) then
        NewMessage := AddMessage(Messages, GetMessageName(MethodExtName, MethIndex, mtHeaderOutput));
      AClass := HeaderItems[I].ClassType;
      HeaderName := InvRegistry.GetHeaderName(IntfMD.Info, AClass);
      TypeName := GetXMLSchemaType(AClass.ClassInfo);
      Parts := NewMessage.Parts;
      Parts.Add(HeaderName, '', TypeName);
    end;
  end;
end;

procedure TWebServExp.AddMessages(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
var
  IntfMethArray: TIntfMethEntryArray;
  ParamArray: TIntfParamEntryArray;
  Methods, Params, NoOfMethods, NoOfParams: Integer;
  ParamType: string;
  Messages: IMessages;
  NewMessage: IMessage;
  Parts: IParts;
  MethodExtName, ParamExtName: InvString;
begin
  IntfMethArray := nil;
  ParamArray    := nil;
  IntfMethArray := IntfMD.MDA;
  NoOfMethods   := Length(IntfMethArray);

  { Add WSDL Message and its parts }
  Messages := WSDLDoc.Definition.Messages;

  for Methods := 0 to NoOfMethods -1 do
  begin
    ParamArray := IntfMD.MDA[Methods].Params;
    NoOfParams := Length(ParamArray);

    { Add InOut parts }
    { Note: We always have a Message for the request - irrespective of in parameters }
    MethodExtName := InvRegistry.GetMethExternalName(IntfMD.Info, IntfMD.MDA[Methods].Name);
    NewMessage := AddMessage(Messages, GetMessageName(MethodExtName, Methods, mtInput));
    Parts := NewMessage.Parts;
    for Params := 0 to NoOfParams-2 do  { Skip Self/this }
    begin
      { Note: No pfOut implies [in] parameter }
      if not (pfOut in ParamArray[Params].Flags) then
      begin
        ParamType := GetXMLSchemaType(ParamArray[Params].Info);
        ParamExtName := InvRegistry.GetParamExternalName(IntfMD.Info, MethodExtName, ParamArray[Params].Name);
        Parts.Add(ParamExtName,'',ParamType);
      end;
    end;

    { Add Out parts }
    { Note: We always have a Message for the response - irrespective of return|out }
    NewMessage := AddMessage(Messages, GetMessageName(MethodExtName, Methods, mtOutput));
    Parts := NewMessage.Parts;
    for Params := 0 to NoOfParams-2 do  { Skip Self/this }
    begin
      { pfOut or pfVar implies [out] parameter }
      if ( (pfOut in ParamArray[Params].Flags) or (pfVar in ParamArray[Params].Flags) ) then
      begin
        ParamType := GetXMLSchemaType(ParamArray[Params].Info);
        ParamExtName := InvRegistry.GetParamExternalName(IntfMD.Info, MethodExtName, ParamArray[Params].Name);
        Parts.Add(ParamExtName,'',ParamType);
      end;
    end;

    { For Functions create a response }
    if IntfMD.MDA[Methods].ResultInfo <> nil then
    begin
      ParamType := GetXMLSchemaType(IntfMD.MDA[Methods].ResultInfo);
      Parts.Add(SReturn, '', ParamType);
    end;

    { Add headers - if any have been registered }
    AddHeaders(IntfMD, Methods, Messages, MethodExtName);
    { And faults }
    AddFaultMessages(IntfMD, Methods, Messages, MethodExtName, WSDLDoc);
  end;
end;

procedure TWebServExp.AddPortTypes(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);

  function AddOperation(const Operations: IOperations; const MethName, Request, Response: InvString): IOperation;
  begin
    Result := Operations.Add(MethName, Request, '', Response);
  end;

var
  IntfMethArray: TIntfMethEntryArray;
  Methods, I, NoOfMethods: Integer;
  PortTypes: IPortTypes;
  PortType: IPortType;
  Operations: IOperations;
  Operation: IOperation;
  PortExtName, MethodExtName: InvString;
  TnsPre: InvString;
  ExceptItems: TExceptionItemArray;
  MessageName: InvString;
begin
  { Add WSDL PortType and its Operations }
  IntfMethArray := nil;
  IntfMethArray := IntfMD.MDA;
  NoOfMethods   := Length(IntfMethArray);

  PortTypes := WSDLDoc.Definition.PortTypes;
  PortExtName := InvRegistry.GetInterfaceExternalName(IntfMD.Info,'',IntfMD.Name);
  PortType := PortTypes.Add(PortExtName);
  TnsPre := GetPrefixForURI(WSDLDoc.Definition, TargetNameSpace);
  ExceptItems := InvRegistry.GetExceptionInfoForInterface(IntfMD.Info);

  { Operations }
  for Methods := 0 to NoOfMethods -1 do
  begin
    Operations := PortType.Operations;
    MethodExtName := InvRegistry.GetMethExternalName(IntfMD.Info, IntfMD.MDA[Methods].Name);
    Operation := AddOperation(Operations, MethodExtName,
                              TnsPre+':'+GetMessageName(MethodExtName, Methods, mtInput),
                              TnsPre+':'+GetMessageName(MethodExtName, Methods, mtOutput));

    { Add operation <fault> node }
    for I := 0 to Length(ExceptItems) -1 do
    begin
      if ExceptionUsedWithMethod(ExceptItems[I], MethodExtName) then
      begin
        MessageName := GetMessageName(MethodExtName, Methods, mtFault, IntToStr(I));
        Operation.Faults.Add(ExceptItems[I].ClassType.ClassName,
                             TnsPre+ ':' + MessageName);
      end;
    end;
  end;
end;

function IsInputParam(const Param: TIntfParamEntry): Boolean;
begin
  { To be consistent with AddMessages we'll assume no 'pfOut' makes
    it an in parameter.
    NOTE: This function does *NOT* mean it's not an Out parameter }
  Result := not (pfOut in Param.Flags);
end;

function IsOutputParam(const Param: TIntfParamEntry): Boolean;
begin
  Result := (pfOut in Param.Flags) or (pfVar in Param.Flags);
end;

function GetBindingType(const ParamInfo: PTypeInfo): TWebServiceBindingType; overload;
var
  ClsType: TClass;
begin
  { Default to btSOAP }
  Result := btSoap;

  if ParamInfo = nil then
    Exit;

  { Here we attempt to detect if it's an attachment. Attachments parameters
    can be TSOAPAttachment or TSOAPAttachment-derived.
    Arrays of the latter or classes that contain members of type
    TSOAPAttachment(derived) are *NOT* considered attachment. The latter
    because WSDL does not provide for a way to describe a part that's
    non-Multipart and yet contains Multipart members. The former because
    every SOAP implementation seems to ignore the array portion and maps
    the parameter to a plain attachment }
  if ParamInfo.Kind = tkClass then
  begin
    ClsType := GetTypeData(ParamInfo).ClassType;
    if ClsType.InheritsFrom(TSOAPAttachment) then
    begin
      Result := btMIME;
      Exit;
    end;
  end;
end;

function GetBindingType(const Param: TIntfParamEntry): TWebServiceBindingType; overload;
begin
  Result := GetBindingType(Param.Info);
end;

function GetBindingType(const MethEntry: TIntfMethEntry;
                        Input: Boolean): TWebServiceBindingType; overload;
var
  I: Integer;
  ParamArray: TIntfParamEntryArray;
begin
  { Default to SOAP }
  Result := btSoap;
  ParamArray := MethEntry.Params;

  if (Input) then
  begin
    { Skip this/Self }
    for I := 0 to Length(ParamArray)-2 do
    begin
      if (IsInputParam(ParamArray[I])) then
      begin
        Result := GetBindingType(ParamArray[I]);
        { End as soon as we get anything other than SOAP binding }
        if Result <> btSoap then
          Exit;
      end;
    end;
  end else
  begin
    { Skip this/Self }
    for I := 0 to Length(ParamArray)-2 do
    begin
      if (IsOutputParam(ParamArray[I])) then
      begin
        Result := GetBindingType(ParamArray[I]);
        { End as soon as we get anything other than SOAP binding }
        if Result <> btSoap then
          Exit;
      end;
    end;
    { For output, we also check the return type, if any }
    Result := GetBindingType(MethEntry.ResultInfo);
  end;
end;

procedure TWebServExp.AddBinding(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);

var
  NewNode, SoapBodyNode, SoapHeaderNode, PartNode, ContentNode: IXMLNode;
  HeaderItems: THeaderItemArray;
  TnsPre: InvString;

  function GetOverloadDigit( const MethNames: TDOMStrings; Name: InvString): string;
  var
    I, Count: Integer;
  begin
    Result := '';
    Count := 0;
    for I := 0 to MethNames.Count -1 do
      if SameText(MethNames[I], Name) then
        Inc(Count);
    MethNames.Add(Name);
    if Count > 0 then
      Result := IntToStr(Count);
  end;

  procedure SetupSoapBodyNode(const SBodyNode: IXMLNode);
  begin
    { SBodyNode.Attributes[SParts] := ''; }
    SBodyNode.Attributes[SUse] := SSoapBodyUseEncoded;
    SBodyNode.Attributes[SEncodingStyle] := SSoap11EncodingS5;
    SBodyNode.Attributes[SNameSpace] := InvRegistry.GetNamespaceByGUID(IntfMD.IID);
  end;

  procedure SetupSoapHeaderNode(const HeaderNode: IXMLNode;
                                const MsgName, PartName, Namespace: InvString;
                                Required: Boolean);
  const
    Prefix = 'n1';
  begin
    if Required then
    begin
      HeaderNode.DeclareNameSpace(Prefix, Wsdlns);
      HeaderNode.SetAttribute(MakeNodeName(Prefix, SRequired), STrue);
    end;
    HeaderNode.Attributes[SUse] := SSoapBodyUseEncoded;
    HeaderNode.Attributes[SMessage] := MsgName;
    HeaderNode.Attributes[SPart] := PartName;
    HeaderNode.Attributes[SEncodingStyle] := SSoap11EncodingS5;
    HeaderNode.Attributes[SNameSpace] := Namespace;
  end;

  function HeaderRequired(const MethName: InvString; Item: IntfHeaderItem): Boolean;
  var
    Meths: TStringList;
    I: Integer;
  begin
    Result := Item.DefaultRequired;
    if Item.MethodNames <> '' then
    begin
      Meths := TStringList.Create;
      try
        Meths.CommaText := Item.MethodNames;
        for I := 0 to Meths.Count -1 do
          if SameText(Meths[I], MethName) then
          begin
            Result := Item.HeaderRequired[I];
            break;
          end;
      finally
        Meths.Free;
      end;
    end;
  end;

  function SetupMultiPartRelatedNode(const MPRelatedNode: IXMLNode;
                                     const MethodExtName: InvString;
                                     Input: Boolean;
                                     const HdrMsgName: InvString): IXMLNode;
  var
    I: Integer;
    PartName, Namespace: InvString;
    AClass: TClass;
  begin
    PartNode := MPRelatedNode.AddChild(SPart, SWSDLMIMENamespace);
    SoapBodyNode := PartNode.AddChild(SBody, Soapns);
    SetupSoapBodyNode(SoapBodyNode);

    if Input then
      HeaderItems := InvRegistry.GetRequestHeaderInfoForInterface(IntfMD.Info)
    else
      HeaderItems := InvRegistry.GetResponseHeaderInfoForInterface(IntfMD.Info);

    for I := 0 to Length(HeaderItems) -1 do
    begin
      if HeaderUsedWithMethod(HeaderItems[I], MethodExtName, hmtRequest) then
      begin
        AClass := HeaderItems[I].ClassType;
        PartName := InvRegistry.GetHeaderName(IntfMD.Info, AClass);
        Namespace:= InvRegistry.GetHeaderNamespace(IntfMD.Info, AClass);
        SoapHeaderNode := NewNode.AddChild(SHeader, Soapns);
        SetupSoapHeaderNode(SoapHeaderNode, TnsPre + ':' + HdrMsgName,
                 PartName, Namespace, HeaderRequired(MethodExtName, HeaderItems[I]));
      end;
    end;
  end;

  procedure SetupMultiPartNode(const MPRelatedNode: IXMLNode; const ParamName: String);
  begin
    PartNode := MPRelatedNode.AddChild(SPart, SWSDLMIMENamespace);
    ContentNode := PartNode.AddChild('content');
                                                             
    ContentNode.SetAttributeNS(SPart, '', ParamName);
    ContentNode.SetAttributeNS(SType, '', 'application/binary');
  end;

var
  I, Methods, NoOfMethods, Params: Integer;
  ParamArray: TIntfParamEntryArray;
  Bindings: IBindings;
  Binding: IBinding;
  BindOperations: IBindingOperations;
  NewBindOperation: IBindingOperation;
  MPartRelated : IXMLNode;
  PartName, PortExtName, MethodExtName, HeaderNamespace: InvString;
  MethodBindingType: TWebServiceBindingType;
  MethNames: TDOMStrings;
  OverloadDigit: string;
  ExceptItems: TExceptionItemArray;
  AClass: TClass;
begin
  SetLength(ParamArray, 0);
  { Method Array }
  NoOfMethods   := Length(IntfMD.MDA);

  { Porttype Name + Namespace }
  PortExtName := InvRegistry.GetInterfaceExternalName(IntfMD.Info,'',IntfMD.Name);
  TnsPre := GetPrefixForURI(WSDLDoc.Definition, TargetNameSpace);

  { Add WSDL Binding and its Operations }
  Bindings := WSDLDoc.Definition.Bindings;
  Binding := Bindings.Add(PortExtName+SBinding,TnsPre + ':' + PortExtName);

  { Add Binding specific elements }
  if FBindingType = btSoap then
  begin
    { Add soap:binding }
    NewNode := Binding.AddChild(SBinding, Soapns);
    NewNode.Attributes[SStyle] := 'rpc';
    NewNode.Attributes[STransport] := SSoapHTTPTransport;
  end;
  OverloadDigit := '';

  ExceptItems := InvRegistry.GetExceptionInfoForInterface(IntfMD.Info);

  MethNames := TDOMStrings.Create;
  try
    { Generate input and output nodes for operations of this binding }
    for Methods := 0 to NoOfMethods -1 do
    begin
      { Add operation node }
      MethodExtName := InvRegistry.GetMethExternalName(IntfMD.Info, IntfMD.MDA[Methods].Name);
      BindOperations := Binding.BindingOperations;
      NewBindOperation := BindOperations.Add(MethodExtName);

      if FBindingType = btSoap then
      begin
        { Add soap:operation }
        NewNode := NewBindOperation.AddChild(SOperation, Soapns);
        NewNode.Attributes[SSoapAction] := InvRegistry.GetActionURIOfInfo(IntfMD.Info, MethodExtName, Methods);
        NewNode.Attributes[SStyle] := 'rpc';  
      end;

      { Get parameters }
      ParamArray := IntfMD.MDA[Methods].Params;

      { Find the Input Binding Type }
      MethodBindingType := GetBindingType(IntfMD.MDA[Methods], True);

      { Add input/output }
      NewNode := NewBindOperation.AddChild(SInput);

      {
        Having the message attribute is only necessary to disambiguate overloaded methods:

        "An operation element within a binding specifies binding information for the operation with
         the same name within the binding's portType. Since operation names are not required to be
         unique (for example, in the case of overloading of method names), the name attribute in the
         operation binding element might not be enough to uniquely identify an operation. In that
         case, the correct operation should be identified by providing the name attributes of the
         corresponding wsdl:input and wsdl:output elements.
      }
{$IFDEF MESSAGE_ON_BINDING_IO_NODES}
      NewNode.Attributes[SMessage] := TnsPre + ':' + GetMessageName(MethodExtName, Methods, mtInput);
{$ENDIF}
      if MethodBindingType = btSoap then
      begin
        SoapBodyNode := NewNode.AddChild(SBody, Soapns);
        SetupSoapBodyNode(SoapBodyNode);
        HeaderItems := InvRegistry.GetRequestHeaderInfoForInterface(IntfMD.Info);
        for I := 0 to Length(HeaderItems) -1 do
        begin
          if HeaderUsedWithMethod(HeaderItems[I], MethodExtName, hmtRequest) then
          begin
            AClass := HeaderItems[I].ClassType;
            PartName := InvRegistry.GetHeaderName(IntfMD.Info, AClass);
            HeaderNamespace := InvRegistry.GetHeaderNamespace(IntfMD.Info, AClass);

            SoapHeaderNode := NewNode.AddChild(SHeader, Soapns);
            SetupSoapHeaderNode(SoapHeaderNode, TnsPre + ':' +
                                GetMessageName(MethodExtName, Methods, mtHeaderInput),
                                PartName, HeaderNamespace,
                                HeaderRequired(MethodExtName, HeaderItems[I]));
          end;
        end;
      end else if MethodBindingType = btMIME then
      begin
{$IFDEF _DEBUG} // The .NET importer does not like the name attribute
        { We make the <input> node's name match that of the input message of this operation -
          NOTE: This is purely conventional - i.e not according to the spec. }
        NewNode.SetAttributeNS(Sname, '', GetMessageName(MethodExtName, Methods, mtInput));
{$ENDIF}

                                                            
        MPartRelated := NewNode.AddChild(SMultiPartRelatedNoSlash, SWSDLMIMENamespace, True);
        SetupMultiPartRelatedNode(MPartRelated, MethodExtName, True,
                                  GetMessageName(MethodExtName, Methods, mtHeaderInput));

        { Here add <mime:part ><mime:content>...</mime:content></mime:part> nodes for
          each MultiPart parameter }
        { NOTE: Skip this/Self }
        for Params := 0 to Length(ParamArray)-2 do
        begin
          if IsInputParam(ParamArray[Params]) and
             (GetBindingType(ParamArray[Params]) = btMIME) then
          begin
                                                                     
            SetupMultiPartNode(MPartRelated, ParamArray[Params].Name);
          end;
        end;
      end;

      { Output Node }
      { According to the spec, we don't really need an <output..> node; however,
        the current version of Axis/Apache is not very happy when that node
        is missing:

        java.lang.NullPointerException
              at org.apache.axis.wsdl.WsdlAttributes.scanBindings(WsdlAttributes.java:271)
              at org.apache.axis.wsdl.WsdlAttributes.init(WsdlAttributes.java:114)
              at org.apache.axis.wsdl.WsdlAttributes.<init>(WsdlAttributes.java:109)
              at org.apache.axis.wsdl.Emitter.emit(Emitter.java:169)
              at org.apache.axis.wsdl.Emitter.emit(Emitter.java:134)
              at org.apache.axis.wsdl.Wsdl2java.main(Wsdl2java.java:199)
        Error in parsing: null

        I've relayed the issue; but in the meantime, we'll output a node anyway
      }
      { if IntfMD.MDA[Methods].ResultInfo <> nil  then }
      NewNode := NewBindOperation.AddChild(SOutput);

      { See note on Input node about the message attribute }
{$IFDEF MESSAGE_ON_BINDING_IO_NODES}
      NewNode.Attributes[SMessage] := TnsPre + ':' + GetMessageName(MethodExtName, Methods, mtOutput);
{$ENDIF}

      { Find the Output Binding Type }
      MethodBindingType := GetBindingType(IntfMD.MDA[Methods], False);

      if MethodBindingType = btSoap then
      begin
        SoapBodyNode := NewNode.AddChild(SBody, Soapns);
        SetupSoapBodyNode(SoapBodyNode);
        HeaderItems := InvRegistry.GetResponseHeaderInfoForInterface(IntfMD.Info);
        for I := 0 to Length(HeaderItems) -1 do
        begin
          if HeaderUsedWithMethod(HeaderItems[I], MethodExtName, hmtResponse) then
          begin
            AClass := HeaderItems[I].ClassType;
            PartName := InvRegistry.GetHeaderName(IntfMD.Info, AClass);
            HeaderNamespace := InvRegistry.GetHeaderNamespace(IntfMD.Info, AClass);

            SoapHeaderNode := NewNode.AddChild(SHeader, Soapns);
            SetupSoapHeaderNode(SoapHeaderNode, TnsPre + ':' +
                                GetMessageName(MethodExtName, Methods, mtHeaderOutput),
                                PartName, HeaderNamespace,
                                HeaderRequired(MethodExtName, HeaderItems[I]));
          end;
        end;
      end else if MethodBindingType = btMIME then
      begin
{$IFDEF _DEBUG} // The .NET importer does not like the name attribute
        { We make the <output> node's name match that of the output message of this operation -
          NOTE: This is purely conventional - i.e not according to the spec. }
        NewNode.SetAttributeNS(Sname, '', GetMessageName(MethodExtName, Methods, mtOutput));
{$ENDIF}

                                                            
        MPartRelated := NewNode.AddChild(SMultiPartRelatedNoSlash, SWSDLMIMENamespace, True);
        SetupMultiPartRelatedNode(MPartRelated, MethodExtName, False,
                                  GetMessageName(MethodExtName, Methods, mtHeaderOutput));

        { Here add <mime:part ><mime:content >...</mime:content></mime:part> nodes for
          each MultiPart parameter }
        { NOTE: Skip this/Self }
        for Params := 0 to Length(ParamArray)-2 do
        begin
          if IsOutputParam(ParamArray[Params]) and
             (GetBindingType(ParamArray[Params]) = btMIME) then
          begin
                                                                     
            SetupMultiPartNode(MPartRelated, ParamArray[Params].Name);
          end;
        end;

        { For output we also check the return type, if any }
        if GetBindingType(IntfMD.MDA[Methods].ResultInfo) = btMIME then
        begin
          SetupMultiPartNode(MPartRelated, SReturn);
        end;
      end;

      { Fault Binding }
      for I := 0 to Length(ExceptItems) -1 do
      begin
        if ExceptionUsedWithMethod(ExceptItems[I], MethodExtName) then
        begin
          NewNode := NewBindOperation.AddChild(SFault);
          NewNode.Attributes[SName] := ExceptItems[I].ClassType.ClassName;
          NewNode := NewNode.AddChild(SFault, Soapns);
          NewNode.Attributes[SName] := ExceptItems[I].ClassType.ClassName;
          SetUpSoapBodyNode(NewNode);
          break;
        end;
      end
    end;
  finally
    MethNames.Free;
  end;

end;

procedure TWebServExp.AddServices(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument; PortNames: array of InvString; Locations: array of InvString);
var
  Services: IServices;
  NewService: IService;
  NewPort: IPort;
  NewNode: IXMLNode;
  I: Integer;
  PortExtName: InvString;
  TnsPre: InvString;
begin

  Services := WSDLDoc.Definition.Services;
  PortExtName := InvRegistry.GetInterfaceExternalName(IntfMD.Info,'',IntfMD.Name);
  NewService := Services.Add(PortExtName + SService);
  for I := 0 to Length(Locations) - 1 do
  begin
    TnsPre := GetPrefixForURI(WSDLDoc.Definition, TargetNameSpace);
    NewPort := NewService.Ports.Add(PortNames[I], TnsPre + ':' + PortExtName+SBinding);
    NewNode := NewPort.AddChild(SAddress, Soapns);
    NewNode.Attributes[SLocation] := Locations[I];
  end;
end;

procedure TWebServExp.AddTypes(const IntfMD: TIntfMetaData; WSDLDoc: IWSDLDocument);
var
{  NewNode: IXMLNode; }
  SchemaDef: IXMLSchemaDef;
  Index, Count: Integer;
  UniqueURI: TDOMStrings;
begin
  { Collect all schema types to be generated }
  GetAllSchemaTypes(IntfMD);
  { Allow user chance to add more types }
  if Assigned(FOnBeforePublishingTypes) then
    FOnBeforePublishingTypes(Self);

  if  Length(SchemaArray) > 0 then
  begin
    UniqueURI := TDOMStrings.Create;
    try
      { Get Unique URI's and namespace prefix }
      for Index := 0 to Length(SchemaArray) -1 do
      begin
        if (UniqueURI.IndexOf(SchemaArray[Index].NameSpace)= -1) then
          UniqueURI.Add(SchemaArray[Index].NameSpace);
        SchemaArray[Index].NSPrefix := GetPrefixForURI(Definition, SchemaArray[Index].NameSpace);
      end;

      { Add seperate schema nodes for each unique URI }
      for Count := 0 to UniqueURI.Count -1  do
      begin
        SchemaDef := WSDLDoc.Definition.Types.SchemaDefs.Add('',UniqueURI.Strings[Count]);
        for Index := 0 to Length(SchemaArray) -1 do
        begin
          if Assigned(FOnPublishingType) then
            FOnPublishingType(Self, SchemaDef, SchemaArray[Index].TypeInfo, UniqueURI.Strings[Count]);
          GenerateXMLSchema(SchemaDef, SchemaArray[Index].TypeInfo, nil, UniqueURI.Strings[Count]);
        end;
      end;
    finally
      UniqueURI.Free;
    end;
  end;
end;

{ NOTE: Consider TOrdType and TFloatType subtypes of tkInteger and tkFloat... }
{ share with TypeTrans.pas ?? }
function TWebServExp.GetXMLSchemaType(const ParamTypeInfo: PTypeInfo):string;
var
  TypeName, URI, Prefix: InvString;
begin

  Prefix := '';
  case ParamTypeInfo^.Kind of
  tkClass, tkDynArray, tkEnumeration, tkSet:
    begin
      { See if it's a predefined XML Schema Type }
      RemTypeRegistry.TypeInfoToXSD(ParamTypeInfo, URI, TypeName);
      { Here if the URI did not match XMLNamespaces, we're dealing with a non-predefined XML Type }
      if ((URI <> SXMLSchemaURI_2000_10) and (URI <> SXMLSchemaURI_1999) and (URI <> SXMLSchemaURI_2001))  then
      begin
        Prefix := GetPrefixForTypeInfo(ParamTypeInfo);
        Result := MakeNodeName(Prefix, GetXMLSchemaTypeName(ParamTypeInfo));
      end
      else
      begin
        { We always publish 2001 XMLSchema currently }
        URI := SXMLSchemaURI_2001;
        Prefix := GetPrefixForURI(Definition, URI);
        Result := MakeNodeName(Prefix, TypeName);
      end;
      bHasComplexTypes := True;
    end;
  else
    RemTypeRegistry.TypeInfoToXSD(ParamTypeInfo, URI, TypeName);
    if TypeName <> '' then
    begin
      Prefix := GetPrefixForURI(Definition, URI);
      Result := MakeNodeName(Prefix, TypeName);
    end
    else { When all fails - anything goes!! }
    begin
      Prefix := GetPrefixForURI(Definition, SXMLSchemaURI_2001);
      Result := MakeNodeName(Prefix, SAnyType);
    end;
  end;
end;

function TWebServExp.GetXMLSchemaTypeName(const ParamTypeInfo: PTypeInfo): InvString;
var
  URI: InvString;
begin
  Result := '';
  RemTypeRegistry.TypeInfoToXSD(ParamTypeInfo, URI, Result);
  if Result = '' then
    Result := TypeInfoName(ParamTypeInfo.Name);
end;

function GetAliasBaseTypeInfo(const ParamType: TTypeKind): PTypeInfo;
begin
  case ParamType of
    tkInteger:  Result := TypeInfo(System.Integer);
    tkInt64:    Result := TypeInfo(System.Int64);
{$IFNDEF NEXTGEN}
    tkLString:  Result := TypeInfo(System.AnsiString);
    tkWString:  Result := TypeInfo(System.WideString);
{$ENDIF !NEXTGEN}
    tkUString:  Result := TypeInfo(System.UnicodeString);
  else
    Result := nil;
  end;
end;

function TWebServExp.IsComplexType(const ParamTypeInfo: PTypeInfo): Boolean;
var
  Name, URI: InvString;
  IsScalar: Boolean;
  Kind: TTypeKind;
begin
  Kind := ParamTypeInfo.Kind;
  Result := IsComplexType(Kind);

  { If not, could it be that we have an alias }
  if Result = False then
  begin
    { Handle a few alias kinds }
    if GetAliasBaseTypeInfo(Kind) <> nil then
    begin
      RemTypeRegistry.InfoToURI(ParamTypeInfo, URI, Name, IsScalar);
      { Provided the typeinfos don't map back to the XMLNamespace }
      if URI <> XMLSchemaNameSpace then
        Result := True;
    end;
  end;
end;

function TWebServExp.IsComplexType(const ParamType: TTypeKind ):Boolean;
begin
  case ParamType of
    tkClass, tkDynArray, tkEnumeration, tkSet:
      Result := True;
  else
    Result := False;
  end;
end;

function TWebServExp.GetPrefixForURI(Def: IDefinition; const URI: InvString): InvString;
var
  NameSpaceNode: IXMLNode;
begin

  Result := '';
  if Definition <> nil then
  begin
    NamespaceNode := Def.FindNamespaceDecl(URI);
    if NamespaceNode <> nil then
    begin
      Result := NamespaceNode.LocalName;
      exit;
    end;
    Result := AddNamespaceURI(Def as IXMLNode, URI);
  end;
end;


function TWebServExp.GetPrefixForURI(SchemaDef: IXMLSchemaDef; const URI: InvString): InvString;
var
  NameSpaceNode: IXMLNode;
begin
  Result := '';
  { Check if the XMLSchema root has it }
  NamespaceNode := SchemaDef.FindNamespaceDecl(URI);
  if NamespaceNode <> nil then
  begin
    Result := NamespaceNode.LocalName;
    exit;
  end
  else
  begin
    { Check if its a WSDL and if the root has it }
    if Definition <> nil then
    begin
      NamespaceNode := Definition.FindNamespaceDecl(URI);
      if NamespaceNode <> nil then
      begin
        Result := NamespaceNode.LocalName;
        exit;
      end
      else
        Result := AddNamespaceURI(Definition as IXMLNode, URI);
    end
    else
      Result := AddNamespaceURI(SchemaDef as IXMLNode, URI);
  end;
end;

function TWebServExp.AddNamespaceURI(RootNode: IXMLNode; const URI: InvString): InvString;
begin
  Result := RootNode.OwnerDocument.GeneratePrefix(RootNode);
  RootNode.DeclareNamespace(Result, URI);
end;


function TWebServExp.GetNodeNameForURI(SchemaDef: IXMLSchemaDef; const URI: InvString): InvString;
var
  NameSpaceNode: IXMLNode;
begin

  Result := '';
  { Check if the XMLSchema root has it }
  NamespaceNode := SchemaDef.FindNamespaceDecl(URI);
  if NamespaceNode <> nil then
  begin
    Result := NamespaceNode.NodeName;
    exit;
  end
  else
  begin
    { Check if its a WSDL and if the root has it }
    if Definition <> nil then
    begin
      NamespaceNode := Definition.FindNamespaceDecl(URI);
      if NamespaceNode <> nil then
        Result := NamespaceNode.NodeName;
    end;
  end;
end;


procedure TWebServExp.GenerateDerivedClassSchema(SchemaDef: IXMLSchemaDef; const ParentTypeInfo: PTypeinfo; const Namespace:InvString);
var
  Count, Index: Integer;
  RegEntry: TRemRegEntry;
begin
  Count := RemClassRegistry.GetURICount;
  for Index := 0 to Count -1 do
  begin
    RegEntry := RemClassRegistry.GetURIMap(Index);
    if RegEntry.ClassType <> nil then
    begin
      if RegEntry.ClassType.InheritsFrom(GetTypeData(ParentTypeInfo).ClassType)
       and (RegEntry.ClassType <> GetTypeData(ParentTypeInfo).ClassType) then
      begin
        GenerateXMLSchema(SchemaDef, RegEntry.Info, ParentTypeInfo, Namespace);
      end;
    end;
  end;
end;

(*
{ Similar to TypInfo's GetPropInfos except that we don't walk up the base classes }
procedure GetPropInfosInternal(TypeInfo: PTypeInfo; PropList: PPropList); assembler;
asm
        { ->    EAX Pointer to type info        }
        {       EDX Pointer to prop list        }
        { <-    nothing                         }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        XOR     ECX,ECX
        MOV     ESI,EAX
        MOV     CL,[EAX].TTypeInfo.Name.Byte[0]
        MOV     EDI,EDX
        XOR     EAX,EAX
        MOVZX   ECX,[ESI].TTypeInfo.Name[ECX+1].TTypeData.PropCount
        REP     STOSD

@outerLoop:
        MOV     CL,[ESI].TTypeInfo.Name.Byte[0]
        LEA     ESI,[ESI].TTypeInfo.Name[ECX+1]
        MOV     CL,[ESI].TTypeData.UnitName.Byte[0]
        MOVZX   EAX,[ESI].TTypeData.UnitName[ECX+1].TPropData.PropCount
        TEST    EAX,EAX
        JE      @parent
        LEA     EDI,[ESI].TTypeData.UnitName[ECX+1].TPropData.PropList

@innerLoop:

        MOVZX   EBX,[EDI].TPropInfo.NameIndex
        MOV     CL,[EDI].TPropInfo.Name.Byte[0]
        CMP     dword ptr [EDX+EBX*4],0
        JNE     @alreadySet
        MOV     [EDX+EBX*4],EDI

@alreadySet:
        LEA     EDI,[EDI].TPropInfo.Name[ECX+1]
        DEC     EAX
        JNE     @innerLoop

@parent:
@exit:
        POP     EDI
        POP     ESI
        POP     EBX
end;

function GetPropListInternal(TypeInfo: PTypeInfo; out PropList: PPropList): Integer;
begin
  Result := GetTypeData(TypeInfo)^.PropCount;
  if Result > 0 then
  begin
    GetMem(PropList, Result * SizeOf(Pointer));
    FillChar(PropList^, Result * SizeOf(Pointer), 0);
    GetPropInfosInternal(TypeInfo, PropList);
  end;
end;

{ Similar to TypInfo's IsStoredProp although this version only handles cases
  where the attribute was assigned 'true' or 'false' directly }
function IsStoredPropInternal(Instance: TObject; PropInfo: PPropInfo): Boolean;
asm
        { ->    EAX Pointer to Instance         }
        {       EDX Pointer to prop info        }
        { <-    AL  Function result             }

        MOV     ECX,[EDX].TPropInfo.StoredProc
        TEST    ECX,0FFFFFF00H
        JE      @@returnCL
        MOV     CL, 1
@@returnCL:
        MOV     AL,CL
@@exit:
end;

{ Returns the TypeInfo of a class member }
function GetMemberTypeInfo(const ObjectTypeInfo: PTypeInfo; const MemberName: string): PTypeInfo;
var
  PropList: PPropList;
  Size, Props: Integer;
begin
  Result := nil;
  Size := GetPropListInternal(ObjectTypeInfo, PropList);
  try
    for Props := 0 to Size -1 do
    begin
      if PropList[Props] <> nil then
      begin
        { Either there's a match or send the only member's TypeInfo back }
        if SameText(PropList[Props].Name, MemberName) or ((MemberName = '') and (Size = 1)) then
        begin
          Result := PropList[Props].PropType^;
          Exit;
        end;
      end;
    end;
  finally
    if Size > 0 then
      FreeMem(PropList);
  end;
end;
 *)

procedure TWebServExp.GenerateClassSchema(SchemaDef: IXMLSchemaDef;
                                          const ATypeInfo, ParentInfo: PTypeinfo;
                                          const Namespace: InvString);
var
  Size, Props: integer;
  PropList: PPropList;
  ComplexType: IXMLComplexTypeDef;
  ElementType: IXMLElementDef;
  AttributeType: IXMLAttributeDef;
  ParamType: string;
  BaseName, Pre, PropName: InvString;
  AncInfo: PTypeInfo;
  SerialOpts: TSerializationOptions;
begin
  Size := GetPropListFlat(ATypeInfo, PropList);
  try
    { Catch case where class is simply an alias wrapper for a simple type }
    SerialOpts := RemClassRegistry.SerializeOptions(GetTypeData(ATypeInfo).ClassType);
    if (xoSimpleTypeWrapper in SerialOpts) and (Size = 1) then
    begin
      { The class is considered as an alias of the type of it's sole (published) member }
      GenerateAliasSchema(SchemaDef, ATypeInfo, Namespace, PropList[0].PropType^);
    end
    else
    begin
      if ParentInfo <> nil then
      begin
        { Namespace prefix of base type }
        Pre := GetPrefixForTypeInfo(ParentInfo);
        if Pre <> '' then
          BaseName := MakeNodeName(Pre, TypeInfoName(ParentInfo.Name))
        else
          BaseName := TypeInfoName(ParentInfo.Name);

        { Does the parent have a parent ?? }
        if GetTypeData(ParentInfo).ParentInfo <> nil then
          AncInfo := GetTypeData(ParentInfo).ParentInfo^
        else
          AncInfo := nil;

        { If yes, validate Grandparent }
        if (AncInfo <> nil) and IsBaseClassTypeInfo(AncInfo) then
          AncInfo := nil;

        { Generate parent schema }
        GenerateXMLSchema(SchemaDef, ParentInfo, AncInfo, Namespace);

        { Add this type's complex type }
        ComplexType := SchemaDef.ComplexTypes.Add(GetXMLSchemaTypeName(ATypeInfo), BaseName)
      end else
        ComplexType := SchemaDef.ComplexTypes.Add(GetXMLSchemaTypeName(ATypeInfo));

      { And the properties }
      for Props := 0 to Size -1 do
      begin
        if PropList[Props] <> nil then
        begin
          ParamType := GetXMLSchemaType(PropList[Props].PropType^);
          PropName := RemClassRegistry.GetExternalPropName(ATypeInfo, TypeInfoName(PropList[Props].Name));
          if IsStoredPropConst(nil, PropList[Props]) then
            ElementType := ComplexType.ElementDefs.Add(PropName, ParamType)
          else
            AttributeType := ComplexType.AttributeDefs.Add(PropName, ParamType);
          if IsComplexType(PropList[Props].PropType^) then
            GenerateXMLSchema(SchemaDef, PropList[Props].PropType^, nil, Namespace);
        end;
      end;
    end;
  finally
    if Size > 0 then
      FreeMem(PropList);
  end;
end;


procedure TWebServExp.GenerateEnumSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString);
var
  SimpleType: IXMLSimpleTypeDef;
  TypeData: PTypeData;
  Index: Integer;
  Value: string;
  EnumInfo: PTypeInfo;
begin
  EnumInfo := ATypeInfo;

  { Here we need to shortcircuit ByteBool, WordBool and LongBool - the
    RTTI/Compiler treats them as enumerations with 256, 32K and 2G members
    respectively - We don't want to publish these members:) }
  if (EnumInfo = TypeInfo(System.ByteBool)) or
     (EnumInfo = TypeInfo(System.WordBool)) or
     (EnumInfo = TypeInfo(System.LongBool)) then
    EnumInfo := TypeInfo(System.Boolean);
  TypeData := GetTypeData(EnumInfo);
  if TypeData <> nil then
  begin
    SimpleType := SchemaDef.SimpleTypes.Add(GetXMLSchemaTypeName(ATypeInfo), 'string'); { do not localize }
    for Index := 0 to TypeData.MaxValue do
    begin
      Value := GetEnumName(ATypeInfo, Index);
      SimpleType.Enumerations.Add(RemClassRegistry.GetExternalPropName(EnumInfo, Value));
    end;
  end;
end;

procedure TWebServExp.GenerateAliasSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString;
                                          const ABaseTypeInfo: PTypeInfo = nil);
var
  SimpleType: IXMLSimpleTypeDef;
  TypeData: PTypeData;
  BaseInfo: PTypeInfo;
  TypeName: InvString;
begin
  TypeData := GetTypeData(ATypeInfo);
  if TypeData <> nil then
  begin
    { Name ?? }
    TypeName := TypeInfoName(ATypeInfo.Name);
    { Base Type Info }
    if ABaseTypeInfo = nil then
      BaseInfo := GetAliasBaseTypeInfo(ATypeInfo.Kind)
    else
      BaseInfo := ABaseTypeInfo;
    { Add type }
    SimpleType := SchemaDef.SimpleTypes.Add(GetXMLSchemaTypeName(ATypeInfo), TypeName);
    SimpleType.BaseTypeName := GetXMLSchemaType(BaseInfo);
  end;
end;

procedure TWebServExp.GenerateArraySchema(SchemaDef: IXMLSchemaDef; const ATypeInfo: PTypeinfo; const Namespace: InvString);
var
  ComplexType: IXMLComplexTypeDef;
  ElementType: IXMLElementDef;
  ElementTypeInfo: PTypeinfo;
  I, Dimensions: integer;
  ParamType, ArrayElementName: string;
  ArrayType: string;
  TypeName, Prefix, SoapEncPrefix: InvString;
  AttrDef: IXMLAttributeDef;
  DimString, ArrayName, TempName: string;
  XMLElementDefs: IXMLElementDefs;
begin
  if FArrayAsComplexContent then
  begin
    ElementTypeInfo := GetDynArrayNextInfo2(ATypeInfo, ArrayName);
    Dimensions := 1;
    while (ElementTypeInfo <> nil) and (ElementTypeInfo.Kind = tkDynArray ) and
{$IFDEF NEXTGEN}
          (ElementTypeInfo.Name = Ord('.')) do
{$ELSE !NEXTGEN}
          (ElementTypeInfo.Name[1] = '.') do
{$ENDIF NEXTGEN}
    begin
      Inc(Dimensions);
      ElementTypeInfo := GetDynArrayNextInfo2(ElementTypeInfo, TempName);
    end;
{$IFDEF NEXTGEN}
    if (ElementTypeInfo = nil) or (ElementTypeInfo.Name = Ord('.')) then
{$ELSE !NEXTGEN}
    if (ElementTypeInfo = nil) or (ElementTypeInfo.Name[1] = '.') then
{$ENDIF NEXTGEN}
      GetDynArrayElTypeInfo(ATypeInfo, ElementTypeInfo, Dimensions);
    {
    if (ElementTypeInfo.Kind = tkDynArray) and (ArrayName <> '') and (ArrayName[1] <> '.') then
      GenerateArraySchema(RootNode, ElementTypeInfo, Namespace);
    if (ElementTypeInfo.Kind = tkClass) or (ElementTypeInfo.Kind = tkEnumeration) then
      GenerateXMLSchema(RootNode, ElementTypeInfo, nil, Namespace);
    }
    ParamType := GetXMLSchemaType(ElementTypeInfo);
    ArrayType := SArrayOf + ParamType;
    { Get Soap Encoding prefix }
    SoapEncPrefix := GetPrefixForURI(SchemaDef,  SSoap11EncodingS5);
    TypeName := GetXMLSchemaTypeName(ATypeInfo);
    ComplexType := SchemaDef.ComplexTypes.Add(TypeName, SoapEncPrefix + ':' + SSoapEncodingArray, dmComplexRestriction);
    AttrDef:= ComplexType.AttributeDefs.Add(SoapEncPrefix + ':'+ SArrayType);
    { Get WSDL URI prefix }
    Prefix := GetNodeNameForURI(SchemaDef, Wsdlns);
    { Create dimension string }
    DimString := '[';
    if (Dimensions > 1) then
      for I := 1 to Dimensions-1 do
        DimString := DimString + ',';
    DimString := DimString + ']';

{$IFDEF OPENDOM}
    AttrDef.DeclareNameSpace('n1', Wsdlns);
    AttrDef.SetAttributeNS(SArrayType, Wsdlns, ParamType + DimString);
{$ELSE}
    AttrDef.Attributes['n1'+':'+SArrayType] := ParamType + DimString;
    AttrDef.Attributes[Prefix+':'+'n1'] := Wsdlns;
{$ENDIF}
  end
  else
  begin
    GetDynArrayElTypeInfo(ATypeInfo, ElementTypeInfo, Dimensions);
    ParamType := GetXMLSchemaType(ElementTypeInfo);
    ArrayType := SArrayOf + ParamType;
    XMLElementDefs := SchemaDef.ElementDefs;
    Prefix := GetPrefixForURI(SchemaDef, Soapns);
    TypeName := GetXMLSchemaTypeName(ATypeInfo);
    ElementType := XMLElementDefs.Add(TypeName, True, MakeNodeName(Prefix, SArray));
  {  ElementType := RootNode.SchemaDef.ElementDefs.Add(ATypeInfo.Name, True, SSoapArray); }
  {  ElementType := SchemaDef.ElementDefs.Add(ATypeInfo.Name, True, SSoapArray); }
    ComplexType := ElementType.DataType as IXMLComplexTypeDef;
    ComplexType.Attributes[SName] := ArrayType;

    if Dimensions > 1  then
      GenerateNestedArraySchema(SchemaDef, ComplexType, ElementTypeInfo, Dimensions, Namespace)
    else
    begin
      ArrayElementName := 'Dimension' + IntToStr(Dimensions);
      ParamType := GetXMLSchemaType(ElementTypeInfo);
      ElementType := ComplexType.ElementDefs.Add(ArrayElementName, ParamType);
      ElementType.Attributes[SMaxOccurs] := SUnbounded;

      if IsComplexType(ElementTypeInfo) then
        GenerateXMLSchema(SchemaDef, ElementTypeInfo, nil, Namespace);
    end;
  end;
end;


procedure TWebServExp.GenerateNestedArraySchema(SchemaDef: IXMLSchemaDef; ComplexType: IXMLComplexTypeDef; const ATypeInfo: PTypeinfo; var Dimension: Integer; Namespace: InvString);
var
  ParamType: string;
  ArrayElementName: String;
  ElementType: IXMLElementDef;
  NestedType: IXMLComplexTypeDef;
begin
  while Dimension <> 0 do
  begin
    if Dimension > 1  then
    begin
      ArrayElementName := 'Dimension' + IntToStr(Dimension);
      ElementType := ComplexType.ElementDefs.Add(ArrayElementName, True);
      ElementType.Attributes[SMaxOccurs] := SUnbounded;
      NestedType := ElementType.DataType as IXMLComplexTypeDef;
      Dimension := Dimension -1;
      GenerateNestedArraySchema(SchemaDef, NestedType, ATypeInfo, Dimension, Namespace);
    end
    else
    begin
      ArrayElementName := 'Dimension' + IntToStr(Dimension);
      ParamType := GetXMLSchemaType(ATypeInfo);
      ElementType := ComplexType.ElementDefs.Add(ArrayElementName, ParamType);
      ElementType.Attributes[SMaxOccurs] := SUnbounded;
      Dimension := Dimension -1;

      if IsComplexType(ATypeInfo) then
        GenerateXMLSchema(SchemaDef, ATypeInfo, nil, Namespace);
    end;
  end; //while
end;


procedure TWebServExp.GenerateXMLSchema(SchemaDef: IXMLSchemaDef; const ATypeInfo, ParentInfo: PTypeinfo; Namespace: InvString);
var
  TempURI, TempName: InvString;
  AncInfo: PTypeInfo;
begin
  if  IsComplexType(ATypeInfo) then
  begin
    { NOTE: IsSchemaGenerated will toggle the generated flag if it returns false }
    if (not IsSchemaGenerated(ATypeInfo, Namespace)) then
    begin
      case ATypeInfo.Kind  of
        tkDynArray:     GenerateArraySchema(SchemaDef, ATypeInfo, NameSpace);
        tkEnumeration:  GenerateEnumSchema(SchemaDef, ATypeInfo, NameSpace);
        tkClass:
          begin
            { Determine the base class info. }
            if (ParentInfo = nil) and (GetTypeData(ATypeInfo).ParentInfo <> nil) then
            begin
              AncInfo := (GetTypeData(ATypeInfo).ParentInfo)^;
              { Stop as soon as we get to a base class }
              if (AncInfo <> nil) and IsBaseClassTypeInfo(AncInfo) then
                AncInfo := nil;
              { Or something not registered }
              if (AncInfo <> nil) and not RemTypeRegistry.TypeInfoToXSD(AncInfo, TempURI, TempName) then
                AncInfo := nil;
            end else
              AncInfo := ParentInfo;

            { Generate the class schemae }
            GenerateClassSchema(SchemaDef, ATypeInfo, AncInfo, Namespace);

            { Generate XML Schema for registered derived classes }
            GenerateDerivedClassSchema(SchemaDef, ATypeInfo, Namespace);
          end;
        else
        begin
          { Generate alias }
          if GetAliasBaseTypeInfo(ATypeInfo.Kind) <> nil then
            GenerateAliasSchema(SchemaDef, ATypeInfo, NameSpace);
        end
      end;
    end;
  end;
end;


procedure TWebServExp.GetAllSchemaTypes(const IntfMD: TIntfMetaData);
var
  I, Methods, Params, NoOfMethods, NoOfParams: Integer;
  IntfMethArray: TIntfMethEntryArray;
  ParamArray: TIntfParamEntryArray;
  HeaderItems: THeaderItemArray;
  ExceptItems: TExceptionItemArray;
begin
  IntfMethArray := nil;
  ParamArray    := nil;
  IntfMethArray := IntfMD.MDA;
  NoOfMethods   := Length(IntfMethArray);

  for Methods := 0 to NoOfMethods -1 do
  begin
    ParamArray := IntfMD.MDA[Methods].Params;
    NoOfParams := Length(ParamArray);

    { Note: Skip this/Self }
    for Params := 0 to NoOfParams -2 do
    begin
      if IsComplexType(ParamArray[Params].Info) then
        GetSchemaTypes(ParamArray[Params].Info, nil);
    end;

    { For Function return type }
    if IntfMD.MDA[Methods].ResultInfo <> nil  then
    begin
      { If the return type is an object }
      if IsComplexType(IntfMD.MDA[Methods].ResultInfo) then
        GetSchemaTypes(IntfMD.MDA[Methods].ResultInfo, nil);
    end;
  end;

  { Add all headers of interface to types }
  HeaderItems := InvRegistry.GetHeaderInfoForInterface(IntfMD.Info);
  for I := 0 to Length(HeaderItems) -1 do
    GetSchemaTypes(HeaderItems[I].ClassType.ClassInfo, nil);

  { And all faults of interface to types }
  ExceptItems := InvRegistry.GetExceptionInfoForInterface(IntfMD.Info);
  for I := 0 to Length(ExceptItems) -1 do
    GetSchemaTypes(ExceptItems[I].ClassType.ClassInfo, nil);
end;


procedure TWebServExp.GetDerivedClassSchema(const ParentTypeInfo: PTypeinfo);
var
  Count, Index: Integer;
  RegEntry: TRemRegEntry;
begin
  Count := RemClassRegistry.GetURICount;
  for Index := 0 to Count -1 do
  begin
    RegEntry := RemClassRegistry.GetURIMap(Index);
    if RegEntry.ClassType <> nil then
    begin
      if RegEntry.ClassType.InheritsFrom(GetTypeData(ParentTypeInfo).ClassType) then
        GetSchemaTypes(RegEntry.Info, ParentTypeInfo);
    end;
  end;
end;

function TWebServExp.FindOrAddSchema(const ATypeInfo: PTypeinfo; const TnsURI: string): Boolean;
var
  Index: Integer;
begin
  Result := False;

  { Do not register Empty TnsURI or tkSet or any predefined type from XMLSchema }
  if ((TnsURI = '') or (ATypeInfo.Kind = tkSet) or (TnsURI = SXMLSchemaURI_1999) or  (TnsURI = SXMLSchemaURI_2000_10) or
    (TnsURI = SXMLSchemaURI_2001))  then
  begin
    Result := True;
    Exit;
  end;

  for Index := 0 to Length(SchemaArray) -1 do
  begin
    if SchemaArray[Index].TypeInfo = ATypeInfo then
    begin
      Result := True;
      Exit;
    end;
  end;

  { Add new type }
  Index := Length(SchemaArray);
  SetLength(SchemaArray, Index+1);
  SchemaArray[Index].TypeName := GetXMLSchemaTypeName(ATypeInfo);
  SchemaArray[Index].NameSpace := TnsURI;
  SchemaArray[Index].TypeInfo := ATypeInfo;
  SchemaArray[Index].XSGenerated := False;
end;

{ NOTE: IsSchemaGenerated has a nasty side-effect - if the generated flag is false, it will
        toggle it - Argghh!! }
function TWebServExp.IsSchemaGenerated(const ATypeInfo: PTypeinfo; const TnsURI: InvString): Boolean;
var
  Index: Integer;
begin
  Result := True;
  for Index := 0 to Length(SchemaArray) -1 do
  begin
    if ((SchemaArray[Index].TypeInfo = ATypeInfo) and
      (SchemaArray[Index].NameSpace = TnsURI) ) then
    begin
      if  SchemaArray[Index].XSGenerated = False then
      begin
        Result := False;
        SchemaArray[Index].XSGenerated := True;
      end
      else
        Result := True;
      Exit;
    end;
  end;
end;


function  TWebServExp.GetPrefixForTypeInfo(const ATypeInfo: PTypeinfo): InvString;
var
  Index: Integer;
begin
  Result := '';
  for Index := 0 to Length(SchemaArray) -1 do
  begin
    if (SchemaArray[Index].TypeInfo = ATypeInfo) then
    begin
      Result := SchemaArray[Index].NSPrefix;
      exit;
    end;
  end;
end;

{ This routines collects all schemas associated with a typeinfo - the Getxxx routines
  collect the types; the Generatexxxx generate the XML }
procedure TWebServExp.GetSchemaTypes(const ATypeInfo, ParentInfo: PTypeinfo);
var
  URI, Name: InvString;
  IsScalar, Registered: Boolean;
begin
  if  IsComplexType(ATypeInfo) then
  begin
    Registered := RemClassRegistry.InfoToURI(ATypeInfo, URI, Name, IsScalar);
    { NOTE: If the user forgot to register the type, and
            auto-registration is probably turned off ??? }
    if not Registered then
    begin
    { NOTE: We get here if the user forgot to register the type, and
            auto-registration is turned off ??? }
      ;
    end;

    { Add to the SchemaArray to keep track of what complex type has }
    { already been encountered                                      }
    if (not FindOrAddSchema(ATypeInfo, URI)) then
    begin
      case ATypeInfo.Kind  of
        tkDynArray:  GetArraySchema(ATypeInfo);
        tkClass:
          begin
            GetClassSchema(ATypeInfo, ParentInfo);
            { Get all the registered derived classes }
            GetDerivedClassSchema(ATypeInfo);
          end;
      end;
    end;
  end;
end;

procedure TWebServExp.GetClassSchema(const ATypeInfo, ParentInfo: PTypeinfo);
var
  Size, Props: integer;
  PropList: PPropList;
begin
  Size := GetPropList(ATypeInfo, [tkUnknown..tkDynArray], nil);
  if Size > 0 then
  begin
    { QC:7954 - Memory is allocated for PropList }
    Size := GetPropList(ATypeInfo, PropList);
    try
      for Props := 0 to Size -1 do
      begin
        if IsComplexType(PropList[Props].PropType^) then
          GetSchemaTypes(PropList[Props].PropType^, nil);
      end;
    finally
      if Size > 0 then
        FreeMem(PropList);
    end;
  end; //Size > 0
end;


procedure TWebServExp.GetArraySchema(const ATypeInfo: PTypeinfo);
var
  ElementTypeInfo: PTypeInfo;
  Dimensions: Integer;
  ArrayName, TempName: String;
begin
  ElementTypeInfo := GetDynArrayNextInfo2(ATypeInfo, ArrayName);
  Dimensions := 1;
  { When the compiler generates *intermediate* typeinfos for multidim arrays, the
    ElementTypeInfo name is '.#'; so we can use the '.' to detect this case }
  while (ElementTypeInfo <> nil) and  (ElementTypeInfo.Kind = tkDynArray ) and
{$IFDEF NEXTGEN}
        (ElementTypeInfo.Name = Ord('.')) do
{$ELSE !NEXTGEN}
        (ElementTypeInfo.Name[1] = '.') do
{$ENDIF NEXTGEN}
  begin
    Inc(Dimensions);
    ElementTypeInfo := GetDynArrayNextInfo2(ElementTypeInfo, TempName);
  end;
{$IFDEF NEXTGEN}
  if (ElementTypeInfo = nil) or (ElementTypeInfo.Name = Ord('.')) then
{$ELSE !NEXTGEN}
  if (ElementTypeInfo = nil) or (ElementTypeInfo.Name[1] = '.') then
{$ENDIF NEXTGEN}
    GetDynArrayElTypeInfo(ATypeInfo, ElementTypeInfo, Dimensions);

  if (ElementTypeInfo.Kind = tkDynArray) and (ArrayName <> '') and (ArrayName[Low(string)] <> '.') then
    GetSchemaTypes(ElementTypeInfo, nil);
  if (ElementTypeInfo.Kind = tkClass) or (ElementTypeInfo.Kind = tkEnumeration) then
    GetSchemaTypes(ElementTypeInfo, nil);
  {
  GetDynArrayElTypeInfo(ATypeInfo, ElementTypeInfo, Dim);
  if ElementTypeInfo <> nil then
    GetSchemaTypes(ElementTypeInfo, nil);
  }
end;

function TWebServExp.GetWebServExp: TWebServExp;
begin
  Result := Self;
end;

initialization

finalization
end.
