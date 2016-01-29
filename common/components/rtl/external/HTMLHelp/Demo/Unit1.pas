unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  sphtmlHelp, StdCtrls, ComCtrls ;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    CheckBox4: TCheckBox;
    Button2: TButton;
    StatusBar1: TStatusBar;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
     Application.HelpFile:=ExtractFilePath(Application.ExeName)+'HtmlHelp.chm';
     StatusBar1.Panels[0].Text:='Help file = ' + Application.HelpFile;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     Application.HelpSystem.ShowTableOfContents;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Application.HelpSystem.ShowContextHelp(6000,'');
end;

end.
