unit vcmBase;

interface

uses
 l3IntfUses
 , vcmStringIDExHelper
 , l3ProtoObject
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
;

type
 TvcmBase = class(Tl3ProtoObject)
  {* Базовый класс библиотеки. }
 end;//TvcmBase
 
 TvcmObjectList = class
 end;//TvcmObjectList
 
 TvcmCacheableBase = class(Tl3ProtoObjectWithCOMQI)
 end;//TvcmCacheableBase
 
 TvcmExecuteEvent = procedure(const aParams: IvcmExecuteParams) of object;
 
 TvcmLongintList = class
 end;//TvcmLongintList
 
implementation

uses
 l3ImplUses
 , vcmMakeParams
;

end.
