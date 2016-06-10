unit ivMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vtForm, F_ImageView;

type
  TForm1 = class(TForm)
    ImgViewer: TfrmImgViewer;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
 //ImgViewer.LoadFileNew('c:\temp\123.tif', '');
 ImgViewer.LoadFileNew('c:\temp\091089a.TIF', '');
 //ImgViewer.LoadFileNew('c:\temp\concept2015.tif', '');
end;

end.
