program imageview;

uses
  Forms,
  ivMain in 'ivMain.pas' {Form1},
  F_ImageView in '..\..\projects\Archi\Frames\F_ImageView.pas' {frmImgViewer: TvtFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
