unit NOT_FINISHED_evEvdReader;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdReader.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evEvdReader" MUID: (4EA536A500EB)

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
 //#UC START# *4EA536A500EBimpl_uses*
 //#UC END# *4EA536A500EBimpl_uses*
;

end.
