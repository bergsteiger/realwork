{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.WebBrowser.iOS;

interface

procedure RegisterWebBrowserService;
procedure UnRegisterWebBrowserService;

implementation

uses
  System.Classes, System.Types, System.StrUtils, System.SysUtils,
  System.IOUtils, System.RTLConsts,
  Macapi.ObjectiveC, {Macapi.CocoaTypes,}
  iOSapi.UIKit, iOSApi.Foundation, iOSApi.CoreGraphics,
  FMX.Platform, FMX.Platform.iOS, FMX.WebBrowser, FMX.Types, FMX.Forms;

type

  TiOSWebBrowserService = class;

{ TWebViewDelegate }

  TiOSWebViewDelegate = class (TOCLocal, UIWebViewDelegate)
  private
    FWebBrowser : TiOSWebBrowserService;
  public
    procedure SetWebBrowser(const AWebBrowser: TiOSWebBrowserService);
    procedure webView(webView: UIWebView; didFailLoadWithError: NSError); overload; cdecl;
    function webView(webView: UIWebView; shouldStartLoadWithRequest: NSURLRequest; navigationType: UIWebViewNavigationType): Boolean; overload; cdecl;
    procedure webViewDidFinishLoad(webView: UIWebView); cdecl;
    procedure webViewDidStartLoad(webView: UIWebView); cdecl;
  end;

  TiOSWBService = class(TWBFactoryService)
  protected
    function DoCreateWebBrowser: ICustomBrowser; override;
  end;

{ TiOSWebBrowserService }

  TiOSWebBrowserService = class(TInterfacedObject, ICustomBrowser)
  private
    FWebView: UIWebView;
    FURL: string;
    FWebControl: TCustomWebBrowser;
    FDelegate: TiOSWebViewDelegate;
  protected
    function GetParent : TFmxObject;
    function GetVisible : Boolean;
    procedure Show;
    procedure Hide;
    procedure UpdateContentFromControl;
    procedure DoNavigate(const URL: string);
    procedure DoGoBack;
    procedure DoGoForward;
    { IFMXWebBrowserService }
    function GetURL: string;
    function GetCanGoBack: Boolean;
    function GetCanGoForward: Boolean;
    procedure SetURL(const AValue: string);
    procedure SetWebBrowserControl(const AValue: TCustomWebBrowser);
    procedure Navigate;
    procedure GoBack;
    procedure GoForward;
    procedure GoHome;

    procedure StartLoading;
    procedure FinishLoading;
    procedure FailLoadingWithError;
    procedure ShouldStartLoading(const URL: string);
  public
    constructor Create;
    destructor Free;
    property URL: string read GetURL write SetURL;
    property CanGoBack: Boolean read GetCanGoBack;
    property CanGoForward: Boolean read GetCanGoForward;
  end;

var
  WBService : TiOSWBService;

procedure RegisterWebBrowserService;
begin
  WBService := TiOSWBService.Create;
  TPlatformServices.Current.AddPlatformService( IFMXWBService, WBService);
end;

procedure UnregisterWebBrowserService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXWBService);
end;

function CGRectFromRect(const R: TRectF): CGRect;
begin
  Result.origin.x := R.Left;
  Result.origin.Y := R.Top;
  Result.size.Width := R.Right - R.Left;
  Result.size.Height := R.Bottom - R.Top;
end;

function TiOSWebBrowserService.GetCanGoBack: Boolean;
begin
  Result := False;
  if Assigned(FWebView) then
    Result := FWebView.canGoBack;
end;

function TiOSWebBrowserService.GetCanGoForward: Boolean;
begin
  Result := False;
  if Assigned(FWebView) then
    Result := FWebView.canGoForward;
end;

function TiOSWebBrowserService.GetParent: TFmxObject;
begin
  Result := FWebControl.Parent;
end;

function TiOSWebBrowserService.GetURL: string;
begin
  Result := FURL;
end;

function TiOSWebBrowserService.GetVisible: Boolean;
begin
  Result := False;
  if Assigned(FWebControl) then
    Result := FWebControl.Visible;
end;

procedure TiOSWebBrowserService.GoBack;
begin
  DoGoBack;
end;

procedure TiOSWebBrowserService.GoForward;
begin
  DoGoForward;
end;

procedure TiOSWebBrowserService.GoHome;
begin

end;

procedure TiOSWebBrowserService.Hide;
begin
  if Assigned(FWebView) and (not FWebView.isHidden) then
    FWebView.setHidden(True);
end;

procedure TiOSWebBrowserService.Navigate;
begin
  DoNavigate(URL);
end;

procedure TiOSWebBrowserService.SetURL(const AValue: string);
begin
  if FURL <> AValue then
    FURL:= AValue;
end;

procedure TiOSWebBrowserService.SetWebBrowserControl(const AValue: TCustomWebBrowser);
begin
  FWebControl := AValue;
end;

procedure TiOSWebBrowserService.ShouldStartLoading(const URL: string);
begin
  if Assigned(FWebControl) then
    FWebControl.ShouldStartLoading(URL);
end;

procedure TiOSWebBrowserService.Show;
begin
  if Assigned(FWebView) and (FWebView.isHidden) then
    FWebView.setHidden(False);
end;

procedure TiOSWebBrowserService.StartLoading;
begin
   if Assigned(FWebControl) then
    FWebControl.StartLoading;
end;

constructor TiOSWebBrowserService.Create;
begin
  FWebView := TUIWebView.Create;
  FDelegate := TiOSWebViewDelegate.Create;
  FDelegate.SetWebBrowser(Self);
  FWebView.setDelegate(FDelegate.GetObjectID);
end;

procedure TiOSWebBrowserService.DoGoBack;
begin
  inherited;
  if Assigned(FWebView) and (FWebView.canGoBack = True)then
  begin
    FWebView.GoBack;
    UpdateContentFromControl;
  end;
end;

procedure TiOSWebBrowserService.DoGoForward;
begin
  inherited;
  if Assigned(FWebView) and (FWebView.canGoForward = True)then
  begin
    FWebView.GoForward;
    UpdateContentFromControl;
  end;
end;

procedure TiOSWebBrowserService.DoNavigate(const URL: string);
var
  NewURL: string;
  NSNewURL: NSURL;
  NSNewURLRequest: NSURLRequest;
  LPath: NSString;
  LFilePath: string;
  LDir, LFileName : string;
  Bundle : Pointer;
begin
  NewURL := URL;
  if Pos('file://', URL) <> 0 then
  begin
    //extract the file name, the string after file://
    NewURL := Copy(URL, length('file://') + 1, length(URL));
    LDir := ExtractFileDir(NewURL);
    LFileName := ExtractFileName(NewURL);
    if LDir.IsEmpty then
      Bundle := TNSBundle.OCClass.mainBundle
    else
      Bundle := TNSBundle.OCClass.bundleWithPath(NSSTR(LDir));
    LPath := TNSBundle.Wrap(Bundle).pathForResource(NSSTR(LFileName), nil);
    if Assigned(LPath) then
    begin
      LFilePath := UTF8ToString(LPath.UTF8String);
      if not FileExists(LFilePath) then
        raise EFileNotFoundException.Create(SFileNotFound);
      NSNewURL := TNSURL.Wrap(TNSURL.OCClass.fileURLWithPath(LPath));
    end;
  end
  else
  begin
    if Pos('http', URL) = 0 then
      Insert('http://', NewURL, 0);
    NSNewURL := TNSUrl.Wrap(TNSUrl.OCClass.URLWithString(NSStr(NewURL)));
  end;
  NSNewURLRequest:= TNSURLRequest.Wrap(TNSURLRequest.OCClass.requestWithURL(NSNewURL));
  FWebView.loadRequest(NSNewURLRequest);
  FWebView.setFrame(CGRectFromRect(RectF(0, 0, 1, 1)));
  UpdateContentFromControl;
end;

procedure TiOSWebBrowserService.FailLoadingWithError;
begin
  if Assigned(FWebControl) then
    FWebControl.FailLoadingWithError;
end;

procedure TiOSWebBrowserService.FinishLoading;
begin
  if Assigned(FWebControl) then
    FWebControl.FinishLoading;
end;

destructor TiOSWebBrowserService.Free;
begin
  FWebView.release;
  FDelegate.Free;
end;

procedure TiOSWebBrowserService.UpdateContentFromControl;
var
  View: UIView;
  Bounds: TRectF;
  Form: TCommonCustomForm;
begin
  if Assigned(FWebView) then
  begin
    if (FWebControl <> nil)
      and not (csDesigning in FWebControl.ComponentState)
      and (FWebControl.Root <> nil)
      and (FWebControl.Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(FWebControl.Root.GetObject);
      Bounds := TRectF.Create(0,0,FWebControl.Width,FWebControl.Height);
      Bounds.Fit(FWebControl.AbsoluteRect);
      View := WindowHandleToPlatform(Form.Handle).View;
      View.addSubview(FWebView);
      FWebView.setFrame(CGRectFromRect(RectF(Bounds.Left, Bounds.Top, Bounds.Right, Bounds.Bottom)));
      FWebView.setHidden(not FWebControl.ParentedVisible);
    end
    else
      FWebView.setHidden(True);
  end;
end;

{ TWebViewDelegate }

procedure TiOSWebViewDelegate.webView(webView: UIWebView;
  didFailLoadWithError: NSError);
begin
  if Assigned(FWebBrowser) then
    FWebBrowser.FailLoadingWithError;
end;

procedure TiOSWebViewDelegate.SetWebBrowser(
  const AWebBrowser: TiOSWebBrowserService);
begin
  FWebBrowser := AWebBrowser;
end;

function TiOSWebViewDelegate.webView(webView: UIWebView;
  shouldStartLoadWithRequest: NSURLRequest;
  navigationType: UIWebViewNavigationType): Boolean;
begin
  if Assigned(FWebBrowser) then
  begin
    FWebBrowser.ShouldStartLoading(FWebBrowser.URL);
  end;
  Result := True;
end;

procedure TiOSWebViewDelegate.webViewDidFinishLoad(webView: UIWebView);
begin
  if Assigned(FWebBrowser) then
    FWebBrowser.FinishLoading;
end;

procedure TiOSWebViewDelegate.webViewDidStartLoad(webView: UIWebView);
begin
  if Assigned(FWebBrowser) then
    FWebBrowser.StartLoading;
end;

{ TiOSWBService }

function TiOSWBService.DoCreateWebBrowser: ICustomBrowser;
var
  Browser : TiOSWebBrowserService;
begin
  Browser := TiOSWebBrowserService.Create;
  Result := Browser;
end;

end.
