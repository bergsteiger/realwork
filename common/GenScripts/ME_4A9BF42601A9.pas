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
;

type
 TListModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Работа со списком документов }
  protected
   function TryOpenDocument(const aList: IdeList;
    const aContainer: IvcmContainer): Boolean;
  public
   procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере }
   procedure OpenListWithReplace(const aList: IdeList;
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
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , ListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListAnalizerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListAnalizeKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
function TListModule.TryOpenDocument(const aList: IdeList;
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

procedure TListModule.MakeListAnalizer(const aTree: Il3SimpleTree);
//#UC START# *4AA4DB140235_4A9BF42601A9_var*
//#UC END# *4AA4DB140235_4A9BF42601A9_var*
begin
//#UC START# *4AA4DB140235_4A9BF42601A9_impl*
 if (aTree = nil) then
  vcmSay(str_MissingAnalisisTree, [DefDataAdapter.GetDealerInfo], mtInformation)
 else
  TListAnalizerForm.Make(aTree, vcmMakeParams(nil, DefaultContainer), vcm_ztModal);
//#UC END# *4AA4DB140235_4A9BF42601A9_impl*
end;//TListModule.MakeListAnalizer

procedure TListModule.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере }
var l_Form: IvcmEntityForm;
var l_Cont: IvcmContainer;
//#UC START# *4AA4DB5100EF_4A9BF42601A9_var*
//#UC END# *4AA4DB5100EF_4A9BF42601A9_var*
begin
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
end;//TListModule.OpenList

procedure TListModule.OpenListWithReplace(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
//#UC START# *4AA4EF7803A4_4A9BF42601A9_var*
//#UC END# *4AA4EF7803A4_4A9BF42601A9_var*
begin
//#UC START# *4AA4EF7803A4_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                aContainer,
                false);
//#UC END# *4AA4EF7803A4_4A9BF42601A9_impl*
end;//TListModule.OpenListWithReplace
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
