unit IWCompLabel;
{PUBDIST}

interface

uses
{$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
{$IFDEF Linux}QControls, {$ELSE}Controls, {$ENDIF}
  Classes,
  IWControl, IWHTMLTag;

type
  TIWCustomLabel = class(TIWControl)
  protected
    FRawText: Boolean;
    //
    procedure SetAutoSize(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
    //
    property AutoSize;
    property RawText: Boolean read FRawText write FRawText default True;
  published
    property Font;
  end;

  TIWLabel = class(TIWCustomLabel)
  published
    property AutoSize;
    //@@ This is the text which is displayed to the user. You may use the font to change how the
    // text is displayed to the user.
    //
    //SeeAlso: Font
    property Caption;
    property RawText;
  end;

implementation

uses
  SysUtils;

function TIWCustomLabel.RenderHTML: TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('SPAN'); try
    if not RawText then begin
      Result.Contents.AddText(TextToHTML(Caption));
    end else begin
      Result.Contents.AddText(Caption);
    end;
  except FreeAndNil(Result); raise; end;
end;

constructor TIWCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 21;
  Width := 121;
  AutoSize := true;
  FRawText := true;
end;

procedure TIWCustomLabel.SetAutoSize(Value: Boolean);
begin
  inherited SetAutoSize(Value);
  Invalidate;
end;

end.

