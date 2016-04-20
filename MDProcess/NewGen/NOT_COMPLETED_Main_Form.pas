unit NOT_COMPLETED_Main_Form;
 {* НЕ Роза }

// Модуль: "w:\MDProcess\NewGen\NOT_COMPLETED_Main_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "Main" MUID: (4F6AEAE5007B)
// Имя типа: "TMainForm"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , NewGenMainPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MainForm: TvcmFormDescriptor = (rFormID : (rName : 'MainForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TMainForm }

type
 TMainForm = class;

 MainFormDef = interface
  {* Идентификатор формы Main }
  ['{45D03D24-01B1-4C43-89B5-AF75285241AE}']
 end;//MainFormDef

 TMainForm = {final} class(TNewGenMainPrimForm, MainFormDef)
  {* НЕ Роза }
  protected
   procedure InitFields; override;
 end;//TMainForm
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , MainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , Main_ut_Main_UserType
;

const
 {* Локализуемые строки ut_MainLocalConstants }
 str_ut_MainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MainCaption'; rValue : 'НЕ Роза');
  {* Заголовок пользовательского типа "НЕ Роза" }

procedure TMainForm.InitFields;
//#UC START# *47A042E100E2_4F6AEAE5007B_var*
//#UC END# *47A042E100E2_4F6AEAE5007B_var*
begin
//#UC START# *47A042E100E2_4F6AEAE5007B_impl*
 inherited;
//#UC END# *47A042E100E2_4F6AEAE5007B_impl*
end;//TMainForm.InitFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainForm);
 {* Регистрация Main }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MainForm.SetFactory(TMainForm.Make);
 {* Регистрация фабрики формы Main }
 str_ut_MainCaption.Init;
 {* Инициализация str_ut_MainCaption }
{$IfEnd} // Defined(NewGen)

end.
