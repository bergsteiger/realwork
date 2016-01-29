unit IWTemplateProcessorHTML;

interface

uses
  Classes,
  IWApplication, IWLayoutMgr;

type
  TIWTemplateProcessorHTMLTagType = (ttIntraWeb, ttBorland);
  TIWUnknownTagEvent = procedure(const AName: string; var VValue: string) of object;

  TIWTemplateFiles = class(TPersistent)
  protected
    FDefault: string;
    FIE: string;
    FNetscape6: string;
    //
    procedure AssignTo(ADest: TPersistent); override;
  published
    //@@ Species the default template to use. If none is specified, the form's name + .html is used.
    //Must contain only a filename, and no path information.
    property Default: string read FDefault write FDefault;
    //@@ Species the template to use for Internet Explorer. If none is specified Default is used.
    //Must contain only a filename, and no path information.
    property IE: string read FIE write FIE;
    //@@ Species the template to use for Netscape 6. If none is specified Default is used.
    //Must contain only a filename, and no path information.
    property Netscape6: string read FNetscape6 write FNetscape6;
  end;

  //@@ TIWTemplateProcessorHTML is a template processor that processes HTML templates. More
  //information on usage of this component is available in the IntraWeb manual.
  TIWTemplateProcessorHTML = class(TIWLayoutMgr)
  protected
    FMasterFormTag: Boolean;
    FOnUnknownTag: TIWUnknownTagEvent;
    FTagType: TIWTemplateProcessorHTMLTagType;
    FTemplates: TIWTemplateFiles;
    //
    function DoUnknownTag(const AName: string): string;
    procedure SetTemplates(const AValue: TIWTemplateFiles);
  public
    //@@ Able returns true if Enabled and the template file exists
    function Able: Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Process(AStream: TStream; AControls: TStringList); override;
    procedure ProcessStream(AStream: TStream; ATemplateStream: TStream; AControls: TStringList);
    function TemplatePathname: string;
  published
    //@@ If the control being placed in the template is an input control or a button it must be
    //embedded in a FORM tag otherwise browsers typically ignore the control. Such controls that
    //require this are the listboxes, comboboxes, memos, edit boxes and buttons. URLs and other
    //clickable controls do not require this. One master FORM tag can be used or many. IntraWeb
    //will parse the document and retrieve data from any and all FORM sections.
    //
    //By Default IntraWeb will wrap the template output with a master FORM tag. However there are
    //HTML tags which are not valid inside of FORM tags and this may limit the flexibility of
    //certain templates. Another option is to put a FORM tag around every individual control but
    //this can lead to unwanted white space. IntraWeb's templates are designed to be easy to use,
    //however it is also a goal that they are flexible. To meet both of these goals the MastFormTag
    //property exists. Setting it to False will cause IntraWeb not to render a master FORM tag.
    //In this case you will need to insert your own FORM tags in your template to contain all
    //input and button controls.
    //
    //The FORM tag does not need to be name or have an ACTION attribute and in fact should not have
    //an ACTION attribute. The FORM tag should be of the following form:
    //
    //<FORM onSubmit="return FormDefaultSubmit();">
    //Put your HTML and input control(s) here
    //</FORM>
    //
    //Using this form will ensure that the output from your template will work properly with
    //IntraWeb. It may also add unnecessary whitespace, so be careful.
    //
    //Note: Internet Explorer will render FORM controls without a valid FORM tag, but Netscape 4
    //will not. This is because to Internet Explorer "patches" bad HTML on the fly while Netscape 4
    //typically rejects bad HTML. Even though Internet Explorer will render such controls outside of
    //a FORM tag, IntraWeb will not recognize the data from such controls.
    property MasterFormTag: Boolean read FMasterFormTag write FMasterFormTag;
    //@@ If TagType = ttBorland, Tags will be processed as <#TagName#> instead of {%TagName%}.
    //These tags are harder to use wtih WSYWIG HTML editors, but are compatible with WebBroker /
    //WebSnap type templates.
    property TagType: TIWTemplateProcessorHTMLTagType read FTagType write FTagType;
    //@@ Specifies the filename(s) to use as the template in the templates directory. If left blank
    //the processor will attempt to us a file of the same name as the form with an .html extension
    //if one exists.
    property Templates: TIWTemplateFiles read FTemplates write SetTemplates;
    //@@ OnUnknownTag is fired if while processing the template the processor finds a tag of the
    //form {%TagName%} for which it cannot find a matching component. This allows you to implement
    //your own custom handling of extra tags that IW does not recognize.
    property OnUnknownTag: TIWUnknownTagEvent read FOnUnknownTag write FOnUnknownTag;
  end;

implementation

uses
  CopyPrsr,
  IWControl, IWServerControllerBase, IWTypes, IWGlobal, IWForm, IWControlInterface,
  SysUtils, SWStrings, SWSystem, IWHTMLTag;

{ TIWTemplateProcessorHTML }

function TIWTemplateProcessorHTML.Able: Boolean;
begin
  Result := False;
  if Enabled then begin
    Result := FileExists(TemplatePathname);
  end;
end;

constructor TIWTemplateProcessorHTML.Create(AOwner: TComponent);
begin
  inherited;
  FMasterFormTag := True;
  FTemplates := TIWTemplateFiles.Create;
end;

destructor TIWTemplateProcessorHTML.Destroy;
begin
  FreeAndNil(FTemplates);
  inherited;
end;

function TIWTemplateProcessorHTML.DoUnknownTag(const AName: string): string;
begin
  Result := '';
  if Assigned(OnUnknownTag) then begin
    OnUnknownTag(AName, Result);
  end;
end;

procedure TIWTemplateProcessorHTML.Loaded;
var
  s: string;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then begin
    if Length(Templates.Default) = 0 then begin
      s := Copy(Owner.ClassName, 2, MaxInt) + '.html';
      if Assigned(GServerController) and FileExists(GServerController.TemplateDir + s) then begin
        FTemplates.Default := s;
      end;
    end;
  end;
end;

procedure TIWTemplateProcessorHTML.Process(AStream: TStream; AControls: TStringList);
var
  LSrcStream: TFileStream;
begin
  LSrcStream := TFileStream.Create(TemplatePathname, fmOpenRead + fmShareDenyWrite); try
    ProcessStream(AStream, LSrcStream, AControls);
  finally FreeAndNil(LSrcStream); end;
end;

procedure TIWTemplateProcessorHTML.ProcessStream(AStream, ATemplateStream: TStream;
 AControls: TStringList);
var
  i: Integer;
  LControl: TIWControl;
  LHeaderHasBeenWritten: Boolean;
  LParser: TCopyParser;
  LStream: TIWStream;
  LTagName: string;
  LTagParams: string;
  LName: string;
  LTerminated: Boolean;
  LWebApp: TIWApplication;

  function ProcessTag(AParser: TCopyParser; AControls: TStringList; const AEndTagChar1: Char;
   const AEndTagChar2: Char): string;
  var
    LCtrlName: string;
    LIControl: IIWControl;
  begin
    Result := '';
    with AParser do begin
      SkipToken(True);
      LCtrlName := TokenString;
      if Length(LCtrlName) > 0 then begin
        i := AControls.IndexOf(LCtrlName);
        if i > -1 then begin
          LControl := TIWControl(AControls.Objects[i]);
          LIControl := LControl;
          if Assigned(LControl.HTML) then begin
            LControl.HTML.AddStringParam('CLASS', LControl.RenderCSSClass);
            // relative positioning is not used from IW controls
            LControl.HTML.AddStringParam('STYLE', {'position:relative;' + }LControl.RenderStyle
              + LControl.HTML.Params.Values['STYLE']);
            LControl.HTML.AddStringParam('ID', LControl.HTMLName);
            Result := LControl.MakeHTMLTag(LControl.HTML);
            if not MasterFormTag then begin
              if LIControl.SupportsInput then begin
                with FormTag.Contents.AddTag('INPUT') do begin
                  AddStringParam('TYPE', 'HIDDEN');
                  AddStringParam('NAME', LControl.HTMLName);
                  AddStringParam('ID', LControl.HTMLName);
                end;
              end;
            end;
          end;
        end else begin
          Result := DoUnknownTag(LCtrlName);
        end;
      end;
      SkipToken(True);
      if TagType <> ttBorland then begin
        CheckToken(AEndTagChar1);
        SkipToken(True);
      end;
      CheckToken(AEndTagChar2);
      SkipToken(True);
    end;
  end;

  procedure SkipAndOutput(AParser: TCopyParser);
  begin
    with AParser do begin
      CopyTokenToOutput;
      SkipToken(True);
    end;
  end;

  procedure SkipOverNextHTMLTag(AParser: TCopyParser);
  begin
    with AParser do begin
      SkipToToken('<');
      SkipToken(True);
      CheckToken('/');
      SkipToToken('>');
      SkipToken(True);
    end;
  end;

  procedure WriteHead;
  begin
    LHeaderHasBeenWritten := True;
    LStream.Write('<HEAD>' + EOL + HeadContent);
    WriteScriptSection(LStream);
  end;

begin
  LStream := TIWStream(AStream);
  LParser := TCopyParser.Create(ATemplateStream, LStream); try
  LHeaderHasBeenWritten := false;

  LTerminated := false;
  if Assigned (GSetWebApplicationThreadVar) then begin
    LWebApp := GSetWebApplicationThreadVar(nil);
    GSetWebApplicationThreadVar(LWebApp);

    LTerminated := Assigned(LWebApp) and LWebApp.Terminated;
  end;

  if not LTerminated and not MasterFormTag then begin
    JavaScript := JavaScript + 'var SubmitClickConfirmOriginal = SubmitClickConfirm;' + EOL
      + 'SubmitClickConfirm = SubmitClickConfirm_Template;';
  end;
    with LParser do begin
      while Token <> toEOF do begin
        case Token of
          '<': begin
            // SkipToken first in case of short circuit
            if (SkipToken(True) = '#') and (TagType = ttBorland) then begin
              LStream.Write(ProcessTag(LParser, AControls, '#', '>'));
            end else begin
              // <!DOCTYPE - etc. this is why TokenString + SkipTo
              LTagName := TokenString;
              // Must be separate from above, SkipToToken modfies result value of TokenString
              LTagName := LTagName + SkipToToken('>');
              //SkipToken(True); Removed. Fixes CR bug. 26/04
              //
              i := Pos(' ', LTagName);
              if i > 0 then begin
                LTagParams := Copy(LTagName, i + 1, MaxInt);
                SetLength(LTagName, i - 1);
                LTagParams := StringReplace(LTagParams, '../files/', URLBase + '/files/'
                 , [rfReplaceAll, rfIgnoreCase]);
              end else begin
                LTagParams := '';
              end;
              if AnsiSameText(LTagName, 'BODY') then begin
                while Length(LTagParams) > 0 do begin
                  LName := Trim(Fetch(LTagParams, '"'));
                  LName := UpperCase(Copy(LName, 1, Length(LName) - 1));
                  if LName <> '' then begin
                    if AnsiSameText(LName, 'BGCOLOR') then begin
                      if BodyTag.Params.Values['BGCOLOR'] = '' then begin
                        BodyTag.AddStringParam('BGCOLOR', Fetch(LTagParams, '"'));
                      end;
                    end else begin
                      if AnsiSameText(LName, 'OnLoad') then begin
                        InitProc := InitProc + Fetch(LTagParams, '"') + ';';
                      end else begin
                        if AnsiSameText(LName, 'OnBlur') then begin
                           BodyTag.Params.Values[LName] := BodyTag.Params.Values[LName] + Fetch(LTagParams, '"') + ';';
                        end else begin
                          BodyTag.Params.Values[LName] := Fetch(LTagParams, '"');
                        end;
                      end;
                    end;
                  end;
                end;
                if not LHeaderHasBeenWritten then begin
                  WriteHead;
                end;
                LStream.Write(BodyTag.RenderCloseTag(false){ + EOL + BodyContent.Render});
                SkipToken(True);
                if MasterFormTag and not LTerminated then begin
                  FormTag.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
                  LStream.Write(FormTag.RenderCloseTag(false));
                  // SkipToken(True);// Added. Fixes CR bug. 26/04
                  {LStream.Write(FormContent);
                  LStream.Write('</FORM>');}
                end;
              end else if AnsiSameText(LTagName, '/BODY') then begin
                {if MasterFormTag then begin
                  // LStream.Write(FormTag.RenderCloseTag(false));
                  // SkipToken(True);// Added. Fixes CR bug. 26/04
                  // LStream.Write(FormContent);
                  LStream.Write('</FORM>');
                end;}
                if not LTerminated then begin
                  if not MasterFormTag then begin
                    FormTag.AddStringParam('onSubmit', 'return FormDefaultSubmit();');
                    LStream.Write(FormTag.RenderCloseTag(false));
                    // SkipToken(True);// Added. Fixes CR bug. 26/04
                  end;
                  LStream.Write(FormContent);
                  LStream.Write('</FORM>' + EOL);
                end;
                LStream.Write('</BODY>');
                SkipToken(True); // Added. Fixes CR bug. 26/04
              end else if AnsiSameText(LTagName, 'HEAD') then begin
                if not LHeaderHasBeenWritten then begin
                  WriteHead;
                end;
                SkipToken(True);
              end else if AnsiSameText(LTagName, 'TITLE') then begin
                if Length(Title) > 0 then begin
                  SkipOverNextHTMLTag(LParser);
                  LStream.Write('<TITLE>' + Title + '</TITLE>' + EOL);
                end else begin
                  LStream.Write('<TITLE>');
                  SkipToken(True); // Added. Fixes CR bug. 26/04
                end;
              end
              else begin
                LStream.Write('<' + Trim(LTagName + ' ' + LTagParams) + '>');
                SkipToken(True);// Added. Fixes CR bug. 26/04
              end;
            end;
          end;
          '{': begin
            // SkipToken first in case of short circuit
            if (SkipToken(True) = '%') and (TagType = ttIntraWeb) then begin
              LStream.Write(ProcessTag(LParser, AControls, '%', '}'));
            end else begin
              LStream.Write('{');
              SkipAndOutput(LParser);
            end;
          end else begin
            SkipAndOutput(LParser);
          end;
        end;
      end;
    end;
  finally FreeAndNil(LParser); end;
end;

procedure TIWTemplateProcessorHTML.SetTemplates(const AValue: TIWTemplateFiles);
begin
  FTemplates.Assign(AValue);
end;

function TIWTemplateProcessorHTML.TemplatePathname: string;
begin
  if (FBrowser = brNetscape6) and (Length(Templates.Netscape6) > 0) then begin
    Result := Templates.Netscape6;
  end else if (FBrowser = brIE) and (Length(Templates.IE) > 0) then begin
    Result := Templates.IE;
  end else if Length(Templates.Default) > 0 then begin
    Result := Templates.Default;
  end;
  Result := GServerController.TemplateDir + Result;
end;

{ TIWTemplateFiles }

procedure TIWTemplateFiles.AssignTo(ADest: TPersistent);
begin
  if ADest is TIWTemplateFiles then begin
    with TIWTemplateFiles(ADest) do begin
      Default := Self.Default;
      IE := Self.IE;
      Netscape6 := Self.Netscape6;
    end;
  end else begin
    inherited;
  end;
end;

end.

