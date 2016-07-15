unit dsDrugDocument;
 {* Описание лекарственного препарата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsDrugDocument.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsDrugDocument" MUID: (491D89A001A9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmInterfaces
 , MedicInterfaces
 , WorkWithDocumentInterfaces
 , DocumentAndListInterfaces
 , nevTools
 , DynamicDocListUnit
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , DocumentInterfaces
 , WorkWithListInterfaces
 , nsDocumentLikeStateHolder
 , afwInterfaces
 , l3Interfaces
 , bsTypes
 , FoldersDomainInterfaces
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
 , PrimPrimListInterfaces
;

type
 _FormDataSourceType_ = IdsDrugDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsBaseDrugDocument.imp.pas}
 _dsDocumentFromList_Parent_ = _dsBaseDrugDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}
 TdsDrugDocument = {final} class(_dsDocumentFromList_, IdsDrugDocument, IucbDocumentWithContents, IucbDocumentFromList)
  {* Описание лекарственного препарата }
  private
   ucc_BaseDrugDocument: IsdsDrugDocument;
   ucc_DocumentWithContents: IucpDocumentWithContents;
  protected
   function As_IucbDocumentWithContents: IucbDocumentWithContents;
    {* Метод приведения нашего интерфейса к IucbDocumentWithContents }
   function As_IucbDocumentFromList: IucbDocumentFromList;
    {* Метод приведения нашего интерфейса к IucbDocumentFromList }
   procedure DoReturnToList(const aList: IDynList;
    const aNodeForPositioning: Il3SimpleNode); override;
    {* параметры создания списка }
   procedure OpenDrugInternationalNameSynonims;
    {* открыть список похожих по международному названию }
   function Get_DsContents: IdsBaseContents;
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure OpenContents(const aTree: IdeSimpleTree;
    anForceOpen: TnsContentsOpenMode;
    const aContainerOfDocument: InevDocumentContainer);
 end;//TdsDrugDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , deList
 , nsF1DocumentContainer
 , l3Base
 , bsUtils
 , BaseTypesUnit
 , bsConvert
 , l3Utils
 , deDocInfo
 , nsTypes
 , nsDocInfoHAFMacroReplacer
 , nsFolderFilterInfo
 , l3InterfacesMisc
 , SysUtils
 , afwFacade
 , IOUnit
 , deSearchInfo
 , DynamicTreeUnit
 , nsINodeWrap
;

type _Instance_R_ = TdsDrugDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsBaseDrugDocument.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}

function TdsDrugDocument.As_IucbDocumentWithContents: IucbDocumentWithContents;
 {* Метод приведения нашего интерфейса к IucbDocumentWithContents }
begin
 Result := Self;
end;//TdsDrugDocument.As_IucbDocumentWithContents

function TdsDrugDocument.As_IucbDocumentFromList: IucbDocumentFromList;
 {* Метод приведения нашего интерфейса к IucbDocumentFromList }
begin
 Result := Self;
end;//TdsDrugDocument.As_IucbDocumentFromList

procedure TdsDrugDocument.DoReturnToList(const aList: IDynList;
 const aNodeForPositioning: Il3SimpleNode);
 {* параметры создания списка }
//#UC START# *491465BF0275_491D89A001A9_var*
//#UC END# *491465BF0275_491D89A001A9_var*
begin
//#UC START# *491465BF0275_491D89A001A9_impl*
 TdmStdRes.OpenList(TdeList.Make(aList,
                                 True,
                                 wdOpenIfUserDefine,
                                 aNodeForPositioning), nil);
//#UC END# *491465BF0275_491D89A001A9_impl*
end;//TdsDrugDocument.DoReturnToList

procedure TdsDrugDocument.OpenDrugInternationalNameSynonims;
 {* открыть список похожих по международному названию }
//#UC START# *491D88070148_491D89A001A9_var*
//#UC END# *491D88070148_491D89A001A9_var*
begin
//#UC START# *491D88070148_491D89A001A9_impl*
 if (ucc_BaseDrugDocument <> nil) then
  ucc_BaseDrugDocument.OpenDrugInternationalNameSynonims;
//#UC END# *491D88070148_491D89A001A9_impl*
end;//TdsDrugDocument.OpenDrugInternationalNameSynonims

procedure TdsDrugDocument.OpenContents(const aTree: IdeSimpleTree;
 anForceOpen: TnsContentsOpenMode;
 const aContainerOfDocument: InevDocumentContainer);
//#UC START# *4953D3B20211_491D89A001A9_var*
//#UC END# *4953D3B20211_491D89A001A9_var*
begin
//#UC START# *4953D3B20211_491D89A001A9_impl*
 if (ucc_DocumentWithContents <> nil) then
  ucc_DocumentWithContents.OpenContents(aTree, anForceOpen, aContainerOfDocument);
//#UC END# *4953D3B20211_491D89A001A9_impl*
end;//TdsDrugDocument.OpenContents

function TdsDrugDocument.Get_DsContents: IdsBaseContents;
//#UC START# *4E7B663D00A9_491D89A001A9get_var*
//#UC END# *4E7B663D00A9_491D89A001A9get_var*
begin
//#UC START# *4E7B663D00A9_491D89A001A9get_impl*
 if (ucc_DocumentWithContents = nil) then
  Result := nil
 else
  Result := ucc_DocumentWithContents.dsContents;
//#UC END# *4E7B663D00A9_491D89A001A9get_impl*
end;//TdsDrugDocument.Get_DsContents

function TdsDrugDocument.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_491D89A001A9_var*
//#UC END# *4C6AB38800F3_491D89A001A9_var*
begin
//#UC START# *4C6AB38800F3_491D89A001A9_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D89A001A9_impl*
end;//TdsDrugDocument.MakeContainer

{$If NOT Defined(NoVCM)}
procedure TdsDrugDocument.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 Supports(aDS, IsdsDrugDocument, ucc_BaseDrugDocument);
 Supports(aDS, IucpDocumentWithContents, ucc_DocumentWithContents);
end;//TdsDrugDocument.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsDrugDocument.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 ucc_BaseDrugDocument := nil;
 ucc_DocumentWithContents := nil;
end;//TdsDrugDocument.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
