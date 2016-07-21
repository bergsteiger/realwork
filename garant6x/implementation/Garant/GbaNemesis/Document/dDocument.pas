unit dDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\dDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdDocument" MUID: (493E5E7202F1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithDocumentInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypes
 , DynamicDocListUnit
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocInfoInterfaces
 , bsInterfaces
 , l3Types
 , ExternalObjectUnit
 , BaseDocumentWithAttributesInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}
 TdDocument = class(_dDocInfo_, IdDocument)
  private
   f_ContentsTree: IdeSimpleTree;
   f_ContextSearched: Boolean;
   f_IncomingLinksToPartPosList: IPositionList;
   f_CRToPartType: TlstCRType;
   f_IncomingLinksToPartList: IDynList;
   f_IncomingLinksToPartFilter: INodeBase;
   f_OutgoingLinksFromPartList: IDynList;
   f_OutgoingLinksFromPartFilter: INodeBase;
   f_OutgoingLinksFromPartPosList: IPositionList;
   f_SimilarDocumentsBlockId: Integer;
   f_dsOutgoingLinksFromPartRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ ссылок из фрагмента (респондентов)" }
   f_dsContentsRef: IvcmFormDataSourceRef;
    {* Ссылка на "Оглавление" }
   f_dsWarningRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ предупреждения" }
   f_dsIncomingLinksToPartRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ ссылок на фрагмент (корреспондентов)" }
   f_dsEditionsRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ редакции документа" }
  protected
   function pm_GetDsOutgoingLinksFromPartRef: IvcmFormDataSourceRef;
   function pm_GetIncomingLinksToPartFilter: INodeBase;
   procedure pm_SetIncomingLinksToPartFilter(const aValue: INodeBase);
   function pm_GetIncomingLinksToPartList: IDynList;
   procedure pm_SetIncomingLinksToPartList(const aValue: IDynList);
   function pm_GetIncomingLinksToPartPosList: IPositionList;
   procedure pm_SetIncomingLinksToPartPosList(const aValue: IPositionList);
   function pm_GetContentsTree: IdeSimpleTree;
   procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
   function Get_OutgoingLinksFromPartList: IDynList;
   procedure Set_OutgoingLinksFromPartList(const aValue: IDynList);
   function Get_OutgoingLinksFromPartFilter: INodeBase;
   procedure Set_OutgoingLinksFromPartFilter(const aValue: INodeBase);
   function Get_OutgoingLinksFromPartPosList: IPositionList;
   procedure Set_OutgoingLinksFromPartPosList(const aValue: IPositionList);
   function pm_GetSimilarDocumentsBlockId: Integer;
   procedure pm_SetSimilarDocumentsBlockId(aValue: Integer);
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
   function pm_GetDsWarningRef: IvcmFormDataSourceRef;
   function pm_GetDsIncomingLinksToPartRef: IvcmFormDataSourceRef;
   function pm_GetDsEditionsRef: IvcmFormDataSourceRef;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make: IdDocument; reintroduce;
 end;//TdDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUserCRListInfo
 , l3Utils
;

type _Instance_R_ = TdDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas}

class function TdDocument.Make: IdDocument;
var
 l_Inst : TdDocument;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdDocument.Make

function TdDocument.pm_GetDsOutgoingLinksFromPartRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsOutgoingLinksFromPartRef);
end;//TdDocument.pm_GetDsOutgoingLinksFromPartRef

function TdDocument.pm_GetIncomingLinksToPartFilter: INodeBase;
//#UC START# *49528B5D0055_493E5E7202F1get_var*
//#UC END# *49528B5D0055_493E5E7202F1get_var*
begin
//#UC START# *49528B5D0055_493E5E7202F1get_impl*
 Result := f_IncomingLinksToPartFilter;
//#UC END# *49528B5D0055_493E5E7202F1get_impl*
end;//TdDocument.pm_GetIncomingLinksToPartFilter

procedure TdDocument.pm_SetIncomingLinksToPartFilter(const aValue: INodeBase);
//#UC START# *49528B5D0055_493E5E7202F1set_var*
//#UC END# *49528B5D0055_493E5E7202F1set_var*
begin
//#UC START# *49528B5D0055_493E5E7202F1set_impl*
 f_IncomingLinksToPartFilter := aValue;
//#UC END# *49528B5D0055_493E5E7202F1set_impl*
end;//TdDocument.pm_SetIncomingLinksToPartFilter

function TdDocument.pm_GetIncomingLinksToPartList: IDynList;
//#UC START# *49528B68021D_493E5E7202F1get_var*
//#UC END# *49528B68021D_493E5E7202F1get_var*
begin
//#UC START# *49528B68021D_493E5E7202F1get_impl*
 Result := f_IncomingLinksToPartList;
//#UC END# *49528B68021D_493E5E7202F1get_impl*
end;//TdDocument.pm_GetIncomingLinksToPartList

procedure TdDocument.pm_SetIncomingLinksToPartList(const aValue: IDynList);
//#UC START# *49528B68021D_493E5E7202F1set_var*
//#UC END# *49528B68021D_493E5E7202F1set_var*
begin
//#UC START# *49528B68021D_493E5E7202F1set_impl*
 f_IncomingLinksToPartList := aValue;
//#UC END# *49528B68021D_493E5E7202F1set_impl*
end;//TdDocument.pm_SetIncomingLinksToPartList

function TdDocument.pm_GetIncomingLinksToPartPosList: IPositionList;
//#UC START# *49528B830160_493E5E7202F1get_var*
//#UC END# *49528B830160_493E5E7202F1get_var*
begin
//#UC START# *49528B830160_493E5E7202F1get_impl*
 Result := f_IncomingLinksToPartPosList;
//#UC END# *49528B830160_493E5E7202F1get_impl*
end;//TdDocument.pm_GetIncomingLinksToPartPosList

procedure TdDocument.pm_SetIncomingLinksToPartPosList(const aValue: IPositionList);
//#UC START# *49528B830160_493E5E7202F1set_var*
//#UC END# *49528B830160_493E5E7202F1set_var*
begin
//#UC START# *49528B830160_493E5E7202F1set_impl*
 f_IncomingLinksToPartPosList := aValue;
//#UC END# *49528B830160_493E5E7202F1set_impl*
end;//TdDocument.pm_SetIncomingLinksToPartPosList

function TdDocument.pm_GetContentsTree: IdeSimpleTree;
//#UC START# *4B1D2DBF0367_493E5E7202F1get_var*
//#UC END# *4B1D2DBF0367_493E5E7202F1get_var*
begin
//#UC START# *4B1D2DBF0367_493E5E7202F1get_impl*
 Result := f_ContentsTree;
//#UC END# *4B1D2DBF0367_493E5E7202F1get_impl*
end;//TdDocument.pm_GetContentsTree

procedure TdDocument.pm_SetContentsTree(const aValue: IdeSimpleTree);
//#UC START# *4B1D2DBF0367_493E5E7202F1set_var*
//#UC END# *4B1D2DBF0367_493E5E7202F1set_var*
begin
//#UC START# *4B1D2DBF0367_493E5E7202F1set_impl*
 f_ContentsTree := aValue;
//#UC END# *4B1D2DBF0367_493E5E7202F1set_impl*
end;//TdDocument.pm_SetContentsTree

function TdDocument.Get_OutgoingLinksFromPartList: IDynList;
//#UC START# *523945FF0106_493E5E7202F1get_var*
//#UC END# *523945FF0106_493E5E7202F1get_var*
begin
//#UC START# *523945FF0106_493E5E7202F1get_impl*
 Result := f_OutgoingLinksFromPartList;
//#UC END# *523945FF0106_493E5E7202F1get_impl*
end;//TdDocument.Get_OutgoingLinksFromPartList

procedure TdDocument.Set_OutgoingLinksFromPartList(const aValue: IDynList);
//#UC START# *523945FF0106_493E5E7202F1set_var*
//#UC END# *523945FF0106_493E5E7202F1set_var*
begin
//#UC START# *523945FF0106_493E5E7202F1set_impl*
 f_OutgoingLinksFromPartList := aValue;
//#UC END# *523945FF0106_493E5E7202F1set_impl*
end;//TdDocument.Set_OutgoingLinksFromPartList

function TdDocument.Get_OutgoingLinksFromPartFilter: INodeBase;
//#UC START# *523946870255_493E5E7202F1get_var*
//#UC END# *523946870255_493E5E7202F1get_var*
begin
//#UC START# *523946870255_493E5E7202F1get_impl*
 Result := f_OutgoingLinksFromPartFilter;
//#UC END# *523946870255_493E5E7202F1get_impl*
end;//TdDocument.Get_OutgoingLinksFromPartFilter

procedure TdDocument.Set_OutgoingLinksFromPartFilter(const aValue: INodeBase);
//#UC START# *523946870255_493E5E7202F1set_var*
//#UC END# *523946870255_493E5E7202F1set_var*
begin
//#UC START# *523946870255_493E5E7202F1set_impl*
 f_OutgoingLinksFromPartFilter := aValue;
//#UC END# *523946870255_493E5E7202F1set_impl*
end;//TdDocument.Set_OutgoingLinksFromPartFilter

function TdDocument.Get_OutgoingLinksFromPartPosList: IPositionList;
//#UC START# *523946AA032A_493E5E7202F1get_var*
//#UC END# *523946AA032A_493E5E7202F1get_var*
begin
//#UC START# *523946AA032A_493E5E7202F1get_impl*
 Result := f_OutgoingLinksFromPartPosList;
//#UC END# *523946AA032A_493E5E7202F1get_impl*
end;//TdDocument.Get_OutgoingLinksFromPartPosList

procedure TdDocument.Set_OutgoingLinksFromPartPosList(const aValue: IPositionList);
//#UC START# *523946AA032A_493E5E7202F1set_var*
//#UC END# *523946AA032A_493E5E7202F1set_var*
begin
//#UC START# *523946AA032A_493E5E7202F1set_impl*
 f_OutgoingLinksFromPartPosList := aValue;
//#UC END# *523946AA032A_493E5E7202F1set_impl*
end;//TdDocument.Set_OutgoingLinksFromPartPosList

function TdDocument.pm_GetSimilarDocumentsBlockId: Integer;
//#UC START# *558C0B2401CD_493E5E7202F1get_var*
//#UC END# *558C0B2401CD_493E5E7202F1get_var*
begin
//#UC START# *558C0B2401CD_493E5E7202F1get_impl*
 Result := f_SimilarDocumentsBlockId;
//#UC END# *558C0B2401CD_493E5E7202F1get_impl*
end;//TdDocument.pm_GetSimilarDocumentsBlockId

procedure TdDocument.pm_SetSimilarDocumentsBlockId(aValue: Integer);
//#UC START# *558C0B2401CD_493E5E7202F1set_var*
//#UC END# *558C0B2401CD_493E5E7202F1set_var*
begin
//#UC START# *558C0B2401CD_493E5E7202F1set_impl*
 f_SimilarDocumentsBlockId := aValue;
//#UC END# *558C0B2401CD_493E5E7202F1set_impl*
end;//TdDocument.pm_SetSimilarDocumentsBlockId

function TdDocument.pm_GetDsContentsRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsContentsRef);
end;//TdDocument.pm_GetDsContentsRef

function TdDocument.pm_GetDsWarningRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsWarningRef);
end;//TdDocument.pm_GetDsWarningRef

function TdDocument.pm_GetDsIncomingLinksToPartRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsIncomingLinksToPartRef);
end;//TdDocument.pm_GetDsIncomingLinksToPartRef

function TdDocument.pm_GetDsEditionsRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsEditionsRef);
end;//TdDocument.pm_GetDsEditionsRef

procedure TdDocument.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_493E5E7202F1_var*
//#UC END# *479731C50290_493E5E7202F1_var*
begin
//#UC START# *479731C50290_493E5E7202F1_impl*
(* f_CRToPartType := crtNone;*)
 inherited;
//#UC END# *479731C50290_493E5E7202F1_impl*
end;//TdDocument.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdDocument.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_493E5E7202F1_var*
//#UC END# *4B16B8CF0307_493E5E7202F1_var*
begin
//#UC START# *4B16B8CF0307_493E5E7202F1_impl*
 f_IncomingLinksToPartFilter := aData.IncomingLinksToPartFilter;
 f_IncomingLinksToPartList := aData.IncomingLinksToPartList;
(* f_IncomingLinksToPartType := aData.CRToPartType;*)
 f_IncomingLinksToPartPosList := aData.IncomingLinksToPartPosList;
 f_SimilarDocumentsBlockId := aData.SimilarDocumentsBlockId;
 f_ContentsTree := aData.ContentsTree;
 f_OutgoingLinksFromPartFilter := aData.OutgoingLinksFromPartFilter;
 f_OutgoingLinksFromPartList := aData.OutgoingLinksFromPartList;
 f_OutgoingLinksFromPartPosList := aData.OutgoingLinksFromPartPosList;
 pm_GetdsUserCR1Ref.Assign(aData.dsUserCR1Ref);
 pm_GetdsUserCR2Ref.Assign(aData.dsUserCR2Ref);
 pm_GetdsEditionsRef.Assign(aData.dsEditionsRef);
 pm_GetdsContentsRef.Assign(aData.dsContentsRef);
 pm_GetDsIncomingLinksToPartRef.Assign(aData.dsIncomingLinksToPartRef);
 pm_GetDsOutgoingLinksFromPartRef.Assign(aData.dsOutgoingLinksFromPartRef);
 pm_GetdsWarningRef.Assign(aData.dsWarningRef);
 inherited;
//#UC END# *4B16B8CF0307_493E5E7202F1_impl*
end;//TdDocument.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure TdDocument.ClearFields;
begin
 f_ContentsTree := nil;
 Finalize(f_IncomingLinksToPartPosList);
 f_IncomingLinksToPartList := nil;
 f_IncomingLinksToPartFilter := nil;
 f_OutgoingLinksFromPartList := nil;
 f_OutgoingLinksFromPartFilter := nil;
 Finalize(f_OutgoingLinksFromPartPosList);
 f_dsOutgoingLinksFromPartRef := nil;
 f_dsContentsRef := nil;
 f_dsWarningRef := nil;
 f_dsIncomingLinksToPartRef := nil;
 f_dsEditionsRef := nil;
 inherited;
end;//TdDocument.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
