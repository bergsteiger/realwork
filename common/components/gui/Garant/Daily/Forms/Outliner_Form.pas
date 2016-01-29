unit Outliner_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/Outliner_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Outliner::OutlinerForm
//
// Форма для тестирования списка
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
  l3StringIDEx,
  vtOutlinerControl
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  OutlinerForm_ut_OutlinerForm_UserType,
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
   { OutlinerFormIDs }
  fm_OutlinerFormForm : TvcmFormDescriptor = (rFormID : (rName : 'OutlinerFormForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TOutlinerFormForm }

type
 OutlinerFormFormDef = interface(IUnknown)
  {* Идентификатор формы OutlinerForm }
   ['{0BC56D56-6AF0-47F9-9D0B-4AE7FEEE4483}']
 end;//OutlinerFormFormDef

 TOutlinerFormForm = {final form} class(TvcmEntityForm, OutlinerFormFormDef)
  {* Форма для тестирования списка }
  Entities : TvcmEntities;
 private
 // private fields
   f_TreeControl : TvtOutlinerControl;
    {* Поле для свойства TreeControl}
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 public
 // public properties
   property TreeControl: TvtOutlinerControl
     read f_TreeControl;
 end;//TOutlinerFormForm
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
  OutlinerFormKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_OutlinerFormLocalConstants }
  str_ut_OutlinerFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_OutlinerFormCaption'; rValue : 'Форма для тестирования списка');
   { Заголовок пользовательского типа "Форма для тестирования списка" }

// start class TOutlinerFormForm

procedure TOutlinerFormForm.InitControls;
//#UC START# *4A8E8F2E0195_4D4697F30281_var*
//#UC END# *4A8E8F2E0195_4D4697F30281_var*
begin
//#UC START# *4A8E8F2E0195_4D4697F30281_impl*
 inherited;
 f_TreeControl.Align := alClient;
//#UC END# *4A8E8F2E0195_4D4697F30281_impl*
end;//TOutlinerFormForm.InitControls

procedure TOutlinerFormForm.MakeControls;
begin
 inherited;
 f_TreeControl := TvtOutlinerControl.Create(Self);
 f_TreeControl.Name := 'TreeControl';
 f_TreeControl.Parent := Self;
 with AddUsertype(ut_OutlinerFormName,
  str_ut_OutlinerFormCaption,
  str_ut_OutlinerFormCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_OutlinerFormName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация OutlinerForm
 TtfwClassRef.Register(TOutlinerFormForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы OutlinerForm
 fm_OutlinerFormForm.SetFactory(TOutlinerFormForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_OutlinerFormCaption
 str_ut_OutlinerFormCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.