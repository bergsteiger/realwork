unit PDMovieAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot;

type

  TgtMoviePlayMode = (mmOnce, mmOpen, mmRepeat, mmPalindrome);

  TgtDiamension = record
    Width: Double;
    Height: Double;
  end;

  TgtPDMovieAnnot = class(TgtPDAnnot)
  private
    FTitle: AnsiString;
    FFileName: AnsiString;
    FAspect: TgtDiamension;
    FRotate: Integer;
    FHasPoster: Boolean;
    //FStart: Varient;
    //FDuration: Varient;
    FRate: Double;
    FVolume: Double;
    FShowControls: Boolean;
    FPlayMode: TgtMoviePlayMode;
    FSynchronous: Boolean;
    //FWScale: integer;
    FXPos: Double;
    FYPos: Double;

    function GetTitle: AnsiString;
    function GetFileName: AnsiString;
    function GetAspect: TgtDiamension;
    function GetRotate: Integer;
    function GetHasPoster: Boolean;
    function GetRate: Double;
    function GetVolume: Double;
    function GetShowControls: Boolean;
    function GetPlayMode: TgtMoviePlayMode;
    function GetSynchronous: Boolean;
    function GetXPos: Double;
    function GetYPos: Double;

    procedure SetTitle(Value: AnsiString);
    procedure SetFileName(Value: AnsiString);
    procedure SetAspect(Value: TgtDiamension);
    procedure SetRotate(Value: Integer);
    procedure SetHasPoster(Value: Boolean);
    procedure SetRate(Value: Double);
    procedure SetVolume(Value: Double);
    procedure SetShowControls(Value: Boolean);
    procedure SetPlayMode(Value: TgtMoviePlayMode);
    procedure SetSynchronous(Value: Boolean);
    procedure SetXPos(Value: Double);
    procedure SetYPos(Value: Double);

  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    property Title: AnsiString read GetTitle write SetTitle;
    property FileName: AnsiString read GetFileName write SetFileName;
    property Aspect: TgtDiamension read GetAspect write SetAspect;
    property Rotate: Integer read GetRotate write SetRotate;
    property HasPoster: Boolean read GetHasPoster write SetHasPoster;
    property Rate: Double read GetRate write SetRate;
    property Volume: Double read GetVolume write SetVolume;
    property ShowControls: Boolean read GetShowControls write SetShowControls;
    property PlayMode: TgtMoviePlayMode read GetPlayMode write SetPlayMode;
    property Synchronous: Boolean read GetSynchronous write SetSynchronous;
    property XPos: Double read GetXPos write SetXPos;
    property YPos: Double read GetYPos write SetYPos;
  end;

implementation

{ TgtPDMovieAnnot }

constructor TgtPDMovieAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotMovie;
end;

destructor TgtPDMovieAnnot.Destroy;
begin

  inherited;
end;

function TgtPDMovieAnnot.GetAspect: TgtDiamension;
begin
  Result := FAspect;
end;

function TgtPDMovieAnnot.GetFileName: AnsiString;
begin
  Result := FFileName;
end;

function TgtPDMovieAnnot.GetHasPoster: Boolean;
begin
  Result := FHasPoster;
end;

function TgtPDMovieAnnot.GetPlayMode: TgtMoviePlayMode;
begin
  Result := FPlayMode;
end;

function TgtPDMovieAnnot.GetRate: Double;
begin
  Result := FRate;
end;

function TgtPDMovieAnnot.GetRotate: Integer;
begin
  Result := FRotate;
end;

function TgtPDMovieAnnot.GetShowControls: Boolean;
begin
  Result := FShowControls;
end;

function TgtPDMovieAnnot.GetSynchronous: Boolean;
begin
  Result := FSynchronous;
end;

function TgtPDMovieAnnot.GetTitle: AnsiString;
begin
  Result := FTitle;
end;

function TgtPDMovieAnnot.GetVolume: Double;
begin
  Result := FVolume;
end;

function TgtPDMovieAnnot.GetXPos: Double;
begin
  Result := FXPos;
end;

function TgtPDMovieAnnot.GetYPos: Double;
begin
  Result := FYPos;
end;

procedure TgtPDMovieAnnot.SetAspect(Value: TgtDiamension);
begin

end;

procedure TgtPDMovieAnnot.SetFileName(Value: AnsiString);
begin

end;

procedure TgtPDMovieAnnot.SetHasPoster(Value: Boolean);
begin

end;

procedure TgtPDMovieAnnot.SetPlayMode(Value: TgtMoviePlayMode);
begin

end;

procedure TgtPDMovieAnnot.SetRate(Value: Double);
begin

end;

procedure TgtPDMovieAnnot.SetRotate(Value: Integer);
begin

end;

procedure TgtPDMovieAnnot.SetShowControls(Value: Boolean);
begin

end;

procedure TgtPDMovieAnnot.SetSynchronous(Value: Boolean);
begin

end;

procedure TgtPDMovieAnnot.SetTitle(Value: AnsiString);
begin

end;

procedure TgtPDMovieAnnot.SetVolume(Value: Double);
begin

end;

procedure TgtPDMovieAnnot.SetXPos(Value: Double);
begin

end;

procedure TgtPDMovieAnnot.SetYPos(Value: Double);
begin

end;

end.
