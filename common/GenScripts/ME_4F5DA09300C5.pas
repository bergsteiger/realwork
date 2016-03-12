unit PrimSaveLoadOptionsForBaseSearch_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadOptions_Form
;

type
 TPrimSaveLoadOptionsForBaseSearchForm = class(TPrimSaveLoadOptionsForm)
  protected
   class function IsBaseSearchLike: Boolean; override;
 end;//TPrimSaveLoadOptionsForBaseSearchForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimPrimListInterfaces
 , bsTypes
 , eeInterfaces
 , nsTypes
 , FiltersUnit
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 // ExcludeAll

const
 {* Локализуемые строки slqtBaseSearchLocalConstants }
 str_slqtBaseSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtBaseSearchCaption'; rValue : 'Базовый поиск');
  {* Заголовок пользовательского типа "Базовый поиск" }

class function TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike: Boolean;
//#UC START# *502289FB008D_4F5DA09300C5_var*
//#UC END# *502289FB008D_4F5DA09300C5_var*
begin
//#UC START# *502289FB008D_4F5DA09300C5_impl*
 Result := true;
//#UC END# *502289FB008D_4F5DA09300C5_impl*
end;//TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike

initialization
 str_slqtBaseSearchCaption.Init;
 {* Инициализация str_slqtBaseSearchCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsForBaseSearchForm);
 {* Регистрация PrimSaveLoadOptionsForBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
