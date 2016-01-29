unit m3StorageTableOfContentsStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageTableOfContentsStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3StorageTableOfContentsStream
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
  m3StoreHeader,
  m3NewStorageStream
  ;

type
 Tm3StorageTableOfContentsStream = class(Tm3NewStorageStream)
 public
 // public methods
   class function Make(anAccess: Tm3StoreAccess;
     aHeader: Tm3StoreHeader): IStream;
 end;//Tm3StorageTableOfContentsStream

implementation

uses
  SysUtils
  ;

// start class Tm3StorageTableOfContentsStream

class function Tm3StorageTableOfContentsStream.Make(anAccess: Tm3StoreAccess;
  aHeader: Tm3StoreHeader): IStream;
//#UC START# *544924E100B6_544924BF0331_var*
var
 l_S : Tm3StorageTableOfContentsStream;
//#UC END# *544924E100B6_544924BF0331_var*
begin
//#UC START# *544924E100B6_544924BF0331_impl*
 l_S := Create(anAccess, aHeader.HeaderData);
 try
  Result := l_S;
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *544924E100B6_544924BF0331_impl*
end;//Tm3StorageTableOfContentsStream.Make

end.