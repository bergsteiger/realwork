{$IfNDef dsDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocument.imp.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "dsDocument" MUID: (491D64430036)
// Имя типа: "_dsDocument_"

{$Define dsDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 _dsDocumentFromList_Parent_ = _dsBaseDocumentPrim_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}
 _dsBaseSearchSupportQuery_Parent_ = _dsDocumentFromList_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}
 _dsDocument_ = {abstract} class(_dsBaseSearchSupportQuery_, IdsDocument, IucbDocumentWithContents, IucbDocumentFromList, IucbBaseSearchSupportQuery)
  {* Бизнес объект формы "TextForm" }
  private
   ucc_DocumentWithContents: IucpDocumentWithContents;
  protected
   ucc_Document: IsdsDocument;
  protected
   function As_IucbDocumentWithContents: IucbDocumentWithContents;
    {* Метод приведения нашего интерфейса к IucbDocumentWithContents }
   function As_IucbDocumentFromList: IucbDocumentFromList;
    {* Метод приведения нашего интерфейса к IucbDocumentFromList }
   function As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
    {* Метод приведения нашего интерфейса к IucbBaseSearchSupportQuery }
   procedure DoReturnToList(const aList: IDynList;
    const aNodeForPositioning: Il3SimpleNode); override;
    {* параметры создания списка }
   procedure OpenSimilarDocuments;
    {* открыть список похожих документов }
   function GetSubPosition(aSubID: Integer): IevdHyperlinkInfo;
   function pm_GetHasSimilarDocuments: Boolean;
   function Get_DsContents: IdsBaseContents;
   procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
   {$If NOT Defined(NoVCM)}
   function GetIsSame(const aValue: _FormDataSourceType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetHasPrevRedaction: Boolean; override;
   function GetHasNextRedaction: Boolean; override;
   function GetCanWorkWithRedactions: Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
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
 end;//_dsDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
_dsDocumentFromList_Parent_ = _dsBaseDocumentPrim_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}
_dsBaseSearchSupportQuery_Parent_ = _dsDocumentFromList_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}
_dsDocument_ = _dsBaseSearchSupportQuery_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsDocument_imp}

{$IfNDef dsDocument_imp_impl}

{$Define dsDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}

function _dsDocument_.As_IucbDocumentWithContents: IucbDocumentWithContents;
 {* Метод приведения нашего интерфейса к IucbDocumentWithContents }
begin
 Result := Self;
end;//_dsDocument_.As_IucbDocumentWithContents

function _dsDocument_.As_IucbDocumentFromList: IucbDocumentFromList;
 {* Метод приведения нашего интерфейса к IucbDocumentFromList }
begin
 Result := Self;
end;//_dsDocument_.As_IucbDocumentFromList

function _dsDocument_.As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
 {* Метод приведения нашего интерфейса к IucbBaseSearchSupportQuery }
begin
 Result := Self;
end;//_dsDocument_.As_IucbBaseSearchSupportQuery

procedure _dsDocument_.DoReturnToList(const aList: IDynList;
 const aNodeForPositioning: Il3SimpleNode);
 {* параметры создания списка }
//#UC START# *491465BF0275_491D64430036_var*
//#UC END# *491465BF0275_491D64430036_var*
begin
//#UC START# *491465BF0275_491D64430036_impl*
 TListOpenService.Instance.OpenList(TdeListSet.Make(aList,
                                    wdOpenIfUserDefine,
                                    lofNone,
                                    True,
                                    aNodeForPositioning,
                                    CloneSearchInfo(aList)), nil);
//#UC END# *491465BF0275_491D64430036_impl*
end;//_dsDocument_.DoReturnToList

procedure _dsDocument_.OpenSimilarDocuments;
 {* открыть список похожих документов }
//#UC START# *491D664C0232_491D64430036_var*
//#UC END# *491D664C0232_491D64430036_var*
begin
//#UC START# *491D664C0232_491D64430036_impl*
 if (ucc_Document <> nil) then
  ucc_Document.OpenSimilarDocuments;
//#UC END# *491D664C0232_491D64430036_impl*
end;//_dsDocument_.OpenSimilarDocuments

function _dsDocument_.GetSubPosition(aSubID: Integer): IevdHyperlinkInfo;
//#UC START# *491D66630373_491D64430036_var*
var
 l_ID : Integer; 
//#UC END# *491D66630373_491D64430036_var*
begin
//#UC START# *491D66630373_491D64430036_impl*
 l_ID := DocInfo.Doc.GetInternalId;
 Result := TevdHyperlinkInfo.Make(l3Fmt('%d.%d',[l_ID, aSubID]),
                                  TevdAddress_E{(l_ID, aSubID)},
                                  nil);
//#UC END# *491D66630373_491D64430036_impl*
end;//_dsDocument_.GetSubPosition

function _dsDocument_.pm_GetHasSimilarDocuments: Boolean;
//#UC START# *491D66910265_491D64430036get_var*
//#UC END# *491D66910265_491D64430036get_var*
begin
//#UC START# *491D66910265_491D64430036get_impl*
 Result := (ucc_Document <> nil) AND ucc_Document.HasSimilarDocuments
//#UC END# *491D66910265_491D64430036get_impl*
end;//_dsDocument_.pm_GetHasSimilarDocuments

procedure _dsDocument_.OpenContents(const aTree: IdeSimpleTree;
 anForceOpen: TnsContentsOpenMode;
 const aContainerOfDocument: InevDocumentContainer);
//#UC START# *4953D3B20211_491D64430036_var*
//#UC END# *4953D3B20211_491D64430036_var*
begin
//#UC START# *4953D3B20211_491D64430036_impl*
 if (ucc_DocumentWithContents <> nil) then
  ucc_DocumentWithContents.OpenContents(aTree, anForceOpen, aContainerOfDocument);
//#UC END# *4953D3B20211_491D64430036_impl*
end;//_dsDocument_.OpenContents

function _dsDocument_.Get_DsContents: IdsBaseContents;
//#UC START# *4E7B663D00A9_491D64430036get_var*
//#UC END# *4E7B663D00A9_491D64430036get_var*
begin
//#UC START# *4E7B663D00A9_491D64430036get_impl*
 if (ucc_DocumentWithContents = nil) then
  Result := nil
 else
  Result := ucc_DocumentWithContents.dsContents;
//#UC END# *4E7B663D00A9_491D64430036get_impl*
end;//_dsDocument_.Get_DsContents

procedure _dsDocument_.OpenSimilarDocumentsToFragment(aBlockId: Integer);
//#UC START# *5594F4830261_491D64430036_var*
//#UC END# *5594F4830261_491D64430036_var*
begin
//#UC START# *5594F4830261_491D64430036_impl*
 if (ucc_Document <> nil) then
  ucc_Document.OpenSimilarDocumentsToFragment(aBlockId);
//#UC END# *5594F4830261_491D64430036_impl*
end;//_dsDocument_.OpenSimilarDocumentsToFragment

{$If NOT Defined(NoVCM)}
function _dsDocument_.GetIsSame(const aValue: _FormDataSourceType_): Boolean;
//#UC START# *49147FB4028C_491D64430036_var*
//#UC END# *49147FB4028C_491D64430036_var*
begin
//#UC START# *49147FB4028C_491D64430036_impl*
 Result := inherited GetIsSame(aValue);
 if not Result and Assigned(DocInfo) and (aValue <> nil) then
  Result := DocInfo.IsSame(aValue.DocInfo);
//#UC END# *49147FB4028C_491D64430036_impl*
end;//_dsDocument_.GetIsSame
{$IfEnd} // NOT Defined(NoVCM)

function _dsDocument_.GetHasPrevRedaction: Boolean;
//#UC START# *491C25280247_491D64430036_var*
//#UC END# *491C25280247_491D64430036_var*
begin
//#UC START# *491C25280247_491D64430036_impl*
 Result := (ucc_Document <> nil) and pm_GetHasDoc and DocInfo.Doc.HasPrevRedaction;
//#UC END# *491C25280247_491D64430036_impl*
end;//_dsDocument_.GetHasPrevRedaction

function _dsDocument_.GetHasNextRedaction: Boolean;
//#UC START# *491C253D0364_491D64430036_var*
//#UC END# *491C253D0364_491D64430036_var*
begin
//#UC START# *491C253D0364_491D64430036_impl*
 Result := (ucc_Document <> nil) and pm_GetHasDoc and DocInfo.Doc.HasNextRedaction;
//#UC END# *491C253D0364_491D64430036_impl*
end;//_dsDocument_.GetHasNextRedaction

function _dsDocument_.GetCanWorkWithRedactions: Boolean;
//#UC START# *491C25470309_491D64430036_var*
//#UC END# *491C25470309_491D64430036_var*
begin
//#UC START# *491C25470309_491D64430036_impl*
 Result := pm_GetHasPrevRedaction or pm_GetHasNextRedaction;
//#UC END# *491C25470309_491D64430036_impl*
end;//_dsDocument_.GetCanWorkWithRedactions

function _dsDocument_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_491D64430036_var*
//#UC END# *4A60B23E00C3_491D64430036_var*
begin
//#UC START# *4A60B23E00C3_491D64430036_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and IID.EQ(IdeDocInfo) then
  Result := Tl3HResult_C(DocInfo.QueryInterface(IID.IID, Obj));
//#UC END# *4A60B23E00C3_491D64430036_impl*
end;//_dsDocument_.COMQueryInterface

{$If NOT Defined(NoVCM)}
procedure _dsDocument_.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 Supports(aDS, IsdsDocument, ucc_Document);
 Supports(aDS, IucpDocumentWithContents, ucc_DocumentWithContents);
end;//_dsDocument_.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsDocument_.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 ucc_Document := nil;
 ucc_DocumentWithContents := nil;
end;//_dsDocument_.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf dsDocument_imp_impl}

{$EndIf dsDocument_imp}

