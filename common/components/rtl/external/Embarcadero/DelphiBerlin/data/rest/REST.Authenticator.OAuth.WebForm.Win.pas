{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Authenticator.OAuth.WebForm.Win;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  SHDocVw;

type
  TOAuth2WebFormRedirectEvent = procedure(const AURL: string; var DoCloseWebView : boolean) of object;
  TOAuth2WebFormTitleChangedEvent = procedure(const ATitle: string; var DoCloseWebView : boolean) of object;

  Tfrm_OAuthWebForm = class(TForm)
    Bevel1: TBevel;
    btn_Close: TButton;
    Browser: TWebBrowser;
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BrowserTitleChange(ASender: TObject; const Text: WideString);
    procedure FormCreate(Sender: TObject);
    procedure BrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure BrowserBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
  private
    { Private declarations }
    FOnBeforeRedirect: TOAuth2WebFormRedirectEvent;
    FOnAfterRedirect: TOAuth2WebFormRedirectEvent;
    FOnBrowserTitleChanged : TOAuth2WebFormTitleChangedEvent;

    FLastTitle: string;
    FLastURL: string;
  public
    { Public declarations }
    procedure ShowWithURL(const AURL: string);
    procedure ShowModalWithURL(const AURL: string); //deprecated 'Please use ShowWithURL() instead. Sorry for inconvenience.';

    property LastTitle: string read FLastTitle;
    property LastURL: string read FLastURL;

    property OnAfterRedirect: TOAuth2WebFormRedirectEvent read FOnAfterRedirect write FOnAfterRedirect;
    property OnBeforeRedirect: TOAuth2WebFormRedirectEvent read FOnBeforeRedirect write FOnBeforeRedirect;
    property OnTitleChanged : TOAuth2WebFormTitleChangedEvent read FOnBrowserTitleChanged write FOnBrowserTitleChanged;
  end;

var
  frm_OAuthWebForm: Tfrm_OAuthWebForm;

implementation

{$R *.dfm}

procedure Tfrm_OAuthWebForm.BrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  LDoCloseForm : boolean;
begin
  if Assigned(FOnBeforeRedirect) then
  begin
    LDoCloseForm:= FALSE;

    FOnBeforeRedirect(URL, LDoCloseForm);

    if LDoCloseForm then
    begin
      Cancel:= TRUE;
      self.Close;
    end;
  end;
end;

procedure Tfrm_OAuthWebForm.BrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  LDoCloseForm : boolean;
begin
  FLastURL := VarToStrDef(URL, '');

  if Assigned(FOnAfterRedirect) then
  begin
    LDoCloseForm:= FALSE;

    FOnAfterRedirect(FLastURL, LDoCloseForm);

    if LDoCloseForm then
      self.Close;
  end;
end;

procedure Tfrm_OAuthWebForm.BrowserTitleChange(ASender: TObject; const Text: WideString);
var LCloseForm : boolean;
begin
  if (Text <> FLastTitle) then
  begin
    FLastTitle := Text;

    if Assigned(FOnBrowserTitleChanged) then
    begin
      LCloseForm:= FALSE;
      FOnBrowserTitleChanged( FLastTitle, LCloseForm );

      if LCloseForm then
        self.Close;
    end;
  end;
end;

procedure Tfrm_OAuthWebForm.FormCreate(Sender: TObject);
begin
  FOnAfterRedirect := NIL;
  FOnBeforeRedirect:= NIL;
  FOnBrowserTitleChanged:= NIL;

  FLastTitle := '';
  FLastURL := '';
end;

procedure Tfrm_OAuthWebForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
  begin
    Close;
  end;
end;

procedure Tfrm_OAuthWebForm.ShowModalWithURL(const AURL: string);
begin
  /// for backwards-compatibility only
  ShowWithURL( AURL );
end;

procedure Tfrm_OAuthWebForm.ShowWithURL(const AURL: string);
begin
  Browser.Navigate(AURL);
  self.ShowModal;
end;

end.
