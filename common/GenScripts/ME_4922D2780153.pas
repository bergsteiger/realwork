unit dsAttributeSelect;
 {* бизнес объект формы выбранные атрибуты дерева }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsAttributeSelect.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , SearchInterfaces
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
 _FormDataSourceType_ = IdsAttributeSelect;
 _InitDataType_ = IdeSearch;
 {$Include vcmFormDataSource.imp.pas}
 TdsAttributeSelect = class(_vcmFormDataSource_, IdsAttributeSelect)
  {* бизнес объект формы выбранные атрибуты дерева }
  protected
   function pm_GetSearch: IdeSearch;
 end;//TdsAttributeSelect
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsAttributeSelect;

{$Include vcmFormDataSource.imp.pas}

function TdsAttributeSelect.pm_GetSearch: IdeSearch;
//#UC START# *4922D0440266_4922D2780153get_var*
//#UC END# *4922D0440266_4922D2780153get_var*
begin
//#UC START# *4922D0440266_4922D2780153get_impl*
 Result := PartData;
//#UC END# *4922D0440266_4922D2780153get_impl*
end;//TdsAttributeSelect.pm_GetSearch
{$IfEnd} // NOT Defined(Admin)

end.
