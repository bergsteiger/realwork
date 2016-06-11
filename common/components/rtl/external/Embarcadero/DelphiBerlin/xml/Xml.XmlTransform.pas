{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Xml.XmlTransform;

interface

uses
  System.Classes, System.SysUtils, Xml.Xmldom;

type
  TranslateException = class(Exception);

{ TXMLTransform }

  TTranslateEvent = procedure(Sender: TObject; Id: string;
    SrcNode: IDOMNode; var Value: string; DestNode: IDOMNode) of object;
  TRowEvent = procedure(Sender: TObject; Id: string;
    SrcNode: IDOMNode; DestNode: IDOMNode) of object;

  TXMLTransform = class(TComponent)
  private
    FEncoding: string;
    FEncodingTrans: string;
    FDirectionToCds: Boolean;
    FVersion: string;
    FSourceXmlFile: string;
    FSourceXmlDocument: IDOMDocument;
    FSourceXml: string;
    FTransformationFile: string;
    FTransformationDocument: IDOMDocument;
    FEmptyDestinationDocument: IDOMDocument;  //Insert into this, if present
    FResultDocument: IDOMDocument;
    FResultString: string;
    FOnTranslate: TTranslateEvent;
    FBeforeEachRow: TRowEvent;
    FAfterEachRow: TRowEvent;
    FBeforeEachRowSet: TRowEvent;
    FAfterEachRowSet: TRowEvent;
  protected
    procedure Translate(const Id: string; const SrcNode: IDOMNode;
      var SrcValue: string; const DestNode: IDOMNode); dynamic;
    function DoTransform(const XMLSrc, XMLExtract, XMLOut: IDOMDocument): string;
    procedure Transform(TransNode, SrcNode, DestNode: IDOMNode;
      Count: Integer; InFromList, InDestList, InIdStrList, InValueList,
      InOptionalList, InDateFormatList, InDateFormatTypeList,
      InMapValuesList: TStringList);
    function GetData: string;
    function GetResultString: string;
  public
    function TransformXML(const SourceXml: string;
      const ATransformationFile: string = ''): string;
    property Data: string read GetData ;
    property Encoding: string read FEncoding;
    property EncodingTrans: string read FEncodingTrans;
    property SourceXmlDocument: IDOMDocument read FSourceXmlDocument write FSourceXmlDocument;
    property SourceXmlFile: string read FSourceXmlFile write FSourceXmlFile;
    property SourceXml: string read FSourceXml write FSourceXml;
    property TransformationDocument: IDOMDocument read FTransformationDocument write FTransformationDocument;
    property EmptyDestinationDocument: IDOMDocument read FEmptyDestinationDocument write FEmptyDestinationDocument;
    property ResultDocument: IDOMDocument read FResultDocument;
    property ResultString: string read GetResultString;
  published
    property TransformationFile: string read FTransformationFile write FTransformationFile;
    property OnTranslate: TTranslateEvent read FOnTranslate write FOnTranslate;
    property BeforeEachRow: TRowEvent read FBeforeEachRow write FBeforeEachRow;
    property AfterEachRow: TRowEvent read FAfterEachRow write FAfterEachRow;
    property BeforeEachRowSet: TRowEvent read FBeforeEachRowSet write FBeforeEachRowSet;
    property AfterEachRowSet: TRowEvent read FAfterEachRowSet write FAfterEachRowSet;
  end;

implementation

uses
  Xml.XMLConst, Xml.xmlutil;

procedure TransformError(const Msg: string);
begin
  raise TranslateException.Create(Msg);
end;

{ TXMLTransform }

procedure TXMLTransform.Translate(const Id: string; const SrcNode: IDOMNode;
  var SrcValue: string; const DestNode: IDOMNode);
begin
  if Assigned(FOnTranslate) then
    FOnTranslate(Self, Id, SrcNode, SrcValue, DestNode);
end;

function TXMLTransform.GetData: string;
var
  FSrcDom: IDOMDocument;
  FTransDom: IDOMDocument;
begin
  if FSourceXMLFile = '' then
  begin
    if FSourceXml <> '' then
      FSrcDom := LoadDocFromString(FSourceXml)
    else if FSourceXmlDocument = nil then
      TransformError(SMissingSourceFile)
    else
      FSrcDom := FSourceXmlDocument;
  end
  else
    FSrcDom := LoadDocFromFile(FSourceXMLFile);

  if FTransformationFile = '' then
  begin
    if FTransformationDocument = nil then
      TransformError(SMissingTransform)
    else
      FTransDom := FTransformationDocument;
  end
  else
    FTransDom := LoadDocFromFile(FTransformationFile);
  Result := DoTransform(FSrcDom, FTransDom, FEmptyDestinationDocument);
end;

function TXMLTransform.GetResultString: string;
begin
  if (FResultString = '') and (FResultDocument <> nil) then
    FResultString := (FResultDocument as IDOMPersist).xml;
  Result := FResultString;
end;

function TXMLTransform.TransformXML (const SourceXML: string;
      const ATransformationFile: string = ''): string;
var
  SrcDom: IDOMDocument;
  TransDom: IDOMDocument;
begin
  Result := '';
  TransDom := nil;
  SrcDom := nil;
  if SourceXml <> '' then
    SrcDom := LoadDocFromString(SourceXML);
  if ATransformationFile <> '' then
    TransDom := LoadDocFromFile(ATransformationFile)
  else
  if FTransformationFile <> '' then
    TransDom := LoadDocFromFile(FTransformationFile)
  else
    TransformError(SMissingTransform);
  if (TransDom <> nil) and (SrcDom <> nil) then
    Result := DoTransForm(SrcDom, TransDom, FEmptyDestinationDocument);
end;

function TXMLTransform.DoTransform(const XMLSrc, XMLExtract, XMLOut: IDOMDocument): string;
var
  TransRoot: IDOMNode;
  SrcRoot, DestRoot, DestRootClone, Node, TransformNode: IDOMNode;
  I: Integer;
  cdata_skeleton: string;
  Skeleton: IDOMDocument;
  Direction: string;
  MajorVersion, MinorVersion: string;
begin
  FResultDocument := nil;
  FResultString := '';
  FEncoding := GetEncoding(XMLSrc);
  TransRoot := XMLExtract.documentElement;
  SrcRoot := XMLSrc.documentElement;
  if XMLOut <> nil then
    DestRootClone := XMLOut.documentElement
  else
  begin
    FVersion :=  GetAttribute(TransRoot, mx_Version);
    if FVersion <> '' then
    begin
      MajorVersion := Head(FVersion, '.', MinorVersion);
      if StrToInt(MajorVersion) < 1 then
        TransformError(SOldVersion);
    end;
    TransformNode := SelectNode(TransRoot, mx_Root + '\'+ mx_Transform);
    FEncodingTrans := GetAttribute(TransformNode, mx_DataEncoding);
    Direction := GetAttribute(TransformNode, mx_Direction);
    FDirectionToCds := (Direction = mx_ToCds);
    DestRoot := SelectNode(TransRoot,mx_Root+'\'+mx_Skeleton);
    if DestRoot.ChildNodes.item[0].nodeType = ELEMENT_NODE then
      DestRootClone := DestRoot.CloneNode(True)
    else if DestRoot.ChildNodes.item[0].nodeType = CDATA_SECTION_NODE then
    begin
      cdata_skeleton := DestRoot.ChildNodes.item[0].nodeValue;
      Skeleton := LoadDocFromString(cdata_skeleton);
      DestRootClone := Skeleton.documentElement;
    end;
  end;

  Node := SelectNode(TransRoot, mx_Root + '\' + mx_Transform);
  if Node <> nil then
    for I := 0 to Node.childNodes.length-1 do
      Transform(Node.childNodes.item[I], SrcRoot, DestRootClone,
      0, nil, nil, nil, nil, nil, nil, nil, nil);

  if XmlOut <> nil then
  begin
    FResultDocument := XMLOut;
    Result := (DestRootClone as IDOMNodeEx).xml;
  end
  else
  begin
    if Skeleton = nil then
      Result := (DestRootClone.childNodes.item[0] as IDOMPersist).xml
    else
    begin
      FResultDocument := Skeleton;
      Result := (Skeleton as IDOMPersist).xml;
    end;
  end;
  FResultString := Result;
end;

procedure TXMLTransform.Transform(TransNode, SrcNode, DestNode: IDOMNode;
    Count: Integer; InFromList, InDestList, InIdStrList, InValueList,
    InOptionalList, InDateFormatList, InDateFormatTypeList,
    InMapValuesList: TStringList);
var
  I, J: Integer;
  From, Dest: string;
  Value, AttrName: string;
  IdStr, RepeatName: string;
  Optional, Map_Values: string;
  DefaultValue, DateFormat, DateFormatType: string;
  More, BeforeEachRowSet: Boolean;
  RepeatDestNode, AttrNode, TmpNode: IDOMNode;
  FromList, DestList, IdStrList, ValueList, OptionalList: TStringList;
  DateFormatList, DateFormatTypeList, MapValuesList: TStringList;
begin
  if TransNode.NodeName = mx_TranslateEach then
  begin
    AttrNode := TransNode.attributes.getNamedItem(mx_FROM);
    if AttrNode <> nil then From := AttrNode.nodeValue else From := '';
    AttrNode := TransNode.attributes.getNamedItem(mx_DEST);
    if AttrNode <> nil then Dest := AttrNode.nodeValue else Dest := '';
    AttrNode := TransNode.attributes.getNamedItem(mx_ID);
    if AttrNode <> nil then IdStr := AttrNode.nodeValue else IdStr := '';
    SrcNode := SelectNode(SrcNode, From);
    if SrcNode <> nil then
    begin
      RepeatName := SrcNode.nodeName;
      DestNode := SelectCreateNode(DestNode, Dest, AttrName);
    end
    else
    begin
      RepeatName := '';
      DestNode := SelectCreateNode(DestNode, Dest, AttrName);
      if (DestNode <> nil) and (DestNode.parentNode <> nil) then
      begin
        TmpNode := DestNode;
        DestNode := DestNode.parentNode;
        DestNode.removeChild(TmpNode);
      end;
    end;
    if (SrcNode <> nil) and (DestNode <> nil) then
    begin
      More := True;
      BeforeEachRowSet := True;
      RepeatDestNode := DestNode.cloneNode(True);
    end
    else
    begin
      More := False;
      BeforeEachRowSet := False;
      RepeatDestNode := nil;
    end;
    if More and Assigned(FBeforeEachRowSet) then
      FBeforeEachRowSet(Self, IdStr, SrcNode, DestNode);

    FromList := TStringList.Create;
    DestList := TStringList.Create;
    IdStrList := TStringList.Create;
    ValueList := TStringList.Create;
    OptionalList := TStringList.Create;
    DateFormatList := TStringList.Create;
    DateFormatTypeList := TStringList.Create;
    MapValuesList := TStringList.Create;
    try
      while More do
      begin
        if Assigned(FBeforeEachRow) then
          FBeforeEachRow(Self, IdStr, SrcNode, DestNode);

        for I := 0 to TransNode.childNodes.length-1 do
          TransForm(TransNode.childNodes.item[i], SrcNode, DestNode,
             I, FromList, DestList, IdStrList, ValueList, OptionalList,
             DateFormatList, DateFormatTypeList, MapValuesList);

        if Assigned(FAfterEachRow) then
          FAfterEachRow(Self, IdStr, SrcNode, DestNode);

        while More do
        begin
          SrcNode := SrcNode.nextSibling;
          if SrcNode = nil then
            More := False
          else
          begin
            if SrcNode.nodeName = RepeatName then
            begin //found next\
              DestNode := SelectCreateSibling(DestNode, RepeatDestNode);
              if DestNode = nil then More := False;
              Break;
            end;
          end;
        end;
      end; //while More

      if BeforeEachRowSet and Assigned(FAfterEachRowSet) then
        FAfterEachRowSet(Self, IdStr, SrcNode, DestNode);

      {We don't have any items, but must keep List.Count = Count}
      if InFromList <> nil then
      begin
        InFromList.Add(EmptyStr);
        InDestList.Add(EmptyStr);
        InIdStrList.Add(EmptyStr);
        InValueList.Add(EmptyStr);
        InOptionalList.Add(EmptyStr);
        InDateFormatList.Add(EmptyStr);
        InDateFormatTypeList.Add(EmptyStr);
        InMapValuesList.Add(EmptyStr);
      end;
    finally
      FromList.Free;
      DestList.Free;
      IdStrList.Free;
      ValueList.Free ;
      OptionalList.Free;
      DateFormatList.Free;
      DateFormatTypeList.Free;
      MapValuesList.Free;
    end;
  end // TransNode.NodeName = mx_TranslateEach
  else if TransNode.NodeName = mx_Translate then //Field-translation
  begin
    if (InFromList = nil) or (Count >= InFromList.Count) then
    begin
      From := ''; Dest := ''; IdStr := ''; Value := ''; Optional := '';
      DateFormat := ''; DateFormatType  := ''; Map_Values := '';
      for J := 0 to TransNode.attributes.length-1 do
      begin
        TmpNode := TransNode.attributes.item[J];
        if TmpNode.NodeName = mx_FROM then
          From := TmpNode.nodeValue
        else if TmpNode.NodeName = mx_DEST then
          Dest := TmpNode.nodeValue
        else if TmpNode.NodeName = mx_VALUE then
          Value := TmpNode.nodeValue
        else if TmpNode.NodeName = mx_OPTIONAL then
          Optional := TmpNode.nodeValue
        else if TmpNode.NodeName = mx_ID then
          Idstr := TmpNode.nodeValue
        else if TmpNode.NodeName = mx_DEFAULT then
          DefaultValue := TmpNode.nodeValue
        else if (TmpNode.NodeName = mx_DATETIMEFORMAT) or
           (TmpNode.NodeName = mx_DATEFORMAT) or
           (TmpNode.NodeName = mx_TIMEFORMAT) then
        begin
          DateFormat := TmpNode.NodeValue;
          DateFormatType := TmpNode.NodeName;
        end
        else if TmpNode.NodeName = mx_MAPVALUES then
           Map_Values := TmpNode.NodeValue;
      end; // for

      if InFromList <> nil then
      begin
        InFromList.Add(From);
        InDestList.Add(Dest);
        InIdStrList.Add(IdStr);
        InValueList.Add(Value);
        InOptionalList.Add(Optional);
        InDateFormatList.Add(DateFormat);
        InDateFormatTypeList.Add(DateFormatType);
        InMapValuesList.Add(Map_Values);
      end;
    end // if (InFromList = nil) ...
    else
    begin
      From := InFromList[Count];
      Dest := InDestList[Count];
      IdStr := InIdStrList[Count];
      Value := InValueList[Count];
      Optional := InOptionalList[Count];
      DateFormat := InDateFormatList[Count];
      DateFormatType := InDateFormatTypeList[Count];
      Map_Values := InMapValuesList[Count];
    end;

    SrcNode := SelectNode(SrcNode, From);
    if SrcNode <> nil then
    begin
      if Value = '' then
      begin
        if SrcNode.nodeType = ELEMENT_NODE then
          Value := (SrcNode as IDOMNodeEx).Text
        else
          Value := SrcNode.nodeValue;
      end;
      if (IdStr <> '') and Assigned(FOnTranslate) then
        FOnTranslate(Self, IdStr, SrcNode, Value, DestNode);
    end;

    if Value = '' then
      if DefaultValue <> '' then
        Value := DefaultValue;

    if Value <> '' then
    begin
      if Map_Values <> '' then
        Value := MapValues(Map_Values, Value);
      if Value = '' then
        if DefaultValue <> '' then
          Value := DefaultValue;
      if DateFormatType <> '' then
        Value := MapDateTime(DateFormatType, DateFormat, Value, FDirectionToCds);
      if (Optional = '') or (Value <> '') then
        PutValue(DestNode, Dest, Value);
    end
    else if Optional = '' then // = '1'
      PutValue(DestNode, Dest, '');
    if (Optional <> '') and (Value = '') and
       (Dest <> '') and (Dest[1] <> '@') then
    begin
      TmpNode := SelectNode(DestNode, Dest);
      if TmpNode <> nil then
        TmpNode.parentNode.removeChild(TmpNode);
    end;
  end; // else if TransNode.NodeName = mx_Translate
end;

end.
