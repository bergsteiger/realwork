{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit XMLSchemaHelper;

interface

{$DEFINE SAFE_TYPE_ACCESS}
{$DEFINE SAFE_DATATYPE_ACCESS}

uses XMLIntf, XMLDoc, xmldom, XmlSchema, WSDLModelIntf
{$IFDEF VISITOR_CONTEXT_TTREENODE}
, ComCtrls
{$ENDIF}
;

type

{$IFDEF VISITOR_CONTEXT_TTREENODE}
  XMLVisitorContext = TTreeNode;
{$ELSE}
  XMLVisitorContext = IWSDLType;
{$ENDIF}

  { Similar to TCompositorType but caters for global elements }
  TElementType = (etGlobal, etAll, etChoice, etSequence, etElementGroup);
  TElementTypes = set of TElementType;


  { To be implemented by class that wants to traverse elements of a schema }
  IXMLSchemaVisitor = interface
  ['{BA640BF8-8364-49FF-829E-81B74A3394F9}']
    function Start(const SchemaDef: IXMLSchemaDef; const SchemaLoc: String): XMLVisitorContext;
    function Visit(const Item: IXMLAttributeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLElementDef; const ElementTypes: TElementTypes;
                   const CompositorId: Integer;
                   const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLSimpleTypeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLComplexTypeDef; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLAttributeGroup; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Visit(const Item: IXMLElementGroup; const Context: XMLVisitorContext): XMLVisitorContext; overload;
    function VisitAny(const Item: IXMLNode; const Context: XMLVisitorContext): XMLVisitorContext;
    procedure Skipping(const SchemaLoc: String);
    procedure Done(const SchemaLoc: String);
    procedure Error(const SchemaLoc: String; const Msg: String);
  end;

  { Tour guide that takes visitor to each element of a schema }
  IXMLSchemaGuide = interface
  ['{B8037BC1-EAC0-45D6-B6B2-207AC2D347B9}']
    procedure ShowSchema(const SchemaDef: IXMLSchemaDef; const SchemaLoc: String;
                         const Tracker: IProcessedTracker;
                         const OuterTNS: DOMString);
  end;

  ArrayOfXMLNode = array of IXMLNode;


  TDataTypeTie = (dtUnknown, dtRef, dtType);

{ Method to visit every element of a schema - note handles import and include of other schemas }
function VisitSchema(const SchemaDef: IXMLSchemaDef;
                     const SchemaLoc: String;
                     const Visitor: IXMLSchemaVisitor;
                     const Tracker: IProcessedTracker): Boolean;

function GetNamespaceOf(const Item: IXMLAttributeGroup): DOMString; overload;
function GetNamespaceOf(const Item: IXMLElementDef): DOMString; overload;
function GetNamespaceOf(const Item: IXMLSimpleTypeDef): DOMString; overload;
function GetNamespaceOf(const Item: IXMLComplexTypeDef): DOMString; overload;
function GetNamespaceOf(const Item: IXMLSchemaItem): DOMString; overload;

function GetNameOf(const Item: IXMLTypedSchemaItem): DOMString; overload;
function GetNameOf(const Item: IXMLTypeDef; const DefaultName: DOMString): DOMString; overload;
function GetNameOf(const Item: IXMLAttributeGroup): DOMString; overload;

function GetDataTypeName(const Item: IXMLTypedSchemaItem): DOMString;
function GetDataTypeNamespace(const Item: IXMLTypedSchemaItem): DOMString;
function GetDataTypeTie(const Item: IXMLTypedSchemaItem): TDataTypeTie;

function HasRefAttr(const Item: IXMLTypedSchemaItem): Boolean;

function IsKnownType(const Item: IXMLSimpleTypeDef): Boolean;

{ Returns whether an Element is defined inline or not }
function ElementDefinedInline(const TypeDef: IXMLElementDef): Boolean;
function AttributeDefinedInline(const TypeDef: IXMLAttributeDef): Boolean;
function AttributeGroupDefinedInline(const TypeDef: IXMLAttributeGroup): Boolean;

{ Odd helper thrown here because .... ?? }
function GetChildNodesOfName(const Node: IXMLNode; const NodeName: String): ArrayOfXMLNode;

{ ---------------------------------------------------------------------------
  Pure collection is a complex type that contains just one element with
  'maxOccurs="unbounded"'.
  ---------------------------------------------------------------------------}
function IsPureCollection(const ComplexType: IXMLComplexTypeDef;
                          var TypeName: DOMString;
                          var TypeNamespace: DOMString): Boolean; overload;
function IsPureCollection(const ComplexType: IXMLComplexTypeDef;
                          var IsInline: Boolean): Boolean; overload;
function IsPureCollection(const WSDLType: IWSDLType): Boolean; overload;


{ ---------------------------------------------------------------------------
  Retrieve documentation attached to type
  ---------------------------------------------------------------------------}
function GetDocumentation(const ComplexType: IXMLComplexTypeDef): DOMString;

{ ---------------------------------------------------------------------------
   Routine that attempts to determine whether a complex type represents
   a SOAP array.
  ---------------------------------------------------------------------------}
function SOAPArray(const ComplexType: IXMLComplexTypeDef;
                   var TypeName: DOMString;
                   var TypeNamespace: DOMString;
                   var Dimension: Integer): Boolean;

function GetProcessedTracker: IProcessedTracker;

const
  DerivationMethodStr: array[TDerivationMethod] of string = ('dmNone',
                                                             'dmComplexExtension',
                                                             'dmComplexRestriction',
                                                             'dmSimpleExtension',
                                                             'dmSimpleRestriction'
                                                            );


implementation

uses SOAPConst, XMLSchemaTags, WSDLIntf, HTTPUtil, Classes, SysUtils, Variants;

type
  { Implements Items Processed }
  TProcessedTracker = class(TInterfacedObject, IProcessedTracker)
    FProcessedList: TDOMStrings;
  public
    constructor Create;
    destructor  Destroy; override;
    function    ProcessedAlready(const Name: DOMString): Boolean;
    procedure   AddProcessed(const Name: DOMString);
    procedure   Clear;
    function    GetCount: Integer;
    function    GetItem(Index: Integer): DOMString;
  end;

function GetProcessedTracker: IProcessedTracker;
begin
  Result := TProcessedTracker.Create;
end;

{ TProcessedTracker }

procedure TProcessedTracker.AddProcessed(const Name: DOMString);
begin
  FProcessedList.Add(Name);
end;

procedure TProcessedTracker.Clear;
begin
  FProcessedList.Clear;
end;

constructor TProcessedTracker.Create;
begin
  FProcessedList := TDOMStrings.Create;
end;

destructor TProcessedTracker.Destroy;
begin
  FProcessedList.Free;
end;

function TProcessedTracker.GetCount: Integer;
begin
  Result := FProcessedList.Count;
end;

function TProcessedTracker.GetItem(Index: Integer): DOMString;
begin
  Result := FProcessedList[Index];
end;

function TProcessedTracker.ProcessedAlready(const Name: DOMString): Boolean;
begin
  Result := FProcessedList.IndexOfIgnoreCase(Name) <> -1;
end;


{ Returns children nodes of the specified named }
function GetChildNodesOfName(const Node: IXMLNode; const NodeName: String): ArrayOfXMLNode;
var
  I, Len: Integer;
begin
  Len := 0;
  SetLength(Result, 0);

  if Node.HasChildNodes then
  begin
    for I := 0 to Node.ChildNodes.Count - 1 do
    begin
      if Node.ChildNodes[I].NodeName = NodeName then
      begin
        Inc(Len);
        SetLength(Result, Len);
        Result[Len-1] := Node.ChildNodes[I];
      end;
    end;
  end;
end;


function HasChildrenNode(Node: IXMLNode; Names: array of DOMString): Boolean;
var
  I: Integer;
  Name: DOMString;
begin
  Result := False;
  if (Node.HasChildNodes) then
  begin
    for Name in Names do
    begin
      Result := Node.ChildNodes.FindNode(Name) <> nil;
      if Result then
        Exit;
    end;
    for I := 0 to Node.ChildNodes.Count - 1 do
    begin
      Result := HasChildrenNode(Node.ChildNodes[I], Names);
      if Result then
        Exit;
    end;
  end;
end;

{ Returns whether an Element is defined inline or not }
function ElementDefinedInline(const TypeDef: IXMLElementDef): Boolean;
begin
{$IFDEF SAFE_TYPE_ACCESS}
  Result := (Typedef.HasAttribute(SRef) = False) and
            (Typedef.HasAttribute(SType) = False) and
            HasChildrenNode(TypeDef, [SComplexType, SSimpleType]);

{$ELSE}
  Result := (TypeDef.Ref = nil) and (TypeDef.DataType.IsAnonymous);
{$ENDIF}
end;

function AttributeDefinedInline(const TypeDef: IXMLAttributeDef): Boolean;
begin
{$IFDEF SAFE_TYPE_ACCESS}
  Result := (Typedef.HasAttribute(SRef) = False) and
            (Typedef.HasAttribute(SType) = False);
{$ELSE}
  Result := (TypeDef.Ref = nil) and (TypeDef.DataType.IsAnonymous);
{$ENDIF}
end;

{ Returns whether an <attributeGroup...> is defined inline or not }
function AttributeGroupDefinedInline(const TypeDef: IXMLAttributeGroup): Boolean;
const
  SAttributeGroup = 'attributeGroup';
  SAttribute = 'attribute';
begin
  Result := (Typedef.HasAttribute(SRef) = False) and
            HasChildrenNode(TypeDef, [SAttribute, SAttributeGroup]);
end;



{ ---------------------------------------------------------------------------
  Retrieve documentation attached to type
  ---------------------------------------------------------------------------}
function GetDocumentation(const ComplexType: IXMLComplexTypeDef): DOMString;
begin
  Result := '';
  try
    Result := XMLSchema.GetDocumentation(ComplexType);
  except
    { RAID: 242581: There's a bug in XMLSchema.GetDocumentation that does not handle
                    Ebay's style annotation, such as the following:

      <xs:complexType xmlns:xs="http://www.w3.org/2001/XMLSchema" name="GetApiAccessRulesRequestType">
        <xs:annotation>
          <xs:documentation>
            <!-- see in/out docs for description -->
          </xs:documentation>
          <xs:appinfo>
            <Summary xmlns="urn:ebay:apis:eBLBaseComponents">
                Retrieves the access rules for various calls and shows how many calls your
                application has made in the past day and hour.
              </Summary>
            <SeeLink xmlns="urn:ebay:apis:eBLBaseComponents">
              <URL>http://developer.ebay.com/help/certification</URL>
              <Title>Certification</Title>
            </SeeLink>
          </xs:appinfo>
        </xs:annotation>
        <xs:sequence>
          <xs:element name="name" type="xs:string"/>
        </xs:sequence>
      </xs:complexType>

      I've informed ME of the issue and is waiting for a reply.
      In the meantime I'll ignore exceptions from XMLSchema.GetDocumetation(xxx) }
  end;
end;


function GetArrayDimension(const Name: DOMString; var Dim: integer): DOMString;
var
  SepPos, I, Strlen: Integer;
begin
  Dim := 1;   { Safe Start! }
  Result := Name;
  StrLen := Length(Name);
  SepPos := Pos('[', Name);

  { Extract dimensions }
  if SepPos > 0 then
  begin
    Dim := 0;
    for I := SepPos to StrLen do
    begin
      if (Name[I] = '[') or (Name[I] = ',') then
        Inc(Dim);
    end;
    { Extract Name }
    Result := Copy(Name, Low(Integer), SepPos-1)
  end;
end;


{ ---------------------------------------------------------------------------
  The way each SOAP Stack declares arrays is frightening. This routine
  attempts to detect the flavors that exists out there.
  NOTE: This is work in progress...
  ---------------------------------------------------------------------------}
function SOAPArray(const ComplexType: IXMLComplexTypeDef;
                   var TypeName: DOMString;
                   var TypeNamespace: DOMString;
                   var Dimension: Integer): Boolean;
var
  BaseType: string;
  URI: DOMString;
  AttributeDef: IXMLAttributeDef;
  HasValue: Boolean;
  V: OleVariant;
begin
  Result := False;
  Dimension := 1;

  { Some schemas - WASP' for example - declare arrrays as:
    <complexType name="ArrayOfstring" base="SOAP-ENC:Array">
      <sequence>
        <element name="arg" type="xsd:string" />
      </sequence>
    </complexType> }
  { Check for Base of SOAP-ENC:Array }
  if ComplexType.HasAttribute(SBase) then
  begin
    BaseType := ComplexType.Attributes[SBase];
    if IsPrefixed(BaseType) and (ExtractLocalName(BaseType) = SArray) then
    begin
      URI := ComplexType.FindNamespaceURI(ExtractPrefix(BaseType));
      if (URI = Soapns) or (URI = SSoap11EncodingS5) then
      begin
        if (ComplexType.ElementDefs.Count = 1) then
        begin
          TypeName :=  GetDataTypeName(ComplexType.ElementDefList[0]);
          TypeNamespace := GetDataTypeNamespace(ComplexType.ElementDefList[0]);
          Result := True;
        end;
      end;
    end;
  end;

  { Here we check for the more typical Array Schema }
  {
    <xs:complexType name="ArrayOfint">
      <xs:complexContent>
        <xs:restriction base="soapenc:Array">
          <xs:sequence/>
          <xs:attribute ref="soapenc:arrayType" n1:arrayType="xs:int[]"/>
        </xs:restriction>
      </xs:complexContent>
    </xs:complexType>

    NOTE this variation:

      <complexType name="ArrayOfstring">
       <complexContent>
        <restriction base="SOAP-ENC:Array">
         <sequence>
          <element name="item" type="xsd:string" minOccurs="0" maxOccurs="unbounded"/>
         </sequence>
         <attribute ref="SOAP-ENC:arrayType" WSDL:arrayType="xsd:string[]"/>
        </restriction>
       </complexContent>
      </complexType>
  }
  if (not Result) then
  begin
    if (ComplexType.DerivationMethod = dmComplexRestriction) and
       (ComplexType.ElementDefs.Count <= 1) and
       (ComplexType.AttributeDefs.Count = 1) then
      begin
        AttributeDef := ComplexType.AttributeDefs[0];
        HasValue := AttributeDef.HasAttribute(SArrayType, Wsdlns);
        if (HasValue) then
        begin
          V := AttributeDef.GetAttributeNS(SArrayType, Wsdlns);
          TypeName := V;
          if IsPrefixed(TypeName) then
          begin
            TypeNamespace := ExtractPrefix(TypeName);
            TypeNamespace := AttributeDef.FindNamespaceURI(TypeNamespace);
            TypeName := ExtractLocalName(TypeName);
          end
          else
            TypeNamespace := AttributeDef.NamespaceURI;
          TypeName := GetArrayDimension(TypeName, Dimension);
          Result := True;
        end;
      end;
  end;
end;


{ ---------------------------------------------------------------------------
  Pure collection is a complex type that contains just one element with
  'maxOccurs="unbounded"'.
  ---------------------------------------------------------------------------}
function IsPureCollection(const ComplexType: IXMLComplexTypeDef; var IsInline: Boolean): Boolean; overload;
begin
  Result := (ComplexType.ElementDefList.Count = 1) and
    ComplexType.ElementDefList[0].IsRepeating;
  if (Result) then
  begin
    IsInline := ElementDefinedInline(ComplexType.ElementDefs[0]);
  end;
end;

{ ---------------------------------------------------------------------------
  Pure collection is a complex type that contains just one element with
  'maxOccurs="unbounded"'.
  ---------------------------------------------------------------------------}
function IsPureCollection(const ComplexType: IXMLComplexTypeDef; var TypeName: DOMString;
                          var TypeNamespace: DOMString): Boolean; overload;
begin
  Result := (ComplexType.ElementDefList.Count = 1) and
    ComplexType.ElementDefList[0].IsRepeating;
  if Result then
  begin
    TypeName :=  GetDataTypeName(ComplexType.ElementDefList[0]);
    TypeNamespace := GetDataTypeNamespace(ComplexType.ElementDefList[0]);
  end;
end;

{ ---------------------------------------------------------------------------
  Pure collection is a complex type that contains just one element with
  'maxOccurs="unbounded"'.
  ---------------------------------------------------------------------------}
function IsPureCollection(const WSDLType: IWSDLType): Boolean; overload;
begin
  Result := False;
  if (WSDLType.DataKind = wtClass) then
  begin
    if (Length(WSDLType.Members) = 1) and (pfUnbounded in WSDLType.Members[0].PartFlags) then
      Result := True;
  end;
end;

function FindDefaultNamespace(Node: IXMLNode): DOMString;
begin
  Result := '';
  while (Result = '') and Assigned(Node) do
  begin
    if (Node.HasAttribute(SXMLNS)) then
    begin
      Result := Node.Attributes[SXMLNS];
      Break;
    end;
    Node := Node.ParentNode;
  end;
end;

function GetNameOf(const Item: IXMLAttributeGroup): DOMString;
begin
  if Item.HasAttribute(SRef) then
  begin
    Result := Item.Attributes[SRef];
    if IsPrefixed(Result) then
      Result := ExtractLocalName(Result);
    Exit;
  end;
  Result := Item.Name;
end;

function GetNameOf(const Item: IXMLTypedSchemaItem): DOMString;
begin
  { Whenever there's a ref="xxxx", the logic in XMLSchema may go into
    an endless loop (eventually stack overlflow) in trying to resolve
    the ref; so we take the easy way out to avoid the crash }
  if Item.HasAttribute(SRef) then
  begin
    Result := Item.Attributes[SRef];
    if IsPrefixed(Result) then
      Result := ExtractLocalName(Result);
    Exit;
  end;
  Result := Item.Name;
end;

function GetNameOf(const Item: IXMLTypeDef; const DefaultName: DOMString): DOMString;
begin
  try
    Result := Item.Name;
  except
    Result := DefaultName;
  end;
end;

function GetNamespaceOf(const Item: IXMLSimpleTypeDef): DOMString;
var
  V: OleVariant;
begin
  if IsKnownType(Item) then
    Result := XMLSchema.SXMLSchemaURI_2001
  else
  begin
    V := Item.SchemaDef.TargetNamespace;
    if not VarIsNull(V) then
      Result := V
    else
      Result := FindDefaultNamespace(Item);
  end;
end;

function GetNamespaceOf(const Item: IXMLAttributeGroup): DOMString;
var
  V: OleVariant;
begin
  V := Item.SchemaDef.TargetNamespace;
  if not VarIsNull(V) then
    Result := V
  else
    Result := FindDefaultNamespace(Item);
end;

function GetNamespaceOf(const Item: IXMLElementDef): DOMString;
var
  V: OleVariant;
begin
  V := Item.SchemaDef.TargetNamespace;
  if not VarIsNull(V) then
    Result := V
  else
    Result := FindDefaultNamespace(Item);
end;

function GetNamespaceOf(const Item: IXMLComplexTypeDef): DOMString;
var
  V: OleVariant;
begin
  V := Item.SchemaDef.TargetNamespace;
  if not VarIsNull(V) then
    Result := V
  else
    Result := FindDefaultNamespace(Item);
end;

function GetNamespaceOf(const Item: IXMLSchemaItem): DOMString;
var
  V: OleVariant;
begin
  if Supports(Item, IXMLSimpleTypeDef) then
    Result := GetNamespaceOf(Item as IXMLSimpleTypeDef)
  else
  begin
    V := Item.SchemaDef.TargetNamespace;
    if not VarIsNull(V) then
      Result := V
    else
      Result := FindDefaultNamespace(Item);
  end;
end;

function GetDataTypeSafely(const Item: IXMLTypedSchemaItem): IXMLTypeDef;
begin
  Result := nil;
  try
    Result := Item.DataType;
  except
      on E: ESchemaParse do
      begin
        raise ESchemaParse.CreateFmt('Unable to resolve DataType of "%s"' + sLineBreak +
                                     'Error ''%s''',
                                     [Item.XML, E.Message]);
      end;
  end;
end;

function GetDataTypeTie(const Item: IXMLTypedSchemaItem): TDataTypeTie;
begin
  if Item.HasAttribute(SType) then
  begin
    Result := dtType;
  end
  else if Item.HasAttribute(SRef) then
  begin
    Result := dtRef;
  end
  else
    Result := dtUnknown;
end;

function GetDataTypeName(const Item: IXMLTypedSchemaItem): DOMString;
begin
  case GetDataTypeTie(Item) of
    dtType:
    begin
      Result := Item.Attributes[SType];
      if IsPrefixed(Result) then
      begin
        Result := ExtractLocalName(Result);
      end;
    end;

    dtRef:
    begin
      Result := Item.Attributes[SRef];
      if IsPrefixed(Result) then
      begin
        Result := ExtractLocalName(Result);
      end;
    end;
  end;

  { Last Resort }
  if Result = '' then
    Result := GetDataTypeSafely(Item).Name;
end;

function GetDataTypeNamespace(const Item: IXMLTypedSchemaItem): DOMString;
var
  TypeName: DOMString;
  ElementDef: IXMLElementDef;
begin
  case GetDataTypeTie(Item) of
    dtType:
      begin
        TypeName := Item.Attributes[SType];
        if IsPrefixed(TypeName) then
        begin
          { Namespace}
          TypeName := ExtractPrefix(TypeName);
          Result := Item.FindNamespaceURI(TypeName);
        end;
      end;

    dtRef:
      begin
        TypeName := Item.Attributes[SRef];
        if IsPrefixed(TypeName) then
        begin
          { Namespace}
          TypeName := ExtractPrefix(TypeName);
          Result := Item.FindNamespaceURI(TypeName);
        end
        else
        begin
          Result := GetNamespaceOf(Item);
        end;
      end;
  end;

  { Last Resort }
  if Result = '' then
{$IFNDEF SAFE_DATATYPE_ACCESS}
    Result := GetNamespaceOf(Item.DataType);
{$ELSE}
  try
    ElementDef := nil;
    if Supports(Item, IXMLElementDef) then
    begin
      ElementDef := Item as IXMLElementDef;
    end;

    Result := GetNamespaceOf(GetDataTypeSafely(Item));
  except
      on E: ESchemaParse do
      begin
        if (ElementDef <> nil) then
          Result := FindDefaultNamespace(item);

        if Result = '' then
          raise;
      end;
  end;
{$ENDIF}
end;

function HasRefAttr(const Item: IXMLTypedSchemaItem): Boolean;
begin
  Result := Item.HasAttribute(SRef);
end;

function IsKnownType(const Item: IXMLSimpleTypeDef): Boolean;
begin
  Result := Item.IsBuiltInType;
end;

type

  TXMLSchemaGuide = class(TInterfacedObject, IXMLSchemaGuide)
    FXMLVisitor: IXMLSchemaVisitor;
  public
    constructor Create(XMLVisitor: IXMLSchemaVisitor);
    procedure HandleSchema(FileName: DOMString);

    procedure ShowSchema(const SchemaDef: IXMLSchemaDef; const SchemaLoc: String;
                         const Tracker: IProcessedTracker;
                         const OuterTNS: DOMString); overload;

    procedure Show(Items: IXMLElementGroups; ElementTypes: TElementTypes; Context: XMLVisitorContext); overload;
    procedure Show(Items: IXMLAttributeGroups; Context: XMLVisitorContext); overload;
    procedure Show(Items: IXMLAttributeDefs; Context: XMLVisitorContext); overload;
    procedure Show(Items: IXMLElementDefs; ElementTypes: TElementTypes; CompositorId: Integer;
                   Context: XMLVisitorContext); overload;
    procedure Show(Items: IXMLSimpleTypeDefs; Context: XMLVisitorContext); overload;
    procedure Show(Items: IXMLComplexTypeDefs; Context: XMLVisitorContext); overload;
    procedure Show(Item: IXMLElementCompositor; CompositorId: Integer; Context: XMLVisitorContext); overload;
    procedure ShowAny(Item: IXMLNode; Context: XMLVisitorContext);

    function Show(Item: IXMLAttributeGroup; Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Show(Item: IXMLElementGroup;  ElementTypes: TElementTypes; Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Show(Item: IXMLComplexTypeDef; Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Show(Item: IXMLSimpleTypeDef; Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Show(Item: IXMLElementDef; ElementTypes: TElementTypes; CompositorId: Integer; Context: XMLVisitorContext): XMLVisitorContext; overload;
    function Show(Item: IXMLAttributeDef; Context: XMLVisitorContext): XMLVisitorContext; overload;
  end;

function VisitSchema(const SchemaDef: IXMLSchemaDef;
                     const SchemaLoc: String;
                     const Visitor: IXMLSchemaVisitor;
                     const Tracker: IProcessedTracker): Boolean;
var
  Guide: IXMLSchemaGuide;
begin
  Guide := TXMLSchemaGuide.Create(Visitor);
  Guide.ShowSchema(SchemaDef, SchemaLoc, Tracker, '');
  Result := True;
end;

function isHTTP(const Name: DOMString): boolean;
const
  sHTTPPrefix = 'http://';
  sHTTPsPrefix= 'https://';
begin
  Result := SameText(Copy(Name, 1, Length(sHTTPPrefix)), sHTTPPrefix) or
            SameText(Copy(Name, 1, Length(sHTTPsPrefix)),sHTTPsPrefix);
end;

{ Returns path of SchemaLoc relative to its Referer }
function GetRelativePath(const Referer, SchemaLoc: DOMString): DOMString;
const
  sPathSep: WideChar = '/';
var
  HTTPRef: Boolean;
  Path: DOMString;
  Len: Integer;
begin
  if IsHTTP(SchemaLoc) then
  begin
    Result := SchemaLoc;
    Exit;
  end;
  HTTPRef := IsHTTP(Referer);
  if (HTTPRef) then
  begin
    Len := Length(Referer);
    while (Len > 0) do
    begin
      if (Referer[Len] = sPathSep) then
      begin
        Path := Copy(Referer, 0, Len);
        Result := Path + SchemaLoc;
        Exit;
      end;
      Dec(Len);
    end;
  end;

  if FileExists(SchemaLoc) then
  begin
    Result := SchemaLoc;
    Path := ExpandFileName(SchemaLoc);
    if Path <> '' then
      Result := Path;
    Exit;
  end;

  Path := ExtractFilePath(SchemaLoc);
  if Path = '' then
  begin
    Path := ExtractFilePath(Referer);
    if Path <> '' then
    begin
      Result := ExpandFileName(Path + SchemaLoc);
      Exit;
    end;
  end;

  Result := SchemaLoc;
end;

{ TXMLSchemaGuide }

constructor TXMLSchemaGuide.Create(XMLVisitor: IXMLSchemaVisitor);
begin
  FXMLVisitor := XMLVisitor;
end;

procedure TXMLSchemaGuide.HandleSchema(FileName: DOMString);
begin

end;

procedure TXMLSchemaGuide.ShowSchema(const SchemaDef: IXMLSchemaDef;
                                     const SchemaLoc: String;
                                     const Tracker: IProcessedTracker;
                                     const OuterTNS: DOMString);
var
  I: Integer;
  UpdatedSchemaLoc: String;
  Context: XMLVisitorContext;
  TargetNS: DOMString;
begin
  if Tracker.ProcessedAlready(SchemaLoc) then
  begin
    FXMLVisitor.Skipping(SchemaLoc);
    Exit;
  end;

  Tracker.AddProcessed(SchemaLoc);

  { For included items, we patch the targetnamespace to that of the outer
    that included the file unless a target namespace is already set }
  if not VarIsNull(SchemaDef.TargetNamespace) then
    TargetNS := SchemaDef.TargetNamespace
  else
  begin
    if OuterTNS <> '' then
    begin
      SchemaDef.SetTargetNamespace(OuterTNS, 'tns');
      if not VarIsNull(SchemaDef.TargetNamespace) then
        TargetNS := SchemaDef.TargetNamespace
    end;
  end;

  Context := FXMLVisitor.Start(SchemaDef, SchemaLoc);
  try
    // Handle <include ... >
    try
      for I := 0 to SchemaDef.SchemaIncludes.Count - 1 do
      begin
        UpdatedSchemaLoc := SchemaDef.SchemaIncludes[I].SchemaLocation;
        if (Length(UpdatedSchemaLoc) > 0) then
        begin
          UpdatedSchemaLoc := GetRelativePath(SchemaLoc, UpdatedSchemaLoc);
          SchemaDef.SchemaIncludes[i].SchemaLocation := UpdatedSchemaLoc;
          try
            ShowSchema(SchemaDef.SchemaIncludes[I].SchemaRef,  UpdatedSchemaLoc, Tracker, TargetNS);
          except
            on E:Exception do
            begin
              FXMLVisitor.Error(UpdatedSchemaLoc, E.Message);
            end;
          end;
        end;
      end;

      // Handle <import ...>
      for I := 0 to SchemaDef.SchemaImports.Count - 1 do
      begin
        UpdatedSchemaLoc := SchemaDef.SchemaImports[I].SchemaLocation;
        if (Length(UpdatedSchemaLoc) > 0) then
        begin
          UpdatedSchemaLoc := GetRelativePath(SchemaLoc, UpdatedSchemaLoc);
          SchemaDef.SchemaImports[i].SchemaLocation := UpdatedSchemaLoc;
          try
            { NOTE: Accessing the SchemaRef causes the schema to be loaded }
            ShowSchema(SchemaDef.SchemaImports[I].SchemaRef,  UpdatedSchemaLoc, Tracker, '');
          except
            on E:Exception do
            begin
              FXMLVisitor.Error(UpdatedSchemaLoc, E.Message);
            end;
          end;
        end;
      end;
    finally
      // Now handle our types
      Show(SchemaDef.ElementGroups, [etGlobal, etElementGroup], Context);
      Show(SchemaDef.AttributeGroups, Context);
      Show(SchemaDef.ComplexTypes, Context);
      Show(SchemaDef.SimpleTypes, Context);
      Show(SchemaDef.ElementDefs, [etGlobal], -1, Context);
      Show(SchemaDef.AttributeDefs, Context);
    end;
  finally
    FXMLVisitor.Done(SchemaLoc);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLElementGroups;
                               ElementTypes: TElementTypes;
                               Context: XMLVisitorContext);
var
  I: Integer;
  Item: IXMLElementGroup;
begin
  for I := 0 to Items.Count-1 do
  begin
    Item := Items[I];
    Show(Item, ElementTypes, Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLAttributeGroups;
                               Context: XMLVisitorContext);
var
  I: Integer;
  Item: IXMLAttributeGroup;
begin
  for I := 0 to Items.Count-1 do
  begin
    Item := Items[I];
    Show(Item, Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLSimpleTypeDefs; Context: XMLVisitorContext);
var
  I: Integer;
begin
  for I := 0 to Items.Count-1 do
  begin
    Show(Items[I], Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLComplexTypeDefs; Context: XMLVisitorContext);
var
  I: Integer;
  Item: IXMLComplexTypeDef;
begin
  for I := 0 to Items.Count-1 do
  begin
    Item := Items[I];
    Show(Item, Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLAttributeDefs; Context: XMLVisitorContext);
var
  I: Integer;
begin
  for I := 0 to Items.Count-1 do
  begin
    Show(Items[I], Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Items: IXMLElementDefs;
                               ElementTypes: TElementTypes;
                               CompositorId: Integer;
                               Context: XMLVisitorContext);
var
  I: Integer;
  Item: IXMLElementDef;
begin
  for I := 0 to Items.Count-1 do
  begin
    Item := Items[I];
    Show(Item, ElementTypes, CompositorId, Context);
  end;
end;

procedure TXMLSchemaGuide.Show(Item: IXMLElementCompositor;
                               CompositorId: Integer;
                               Context: XMLVisitorContext);

  function ElementTypeFromCompositorType(const CT: TCompositorType): TElementType;
  begin
    Result := etGlobal;
    case CT of
      ctAll: Result := etAll;
      ctChoice: Result := etChoice;
      ctSequence: Result := etSequence;
    end;
  end;

  function GetAnyNode(const Item: IXMLElementCompositor): IXMLNode;
  begin
    Result := Item.ChildNodes.FindNode(SAny, XMLSchemaNamespace);
  end;

var
  I, Count: Integer;
  Nodes: array of IXMLNode;
  Processed: array of Boolean;
  Node: IXMLNode;
  ElemTypes: TElementTypes;
begin
  ElemTypes := [ElementTypeFromCompositorType(Item.CompositorType)];
  if (Item.Compositors.Count < 1) and (Item.ElementGroups.Count < 1) then
  begin
    Show(Item.ElementDefs, ElemTypes, CompositorId, Context);
  end
  else
  begin
    { Here we might have <element> and <compositorNodes> mixed - so we have to
      walk down and make sure we go in Depth-first order }
    Count := Item.ChildNodes.Count;
    SetLength(Nodes, Count);
    SetLength(Processed, Count);
    for I := 0 to Count-1 do
      Nodes[I] := Item.ChildNodes[I];

    for I := 0 to Length(Nodes)-1 do
    begin
      if Supports(Nodes[I], IXMLElementCompositor) then
      begin
        Show(Nodes[I] as IXMLElementCompositor, CompositorId, Context);
        Processed[I] := True;
      end
      else if Supports(Nodes[I], IXMLElementGroup) then
      begin
        Show(Nodes[I] as IXMLElementGroup, ElemTypes + [etElementGroup], Context);
        Processed[I] := True;
      end
      else if Supports(Nodes[I], IXMLElementDef) then
      begin
        Show(Nodes[I] as IXMLElementDef, ElemTypes, CompositorId, Context);
        Processed[I] := True;
      end
      else
                                        
        Processed[I] := False;
    end;
  end;
  Node := GetAnyNode(Item);
  if (Node <> nil) then
    ShowAny(Node, Context);
end;

{$DEFINE USE_COMPOSITOR_NODE}
//{$DEFINE WALK_COMPLEXTYPE_NODES}
function TXMLSchemaGuide.Show(Item: IXMLComplexTypeDef; Context: XMLVisitorContext): XMLVisitorContext;

  function ElementTypeFromContentModel(CM: TContentModel): TElementType;
  begin
    Result := etGlobal;
    // cmALL, cmChoice, cmSequence, cmGroupRef, cmEmpty
    case CM of
      cmAll: Result := etAll;
      cmChoice: Result := etChoice;
      cmSequence: Result := etSequence;
      cmGroupRef, cmEmpty: ;
    else
      Assert(False, 'Unexpected content model');
    end;
  end;

{$IFDEF WALK_COMPLEXTYPE_NODES}
var
  I, Count: Integer;
  Node: IXMLNode;
  XMLElementCompositor: IXMLElementCompositor;
  XMLAttribute: IXMLAttributeDef;
  XMLAttributeGroup: IXMLAttributeGroup;
  XMLBaseTypeIndicator: IXMLBaseTypeIndicator;
{$ENDIF}
begin
  Result := FXMLVisitor.Visit(Item, Context);
{$IFDEF WALK_COMPLEXTYPE_NODES}
  Count := Item.ChildNodes.Count;
  for I := 0 to Count-1 do
  begin
    Node := Item.ChildNodes[I];
    if Supports(Node, IXMLElementCompositor, XMLElementCompositor) then
      Show(XMLelementCompositor, I, Result)
    else if Supports(Node,  IXMLAttributeDef, XMLAttribute) then
      Show(XMLAttribute, Result)
    else if Item.ContentModel
  end;

{$ELSE}
  Show(Item.AttributeDefs, Result);
  Show(Item.AttributeGroups, Result);
  {$IFDEF USE_COMPOSITOR_NODE}
  Show(Item.CompositorNode, 0, Result);
  {$ELSE}
  Show(Item.ElementDefs, ElementTypeFromContentModel(Item.ContentModel), Result);
  {$ENDIF}
{$ENDIF}
end;

function TXMLSchemaGuide.Show(Item: IXMLAttributeGroup; Context: XMLVisitorContext): XMLVisitorContext;
begin
  Result := FXMLVisitor.Visit(Item, Context);
  { XMLSchema's TXMLAttributeGroup.GetAttributeDefs will follow 'ref'
    something we do not want - so we check first }
  if not Item.HasAttribute(SRef) then
  begin
    Show(Item.AttributeDefs, Result);
  end;
end;

function TXMLSchemaGuide.Show(Item: IXMLElementGroup;  ElementTypes: TElementTypes; Context: XMLVisitorContext): XMLVisitorContext;
begin
  Result := FXMLVisitor.Visit(Item, Context);
  Show(Item.ElementDefs, ElementTypes + [etElementGroup], 0, Result);
end;

function TXMLSchemaGuide.Show(Item: IXMLSimpleTypeDef; Context: XMLVisitorContext): XMLVisitorContext;
begin
  Result := FXMLVisitor.Visit(Item, Context);
end;

function TXMLSchemaGuide.Show(Item: IXMLElementDef; ElementTypes: TElementTypes;
                              CompositorId: Integer; Context: XMLVisitorContext): XMLVisitorContext;
begin
  Result := FXMLVisitor.Visit(Item, ElementTypes, CompositorId, Context);
  if ElementDefinedInline(Item) then
  begin
    if Item.DataType.IsComplex then
      Show(Item.DataType as IXMLComplexTypeDef, Result)
    else
      Show(Item.DataType as IXMLSimpleTypeDef, Result);
  end
end;

function TXMLSchemaGuide.Show(Item: IXMLAttributeDef; Context: XMLVisitorContext): XMLVisitorContext;
begin
  Result := FXMLVisitor.Visit(Item, Context);
end;

procedure TXMLSchemaGuide.ShowAny(Item: IXMLNode; Context: XMLVisitorContext);
begin
  FXMLVisitor.VisitAny(Item, Context);
end;


end.
