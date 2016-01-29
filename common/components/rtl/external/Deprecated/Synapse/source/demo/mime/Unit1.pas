unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mimemess, mimepart;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Memo1: TMemo;
    Button2: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    Mime:TMimemess;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  n:integer;
  s:string;
begin
  mime.Clear;
  listbox1.Clear;
  memo1.Clear;
  mime.Lines.LoadFromFile(edit1.text);
  mime.DecodeMessage;
  ShowMessage(datetimetostr(mime.Header.Date));
  for n:=0 to mime.MessagePart.GetSubPartCount-1 do
    begin
      with mime.MessagePart.GetSubPart(n) do
        begin
          s:=format('%12s/%-12s %-15s %-s',[primary,secondary,filename,description]);
        end;
      listbox1.items.Add(s);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  mime:=TMimemess.create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  mime.free;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  memo1.Lines.assign(mime.MessagePart.GetSubPart(listbox1.ItemIndex).Lines);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f:string;
begin
  with mime.MessagePart.GetSubPart(listbox1.ItemIndex) do
    begin
      f:=filename;
      if f=''
        then f:='mimedemo.txt';
      f:='c:/'+f;
      Decodepart;
      decodedlines.SaveToFile(f);
    end;
end;

end.
