unit NOT_FINISHED_k2Tags;
 {* Описание идентификаторов стандартных тегов и типов. }

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2Tags.pas"
// Стереотип: "Interfaces"
// Элемент модели: "k2Tags" MUID: (47AC75550330)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
;

const
 {* вспомогательные тэги }
 k2_tiComplexBase = High(Byte) + 1;
  {* база для указания сложной сортировки. }

type
 Tk2TagID = (
 );//Tk2TagID

 Tk2FontParam = k2_tiName .. k2_tiIndex;

implementation

uses
 l3ImplUses
;

end.
