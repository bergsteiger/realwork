unit ParentAndChildPrim_Module;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentAndChildPrim_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "ParentAndChildPrim" MUID: (4F6B66260326)
// Имя типа: "TParentAndChildPrimModule"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TParentAndChildPrimModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeChild(aMainForm: TvcmMainForm;
    anOwner: TvcmEntityForm): IvcmEntityForm;
   class function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//TParentAndChildPrimModule

implementation

uses
 l3ImplUses
 , Parent_Form
 , Child_Form
 , F1Like_FormDefinitions_Controls
 //#UC START# *4F6B66260326impl_uses*
 //#UC END# *4F6B66260326impl_uses*
;

{$If NOT Defined(NoVCM)}
class function TParentAndChildPrimModule.MakeChild(aMainForm: TvcmMainForm;
 anOwner: TvcmEntityForm): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4F6B67820382_4F6B66260326_var*
//#UC END# *4F6B67820382_4F6B66260326_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F6B67820382_4F6B66260326_impl*
  Result := TChildForm.Make(vcmMakeParams(nil, aMainForm, anOwner));
//#UC END# *4F6B67820382_4F6B66260326_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TParentAndChildPrimModule.MakeChild

class function TParentAndChildPrimModule.MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4F6B678D03B8_4F6B66260326_var*
//#UC END# *4F6B678D03B8_4F6B66260326_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F6B678D03B8_4F6B66260326_impl*
  Result := TParentForm.Make(vcmMakeParams(nil, aMainForm, aMainForm));
//#UC END# *4F6B678D03B8_4F6B66260326_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TParentAndChildPrimModule.MakeParent

class procedure TParentAndChildPrimModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TParentForm);
 aList.Add(TChildForm);
end;//TParentAndChildPrimModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

end.
