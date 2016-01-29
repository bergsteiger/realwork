unit ParentAndChildPrim_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/ParentAndChildPrim_Module.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::ParentAndChildPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainForm
  {$IfEnd} //not NoVCM
  ,
  ElPgCtl,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscFormsPageControl
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  PrimChild_Form,
  PrimParent_Form,
  Parent_Form,
  Child_Form,
  F1Like_FormDefinitions_Controls
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ParentKeywordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ChildKeywordsPack
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;

type
 TParentAndChildPrimModule = {abstract formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class function MakeChild(aMainForm: TvcmMainForm;
     anOwner: TvcmEntityForm): IvcmEntityForm;
   class function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//TParentAndChildPrimModule

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;

// start class TParentAndChildPrimModule

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

class procedure TParentAndChildPrimModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TParentForm);
 aList.Add(TChildForm);
end;

end.