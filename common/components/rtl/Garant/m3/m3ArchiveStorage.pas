unit m3ArchiveStorage;
{* ��������� � �������� ������. }

{ ���������� "M3"                       }
{ �����: ����� �.�. �                   }
{ ������: m3ArchiveStorage -            }
{ �����: 28.11.2001 16:21               }
{ $Id: m3ArchiveStorage.pas,v 1.16 2015/05/13 10:59:48 lulin Exp $ }

// $Log: m3ArchiveStorage.pas,v $
// Revision 1.16  2015/05/13 10:59:48  lulin
// - ������ ���.
//
// Revision 1.15  2014/10/31 17:42:58  lulin
// - ������������� ���.
//
// Revision 1.14  2014/10/31 14:14:30  lulin
// - ������������� ���.
//
// Revision 1.13  2014/10/30 13:43:54  lulin
// - ������������� ���.
//
// Revision 1.12  2014/10/30 07:49:12  lulin
// - ������������� ���.
//
// Revision 1.11  2014/10/29 17:32:19  lulin
// - ������������� ���.
//
// Revision 1.10  2014/10/23 16:33:05  lulin
// - ��������� �� ������.
//
// Revision 1.9  2014/10/16 09:02:51  lulin
// - ��������� ��� ������� "������ ������ ���������".
//
// Revision 1.8  2014/10/13 10:28:52  lulin
// - ��������� "������ ������ ���������".
//
// Revision 1.7  2014/10/03 09:44:33  lulin
// - ��������� � ����������� ��������, � ������ - ���������� ������ � ��������� � ���� �������.
//
// Revision 1.6  2014/09/24 10:32:52  lulin
// - ��� ����� ��������� ��������.
//
// Revision 1.5  2014/09/16 16:30:27  lulin
// - ����� �������� ������ � ����� �������.
//
// Revision 1.4  2014/09/16 10:43:22  lulin
// - ���������� ������ ���������� ���������.
//
// Revision 1.3  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.2  2005/01/31 10:28:46  lulin
// - bug fix: ��� ������� ������ � �������� ������������ ����� - ������������ - ������� ���������� - �������� print preview.
//
// Revision 1.1  2004/09/02 08:09:47  law
// - cleanup.
//
// Revision 1.8  2004/08/31 15:42:07  law
// - bug fix: � PlugIn'� ��� Far'� �� ���������������� ����������������� �����.
//
// Revision 1.7  2002/10/16 14:13:36  narry
// - change: ��������� ����������� ��������/�������� ������ ��� ������.
//
// Revision 1.6  2002/06/17 14:24:15  law
// - new method: _OpenStore.
//
// Revision 1.5  2002/02/22 10:30:53  law
// - optimization: ���������� ��������� Im3IndexedStorage.
//
// Revision 1.4  2002/01/18 14:54:16  law
// - change: ��������� *Storage � *Stream ���������� � *Store.
//
// Revision 1.3  2002/01/10 13:18:26  law
// - change data struct: PWideChar -> Tl3PCharLen.
//
// Revision 1.2  2001/11/28 15:10:02  law
// - bug fix: ��������� PlugIn ��� Far'� - �� ����� �������������� ���������.
//
// Revision 1.1  2001/11/28 14:19:31  law
// - new behavior: ������� �������� �������� � �������������� ��������.
//

{$I m3Define.inc}

interface

uses
  Windows,
  
  l3Types,
  l3Base,

  m3StorageInterfaces
  ;

type
  Tm3ArchiveStorage = class
   {* ��������� � �������� ������. }
    public
      class function Make(anAccess      : Tm3StoreAccess;
                          const aStream : IStream;
                          aStorageType  : Tm3StorageType): Im3StorageHolder;
  end;//Tm3ArchiveStorage

implementation

uses
  SysUtils,
  ActiveX,
  ComObj,

  l3Interfaces,

  m2AddDbg,
  m2COMLib,
  
  m3ArcMgr,
  m3NewStorage,
  m3RootStream,
  m3RootStreamNew,
  m3StorageHolder,
  m3StoreHeaderDataNew
  ;

type
  Tm3NewArchiveStorage = class(Tm3NewStorage)
   {* ��������� � �������� ������. }
    protected
    // internal methods
      function IsValidOpenMode(aStatStgMode: Integer): Boolean;
        override;
        {-}
      class function IsPacked: Boolean;
        override;
        {-}
      function CreateOpenStoreByName(const aStoreInfo  : Tm3StoreInfo;
                               anAccess   : Tm3StoreAccess;
                               aName      : Tl3String;
                               aMode      : Tm3StoreMode;
                               aUseCompression : Boolean): Tm3Store;
        override;
        {-}
      procedure DoCreateStore(const AName   : Tl3WString;
                            anAccess      : Tm3StoreAccess;
                            aStoreType    : Tm3StoreType;
                            out   AStream : Tm3Store;
                            out   AReturn : HRESULT;
                            aUseCompression : Boolean);
        override;
        {-}
  end;//Tm3NewArchiveStorage

  Tm3NewPluginArchiveStorage = class(Tm3NewArchiveStorage)
    protected
    // internal methods
      class function ForPlugin: Boolean;
        override;
        {-}
  end;//Tm3NewPluginArchiveStorage

// start class Tm3ArchiveStorage

class function Tm3ArchiveStorage.Make(anAccess      : Tm3StoreAccess;
                                      const aStream : IStream;
                                      aStorageType  : Tm3StorageType): Im3StorageHolder;
var                                      
 l_GUID : AnsiString;
begin
 Assert((anAccess = STGM_READ) OR (anAccess = STGM_READWRITE));
 l_GUID := m2COMCLSIDFromStream(m2COMSetPosition(0, aStream));
 if (l_GUID = GUIDToString(GUID_NULL)) then
 begin
  if (anAccess = STGM_READWRITE) then
   if (m2COMGetSize(aStream) = 0) then
    l_GUID := GUIDToString(Tm3RootStreamNew.HeaderID);
 end;//l_GUID = GUIDToString(GUID_NULL)

 if (l_GUID = GUIDToString(Tm3RootStream.HeaderID)) OR
    (l_GUID = GUIDToString(Tm3RootStreamNew.HeaderID)) then
 begin
  Case aStorageType of
   m3_stArchive:
    Result := Tm3StorageHolder.Make(Tm3NewArchiveStorage, anAccess, aStream);
   m3_stPlugin:
    Result := Tm3StorageHolder.Make(Tm3NewPluginArchiveStorage, anAccess, aStream);
   else
    Result := Tm3StorageHolder.Make(Tm3NewStorage, anAccess, aStream);
  end;//Case UseCompression
 end//l_GUID = GUIDToString(Tm3RootStream.HeaderID)..
 else
  OleError(STG_E_INVALIDHEADER);
end;

// start class Tm3NewArchiveStorage

class function Tm3NewArchiveStorage.IsPacked: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

function Tm3NewArchiveStorage.CreateOpenStoreByName(const aStoreInfo  : Tm3StoreInfo;
                                           anAccess   : Tm3StoreAccess;
                                           aName      : Tl3String;
                                           aMode      : Tm3StoreMode;
                                           aUseCompression : Boolean): Tm3Store;
  //override;
  {-}
var
 l_StatStgMode : LongInt;
begin
 Case aMode of
  m3_smOpen :
  begin
   if (aStoreInfo.rStoreType = m3_stStream) then
   begin
    l_StatStgMode := anAccess;
    if ForPlugin then
     l_StatStgMode := l_StatStgMode AND not (STGM_WRITE OR STGM_READWRITE);
    Result := inherited CreateOpenStoreByName(aStoreInfo, l_StatStgMode, aName, aMode, aUseCompression);
    if (Result.rStream <> nil) then
    begin
     if (l_StatStgMode AND (STGM_WRITE OR STGM_READWRITE) = 0) then
      Result.rStream := Tm3InflateStreamManager.MakeInterface(Result.rStream)
     else
     if aUseCompression then
     begin
      try
       Result.rStream := Tm3DeflateStreamManager.MakeInterface(Self.Header.RootStreamManager.StoreHeaderDataClass.InheritsFrom(Tm3StoreHeaderDataNew), Result.rStream);
      except
       on Em2InvalidValue do
       begin
        // - ��������� ������ �������������� ����� �������� ������� ������� ����
        //   ��� ����� ��� ��� ��� �������������� - ��� ����������� �� ���
        m2COMSetSize(0, Result.rStream);
        // - �������� ������ �����, �.�. � �������������� ����� ��� ����� ������
        //   ������������ ������ � ������
        Result.rStream := Tm3DeflateStreamManager.MakeInterface(Self.Header.RootStreamManager.StoreHeaderDataClass.InheritsFrom(Tm3StoreHeaderDataNew), Result.rStream);
        // - ��������� �������������� ����� ������ �������    
       end;//on EInvalidValue
      end;//try..except
     end;//aUseCompression
    end;//Result <> nil
   end else
    Result := inherited CreateOpenStoreByName(aStoreInfo, anAccess, aName, aMode, aUseCompression);
  end;//m3_smOpen
  m3_smCreate :
  begin
   Result := inherited CreateOpenStoreByName(aStoreInfo, anAccess, aName, aMode, aUseCompression);
   if (Result.rStream <> nil) AND (aStoreInfo.rStoreType = m3_stStream) then
   begin
    if (anAccess AND (STGM_WRITE OR STGM_READWRITE) <> 0) then
     if aUseCompression then
      Result.rStream := Tm3DeflateStreamManager.MakeInterface(Self.Header.RootStreamManager.StoreHeaderDataClass.InheritsFrom(Tm3StoreHeaderDataNew), Result.rStream);
   end;//Result <> nil..
  end;//m3_smCreate
 end;//Case aMode
end;
  
procedure Tm3NewArchiveStorage.DoCreateStore(const AName   : Tl3WString;
                                        anAccess      : Tm3StoreAccess;
                                        aStoreType    : Tm3StoreType;
                                        out   AStream : Tm3Store;
                                        out   AReturn : HRESULT;
                                        aUseCompression : Boolean);
  {-}
begin
 inherited;
 if ForPlugin then
  if (aReturn = STG_E_FILEALREADYEXISTS) then
  begin
   aReturn := S_Ok;
   DoOpenStore(aName, m3_saCreate, aStoreType, aStream, aReturn, aUseCompression);
  end;//aReturn = STG_E_FILEALREADYEXISTS
end;
  
function Tm3NewArchiveStorage.IsValidOpenMode(AStatStgMode: Integer): Boolean;
  //override;
  {-}
begin
 Result := inherited IsValidOpenMode(aStatStgMode);
 if not Result then
  Result := (aStatStgMode = m3_saCreate);
end;

// start class Tm3NewPluginArchiveStorage

class function Tm3NewPluginArchiveStorage.ForPlugin: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

end.

