unit IWCompButton;
{PUBDIST}

interface

uses
  Classes,
  IWControl, IWHTMLTag, IWScriptEvents;

type
  TIWButtonType = (btSubmit, btButton, btReset);

  TIWCustomButton = class(TIWControl)
  protected
    FButtonType: TIWButtonType;
    FOnClick: TScriptEvent;
    FHotKey: string;

    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
    property ButtonType: TIWButtonType read FButtonType write FButtonType;
    property HotKey: string read FHotkey write FHotKey;
  end;

  TIWButton = class(TIWCustomButton)
  protected
    procedure Submit(const AValue: string); override;
  published
    property ButtonType;
    //@@ This is the text that will be displayed on the button.
    property Caption;
    //@@ Sets the background color for the button.
    //Note: This has no effect in Nestcape 4.
    property Color;
    property Confirmation;
    property DoSubmitValidation;
    property Enabled;
    property ExtraTagParams;
    property Font;
    property HotKey;
    property ScriptEvents;
    property TabOrder;
    //
    //@@ OnClick is fired when the user clicks on the button.
    property OnClick;
  end;

implementation

uses
{$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
{$IFNDEF Linux}Windows, {$ENDIF}
  Math, SWSystem, SysUtils;

function TIWCustomButton.RenderHTML: TIWHTMLTag;
begin
  if FHotKey <> '' then begin
    Result := TIWHTMLTag.CreateTag('BUTTON'); try
      Result.AddStringParam('ACCESSKEY', FHotKey);
      Result.Contents.AddText(StringReplace(Caption, FHotKey, '<u>' + FHotKey + '</u>', [rfIgnoreCase]));
    except FreeAndNil(result); raise; end;
  end else begin
    Result := TIWHTMLTag.CreateTag('INPUT'); try
      Result.AddStringParam('VALUE', Caption);
    except FreeAndNil(Result); raise; end;
  end;
  try
    Result.AddStringParam('NAME', HTMLName);
    case ButtonType of
      btSubmit: Result.AddStringParam('TYPE', 'submit');
      btButton: Result.AddStringParam('TYPE', 'button');
      btReset: Result.AddStringParam('TYPE', 'reset');
    end;
    if (Font.Enabled) and (Color <> clBtnFace) then begin
      Result.AddStringParam('STYLE', 'background-color: ' + ColorToRGBString(Color){ + ';'
      + Font.FontToStringStyle(WebApplication.Browser)});
    end;
    if not Enabled then begin
      Result.Add('DISABLED');
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWButton.Submit(const AValue: string);
begin
  DoClick;
end;

constructor TIWCustomButton.Create(AOwner: TComponent);
begin
  inherited;
  Color := clBtnFace;
  FNeedsFormTag := True;
  FSupportsSubmit := True;
  FSupportedScriptEvents := 'OnBlur,OnClick,OnFocus,OnMouseDown,OnMouseUp';
  FButtonType := btButton;
  FRenderSize := true;
  Height := 25;
  Width := 75;
end;

procedure TIWCustomButton.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(AScriptEvents);
  AScriptEvents.HookEvent('OnClick', iif(Assigned(OnClick), SubmitHandler));
end;

end.

