unit List_Module;
 {* Работа со списком документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\List_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "List" MUID: (4A9BF42601A9)
// Имя типа: "TListModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsOpenListInfo
 , DocumentInterfaces
 , PrimPrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
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
 TListModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Работа со списком документов }
  protected
   class function TryOpenDocument(const aList: IdeList;
    const aContainer: IvcmContainer): Boolean;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   class procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере }
   class procedure OpenListWithReplace(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
 end;//TListModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , Common_FormDefinitions_Controls
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , nsListEvents
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , sdsList
 , ListInterfaces
 , DynamicDocListUnit
 , PrimListInterfaces
 , List_Form
 , ListInfo_Form
 , ListAnalizer_Form
 , fsList
 , ListAnalize_Form
 //#UC START# *4A9BF42601A9impl_uses*
 , StdRes
 //#UC END# *4A9BF42601A9impl_uses*
;

{$If NOT Defined(NoVCM)}
class function TListModule.TryOpenDocument(const aList: IdeList;
 const aContainer: IvcmContainer): Boolean;
var l_Info: TbsOpenListInfo;
var l_DocInfo: IdeDocInfo;
//#UC START# *4AA4D7EA0094_4A9BF42601A9_var*
//#UC END# *4AA4D7EA0094_4A9BF42601A9_var*
begin
//#UC START# *4AA4D7EA0094_4A9BF42601A9_impl*
 l_Info := TbsOpenListInfo.Create(aList);
 try
  case l_Info.LinkType of
   ltDocument:
   begin
    if (l_Info.Data = nil) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=296626118
    // - видимо список пустой и открывать ничего не получится
     Result := false
    else
    begin
     Result := True;
     l_DocInfo := l_Info.Data As IdeDocInfo;
     TnsOpenDocumentFromListEvent.Log(l_DocInfo);
     TdmStdRes.OpenDocument(l_DocInfo, aContainer);
     l_DocInfo := nil;
    end;//l_Info.Data = nil
   end;//ltDocument
   ltList:
    Result := False;
   else
   begin
    Assert(False);
    Result := False;
   end;//else
  end;//case l_Info.LinkType of
 finally
  FreeAndNil(l_Info);
 end;//try..finally
//#UC END# *4AA4D7EA0094_4A9BF42601A9_impl*
end;//TListModule.TryOpenDocument

class procedure TListModule.MakeListAnalizer(const aTree: Il3SimpleTree);
var
 __WasEnter : Boolean;
//#UC START# *4AA4DB140235_4A9BF42601A9_var*
//#UC END# *4AA4DB140235_4A9BF42601A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4DB140235_4A9BF42601A9_impl*
 if (aTree = nil) then
  vcmSay(str_MissingAnalisisTree, [DefDataAdapter.GetDealerInfo], mtInformation)
 else
  TListAnalizerForm.Make(aTree, vcmMakeParams(nil, DefaultContainer), vcm_ztModal);
//#UC END# *4AA4DB140235_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.MakeListAnalizer

class procedure TListModule.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере }
var l_Form: IvcmEntityForm;
var l_Cont: IvcmContainer;
var
 __WasEnter : Boolean;
//#UC START# *4AA4DB5100EF_4A9BF42601A9_var*
//#UC END# *4AA4DB5100EF_4A9BF42601A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4DB5100EF_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  case aList.List.GetContentType of
   DLC_LEGAL_DOCUMENTS:
    Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                  CheckContainer(aContainer));
   DLC_MEDICAL_DOCUMENTS:
   begin
    l_Cont := CheckContainer(aContainer);
    TdmStdRes.OpenDrugList(aList, l_Cont);
    // Синхронный просмотр открыт по умолчанию (CQ: OIT5-29213):
    // http://mdp.garant.ru/pages/viewpage.action?pageId=96484558
    if l_Cont.HasForm(fm_TextForm.rFormID,
                      vcm_ztAny,
                      True,
                      @l_Form,
                      dftDrugSynchroView) then
     l_Form.SetActiveInParent;
   end;
  end;//case aList.List.GetContentType of
//#UC END# *4AA4DB5100EF_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.OpenList

class procedure TListModule.OpenListWithReplace(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
var
 __WasEnter : Boolean;
//#UC START# *4AA4EF7803A4_4A9BF42601A9_var*
//#UC END# *4AA4EF7803A4_4A9BF42601A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4EF7803A4_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                aContainer,
                false);
//#UC END# *4AA4EF7803A4_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.OpenListWithReplace

class procedure TListModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TefList);
 aList.Add(TefListInfo);
 aList.Add(TListAnalizerForm);
 aList.Add(TListAnalizeForm);
end;//TListModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
