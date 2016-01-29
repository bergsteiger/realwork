unit IWCompCheckbox;
{PUBDIST}

interface

uses
  Classes, IWHTMLTag,
  IWControl, IWTypes, IWScriptEvents;

type
  TIWCustomCheckBoxStyle = (stNormal, stCool);

  TIWCustomCheckBox = class(TIWControl)
  protected
    FChecked: Boolean;
    FStyle: TIWCustomCheckBoxStyle;
    //
    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
    //
    procedure Submit(const AValue: string); override;
    procedure SetValue(const AValue: string); override;
    //
    procedure SetChecked(AValue: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    //
    function RenderHTML: TIWHTMLTag; override;
    //
    //@@ This property indicates that the checkbox is checked. Setting this to true will cause the
    // checkbox to appear checked in the user's web-browser.
    property Checked: Boolean read FChecked write SetChecked;
  published
    //@@ This is the text that is displayed on the to the right of the check box in the browser.
    property Caption;
    property Editable;
    property ExtraTagParams;
    property Font;
    property ScriptEvents;
    //@@ Specifies caption to appear with checkbox.
    property DoSubmitValidation;
    //@@ OnClick is fired when the user checks or unchecks the check box.
    property OnClick;
    //@@ Style determines how the checkbox appears to the user.
    //stNormal - Appears as a normal checkbox
    //stCool - Appears as a graphical checkbox with colors
    property Style: TIWCustomCheckBoxStyle read FStyle write FStyle;
    property TabOrder;
  end;

  TIWCheckBox = class(TIWCustomCheckBox)
  published
    property Checked;
  end;

implementation

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  IWAppForm,
  SysUtils, SWSystem;

function TIWCustomCheckBox.RenderHTML: TIWHTMLTag;
begin
  // Div is a must here becouse the HTML is constructed by TAG + Caption or 2 TAGS
  Result := TIWHTMLTag.CreateTag('SPAN'); try
    Result.AddStringParam('ID', HTMLName);
    Result.AddStringParam('NAME', HTMLName + '_CHECKBOX');
    if (Style = stNormal) then begin
      Result.ScriptedTag := Result.Contents.AddTag('INPUT');
      with Result.ScriptedTag do begin
        if Editable then begin
          AddStringParam('TYPE', 'CHECKBOX');
          Add(iif(FChecked, 'CHECKED'));
          AddStringParam('NAME', HTMLName);
          AddStringParam('ID', HTMLName + '_CHECKBOX');
        end else begin
          AddStringParam('TYPE', 'CHECKBOX');
          Add(iif(FChecked, 'CHECKED'));
          AddStringParam('OnClick', 'return false;');
        end;
      end;
      Result.Contents.AddText(Caption);
    end else begin
      if Editable then begin
        with TIWAppForm(Form) do begin
          CacheImage('TIWCustomCheckBox_False', WebApplication.URLBase
           + '/gfx/TIWCustomCheckBox_False.gif');
          CacheImage('TIWCustomCheckBox_True', WebApplication.URLBase
           + '/gfx/TIWCustomCheckBox_True.gif');
          AddToInitProc('document.images.' + HTMLName + '_Image.src'
           + '=GImageCache_TIWCustomCheckBox_' + iif(FChecked, 'True', 'False') + '.src;' + EOL
           + 'GSubmitter.elements[''' + HTMLName + '''].value="' + iif(FChecked, 'On', 'Off')
           + '";' + EOL);
        end;
        //TODO: Use a TIWHTMLImage
        with Result.Contents.AddTag('A') do begin
          AddStringParam('HREF', '#');
          AddStringParam('OnClick'
            , 'TIWCustomCheckBoxToggle(''' + HTMLName + ''', ' + 'document.images.' + HTMLName
            + '_Image, ' + iif(Assigned(OnClick), 'true', 'false') + ')');
          with Contents.AddTag('INPUT') do begin
            AddStringParam('TYPE', 'HIDDEN');
            AddStringParam('NAME', HTMLName);
            AddStringParam('ID', HTMLName);
          end;
          with Contents.AddTag('IMG') do begin
            AddStringParam('NAME', HTMLName + '_Image');
            AddIntegerParam('BORDER', 0);
            // Width and height tags necessary for NS4, good for others
            AddIntegerParam('WIDTH', 10);
            AddIntegerParam('HEIGHT', 12);
          end;
        end;
      end else begin
        //TODO: Use a TIWHTMLImage
        with Result.Contents.AddTag('IMG') do begin
          AddStringParam('SRC', WebApplication.URLBase + '/gfx/TIWCustomCheckBox_' + iif(FChecked, 'True', 'False') + '.gif');
          AddIntegerParam('BORDER', 0);
          // Width and height tags necessary for NS4, good for others
          AddIntegerParam('WIDTH', 10);
          AddIntegerParam('HEIGHT', 12);
        end;
      end;
      Result.Contents.AddText(Caption);
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWCustomCheckBox.SetValue(const AValue: string);
begin
  FChecked := AnsiSameText(AValue, 'On');
  Invalidate;
end;

procedure TIWCustomCheckBox.Submit(const AValue: string);
begin
  DoClick;
end;

procedure TIWCustomCheckBox.SetChecked(AValue: boolean);
begin
  FChecked := AValue;
  Invalidate;
end;

constructor TIWCustomCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FNeedsFormTag := True;
  FSupportsInput := True;
  FSupportsSubmit := True;
  FSupportedScriptEvents := 'OnBlur,OnClick,OnFocus';
  Height := 21;
  Width := 121;
end;

procedure TIWCustomCheckBox.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(AScriptEvents);
  if (Style = stNormal) and Editable then begin
    AScriptEvents.HookEvent('OnClick', iif(Assigned(OnClick), SubmitHandler));
  end;
end;

end.
