unit IWCompText;
{PUBDIST}

interface

uses
  Classes,
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  IWControl, IWHTMLTag;

type
  TIWCustomText = class(TIWControl)
  protected
    FLines: TStrings;
    FRawText: boolean;
    FWantReturns: boolean;
    //
    // procedure TextChangedNotification; override;
    procedure SetLines(const AValue: TStrings);
    //
    //@@ This property indicates that the Lines property contains HTML which should be rendered as
    // is. If this is true, the Text is treated as if it was valid HTML and is not parsed or
    // modified in any way. This is useful if want a high-degree of control over the presentation
    // and you know what you are doing.
    //
    // If this is false, all text in the Lines property is rendered as text even if it contains
    // HTML and characters in need of encoding are translated to HTML.
    //
    //SeeAlso: Lines, WantReturns
    property RawText: boolean read FRawText write FRawText;
    //@@ This property indicates that the text in the lines property should honor the carriage
    // returns in the Lines property. This property is ignored if the RawText property is set to
    // True.
    //
    // SeeAlso: Lines, RawText
    property WantReturns: Boolean read FWantReturns write FWantReturns;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function RenderHTML: TIWHTMLTag; override;
    //
    //@@ This TStrings property contains the text which will be displayed to the user. You can set
    // this at design-time or manipulate it at run-time with methods such as LoadFromFile.
    //
    // You can set the font property to a font you wish the text to be rendered in. If you wish the
    // text to be displayed with the Carriage returns from your text, you may set the WantReturns
    // property to True otherwise the web-browser will wrap words as it sees fit.
    //
    // If you set the UseFrame property to True, text is placed in a scrollable region in the user's
    // web-browser.
    //
    // If you set RawText to true, you can have your own HTML in your IntraWeb application by
    // setting the Lines property to your HTML.
    //
    //SeeAlso: Font, RawText, WantReturns
    property Lines: TStrings read FLines write SetLines;
  end;

  TIWText = class(TIWCustomText)
  public
  published
    property Font;
    property Lines;
    property RawText;
    property UseFrame;
    property WantReturns;
  end;

implementation

uses
{$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
  IWServerControllerBase,
  SysUtils, SWSystem;

constructor TIWCustomText.Create(AOwner: TComponent);
begin
  inherited;
  Height := 121;
  Width := 121;
  FLines := TStringList.Create;
  FWantReturns := True;
end;

destructor TIWCustomText.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

procedure TIWCustomText.SetLines(const AValue: TStrings);
begin
  FLines.Assign(AValue);
  Text := FLines.Text;
  Invalidate;
end;

{ TIWHTMLText }

function TIWCustomText.RenderHTML: TIWHTMLTag;
Var
  S: String;
begin
  S := FLines.Text;
  if not RawText then begin
    S := TextToHTML(S, WantReturns);
  end else if WantReturns then begin
    S := StringReplace(S, EOL, '<br>', [rfReplaceAll]);
  end;

  result := TIWHTMLTag.CreateTag('SPAN'); try
    result.Contents.AddText(S);
  except FreeAndNil(Result); raise; end;
end;

end.

