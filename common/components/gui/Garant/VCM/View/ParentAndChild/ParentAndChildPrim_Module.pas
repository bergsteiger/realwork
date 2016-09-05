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
 end;//TParentAndChildPrimModule

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , F1Like_Contracts
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 , Parent_Form
 , Child_Form
 , F1Like_FormDefinitions_Controls
 //#UC START# *4F6B66260326impl_uses*
 //#UC END# *4F6B66260326impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TvcmParentAndChildServiceImpl = {final} class(TvcmModuleContractImplementation, IvcmParentAndChildService)
  public
   function MakeChild(aMainForm: TvcmMainForm;
    anOwner: TvcmEntityForm): IvcmEntityForm;
   function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
   class function Instance: TvcmParentAndChildServiceImpl;
    {* Метод получения экземпляра синглетона TvcmParentAndChildServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmParentAndChildServiceImpl

var g_TvcmParentAndChildServiceImpl: TvcmParentAndChildServiceImpl = nil;
 {* Экземпляр синглетона TvcmParentAndChildServiceImpl }

procedure TvcmParentAndChildServiceImplFree;
 {* Метод освобождения экземпляра синглетона TvcmParentAndChildServiceImpl }
begin
 l3Free(g_TvcmParentAndChildServiceImpl);
end;//TvcmParentAndChildServiceImplFree

function TvcmParentAndChildServiceImpl.MakeChild(aMainForm: TvcmMainForm;
 anOwner: TvcmEntityForm): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *5791E0EF0247_4F6B66260326_var*
//#UC END# *5791E0EF0247_4F6B66260326_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *5791E0EF0247_4F6B66260326_impl*
  Result := TChildForm.Make(vcmMakeParams(nil, aMainForm, anOwner));
//#UC END# *5791E0EF0247_4F6B66260326_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TvcmParentAndChildServiceImpl.MakeChild

function TvcmParentAndChildServiceImpl.MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
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
end;//TvcmParentAndChildServiceImpl.MakeParent

class function TvcmParentAndChildServiceImpl.Instance: TvcmParentAndChildServiceImpl;
 {* Метод получения экземпляра синглетона TvcmParentAndChildServiceImpl }
begin
 if (g_TvcmParentAndChildServiceImpl = nil) then
 begin
  l3System.AddExitProc(TvcmParentAndChildServiceImplFree);
  g_TvcmParentAndChildServiceImpl := Create;
 end;
 Result := g_TvcmParentAndChildServiceImpl;
end;//TvcmParentAndChildServiceImpl.Instance

class function TvcmParentAndChildServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmParentAndChildServiceImpl <> nil;
end;//TvcmParentAndChildServiceImpl.Exists

class procedure TParentAndChildPrimModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TParentForm);
 aList.Add(TChildForm);
end;//TParentAndChildPrimModule.GetEntityForms

initialization
 TvcmParentAndChildService.Instance.Alien := TvcmParentAndChildServiceImpl.Instance;
 {* Регистрация TvcmParentAndChildServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

end.
