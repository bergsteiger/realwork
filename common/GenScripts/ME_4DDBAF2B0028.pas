unit ChangesBetweenEditions_Module;
 {* Просмотр только измененных фрагментов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , l3MessageID
 , PrimChangesBetweenEditons_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimChangesBetweenEditons_DocumentChanges_UserType
 , ChangesBetweenEditionsInterfaces
 , nevTools
 , DocumentInterfaces
;

const
 fm_ChangesBetweenEditonsForm: TvcmFormDescriptor = (rFormID : (rName : 'ChangesBetweenEditonsForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TChangesBetweenEditonsForm }

type
 ChangesBetweenEditonsFormDef = interface
  {* Идентификатор формы ChangesBetweenEditons }
  ['{E8402096-B641-4FAE-B341-69369D1BB399}']
 end;//ChangesBetweenEditonsFormDef

 TChangesBetweenEditonsForm = {final} class(TPrimChangesBetweenEditonsForm, ChangesBetweenEditonsFormDef)
  {* Изменения в документе }
 end;//TChangesBetweenEditonsForm

 // Parent

 Tfs_ViewChangedFragments = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Parent_Parent_DocumentChanges_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Parent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_ViewChangedFragments;
    {* Метод получения экземпляра синглетона Tfs_ViewChangedFragments }
 end;//Tfs_ViewChangedFragments

 TChangesBetweenEditionsModule = class
  {* Просмотр только измененных фрагментов }
  public
   procedure ViewChangedFragments(const aLeft: IDocument;
    const aRight: IDocument);
   procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
    {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
 end;//TChangesBetweenEditionsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChangesBetweenEditonsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , DataAdapter
 , sdsChangesBetweenEditions
 , nsChangesBetweenEditionsInfo
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_Tfs_ViewChangedFragments: Tfs_ViewChangedFragments = nil;
 {* Экземпляр синглетона Tfs_ViewChangedFragments }

const
 {* Локализуемые строки Local }
 str_CannotShowChanges: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'CannotShowChanges'; rValue : 'Изменения не могут быть отображены в сводном обзоре');
  {* 'Изменения не могут быть отображены в сводном обзоре' }

procedure Tfs_ViewChangedFragmentsFree;
 {* Метод освобождения экземпляра синглетона Tfs_ViewChangedFragments }
begin
 l3Free(g_Tfs_ViewChangedFragments);
end;//Tfs_ViewChangedFragmentsFree

function Tfs_ViewChangedFragments.Parent_Parent_DocumentChanges_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Parent }
//#UC START# *9C7EE9D70E75_4DDCBC5C0211_var*
//#UC END# *9C7EE9D70E75_4DDCBC5C0211_var*
begin
//#UC START# *9C7EE9D70E75_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C7EE9D70E75_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.Parent_Parent_DocumentChanges_NeedMakeForm

class function Tfs_ViewChangedFragments.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_ViewChangedFragments <> nil;
end;//Tfs_ViewChangedFragments.Exists

class function Tfs_ViewChangedFragments.Instance: Tfs_ViewChangedFragments;
 {* Метод получения экземпляра синглетона Tfs_ViewChangedFragments }
begin
 if (g_Tfs_ViewChangedFragments = nil) then
 begin
  l3System.AddExitProc(Tfs_ViewChangedFragmentsFree);
  g_Tfs_ViewChangedFragments := Create;
 end;
 Result := g_Tfs_ViewChangedFragments;
end;//Tfs_ViewChangedFragments.Instance

procedure Tfs_ViewChangedFragments.InitFields;
//#UC START# *47A042E100E2_4DDCBC5C0211_var*
//#UC END# *47A042E100E2_4DDCBC5C0211_var*
begin
//#UC START# *47A042E100E2_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_ViewChangedFragments.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4DDCBC5C0211_var*
//#UC END# *4FFE854A009B_4DDCBC5C0211_var*
begin
//#UC START# *4FFE854A009B_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

procedure TChangesBetweenEditionsModule.ViewChangedFragments(const aLeft: IDocument;
 const aRight: IDocument);
//#UC START# *4DDCBB5D0298_4DDBAF2B0028_var*
var
 l_P : IDiffDocDataProvider;
//#UC END# *4DDCBB5D0298_4DDBAF2B0028_var*
begin
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
end;//TChangesBetweenEditionsModule.ViewChangedFragments

procedure TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
 {* Просмотр изменёных фрагментов в сравнении с предыдущей редакцией }
//#UC START# *4DE513C202B3_4DDBAF2B0028_var*
var
 l_PrevState : IDocumentState;
 l_State : IDocumentState;
 l_Prev  : IDocument;
//#UC END# *4DE513C202B3_4DDBAF2B0028_var*
begin
//#UC START# *4DE513C202B3_4DDBAF2B0028_impl*
  aDocument.GetCurrentState(l_PrevState);
  l_PrevState.Clone(l_State);
  l_State.SetPrevRedaction;
  aDocument.CreateView(l_State, l_Prev);
  Assert(l_Prev <> nil);
  ViewChangedFragments(l_Prev, aDocument);
//#UC END# *4DE513C202B3_4DDBAF2B0028_impl*
end;//TChangesBetweenEditionsModule.ViewChangedFragmentsForPrevEdition

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
 {* Регистрация ChangesBetweenEditons }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChangesBetweenEditonsForm.SetFactory(TChangesBetweenEditonsForm.Make);
 {* Регистрация фабрики формы ChangesBetweenEditons }
 str_CannotShowChanges.Init;
!!! Lost Message ini !!!
 {* Инициализация str_CannotShowChanges }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
