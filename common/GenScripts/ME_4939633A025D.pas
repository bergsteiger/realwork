{$IfNDef sdsMedicFirmDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.imp.pas"
// Стереотип: "UseCaseControllerImp"

{$Define sdsMedicFirmDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _InitDataType_ = IdeDocInfo;
 {$Include sdsBaseDocumentWithAttributes.imp.pas}
 _sdsMedicFirmDocument_ = {abstract} class(_sdsBaseDocumentWithAttributes_, IsdsMedicFirmDocumentPrim)
  {* документ-фирма }
  protected
   function NeedMakeDrugList: Boolean; virtual;
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure OpenDrugList;
   function pm_GetdsDrugList: IdsDrugList;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function GetHasAttributes: Boolean; override;
    {* Реализация HasAttributes }
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_sdsMedicFirmDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include sdsBaseDocumentWithAttributes.imp.pas}
_sdsMedicFirmDocument_ = _sdsBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsMedicFirmDocument_imp}

{$IfNDef sdsMedicFirmDocument_imp_impl}

{$Define sdsMedicFirmDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include sdsBaseDocumentWithAttributes.imp.pas}

function _sdsMedicFirmDocument_.NeedMakeDrugList: Boolean;
//#UC START# *493964C6039A_4939633A025D_var*
//#UC END# *493964C6039A_4939633A025D_var*
begin
//#UC START# *493964C6039A_4939633A025D_impl*
 Result := true;
//#UC END# *493964C6039A_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.NeedMakeDrugList

function _sdsMedicFirmDocument_.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_4939633A025D_var*
//#UC END# *4925B1EC0100_4939633A025D_var*
begin
//#UC START# *4925B1EC0100_4939633A025D_impl*
 Result := TdsMedicFirmDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.BaseDocumentClass

procedure _sdsMedicFirmDocument_.OpenDrugList;
//#UC START# *4937AC23020B_4939633A025D_var*
//#UC END# *4937AC23020B_4939633A025D_var*
begin
//#UC START# *4937AC23020B_4939633A025D_impl*
 with pm_GetdsDrugListRef do
  if IsEmpty then
  begin
   SetIfNeedMakeNo(vcm_nmForce);
   Refresh;
  end;//IsEmpty
//#UC END# *4937AC23020B_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.OpenDrugList

function _sdsMedicFirmDocument_.pm_GetdsDrugList: IdsDrugList;
//#UC START# *500D3D150007_4939633A025Dget_var*
//#UC END# *500D3D150007_4939633A025Dget_var*
begin
//#UC START# *500D3D150007_4939633A025Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D3D150007_4939633A025Dget_impl*
end;//_sdsMedicFirmDocument_.pm_GetdsDrugList

{$If NOT Defined(NoVCM)}
procedure _sdsMedicFirmDocument_.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_4939633A025D_var*
//#UC END# *47F37DF001FE_4939633A025D_var*
begin
//#UC START# *47F37DF001FE_4939633A025D_impl*
 ChangeDocument(InitialUseCaseData);
//#UC END# *47F37DF001FE_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsMedicFirmDocument_.ClearAllDS;
//#UC START# *4925B7F00156_4939633A025D_var*
//#UC END# *4925B7F00156_4939633A025D_var*
begin
//#UC START# *4925B7F00156_4939633A025D_impl*
 inherited;
 pm_GetdsDrugListRef.Referred := nil;
//#UC END# *4925B7F00156_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.ClearAllDS

function _sdsMedicFirmDocument_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_4939633A025D_var*
//#UC END# *4925B9370022_4939633A025D_var*
begin
//#UC START# *4925B9370022_4939633A025D_impl*
 if not (pm_GetDocInfo <> nil) or not Assigned(aDoc) or
   (not aDoc.Doc.IsSameView(pm_GetDocInfo.Doc) or
   not aDoc.Pos.EQ(pm_GetDocInfo.Pos)) then
 begin
  SetData.DocInfo := aDoc;
  Result := True;
  ClearAllDS;
  Refresh;
 end
 else
  Result := False;
//#UC END# *4925B9370022_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.DoChangeDocument

function _sdsMedicFirmDocument_.GetHasAttributes: Boolean;
 {* Реализация HasAttributes }
//#UC START# *49352CEF0222_4939633A025D_var*
//#UC END# *49352CEF0222_4939633A025D_var*
begin
//#UC START# *49352CEF0222_4939633A025D_impl*
 if afw.Application.IsInternal then
  Result := inherited GetHasAttributes
 else
  Result := False;
//#UC END# *49352CEF0222_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.GetHasAttributes

{$If NOT Defined(NoVCM)}
procedure _sdsMedicFirmDocument_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_4939633A025D_var*
//#UC END# *4938F7E702B7_4939633A025D_var*
begin
//#UC START# *4938F7E702B7_4939633A025D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf sdsMedicFirmDocument_imp_impl}

{$EndIf sdsMedicFirmDocument_imp}

