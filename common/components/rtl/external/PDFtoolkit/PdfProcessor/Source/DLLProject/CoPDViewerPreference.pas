unit CoPDViewerPreference;

interface

uses
  PDViewerPreferenceIntf, PDViewerPreference, PDDocumentIntf;

type
  TgtCoPDViewerPreference = class(IgtPDViewerPreference)
  private
    FPDViewerPreference: TgtPDViewerPref;
  public
//  constructor Create(AParentDoc: IgtPDDocument; ACatalog: IgtPDCatalog);
//  destructor Destroy;
    constructor Create(APDViewerPref: TgtPDViewerPref);
    function GetHideToolBar: WordBool; override;
    procedure SetHideToolBar(const Value: WordBool); override;
    function GetHideMenuBar: WordBool; override;
    procedure SetHideMenuBar(const Value: WordBool); override;
    function GetHideWindowUI: WordBool; override;
    procedure SetHideWindowUI(const Value: WordBool); override;
    function GetCenterWindow: WordBool; override;
    function GetDisplayDocTitle: WordBool; override;
    function GetFitWindow: WordBool; override;
    procedure SetCenterWindow(const Value: WordBool); override;
    procedure SetDisplayDocTitle(const Value: WordBool); override;
    procedure SetFitWindow(const Value: WordBool); override;
  end;

implementation

{ TgtCoPDViewerPreference }

{*
constructor TgtCoPDViewerPreference.Create(AParentDoc: IgtPDDocument;
  ACatalog: IgtPDCatalog);
begin

end;

destructor TgtCoPDViewerPreference.Destroy;
begin
  if Assigned(FPDViewerPreference) then
    FPDViewerPreference.Free;
end;
*}

constructor TgtCoPDViewerPreference.Create(APDViewerPref: TgtPDViewerPref);
begin
  FPDViewerPreference := APDViewerPref;
end;

function TgtCoPDViewerPreference.GetCenterWindow: WordBool;
begin
  Result := FPDViewerPreference.CenterWindow;
end;

function TgtCoPDViewerPreference.GetDisplayDocTitle: WordBool;
begin
  Result := FPDViewerPreference.DisplayDocTitle;
end;

function TgtCoPDViewerPreference.GetFitWindow: WordBool;
begin
  Result := FPDViewerPreference.FitWindow;
end;

function TgtCoPDViewerPreference.GetHideMenuBar: WordBool;
begin
  Result := FPDViewerPreference.HideMenuBar;
end;

function TgtCoPDViewerPreference.GetHideToolBar: WordBool;
begin
  Result := FPDViewerPreference.HideToolBar;
end;

function TgtCoPDViewerPreference.GetHideWindowUI: WordBool;
begin
  Result := FPDViewerPreference.HideWindowUI;
end;

procedure TgtCoPDViewerPreference.SetCenterWindow(const Value: WordBool);
begin
  FPDViewerPreference.CenterWindow := Value;
end;

procedure TgtCoPDViewerPreference.SetDisplayDocTitle(const Value: WordBool);
begin
  FPDViewerPreference.DisplayDocTitle := Value;
end;

procedure TgtCoPDViewerPreference.SetFitWindow(const Value: WordBool);
begin
  FPDViewerPreference.FitWindow := Value;
end;

procedure TgtCoPDViewerPreference.SetHideMenuBar(const Value: WordBool);
begin
  FPDViewerPreference.HideMenuBar := Value;
end;

procedure TgtCoPDViewerPreference.SetHideToolBar(const Value: WordBool);
begin
  FPDViewerPreference.HideToolBar := Value;
end;

procedure TgtCoPDViewerPreference.SetHideWindowUI(const Value: WordBool);
begin
  FPDViewerPreference.HideWindowUI := Value;
end;

end.
