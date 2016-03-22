unit m3NewStorageStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3NewStorageStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3NewStorageStream
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
  l3_String,
  m3RootStreamManagerPrim,
  m3NewStorageStreamPrim
  ;

type
 Tm3NewStorageStream = class(Tm3NewStorageStreamPrim)
 public
 // public methods
   class function Make(anAccess: Tm3StoreAccess;
     aName: Tl3_String;
     aManager: Tm3RootStreamManagerPrim;
     aPosition: Int64): IStream;
 end;//Tm3NewStorageStream

implementation

uses
  SysUtils,
  m3StoreHeader
  ;

// start class Tm3NewStorageStream

class function Tm3NewStorageStream.Make(anAccess: Tm3StoreAccess;
  aName: Tl3_String;
  aManager: Tm3RootStreamManagerPrim;
  aPosition: Int64): IStream;
//#UC START# *544910F10203_54182F58013B_var*
var
 l_H : Tm3StoreHeader;
 l_S : Tm3NewStorageStream;
//#UC END# *544910F10203_54182F58013B_var*
begin
//#UC START# *544910F10203_54182F58013B_impl*
 l_H := Tm3StoreHeader.Create(anAccess,
                              aName,
                              aManager,
                              aPosition);
 try
  l_S := Create(anAccess, l_H.HeaderData);
  try
   Result := l_S;
  finally
   FreeAndNil(l_S);
  end;//try..finally
 finally
  FreeAndNil(l_H);
 end;//try..finally
//#UC END# *544910F10203_54182F58013B_impl*
end;//Tm3NewStorageStream.Make

end.