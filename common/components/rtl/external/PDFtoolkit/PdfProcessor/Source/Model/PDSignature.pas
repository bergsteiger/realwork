unit PDSignature;

interface

uses
  Classes, Contnrs, gtConstants, gtTypes, PDElement;

resourcestring
  SName = 'Digitally signed by: ';
  SLocation = 'Location: ';
  SReason = 'Reason: ';
  SDate = 'Date: ';

type

  TgtSigDisplayOption = (sdoReason, sdoName, sdoDate, sdoLogo, sdoLabels,
    sdoLocation);

  TgtSigDisplayOptions = set of TgtSigDisplayOption;

  TgtPDSignature = class(TgtPDElement)
  private
    FAuthor,
    FContactInfo,
    FLocation,
    FReason: AnsiString;
    FName: AnsiString;
    FCertifyDocument: Boolean;
    FFilter: AnsiString;
    FSubfilter: TgtSigSubfilter;
    FCerificationLevel: TgtSigCertLevel;
    FPFXPassword: AnsiString;
    FPFXFileName: AnsiString;
    FDateTime: TDateTime;
    FOffset1,
    FOffset2,
    FOffset3,
    FOffset4: Cardinal;
    FSigDispOptions: TgtSigDisplayOptions;
  public
    constructor Create(AAuthorName, AReason, ALocation, AContactInfo: Ansistring;
      ACertifyDoc: Boolean); overload;
    constructor Create; overload;
    destructor Destroy; override;

    //GetSignedVersion;
    procedure GetByteOffset(var Offset1: Cardinal; var Offset2: Cardinal;
      var Offset3: Cardinal; var Offset4: Cardinal);
    procedure SetByteOffset(Offset1, Offset2, Offset3, Offset4: Cardinal);
    function Validate: Boolean;
    property Author: AnsiString read FAuthor write FAuthor;
    property ContactInfo: AnsiString read FContactInfo write FContactInfo;
    property Location: AnsiString read FLocation write FLocation;
    property Reason: AnsiString read FReason write FReason;
    property CertifyDocument: Boolean read FCertifyDocument write FCertifyDocument;
    property CertLevel: TgtSigCertLevel read FCerificationLevel write FCerificationLevel;
    property Handler: AnsiString read FFilter write FFilter;
    property SubFilter: TgtSigSubfilter read FSubfilter write FSubfilter;
    property PFXFileName: AnsiString read FPFXFileName write FPFXFileName;
    property PFXPassword: AnsiString read FPFXPassword write FPFXPassword;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property Name: AnsiString read FName write FName;
    property SigDispOptions: TgtSigDisplayOptions read FSigDispOptions write
      FSigDispOptions;
  end;

  TgtPDSignatures = class(TObjectList)
  private
    function GetItem(Index: Integer): TgtPDSignature;
  public
    destructor Destroy; override;
    property Items[Index: Integer]: TgtPDSignature read GetItem; default;
  end;

implementation

{ TgtPDSignature }

uses
  PDDocument;

constructor TgtPDSignature.Create(AAuthorName, AReason, ALocation,
  AContactInfo: Ansistring; ACertifyDoc: Boolean);
begin
  FAuthor := AAuthorName;
  FReason := AReason;
  FLocation := ALocation;
  FContactInfo := AContactInfo;
  FCertifyDocument := ACertifyDoc;
end;

constructor TgtPDSignature.Create;
begin
  FFilter := PDF_ADOBEHANDLER;
  FSubfilter := sfPkcs7Sha1;
  FCerificationLevel := clFillFormFields;
  FSigDispOptions := [sdoReason, sdoName, sdoDate, sdoLogo, sdoLabels,
    sdoLocation];
end;

destructor TgtPDSignature.Destroy;
begin

  inherited;
end;

procedure TgtPDSignature.GetByteOffset(var Offset1, Offset2, Offset3,
  Offset4: Cardinal);
begin
  Offset1 := FOffset1;
  Offset2 := FOffset2;
  Offset3 := FOffset3;
  Offset4 := FOffset4;
end;

procedure TgtPDSignature.SetByteOffset(Offset1, Offset2, Offset3,
  Offset4: Cardinal);
begin
  FOffset1 := Offset1;
  FOffset2 := Offset2;
  FOffset3 := Offset3;
  FOffset4 := Offset4;
end;

function TgtPDSignature.Validate: Boolean;
var
  LStream: TStream;
begin
  Result := False;
  LStream := TgtPDDocument(FParentDoc).BaseDoc.GetReader.FileStream;
end;

{ TgtPDSignatures }

destructor TgtPDSignatures.Destroy;
begin

  inherited;
end;

function TgtPDSignatures.GetItem(Index: Integer): TgtPDSignature;
begin
  Result := TgtPDSignature(inherited Get(Index));
end;

end.
