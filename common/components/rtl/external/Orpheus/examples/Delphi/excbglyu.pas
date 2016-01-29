unit excbglyu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OvcCkLb;

type
  TForm1 = class(TForm)
    OvcCheckList1: TOvcCheckList;
    ImageList1: TImageList;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    MyBitmaps : array[0..4] of TBitmap;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  I : Integer;
begin
  for I := 0 to 4 do begin
    {create a container for the bitmaps since the listbox}
    {does not store the bitmap, just a reference to it}
    MyBitmaps[I] := TBitmap.Create;
    ImageList1.GetBitmap(I, MyBitmaps[I]);

    {now, tell the listbox which glyph to use}
    OvcCheckList1.Glyphs[I] := MyBitmaps[I];

    {this allows the same glyph to be displayed by multiple}
    {list items and not require that multiple copies of the}
    {bitmap be created}
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I : Integer;
begin
  for I := 0 to 4 do
    MyBitmaps[I].Free;
end;

end.
