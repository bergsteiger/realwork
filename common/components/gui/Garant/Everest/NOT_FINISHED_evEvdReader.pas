unit NOT_FINISHED_evEvdReader;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdReader.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEvdRd
;

type
 TevCustomEvdStorageReader = class(TevCustomEvdReader)
  {* Читатель тегов в формате evd из структурированного хранилища (IStorage) }
 end;//TevCustomEvdStorageReader

 TevEvdStorageReader = class(TevCustomEvdStorageReader)
  {* Читатель тегов в формате evd (с published свойствами). }
 end;//TevEvdStorageReader

implementation

uses
 l3ImplUses
;

end.
