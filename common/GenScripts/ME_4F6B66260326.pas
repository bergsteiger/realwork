unit ParentAndChildPrim_Module;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentAndChildPrim_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimParent_Form
 , F1Like_FormDefinitions_Controls
 , PrimChild_Form
;

type
 TParentForm = {final} class(TPrimParentForm, ParentFormDef)
 end;//TParentForm

 TChildForm = {final} class(TPrimChildForm, ChildFormDef)
 end;//TChildForm

 TParentAndChildPrimModule = {abstract} class
  public
   procedure MakeChild(aMainForm: TvcmMainForm;
    anOwner: TvcmEntityForm);
   procedure MakeParent(aMainForm: TvcmMainForm);
 end;//TParentAndChildPrimModule

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ParentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChildKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TParentAndChildPrimModule.MakeChild(aMainForm: TvcmMainForm;
 anOwner: TvcmEntityForm);
//#UC START# *4F6B67820382_4F6B66260326_var*
//#UC END# *4F6B67820382_4F6B66260326_var*
begin
//#UC START# *4F6B67820382_4F6B66260326_impl*
  Result := TChildForm.Make(vcmMakeParams(nil, aMainForm, anOwner));
//#UC END# *4F6B67820382_4F6B66260326_impl*
end;//TParentAndChildPrimModule.MakeChild

procedure TParentAndChildPrimModule.MakeParent(aMainForm: TvcmMainForm);
//#UC START# *4F6B678D03B8_4F6B66260326_var*
//#UC END# *4F6B678D03B8_4F6B66260326_var*
begin
//#UC START# *4F6B678D03B8_4F6B66260326_impl*
  Result := TParentForm.Make(vcmMakeParams(nil, aMainForm, aMainForm));
//#UC END# *4F6B678D03B8_4F6B66260326_impl*
end;//TParentAndChildPrimModule.MakeParent

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TParentForm);
 {* Регистрация Parent }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ParentForm.SetFactory(TParentForm.Make);
 {* Регистрация фабрики формы Parent }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChildForm);
 {* Регистрация Child }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChildForm.SetFactory(TChildForm.Make);
 {* Регистрация фабрики формы Child }

end.
