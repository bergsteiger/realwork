unit PDSignatureField;

interface

uses
  PDFormField, PDSignature, gtObject, PDElement, PDBaseObject, Classes, Contnrs,
  gtConstants, gtTypes, SysUtils, PDIndirectRef;

type

  TgtPDSignatureField = class(TgtPDFormField)
  private
    FNormalCaption: AnsiString;
    FVisible,
    FIsBlank: Boolean;
    FSignature: TgtPDSignature;
    FPFXFileName,
    FPFXPassword: AnsiString;
    FAppearanceImage: TStream;
    FAppearanceText: Ansistring;
    function GetSignature: TgtPDSignature;
    function CreateSigDictionary(ASig: TgtPDSignature): TgtPDIndirectRef;
    function GetNormalCaption: AnsiString;
    procedure SetNormalCaption(const Value: AnsiString);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure Fill(APFXFileName, APFXPassword: AnsiString; AReason: AnsiString = '';
      ALocation: AnsiString = ''; AContactInfo: AnsiString = ''); overload;
    procedure Fill(APFXFileName, APFXPassword: AnsiString; ADateTime: TDateTime;
       AReason: AnsiString = ''; ALocation: AnsiString = ''; AContactInfo: AnsiString = ''); overload;
    function Clone: TgtPDFormField; override;
    property Visible: Boolean read FVisible write FVisible;
    property IsBlank: Boolean read FIsBlank;
    property Signature: TgtPDSignature read GetSignature;
    property AppearanceImage: TStream read FAppearanceImage write FAppearanceImage;
    property AppearanceText: Ansistring read FAppearanceText write FAppearanceText;
    property Rect;
    property NormalCaption: AnsiString read GetNormalCaption write SetNormalCaption;
//    property BackgroundColor;
    property BorderColor;
    property Font;
    // Appearence
  end;

  TgtPDSignatureFields = class(TObjectList)
  private
    function GetItem(Index: Integer): TgtPDSignatureField;
  public
    destructor Destroy; override;
    property Items[Index: Integer]: TgtPDSignatureField read GetItem; default;
  end;

implementation

{ TgtPDSignatureField }

uses
  PDDictionary, PDString, PDName, PDInteger, PDArray, PDDocument;

function TgtPDSignatureField.Clone: TgtPDFormField;
begin
  Result := TgtPDSignatureField.Create;
end;

constructor TgtPDSignatureField.Create;
begin
  inherited;
  FormFieldType := ftSignature;
end;

function TgtPDSignatureField.CreateSigDictionary(ASig: TgtPDSignature): TgtPDIndirectRef;
var
  LSigDict: TgtPDDictionary;
  LStr: Ansistring;
  LArray: TgtPDArray;
  LContents: array[1..PDF_SIGVALUELENGTH] of AnsiChar;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Sig dictionary
  LSigDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LSigDict);

  case ASig.SubFilter of
    sfX509RsaSha1: LStr := PDF_RSASHA1;
    sfPkcs7Detached: LStr := PDF_DETACHED;
    sfPkcs7Sha1: LStr := PDF_SHA1;
  end;
  with TgtPDDocument(FParentDoc).BaseDoc.Signature do
  begin
    Author := ASig.Author;
    ContactInfo := ASig.Author;
    Location := ASig.Location;
    Reason := ASig.Reason;
    Filter := ASig.Handler;
    PFXFileName := ASig.PFXFileName;
    PFXPassWord := ASig.PFXPassWord;
    Subfilter := LStr;
    DateTime := ASig.DateTime;
  end;
//  GetMem(LContents, PDF_SIGVALUELENGTH);
  FillChar(LContents, PDF_SIGVALUELENGTH, Ord(' '));
  // Dummy key to add place holder and tag for finding the offset for sig dict
  LSigDict.Add(PDF_GNOSTICETAG, TgtPDName.Create(LContents));
//  FreeMem(LContents);
  Result := TgtPDIndirectRef.Create(LSigDict.ObjNumber, LSigDict.GenNumber);
end;

constructor TgtPDSignatureField.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

destructor TgtPDSignatureField.Destroy;
begin
  if Assigned(FSignature) then FreeAndNil(FSignature);

  inherited;
end;

procedure TgtPDSignatureField.Fill(APFXFileName, APFXPassword: AnsiString;
  ADateTime: TDateTime; AReason, ALocation, AContactInfo: AnsiString);
begin
  // No task if the signature is already there
  if Assigned(Self.Signature.BaseObject) then Exit;
  with Self.Signature do
  begin
    PFXFileName := APFXFileName;
    PFXPassword := APFXPassword;
    Reason := AReason;
    Location := ALocation;
    ContactInfo := AContactInfo;
    DateTime := ADateTime;
  end;
  TgtPDDictionary(FBaseObject).SetKeyValue(PDF_V, CreateSigDictionary(Self.Signature));
  TgtPDDocument(FParentDoc).BaseDoc.SignDoc := True;
end;

procedure TgtPDSignatureField.Fill(APFXFileName, APFXPassword, AReason, ALocation,
  AContactInfo: AnsiString);
begin
  Fill(APFXFileName, APFXPassword, 0, AReason, ALocation, AContactInfo);
end;

function TgtPDSignatureField.GetNormalCaption: AnsiString;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_CA);
      if Assigned(LObj2) then
      begin
        FNormalCaption := TgtPDString(LObj2).Value;
      end;
    end;
  end;
  Result := FNormalCaption
end;

function TgtPDSignatureField.GetSignature: TgtPDSignature;
var
  LObj: TgtPDBaseObject;
  LStr: AnsiString;
begin
  if not Assigned(FSignature) then
  begin
    FSignature := TgtPDSignature.Create;
    if Assigned(FBaseObject) then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_V);
      if Assigned(LObj) and LObj.IsDict then
      begin
        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NAME);
        if Assigned(LObj) and LObj.IsString then
          FSignature.Author := TgtPDString(LObj).Value;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_REASON);
        if Assigned(LObj) and LObj.IsString then
          FSignature.Reason := TgtPDString(LObj).Value;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LOCATION);
        if Assigned(LObj) and LObj.IsString then
          FSignature.Location := TgtPDString(LObj).Value;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CONTACT);
        if Assigned(LObj) and LObj.IsString then
          FSignature.ContactInfo := TgtPDString(LObj).Value;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FILTER);
        if Assigned(LObj) and LObj.IsName then
          FSignature.Handler := TgtPDName(LObj).Value;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SUBFILTER);
        if Assigned(LObj) and LObj.IsName then
        begin
          LStr := TgtPDName(LObj).Value;
          if LStr = PDF_RSASHA1 then
            FSignature.SubFilter := sfX509RsaSha1
          else if LStr = PDF_DETACHED then
            FSignature.SubFilter := sfPkcs7Detached
          else if LStr = PDF_SHA1 then
            FSignature.SubFilter := sfPkcs7Sha1;
        end;

        LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BYTERANGE);
        if Assigned(LObj) and Lobj.IsArray then
        begin
          FSignature.SetByteOffset(TgtPDInteger(TgtPDArray(LObj).Get(0)).Value,
            TgtPDInteger(TgtPDArray(LObj).Get(1)).Value,
            TgtPDInteger(TgtPDArray(LObj).Get(2)).Value,
            TgtPDInteger(TgtPDArray(LObj).Get(3)).Value);
        end;
      end;
    end;
  end;
  Result := FSignature;
end;

procedure TgtPDSignatureField.SetNormalCaption(const Value: AnsiString);
var
  LMKObj, LObj: TgtPDBaseObject;
begin
  FNormalCaption := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      LObj := TgtPDDictionary(LMKObj).LookUp(PDF_CA);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := FNormalCaption
      else
        TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create(FNormalCaption, False));
    end
    else //If MK Dict is not present in the Document, Create it
    begin
      LMKObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create(FNormalCaption, False));
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj);
    end;
  end;
end;

{ TgtPDSignatureFields }

destructor TgtPDSignatureFields.Destroy;
begin

  inherited;
end;

function TgtPDSignatureFields.GetItem(Index: Integer): TgtPDSignatureField;
begin
  Result := TgtPDSignatureField(inherited Get(Index));
end;

end.
