unit Rubricator_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Rubricator_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Rubricator" MUID: (4AA67768038F)
// Имя типа: "TRubricatorModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 TRubricatorModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TRubricatorModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , DynamicTreeUnit
 , MainMenuUnit
 , Common_Rubricator_Controls
 , Base_Operations_Strange_Controls
 , SysUtils
 , l3Base
 , Rubricator_Form
 , Common_FormDefinitions_Controls
 //#UC START# *4AA67768038Fimpl_uses*
 , StdRes
 , Common_F1CommonServices_Contracts
 //#UC END# *4AA67768038Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TRubricatorServiceImpl = {final} class(TvcmModuleContractImplementation, IRubricatorService)
  public
   function OpenRubricator(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem;
    aNeedsSheet: Boolean;
    const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer): IvcmEntityForm;
   class function Instance: TRubricatorServiceImpl;
    {* Метод получения экземпляра синглетона TRubricatorServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TRubricatorServiceImpl

var g_TRubricatorServiceImpl: TRubricatorServiceImpl = nil;
 {* Экземпляр синглетона TRubricatorServiceImpl }

procedure TRubricatorServiceImplFree;
 {* Метод освобождения экземпляра синглетона TRubricatorServiceImpl }
begin
 l3Free(g_TRubricatorServiceImpl);
end;//TRubricatorServiceImplFree

function TRubricatorServiceImpl.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer): IvcmEntityForm;
var l_Container: IvcmEntityForm;
var l_Navigator: IvcmEntityForm;
var l_Aggregate: IvcmAggregate;
var l_Params: IvcmMakeParams;
var l_RubrExists: Boolean;
var
 __WasEnter : Boolean;
//#UC START# *4AA691690389_4AA67768038F_var*
//#UC END# *4AA691690389_4AA67768038F_var*
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
   TCommonService.Instance.GetNavigator(l_Params.Aggregate, l_Params.Container);

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
end;//TRubricatorServiceImpl.OpenRubricator

class function TRubricatorServiceImpl.Instance: TRubricatorServiceImpl;
 {* Метод получения экземпляра синглетона TRubricatorServiceImpl }
begin
 if (g_TRubricatorServiceImpl = nil) then
 begin
  l3System.AddExitProc(TRubricatorServiceImplFree);
  g_TRubricatorServiceImpl := Create;
 end;
 Result := g_TRubricatorServiceImpl;
end;//TRubricatorServiceImpl.Instance

class function TRubricatorServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TRubricatorServiceImpl <> nil;
end;//TRubricatorServiceImpl.Exists

class procedure TRubricatorModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TefRubricator);
end;//TRubricatorModule.GetEntityForms

initialization
 TRubricatorService.Instance.Alien := TRubricatorServiceImpl.Instance;
 {* Регистрация TRubricatorServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
