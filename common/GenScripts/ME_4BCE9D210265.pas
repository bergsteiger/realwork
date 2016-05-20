unit elCustomEdit_Form;
 {* Форма для тестирования TelCustomEdit }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "elCustomEdit" MUID: (4BCE9D210265)
// Имя типа: "TelCustomEditForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , vcmInterfaces
 , vcmEntities
 , elCustomEdit
;

const
 fm_elCustomEditForm: TvcmFormDescriptor = (rFormID : (rName : 'elCustomEditForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TelCustomEditForm }

type
 TelCustomEditForm = class;

 elCustomEditFormDef = interface
  {* Идентификатор формы elCustomEdit }
  ['{83F3F220-AFBC-45DC-8C59-16D7972E06BB}']
 end;//elCustomEditFormDef

 TelCustomEditForm = {final} class(TvcmEntityForm, elCustomEditFormDef)
  {* Форма для тестирования TelCustomEdit }
   Entities : TvcmEntities;
  private
   f_Edit: TelCustomEdit;
  protected
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure MakeControls; override;
  public
   property Edit: TelCustomEdit
    read f_Edit;
 end;//TelCustomEditForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , elCustomEdit_ut_elCustomEdit_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , elCustomEditKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_elCustomEditLocalConstants }
 str_ut_elCustomEditCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_elCustomEditCaption'; rValue : 'Форма для тестирования TelCustomEdit');
  {* Заголовок пользовательского типа "Форма для тестирования TelCustomEdit" }

{$R *.DFM}

procedure TelCustomEditForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4BCE9D210265_var*
//#UC END# *4A8E8F2E0195_4BCE9D210265_var*
begin
//#UC START# *4A8E8F2E0195_4BCE9D210265_impl*
 inherited;
 WindowState := wsMaximized;
 Edit.Left := 0;
 Edit.Top := 0;
//#UC END# *4A8E8F2E0195_4BCE9D210265_impl*
end;//TelCustomEditForm.InitControls

procedure TelCustomEditForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_elCustomEditName,
  str_ut_elCustomEditCaption,
  str_ut_elCustomEditCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_elCustomEditName
 f_Edit := TelCustomEdit.Create(Self);
 f_Edit.Name := 'Edit';
end;//TelCustomEditForm.MakeControls

initialization
 str_ut_elCustomEditCaption.Init;
 {* Инициализация str_ut_elCustomEditCaption }
 fm_elCustomEditForm.SetFactory(TelCustomEditForm.Make);
 {* Регистрация фабрики формы elCustomEdit }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TelCustomEditForm);
 {* Регистрация elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
