unit Rubricator_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Rubricator/Rubricator_Module.pas"
// Начат: 08.09.2009 19:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Основные прецеденты::Rubricator::View::Rubricator::Rubricator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  PrimRubricator_Form,
  Rubricator_Form,
  Common_FormDefinitions_Controls,
  nscSimpleEditor
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  MainMenuUnit
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RubricatorKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TRubricatorModule = {formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class function OpenRubricator(const aNode: Il3SimpleNode;
     const aRootToKeep: INodeBase;
     const aMenuSectionItemToKeep: ISectionItem;
     aNeedsSheet: Boolean;
     const anAggregate: IvcmAggregate;
     const aContainer: IvcmContainer): IvcmEntityForm;
 end;//TRubricatorModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  Common_Rubricator_Controls,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TRubricatorModule

class function TRubricatorModule.OpenRubricator(const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem;
  aNeedsSheet: Boolean;
  const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AA691690389_4AA67768038F_var*
//#UC END# *4AA691690389_4AA67768038F_var*
var
 l_Container : IvcmEntityForm;
 l_Navigator : IvcmEntityForm;
 l_Aggregate : IvcmAggregate;
 l_Params : IvcmMakeParams;
 l_RubrExists : Boolean;
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TRubricatorModule.OpenRubricator

class procedure TRubricatorModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TefRubricator);
end;

{$IfEnd} //not Admin AND not Monitorings

end.