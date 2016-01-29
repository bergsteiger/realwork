unit PDXFADocument;
{$I ..\Utils\gtCompilerDefines.inc}

interface
{$IFDEF VCL6ORABOVE}
uses
  PDElement, Classes, XMLDoc, XMLIntf, gtObject, PDTypes;

type

  TgtPDXFADocument = class(TgtPDElement)
  private
    FTemplateDoc: IXMLDocument;
    FDataSetDoc: IXMLDocument;
    FTempRootNode: IXMLNode;
    FDataRootNode: IXMLNode;
    FTemplateStream: TMemoryStream;
    FDataSetStream: TMemoryStream;

    procedure UpdateXFAObj(AStr: AnsiString; AStream: TMemoryStream);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ADataSetStream, ATemplateStream: TStream);
    destructor Destroy; override;
    procedure Update; override;

    procedure UpdateNodeAt(ARootNode: IXMLNode; ANodeName, ANewNodeName,
      ANewNodeValue: AnsiString);

//    procedure GetNodeName(ARootNode: IXMLNode; ANodeName, ANewNodeName: AnsiString);
    procedure SetNodeName(ARootNode: IXMLNode; ANodeName, ANewNodeName: AnsiString);

    procedure SetAttributes(ARootNode: IXMLNode; AAttribute, AValue, ANewValue: AnsiString);
    function GetNodeValue(ARootNode: IXMLNode; ANodeName: AnsiString): AnsiString;
    procedure SetNodeValue(ARootNode: IXMLNode; ANodeName: AnsiString; AValue: AnsiString);

    procedure DeleteNodeInTemplate(ARootNode: IXMLNode; ANodeName: AnsiString);
    procedure DeleteNodeInDataSets(ARootNode: IXMLNode; ANodeName: AnsiString);

    property TempRootNode: IXMLNode read FTempRootNode write FTempRootNode;
    property DataRootNode: IXMLNode read FDataRootNode write FDataRootNode;
  end;

{$ENDIF}
implementation
{$IFDEF VCL6ORABOVE}

uses
  SysUtils, PDCatalog, PDDictionary, PDBaseObject, PDArray, PDString,
  PDIndirectRef, gtConstants, PDDocument, MemoryStream, PDStream, PDInteger,
  gtMethods, PDFormField;

{ TgtPDXFADocument }

constructor TgtPDXFADocument.Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
  ADataSetStream, ATemplateStream: TStream);
begin
  FParentElement := AParentElement;
  FParentDoc := AParentDoc;

  FDataSetDoc := NewXMLDocument;
  FDataSetDoc.Active := True;
  FDataSetDoc.LoadFromStream(ADataSetStream);

  FTemplateDoc := NewXMLDocument;
  FTemplateDoc.Active := True;
  FTemplateDoc.LoadFromStream(ATemplateStream);

  FDataRootNode := FDataSetDoc.DocumentElement;
  FTempRootNode := FTemplateDoc.DocumentElement;
end;

procedure TgtPDXFADocument.DeleteNodeInDataSets(ARootNode: IXMLNode;
  ANodeName: AnsiString);
var
  LI: Integer;
  LS: AnsiString;
begin
  for LI := 0 to ARootNode.ChildNodes.Count - 1 do
  begin
    LS := ARootNode.ChildNodes[LI].NodeName;
    if (LS = ANodeName) then
    begin
      ARootNode.ChildNodes.Delete(LI);
      Exit;
    end
    else if ARootNode.ChildNodes[LI].HasChildNodes then
      DeleteNodeInDataSets(ARootNode.ChildNodes[LI], ANodeName);
  end;
end;

procedure TgtPDXFADocument.DeleteNodeInTemplate(ARootNode: IXMLNode;
  ANodeName: AnsiString);
var
  LI: Integer;
  LS: AnsiString;
begin
  for LI := 0 to ARootNode.ChildNodes.Count - 1 do
  begin
    LS := ARootNode.ChildNodes[LI].NodeName;
    if (LS = 'field') then
    begin
      if (ARootNode.ChildNodes[LI].Attributes['name'] = ANodeName) then
      begin
        ARootNode.ChildNodes.Delete(LI);
        Exit;
      end;
    end
    else if ARootNode.ChildNodes[LI].HasChildNodes then
      DeleteNodeInTemplate(ARootNode.ChildNodes[LI], ANodeName);
  end;
end;

destructor TgtPDXFADocument.Destroy;
begin
  FDataSetDoc.Active := False;
  FTemplateDoc.Active := False;
//  if Assigned(FDataSetDoc) then FreeAndNil(FDataSetDoc);
//  if Assigned(FTemplateDoc) then FreeAndNil(FTemplateDoc);
  if Assigned(FTemplateStream) then FreeAndNil(FTemplateStream);
  if Assigned(FDataSetStream) then FreeAndNil(FDataSetStream);

  inherited;
end;

function TgtPDXFADocument.GetNodeValue(ARootNode: IXMLNode;
  ANodeName: AnsiString): AnsiString;
var
  LI, LChildCount: Integer;
  LNodeName: AnsiString;
begin
  Result := '';
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to (LChildCount - 1) do
  begin
    LNodeName := ARootNode.ChildNodes[LI].NodeName;
    if (LNodeName = ANodeName) then
    begin
      Result := ARootNode.ChildNodes[LI].Text;
      Exit;
    end
    else
    begin
      if (ARootNode.ChildNodes[LI].HasChildNodes) then
        Result := GetNodeValue(ARootNode.ChildNodes[LI], ANodeName);
    end;
  end;
end;

procedure TgtPDXFADocument.UpdateNodeAt(ARootNode: IXMLNode; ANodeName,
  ANewNodeName, ANewNodeValue: AnsiString);
var
  LI: Integer;
  LChildCount: Integer;
  LNodeName: AnsiString;
begin
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to (LChildCount - 1) do
  begin
    LNodeName := ARootNode.ChildNodes[LI].NodeName;
    if (LNodeName = ANodeName) then
    begin
      ARootNode.ChildNodes.Delete(LI);
      ARootNode.AddChild(ANewNodeName, LI);
      ARootNode.ChildNodes[LI].NodeValue := ANewNodeValue;
      Exit;
    end
    else
    begin
      if (ARootNode.ChildNodes[LI].HasChildNodes) then
        UpdateNodeAt(ARootNode.ChildNodes[LI], ANodeName, ANewNodeName, ANewNodeValue)
    end;
  end;
end;

procedure TgtPDXFADocument.Update;
begin
  FTemplateStream := TMemoryStream.Create;
  FTemplateDoc.SaveToStream(FTemplateStream);

  FDataSetStream := TMemoryStream.Create;
  FDataSetDoc.SaveToStream(FDataSetStream);

  UpdateXFAObj('template', FTemplateStream);
  UpdateXFAObj('datasets', FDataSetStream);
end;

procedure TgtPDXFADocument.SetAttributes(ARootNode: IXMLNode; AAttribute,
  AValue, ANewValue: AnsiString);
var
  LI, LChildCount: Integer;
  LName: AnsiString;
begin
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to (LChildCount - 1) do
  begin
    LName := ARootNode.ChildNodes[LI].NodeName;
    if ((LName = 'field') or (LName = 'exclGroup')) then
    begin
      if (ARootNode.ChildNodes[LI].Attributes[AAttribute] = AValue) then
      begin
        ARootNode.ChildNodes[LI].Attributes[AAttribute] := ANewValue;
        Exit;
      end
    end
    else
    begin
      if (ARootNode.ChildNodes[LI].HasChildNodes) then
        SetNodeName(ARootNode.ChildNodes[LI], AValue, ANewValue);
    end;
  end;
end;

procedure TgtPDXFADocument.SetNodeName(ARootNode: IXMLNode; ANodeName,
  ANewNodeName: AnsiString);
var
  LI, LChildCount: Integer;
  LName: AnsiString;
begin
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to (LChildCount - 1) do
  begin
    LName := ARootNode.ChildNodes[LI].NodeName;
    if (LName = 'field') or (LName = 'exclGroup') then
    begin
      if (ARootNode.ChildNodes[LI].Attributes['name'] = ANodeName) then
      begin
        ARootNode.ChildNodes[LI].Attributes['name'] := ANewNodeName;
        Exit;
      end
    end
    else
    begin
      if (ARootNode.ChildNodes[LI].HasChildNodes) then
        SetNodeName(ARootNode.ChildNodes[LI], ANodeName, ANewNodeName);
    end;
  end;
end;

procedure TgtPDXFADocument.SetNodeValue(ARootNode: IXMLNode; ANodeName: AnsiString;
  AValue: AnsiString);
var
  LI, LChildCount: Integer;
  LNodeName: AnsiString;
begin
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to (LChildCount - 1) do
  begin
    LNodeName := ARootNode.ChildNodes[LI].NodeName;
    if (LNodeName = ANodeName) then
    begin
      ARootNode.ChildNodes[LI].Text := AValue;
      Exit;
    end
    else
    begin
      if (ARootNode.ChildNodes[LI].HasChildNodes) then
        SetNodeValue(ARootNode.ChildNodes[LI], ANodeName, AValue);
    end;
  end;
end;

procedure TgtPDXFADocument.UpdateXFAObj(AStr: AnsiString; AStream: TMemoryStream);
var
  LObj: TgtPDBaseObject;
  LI, LPosition: Integer;
  LgtMemStream: TgtMemoryStream;
  LDict: TgtPDDictionary;
  LPDStream: TgtPDStream;
  LStream: TMemoryStream;
begin
  LPosition := ParseMemStream(AStream);
  AStream.Position := LPosition + 2;

  LStream := TMemoryStream.Create;
  LStream.CopyFrom(AStream, AStream.Size - LPosition - 4);

  LObj := TgtPDDictionary(TgtPDCatalog(FParentElement).AcroFormField).LookUp(PDF_XFA);
  if (Assigned(LObj) and (LObj.IsArray)) then
  begin
    for LI := 0 to TgtPDArray(LObj).GetLength - 1 do
    begin
      if ((TgtPDArray(LObj).Get(LI) is TgtPDString) and
        (TgtPDString(TgtPDArray(LObj).Get(LI)).Value = AStr)) then
      begin
        LgtMemStream := TgtMemoryStream.Create(LStream, 0, 0, False);
        LgtMemStream.Reset;

        TgtPDDocument(FParentDoc).LastObjectNumber :=
          TgtPDDocument(FParentDoc).LastObjectNumber + 1;

        LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

        LDict.Add(PDF_LENGTH, TgtPDInteger.Create(LStream.Size));

        LPDStream := TgtPDStream.Create(LgtMemStream, LDict,
          TgtPDDocument(FParentDoc).LastObjectNumber, 0);

        TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LPDStream);

        TgtPDArray(LObj).Remove(LI + 1);

        TgtPDArray(LObj).Insert(TgtPDIndirectRef.Create(
          LPDStream.ObjNumber, LPDStream.GenNumber), LI + 1);
      end;
    end;
  end;
end;
{$ENDIF}
end.
