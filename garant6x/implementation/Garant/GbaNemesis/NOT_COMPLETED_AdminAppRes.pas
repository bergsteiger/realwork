unit NOT_COMPLETED_AdminAppRes;
 {* Оболочка Admin }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_AdminAppRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "AdminApp" MUID: (4AA517B5037A)
// Имя типа: "TAdminAppRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
 , l3StringIDEx
;

const
 {* Локализуемые строки AdminTitle }
 str_AdminTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AdminTitle'; rValue : 'ГАРАНТ аэро');
  {* 'ГАРАНТ аэро' }

type
 TAdminAppRes = {final} class(TPrimF1Res)
  {* Оболочка Admin }
  protected
   class procedure DoRun(var theSplash: IUnknown); override;
 end;//TAdminAppRes

 TvcmApplicationRef = TAdminAppRes;
  {* Ссылка на приложение для DesignTime редакторов }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , moAdmin
 , nsStartupSupport
 , l3MessageID
 , PrimAdminMain_Form
 , AdminMain_Form
 {$If NOT Defined(NoScripts)}
 , AdminMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , evExtFormat
 , StdRes
;

class procedure TAdminAppRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA517B5037A_var*
var
 l_Main : TAdminMainForm;
//#UC END# *4AA7E4DC0047_4AA517B5037A_var*
begin
//#UC START# *4AA7E4DC0047_4AA517B5037A_impl*
 inherited;
 Application.CreateForm(TAdminMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA517B5037A_impl*
end;//TAdminAppRes.DoRun

initialization
 str_AdminTitle.Init;
 {* Инициализация str_AdminTitle }
{$IfEnd} // Defined(Admin)

end.
