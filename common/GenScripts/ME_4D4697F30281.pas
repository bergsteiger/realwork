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
;

const
 fm_OutlinerFormForm: TvcmFormDescriptor = (rFormID : (rName : 'OutlinerFormForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TOutlinerFormForm }

type
 OutlinerFormFormDef = interface
  {* Идентификатор формы OutlinerForm }
  ['{0BC56D56-6AF0-47F9-9D0B-4AE7FEEE4483}']
 end;//OutlinerFormFormDef

 TOutlinerFormForm = {final} class(TvcmEntityForm, OutlinerFormFormDef)
  {* Форма для тестирования списка }
  private
   f_TreeControl: TvtOutlinerControl;
    {* Поле для свойства TreeControl }
  protected
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
  public
   property TreeControl: TvtOutlinerControl
    read f_TreeControl;
 end;//TOutlinerFormForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , OutlinerFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_OutlinerFormLocalConstants }
 str_ut_OutlinerFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_OutlinerFormCaption'; rValue : 'Форма для тестирования списка');
  {* Заголовок пользовательского типа "Форма для тестирования списка" }

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOutlinerFormForm);
 {* Регистрация OutlinerForm }
{$IfEnd} // NOT Defined(NoScripts)
 fm_OutlinerFormForm.SetFactory(TOutlinerFormForm.Make);
 {* Регистрация фабрики формы OutlinerForm }
 str_ut_OutlinerFormCaption.Init;
 {* Инициализация str_ut_OutlinerFormCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
