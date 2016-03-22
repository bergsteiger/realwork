unit m3StorageIndexStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageIndexStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3StorageIndexStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  m3StorageInterfaces,
  m3NewStorageStream,
  m3NewStoragePrim
  ;

type
 Tm3StorageIndexStream = class(Tm3NewStorageStream)
 protected
 // protected methods
   class function NeedBuffering: Boolean; virtual;
 public
 // public methods
   class function Make(anAccess: Tm3StoreAccess;
     aStep: Integer;
     aParentStorage: Tm3NewStoragePrim;
     aPosition: Int64): IStream;
 end;//Tm3StorageIndexStream

implementation

uses
  SysUtils,
  m3BuffStream,
  l3_String,
  l3String
  ;

// start class Tm3StorageIndexStream

class function Tm3StorageIndexStream.Make(anAccess: Tm3StoreAccess;
  aStep: Integer;
  aParentStorage: Tm3NewStoragePrim;
  aPosition: Int64): IStream;
//#UC START# *5449197F0081_54182F8A0069_var*
var
 l_Name : Tl3_String;
//#UC END# *5449197F0081_54182F8A0069_var*
begin
//#UC START# *5449197F0081_54182F8A0069_impl*
 Assert(aParentStorage <> nil);
 Assert(aParentStorage.Header <> nil);
 Assert(aParentStorage.Header.RootStreamManager <> nil);
 l_Name := aParentStorage.Header.Name.Clone;
 try
  l_Name.Append(l3PCharLen('.Index'));
  if (aStep > 0) then
   l_Name.Append(l3PCharLen(IntToStr(aStep)));
  Result := inherited Make(anAccess, l_Name, aParentStorage.Header.RootStreamManager, aPosition);
 finally
  FreeAndNil(l_Name);
 end;//try..finally

 if NeedBuffering then
  if (anAccess AND (STGM_WRITE OR STGM_READWRITE) = 0) then
   Result := Tm3BuffStream.Make(Result);
//#UC END# *5449197F0081_54182F8A0069_impl*
end;//Tm3StorageIndexStream.Make

class function Tm3StorageIndexStream.NeedBuffering: Boolean;
//#UC START# *544A2D9F0368_54182F8A0069_var*
//#UC END# *544A2D9F0368_54182F8A0069_var*
begin
//#UC START# *544A2D9F0368_54182F8A0069_impl*
 Result := false;
//#UC END# *544A2D9F0368_54182F8A0069_impl*
end;//Tm3StorageIndexStream.NeedBuffering

end.