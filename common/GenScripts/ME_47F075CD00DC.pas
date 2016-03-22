{$IfNDef sdsBaseDrugDocument_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsBaseDrugDocument.imp.pas"
// ���������: "UseCaseControllerImp"
// ������� ������: "sdsBaseDrugDocument" MUID: (47F075CD00DC)
// ��� ����: "_sdsBaseDrugDocument_"

{$Define sdsBaseDrugDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsBaseDrugDocument_ = {abstract} class(_sdsBaseDocumentWithAttributes_, IsdsBaseDrugDocument)
  {* ��� �������� ���������. }
  protected
   procedure DoOpenDrugInternationalNameSynonims; virtual;
    {* - ������� �������� �� �������������� ��������. }
   function NeedMakeDsDrugInternationalNameSynonims: Boolean; virtual;
    {* - ����� �� ��������� ��� ��������� �� �������������� ��������. }
   function pm_GetHasDrugInternationalNameSynonims: Boolean;
   function pm_GetdsDrugInternationalNameSynonims: IdsDrugList;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - ���������� ����� ��������� ������ �������������. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function GetHasAttributes: Boolean; override;
    {* ���������� HasAttributes }
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_sdsBaseDrugDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
_sdsBaseDrugDocument_ = _sdsBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsBaseDrugDocument_imp}

{$IfNDef sdsBaseDrugDocument_imp_impl}

{$Define sdsBaseDrugDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}

procedure _sdsBaseDrugDocument_.DoOpenDrugInternationalNameSynonims;
 {* - ������� �������� �� �������������� ��������. }
//#UC START# *47FDDD500143_47F075CD00DC_var*
//#UC END# *47FDDD500143_47F075CD00DC_var*
begin
//#UC START# *47FDDD500143_47F075CD00DC_impl*
 with SetData.dsDrugInternationalNameSynonimsRef do
  if IsEmpty then
  begin
   SetIfNeedMakeNo(vcm_nmForce);
   Refresh;
  end;//if IsEmpty then
//#UC END# *47FDDD500143_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.DoOpenDrugInternationalNameSynonims

function _sdsBaseDrugDocument_.NeedMakeDsDrugInternationalNameSynonims: Boolean;
 {* - ����� �� ��������� ��� ��������� �� �������������� ��������. }
//#UC START# *47FE048E0224_47F075CD00DC_var*
//#UC END# *47FE048E0224_47F075CD00DC_var*
begin
//#UC START# *47FE048E0224_47F075CD00DC_impl*
 Result := pm_GetHasDrugInternationalNameSynonims;
//#UC END# *47FE048E0224_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.NeedMakeDsDrugInternationalNameSynonims

function _sdsBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims: Boolean;
//#UC START# *0D45C46989F3_47F075CD00DCget_var*
var
 l_HasList: Tl3Bool;
//#UC END# *0D45C46989F3_47F075CD00DCget_var*
begin
//#UC START# *0D45C46989F3_47F075CD00DCget_impl*
 Result := False;
 if pm_GetHasDocument and
  not l3BoolCheck(SetData.HasDrugInternationalNameSynonims, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasSameDocuments, l_HasList);
  SetData.HasDrugInternationalNameSynonims := l_HasList;
 end;
//#UC END# *0D45C46989F3_47F075CD00DCget_impl*
end;//_sdsBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims

function _sdsBaseDrugDocument_.pm_GetdsDrugInternationalNameSynonims: IdsDrugList;
//#UC START# *500D3CBB01DF_47F075CD00DCget_var*
//#UC END# *500D3CBB01DF_47F075CD00DCget_var*
begin
//#UC START# *500D3CBB01DF_47F075CD00DCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3CBB01DF_47F075CD00DCget_impl*
end;//_sdsBaseDrugDocument_.pm_GetdsDrugInternationalNameSynonims

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDrugDocument_.DataExchange;
 {* - ���������� ����� ��������� ������ �������������. }
//#UC START# *47F37DF001FE_47F075CD00DC_var*
var
 l_DocInfo: IdeDocInfo;
//#UC END# *47F37DF001FE_47F075CD00DC_var*
begin
//#UC START# *47F37DF001FE_47F075CD00DC_impl*
 Assert(false, '����� ������������ ���� � �������');
 if Supports(InitialUseCaseData, IdeDocInfo, l_DocInfo) then
 try
  ChangeDocument(l_DocInfo);
 finally
  l_DocInfo := nil;
 end;//if Supports(InitialUseCaseData,
//#UC END# *47F37DF001FE_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsBaseDrugDocument_.ClearAllDS;
//#UC START# *4925B7F00156_47F075CD00DC_var*
//#UC END# *4925B7F00156_47F075CD00DC_var*
begin
//#UC START# *4925B7F00156_47F075CD00DC_impl*
 inherited;
 SetData.dsDrugInternationalNameSynonimsRef.Referred := nil;
//#UC END# *4925B7F00156_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.ClearAllDS

function _sdsBaseDrugDocument_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_47F075CD00DC_var*
//#UC END# *4925B9370022_47F075CD00DC_var*
begin
//#UC START# *4925B9370022_47F075CD00DC_impl*
 if not (pm_GetDocInfo <> nil) or not Assigned(aDoc) or
   (not aDoc.Doc.IsSameView(pm_GetDocInfo.Doc) or
   not aDoc.Pos.EQ(pm_GetDocInfo.Pos)) then
 begin
  SetData.DocInfo := aDoc;
  Result := True;
  SetData.ResetBooleans;
  ClearAllDS;
  FillState;
  Refresh;
 end
 else
  Result := False;
//#UC END# *4925B9370022_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.DoChangeDocument

function _sdsBaseDrugDocument_.GetHasAttributes: Boolean;
 {* ���������� HasAttributes }
//#UC START# *49352CEF0222_47F075CD00DC_var*
//#UC END# *49352CEF0222_47F075CD00DC_var*
begin
//#UC START# *49352CEF0222_47F075CD00DC_impl*
 if afw.Application.IsInternal then
  Result := inherited GetHasAttributes
 else
  Result := False;
//#UC END# *49352CEF0222_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.GetHasAttributes

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDrugDocument_.ClearAreas;
 {* ������� ������ �� ������� ����� }
//#UC START# *4938F7E702B7_47F075CD00DC_var*
//#UC END# *4938F7E702B7_47F075CD00DC_var*
begin
//#UC START# *4938F7E702B7_47F075CD00DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_47F075CD00DC_impl*
end;//_sdsBaseDrugDocument_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf sdsBaseDrugDocument_imp_impl}

{$EndIf sdsBaseDrugDocument_imp}

