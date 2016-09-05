unit evNodeDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evNodeDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevNodeDataObject" MUID: (48F4DC5A018D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evNodeStorable
 , l3TreeInterfaces
 , evPersistentDataObjectEx
 , l3Interfaces
;

type
 _StorableClass_ = TevNodeStorable;
 _DataType_ = Il3SimpleNode;
 {$Include w:\common\components\gui\Garant\Everest\evDataObjectFromStorable.imp.pas}
 TevNodeDataObject = class(_evDataObjectFromStorable_)
 end;//TevNodeDataObject

implementation

uses
 l3ImplUses
 , evFormats
 , evTypes
 , nevTools
 , l3Base
 //#UC START# *48F4DC5A018Dimpl_uses*
 //#UC END# *48F4DC5A018Dimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\evDataObjectFromStorable.imp.pas}

end.
