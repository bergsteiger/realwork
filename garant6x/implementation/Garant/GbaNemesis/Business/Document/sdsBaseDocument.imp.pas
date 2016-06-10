{$IfNDef sdsBaseDocument_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocument.imp.pas"
// ���������: "UseCaseControllerImp"
// ������� ������: "sdsBaseDocument" MUID: (47EA106D035E)
// ��� ����: "_sdsBaseDocument_"

{$Define sdsBaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 _sdsBaseDocument_ = {abstract} class(_vcmFormSetDataSource_, IsdsBaseDocument, IsdsGotoPointDataMaker, IsdsPrimDocument)
  {* ���, ������� ��� ���������� � ���������� }
  protected
   function BaseDocumentClass: IdsBaseDocument; virtual; abstract;
   function DocumentData: IdeDocInfo;
    {* ������ ��� ������������� ������ ������� ��������� }
   procedure ClearAllDS; virtual;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; virtual;
   function DoMakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo; virtual;
    {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
   function NeedMakeDocument: Boolean; virtual;
    {* ���������� - ����� �� ��������� ������� ����� ��� ��������� }
   procedure FillState; virtual;
   function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
    {* ����� ���������� ������ ���������� � IsdsGotoPointDataMaker }
   function As_IsdsPrimDocument: IsdsPrimDocument;
    {* ����� ���������� ������ ���������� � IsdsPrimDocument }
   function ChangeDocument(const aDoc: IdeDocInfo): Boolean;
    {* ��������� �������� }
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
    {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetDsDocument: IdsBaseDocument;
   function DoGet_DsDocument: IdsBaseDocument;
   function pm_GetHasDocument: Boolean;
   function pm_GetDsDocumentRef: IvcmViewAreaControllerRef;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - ���������� ����� ��������� ������ �������������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_sdsBaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
_sdsBaseDocument_ = _vcmFormSetDataSource_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsBaseDocument_imp}

{$IfNDef sdsBaseDocument_imp_impl}

{$Define sdsBaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

function _sdsBaseDocument_.DocumentData: IdeDocInfo;
 {* ������ ��� ������������� ������ ������� ��������� }
//#UC START# *4925B4AD0340_47EA106D035E_var*
//#UC END# *4925B4AD0340_47EA106D035E_var*
begin
//#UC START# *4925B4AD0340_47EA106D035E_impl*
 // ����������� ���������, ������ ��� ����� �������� � ������ ����� ��������
 // ���� � ��� �� IdeDocInfo
 if Assigned(SetData.DocInfo) then
  Result := SetData.DocInfo.Clone
 else
  Result := nil;
//#UC END# *4925B4AD0340_47EA106D035E_impl*
end;//_sdsBaseDocument_.DocumentData

procedure _sdsBaseDocument_.ClearAllDS;
//#UC START# *4925B7F00156_47EA106D035E_var*
//#UC END# *4925B7F00156_47EA106D035E_var*
begin
//#UC START# *4925B7F00156_47EA106D035E_impl*
 pm_GetdsDocumentRef.Referred := nil;
//#UC END# *4925B7F00156_47EA106D035E_impl*
end;//_sdsBaseDocument_.ClearAllDS

function _sdsBaseDocument_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_47EA106D035E_var*
//#UC END# *4925B9370022_47EA106D035E_var*
begin
//#UC START# *4925B9370022_47EA106D035E_impl*
 Result := false;
//#UC END# *4925B9370022_47EA106D035E_impl*
end;//_sdsBaseDocument_.DoChangeDocument

function _sdsBaseDocument_.DoMakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
//#UC START# *4925BE3E0260_47EA106D035E_var*
//#UC END# *4925BE3E0260_47EA106D035E_var*
begin
//#UC START# *4925BE3E0260_47EA106D035E_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aRefType, aPos));
//#UC END# *4925BE3E0260_47EA106D035E_impl*
end;//_sdsBaseDocument_.DoMakeGotoPointData

function _sdsBaseDocument_.NeedMakeDocument: Boolean;
 {* ���������� - ����� �� ��������� ������� ����� ��� ��������� }
//#UC START# *493D1BE601B1_47EA106D035E_var*
//#UC END# *493D1BE601B1_47EA106D035E_var*
begin
//#UC START# *493D1BE601B1_47EA106D035E_impl*
 Result := true;
//#UC END# *493D1BE601B1_47EA106D035E_impl*
end;//_sdsBaseDocument_.NeedMakeDocument

procedure _sdsBaseDocument_.FillState;
//#UC START# *493D51ED0329_47EA106D035E_var*
//#UC END# *493D51ED0329_47EA106D035E_var*
begin
//#UC START# *493D51ED0329_47EA106D035E_impl*
 // - ������ �� ������, �������� �� ��������
//#UC END# *493D51ED0329_47EA106D035E_impl*
end;//_sdsBaseDocument_.FillState

function _sdsBaseDocument_.As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
 {* ����� ���������� ������ ���������� � IsdsGotoPointDataMaker }
begin
 Result := Self;
end;//_sdsBaseDocument_.As_IsdsGotoPointDataMaker

function _sdsBaseDocument_.As_IsdsPrimDocument: IsdsPrimDocument;
 {* ����� ���������� ������ ���������� � IsdsPrimDocument }
begin
 Result := Self;
end;//_sdsBaseDocument_.As_IsdsPrimDocument

function _sdsBaseDocument_.ChangeDocument(const aDoc: IdeDocInfo): Boolean;
 {* ��������� �������� }
//#UC START# *4925978F00FA_47EA106D035E_var*
//#UC END# *4925978F00FA_47EA106D035E_var*
begin
//#UC START# *4925978F00FA_47EA106D035E_impl*
 Result := DoChangeDocument(aDoc);
//#UC END# *4925978F00FA_47EA106D035E_impl*
end;//_sdsBaseDocument_.ChangeDocument

function _sdsBaseDocument_.MakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* ������� ������. ���� ������ ������� ������������ ������, �� ������ ���
           ����� ������ ��������� ��� ��������� ��� ������ �������� ������ }
//#UC START# *492597A602F6_47EA106D035E_var*
//#UC END# *492597A602F6_47EA106D035E_var*
begin
//#UC START# *492597A602F6_47EA106D035E_impl*
 Result := DoMakeGotoPointData(aDocument, aRefType, aPos);
//#UC END# *492597A602F6_47EA106D035E_impl*
end;//_sdsBaseDocument_.MakeGotoPointData

function _sdsBaseDocument_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_47EA106D035Eget_var*
//#UC END# *4DF9D63B0360_47EA106D035Eget_var*
begin
//#UC START# *4DF9D63B0360_47EA106D035Eget_impl*
 Result := SetData.DocInfo;
//#UC END# *4DF9D63B0360_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetDocInfo

function _sdsBaseDocument_.pm_GetDsDocument: IdsBaseDocument;
//#UC START# *50002EC80001_47EA106D035Eget_var*
//#UC END# *50002EC80001_47EA106D035Eget_var*
begin
 with pm_GetdsDocumentRef do
 begin
  if IsEmpty
  //#UC START# *50002EC80001_47EA106D035Eget_need*
   AND NeedMakeDocument
   // - ������� �������� ViewArea
  //#UC END# *50002EC80001_47EA106D035Eget_need*
   then
    Referred := DoGet_dsDocument;
  Result := IdsBaseDocument(Referred);
 end;// with pm_GetdsDocumentRef
end;//_sdsBaseDocument_.pm_GetDsDocument

function _sdsBaseDocument_.DoGet_DsDocument: IdsBaseDocument;
//#UC START# *50002EC80001_47EA106D035Earea_var*
//#UC END# *50002EC80001_47EA106D035Earea_var*
begin
//#UC START# *50002EC80001_47EA106D035Earea_impl*
 Result := BaseDocumentClass;
//#UC END# *50002EC80001_47EA106D035Earea_impl*
end;//_sdsBaseDocument_.DoGet_DsDocument

function _sdsBaseDocument_.pm_GetHasDocument: Boolean;
//#UC START# *5111C2BAF24F_47EA106D035Eget_var*
//#UC END# *5111C2BAF24F_47EA106D035Eget_var*
begin
//#UC START# *5111C2BAF24F_47EA106D035Eget_impl*
 with SetData do
  Result := Assigned(DocInfo) and Assigned(DocInfo.Doc);
//#UC END# *5111C2BAF24F_47EA106D035Eget_impl*
end;//_sdsBaseDocument_.pm_GetHasDocument

function _sdsBaseDocument_.pm_GetDsDocumentRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsDocumentRef;
end;//_sdsBaseDocument_.pm_GetDsDocumentRef

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDocument_.DataExchange;
 {* - ���������� ����� ��������� ������ �������������. }
//#UC START# *47F37DF001FE_47EA106D035E_var*
var
 l_DocInfo: IdeDocInfo;
//#UC END# *47F37DF001FE_47EA106D035E_var*
begin
//#UC START# *47F37DF001FE_47EA106D035E_impl*
 Assert(false, '����� ������������� ������������ ����������');
 Supports(InitialUseCaseData, IdeDocInfo, l_DocInfo);
 SetData.DocInfo := l_DocInfo;
//#UC END# *47F37DF001FE_47EA106D035E_impl*
end;//_sdsBaseDocument_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

function _sdsBaseDocument_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_47EA106D035E_var*
//#UC END# *4A60B23E00C3_47EA106D035E_var*
begin
//#UC START# *4A60B23E00C3_47EA106D035E_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IDocument) and pm_GetHasDocument then
  begin
   IDocument(Obj) := pm_GetDocInfo.Doc;
   Result.SetOK;
  end;//if IID.EQ(IDocument) and pm_GetHasDocument then
//#UC END# *4A60B23E00C3_47EA106D035E_impl*
end;//_sdsBaseDocument_.COMQueryInterface

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDocument_.ClearAreas;
 {* ������� ������ �� ������� ����� }
begin
 pm_GetdsDocumentRef.Referred := nil;
 inherited;
end;//_sdsBaseDocument_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf sdsBaseDocument_imp_impl}

{$EndIf sdsBaseDocument_imp}

