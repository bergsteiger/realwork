unit m3StorageTableOfContentsStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageTableOfContentsStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3NewStorageStream
 , ActiveX
 , m3StorageInterfaces
 , m3StoreHeader
;

type
 Tm3StorageTableOfContentsStream = class(Tm3NewStorageStream)
  public
   class function Make(anAccess: Tm3StoreAccess;
    aHeader: Tm3StoreHeader): IStream;
 end;//Tm3StorageTableOfContentsStream

implementation

uses
 l3ImplUses
 , SysUtils
;

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
