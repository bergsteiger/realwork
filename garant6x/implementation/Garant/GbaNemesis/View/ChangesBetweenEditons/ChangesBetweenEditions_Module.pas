unit ChangesBetweenEditions_Module;
 {* Просмотр только измененных фрагментов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "ChangesBetweenEditions" MUID: (4DDBAF2B0028)
// Имя типа: "TChangesBetweenEditionsModule"

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
 TChangesBetweenEditionsModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Просмотр только измененных фрагментов }
  protected
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TChangesBetweenEditionsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , DocumentUnit
 , l3MessageID
 , DataAdapter
 , nsChangesBetweenEditionsInfo
 , sdsChangesBetweenEditions
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , fsViewChangedFragments
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 , ChangesBetweenEditons_Form
 //#UC START# *4DDBAF2B0028impl_uses*
 //#UC END# *4DDBAF2B0028impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TChangesBetweenEditionsServiceImpl = {final} class(TvcmModuleContractImplementation, IChangesBetweenEditionsService)
  public
   procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
    {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
   procedure ViewChangedFragments(const aLeft: IDocument;
    const aRight: IDocument);
   class function Instance: TChangesBetweenEditionsServiceImpl;
    {* Метод получения экземпляра синглетона TChangesBetweenEditionsServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TChangesBetweenEditionsServiceImpl

var g_TChangesBetweenEditionsServiceImpl: TChangesBetweenEditionsServiceImpl = nil;
 {* Экземпляр синглетона TChangesBetweenEditionsServiceImpl }

const
 {* Локализуемые строки Local }
 str_CannotShowChanges: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'CannotShowChanges'; rValue : 'Изменения не могут быть отображены в сводном обзоре');
  {* 'Изменения не могут быть отображены в сводном обзоре' }

procedure TChangesBetweenEditionsServiceImplFree;
 {* Метод освобождения экземпляра синглетона TChangesBetweenEditionsServiceImpl }
begin
 l3Free(g_TChangesBetweenEditionsServiceImpl);
end;//TChangesBetweenEditionsServiceImplFree

procedure TChangesBetweenEditionsServiceImpl.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
 {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
var
 __WasEnter : Boolean;
//#UC START# *4DE513C202B3_4DDBAF2B0028_var*
var
 l_PrevState : IDocumentState;
 l_State : IDocumentState;
 l_Prev  : IDocument;
//#UC END# *4DE513C202B3_4DDBAF2B0028_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4DE513C202B3_4DDBAF2B0028_impl*
  aDocument.GetCurrentState(l_PrevState);
  l_PrevState.Clone(l_State);
  l_State.SetPrevRedaction;
  aDocument.CreateView(l_State, l_Prev);
  Assert(l_Prev <> nil);
  ViewChangedFragments(l_Prev, aDocument);
//#UC END# *4DE513C202B3_4DDBAF2B0028_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChangesBetweenEditionsServiceImpl.ViewChangedFragmentsForPrevEdition

procedure TChangesBetweenEditionsServiceImpl.ViewChangedFragments(const aLeft: IDocument;
 const aRight: IDocument);
var
 __WasEnter : Boolean;
//#UC START# *4DDCBB5D0298_4DDBAF2B0028_var*
var
 l_P : IDiffDocDataProvider;
//#UC END# *4DDCBB5D0298_4DDBAF2B0028_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4DDCBB5D0298_4DDBAF2B0028_impl*
  try
   l_P := DefDataAdapter.NativeAdapter.MakeDiffDocDataProvider(aLeft, aRight);
  except
   on EAllChangesInTables do // http://mdp.garant.ru/pages/viewpage.action?pageId=309592530
   begin
    vcmSay(str_CannotShowChanges);
    Exit;
   end;//on EAllChangesInTables
  end;//try..except
  Tfs_ViewChangedFragments.Make(
   TsdsChangesBetweenEditions.Make(
    TnsChangesBetweenEditionsInfo.Make(aLeft, aRight, l_P)),
   DefaultContainer);
//#UC END# *4DDCBB5D0298_4DDBAF2B0028_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TChangesBetweenEditionsServiceImpl.ViewChangedFragments

class function TChangesBetweenEditionsServiceImpl.Instance: TChangesBetweenEditionsServiceImpl;
 {* Метод получения экземпляра синглетона TChangesBetweenEditionsServiceImpl }
begin
 if (g_TChangesBetweenEditionsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TChangesBetweenEditionsServiceImplFree);
  g_TChangesBetweenEditionsServiceImpl := Create;
 end;
 Result := g_TChangesBetweenEditionsServiceImpl;
end;//TChangesBetweenEditionsServiceImpl.Instance

class function TChangesBetweenEditionsServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TChangesBetweenEditionsServiceImpl <> nil;
end;//TChangesBetweenEditionsServiceImpl.Exists

class procedure TChangesBetweenEditionsModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TChangesBetweenEditonsForm);
end;//TChangesBetweenEditionsModule.GetEntityForms

initialization
 str_CannotShowChanges.Init;
 str_CannotShowChanges.SetDlgType(mtWarning);
 {* Инициализация str_CannotShowChanges }
 TChangesBetweenEditionsService.Instance.Alien := TChangesBetweenEditionsServiceImpl.Instance;
 {* Регистрация TChangesBetweenEditionsServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
