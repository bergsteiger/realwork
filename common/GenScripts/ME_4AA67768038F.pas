unit Rubricator_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Rubricator_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , DynamicTreeUnit
 , MainMenuUnit
 , PrimRubricator_Form
 , Common_FormDefinitions_Controls
;

type
 TefRubricator = {final} class(TPrimRubricatorForm, RubricatorFormDef)
  {* Правовой навигатор }
 end;//TefRubricator

 TRubricatorModule = class
  public
   procedure OpenRubricator(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem;
    aNeedsSheet: Boolean;
    const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
 end;//TRubricatorModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Common_Rubricator_Controls
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RubricatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TRubricatorModule.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
var l_Container: IvcmEntityForm;
var l_Navigator: IvcmEntityForm;
var l_Aggregate: IvcmAggregate;
var l_Params: IvcmMakeParams;
var l_RubrExists: Boolean;
//#UC START# *4AA691690389_4AA67768038F_var*
//#UC END# *4AA691690389_4AA67768038F_var*
begin
//#UC START# *4AA691690389_4AA67768038F_impl*
 l_Params := vcmMakeParams(anAggregate, aContainer);

 l_Container := CheckContainer(aContainer).AsForm;
 try
  if l_Container.NativeMainForm.HasForm(fm_efRubricator.rFormID, vcm_ztParent, True, @Result) then
   l_Aggregate := Result.Aggregate
  else
  if l_Container.NativeMainForm.HasForm(fm_en_Navigator.rFormID, vcm_ztNavigator, False, @l_Navigator) then
   l_Aggregate := l_Navigator.Aggregate
  else
   l_Aggregate := anAggregate;

  l_RubrExists := (Result <> nil);
  if (l_Aggregate = nil) then
  begin
   if l_RubrExists then
   begin
    Result.MakeAggregate;
    l_Aggregate := Result.Aggregate;
   end//l_RubrExists
   else
   if (l_Navigator <> nil) then
   begin
    l_Navigator.MakeAggregate;
    l_Aggregate := l_Navigator.Aggregate;
   end//l_Navigator <> nil
   else
    l_Aggregate := vcmCheckAggregate(vcmMakeParams).Aggregate;
  end;//l_Aggregate = nil

  if (l_Aggregate <> nil) then
   l_Params := vcmSetAggregate(l_Aggregate, l_Params);

  if not op_Switcher_BecomeActive.Call(l_Aggregate) and aNeedsSheet then
   TdmStdRes.GetNavigator(l_Params.Aggregate, l_Params.Container);

  if not l_RubrExists then
   Result := TefRubricator.MakeSingleChild(l_Container.NativeMainForm,
                                             l_Params,
                                             vcm_ztParent);

  if l_RubrExists then
   Op_Rubricator_SetListRoot.Call(Result, aNode, aRootToKeep, aMenuSectionItemToKeep)
  else
  begin
   Op_Rubricator_InitListRoot.Call(Result, aNode, aRootToKeep, aMenuSectionItemToKeep);
   Op_Rubricator_Synchronize.Call(Result);
  end;//l_RubrExists..

 finally
  l_Container := nil;
 end;//try..finally
//#UC END# *4AA691690389_4AA67768038F_impl*
end;//TRubricatorModule.OpenRubricator

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefRubricator);
 {* Регистрация Rubricator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efRubricator.SetFactory(TefRubricator.Make);
 {* Регистрация фабрики формы Rubricator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
