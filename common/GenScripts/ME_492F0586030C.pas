unit AutoreferatInterfaces;
 {* Интерфейсы для работы с новостной лентой }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\AutoreferatInterfaces.pas"
// Стереотип: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
;

type
 IdsNewsLine = interface
  {* Новостная лента }
  ['{34D4F64F-ABFB-48BE-B04F-DD609BB32DAB}']
 end;//IdsNewsLine

 IsdsAutoreferat = interface(IsdsBaseDocument)
  ['{22A93E6D-D6A0-4D95-BA27-C6A9CFBBF259}']
  function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
  property MakeNewsLineFakeDS: IdsNewsLine
   read pm_GetMakeNewsLineFakeDS;
   {* Фиктивный бизнес объект новостной ленты }
 end;//IsdsAutoreferat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
