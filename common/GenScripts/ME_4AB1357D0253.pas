unit Attributes_Form;
 {* Информация о документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Attributes_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Attributes" MUID: (4AB1357D0253)
// Имя типа: "TAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimAttributesOptions_Form
 , Common_FormDefinitions_Controls
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAttributesForm = {final} class(TPrimAttributesOptionsForm, AttributesFormDef)
  {* Информация о документе }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TAttributesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TAttributesForm.MakeControls;
begin
 inherited;
 tvAttributes.Parent := Self;
end;//TAttributesForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 fm_AttributesForm.SetFactory(TAttributesForm.Make);
 {* Регистрация фабрики формы Attributes }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAttributesForm);
 {* Регистрация Attributes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
