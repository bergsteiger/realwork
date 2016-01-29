unit D_About;

{ $Id: D_About.pas,v 1.5 2002/07/16 15:45:54 law Exp $ }

// $Log: D_About.pas,v $
// Revision 1.5  2002/07/16 15:45:54  law
// - some refactoring.
//
// Revision 1.4  2002/04/06 11:33:55  law
// - Delphi 6.0.
//
// Revision 1.3.2.1  2001/10/03 06:29:37  law
// - new project: EverestLite 2001.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, l3Base;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    lbArchi: TLabel;
    lbWebPage: TLabel;
    lbDownloadVersion: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lbArchiClick(Sender: TObject);
    procedure lbWebPageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  ShellAPI,

  l3Chars,
  vtVerInf,

  MainEditor
  ;

{$R *.DFM}

procedure TAboutBox.FormCreate(Sender: TObject);
var
 VI : TVersionInfo;
begin
 VI := TVersionInfo.Create;
 try
  Version.Caption := Version.Caption + cc_HardSpace + VI.FileVersion;
 finally
  l3Free(VI);
 end;{try..finally}
end;

procedure TAboutBox.lbArchiClick(Sender: TObject);
var
 VI : TVersionInfo;
begin
 VI := TVersionInfo.Create;
 try
  ShellExecute(MainForm.Handle, nil,
               PChar('mailto:everesteditor@chat.ru?subject=Everest%20Editor%20'+
                     VI.FileVersion),
               nil, nil, SW_ShowNormal);
 finally
  l3Free(VI);
 end;{try..finally}
end;

procedure TAboutBox.lbWebPageClick(Sender: TObject);
begin
 ShellExecute(MainForm.Handle, nil,
              PChar('http://everesteditor.chat.ru'),
              nil, nil, SW_ShowNormal);
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
(* try
  httpCurrentVersion.Get('http://everesteditor.chat.ru/version.txt');
  lbDownloadVersion.Caption := lbDownloadVersion.Caption + cc_HardSpace + httpCurrentVersion.Body;
 except
  lbDownloadVersion.Visible := false;
 end;//try..except*)
 lbDownloadVersion.Visible := false;
end;

end.

