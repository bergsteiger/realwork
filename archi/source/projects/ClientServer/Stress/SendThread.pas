unit SendThread;

interface

uses
 ncsMessageQueue, l3Base;

type
 TSendThread = class(Tl3ThreadContainer)
 private
  f_Queue : TncsMessageQueue;
  f_IterateCount: Integer;
  f_FileName: String;
  f_PartSize: Integer;
 protected
   procedure DoExecute; override;
 protected
   procedure Cleanup; override;
 public
   constructor Create(anQueue: TncsMessageQueue; anIterateCount: Integer; const aFileName: String; aPartSize: Integer);
 end;

implementation

uses
 ncsPushFilePart, SysUtils, Classes, l3Stream, l3Types, l3TempMemoryStream, ncsMessage;

{ TSendThread }

procedure TSendThread.Cleanup;
begin
 FreeAndNil(f_Queue);
 inherited;
end;

constructor TSendThread.Create(anQueue: TncsMessageQueue; anIterateCount: Integer; const aFileName: String; aPartSize: Integer);
begin
 inherited Create;
 anQueue.SetRefTo(f_Queue);
 f_IterateCount := anIterateCount;
 f_FileName := aFileName;
 f_PartSize := aPartSize;
end;

procedure TSendThread.DoExecute;
var
 l_Message: TncsPushFilePart;
// l_Message: TncsMessage;
 l_Stream: TStream;
 l_Stream2: TStream;
 l_IDX: Integer;
begin
 l_Stream := Tl3FileStream.Create(f_FileName, l3_fmRead);
 try
  for l_IDX := 0 to f_IterateCount - 1 do
  begin
   l_Stream.Seek(0, soBeginning);
//   l_Message := TncsMessage.Create;
   l_Message := TncsPushFilePart.Create;
   try
    l_Message.Data.CopyFrom(l_Stream, f_PartSize);
    l_Stream2 := Tl3TempMemoryStream.Create;
    try
     l_Message.SaveToEVD(l_Stream2, nil);
    finally
     FreeAndNil(l_Stream2);
    end;
    f_Queue.Push(l_Message);
   finally
    FreeAndNil(l_Message);
   end;
  end;
 finally
  FreeAndNil(l_Stream);
 end;
 f_Queue.Processing := False;
end;

end.
