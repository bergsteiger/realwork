unit TextLoad_Form;
 {* Форма для загрузки документа }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\TextLoad_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "TextLoad" MUID: (4B30C7E800EE)
// Имя типа: "TTextLoadForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , evEditor
 , evTextSource
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
 , vcmEntities
;

const
 fm_TextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'TextLoadForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TTextLoadForm }

type
 TTextLoadForm = class;

 TextLoadFormDef = interface
  {* Идентификатор формы TextLoad }
  ['{0D52D59A-6EBD-46A6-AA44-2467ABBFDC5C}']
 end;//TextLoadFormDef

 TTextLoadForm = {final} class(TPrimTextLoadForm, TextLoadFormDef)
  {* Форма для загрузки документа }
   Entities : TvcmEntities;
  private
   f_Text: TevEditor;
   f_TextSource: TevTextSource;
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
   procedure MakeControls; override;
  public
   property Text: TevEditor
    read f_Text;
   property TextSource: TevTextSource
    read f_TextSource;
 end;//TTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmStringIDExHelper
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , TextLoad_ut_TextLoad_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

function TTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4B30C7E800EEget_var*
//#UC END# *4C9B21D20187_4B30C7E800EEget_var*
begin
//#UC START# *4C9B21D20187_4B30C7E800EEget_impl*
 Result := Self.TextSource;
//#UC END# *4C9B21D20187_4B30C7E800EEget_impl*
end;//TTextLoadForm.pm_GetTextSource

function TTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4B30C7E800EEget_var*
//#UC END# *4C9B21E400A4_4B30C7E800EEget_var*
begin
//#UC START# *4C9B21E400A4_4B30C7E800EEget_impl*
 Result := Self.Text;
//#UC END# *4C9B21E400A4_4B30C7E800EEget_impl*
end;//TTextLoadForm.pm_GetText

procedure TTextLoadForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_TextLoadName,
  str_ut_TextLoadCaption,
  str_ut_TextLoadCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TextLoadName
 f_Text := TevEditor.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TevTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
end;//TTextLoadForm.MakeControls

initialization
 fm_TextLoadForm.SetFactory(TTextLoadForm.Make);
 {* Регистрация фабрики формы TextLoad }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextLoadForm);
 {* Регистрация TextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
