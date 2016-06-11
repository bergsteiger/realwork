{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit REST.Authenticator.OAuth.WebForm.FMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.WebBrowser, FMX.StdCtrls;

type
  TOAuth2WebFormRedirectEvent = procedure(const AURL: string; var DoCloseWebView : boolean) of object;
  TOAuth2WebFormTitleChangedEvent = procedure(const ATitle: string; var DoCloseWebView : boolean) of object;

  Tfrm_OAuthWebForm = class(TForm)
   {$NODEFINE Tfrm_OAuthWebForm}
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    WebBrowser: TWebBrowser;
    btn_Close: TButton;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserShouldStartLoadWithRequest(ASender: TObject;
      const URL: string);
    procedure WebBrowserDidFinishLoad(ASender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FOnBeforeRedirect: TOAuth2WebFormRedirectEvent;
    FOnAfterRedirect: TOAuth2WebFormRedirectEvent;
    FOnBrowserTitleChanged : TOAuth2WebFormTitleChangedEvent;

    FLastURL: string;
  public
    { Public declarations }
    procedure ShowWithURL(const AURL: string);

    property LastURL: string read FLastURL;

    property OnAfterRedirect: TOAuth2WebFormRedirectEvent read FOnAfterRedirect write FOnAfterRedirect;
    property OnBeforeRedirect: TOAuth2WebFormRedirectEvent read FOnBeforeRedirect write FOnBeforeRedirect;
    property OnTitleChanged : TOAuth2WebFormTitleChangedEvent read FOnBrowserTitleChanged write FOnBrowserTitleChanged;
  end;

var
  frm_OAuthWebForm: Tfrm_OAuthWebForm;
  {$NODEFINE frm_OAuthWebForm}
implementation

{$R *.fmx}

type
  TWebBrowserAccess = class(TWebBrowser);


procedure Tfrm_OAuthWebForm.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OAuthWebForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TWebBrowserAccess(WebBrowser).Hide;
end;

procedure Tfrm_OAuthWebForm.FormCreate(Sender: TObject);
begin
  FOnAfterRedirect := NIL;
  FOnBeforeRedirect:= NIL;
  FOnBrowserTitleChanged:= NIL;

  FLastURL := '';
end;

procedure Tfrm_OAuthWebForm.ShowWithURL(const AURL: string);
begin
  Show;
  WebBrowser.CanFocus := TRUE;
  WebBrowser.Navigate( AURL );

  WebBrowser.SetFocus;
end;

procedure Tfrm_OAuthWebForm.WebBrowserDidFinishLoad(ASender: TObject);
var
  LDoCloseForm : boolean;
begin
  FLastURL := WebBrowser.URL;

  if Assigned(FOnAfterRedirect) then
  begin
    LDoCloseForm:= FALSE;

    FOnAfterRedirect(FLastURL, LDoCloseForm);

    if LDoCloseForm then
      self.Close;
  end;
end;

procedure Tfrm_OAuthWebForm.WebBrowserShouldStartLoadWithRequest(
  ASender: TObject; const URL: string);
var
  LDoCloseForm : boolean;
begin
  if Assigned(FOnBeforeRedirect) then
  begin
    LDoCloseForm:= FALSE;

    FOnBeforeRedirect(URL, LDoCloseForm);

    if LDoCloseForm then
    begin
      self.Close;
    end;
  end;
end;

end.
