program EXmlTest;

uses
  Forms,
  ExMain in 'ExMain.pas' {MainForm};
(*  XmlParserStrings in 'E:\util\cuexml2b\XmlParserStrings.pas',
  XmlParserConsts in 'E:\util\cuexml2b\XmlParserConsts.pas',
  XmlParser in 'E:\util\cuexml2b\XmlParser.pas',
  XmlObjModel in 'E:\util\cuexml2b\XmlObjModel.pas';*)

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
