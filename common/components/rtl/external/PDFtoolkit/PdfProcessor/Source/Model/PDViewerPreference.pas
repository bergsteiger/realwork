unit PDViewerPreference;

interface

uses
  classes, PDDictionary, gtConstants, PDBaseObject, PDElement,
  PDBoolean, gtLogger, gtObject, PDName, PDString;

type

  TgtPDViewerPref = class(TgtPDElement)
  private
    FHideToolBar: Integer;
    FHideMenuBar: Integer;
    FHideWindowUI: Integer;
    FFitWindow: Integer;
    FCenterWindow: Integer;
    FDisPlayDocTitle: Integer;
    function GetHideToolBar: Boolean;
    procedure SetHideToolBar(const AValue: Boolean);
    function GetHideMenuBar: Boolean;
    procedure SetHideMenuBar(const AValue: Boolean);
    function GetHideWindowUI: Boolean;
    procedure SetHideWindowUI(const AValue: Boolean);
    function GetCenterWindow: Boolean;
    function GetDisplayDocTitle: Boolean;
    function GetFitWindow: Boolean;
    procedure SetCenterWindow(const AValue: Boolean);
    procedure SetDisplayDocTitle(const AValue: Boolean);
    procedure SetFitWindow(const AValue: Boolean);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    procedure Update; override;
    property HideToolBar: Boolean read GetHideToolBar write SetHideToolBar;
    property HideMenuBar: Boolean read GetHideMenuBar write SetHideMenuBar;
    property HideWindowUI: Boolean read GetHideWindowUI write SetHideWindowUI;
    property FitWindow: Boolean read GetFitWindow write SetFitWindow;
    property CenterWindow: Boolean read GetCenterWindow write SetCenterWindow;
    property DisplayDocTitle: Boolean read GetDisplayDocTitle write
      SetDisplayDocTitle;
  end;

implementation

{ TgtPDViewerPref }

uses
  PDDocument;

constructor TgtPDViewerPref.Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
  ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FHideToolBar := -1;
  FHideMenuBar := -1;
  FHideWindowUI := -1;
  FFitWindow := -1;
  FCenterWindow := -1;
  FDisPlayDocTitle := -1;
end;

destructor TgtPDViewerPref.Destroy;
begin

  inherited;
end;

function TgtPDViewerPref.GetCenterWindow: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_CENTERWINDOW);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

function TgtPDViewerPref.GetDisplayDocTitle: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_DISPLAYDOCTITLE);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

function TgtPDViewerPref.GetFitWindow: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_FITWINDOW);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

function TgtPDViewerPref.GetHideMenuBar: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDEMENUBAR);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

function TgtPDViewerPref.GetHideToolBar: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDETOOLBAR);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

function TgtPDViewerPref.GetHideWindowUI: Boolean;
var
  LPref: TgtPDBaseObject;
  LValue: Boolean;
begin
  if FCenterWindow = -1 then
  begin
    FCenterWindow := 0; // Default is false
    LPref := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDEWINDOWUI);
    if Assigned(LPref) then
    begin
      if LPref.IsBoolean then
      begin
        LValue := TgtPDBoolean(LPref).Value;
        if LValue then
          FCenterWindow := 1;
      end
      else
{$IFDEF DEBUG}
        Logger.LogError('Viewer Preference: Boolean object Expected');
{$ENDIF}
    end;
  end;
  Result := (FCenterWindow = 1);
end;

procedure TgtPDViewerPref.SetCenterWindow(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CENTERWINDOW);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
//    LObj := TgtPDName.Create(PDF_CENTERWINDOW);
    TgtPDDictionary(FBaseObject).Add(PDF_CENTERWINDOW, TgtPDBoolean.Create(AValue));
  end;
end;

procedure TgtPDViewerPref.SetDisplayDocTitle(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DISPLAYDOCTITLE);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
    LObj := TgtPDBoolean.Create(AValue);
    TgtPDDictionary(FBaseObject).Add(PDF_DISPLAYDOCTITLE, LObj);
  end;
end;

procedure TgtPDViewerPref.SetFitWindow(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FITWINDOW);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
    LObj := TgtPDBoolean.Create(AValue);
    TgtPDDictionary(FBaseObject).Add(PDF_FITWINDOW, LObj);
  end;
end;

procedure TgtPDViewerPref.SetHideMenuBar(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDEMENUBAR);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
    LObj := TgtPDBoolean.Create(AValue);
    TgtPDDictionary(FBaseObject).Add(PDF_HIDEMENUBAR, LObj);
  end;
end;

procedure TgtPDViewerPref.SetHideToolBar(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDETOOLBAR);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
    LObj := TgtPDBoolean.Create(AValue);
    TgtPDDictionary(FBaseObject).Add(PDF_HIDETOOLBAR, LObj);
  end;
end;

procedure TgtPDViewerPref.SetHideWindowUI(const AValue: Boolean);
var
  LObj: TgtPDBaseObject;
//  LString: AnsiString;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_HIDEWINDOWUI);
  if Assigned(LObj) then
    TgtPDBoolean(LObj).Value := AValue
  else
  begin
    LObj := TgtPDBoolean.Create(AValue);
    TgtPDDictionary(FBaseObject).Add(PDF_HIDEWINDOWUI, LObj);
  end;
end;

procedure TgtPDViewerPref.Update;
begin
  inherited;

end;

end.
