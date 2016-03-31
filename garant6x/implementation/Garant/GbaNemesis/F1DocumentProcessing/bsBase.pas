unit bsBase;
 {* Базовый класс бизнес слоя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\bsBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TbsBase" MUID: (4B17D7FA023F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3IID
 , l3Interfaces
;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 TbsBase = class(_l3COMQueryInterface_)
  {* Базовый класс бизнес слоя }
 end;//TbsBase
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
;

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
