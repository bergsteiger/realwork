unit F1LikeTextLoad_Form;

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "F1LikeTextLoad" MUID: (4C9B31190392)
// Имя типа: "TF1LikeTextLoadForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
 , vcmEntities
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
;

const
 fm_F1LikeTextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'F1LikeTextLoadForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TF1LikeTextLoadForm }

type
 TF1LikeTextLoadForm = class;

 F1LikeTextLoadFormDef = interface
  {* Идентификатор формы F1LikeTextLoad }
  ['{FAAC10AB-4EAF-4B43-B184-7BFAADA53CAD}']
 end;//F1LikeTextLoadFormDef

 TF1LikeTextLoadForm = {final} class(TPrimTextLoadForm, F1LikeTextLoadFormDef)
   Entities : TvcmEntities;
  private
   f_Text: TeeEditorExport;
   f_TextSource: TeeTextSourceExport;
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
   procedure MakeControls; override;
  public
   property Text: TeeEditorExport
    read f_Text;
   property TextSource: TeeTextSourceExport
    read f_TextSource;
 end;//TF1LikeTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , F1LikeTextLoad_ut_F1LikeTextLoad_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , F1LikeTextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_F1LikeTextLoadLocalConstants }
 str_ut_F1LikeTextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeTextLoadCaption'; rValue : 'F1LikeTextLoad');
  {* Заголовок пользовательского типа "F1LikeTextLoad" }

{$R *.DFM}

function TF1LikeTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4C9B31190392get_var*
//#UC END# *4C9B21D20187_4C9B31190392get_var*
begin
//#UC START# *4C9B21D20187_4C9B31190392get_impl*
 Result := TextSource;
//#UC END# *4C9B21D20187_4C9B31190392get_impl*
end;//TF1LikeTextLoadForm.pm_GetTextSource

function TF1LikeTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4C9B31190392get_var*
//#UC END# *4C9B21E400A4_4C9B31190392get_var*
begin
//#UC START# *4C9B21E400A4_4C9B31190392get_impl*
 Result := Text;
//#UC END# *4C9B21E400A4_4C9B31190392get_impl*
end;//TF1LikeTextLoadForm.pm_GetText

procedure TF1LikeTextLoadForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_F1LikeTextLoadName,
  str_ut_F1LikeTextLoadCaption,
  str_ut_F1LikeTextLoadCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_F1LikeTextLoadName
 f_Text := TeeEditorExport.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TeeTextSourceExport.Create(Self);
 f_TextSource.Name := 'TextSource';
end;//TF1LikeTextLoadForm.MakeControls

initialization
 str_ut_F1LikeTextLoadCaption.Init;
 {* Инициализация str_ut_F1LikeTextLoadCaption }
 fm_F1LikeTextLoadForm.SetFactory(TF1LikeTextLoadForm.Make);
 {* Регистрация фабрики формы F1LikeTextLoad }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TF1LikeTextLoadForm);
 {* Регистрация F1LikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
