{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       XML Data File to XML Schema Translator          }
{*******************************************************}

unit Xml.XMLDataToSchema;

interface

uses System.Variants, System.SysUtils, System.Classes, Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf, Xml.XMLSchema;

type

{ TXMLDataTranslator }

  TXMLDataImporter = class(TXMLSchemaTranslator)
  private
    FXMLDoc: IXMLDocument;
  protected
    function AddComplexType(const Node: IXMLNode; const NameOverride: DOMString = ''): DOMString;
    function GetDataType(const Node: IXMLNode): DOMString;
    function IsComplexType(const Node: IXMLNode): Boolean;
    procedure Translate(const FileName: DOMString; const SchemaDef: IXMLSchemaDef); override;
    function ValidateExistingType(const ExistingType: IXMLComplexTypeDef;
      const Node: IXMLNode): DOMString;
    { Data member access }
    property XMLDoc: IXMLDocument read FXMLDoc;
  end;

const
  SXMLDataExtension = '.xml';

implementation

uses Xml.XMLSchemaTags, Xml.XMLConst;

const
  FirstIndex = Low(string);
  AdjustIndex= 1-Low(string);

const
  TypeSuffix = 'Type';

var
  TranslatorFactory: IXMLSchemaTranslatorFactory;

{ TXMLDataImporter }

function TXMLDataImporter.GetDataType(const Node: IXMLNode): DOMString;
const
  Digits = [Ord('0')..Ord('9')];
var
  Len, I: Integer;
  Value: string;
begin
  { Basic routine to try and determine the data type of a node's value.
    Currently only tries to detect integers and decimals }
  if (Node.NodeType = ntAttribute) or Node.IsTextElement then
    Value := VarToStr(Node.NodeValue);
  if Value = '' then
  begin
    Result := xsdString;
    Exit;
  end;
  Len := Length(Value)-AdjustIndex;
  Result := '';
  for I := FirstIndex to Len do
    //if not CharInSet(Value[I], Digits + [FormatSettings.DecimalSeparator]) then
    if not Ord(Value[I]) in  Digits + [Ord(FormatSettings.DecimalSeparator)] then
    begin
      Result := xsdString;
      Exit;
    end else if Value[I] = FormatSettings.DecimalSeparator then
      Result := xsdDecimal;
  if Result = '' then
    Result := xsdInteger;
end;

function TXMLDataImporter.IsComplexType(const Node: IXMLNode): Boolean;
var
  I: Integer;
begin
  Result :=  Node.AttributeNodes.Count > 0;
  if not Result then
    for I := 0 to Node.ChildNodes.Count - 1 do
      if Node.ChildNodes[I].NodeType = ntElement then
      begin
        Result := True;
        Break;
      end;
end;

function TXMLDataImporter.AddComplexType(const Node: IXMLNode; const NameOverride: DOMString =''): DOMString;

  function MakeTypeName(const Name: DOMString): DOMString;
  var
    TypePos: Integer;
  begin
    TypePos := Pos(DOMString(TypeSuffix), Name);
    if (TypePos = 0) or (TypePos <> (Length(Name) + 1 - Length(TypeSuffix))) then
      Result := Name + TypeSuffix
    else
      Result := Name;
  end;

  procedure ProcessChildNodes(ComplexTypeDef: IXMLComplexTypeDef);
  var
    I: Integer;
    BaseName, ChildType: DOMString;
    ChildNode: IXMLNode;
    ElementDef: IXMLElementDef;
  begin
    for I := 0 to Node.ChildNodes.Count - 1 do
    begin
      ChildNode := Node.ChildNodes[I];
      if ChildNode.NodeType = ntElement then
      begin
        ComplexTypeDef.ContentModel := cmSequence;
        BaseName := ExtractLocalName(ChildNode.NodeName);
        ElementDef := ComplexTypeDef.ElementDefs.Find(BaseName);
        if not Assigned(ElementDef) then
        begin
          if IsComplexType(ChildNode) then
            ChildType := AddComplexType(ChildNode) else
            ChildType := GetDataType(ChildNode);
          ComplexTypeDef.ElementDefs.Add(BaseName, ChildType);
        end else
        begin
          ElementDef.MaxOccurs := SUnbounded;
          { Determine if this node is different than any we've already seen }
          if ElementDef.DataType.IsComplex then
            ValidateExistingType(ElementDef.DataType as IXMLComplexTypeDef,
              ChildNode);
        end;
      end;
    end;
  end;

  procedure ProcessAttributes(ComplexTypeDef: IXMLComplexTypeDef);
  var
    I: Integer;
    BaseName: DOMString;
    AttributeNode: IXMLNode;
  begin
    for I := 0 to Node.AttributeNodes.Count - 1 do
    begin
      AttributeNode := Node.AttributeNodes[I];
      BaseName := ExtractLocalName(AttributeNode.NodeName);
      { Ignore 'xmlns' and any other reserved xml attributes }
      if Pos(DOMString('xml'), attributeNode.Prefix) <> 1 then
        if ComplexTypeDef.AttributeDefs.IndexOfItem(BaseName) = -1 then
          ComplexTypeDef.AttributeDefs.Add(BaseName, GetDataType(AttributeNode));
    end;
  end;

var
  NewType, ExistingType: IXMLComplexTypeDef;
begin
  if NameOverride = '' then
    Result := MakeTypeName(ExtractLocalName(Node.NodeName))
  else
    Result := NameOverride;
  ExistingType := SchemaDef.ComplexTypes.Find(Result);
  if ExistingType = nil then
  begin
    if not Node.IsTextElement then
    begin
      NewType := SchemaDef.ComplexTypes.Add(Result, cmEmpty);
      ProcessChildNodes(NewType);
    end else
      NewType := SchemaDef.ComplexTypes.Add(Result, xsdString, dmSimpleExtension, cmEmpty);
    ProcessAttributes(NewType);
  end else
    Result := ValidateExistingType(ExistingType, Node);
end;

function TXMLDataImporter.ValidateExistingType(
  const ExistingType: IXMLComplexTypeDef; const Node: IXMLNode): DOMString;
var
  I, J: Integer;
  NoChildElements: Boolean;
  BaseName, ChildType: DOMString;
  AttrNode, ChildNode: IXMLNode;
  AttrDef: IXMLAttributeDef;
  ElementDef: IXMLElementDef;
begin
  NoChildElements := Node.IsTextElement or (Node.ChildNodes.Count = 0);
  if not (NoChildElements = (ExistingType.ContentModel = cmEmpty))  then
  begin
    // If existing type had no elements then convert it a simpleRestriction type.
    if Node.IsTextElement and (ExistingType.ElementDefs.Count = 0) then
    begin
      ExistingType.ContentModel := cmEmpty;
      ExistingType.DerivationMethod := dmSimpleExtension;
      ExistingType.BaseTypeName := xsdString;
    end
    else
    begin
      Result := AddComplexType(Node, ExistingType.Name + '2');
      Exit;
    end;
  end;
  Result := ExistingType.Name;
  if not Node.IsTextElement then
    for I := 0 to Node.ChildNodes.Count - 1 do
    begin
      ChildNode := Node.ChildNodes[I];
      if ChildNode.NodeType <> ntElement then continue;
      BaseName := ExtractLocalName(ChildNode.NodeName);
      ElementDef := ExistingType.ElementDefs.Find(BaseName);
      { If element didn't occur previously, then add it now }
      if not Assigned(ElementDef) then
      begin
        if IsComplexType(ChildNode) then
          ChildType := AddComplexType(ChildNode) else
          ChildType := GetDataType(ChildNode);

        ExistingType.ElementDefs.Add(BaseName, ChildType);
      end else
      begin
        { Check if the element is repeated in this node, if it wasn't previously }
        if ElementDef.MaxOccurs <> SUnbounded then
          for J := I + 1 to Node.ChildNodes.Count - 1 do
            if Node.GetChildNodes[J].NodeName = ChildNode.NodeName then
            begin
              ElementDef.MaxOccurs := SUnbounded;
              Break;
            end;
        { Validate the children of this node as well }
        if ElementDef.DataType.IsComplex then
          ValidateExistingType(ElementDef.DataType as IXMLComplexTypeDef, ChildNode);
      end;
    end;

  { If an attribute didn't occur previously, then add it now }
  for I := 0 to Node.AttributeNodes.Count - 1 do
  begin
    AttrNode := Node.AttributeNodes[I];
    BaseName := ExtractLocalName(AttrNode.NodeName);
    AttrDef := ExistingType.AttributeDefs.Find(BaseName);
    if not Assigned(AttrDef) then
      ExistingType.AttributeDefs.Add(BaseName, GetDataType(AttrNode));
  end;

  { If an existing element doesn't appear here, then mark it as optional }
  for I := 0 to ExistingType.ElementDefs.Count - 1 do
  begin
    ElementDef := ExistingType.ElementDefs[I];
    if (ElementDef.MinOccurs <> '0') and
       (Node.ChildNodes.FindNode(ElementDef.Name) = nil) then
      ElementDef.MinOccurs := '0';
  end;

end;

procedure TXMLDataImporter.Translate(const FileName: DOMString;
  const SchemaDef: IXMLSchemaDef);
begin
  inherited;
  FXMLDoc := LoadXMLDocument(FileName);
  if Assigned(XMLDoc.DocumentElement) then
  begin
    if XMLDoc.DocumentElement.NamespaceURI <> '' then
      SchemaDef.SetTargetNamespace(XMLDoc.DocumentElement.NamespaceURI,
        XMLDoc.DocumentElement.Prefix);
    if IsComplexType(XMLDoc.DocumentElement) then
    begin
      SchemaDef.ElementDefs.Add(ExtractLocalName(XMLDoc.DocumentElement.NodeName),
        XMLDoc.DocumentElement.NodeName+TypeSuffix);
      AddComplexType(XMLDoc.DocumentElement);
    end;
  end;
end;

initialization
  TranslatorFactory := TXMLSchemaTranslatorFactory.Create(TXMLDataImporter, nil,
    SXMLDataExtension, SXMLDataTransDesc);
  RegisterSchemaTranslator(TranslatorFactory);
finalization
  UnRegisterSchemaTranslator(TranslatorFactory);
end.

