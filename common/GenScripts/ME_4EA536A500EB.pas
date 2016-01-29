unit evEvdReader;

interface

uses
 l3IntfUses
 , evEvdRd
;

type
 TevCustomEvdStorageReader = class(TevCustomEvdReader)
  {* „итатель тегов в формате evd из структурированного хранилища (IStorage) }
 end;//TevCustomEvdStorageReader
 
 TevEvdStorageReader = class(TevCustomEvdStorageReader)
  {* „итатель тегов в формате evd (с published свойствами). }
 end;//TevEvdStorageReader
 
implementation

uses
 l3ImplUses
;

end.
