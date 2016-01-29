{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.WebBrowser;

interface

uses
  System.Classes, System.SysUtils, System.Types,
  System.Generics.Collections,
  FMX.Types, FMX.Types3D, FMX.Forms, FMX.Consts, FMX.Controls;

type

  EWebManagerException = class(Exception);

  TCustomWebBrowser = class;

  TWebBrowserDidStartLoad = procedure(ASender: TObject) of object;
  TWebBrowserDidFinishLoad = procedure(ASender: TObject) of object;
  TWebBrowserDidFailLoadWithError = procedure(ASender: TObject) of object;
  TWebBrowserShouldStartLoadWithRequest = procedure(ASender: TObject; const URL: string) of object;

{ IFMXWebBrowserService }

  ICustomBrowser = interface(IInterface)
  ['{A5BB2E8C-6D53-4FF3-BC38-2299285F07BD}']
    function GetURL: string;
    function GetCanGoBack: Boolean;
    function GetCanGoForward: Boolean;
    procedure SetURL(const AValue: string);

    procedure SetWebBrowserControl(const AValue: TCustomWebBrowser);
    function GetParent : TFmxObject;
    function GetVisible : Boolean;
    procedure UpdateContentFromControl;
    procedure Navigate;
    procedure GoBack;
    procedure GoForward;
    procedure GoHome;
    procedure Show;
    procedure Hide;
    property URL: string read GetURL write SetURL;
    property CanGoBack: Boolean read GetCanGoBack;
    property CanGoForward: Boolean read GetCanGoForward;
  end;

{ IFMXWBService }

  IFMXWBService = interface (IInterface)
    ['{61BC1956-BAA0-4B07-971D-EF40064FBD07}']
    function CreateWebBrowser: ICustomBrowser;
    procedure ReAlignBrowsers;
  end;

  { TCustomWebBrowser }

  TCustomWebBrowser = class(TControl)
  private
    FWeb: ICustomBrowser;
    FURL: string;
    FOnDidStartLoad: TWebBrowserDidStartLoad;
    FOnDidFinishLoad: TWebBRowserDidFinishLoad;
    FOnDidFailLoadWithError: TWebBrowserdidFailLoadWithError;
    FOnShouldStartLoadWithRequest: TWebBrowsershouldStartLoadWithRequest;
    function GetURL: string;
    function GetCanGoBack: Boolean;
    function GetCanGoForward: Boolean;
    procedure SetURL(const Value: string);
    procedure UpdateContent;
  protected
    procedure Move; override;
    procedure Resize; override;
    procedure Paint; override;
    procedure Show; override;
    procedure Hide; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    // getters and setters for web browser events

    function GetOnDidStartLoad: TWebBrowserDidStartLoad;
    procedure SetOnDidStartLoad(const AEvent: TWebBrowserDidStartLoad);
    function GetOnDidFinishLoad: TWebBrowserDidFinishLoad;
    procedure SetOnDidFinishLoad(const AEvent: TWebBrowserDidFinishLoad);
    function GetOnShouldStartLoadWithRequest: TWebBrowserShouldStartLoadWithRequest;
    procedure SetOnShouldStartLoadWithRequest(const AEvent: TWebBrowserShouldStartLoadWithRequest);
    function GetOnDidFailLoadWithError: TWebBrowserDidFailLoadWithError;
    procedure SetOnDidFailLoadWithError(const AEvent: TWebBrowserDidFailLoadWithError);
    procedure SetVisible(const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartLoading;
    procedure FinishLoading;
    procedure FailLoadingWithError;
    procedure ShouldStartLoading(const URL: string);

    procedure GoBack;
    procedure GoForward;
    procedure Navigate; overload;
    procedure Navigate(const AURL: string); overload;
    property URL: string read GetURL write SetURL;
    property CanGoBack: Boolean read GetCanGoBack default False;
    property CanGoForward: Boolean read GetCanGoForward default False;

    property OnDidStartLoad: TWebBrowserDidStartLoad read GetOnDidStartLoad write SetOnDidStartLoad;
    property OnDidFinishLoad: TWebBrowserDidFinishLoad read GetOnDidFinishLoad write SetOnDidFinishLoad;
    property OnShouldStartLoadWithRequest: TWebBrowserShouldStartLoadWithRequest read GetOnShouldStartLoadWithRequest write SetOnShouldStartLoadWithRequest;
    property OnDidFailLoadWithError: TWebBrowserDidFailLoadWithError read GetOnDidFailLoadWithError write SetOnDidFailLoadWithError;
  end;

{ TWBFactoryService }

  TWBFactoryService = class abstract (TInterfacedObject, IFMXWBService)
  protected
    FWebBrowsers: TList<ICustomBrowser>;
    function DoCreateWebBrowser: ICustomBrowser; virtual; abstract;
    procedure DoRemoveWebBrowser(const AWebBrowser: ICustomBrowser);
    procedure ReAlignBrowsers;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateWebBrowser: ICustomBrowser;
  end;

{ TWebBrowser }
  [ComponentPlatformsAttribute(pidiOSSimulator or pidiOSDevice)]
  TWebBrowser = class(TCustomWebBrowser)
  published
    property Align;
    property Anchors;
    property Height;
    property Margins;
    property Position;
    property URL;
    property Visible default True;
    property Width;
    property OnDidStartLoad;
    property OnDidFinishLoad;
    property OnDidFailLoadWithError;
    property OnShouldStartLoadWithRequest;
  end;

implementation

uses
{$IFDEF IOS}
  FMX.WebBrowser.iOS,
{$ENDIF IOS}
  FMX.Platform;

{ TCustomWebBrowser }

constructor TCustomWebBrowser.Create(AOwner: TComponent);
var
  WBService : IFMXWBService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXWBService, IInterface(WBService)) then
  begin
    FWeb := WBService.CreateWebBrowser;
    FWeb.SetWebBrowserControl(Self);
  end;
end;

destructor TCustomWebBrowser.Destroy;
begin
  FWeb := nil;
  inherited;
end;

procedure TCustomWebBrowser.FailLoadingWithError;
begin
  if Assigned(FOnDidFailLoadWithError) then
    FOnDidFailLoadWithError(Self);
end;

procedure TCustomWebBrowser.FinishLoading;
begin
  if Assigned(FOnDidFinishLoad) then
    FOnDidFinishLoad(Self);
end;

function TCustomWebBrowser.GetCanGoBack: Boolean;
begin
  Result:= False;
  if Assigned(FWeb) then
    Result:= FWeb.CanGoBack;
end;

function TCustomWebBrowser.GetCanGoForward: Boolean;
begin
  Result:= False;
  if Assigned(FWeb) then
    Result:= FWeb.CanGoForward;
end;

function TCustomWebBrowser.GetOnDidFailLoadWithError: TWebBrowserdidFailLoadWithError;
begin
  Result := FOnDidFailLoadWithError;
end;

function TCustomWebBrowser.GetOnDidFinishLoad: TWebBrowserDidFinishLoad;
begin
  Result := FOnDidFinishLoad;
end;

function TCustomWebBrowser.GetOnDidStartLoad: TWebBrowserDidStartLoad;
begin
  Result := FOnDidStartLoad;
end;

function TCustomWebBrowser.GetOnShouldStartLoadWithRequest: TWebBrowserShouldStartLoadWithRequest;
begin
  Result := FOnShouldStartLoadWithRequest;
end;

function TCustomWebBrowser.GetURL: string;
begin
  Result := FURL;
end;

procedure TCustomWebBrowser.GoBack;
begin
  if Assigned(FWeb) then
    FWeb.GoBack;
end;

procedure TCustomWebBrowser.GoForward;
begin
  if Assigned(FWeb) then
    FWeb.GoForward;
end;

procedure TCustomWebBrowser.Hide;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomWebBrowser.Move;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomWebBrowser.Navigate(const AURL: string);
begin
  if Assigned(FWeb) then
    SetUrl(AURL);
end;

procedure TCustomWebBrowser.Navigate;
begin
  if Assigned(FWeb) then
    FWeb.Navigate;
end;

procedure TCustomWebBrowser.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

procedure TCustomWebBrowser.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.sdDash;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.sdSolid;
  end;
end;

procedure TCustomWebBrowser.Resize;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomWebBrowser.SetOnDidFailLoadWithError(
  const AEvent: TWebBrowserdidFailLoadWithError);
begin
  FOnDidFailLoadWithError := AEvent;
end;

procedure TCustomWebBrowser.SetOnDidFinishLoad(
  const AEvent: TWebBrowserDidFinishLoad);
begin
  FOnDidFinishLoad := AEvent;
end;

procedure TCustomWebBrowser.SetOnDidStartLoad(
  const AEvent: TWebBrowserDidStartLoad);
begin
  FOnDidStartLoad := AEvent;
end;

procedure TCustomWebBrowser.SetOnShouldStartLoadWithRequest(
  const AEvent: TWebBrowserShouldStartLoadWithRequest);
begin
  FOnShouldStartLoadWithRequest := AEvent;
end;

procedure TCustomWebBrowser.SetURL(const Value: string);
begin
  if FURL <> Value then
  begin
    FURL:= Value;
    if Assigned(FWeb) then
    begin
      FWeb.URL := Value;
      if not(csDesigning in ComponentState) and (Value <> '') then
        Navigate;
    end;
  end;
end;

procedure TCustomWebBrowser.SetVisible(const Value: Boolean);
begin
  inherited;
end;

procedure TCustomWebBrowser.ShouldStartLoading(const URL: string);
begin
  if Assigned(FOnShouldStartLoadWithRequest) then
    FOnShouldStartLoadWithRequest(Self, URL);
end;

procedure TCustomWebBrowser.Show;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomWebBrowser.StartLoading;
begin
  if Assigned(FOnDidStartLoad) then
    FOnDidStartLoad(Self);
end;

procedure TCustomWebBrowser.UpdateContent;
begin
  if Assigned(FWeb) then
    FWeb.UpdateContentFromControl;
end;

{ TWBFactoryService }

constructor TWBFactoryService.Create;
begin
  inherited Create;
  FWebBrowsers := TList<ICustomBrowser>.Create;
end;

function TWBFactoryService.CreateWebBrowser: ICustomBrowser;
begin
  Result := DoCreateWebBrowser;
  FWebBrowsers.Add(Result);
end;

destructor TWBFactoryService.Destroy;
begin
  FreeAndNil(FWebBrowsers);
  inherited Destroy;
end;

procedure TWBFactoryService.DoRemoveWebBrowser(
  const AWebBrowser: ICustomBrowser);
begin
  if Assigned(FWebBrowsers) and Assigned(AWebBrowser) then
    FWebBrowsers.Remove(AWebBrowser);
end;

procedure TWBFactoryService.ReAlignBrowsers;
var
  WebBrowser : ICustomBrowser;
  Parent : TFmxObject;

begin
  for WebBrowser in FWebBrowsers do
  begin
    Parent := WebBrowser.GetParent;
    if Assigned(Parent) and (Parent is TControl) then
    begin
      if TControl(Parent).ParentedVisible then
      begin
        if WebBrowser.GetVisible then
          WebBrowser.Show
        else
          WebBrowser.Hide;
      end
      else
      begin
        WebBrowser.Hide;
      end;
    end
    else
      WebBrowser.Hide;
    if WebBrowser.GetVisible then
      WebBrowser.UpdateContentFromControl;
  end;
end;

initialization

{$IFDEF IOS}
  RegisterWebBrowserService;
{$ENDIF IOS}

  RegisterFmxClasses([TWebBrowser]);

end.
