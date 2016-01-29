unit PDDocInfo;
{$I ..\Utils\gtCompilerDefines.inc}

interface

uses
  classes, PDCatalog, PDBaseObject, gtObject;

type

  TgtPDCustomInfoSchema = (scAdobePDF,
    scBasic,
    scDublinCore,
    scJobTicket,
    scRightsManagement,
    scPagedText
    );

  TgtPDDocInfo = class(TgtObject)
  private
    FParentDoc: TgtObject;
    FCatalog: TgtPDCatalog;
    FPDFInfoObj: TgtPDBaseObject;

    FAuthor: AnsiString;
    FCreateDate: AnsiString;
    FCreator: AnsiString;
    FModDate: AnsiString;
    FProducer: AnsiString;
    FSubject: AnsiString;
    FTitle: AnsiString;
    FKeyword: AnsiString;

    function GetAuthor: AnsiString;
    function GetCreateDate: AnsiString;
    function GetCreator: AnsiString;
    function GetModDate: AnsiString;
    function GetProducer: AnsiString;
    function GetSubject: AnsiString;
    function GetTitle: AnsiString;
    function GetKeyword: AnsiString;

    procedure SetAuthor(Value: AnsiString);
    procedure SetCreateDate(Value: AnsiString);
    procedure SetCreator(Value: AnsiString);
    procedure SetModDate(Value: AnsiString);
    procedure SetProducer(Value: AnsiString);
    procedure SetSubject(Value: AnsiString);
    procedure SetTitle(Value: AnsiString);
    procedure SetKeyword(Value: AnsiString);

  public
    constructor Create(AParentDoc: TgtObject; ACatalog: TgtPDCatalog);
    destructor Destroy; override;

    procedure GetInfo(const InfoKey: AnsiString; var Value: AnsiString);
    procedure SetDocInfo(const InfoKey: AnsiString; const Value: AnsiString);
    function CountXMPMetadataArrayItems(const Namespace: AnsiString; const
      Path: AnsiString): Integer;
    function GetXMPMetadataArrayItem(const NameSpaceName: AnsiString; const
      Path: AnsiString; Index: Integer): AnsiString;
    procedure SetXMPMetadataArrayItem(const NameSpace: AnsiString;
      const NamespacePrefix: AnsiString; const Path: AnsiString; Index: Integer;
      const NewValue: AnsiString);
    function GetXMLMetaData: AnsiString;
    procedure AddCustomPDMetadata(Name, Value: AnsiString; Schema: TgtPDCustomInfoSchema);

    property Author: AnsiString read GetAuthor write SetAuthor;
    property CreateDate: AnsiString read GetCreateDate write SetCreateDate;
    property Creator: AnsiString read GetCreator write SetCreator;
    property ModeDate: AnsiString read GetModDate write SetModDate;
    property Producer: AnsiString read GetProducer;
    property Subject: AnsiString read GetSubject write SetSubject;
    property Title: AnsiString read GetTitle write SetTitle;
    property Keyword: AnsiString read GetKeyword write SetKeyword;
  end;

implementation

uses
  PDDocument, PDDictionary, {$IFDEF VCL6ORABOVE}XMLDoc, {$ENDIF}gtConstants, gtMethods, PDName, PDString,
  gtLogger, PDIndirectRef, gtTypes;


{ TgtPDDocInfo }

procedure TgtPDDocInfo.AddCustomPDMetadata(Name, Value: AnsiString;
  Schema: TgtPDCustomInfoSchema);
begin

end;

function TgtPDDocInfo.CountXMPMetadataArrayItems(const Namespace,
  Path: AnsiString): Integer;
begin
  Result := 0;
end;

constructor TgtPDDocInfo.Create(AParentDoc: TgtObject; ACatalog: TgtPDCatalog);
begin
  FParentDoc := AParentDoc;
  FCatalog := ACatalog;

  FPDFInfoObj := TgtPDDocument(FParentDoc).BaseDoc.GetDocInfo;
  SetProducer(PDFPRODUCER);
end;

destructor TgtPDDocInfo.Destroy;
begin

  inherited;
end;

function TgtPDDocInfo.GetAuthor: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if FAuthor = '' then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_AUTHOR);
    if Assigned(LObj) then
    begin
      FAuthor := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FAuthor;
end;

function TgtPDDocInfo.GetCreateDate: AnsiString;
var
  LObj: TgtPDBaseObject;
  LDate: AnsiString;
  LDateRec: TgtDate;
begin
  if (FCreateDate = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_CREATIONDATE);
    if Assigned(LObj) then
    begin
      LDate := TgtPDString(LObj).HexToString;
      LDateRec := PDFStringToDate(LDate);
      FCreateDate := IntegerToString(LDateRec.Day) + '/' +
        IntegerToString(LDateRec.Month) + '/' + IntegerToString(LDateRec.Year)
        + '/ ' + IntegerToString(LDateRec.Hour) + ':' +
        IntegerToString(LDateRec.Minutes) + ':' + IntegerToString(LDateRec.Seconds);
    end;
  end;
  Result := FCreateDate;
end;

function TgtPDDocInfo.GetCreator: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FCreator = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_CREATOR);
    if Assigned(LObj) then
    begin
      FCreator := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FCreator;
end;

procedure TgtPDDocInfo.GetInfo(const InfoKey: AnsiString; var Value: AnsiString);
begin
  if (InfoKey = PDF_AUTHOR) then
    Value := GetAuthor
  else if (InfoKey = PDF_SUBJECT) then
    Value := GetSubject
  else if (InfoKey = PDF_PRODUCER) then
    Value := GetProducer
  else if (InfoKey = PDF_TITLE) then
    Value := GetTitle
  else if (InfoKey = PDF_CREATOR) then
    Value := GetCreator
  else if (InfoKey = PDF_KEYWORDS) then
    Value := GetKeyword
  else if (InfoKey = PDF_MODDATE) then
    Value := GetModDate
  else if (InfoKey = PDF_CREATIONDATE) then
    Value := GetCreateDate;
end;

function TgtPDDocInfo.GetXMLMetaData: AnsiString;
//var
//  LXMPData: AnsiString;
begin
  Result := TgtPDDocument(FParentDoc).GetXMPMetadata;
end;

function TgtPDDocInfo.GetXMPMetadataArrayItem(const NameSpaceName, Path: AnsiString;
  Index: Integer): AnsiString;
begin

end;

function TgtPDDocInfo.GetKeyword: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FKeyword = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_KEYWORDS);
    if Assigned(LObj) then
    begin
      FKeyword := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FKeyword;
end;

function TgtPDDocInfo.GetModDate: AnsiString;
var
  LObj: TgtPDBaseObject;
  LDate: AnsiString;
  LDateRec: TgtDate;
begin
  if (FModDate = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_MODDATE);
    if Assigned(LObj) then
    begin
      LDate := TgtPDString(LObj).HexToString;
      LDateRec := PDFStringToDate(LDate);
      FModDate := IntegerToString(LDateRec.Day) + '/' +
        IntegerToString(LDateRec.Month) + '/' + IntegerToString(LDateRec.Year)
        + '/ ' + IntegerToString(LDateRec.Hour) + ':' +
        IntegerToString(LDateRec.Minutes) + ':' + IntegerToString(LDateRec.Seconds);
    end;
  end;
  Result := FModDate;
end;

function TgtPDDocInfo.GetProducer: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FProducer = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_PRODUCER);
    if Assigned(LObj) then
    begin
      FProducer := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FProducer;
end;

procedure TgtPDDocInfo.SetAuthor(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_AUTHOR);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_AUTHOR);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetCreateDate(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_CREATIONDATE);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_CREATIONDATE);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetCreator(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_CREATOR);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_CREATOR);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetDocInfo(const InfoKey, Value: AnsiString);
begin
  if (InfoKey = PDF_AUTHOR) then
    SetAuthor(Value)
  else if (InfoKey = PDF_PRODUCER) then
    SetProducer(Value)
  else if (InfoKey = PDF_SUBJECT) then
    SetSubject(Value)
  else if (InfoKey = PDF_KEYWORDS) then
    SetKeyword(Value)
  else if (InfoKey = PDF_TITLE) then
    SetTitle(Value)
  else if (InfoKey = PDF_CREATOR) then
    SetCreator(Value)
  else if (InfoKey = PDF_CREATIONDATE) then
    SetCreateDate(Value)
  else if (InfoKey = PDF_MODDATE) then
    SetModDate(Value);
end;

procedure TgtPDDocInfo.SetKeyword(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_KEYWORDS);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_KEYWORDS);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetModDate(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_MODDATE);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_MODDATE);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetProducer(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_PRODUCER);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    TgtPDDictionary(FPDFInfoObj).SetKeyValue(PDF_PRODUCER, TgtPDString.Create(Value, False));
  end;
end;

procedure TgtPDDocInfo.SetSubject(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_SUBJECT);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_SUBJECT);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetTitle(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_TITLE);
  if Assigned(LObj) then
    TgtPDString(LObj).HexToString := Value
  else
  begin
    LObj := TgtPDName.Create(PDF_TITLE);
    TgtPDDictionary(FPDFInfoObj).Add(LObj, TgtPDString.Create(Value, False));
    LObj.Free;
  end;
end;

procedure TgtPDDocInfo.SetXMPMetadataArrayItem(const NameSpace, NamespacePrefix,
  Path: AnsiString; Index: Integer; const NewValue: AnsiString);
begin

end;

function TgtPDDocInfo.GetSubject: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FSubject = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_SUBJECT);
    if Assigned(LObj) then
    begin
      FSubject := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FSubject;
end;

function TgtPDDocInfo.GetTitle: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FTitle = '') then
  begin
    LObj := TgtPDDictionary(FPDFInfoObj).LookUp(PDF_TITLE);
    if Assigned(LObj) then
    begin
      FTitle := TgtPDString(LObj).HexToString;
    end;
  end;
  Result := FTitle;
end;

end.
