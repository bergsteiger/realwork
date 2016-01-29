unit IWCompMemo;
{PUBDIST}

interface

uses
  Classes,
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  IWHTMLTag, IWControl;

type
  TIWCustomMemo = class(TIWControl)
  protected
    FLines: TStrings;
    FRawText: Boolean;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FEndsWithCRLF: Boolean;
    FWantReturns: Boolean;
    //
    procedure SetLines(const AValue: TStrings);
    procedure SetValue(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function RenderHTML: TIWHTMLTag; override;
    // make it visible to PaintHandler
    property Lines: TStrings read FLines write SetLines;
  published
    property Editable;
    property ExtraTagParams;
    //@@ Font is not supported when Editable = False.
    property Font;
    property ScriptEvents;
    property RawText: Boolean read FRawText write FRawText;
    //@@ Makes the memo control read only in the browser.
    //Note: This has no effect in Netscape 4.
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    //@@ If Required is True the user must enter data in this field before submiting the page.
    //SeeAlso: FriendlyName

    property Required: Boolean read FRequired write FRequired;
    property TabOrder;
    property WantReturns: Boolean read FWantReturns write FWantReturns;
  end;

  TIWMemo = class(TIWCustomMemo)
  public
  published
    property FriendlyName;
    property Lines;
  end;

implementation

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  IWAppForm, IWCompText, IWResourceStrings, IWGlobal,
  SysUtils, SWSystem;

constructor TIWCustomMemo.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  FNeedsFormTag := True;
  FSupportsInput := True;
  FSupportedScriptEvents := 'OnBlur,OnChange,OnFocus,OnKeyDown,OnKeyPress,OnKeyUp,OnSelect';
  Height := 121;
  Width := 121;
  FEndsWithCRLF := true;
end;

destructor TIWCustomMemo.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

function TIWCustomMemo.RenderHTML: TIWHTMLTag;
var
  LDest: TIWText;
  S: String;
begin
  Result := nil;
  if Editable then begin
    Result := TIWHTMLTag.CreateTag('TEXTAREA'); try
      // Netscape can handle fonts here using method in TIWEdit, but IE cannot.
      Result.AddStringParam('NAME', HTMLName);
      Result.AddIntegerParam('ROWS', Height div 16);
      Result.AddIntegerParam('COLS', Width div 7);
      Result.Add(iif(ReadOnly, 'READONLY'));
      S := FLines.Text;
      if not FEndsWithCRLF and (Length(S) >= Length(sLineBreak)) then
        SetLength(S, Length(S) - Length(sLineBreak));
      Result.Contents.AddText(S);
      UseFrame := False;
    except FreeAndNil(Result); raise; end;
  end else begin
    LDest := TIWText.Create(Self); try
      LDest.Name := Self.Name;
      LDest.Color := Self.Color;
      LDest.FriendlyName := Self.FriendlyName;
      LDest.ExtraTagParams := Self.ExtraTagParams;
      LDest.Font.Assign(Self.Font);
      LDest.ScriptEvents.Assign(Self.ScriptEvents);
      LDest.RawText := Self.RawText;
      LDest.Width := Self.Width;
      LDest.Height := Self.Height;
      LDest.Lines := Lines;
      LDest.WantReturns := Self.WantReturns;
      Result := LDest.RenderHTML;
    finally FreeAndNil(LDest); end;
    UseFrame := True;
  end;

  if Required and SupportsInput then begin
    TIWAppForm(Form).AddValidation('GSubmitter.' + HTMLName + '.value.length==0'
     , Format(RSValidationRequeredField, [FriendlyName]));
  end;
end;

procedure TIWCustomMemo.SetLines(const AValue: TStrings);
begin
  FLines.Assign(AValue);
  FEndsWithCRLF := true;
  Invalidate;
end;

procedure TIWCustomMemo.SetValue(const AValue: string);
begin
  FLines.Text := AValue;
  FEndsWithCRLF := FLines.Text = AValue;
  // Will use Text internally to set the real value
  Text := AValue;
  Invalidate;
end;

end.
