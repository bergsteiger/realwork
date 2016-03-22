unit NOT_FINISHED_ddProgressObj;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddProgressObj.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddProgressObj" MUID: (53A2EF8B0204)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
;

type
 TddProgressObject = class
 end;//TddProgressObject

 TddProgressEvent = procedure(Sender: TObject;
  aTotalPercent: Integer) of object;

implementation

uses
 l3ImplUses
;

end.
