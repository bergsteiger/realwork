unit m3NewStorageStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3NewStorageStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3NewStorageStreamPrim
 , ActiveX
 , m3StorageInterfaces
 , l3_String
 , m3RootStreamManagerPrim
;

type
 Tm3NewStorageStream = class(Tm3NewStorageStreamPrim)
  public
   class function Make(anAccess: Tm3StoreAccess;
    aName: Tl3_String;
    aManager: Tm3RootStreamManagerPrim;
    aPosition: Int64): IStream;
 end;//Tm3NewStorageStream

implementation

uses
 l3ImplUses
 , m3StoreHeader
 , SysUtils
;

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
