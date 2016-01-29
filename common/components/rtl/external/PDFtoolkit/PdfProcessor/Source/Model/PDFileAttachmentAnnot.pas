unit PDFileAttachmentAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, gtConstants, PDFileSpec,
  Classes;

type
  //The name of an icon to be used in displaying the annotation.
  TgtFileAttachmentIcon = (faGraph, faPaperclip, faPushPin, faTag);

  TgtPDFileAttachmentAnnot = class(TgtPDAnnot)
  private
    FIconColor: TgtPDColorValue;
    FSubject: AnsiString;
    FAuthor: AnsiString;
    FAttachName: AnsiString;
    FFileAttachmentIcon: TgtFileAttachmentIcon;
    FFileSpec: TgtPDFileSpec;

    function GetFileName: AnsiString;
    function GetIconColor: TgtPDColorValue;
    function GetSubject: AnsiString;
    function GetAuthor: AnsiString;
    function GetAttachmentName: AnsiString;
    function GetAttachmentIcon: TgtFileAttachmentIcon;

    procedure SetFileName(const Value: AnsiString);
    procedure SetIconColor(const Value: TgtPDColorValue);
    procedure SetSubject(const Value: AnsiString);
    procedure SetAuthor(const Value: AnsiString);
    procedure SetAttachmentName(const Value: AnsiString);
    procedure SetAttachmentIcon(const Value: TgtFileAttachmentIcon);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property FileName: AnsiString read GetFileName write SetFileName;
    property IconColor: TgtPDColorValue read GetIconColor write SetIconColor;
    property Subject: AnsiString read GetSubject write SetSubject;
    property Author: AnsiString read GetAuthor write SetAuthor;
    property AttachmentName: AnsiString read GetAttachmentName write SetAttachmentName;
    property AttachmentIcon: TgtFileAttachmentIcon read GetAttachmentIcon
      write SetAttachmentIcon default faPushPin;
    procedure SaveToStream(AStream: TStream);
  end;

implementation

{ TgtPDFileAttachmentAnnot }

uses
  PDDictionary, PDName, PDString, PDArray, PDReal, PDInteger, Stream;

constructor TgtPDFileAttachmentAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotFileAttachment;
end;

constructor TgtPDFileAttachmentAnnot.Create;
begin
  inherited;
  AnnotType := annotFileAttachment;
  FFileAttachmentIcon := faPushPin;
  FFileSpec := TgtPDFileSpec.Create;
  FIconColor.ColorSpace := DeviceRGB;
  FIconColor.Value[0] := 1;
  FIconColor.Value[1] := 0;
  FIconColor.Value[2] := 0;
end;

destructor TgtPDFileAttachmentAnnot.Destroy;
begin

  inherited;
end;

function TgtPDFileAttachmentAnnot.GetAttachmentIcon: TgtFileAttachmentIcon;
var
  LObj: TgtPDBaseObject;
  LValue: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NAME);
    if Assigned(LObj) and LObj.IsName then
    begin
      LValue := TgtPDName(LObj).Value;
      if LValue = 'PDF_GRAPH' then
        FFileAttachmentIcon := faGraph
      else if LValue = 'PDF_PUSHPIN' then
        FFileAttachmentIcon := faPushPin
      else if LValue = 'PDF_PAPERCLIP' then
        FFileAttachmentIcon := faPaperclip
      else if LValue = 'PDF_TAG' then
        FFileAttachmentIcon := faTag;
    end;
  end;
  Result := FFileAttachmentIcon;
end;

function TgtPDFileAttachmentAnnot.GetAttachmentName: AnsiString;
begin
  Result := FAttachName;
end;

function TgtPDFileAttachmentAnnot.GetAuthor: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FAuthor = '' then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
      if Assigned(LObj) and LObj.IsString then
        FAuthor := TgtPDString(LObj).Value;
    end;
  end;
  Result := FAuthor;
end;

function TgtPDFileAttachmentAnnot.GetFileName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FFileSpec) then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FS);
      if Assigned(LObj) then
      begin
        if LObj.IsString then
        begin
          FFileSpec := TgtPDFileSpec.Create(nil);
          FFileSpec.FileName := TgtPDString(LObj).Value;
        end
        else if LObj.IsDict then
        begin
          FFileSpec := TgtPDFileSpec.Create(LObj);
        end;
      end;
    end;
  end;
  Result := FFileSpec.FileName;
end;

function TgtPDFileAttachmentAnnot.GetIconColor: TgtPDColorValue;
var
  LObj: TgtPDBaseObject;
  LValue: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LObj) and LObj.IsArray then
    begin
      FIconColor.ColorSpace := DeviceRGB;
      LValue := TgtPDArray(LObj).Get(0);
      if LValue.IsReal then
        FIconColor.Value[0] := TgtPDReal(LValue).Value
      else if LValue.IsInteger then
        FIconColor.Value[0] := TgtPDInteger(LValue).Value;
      LValue := TgtPDArray(LObj).Get(1);
      if LValue.IsReal then
        FIconColor.Value[1] := TgtPDReal(LValue).Value
      else if LValue.IsInteger then
        FIconColor.Value[1] := TgtPDInteger(LValue).Value;
      LValue := TgtPDArray(LObj).Get(2);
      if LValue.IsReal then
        FIconColor.Value[2] := TgtPDReal(LValue).Value
      else if LValue.IsInteger then
        FIconColor.Value[2] := TgtPDInteger(LValue).Value;
    end;
  end;
  Result := FIconColor;
end;

function TgtPDFileAttachmentAnnot.GetSubject: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FSubject = '' then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SUBJ);
      if Assigned(LObj) and LObj.IsString then
        FSubject := TgtPDString(LObj).Value;
    end;
  end;
  Result := FSubject;
end;

procedure TgtPDFileAttachmentAnnot.SaveToStream(AStream: TStream);
var
  LStream: TgtStream;
  LBuffer: AnsiString;
  LChar: Integer;
begin
  LStream := FFileSpec.EmbeddedFileStream;
//  SetLength(LBuffer, 10000);
//  LStream.Write(LBuffer);
//  AStream.Write(LBuffer[1], Length(LBuffer));
  LStream.Reset;
  LChar := LStream.GetChar;
  while LChar <> ENDOFFILE do
  begin
    LBuffer := LBuffer + AnsiChar(LChar);
    LChar := LStream.GetChar;
  end;
  TFileStream(AStream).Position := 0;
  TFileStream(AStream).Write(LBuffer[1], Length(LBuffer));
end;

procedure TgtPDFileAttachmentAnnot.SetAttachmentIcon(
  const Value: TgtFileAttachmentIcon);
var
  LObj: TgtPDBaseObject;
  LValue: AnsiString;
begin
  case Value of
    faGraph: LValue := PDF_GRAPH;
    faPaperclip: LValue := PDF_PUSHPIN;
    faPushPin: LValue := PDF_PAPERCLIP;
    faTag: LValue := PDF_TAG;
  end;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NAME);
    if Assigned(LObj) then
    begin
      TgtPDName(LObj).Value := LValue;
    end
    else
    begin
      LObj := TgtPDName.Create(LValue);
      TgtPDDictionary(FBaseObject).Add(PDF_NAME, LObj);
    end;
  end;
  FFileAttachmentIcon := Value;
end;

procedure TgtPDFileAttachmentAnnot.SetAttachmentName(const Value: AnsiString);
begin
  if Assigned(FBaseObject) then
  begin

  end;
  FAttachName := Value;
end;

procedure TgtPDFileAttachmentAnnot.SetAuthor(const Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FAuthor = '' then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := Value
      else
      begin
        LObj := TgtPDString.Create(Value);
        TgtPDDictionary(FBaseObject).Add(PDF_T, LObj);
      end;
    end;
  end;
  FAuthor := Value;
end;

procedure TgtPDFileAttachmentAnnot.SetFileName(const Value: AnsiString);
begin
  if Assigned(FBaseObject) then
  begin

  end;
  FFileSpec.FileName := Value;
end;

procedure TgtPDFileAttachmentAnnot.SetIconColor(const Value: TgtPDColorValue);
var
  LObj: TgtPDBaseObject;
  LValue: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LObj) then
    begin
      LValue := TgtPDArray(LObj).Get(0);
      if Assigned(LValue) then
      begin
        if LValue.IsReal then
          TgtPDReal(LValue).Value := Value.Value[0]
        else
        begin
          TgtPDArray(LObj).Remove(0);
          LValue := TgtPDReal.Create(Value.Value[0]);
          TgtPDArray(LObj).Insert(LValue, 0);
        end;
      end;
      LValue := TgtPDArray(LObj).Get(1);
      if Assigned(LValue) then
      begin
        if LValue.IsReal then
          TgtPDReal(LValue).Value := Value.Value[1]
        else
        begin
          TgtPDArray(LObj).Remove(1);
          LValue := TgtPDReal.Create(Value.Value[1]);
          TgtPDArray(LObj).Insert(LValue, 1);
        end;
      end;
      LValue := TgtPDArray(LObj).Get(2);
      if Assigned(LValue) then
      begin
        if LValue.IsReal then
          TgtPDReal(LValue).Value := Value.Value[2]
        else
        begin
          TgtPDArray(LObj).Remove(2);
          LValue := TgtPDReal.Create(Value.Value[2]);
          TgtPDArray(LObj).Add(LValue);
        end;
      end;
    end;
  end;
  FIconColor := Value;
end;

procedure TgtPDFileAttachmentAnnot.SetSubject(const Value: AnsiString);
begin

  if Assigned(FBaseObject) then
  begin

  end;
  FSubject := Value;
end;

end.
