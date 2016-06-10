unit ivpMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, imageenio, ieview, imageenview, l3InterfacedComponent;

type
  TForm1 = class(TForm)
    View: TImageEnView;
    IO: TImageEnIO;
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
var
 l_FS: TFileStream;
begin

 l_FS := TFileStream.Create('c:\temp\pict3.wmf', fmOpenRead);
 try
  IO.LoadFromStream(l_FS);
 finally
  FreeAndNil(l_FS);
 end;
 {}
 //IO.LoadFromFile('c:\temp\pict1.wmf');
end;

end.
