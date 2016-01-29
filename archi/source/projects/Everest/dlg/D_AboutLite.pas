unit D_AboutLite;

{ $Id: D_AboutLite.pas,v 1.1 2008/10/01 06:31:32 dinishev Exp $ }

// $Log: D_AboutLite.pas,v $
// Revision 1.1  2008/10/01 06:31:32  dinishev
// Диалог About для Lite-версии
//
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
  TAboutBoxLite = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
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

procedure TAboutBoxLite.FormCreate(Sender: TObject);
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

end.

