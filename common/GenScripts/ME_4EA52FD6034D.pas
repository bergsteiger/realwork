unit NOT_FINISHED_evEvdWriter;
 {* Писатель тегов в формате evd в структурированное хранилище (IStorage). }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEvdWriter.pas"
// Стереотип: "UtilityPack"

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
;

end.
