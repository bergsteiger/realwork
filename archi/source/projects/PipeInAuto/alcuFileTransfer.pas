unit alcuFileTransfer;
{ Модуль передачи файлов на сторону клиента в отдельном потоке }

{ $Id: alcuFileTransfer.pas,v 1.1 2013/04/16 13:11:31 narry Exp $ }

// $Log: alcuFileTransfer.pas,v $
// Revision 1.1  2013/04/16 13:11:31  narry
// Обновление
//

interface

uses
  l3ProtoObject, dt_Types;

type
 TalcuFileTransfer = class(Tl3ProtoObject)
 protected
  procedure Execute(aUserID: TUserID; const aFromFolder, aToFolder: String);
 end;

implementation

procedure TalcuFileTransfer.Execute(aUserID: TUserID; const aFromFolder, aToFolder: String);
begin
 // TODO -cMM: TalcuFileTransfer.Execute default body inserted
end;

end.
