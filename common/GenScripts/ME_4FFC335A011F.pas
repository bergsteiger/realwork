unit vcmPrimCollectionItem;

interface

uses
 l3IntfUses
 , Classes
 , vcmInterfaces
;

 {$Define _UnknownNeedsQI}
 
 {$Define _UnknownNotNeedL3}
 
type
 TvcmPrimCollectionItem = class(TCollectionItem)
 end;//TvcmPrimCollectionItem
 
implementation

uses
 l3ImplUses
 , vcmBase
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
