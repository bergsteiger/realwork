unit PrimAdminMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimAdminMain_Form.pas"
// Стереотип: "VCMMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimMainOptions_Form
;

type
 _AdminAndMonitoringsMainForm_Parent_ = TPrimMainOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimAdminMainForm = class(_AdminAndMonitoringsMainForm_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAdminMainForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmSettings
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* Локализуемые строки utEmptyMainWindowLocalConstants }
 str_utEmptyMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : 'Главное окно');
  {* Заголовок пользовательского типа "Главное окно" }
 str_utEmptyMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
  {* Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

type _Instance_R_ = TPrimAdminMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimAdminMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AA518EB039C_var*
//#UC END# *49803F5503AA_4AA518EB039C_var*
begin
//#UC START# *49803F5503AA_4AA518EB039C_impl*
 inherited;
 TdmStdRes.OpenUserList(Self);
//#UC END# *49803F5503AA_4AA518EB039C_impl*
end;//TPrimAdminMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utEmptyMainWindowCaption.Init;
 {* Инициализация str_utEmptyMainWindowCaption }
 str_utEmptyMainWindowSettingsCaption.Init;
 {* Инициализация str_utEmptyMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminMainForm);
 {* Регистрация PrimAdminMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
