unit ddObjProxyStream;

interface

uses
 Classes,

 l3Types,
 l3Base,
 l3Memory,

 k2Interfaces,

 dt_Types,
 dt_Const
 ;

type
 TddObjProxyStream = class(Tl3SizedMemoryPool, Ik2RawData)
 private
  f_DocFamily: TFamilyID;
  f_DocID    : TDocID;
  f_ObjID    : Longint;
  f_IsActual : Boolean;
  f_IsModified: Boolean;
  procedure Actualize;
  function pm_GetIsModified: Boolean;
  procedure pm_SetIsModified(const Value: Boolean);
 protected
  function pm_GetSize: Long; override;
 public
  constructor Create(const aFamily: TFamilyID; aDocID: TDocID; const aObjID: Longint); reintroduce;
  procedure ActualizeFrom(const aStream: IStream);
  function Read(Ofs: Long; Buf: PAnsiChar; BufSize: Long): Long;
  property DocFamily: TFamilyID read f_DocFamily;
  property IsModified: Boolean read pm_GetIsModified write pm_SetIsModified;
 end;//TddObjProxyStream

implementation

uses
 l3Stream,

 m3StorageInterfaces,
 
 DT_Serv
 ;

constructor TddObjProxyStream.Create(const aFamily: TFamilyID; aDocID: TDocID; const aObjID: Longint);
begin
 inherited Create{(nil)};
 f_DocFamily := aFamily;
 f_DocID := aDocID;
 f_ObjID := aObjID;
 f_IsActual := False;
 f_IsModified := False;
end;

procedure TddObjProxyStream.Actualize;
var
 l_IStr  : IStream;
begin
 if not f_IsActual then
 begin
  f_IsActual := True;
  try
   l_IStr := dtGetObjectStream(f_DocFamily, f_DocID, f_ObjID, m3_saRead);
   try
    ActualizeFrom(l_IStr);
   finally
    l_IStr := nil;
   end;//try..finally
  except
   f_IsActual := False;
   raise;
  end;//try..except
 end;//not f_IsActual
end;

procedure TddObjProxyStream.ActualizeFrom(const aStream: IStream);
var
 l_Read      : Large;
 l_Written   : Large;
 l_Position  : Large;
begin
 f_IsActual := True;
 try
  Size := 0; // очищаем нафик
  if (aStream = nil) then
   f_IsActual := False
  else
  begin
   aStream.Seek(0, STREAM_SEEK_SET, l_Position);
   aStream.CopyTo(Self As IStream, High(Large), l_Read, l_Written);
  end;//aStream <> nil
 except
  f_IsActual := False;
  raise;
 end;//try..except
end;

function TddObjProxyStream.pm_GetIsModified: Boolean;
begin
 Result := f_IsModified;
end;

function TddObjProxyStream.pm_GetSize: Long;
begin
 Actualize;
 Result := inherited pm_GetSize;
end;

procedure TddObjProxyStream.pm_SetIsModified(const Value: Boolean);
begin
 f_IsModified := Value;
end;

function TddObjProxyStream.Read(Ofs: Long; Buf: PAnsiChar; BufSize: Long): Long;
begin
 Actualize;
 Result := inherited Read(Ofs, Buf, BufSize);
end;

end.
