unit TurnOnTimeMachine_Form;
 {* Включить Машину времени }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "TurnOnTimeMachine" MUID: (4AB135BD01C2)
// Имя типа: "Ten_TurnOnTimeMachine"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOnTimeMachineOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_en_TurnOnTimeMachine: TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOnTimeMachine'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_TurnOnTimeMachine }

type
 Ten_TurnOnTimeMachine = class;

 TurnOnTimeMachineFormDef = interface
  {* Идентификатор формы TurnOnTimeMachine }
  ['{A410D5AE-D083-4A07-A820-B7E6DCB07A55}']
 end;//TurnOnTimeMachineFormDef

 Ten_TurnOnTimeMachine = {final} class(TPrimTurnOnTimeMachineOptionsForm, TurnOnTimeMachineFormDef)
  {* Включить Машину времени }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_TurnOnTimeMachine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TurnOnTimeMachineKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_TurnOnTimeMachineLocalConstants }
 str_ut_TurnOnTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOnTimeMachineCaption'; rValue : 'Включить Машину времени');
  {* Заголовок пользовательского типа "Включить Машину времени" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure Ten_TurnOnTimeMachine.MakeControls;
begin
 inherited;
 with AddUsertype(ut_TurnOnTimeMachineName,
  str_ut_TurnOnTimeMachineCaption,
  str_ut_TurnOnTimeMachineCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TurnOnTimeMachineName
end;//Ten_TurnOnTimeMachine.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TurnOnTimeMachine);
 {* Регистрация TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_TurnOnTimeMachineCaption.Init;
 {* Инициализация str_ut_TurnOnTimeMachineCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
