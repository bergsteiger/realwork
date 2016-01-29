unit IWCompEdit;
{PUBDIST}

interface

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  Classes,
  IWControl, IWTypes, IWScriptEvents, IWHTMLTag;

type
  TIWCustomEdit = class(TIWControl)
  protected
    FBGColor: TIWColor;
    FMaxLength: Integer;
    FOnSubmit: TNotifyEvent;
    FPasswordPrompt: Boolean;
    FRequired: Boolean;
    FReadOnly: Boolean;
    FTagType: string;
    //
    procedure DoSubmit;
    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
    procedure SetValue(const AValue: string); override;
    procedure Submit(const AValue: string); override;
    procedure SetPasswordPrompt(const AValue: Boolean);
    procedure SetBGColor(const Value: TIWColor);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
    function RenderStyle: string; override;
  published
    //@@ Specifies the background color for the edit field.
    //
    //Note: This has no effect in Netscape 4.
    property BGColor: TIWColor read FBGColor write SetBGColor;
    property DoSubmitValidation;
    property Editable;
    //@@ Browsers typically ignore some of the font attributes with edit controls, however
    //all font attributes are usable when Editable = False.
    //
    //For more information on the font property, see TIWControl.Font.
    //
    //SeeAlso: TIWControl.Font
    property Font;
    property ExtraTagParams;
    property FriendlyName;
    //@@ This is the maximum length of text specified as a character count that the user will be
    // permitted to enter.
    property MaxLength: Integer read FMaxLength write FMaxLength;
    //@@ Makes the edit control read only in the browser.
    //Note: This has no effect in Netscape 4.
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    //@@ If required is true, the user will be required to enter a value in this field before
    //they can submit the form.
    property Required: Boolean read FRequired write FRequired;
    property ScriptEvents;
    property TabOrder;
    //
    //@@ OnSubmit will be fired if the user presses enter while in this field.
    //Note: This does not work in Netscape 4.
    property OnSubmit: TNotifyEvent read FOnSubmit write FOnSubmit;
  end;

  TIWEdit = class(TIWCustomEdit)
  published
    //@@ If True, this indicates that this field is to be used for password or other masked entry.
    // When True, the field will not show the text the user is typing. Instead of the actual
    // characters a single mask character such as * will be displayed. The actual character that is
    // displayed is determined by the browser. This only affects display, and not the actual data
    // that is available for use at run time.
    //
    // This is usually done to prevent people from obtaining a password simply by looking over the
    // user's shoulder.
    property PasswordPrompt: boolean read FPasswordPrompt write SetPasswordPrompt;
    property Text;
  end;

  TReceivedFileEvent = procedure (ASender: TObject; const AFilename: string) of object;

  TIWCustomFile = class(TIWCustomEdit)
  protected
    FContentType: string;
    FFileName: string;
    FFileData: TStream;
    FOnReceivedFile: TReceivedFileEvent;

    function GetContentType: string;
    function GetFileName: string;
    function GetFileData: TStream;
    procedure DoReceivedFile(const AFileName:string);
  public
    constructor Create(AOwner: TComponent); override;

    procedure SaveToFile(AFilename: string = '');
    procedure SaveToStream(AStream: TStream);

    property ContentType: string read GetContentType;
    property Filename: string read GetFileName;
    property FileData: TStream read GetFileData;

  published
    property OnReceivedFile: TReceivedFileEvent read FOnReceivedFile write FOnReceivedFile;
  end;

  TIWFile = class(TIWCustomFile)
  end;

implementation

uses
  IWAppForm, IWApplication, IWCompLabel, IWFileParser, IWResourceStrings,
  SWSystem, SysUtils;

procedure TIWCustomEdit.SetValue(const AValue: string);
begin
  Text := AValue;
  Invalidate;
end;

function TIWCustomEdit.RenderHTML: TIWHTMLTag;
var
  LLabel: TIWLabel;
  LTag: TIWHTMLTag;
begin
  result := nil;
  if Editable then begin
    Result := TIWHTMLTag.CreateTag('INPUT'); try
      Result.AddStringParam('TYPE', FTagType);
      Result.AddStringParam('NAME', HTMLName);
      if MaxLength > 0 then begin
        Result.AddIntegerParam('MAXLENGTH', MaxLength);
      end;
      Result.AddIntegerParam('SIZE', Width div 7);
      Result.AddStringParam('VALUE', TextToHTML(Text));
      Result.Add(iif(ReadOnly, 'READONLY'));
      if Required then begin
        TIWAppForm(Form).AddValidation('GSubmitter.' + HTMLName + '.value.length==0'
         , Format(RSValidationRequeredField, [FriendlyName]));
      end;
      if AnsiSameText(FTagType, 'FILE') then begin
        LTag := Result;
        Result := TIWHTMLTag.CreateTag('SPAN'); try
          Result.Contents.AddTagAsObject(LTag);
          Result.AddStringParam('NAME', HTMLName + 'SPAN');
          Result.ScriptedTag := LTag;
        except FreeAndNil(LTag); raise; end;
      end;
    except FreeAndNil(Result); raise; end;
  end else begin
    LLabel := TIWLabel.Create(Self); try
      LLabel.Name := Name;
      LLabel.Caption := Text;
      LLabel.Font.Assign(Font);
      LLabel.Width := Width;
      LLabel.Height := Height;
      Result := LLabel.RenderHTML;
    finally FreeAndNil(LLabel); end;
  end;
end;

procedure TIWCustomEdit.DoSubmit;
begin
  if Assigned(OnSubmit) then begin
    OnSubmit(Self);
  end;
end;

procedure TIWCustomEdit.Submit(const AValue: string);
begin
  DoSubmit;
end;

function TIWCustomEdit.RenderStyle: string;
begin
  Result := inherited RenderStyle
   + iif(Font.Color <> clNone, 'color:' + ColorToRGBString(Font.Color))
   + iif(BGColor <> clNone, 'background:' + ColorToRGBString(BGColor));
end;

procedure TIWCustomEdit.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  if Assigned(OnSubmit) then begin
    AScriptEvents.HookEvent('OnKeyPress', 'CheckReturnKey(event.keyCode, ''' + HTMLName
     + ''', ' + iif(DoSubmitValidation, 'true', 'false') + ')');
  end;
end;

constructor TIWCustomEdit.Create(AOwner: TComponent);
begin
  inherited;
  FBGColor := clNone;
  FNeedsFormTag := True;
  FSupportsInput := True;
  FSupportsSubmit := True;
  FSupportedScriptEvents := 'OnBlur,OnChange,OnFocus,OnKeyPress,OnSelect';
  Height := 21;
  Width := 121;
  FTagType := 'TEXT';
end;

{ TIWCustomFile }

constructor TIWCustomFile.Create(AOwner: TComponent);
begin
  inherited;
  FTagType := 'FILE';
  FControlEncode := ceMPFormData;
end;

procedure TIWCustomFile.DoReceivedFile(const AFileName: string);
begin
  if Assigned(FOnReceivedFile) then begin
    OnReceivedFile(Self, AFileName);
  end;
end;

function TIWCustomFile.GetContentType: string;
begin
  Result := THTTPFiles(WebApplication.FileList).GetContentType(Name);
end;

function TIWCustomFile.GetFileData: TStream;
begin
  Result := THTTPFiles(WebApplication.FileList).GetFileData(Name);
end;

function TIWCustomFile.GetFileName: string;
begin
  Result := THTTPFiles(WebApplication.FileList).GetFileName(Name);
  if FFileName <> '' then begin
    DoReceivedFile(FFilename);
  end;
end;

procedure TIWCustomFile.SaveToFile(AFilename: string = '');
begin
  if AFileName = '' then begin
    AFileName := Filename;
  end;
  THTTPFiles(WebApplication.FileList).SaveToFile(Name, AFileName);
end;

procedure TIWCustomFile.SaveToStream(AStream: TStream);
begin
  THTTPFiles(WebApplication.FileList).SaveToStream(Name, AStream);
end;

procedure TIWCustomEdit.SetPasswordPrompt(const AValue: Boolean);
begin
  FTagType := IIF(AValue, 'PASSWORD', 'TEXT');
  FPasswordPrompt := AValue;
end;

procedure TIWCustomEdit.SetBGColor(const Value: TIWColor);
begin
  FBGColor := Value;
  Invalidate;
end;

end.
