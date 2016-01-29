unit evEvdWriter;

interface

uses
 l3IntfUses
 , evdCustomNativeWriter
;

type
 TevCustomEvdStorageWriter = class(TevdCustomNativeWriter)
 end;//TevCustomEvdStorageWriter
 
 TevEvdStorageWriter = class(TevCustomEvdStorageWriter)
  {* Писатель тегов в формате evd в структурированное хранилище (IStorage). (С published свойствами) }
 end;//TevEvdStorageWriter
 
 TevPartContainer = class
 end;//TevPartContainer
 
implementation

uses
 l3ImplUses
;

end.
