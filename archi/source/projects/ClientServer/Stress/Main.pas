unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
 SendThread, ncsMessageQueue, ReceiveThread, ncsMessageFactory, ncsPushFilePart,
 ncsMessage, l3TempMemoryStream, k2Base;

{$R *.dfm}

const
 cIterateCount = 1000;

procedure TForm3.Button1Click(Sender: TObject);
var
 l_Send: TSendThread;
// l_Send2: TSendThread;
 l_Receive: TReceiveThread;
 l_Queue: TncsMessageQueue;
begin
 l_Queue := TncsMessageQueue.Create;
 try
  l_Queue.Processing := True;
  l_Send := TSendThread.Create(l_Queue, cIterateCount, Edit1.Text, StrToInt(Edit2.Text));
  try
//   l_Send2 := TSendThread.Create(l_Queue, cIterateCount, Edit1.Text, StrToInt(Edit2.Text));
   l_Receive := TReceiveThread.Create(l_Queue);
   try
    l_Receive.Suspended := False;
//    l_Send2.Suspended := False;
    l_Send.Suspended := False;
    l_Send.WaitFor;
//    l_Send2.WaitFor;
    l_Receive.WaitFor;
   finally
//    FreeAndNil(l_Send2);
    FreeAndNil(l_Receive);
   end;
  finally
   FreeAndNil(l_Send);
  end;
 finally
  FreeAndNil(l_Queue);
 end;
 ShowMessage('Done');
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 TncsMessageFactory.Instance.Register(TncsPushFilePart);
 Tk2TypeTable.GetInstance;
 Edit1.Text := '\\ARCHI\archi\incoming\4law\EVDSTress\document.nsr';
end;

procedure TForm3.Button2Click(Sender: TObject);
var
 l_Message1: TncsMessage;
 l_Message2: TncsMessage;
 l_Stream: TSTream;
 l_IDX: Integer;
begin
 for l_IDX := 1 to cIterateCount do
 begin
  l_Message1 := TncsMessage.Create;
  try
   l_Stream := Tl3TempMemoryStream.Create;
   try
    l_Message1.SaveToEVD(l_Stream, nil);
    l_Stream.Seek(0, soBeginning);
    l_Message2 := TncsMessageFactory.MakeFromEVD(l_Stream);
    try
    finally
     FreeAndNil(l_Message2);
    end;
   finally
    FreeAndNil(l_Stream);
   end;
  finally
   FreeAndNil(l_Message1);
  end;
 end;
 ShowMessage('Done');
end;

end.
