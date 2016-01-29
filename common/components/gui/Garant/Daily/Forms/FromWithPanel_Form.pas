unit FromWithPanel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/FromWithPanel_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::FormWithPanel::FromWithPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmEntityForm,
  vcmUserControls,
  vtPanel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  FromWithPanel_ut_FromWithPanel_UserType,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a}
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
const
   { FromWithPanelIDs }
  fm_FromWithPanelForm : TvcmFormDescriptor = (rFormID : (rName : 'FromWithPanelForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TFromWithPanelForm }

type
 FromWithPanelFormDef = interface(IUnknown)
  {* Идентификатор формы FromWithPanel }
   ['{52A98A72-5DD1-4BDA-8FD3-152438D1B28D}']
 end;//FromWithPanelFormDef

 TFromWithPanelForm = {final form} class(TvcmEntityForm, FromWithPanelFormDef)
  Entities : TvcmEntities;
 private
 // private fields
   f_WorkSpace : TvtPanel;
    {* Поле для свойства WorkSpace}
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 public
 // public properties
   property WorkSpace: TvtPanel
     read f_WorkSpace;
 end;//TFromWithPanelForm
{$IfEnd} //nsTest AND not NoVCM

implementation

{$R *.DFM}

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  FromWithPanelKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_FromWithPanelLocalConstants }
  str_ut_FromWithPanelCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_FromWithPanelCaption'; rValue : 'FromWithPanel');
   { Заголовок пользовательского типа "FromWithPanel" }

// start class TFromWithPanelForm

procedure TFromWithPanelForm.InitControls;
//#UC START# *4A8E8F2E0195_51D534260378_var*
//#UC END# *4A8E8F2E0195_51D534260378_var*
begin
//#UC START# *4A8E8F2E0195_51D534260378_impl*
 inherited;
 f_WorkSpace.Align := alClient;
//#UC END# *4A8E8F2E0195_51D534260378_impl*
end;//TFromWithPanelForm.InitControls

procedure TFromWithPanelForm.MakeControls;
begin
 inherited;
 f_WorkSpace := TvtPanel.Create(Self);
 f_WorkSpace.Name := 'WorkSpace';
 f_WorkSpace.Parent := Self;
 with AddUsertype(ut_FromWithPanelName,
  str_ut_FromWithPanelCaption,
  str_ut_FromWithPanelCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_FromWithPanelName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация FromWithPanel
 TtfwClassRef.Register(TFromWithPanelForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы FromWithPanel
 fm_FromWithPanelForm.SetFactory(TFromWithPanelForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_FromWithPanelCaption
 str_ut_FromWithPanelCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.