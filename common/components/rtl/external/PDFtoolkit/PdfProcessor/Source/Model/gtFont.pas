unit gtFont;

interface

uses
  Classes, Graphics, gtObject, PDTypes, PDBaseObject;

type

  TgtFontEncoding = (feWinAnsiEncoding, feMacRomanEncoding,
    feMacExpertEncoding, feStandardEncoding, fePDFDocEncoding);

  TgtFont = class(TgtObject)
  private
    FName: AnsiString;
    FSize: Integer;
    FStyle: TFontStyles;
    FColor: TColor;
//    FFontObj: TgtPDBaseObject;
    FStream: TStream;
    FFileName: AnsiString;
    FEncoding: TgtFontEncoding;

    function GetName: AnsiString;
    function GetSize: Integer;
    function GetStyle: TFontStyles;
    function GetColor: TColor;
    function GetFileName: AnsiString;
    function GetEncoding: TgtFontEncoding;
    function GetStream: TStream;
    procedure SetName(AValue: AnsiString);
    procedure SetSize(AValue: Integer);
    procedure SetStyle(AValue: TFontStyles);
    procedure SetColor(AValue: TColor);
    procedure SetFileName(AValue: AnsiString);
    procedure SetEncoding(AValue: TgtFontEncoding);
    procedure SetStream(const Value: TStream);
  public
    constructor Create; overload;
    constructor Create(AName: AnsiString; ASize: Integer;
      AStyle: TFontStyles; AColor: TColor); overload;
    destructor Destroy; override;

    procedure SetFont(AFontFileName: AnsiString; ASize: Integer; AColor: TColor); overload;
    procedure SetFont(AFontStream: TStream; ASize: Integer; AColor: TColor); overload;

    property Name: AnsiString read GetName write SetName;
    property Size: Integer read GetSize write SetSize;
    property Style: TFontStyles read GetStyle write SetStyle;
    property Color: TColor read GetColor write SetColor;
    property Stream: TStream read GetStream write SetStream;
    property FileName: AnsiString read GetFileName write SetFileName;
    property Encoding: TgtFontEncoding read GetEncoding write SetEncoding;
  end;

implementation

uses
  SysUtils;

{ TgtFont }

constructor TgtFont.Create;
begin
  FName := 'Arial';
  FSize := 8;
  FStyle := [];
  FColor := clBlack;
  FFileName := '';
  FStream := nil;
end;

constructor TgtFont.Create(AName: AnsiString; ASize: Integer;
  AStyle: TFontStyles; AColor: TColor);
begin
  FName := AName;
  FSize := ASize;
  FColor := AColor;
  FStyle := AStyle;
end;

destructor TgtFont.Destroy;
begin
  if Assigned(FStream) then
    FreeAndNil(FStream);
  inherited;
end;

function TgtFont.GetColor: TColor;
begin
  Result := FColor;
end;

function TgtFont.GetEncoding: TgtFontEncoding;
begin
  Result := FEncoding;
end;

function TgtFont.GetFileName: AnsiString;
begin
  Result := FFileName;
end;

function TgtFont.GetName: AnsiString;
begin
  Result := FName;
end;

function TgtFont.GetSize: Integer;
begin
  Result := FSize;
end;

function TgtFont.GetStream: TStream;
begin
  Result := FStream;
end;

function TgtFont.GetStyle: TFontStyles;
begin
  Result := FStyle;
end;

procedure TgtFont.SetFont(AFontFileName: AnsiString; ASize: Integer;
  AColor: TColor);
begin
  FFileName := AFontFileName;
  FSize := ASize;
  FColor := AColor;
end;

procedure TgtFont.SetFileName(AValue: AnsiString);
begin
  FFileName := AValue;
end;

procedure TgtFont.SetFont(AFontStream: TStream; ASize: Integer;
  AColor: TColor);
begin
  FStream := AFontStream;
  FSize := ASize;
  FColor := AColor;
end;

procedure TgtFont.SetName(AValue: AnsiString);
begin
  FName := AValue;
end;

procedure TgtFont.SetColor(AValue: TColor);
begin
  FColor := AValue;
end;

procedure TgtFont.SetEncoding(AValue: TgtFontEncoding);
begin
  FEncoding := AValue;
end;

procedure TgtFont.SetSize(AValue: Integer);
begin
  FSize := AValue;
end;

procedure TgtFont.SetStream(const Value: TStream);
begin
  if not Assigned(FStream) then
    FStream := TMemoryStream.Create;
  TMemoryStream(FStream).LoadFromStream(Value);
  FStream.Position := 0;
end;

procedure TgtFont.SetStyle(AValue: TFontStyles);
begin
  FStyle := AValue;
end;

end.
