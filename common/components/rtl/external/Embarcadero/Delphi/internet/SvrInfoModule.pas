{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrInfoModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd;

type
  TWebModule2 = class(TWebModule)
    PageProducerSelect: TPageProducer;
    PageProducerDetails: TPageProducer;
    procedure CleanAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure ServerListPageHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: String; TagParams: TStrings;
      var ReplaceText: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModule2: TWebModule2;

implementation

uses Web.WebReq, SvrInfoConst, SockAppReg;

{$R *.dfm}

function FormatDetail(ARequest: TWebRequest; AWebAppRegInfo: TWebAppRegInfo): string;
var
  FileStatus: string;
  Buttons: string;
begin
  Result := '';
  Buttons := '';
  Result := Format('%0:s' +
  '<TR><TD align="right">ProgID: </TD><TD><A HREF="/%1:s">%1:s</A></TD></TR>'#13#10 +     { do not localize }
  '<TR><TD align="right">FileName: </TD><TD>%6:s%5:s</TD></TR>'#13#10,  { do not localize }
   [Result, AWebAppRegInfo.ProgID, AWebAppRegInfo.FileName, ARequest.ScriptName,
    ARequest.Host, ExtractFileName(AWebAppRegInfo.FileName),
    ExtractFilePath(AWebAppRegInfo.FileName)]);
  if AWebAppRegInfo.FileName <> '' then
  begin
    if FileExists(AWebAppRegInfo.FileName) then
      FileStatus := sFound
    else
      FileStatus := sNotFound;
    Buttons := Format('<FORM Method="POST" Action="%s/Clean">' +           { do not localize }
    '<INPUT TYPE=HIDDEN NAME="ProgID" VALUE="%s"/><INPUT TYPE=SUBMIT VALUE="Clean"/></FORM>', { do not localize }
     [ARequest.InternalScriptName, AWebAppRegInfo.ProgID]);
    Result := Format('%0:s<TR><TD align="right">%2:s </TD><TD>%1:s</TD></TR>',   { do not localize }
      [Result, FileStatus, sFileStatus]);
  end;

  Result := Format('<TABLE border=1 width="90%%"><TD><TABLE width="100%%">' +    { do not localize }
  '<TD><TABLE>%0:s</TABLE></TD><TD align="right" valign=top">%1:s</TD>' +        { do not localize }
  '</TABLE></TABLE>', [Result, Buttons]);                                        { do not localize }
end;

function CompareProgID(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(TWebAppRegInfo(Item1).ProgID, TWebAppRegInfo(Item2).ProgID);
end;

function FormatDetails(ARequest: TWebRequest): string;
var
  I: Integer;
  WebAppRegList: TWebAppRegList;
begin
  WebAppRegList := TWebAppRegList.Create;
  try
    SockAppReg.GetRegisteredWebApps(WebAppRegList);
    WebAppRegList.Sort(CompareProgID);
    for I := 0 to WebAppRegList.Count - 1 do
      Result := Format('%0:s<p>%1:s', [Result, FormatDetail(ARequest, WebAppRegList.Items[I])]);
  finally
    WebAppRegList.Free;
  end;
end;

function FormatOption(ARequest: TWebRequest; const AProgID: string): string;
begin
  Result := Format('<OPTION value="%0:s">%0:s</OPTION>', [AProgID]);     { do not localize }
end;

function FormatSelect(ARequest: TWebRequest): string;
var
  I: Integer;
  WebAppRegList: TWebAppRegList;
begin
  WebAppRegList := TWebAppRegList.Create;
  try
    SockAppReg.GetRegisteredWebApps(WebAppRegList);
    WebAppRegList.Sort(CompareProgID);
    for I := 0 to WebAppRegList.Count - 1 do
      Result := Format('%0:s'#13#10'%1:s', [Result, FormatOption(ARequest, WebAppRegList.Items[I].ProgID)]);
    Result := Format('<SELECT name="S" size="%d" onenter="F.Submit()">'#13#10'%s'#13#10'</SELECT>', [WebAppRegList.Count, Result]);    { do not localize }
  finally
    WebAppRegList.Free;
  end;
  Result := '<FORM name="F" OnSubmit="Go(document.F.S.value);return false">'#13#10 +   { do not localize }
    '<TABLE>'#13#10 +                                                                  { do not localize }
    '<TD>'#13#10 +                                                                     { do not localize }
    Result +                                                                           { do not localize }
    '<TD valign="top">'#13#10 +                                                        { do not localize }
    '<INPUT TYPE=SUBMIT value="' + sGo + '">'#13#10 +                                  { do not localize }
    //'<INPUT TYPE=SUBMIT VALUE="Go" OnClick="Go(document.F.S.value);return false">'#13#10 +   { do not localize }
    '</TABLE>'#13#10 +                                                                 { do not localize }
    '</FORM>'#13#10;                                                                   { do not localize }

end;

procedure TWebModule2.ServerListPageHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: String; TagParams: TStrings; var ReplaceText: String);
begin
  if CompareText(TagString, 'DETAILS') = 0 then                               { do not localize }
    ReplaceText := FormatDetails(Request)
  else if CompareText(TagString, 'LIST') = 0 then                             { do not localize }
    ReplaceText := FormatSelect(Request)
  else if CompareText(TagString, 'PATH') = 0 then                             { do not localize }
    ReplaceText := string(Request.InternalScriptName) + '/';
end;

procedure TWebModule2.CleanAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Redirect: string;
  ProgID: string;
begin

  ProgID := Request.ContentFields.Values['ProgID'];                          { do not localize }
  if ProgID = '' then
    raise Exception.Create(sMissingProgID);

  SockAppReg.UnregisterWebApp(ProgID);

  Redirect := Format('http://%s%s/Details', [Request.Host, Request.InternalScriptName]); { Do not localize }
  Response.SendRedirect(AnsiString(Redirect));
end;

initialization
  WebRequestHandler.WebModuleClass := TWebModule2;

end.
