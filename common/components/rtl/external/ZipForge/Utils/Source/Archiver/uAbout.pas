
//------------------------------------------------------------------------------
//About screen
//------------------------------------------------------------------------------

unit uAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgName: TLabel;
    OKButton: TButton;
    Version: TLabel;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProgramIconClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses arch1;

{$R *.dfm}

//------------------------------------------------------------------------------
// Close window
//------------------------------------------------------------------------------
procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
 Close;
end; // TAboutBox.OKButtonClick

//------------------------------------------------------------------------------
// Some variables initialization
//------------------------------------------------------------------------------
procedure TAboutBox.FormCreate(Sender: TObject);
var s:string;
begin
 s := Archiver.ClassName; //Get class name
 delete(s,1,1); //Delete first char
 ProgName.Caption := s+' archiver'; //Show program name
 Version.Caption := 'Version : '+Archiver.CurrentVersion; //Show current version
end; // TAboutBox.FormCreate

//------------------------------------------------------------------------------
// Connect to AidAim site
//------------------------------------------------------------------------------
procedure TAboutBox.ProgramIconClick(Sender: TObject);
begin
 ShellExecute(Handle,'Open',
              pchar('http://www.aidaim.com'),nil,nil,SW_SHOWNORMAL);
end; // TAboutBox.ProgramIconClick

end.

