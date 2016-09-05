unit NOT_FINISHED_evEvdWriter;
 {* Писатель тегов в формате evd в структурированное хранилище (IStorage). }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdWriter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evEvdWriter" MUID: (4EA52FD6034D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 //#UC START# *4EA52FD6034Dimpl_uses*
 //#UC END# *4EA52FD6034Dimpl_uses*
;

end.
