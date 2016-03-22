unit dsFilters;
 {* БОФ формы фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\dsFilters.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsFilters" MUID: (47F5BC100329)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SimpleListInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsFilters = {final} class(_vcmFormDataSourcePrim_, IdsFilters)
  {* БОФ формы фильтры }
  protected
   function OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
    {* возвращает данные необходимые редактироания фильтра }
 end;//TdsFilters

implementation

uses
 l3ImplUses
 , deFilter
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TdsFilters;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

function TdsFilters.OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
 {* возвращает данные необходимые редактироания фильтра }
//#UC START# *4922D96003C8_47F5BC100329_var*
//#UC END# *4922D96003C8_47F5BC100329_var*
begin
//#UC START# *4922D96003C8_47F5BC100329_impl*
 Result := TdeFilter.Make(aNode);
//#UC END# *4922D96003C8_47F5BC100329_impl*
end;//TdsFilters.OpenFilter
{$IfEnd} // NOT Defined(NoVCM)

end.
