unit Outliner_Form;
 {* Форма для тестирования списка }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\Outliner_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "OutlinerForm" MUID: (4D4697F30281)
// Имя типа: "TOutlinerFormForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , vtOutlinerControl
 , vcmInterfaces
 , vcmEntities
;

const
 fm_OutlinerFormForm: TvcmFormDescriptor = (rFormID : (rName : 'OutlinerFormForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TOutlinerFormForm }

type
 TOutlinerFormForm = class;

 OutlinerFormFormDef = interface
  {* Идентификатор формы OutlinerForm }
  ['{0BC56D56-6AF0-47F9-9D0B-4AE7FEEE4483}']
 end;//OutlinerFormFormDef

 TOutlinerFormForm = {final} class(TvcmEntityForm, OutlinerFormFormDef)
  {* Форма для тестирования списка }
   Entities : TvcmEntities;
  private
   f_TreeControl: TvtOutlinerControl;
  protected
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure MakeControls; override;
  public
   property TreeControl: TvtOutlinerControl
    read f_TreeControl;
 end;//TOutlinerFormForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , OutlinerForm_ut_OutlinerForm_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , OutlinerFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

procedure TOutlinerFormForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
 with AddUsertype(ut_OutlinerFormName,
  str_ut_OutlinerFormCaption,
  str_ut_OutlinerFormCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_OutlinerFormName
 f_TreeControl := TvtOutlinerControl.Create(Self);
 f_TreeControl.Name := 'TreeControl';
 f_TreeControl.Parent := Self;
end;//TOutlinerFormForm.MakeControls

initialization
 fm_OutlinerFormForm.SetFactory(TOutlinerFormForm.Make);
 {* Регистрация фабрики формы OutlinerForm }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOutlinerFormForm);
 {* Регистрация OutlinerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
