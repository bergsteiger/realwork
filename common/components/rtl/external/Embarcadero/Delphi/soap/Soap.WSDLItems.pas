{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                      WSDL Items                       }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WSDLItems;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

{$IFDEF WEAVER_UP}
  {$DEFINE SOAP12_PRECEDENCE_OVER_SOAP11}
{$ENDIF}

interface

uses
  System.Classes, System.Generics.Collections,
  Xml.XMLIntf, Xml.xmldom, Xml.XMLSchema,
  Soap.HTTPUtil, Soap.WSDLBind, Soap.WSDLIntf;

type
  TWSDLItems = class;

  IWSDLItems = interface
  ['{F71B4B05-C5AB-4484-B994-64F3F9E805C7}']
    function GetWSDLItems: TWSDLItems;
    function GetWSDLDoc: IWSDLDocument;
    procedure Load(const WSDLFileName: DOMString);
  end;

  IQualifiedName = interface
  ['{0173ABA2-34AB-4CB1-ADF0-AA99C98FCFBD}']
    function  GetName: DOMString;
    procedure SetName(const name: DOMString);
    function  GetNamespace: DOMString;
    procedure SetNamespace(const ns: DOMString);
    property  Name: DOMString read GetName write SetName;
    property  Namespace: DOMString read GetNamespace write SetNamespace;
  end;

  IQualifiedNameArray = array of IQualifiedName;

  IHeaderInfo = interface
  ['{3331A5D4-BA6D-4E76-80F3-279DB879EDCB}']
    function  GetPart: IPart;
    procedure SetPart(const P: IPart);
    function  GetRequired: Boolean;
    procedure SetRequired(Req: Boolean);
    function  GetUse: DOMString;
    procedure SetUse(const U: DOMString);
    function  GetEncodingStyle: DOMString;
    procedure SetEncodingStyle(const EncStyl: DOMString);
    function  GetNamespace: DOMString;
    procedure SetNamespace(const N: DOMString);
    function  GetName: DOMString;
    procedure SetName(const N: DOMString);

    property  Part: IPart read GetPart write SetPart;
    property  Required: Boolean read GetRequired write SetRequired;
    property  Use: DOMString read GetUse write SetUse;
    property  EncodingStyle: DOMString read GetEncodingStyle write SetEncodingStyle;
    property  Namespace: DOMString read GetNamespace write SetNamespace;
    property  Name: DOMString read GetName write SetName;
  end;

  IHeaderInfoArray = array of IHeaderInfo;

  { Options passed to Proc. when iterating through imports }
  IterateImportOptions = (ioBeforeLoad, ioLoaded);

  { Callback when iterating through imports of a WSDL document }
  TWSDLIterateProc = procedure (const Options: IterateImportOptions;
                                const WSDLItems: IWSDLItems;
                                const XMLSchemaDoc: IXMLSchemaDoc;
                                const Name: DOMString) of object;

  IWSDLLookup = interface
  ['{0A742759-AD54-4458-AF5E-C2BC971157D2}']
    procedure BuildWSDLLookup(WSDLItems: IWSDLItems; IterateProc: TWSDLIterateProc); overload;
    procedure BuildWSDLLookup(WSDLItems: IWSDLItems); overload;
    procedure ClearWSDLLookup;
    procedure Add(const URLLocation: string; WSDLItems: IWSDLItems);
    procedure AddImport(const URLLocation, ImportURLLocation: string);
    function Contains(const URLLocation: string): Boolean;
    function GetWSDLItems(const URLLocation: string): IWSDLItems;
    function GetWSDLImportList(const URLLocation: string): TList<string>;
    function IsEmpty: Boolean;
  end;

  { Helper class to get WSDL Items }
  TWSDLItems = class(TWSDLDocument, IWSDLItems)
  private
    FWSDLStreamLoader: IStreamLoader;
    FWSDLLookup: IWSDLLookup;

    function  GetGenericBindingAttribute(const BindingName: DOMString;
                                         const NodeName: DOMString;
                                         const Namespace: DOMString;
                                         Attribute: DOMString): DOMString;
    function MakeTNSName(const Name: DOMString): DOMString;
    procedure GetBindingOfType(const BindingTypeName: DOMString;
                               const TNS: DOMString;
                               var BindingArray: IQualifiedNameArray); overload;
  protected
    function  GetName: DOMString;
    function  GetTargetNamespace: DOMString;
    function  GetTargetNamespacePrefix: DOMString;

  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(const WSDLItems: TWSDLItems; const StreamLoader: IStreamLoader); overload; virtual;

    { IWSDLItems }
    function GetWSDLItems: TWSDLItems;
    function GetWSDLDoc: IWSDLDocument;
    procedure Load(const WSDLFileName: DOMString);

    function CompareName(const NodeName: DOMString;
                         const OtherName: DOMString;
                         const TNS: DOMString = ''): Boolean;

    { Helper methods to get WSDL Items }

    procedure GetServices(ServiceNames: TDOMStrings; QualifiedNames: Boolean = False);
    function  GetServiceNode(const ServiceName: DOMString): IXMLNode;

    procedure GetMessages(MessageNames: TDOMStrings; QualifiedNames: Boolean = False);
    function  GetMessageNode(const MessageName: DOMString): IXMLNode;
    procedure GetParts(const MessageName: DOMString; PartNames: TDOMStrings; QualifiedNames: Boolean = False);
    function  GetPartNode(const MessageName, PartName: DOMString): IXMLNode;
    function  IsPortTypeHTTPBound(const PortType: DOMString): Boolean;
    procedure GetPortTypes(PortTypeNames: TDOMStrings; SkipHttpBindings: Boolean = True;
                                                        QualifiedNames: Boolean = False);
    function  GetPortTypeNode(const PortTypeName: DOMString): IXMLNode;
    procedure GetOperations(const PortTypeName: DOMString; OperationNames: TDOMStrings; QualifiedNames: Boolean = False);
    function  GetOperationNode(const PortTypeName, OperationName: DOMString): IXMLNode;

    procedure GetPortsForService(const ServiceName: DOMString; PortNames: TDOMStrings;
                                 SkipHttpBindings: Boolean = True; QualifiedNames: Boolean = False);

    { Returns a Binding for the specified Service/Port combination }
    function  GetBindingForServicePort(const ServiceName, PortName: DOMString): IQualifiedName;

    { Returns the Service/Port of the specified Binding }
    function  GetServiceAndPortOfBinding(const BindingName: IQualifiedName;
                                         var ServiceName: DOMString;
                                         var PortName: DOMString): Boolean;

    { Returns the endpoint/location for the specified Service/Port combination }
    function  GetSoapAddressForServicePort(const ServiceName, PortName: DOMString;
                                           var SOAPVersion: TSOAPVersion): DOMString;
    { Imports }
    procedure GetImports(ImportNames: TDOMStrings);
    procedure IterateImports(IterateProc: TWSDLIterateProc);
    function  GetLocationForImport(const ImportNameSpace: DOMString): DOMString;
    { Schemas }
    function  HasTypesNode: Boolean;
    procedure GetSchemas(SchemaNames: TDOMStrings);
    function  GetSchemaNode(const SchemaTns: DOMString) : IXMLNode;
    { Bindings }
    procedure GetBindings(BindingNames: TDOMStrings; QualifiedNames: Boolean = False);
    function  GetBindingType(const BindingName: DOMString): DOMString;
    function  GetBindingOfType(const BindingTypeName: DOMString;
                               const TNS: DOMString = ''): IQualifiedNameArray; overload;
    function  GetSoapBindingAttribute(const BindingName: DOMString; Attribute: DOMString;
                                      var SOAPVersion: TSOAPVersion): DOMString;
    function  GetHttpBindingAttribute(const BindingName: DOMString; Attribute: DOMString): DOMString; overload;
    function  GetHttpBindingAttribute(const QualifiedName: IQualifiedName; Attribute: DOMString): DOMString; overload;
    procedure GetOperationsForBinding(const BindingName: DOMString; OperationNames: TDOMStrings; QualifiedNames: Boolean = False);

    function  GetBindingOperationNode(const BindingName, Operation: DOMString; OverloadIndex: Integer; out ResultsWSDLItems: IWSDLItems): IBindingOperation;

    function  GetSoapOperationAttribute(const BindingName, Operation, Attribute: DOMString;
                                        OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
    function  GetSoapAction(const BindingName, Operation: DOMString; OverloadIndex: Integer;
                            var SOAPVersion: TSOAPVersion): DOMString;
    function  GetSoapOperationStyle(const BindingName, Operation: DOMString; OverloadIndex: Integer;
                                    var SOAPVersion: TSOAPVersion): DOMString;
    procedure GetSoapActionList(const BindingName: DOMString; ActionList: TDOMStrings;
                                QualifiedNames: Boolean; var SOAPVersion: TSOAPVersion);

    function  GetSoapBindingIONode(const BindingName, Operation: DOMString;
                                   Input: Boolean;
                                   OverloadIndex: Integer;
                                   out ResultsWSDLItems: IWSDLItems): IXMLNode;
    function  GetSoapBindingInputNode(const BindingName, Operation: DOMString;
                                      OverloadIndex: Integer;
                                      out ResultsWSDLItems: IWSDLItems): IXMLNode;
    function  GetSoapBindingOutputNode(const BindingName, Operation: DOMString;
                                       OverloadIndex: Integer;
                                       out ResultsWSDLItems: IWSDLItems): IXMLNode;

    function  GetSoapBodyAttribute(const BindingName, Operation, IOType, Attribute: DOMString;
                                   OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
    function  GetSoapBodyInputAttribute(const BindingName, Operation, Attribute: DOMString;
                                        OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
    function  GetSoapBodyOutputAttribute(const BindingName, Operation, Attribute: DOMString;
                                         OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
    function  GetSoapBodyNamespace(const BindingPortType: DOMString; var SOAPVersion: TSOAPVersion): DOMString;

    { Headers }
    function  GetSoapHeaders(BindingName: IQualifiedName; const Operation: DOMString; Input: Boolean;
                             OverloadIndex: Integer; const MessageName: DOMString;
                             var SOAPVersion: TSOAPVersion; out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;
    function  GetSoapInputHeaders(BindingName: IQualifiedName; const Operation: DOMString;
                                  OverloadIndex: Integer; const MessageName: DOMString;
                                  var SOAPVersion: TSOAPVersion; out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;
    function  GetSoapOutputHeaders(BindingName: IQualifiedName; const Operation: DOMString;
                                   OverloadIndex: Integer; const MessageName: DOMString;
                                   var SOAPVersion: TSOAPVersion; out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;

    function GetPartsForOperation(const PortTypeName, OperationName: DOMString; OperationIndex: Integer; PartNames: TDOMStrings): Boolean;

    property StreamLoader: IStreamLoader read FWSDLStreamLoader;
    property TargetNamespace: DOMString read GetTargetNamespace;
    property WSDLLookup: IWSDLLookup read FWSDLLookup;
  end;

{ Helper functions }
function HasDefinition(const WSDLDoc: IWSDLDocument): Boolean; overload;
function HasDefinition(const WSDLItems: IWSDLItems): Boolean; overload;

function NewQualifiedName(const Name: DOMString = ''; const Namespace: DOMString = ''): IQualifiedName;

implementation

uses
  System.SysUtils, Soap.SOAPConst, Soap.WSDLLookup;

type
  TQualifiedName = class(TInterfacedObject, IQualifiedName)
  private
    FName: DOMString;
    FNamespace: DOMString;
  public
    function  GetName: DOMString;
    procedure SetName(const name: DOMString);
    function  GetNamespace: DOMString;
    procedure SetNamespace(const ns: DOMString);
  end;

  THeaderInfo = class(TInterfacedObject, IHeaderInfo)
  private
    FPart: IPart;
    FRequired: Boolean;
    FUse: DOMString;
    FEncodingStyle: DOMString;
    FNamespace: DOMString;
    FName: DOMString;
  public
    function  GetPart: IPart;
    procedure SetPart(const P: IPart);
    function  GetRequired: Boolean;
    procedure SetRequired(Req: Boolean);
    function  GetUse: DOMString;
    procedure SetUse(const U: DOMString);
    function  GetEncodingStyle: DOMString;
    procedure SetEncodingStyle(const EncStyl: DOMString);
    function  GetNamespace: DOMString;
    procedure SetNamespace(const N: DOMString);
    function  GetName: DOMString;
    procedure SetName(const N: DOMString);
  end;

function NewQualifiedName(const Name: DOMString; const Namespace: DOMString): IQualifiedName;
begin
  Result := TQualifiedName.Create;
  Result.Name := Name;
  Result.Namespace := Namespace;
end;

function NewHeaderInfo: IHeaderInfo;
begin
  Result := THeaderInfo.Create;
end;

function  TQualifiedName.GetName: DOMString;
begin
  Result := FName;
end;

procedure TQualifiedName.SetName(const name: DOMString);
begin
  FName := name;
end;

function  TQualifiedName.GetNamespace: DOMString;
begin
  Result := FNamespace;
end;

procedure TQualifiedName.SetNamespace(const ns: DOMString);
begin
  FNamespace := ns;
end;

constructor TWSDLItems.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWSDLStreamLoader := Soap.HTTPUtil.GetDefaultStreamLoader;
  FWSDLLookup := GetWSDLLookup as IWSDLLookup;
end;

constructor TWSDLItems.Create(const WSDLItems: TWSDLItems; const StreamLoader: IStreamLoader);
begin
  inherited Create(nil);
  if Assigned(StreamLoader) then
    FWSDLStreamLoader := StreamLoader
  else if Assigned(WSDLItems) then
    FWSDLStreamLoader := WSDLItems.StreamLoader;
  FWSDLLookup := WSDLItems.WSDLLookup;
end;

procedure TWSDLItems.Load(const WSDLFileName: DOMString);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    try
      FWSDLStreamLoader.Load(WSDLFileName, Stream);
      if Stream.Size > 0 then
        LoadFromStream(Stream)
      else
        raise Exception.Create(SEmptyWSDL);
      FileName := WSDLFIleName;
    except
      { DOM exceptions tend to be cryptic }
      on E: Exception do
        raise Exception.CreateFmt(SCantLoadLocation, [WSDLFileName, E.Message]);
    end;
  finally;
    Stream.Free;
  end;
end;

{ Returns whether the WSDL/XML document had a <definition> node }
function HasDefinition(const WSDLDoc: IWSDLDocument): Boolean;
var
  XMLNodeList: IXMLNodeList;
begin
  XMLNodeList := WSDLDoc.ChildNodes;
  Result := (XMLNodeList <> nil) and (XMLNodeList.FindNode(SDefinitions, Wsdlns) <> nil);
end;

function HasDefinition(const WSDLItems: IWSDLItems): Boolean;
begin
  Result := HasDefinition(WSDLItems.GetWSDLDoc);
end;

{ TWSDLItems implementation }

function TWSDLItems.GetWSDLItems: TWSDLItems;
begin
  Result := Self;
end;

function TWSDLItems.GetWSDLDoc: IWSDLDocument;
begin
  Result := Self;
end;

{ Returns the path of the underlying WSDL document }
function TWSDLItems.GetName: DOMString;
begin
  Result := Definition.Name;
end;

function TWSDLItems.GetTargetNamespace: DOMString;
begin
  Result := Definition.GetTargetNamespace;
end;

function TWSDLItems.GetTargetNamespacePrefix: DOMString;
var
  XMLNode: IXMLNode;
begin
  Result := '';
  XMLNode := Definition.FindNamespaceDecl(GetTargetNamespace);
  if XMLNode <> nil then
    Result := ExtractLocalName(XMLNode.NodeName);
end;

function TWSDLItems.CompareName(const NodeName: DOMString;
                                const OtherName: DOMString;
                                const TNS: DOMString): boolean;
var
  LocalName1, LocalName2: DOMString;
  Prefix1, Prefix2: DOMString;
  TNS1, TNS2: DOMString;
begin
  Result := False;
  LocalName1 := ExtractLocalName(NodeName);
  LocalName2 := ExtractLocalName(OtherName);

  { Check local names first }
  if (LocalName1 <> LocalName2) then
    Exit;

  { Extract Prefixes }
  Prefix1 := ExtractPrefix(NodeName);
  Prefix2 := ExtractPrefix(OtherName);

  { Check Prefixes }
  { NOTE: Technically this is not accurate. In cases where there are imports
          similar prefixes don't imply same namespace.... }
  if Prefix1 = Prefix2 then
  begin
    Result := True;
    Exit;
  end;

  { First prefix }
  if (Prefix1 = '') then
    TNS1 := GetTargetNamespace
  else
    TNS1 := Definition.FindNamespaceURI(Prefix1);

  { Second prefix may be overriden }
  if (TNS <> '') then
    TNS2 := TNS
  else
  begin
    if Prefix2 = '' then
      TNS2 := GetTargetNamespace
    else
      TNS2 := Definition.FindNamespaceURI(Prefix2);
  end;

  { Compare actual namespaces }
  Result := SameNamespace(TNS1, TNS2);
end;

function TWSDLItems.MakeTNSName(const Name: DOMString): DOMString;
begin
  Result := MakeNodeName(GetTargetNamespacePrefix, Name)
end;

procedure TWSDLItems.GetServices(ServiceNames: TDOMStrings; QualifiedNames: Boolean = False);

  procedure InternalGetServices(CurrWSDLItems: IWSDLItems; ServiceNames: TDOMStrings;
                                QualifiedNames: Boolean = False);
  var
    I: Integer;
    Services: IServices;
    Service: IService;
  begin
    with CurrWSDLItems.GetWSDLItems do
    begin
      Services := Definition.Services;
      if Services <> nil then
      begin
        for I := 0 to Services.Count-1 do
        begin
          Service := Services[I];
          if QualifiedNames then
          begin
            ServiceNames.Add(MakeTNSName(Service.Name))
          end
          else
            ServiceNames.Add(Service.Name);
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  InternalGetServices(Self, ServiceNames, QualifiedNames);

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
      InternalGetServices(CurrWSDLItems, ServiceNames, QualifiedNames);
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

function TWSDLItems.GetServiceNode(const ServiceName: DOMString): IXMLNode;
var
  Count: Integer;
  Services: IServices;
  ServiceNode: IXMLNode;
begin
  Services := Definition.Services;
  for Count := 0 to Services.Count-1 do
    if (ServiceName = Services[Count].Name) then
    begin
      ServiceNode := Services[Count] as IXMLNode;
      break;
    end;
  Result := ServiceNode;
end;

procedure TWSDLItems.GetPortsForService(const ServiceName: DOMString;
                                        PortNames: TDOMStrings;
                                        SkipHttpBindings: Boolean = True;
                                        QualifiedNames: Boolean = False);

  procedure InternalGetPortsForService(CurrWSDLItems: IWSDLItems;
                                       const ServiceName: DOMString;
                                       PortNames: TDOMStrings;
                                       SkipHttpBindings: Boolean = True;
                                       QualifiedNames: Boolean = False);
  var
    I, Count: Integer;
    Services: IServices;
    Service: IService;
    Ports: IPorts;
    Port: IPort;
    PortName: DOMString;
  begin
    with CurrWSDLItems.GetWSDLItems do
    begin
      Services := Definition.Services;
      if Services <> nil then
      begin
        for Count := 0 to Services.Count -1 do
        begin
          Service := Services[Count];
          if CompareName(Service.Name, ServiceName) then
          begin
            Ports := Service.Ports;
            for I := 0 to Ports.Count-1 do
            begin
              Port := Ports[I];
              PortName := MakeTNSName(Port.Name);

              { Check for HTTP Binding if we're skipping }
              if SkipHttpBindings and
                (GetHttpBindingAttribute(GetBindingForServicePort(ServiceName, PortName), SVerb) <> '') then
                Continue;

              if QualifiedNames then
                PortNames.Add(PortName)
              else
                PortNames.Add(Port.Name);
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  InternalGetPortsForService(Self, ServiceName, PortNames, SkipHttpBindings, QualifiedNames);

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
      InternalGetPortsForService(CurrWSDLItems, ServiceName, PortNames, SkipHttpBindings, QualifiedNames);
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

function TWSDLItems.GetBindingForServicePort(const ServiceName, PortName: DOMString): IQualifiedName;

  function InternalGetBindingForServicePort(CurrWSDLItems: IWSDLItems; const ServiceName, PortName: DOMString): IQualifiedName;
  var
    I, Count: Integer;
    Services: IServices;
    Ports: IPorts;
    Port: IPort;
  begin
    Result := nil;
    with CurrWSDLItems.GetWSDLItems do
    begin
      Services := Definition.Services;
      if Services <> nil then
      begin
        for Count := 0 to Services.Count -1 do
        begin
          if CompareName(Services[Count].Name, ServiceName) then
          begin
            Ports := Services[Count].Ports;
            for I := 0 to Ports.Count-1 do
            begin
              if CompareName(Ports[I].Name, PortName) then
              begin
                Port := Ports[I];
                Result := NewQualifiedName(Port.Binding);
                Exit;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetBindingForServicePort(Self, ServiceName, PortName);

  { Get any imported WSDL }
  if Result = nil then
  begin
    ClearWSDLLookup := False;
    if WSDLLookup.IsEmpty then
    begin
      WSDLLookup.BuildWSDLLookup(Self);
      ClearWSDLLookup := True;
    end;

    ImportList := WSDLLookup.GetWSDLImportList(FileName);
    for I := 0 to ImportList.Count -1 do
    begin
      CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
      if HasDefinition(CurrWSDLItems) then
      begin
        Result := InternalGetBindingForServicePort(CurrWSDLItems, ServiceName, PortName);
        if Result <> nil then
          Exit;
      end;
    end;

    if ClearWSDLLookup then
      WSDLLookup.ClearWSDLLookup;
  end;
end;

function TWSDLItems.GetSoapAddressForServicePort(const ServiceName, PortName: DOMString;
                                                 var SOAPVersion: TSOAPVersion): DOMString;

  function InternalGetSoapAddressForServicePort(CurrWSDLItems: IWSDLItems;
                                                  const ServiceName, PortName: DOMString;
                                                  var SOAPVersion: TSOAPVersion): DOMString;
  var
    I, Count: Integer;
    Services: IServices;
    AddressNode: IXMLNode;
    Ports: IPorts;
    CurrSOAPVersion: TSOAPVersion;
  begin
    Result := '';

    with CurrWSDLItems.GetWSDLItems do
    begin
      Services := Definition.Services;
      if Services <> nil then
      begin
        for Count := 0 to Services.Count -1 do
        begin
          if CompareName(Services[Count].Name, ServiceName) then
          begin
            Ports := Services[Count].Ports;

            if SOAPVersion = svUnspecified then
            begin
    {$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
              for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
    {$ELSE}
              for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
    {$ENDIF}
              begin
                if SOAPWSDLNamespaces[CurrSOAPVersion] = '' then
                  Continue;

                for I := 0 to Ports.Count-1 do
                begin
                  if CompareName(Ports[I].Name, PortName) then
                  begin
                    if Ports[I].HasChildNodes then
                    begin
                      AddressNode := Ports[I].ChildNodes.FindNode(SAddress, SOAPWSDLNamespaces[CurrSOAPVersion]);

                      if AddressNode <> nil then
                      begin
                        Result := AddressNode.Attributes[SLocation];
                        SOAPVersion := CurrSOAPVersion;
                        Exit;
                      end;
                    end;
                  end;
                end;
              end;
            end
            else
            begin
              for I := 0 to Ports.Count-1 do
              begin
                if CompareName(Ports[I].Name, PortName) then
                begin
                  if Ports[I].HasChildNodes then
                  begin
                    AddressNode := Ports[I].ChildNodes.FindNode(SAddress, SOAPWSDLNamespaces[SOAPVersion]);

                    if AddressNode <> nil then
                    begin
                      Result := AddressNode.Attributes[SLocation];
                      Exit;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetSoapAddressForServicePort(Self, ServiceName, PortName, SOAPVersion);
  if Result <> '' then
    Exit;

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
    begin
      Result := InternalGetSoapAddressForServicePort(CurrWSDLItems, ServiceName, PortName, SOAPVersion);
      if Result <> '' then
        Exit;
    end;
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

procedure TWSDLItems.GetMessages(MessageNames: TDOMStrings; QualifiedNames: Boolean);
var
  Count: Integer;
  Messages: IMessages;
  MessageName: DOMString;
begin
  Messages := Definition.Messages;
  for Count:= 0 to  Messages.Count-1 do
  begin
    MessageName := Messages[Count].Name;
    if QualifiedNames then
      MessageNames.Add(MakeTNSName(MessageName))
    else
      MessageNames.Add(MessageName);
  end;
end;

function TWSDLItems.GetMessageNode(const MessageName: DOMString): IXMLNode;
var
 Count: Integer;
 MessageNode: IXMLNode;
 Messages: IMessages;
begin
  Messages := Definition.Messages;
  for Count := 0 to  Messages.Count-1 do
    if CompareName(Messages[Count].Name, MessageName) then
    begin
      MessageNode := Messages[Count] as IXMLNode;
      break;
    end;

  Result := MessageNode;
end;

procedure TWSDLItems.GetParts(const MessageName: DOMString; PartNames: TDOMStrings; QualifiedNames: Boolean);
var
  I, Count: Integer;
  Messages: IMessages;
  Parts: IParts;
  Part: IPart;
begin
  Parts := nil;
  Messages := Definition.Messages;
  for Count := 0 to  Messages.Count-1 do
  begin
    if CompareName(Messages[Count].Name, MessageName) then
    begin
      Parts := Messages[Count].Parts;
      break;
    end;
  end;

  if Parts <> nil then
    for I := 0 to Parts.Count -1 do
    begin
      Part := Parts[I];
      if QualifiedNames then
        PartNames.Add(MakeTNSName(Part.Name))
      else
        PartNames.Add(Part.Name);
    end;
end;


function TWSDLItems.GetPartNode(const MessageName, PartName: DOMString): IXMLNode;
var
  I, Count: Integer;
  Messages: IMessages;
  Parts: IParts;
begin
  Result := nil;
  Parts := nil;

  Messages := Definition.Messages;
  for Count := 0 to Messages.Count-1 do
    if CompareName(Messages[Count].Name, MessageName) then
    begin
      Parts := Messages[Count].Parts;
      break;
    end;

  if Parts <> nil then
  begin
    for I := 0 to Parts.Count -1 do
    begin
      if CompareName(Parts[I].Name, PartName) then
      begin
        Result := Parts[I] as IXMLNode;
        Exit;
      end;
    end;
  end;
end;

function  TWSDLItems.IsPortTypeHTTPBound(const PortType: DOMString): Boolean;
var
  Bindings: IQualifiedNameArray;
  I: Integer;
begin
  Result := False;
  Bindings := GetBindingOfType(PortType, TargetNamespace);
  for I := 0 to Length(Bindings)-1 do
  begin
    if GetHttpBindingAttribute(Bindings[I], SVerb) <> '' then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TWSDLItems.GetPortTypes(PortTypeNames: TDOMStrings; SkipHttpBindings: Boolean;
                                  QualifiedNames: Boolean);

  procedure InternalGetPortTypes(CurrWSDLItems: IWSDLItems; PortTypeNames: TDOMStrings;
                                 SkipHttpBindings: Boolean; QualifiedNames: Boolean);
  var
    I: Integer;
    PortTypes: IPortTypes;
    PortTypeName: string;
  begin
    with CurrWSDLItems.GetWSDLItems do
    begin
      PortTypes := Definition.PortTypes;
      for I := 0 to PortTypes.Count-1 do
      begin
        PortTypeName:= PortTypes[I].Name;
        if SkipHttpBindings and IsPortTypeHTTPBound(PortTypeName) then
          Continue;

        if QualifiedNames then
          PortTypeNames.Add(MakeTNSName(PortTypeName))
        else
          PortTypeNames.Add(PortTypeName);
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  InternalGetPortTypes(Self, PortTypeNames, SkipHttpBindings, QualifiedNames);

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
      InternalGetPortTypes(CurrWSDLItems, PortTypeNames, SkipHttpBindings, QualifiedNames);
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

function TWSDLItems.GetPortTypeNode(const PortTypeName: DOMString): IXMLNode;
var
  Count: Integer;
  PortTypes: IPortTypes;
begin
  Result := nil;
  PortTypes := Definition.PortTypes;
  for Count := 0 to PortTypes.Count-1 do
    if CompareName(PortTypes[Count].Name, PortTypeName) then
    begin
      Result := PortTypes[Count] as IXMLNode;
      Exit;
    end;
end;

procedure TWSDLItems.GetOperations(const PortTypeName: DOMString; OperationNames: TDOMStrings; QualifiedNames: Boolean);
var
  I, Count: Integer;
  PortTypes: IPortTypes;
  Operations: IOperations;
  Operation: IOperation;
begin
  PortTypes := Definition.PortTypes;

  for Count:= 0 to PortTypes.Count-1 do
    if CompareName(PortTypes[Count].Name, PortTypeName) then
    begin
      Operations := PortTypes[Count].Operations;
      break;
    end;

  if Operations <> nil then
  begin
    for I:=0 to Operations.Count -1 do
    begin
      Operation := Operations[I];
      if QualifiedNames then
        OperationNames.Add(MakeTNSName(Operation.Name))
      else
        OperationNames.Add(Operation.Name);
    end;
  end;
end;

function TWSDLItems.GetOperationNode(const PortTypeName, OperationName: DOMString): IXMLNode;
var
  I, Count: Integer;
  PortTypes: IPortTypes;
  Operations: IOperations;
begin
  Operations := nil;
  PortTypes := Definition.PortTypes;

  for Count:= 0 to PortTypes.Count-1 do
    if CompareName(PortTypes[Count].Name, PortTypeName) then
    begin
      Operations := PortTypes[Count].Operations;
      break;
    end;

  if Operations <> nil then
  begin
    for I:=0 to Operations.Count -1 do
    begin
      if CompareName(Operations[I].Name, OperationName) then
      begin
        Result := Operations[I] as IXMLNode;
        Exit;
      end;
    end;
  end;
end;

function TWSDLItems.GetPartsForOperation(const PortTypeName, OperationName: DOMString; OperationIndex: Integer; PartNames: TDOMStrings): Boolean;

  function InternalGetPartsForOperation(CurrWSDLItems: IWSDLItems;
                                        const PortTypeName, OperationName: DOMString;
                                        OperationIndex: Integer; PartNames: TDOMStrings): Boolean;
  var
    I: Integer;
    PortTypes: IPortTypes;
    Operations: IOperations;
  begin
    Result := False;

    with CurrWSDLItems.GetWSDLItems do
    begin
      PortTypes := Definition.PortTypes;
      for I := 0 to PortTypes.Count-1 do
      begin
        if CompareName(PortTypes[I].Name, PortTypeName) then
        begin
          Operations := PortTypes[I].Operations;
          Break;
        end;
      end;

      if Assigned(Operations) then
      begin
        for I := 0 to Operations.Count-1 do
        begin
          if CompareName(Operations[I].Name, OperationName) and (OperationIndex = I) then
          begin
            if (Operations[I].Input.Message <> '') then
            begin
              GetParts(Operations[I].Input.Message, PartNames);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetPartsForOperation(Self, PortTypeName, OperationName, OperationIndex, PartNames);
  if Result then
    Exit;

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count-1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
    begin
      Result := InternalGetPartsForOperation(CurrWSDLItems, PortTypeName, OperationName, OperationIndex, PartNames);
      if Result then
        Exit;
    end;
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;


procedure TWSDLItems.GetImports(ImportNames: TDOMStrings);
var
  Count: Integer;
  Imports: IImports;
begin
  Imports := Definition.Imports;
  for Count := 0 to Imports.Count -1 do
    ImportNames.Add(Imports[Count].Namespace);
end;

procedure TWSDLItems.IterateImports(IterateProc: TWSDLIterateProc);
var
  I: Integer;
  ImportedWSDLItems: IWSDLItems;
  SchemaDoc: IXMLSchemaDoc;
  Stream: TMemoryStream;
  ImportedLocation: string;
  ImportList: TList<string>;
begin
  if WSDLLookup.IsEmpty then
    WSDLLookup.BuildWSDLLookup(Self, IterateProc);

  ImportList := WSDLLookup.GetWSDLImportList('');
  for I := 0 to ImportList.Count-1 do
  begin
    ImportedLocation := ImportList[I];
    ImportedWSDLItems := WSDLLookup.GetWSDLItems(ImportedLocation);
    if ImportedWSDLItems <> nil then
    begin
      IterateProc(ioLoaded, ImportedWSDLItems, nil, ImportedLocation);
    end
    else
    begin
      Stream := TMemoryStream.Create;
      try
        StreamLoader.Load(ImportedLocation, Stream);
        SchemaDoc := TXMLSchemaDoc.Create(nil);
        SchemaDoc.LoadFromStream(Stream);
        SchemaDoc.Active := True;
        SchemaDoc.FileName := ImportedLocation;
        IterateProc(ioLoaded, nil, SchemaDoc, ImportedLocation);
      finally
        Stream.Free;
      end;
    end;
  end;
end;

function TWSDLItems.GetLocationForImport(const ImportNameSpace: DOMString): DOMString;
var
  Count: Integer;
  Location: DOMString;
  Imports: IImports;
begin
  Imports := Definition.Imports;
  for Count := 0 to Imports.Count -1 do
    if (ImportNameSpace = Imports[Count].Namespace) then
    begin
      Location := Imports[Count].Location;
      break;
    end;

  Result := Location;
end;

procedure TWSDLItems.GetBindings(BindingNames: TDOMStrings; QualifiedNames: Boolean);
var
  Count: Integer;
  Bindings: IBindings;
  Binding: IBinding;
begin
  Bindings := Definition.Bindings;
  for Count := 0 to Bindings.Count -1 do
  begin
    Binding := Bindings[Count];
    if QualifiedNames then
      BindingNames.Add(MakeTNSName(Binding.Name))
    else
      BindingNames.Add(Binding.Name);
  end;
end;

function TWSDLItems.GetServiceAndPortOfBinding(const BindingName: IQualifiedName;
                                               var ServiceName: DOMString;
                                               var PortName: DOMString): Boolean;

  function InternalGetServiceAndPortOfBinding(CurrWSDLItems: IWSDLItems;
                                              const BindingName: IQualifiedName;
                                              var ServiceName: DOMString;
                                              var PortName: DOMString): Boolean;
  var
    Count, I: Integer;
    Services: IServices;
    Ports: IPorts;
    Service: IService;
    Port: IPort;
  begin
    Result := False;
    with CurrWSDLItems.GetWSDLItems do
    begin
      Services := Definition.Services;
      if Services <> nil then
      begin
        for Count := 0 to Services.Count -1 do
        begin
          Service := Services[Count];
          Ports := Service.Ports;
          for I := 0 to Ports.Count-1 do
          begin
            Port := Ports[I];
            if CompareName(Port.Binding, BindingName.Name, BindingName.Namespace) then
            begin
              ServiceName := Service.Name;
              PortName := Port.Name;
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetServiceAndPortOfBinding(Self, BindingName, ServiceName, PortName);
  if Result then
    Exit;

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
    begin
      Result := InternalGetServiceAndPortOfBinding(CurrWSDLItems, BindingName, ServiceName, PortName);
      if Result then
        Exit;
    end;
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

{ Returns PortType that maps to the specified Binding }
function TWSDLItems.GetBindingType(const BindingName: DOMString): DOMString;
var
  Count: Integer;
  BindingTypeName: DOMString;
  Bindings: IBindings;
begin
  Bindings := Definition.Bindings;
  for Count := 0 to Bindings.Count -1 do
    if CompareName(Bindings[Count].Name, BindingName) then
    begin
      BindingTypeName := Bindings[Count].Type_;
      break;
    end;
  Result := BindingTypeName;
end;

procedure TWSDLItems.GetBindingOfType(const BindingTypeName: DOMString;
                                      const TNS: DOMString;
                                      var BindingArray: IQualifiedNameArray);

  function InArray(const Name, NS: DOMString): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Length(BindingArray)-1 do
      if (BindingArray[I].Name = Name) and
         (BindingArray[I].Namespace = NS) then
      begin
        Result := True;
        Exit;
      end;
  end;

  procedure InternalGetBindingOfType(CurrWSDLItems: IWSDLItems;
                                     const BindingTypeName, TNS: DOMString;
                                     var BindingArray: IQualifiedNameArray);
  var
    I, Len: Integer;
    Bindings: IBindings;
    Binding: IBinding;
    BindingName, NS: DOMString;
  begin
    with CurrWSDLItems.GetWSDLItems do
    begin
      Bindings := Definition.Bindings;
      for I := 0 to Bindings.Count -1 do
      begin
        Binding := Bindings[I];
        if CompareName(Binding.Type_, BindingTypeName, TNS) then
        begin
          BindingName := Binding.Name;
          NS := TargetNamespace;
          if not InArray(BindingName, NS) then
          begin
            Len := Length(BindingArray);
            SetLength(BindingArray, Len+1);
            BindingArray[Len] := NewQualifiedName(BindingName, NS);
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  CurrWSDLItems: IWSDLItems;
  NS: DOMString;
  ImportList: TList<string>;
  ClearWSDLLookup: Boolean;
begin
  InternalGetBindingOfType(Self, BindingTypeName, TNS, BindingArray);

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count - 1 do
  begin
    { Keep namespace for comparisons }
    if TNS = '' then
      NS := TargetNamespace
    else
      NS := TNS;

    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if Assigned(CurrWSDLItems) then
      InternalGetBindingOfType(CurrWSDLItems, BindingTypeName, NS, BindingArray);
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

{ Returns the Binding whose type="xxx" attribute value corresponds to the specified name (i.e. a PortType name) }
function TWSDLItems.GetBindingOfType(const BindingTypeName: DOMString;
                                     const TNS: DOMString): IQualifiedNameArray;
begin
  SetLength(Result, 0);
  GetBindingOfType(BindingTypeName, TNS, Result);
end;

function  TWSDLItems.GetGenericBindingAttribute(const BindingName: DOMString;
                                                const NodeName: DOMString;
                                                const Namespace: DOMString;
                                                Attribute: DOMString): DOMString;
var
  I,Count: Integer;
  Bindings: IBindings;
  Node: IXMLNode;
  XMLNodeList: IXMLNodeList;
begin
  Result := '';
  Bindings := Definition.Bindings;
  for Count := 0 to Bindings.Count -1 do
  begin
    if CompareName(Bindings[Count].Name, BindingName) then
    begin
      if Bindings[Count].HasChildNodes then
      begin
        for I := 0 to Bindings[Count].ChildNodes.Count -1 do
        begin
          XMLNodeList := Bindings[Count].ChildNodes;
          Node := XMLNodeList.FindNode(NodeName, Namespace);
          if Node <> nil then
          begin
            if Node.HasAttribute(Attribute) then
            begin
              Result := Node.GetAttribute(Attribute);
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{ Retrieve <soap:binding attribute=xxxxx> values - For example, the 'transport' }
{ - 'http://schemas.xmlsoap.org/soap/http' - or the style ( 'rpc' vs. 'document'}
function TWSDLItems.GetSoapBindingAttribute(const BindingName: DOMString; Attribute: DOMString;
  var SOAPVersion: TSOAPVersion): DOMString;
var
  CurrSOAPVersion: TSOAPVersion;
begin
  if SOAPVersion = svUnspecified then
  begin
{$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
    for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
{$ELSE}
    for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
{$ENDIF}
    begin
      if SOAPWSDLNamespaces[CurrSOAPVersion] = '' then
        Continue;

      Result := GetGenericBindingAttribute(BindingName, SBinding,
                                           SOAPWSDLNamespaces[CurrSOAPVersion], Attribute);
      if Result <> '' then
      begin
        SOAPVersion := CurrSOAPVersion;
        Break;
      end;
    end;
  end
  else
    Result := GetGenericBindingAttribute(BindingName, SBinding, SOAPWSDLNamespaces[SOAPVersion], Attribute);
end;

{ Retrieve <http:binding attribute=xxxx> values - For example, 'verb' (GET or POST }
function TWSDLItems.GetHttpBindingAttribute(const BindingName: DOMString; Attribute: DOMString): DOMString;
begin
  Result := GetGenericBindingAttribute(BindingName, SBinding, Httpns, Attribute);
end;

function TWSDLItems.GetHttpBindingAttribute(const QualifiedName: IQualifiedName; Attribute: DOMString): DOMString;
begin
  Result := '';
  if QualifiedName <> nil then
    Result := GetHttpBindingAttribute(QualifiedName.Name, Attribute);
end;

procedure TWSDLItems.GetOperationsForBinding(const BindingName: DOMString;
                                             OperationNames: TDOMStrings;
                                             QualifiedNames: Boolean);
var
  I,Count: Integer;
  Bindings: IBindings;
  BindOperations: IBindingOperations;
  BindOperation: IBindingOperation;
begin
  Bindings := Definition.Bindings;
  for Count := 0 to Bindings.Count -1 do
  begin
    if CompareName(Bindings[Count].Name, BindingName) then
    begin
      BindOperations := Bindings[Count].BindingOperations;
      for I := 0 to BindOperations.Count -1 do
      begin
        BindOperation := BindOperations[I];
        if QualifiedNames then
          OperationNames.Add(MakeTNSName(BindOperation.Name))
        else
          OperationNames.Add(BindOperation.Name);
      end;
      Break;
    end;
  end;
end;

function TWSDLItems.GetBindingOperationNode(const BindingName, Operation: DOMString;
                                            OverloadIndex: Integer;
                                            out ResultsWSDLItems: IWSDLItems): IBindingOperation;

  function InternalGetBindingOperationNode(CurrWSDLItems: IWSDLItems;
                                           const BindingName, Operation: DOMString;
                                           OverloadIndex: Integer;
                                           out ResultsWSDLItems: IWSDLItems): IBindingOperation;
  var
    Count, OverloadCount, I: Integer;
    Bindings: IBindings;
    BindOperations: IBindingOperations;
  begin
    Result := nil;
    with CurrWSDLItems.GetWSDLItems do
    begin
      Bindings := Definition.Bindings;

      OverloadCount := OverloadIndex;
      for Count := 0 to Bindings.Count -1 do
      begin
        if CompareName(Bindings[Count].Name, BindingName) then
        begin
          BindOperations := Bindings[Count].BindingOperations;
          for I := 0 to BindOperations.Count -1 do
          begin
            if CompareName(BindOperations[I].Name, Operation) then
            begin
              if OverloadCount > 0 then
                Dec(OverloadCount)
              else
              begin
                Result := BindOperations[I];
                Exit;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  Options: TXMLDocOptions;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetBindingOperationNode(Self, BindingName, Operation, OverloadIndex, ResultsWSDLItems);
  if Result <> nil then
  begin
    ResultsWSDLItems := Self;
    Exit;
  end;

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    Options := CurrWSDLItems.GetWSDLDoc.Options;
    CurrWSDLItems.GetWSDLDoc.Options := Options - [doNodeAutoCreate];
    try
      if HasDefinition(CurrWSDLItems) then
      begin
        Result := InternalGetBindingOperationNode(CurrWSDLItems, BindingName, Operation, OverloadIndex, ResultsWSDLItems);
        if Result <> nil then
        begin
          ResultsWSDLItems := CurrWSDLItems;
          Exit;
        end;
      end;
    finally
      CurrWSDLItems.GetWSDLDoc.Options := Options + [doNodeAutoCreate];
    end;
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

function TWSDLItems.GetSoapOperationAttribute(const BindingName, Operation, Attribute: DOMString;
  OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
var
  BindingNode, SoapOperationNode: IXMLNode;
  BindingNodeWSDLItems: IWSDLItems;
  XMLNodeList: IXMLNodeList;
  CurrSOAPVersion: TSOAPVersion;
begin
  Result := '';
  BindingNode := GetBindingOperationNode(BindingName, Operation, OverloadIndex, BindingNodeWSDLItems);
  try
    if (BindingNode <> nil) and (BindingNode.HasChildNodes) then
    begin
      XMLNodeList := BindingNode.ChildNodes;
      if XMLNodeList <> nil then
      begin
        if SOAPVersion = svUnspecified then
        begin
{$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
          for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
{$ELSE}
          for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
{$ENDIF}
          begin
            if SOAPWSDLNamespaces[CurrSOAPVersion] = '' then
              Continue;

            SoapOperationNode := XMLNodeList.FindNode(SOperation, SOAPWSDLNamespaces[CurrSOAPVersion]);
            if SoapOperationNode <> nil then
            begin
              SOAPVersion := CurrSOAPVersion;
              Break;
            end;
          end;
        end
        else
          SoapOperationNode := XMLNodeList.FindNode(SOperation, SOAPWSDLNamespaces[SOAPVersion]);

        if SoapOperationNode <> nil then
        begin
          if SoapOperationNode.HasAttribute(Attribute) then
            Result := SoapOperationNode.Attributes[Attribute];
        end;
      end;
    end;
  finally
    BindingNodeWSDLItems := nil;
  end;
end;

{ Returns the value of the 'soapAction' attribute for the specified Binding/Operation }
function TWSDLItems.GetSoapAction(const BindingName, Operation: DOMString; OverloadIndex: Integer;
  var SOAPVersion: TSOAPVersion): DOMString;
begin
  Result := GetSoapOperationAttribute(BindingName, Operation, SSoapAction, OverloadIndex, SOAPVersion);
end;

{ Returns  the value of the style="xxxx" attribute of the <soap:operation ..> node
  for the specified Binding/Operation combination }
function TWSDLItems.GetSoapOperationStyle(const BindingName, Operation: DOMString; OverloadIndex: Integer;
  var SOAPVersion: TSOAPVersion): DOMString;
begin
  Result := GetSoapOperationAttribute(BindingName, Operation, SStyle, OverloadIndex, SOAPVersion);
end;

procedure TWSDLItems.GetSoapActionList(const BindingName: DOMString; ActionList: TDOMStrings;
  QualifiedNames: Boolean; var SOAPVersion: TSOAPVersion);
var
  Operations: TDOMStrings;
  I: Integer;
  Operation: DOMString;
begin
  Operations := TDOMStrings.Create;
  try
    GetOperationsForBinding(BindingName, Operations, QualifiedNames);
    for I := 0 to (Operations.Count-1) do
    begin
      Operation := Operations.Strings[I];
      ActionList.Add(Operation + '=' + GetSoapAction(BindingName, Operation, 0, SOAPVersion));
    end;
  finally
    Operations.Free;
  end;
end;

function  TWSDLItems.GetSoapBodyInputAttribute(const BindingName, Operation, Attribute: DOMString;
  OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
begin
  Result := GetSoapBodyAttribute(BindingName, Operation, SInput, Attribute, OverloadIndex, SOAPVersion);
end;

function  TWSDLItems.GetSoapBodyOutputAttribute(const BindingName, Operation, Attribute: DOMString;
  OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
begin
  Result := GetSoapBodyAttribute(BindingName, Operation, SOutput, Attribute, OverloadIndex, SOAPVersion);
end;

function TWSDLItems.GetSoapBodyAttribute(const BindingName, Operation, IOType, Attribute: DOMString;
  OverloadIndex: Integer; var SOAPVersion: TSOAPVersion): DOMString;
var
  IONode, SoapBodyNode: IXMLNode;
  IONodeWSDLItems: IWSDLItems;
  XMLNodeList: IXMLNodeList;
  CurrSOAPVersion: TSOAPVersion;
begin
  IONode := GetSoapBindingIONode(BindingName, Operation, SameText(IOType, SInput), OverloadIndex, IONodeWSDLItems);
  try
    if (IONode <> nil) and (IONode.HasChildNodes) then
    begin
      XMLNodeList := IONode.ChildNodes;

      if SOAPVersion = svUnspecified then
      begin
{$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
        for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
{$ELSE}
        for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
{$ENDIF}
        begin
          if SOAPWSDLNamespaces[CurrSOAPVersion] = '' then
            Continue;

          SoapBodyNode := XMLNodeList.FindNode(SBody, SOAPWSDLNamespaces[CurrSOAPVersion]);
          if SoapBodyNode <> nil then
          begin
            SOAPVersion := CurrSOAPVersion;
            Break;
          end;
        end;
      end
      else
        SoapBodyNode := XMLNodeList.FindNode(SBody, SOAPWSDLNamespaces[SOAPVersion]);

      if SoapBodyNode <> nil then
      begin
        if SoapBodyNode.HasAttribute(Attribute) then
        begin
          Result := SoapBodyNode.Attributes[Attribute];
          Exit;
        end;
      end;
    end;
  finally
    IONodeWSDLItems := nil
  end;
end;

function TWSDLItems.GetSoapBindingIONode(const BindingName, Operation: DOMString;
                                         Input: Boolean;
                                         OverloadIndex: Integer;
                                         out ResultsWSDLItems: IWSDLItems): IXMLNode;
var
  BindingNode: IBindingOperation;
  BindingNodeWSDLItems: IWSDLItems;
begin
  Result := nil;
  BindingNode := GetBindingOperationNode(BindingName, Operation, OverloadIndex, BindingNodeWSDLItems);
  try
    if (BindingNode <> nil) and (BindingNode.HasChildNodes) then
    begin
      if Input then
        Result := BindingNode.Input
      else
        Result := BindingNode.Output;
      ResultsWSDLItems := BindingNodeWSDLItems;
    end;
  finally
    BindingNodeWSDLItems := nil;
  end;
end;

function TWSDLItems.GetSoapBindingInputNode(const BindingName, Operation: DOMString;
                                            OverloadIndex: Integer;
                                            out ResultsWSDLItems: IWSDLItems): IXMLNode;
begin
  Result := GetSoapBindingIONode(BindingName, Operation, True, OverloadIndex, ResultsWSDLItems);
end;

function TWSDLItems.GetSoapBindingOutputNode(const BindingName, Operation: DOMString;
                                             OverloadIndex: Integer;
                                             out ResultsWSDLItems: IWSDLItems): IXMLNode;
begin
  Result := GetSoapBindingIONode(BindingName, Operation, False, OverloadIndex, ResultsWSDLItems);
end;

function TWSDLItems.GetSoapBodyNamespace(const BindingPortType: DOMString;
  var SOAPVersion: TSOAPVersion): DOMString;

  function FindSoapBodyNamespace(const Node: IXMLNode; var SOAPVersion: TSOAPVersion): DOMString;
  var
    SoapBodyNode: IXMLNode;
    CurrSOAPVersion: TSOAPVersion;
  begin
    Result := '';
    if Node.HasChildNodes then
    begin
      if SOAPVersion = svUnspecified then
      begin
{$IFDEF SOAP12_PRECEDENCE_OVER_SOAP11}
        for CurrSOAPVersion := High(TSOAPVersion) downto Low(TSOAPVersion) do
{$ELSE}
        for CurrSOAPVersion := Low(TSOAPVersion) to High(TSOAPVersion) do
{$ENDIF}
        begin
          if SOAPWSDLNamespaces[CurrSOAPVersion] = '' then
            Continue;

          SoapBodyNode := Node.ChildNodes.FindNode(SBody, SOAPWSDLNamespaces[CurrSOAPVersion]);
          if Result <> '' then
          begin
            SOAPVersion := CurrSOAPVersion;
            Break;
          end;
        end;
      end
      else
        SoapBodyNode := Node.ChildNodes.FindNode(SBody, SOAPWSDLNamespaces[SOAPVersion]);

      if Assigned(SoapBodyNode) and SoapBodyNode.HasAttribute(SNamespace) then
         Result := SoapBodyNode.Attributes[SNamespace];
    end;
  end;

  function InternalGetSoapBodyNamespace(CurrWSDLItems: IWSDLItems;
                                        const BindingPortType: DOMString;
                                        var SOAPVersion: TSOAPVersion): DOMString;
  var
    Count, I: Integer;
    Bindings: IBindings;
    BindOperations: IBindingOperations;
  begin
    Result := '';
    with CurrWSDLItems.GetWSDLItems do
    begin
      Bindings := Definition.Bindings;
      for Count := 0 to Bindings.Count -1 do
      begin
        if CompareName(BindingPortType, Bindings[Count].Type_) then
        begin
          BindOperations := Bindings[Count].BindingOperations;
          for I := 0 to BindOperations.Count -1 do
          begin
            Result := FindSoapBodyNamespace(BindOperations[I].Input, SOAPVersion);
            if Result <> '' then
              Exit;
            Result := FindSoapBodyNamespace(BindOperations[I].Output, SOAPVersion);
            if Result <> '' then
              Exit;
          end;
          Break;
        end;
      end;
    end;
  end;

var
  I: Integer;
  ImportList: TList<string>;
  CurrWSDLItems: IWSDLItems;
  ClearWSDLLookup: Boolean;
begin
  Result := InternalGetSoapBodyNamespace(Self, BindingPortType, SOAPVersion);
  if Result <> '' then
    Exit;

  { Get any imported WSDL }
  ClearWSDLLookup := False;
  if WSDLLookup.IsEmpty then
  begin
    WSDLLookup.BuildWSDLLookup(Self);
    ClearWSDLLookup := True;
  end;

  ImportList := WSDLLookup.GetWSDLImportList(FileName);
  for I := 0 to ImportList.Count -1 do
  begin
    CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[I]);
    if HasDefinition(CurrWSDLItems) then
    begin
      Result := InternalGetSoapBodyNamespace(CurrWSDLItems, BindingPortType, SOAPVersion);
      if Result <> '' then
        Exit;
    end;
  end;

  if ClearWSDLLookup then
    WSDLLookup.ClearWSDLLookup;
end;

function TWSDLItems.HasTypesNode: Boolean;
begin
  Result := False;
  if (Definition.Types <> nil) then
    Result := True;
end;

procedure TWSDLItems.GetSchemas(SchemaNames: TDOMStrings);
var
  Types: ITypes;
  Tns: DOMString;
  Index: Integer;
begin
  Types := Definition.Types;
  if (Types <> nil) and (Types.SchemaDefs.Count > 0) then
  begin
    for Index := 0 to Types.SchemaDefs.Count - 1 do
    begin
      Tns := Types.SchemaDefs[Index].Attributes[sTns];
      SchemaNames.Add(Tns);
    end;
  end;

end;

function TWSDLItems.GetSchemaNode(const SchemaTns: DOMString) : IXMLNode;
var
  Index: Integer;
  Types: ITypes;
  SchemaRootNode: IXMLNode;
begin
  Types := Definition.Types;
  if (Types <> nil) and (Types.SchemaDefs.Count > 0) then
  begin
    for Index := 0 to Types.SchemaDefs.Count - 1 do
    begin
      if ( SchemaTns = Types.SchemaDefs[Index].Attributes[sTns] ) then
      begin
        SchemaRootNode := Types.SchemaDefs[Index] as IXMLNode;
        break;
      end;
    end;
  end;
  Result := SchemaRootNode;
end;

function TWSDLItems.GetSoapHeaders(BindingName: IQualifiedName; const Operation: DOMString;
                                   Input: Boolean; OverloadIndex: Integer; const MessageName: DOMString;
                                   var SOAPVersion: TSOAPVersion; out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;

  function FindPartAndName(AMsgName: DOMString;
                           AMsgNS: DOMString;
                           APartName: DOMString;
                           AWSDLItems: TWSDLItems;
                           var HeaderInfo: IHeaderInfo): Boolean;
  var
    AMessage: IMessage;
    Messages: IMessages;
    Parts: IParts;
    Part: IPart;
    I, J: Integer;
  begin
    Messages := AWSDLItems.Definition.Messages;
    for I := 0 to Messages.Count -1 do
    begin
      AMessage := Messages[I];
      if AWSDLItems.CompareName(AMessage.Name, AMsgName, AMsgNS) then
      begin
        Parts := Messages[I].Parts;
        for J := 0 to Parts.Count -1 do
        begin
          Part := Parts[J];
          if Part.Name = APartName then
          begin
            HeaderInfo.Part := Part;
            HeaderInfo.Name := Part.Name;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
    Result := False;
  end;

var
  I, J, HeaderLen: Integer;
  IONode, Node: IXMLNode;
  IONodeWSDLItems, CurrWSDLItems: IWSDLItems;
  XMLNodeList: IXMLNodeList;
  Msg, Prt, Attr: DOMString;
  ImportList: TList<string>;
begin
  SetLength(Result, 0);
  IONode := GetSoapBindingIONode(BindingName.Name, Operation, Input, OverloadIndex, IONodeWSDLItems);
  try
    if (IONode <> nil) and (IONode.HasChildNodes) then
    begin
      XMLNodeList := IONode.ChildNodes;
      for I := 0 to XMLNodeList.Count-1 do
      begin
        Node := XMLNodeList[I];
        if SameText(ExtractLocalName(Node.NodeName), SHeader) and
           SameText(Node.NamespaceURI, SOAPWSDLNamespaces[SOAPVersion]) then
        begin
          if Node.HasAttribute(SMessage) and
             Node.HasAttribute(SPart) then
          begin
            HeaderLen := Length(Result);
            SetLength(Result, HeaderLen+1);
            Result[HeaderLen] := NewHeaderInfo;
            ResultsWSDLItems := IONodeWSDLItems;

            { Message/Part }
            Msg := Node.Attributes[SMessage];
            Prt:= Node.Attributes[SPart];

            { Name }
            Result[HeaderLen].Name := Prt;

            { Required ?? }
            if Node.HasAttribute(SRequired, Wsdlns) then
            begin
              Attr := Node.GetAttributeNS(SRequired, Wsdlns);
              Result[HeaderLen].Required := SameText(Attr, 'true') or SameText(Attr, '1');
            end;

            { Namespace }
            if Node.HasAttribute(SNamespace) then
              Result[HeaderLen].Namespace := Node.Attributes[SNamespace];

            { Use }
            if Node.HasAttribute(SUse) then
              Result[HeaderLen].Use := Node.Attributes[SUse];

            { Encoding }
            if Node.HasAttribute(SEncodingStyle) then
              Result[HeaderLen].EncodingStyle := Node.Attributes[SEncodingStyle];

            { Namespace of Message }
            Attr := '';
            if IsPrefixed(Msg) and HasDefinition(ResultsWSDLItems) then
            begin
              Attr := ExtractPrefix(Msg);
              Attr := ResultsWSDLItems.GetWSDLItems.Definition.FindNamespaceURI(Attr);
            end;

            { First look for the Message in the WSDL were we found the bindings }
            if not FindPartAndName(Msg, Attr, Prt,
                                   ResultsWSDLItems.GetWSDLItems,
                                   Result[HeaderLen]) then
            begin
              ImportList := WSDLLookup.GetWSDLImportList(FileName);
              for J := 0 to ImportList.Count -1 do
              begin
                CurrWSDLItems := WSDLLookup.GetWSDLItems(ImportList[J]);
                if FindPartAndName(Msg, Attr, Prt,
                                   CurrWSDLItems.GetWSDLItems,
                                   Result[HeaderLen]) then
                  Break;
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    IONodeWSDLItems := nil;
  end;
end;

function TWSDLItems.GetSoapInputHeaders(BindingName: IQualifiedName; const Operation: DOMString;
                                        OverloadIndex: Integer; const MessageName: DOMString;
                                        var SOAPVersion: TSOAPVersion;
                                        out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;
begin
  Result := GetSoapHeaders(BindingName, Operation, True, OverloadIndex, MessageName, SOAPVersion, ResultsWSDLItems);
end;

function TWSDLItems.GetSoapOutputHeaders(BindingName: IQualifiedName; const Operation: DOMString;
                                         OverloadIndex: Integer; const MessageName: DOMString;
                                         var SOAPVersion: TSOAPVersion;
                                         out ResultsWSDLItems: IWSDLItems): IHeaderInfoArray;
begin
  Result := GetSoapHeaders(BindingName, Operation, False, OverloadIndex, MessageName, SOAPVersion, ResultsWSDLItems);
end;

{ THeaderInfo }

function THeaderInfo.GetEncodingStyle: DOMString;
begin
  Result := FEncodingStyle;
end;

function THeaderInfo.GetName: DOMString;
begin
  Result := FName;
end;

function THeaderInfo.GetNamespace: DOMString;
begin
  Result := FNamespace;
end;

function THeaderInfo.GetPart: IPart;
begin
  Result := FPart;
end;

function THeaderInfo.GetRequired: Boolean;
begin
  Result := FRequired;
end;

function THeaderInfo.GetUse: DOMString;
begin
  Result := FUse;
end;

procedure THeaderInfo.SetEncodingStyle(const EncStyl: DOMString);
begin
  FEncodingStyle := EncStyl;
end;

procedure THeaderInfo.SetName(const N: DOMString);
begin
  FName := N;
end;

procedure THeaderInfo.SetNamespace(const N: DOMString);
begin
  FNamespace := N;
end;

procedure THeaderInfo.SetPart(const P: IPart);
begin
  FPart := P;
end;

procedure THeaderInfo.SetRequired(Req: Boolean);
begin
  FRequired := Req;
end;

procedure THeaderInfo.SetUse(const U: DOMString);
begin
  FUse := U;
end;

end.
