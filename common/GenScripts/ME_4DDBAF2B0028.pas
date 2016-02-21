unit ChangesBetweenEditions_Module;
 {* Просмотр только измененных фрагментов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
;

type
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
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , sdsChangesBetweenEditions
 , nsChangesBetweenEditionsInfo
 , fsViewChangedFragments
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Локализуемые строки Local }
 str_CannotShowChanges: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'CannotShowChanges'; rValue : 'Изменения не могут быть отображены в сводном обзоре');
  {* 'Изменения не могут быть отображены в сводном обзоре' }

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
 str_CannotShowChanges.Init;
!!! Lost Message ini !!!
 {* Инициализация str_CannotShowChanges }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
