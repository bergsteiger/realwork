program EXml;

uses
  Forms,
  Registry,
  Windows,
  ExMain in 'ExMain.pas' {MainForm},
  ExChildW in 'ExChildW.pas' {XmlChild},
  ExAttr in 'ExAttr.pas' {AttributeForm},
  ExElemnt in 'ExElemnt.pas' {ElementForm},
  ExText in 'ExText.pas' {TextForm},
  ExCommnt in 'ExCommnt.pas' {CommentForm},
  ExProcIn in 'ExProcIn.pas' {PIForm},
  ExPrefs in 'ExPrefs.pas' {PrefsForm},
  ExURL in 'ExURL.pas' {URLForm},
  ExSelAtt in 'ExSelAtt.pas' {SelAttrsForm},
  XpDom in '..\..\..\XpDOM.pas',
  ExErr in 'ExErr.pas' {frmErrors},
  ExUtil in 'ExUtil.pas',
  xpAboutw in '..\..\..\XpAboutw.pas' {XpAboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TElementForm, ElementForm);
  Application.CreateForm(TTextForm, TextForm);
  Application.CreateForm(TCommentForm, CommentForm);
  Application.CreateForm(TSelAttrsForm, SelAttrsForm);
  Application.CreateForm(TfrmErrors, frmErrors);
  Application.CreateForm(TXpAboutBox, XpAboutBox);
  Application.Run;
end.
