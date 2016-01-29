{$IfNDef sdsMedicFirmDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/sdsMedicFirmDocument.imp.pas"
// Начат: 2008/03/26 13:08:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::sdsMedicFirmDocument
//
// документ-фирма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define sdsMedicFirmDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _InitDataType_ = IdeDocInfo;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsMedicFirmDocument_ = {abstract ucc} class(_sdsBaseDocumentWithAttributes_, IsdsMedicFirmDocumentPrim)
  {* документ-фирма }
 protected
 // realized methods
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure OpenDrugList;
   function pm_GetDsDrugList: IdsDrugList;
   function DoGet_dsDrugList: IdsDrugList;
   function pm_GetdsDrugListRef: IvcmViewAreaControllerRef;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   function GetHasAttributes: Boolean; override;
     {* Реализация HasAttributes }
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function NeedMakeDrugList: Boolean; virtual;
 end;//_sdsMedicFirmDocument_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _sdsMedicFirmDocument_ = _sdsBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else sdsMedicFirmDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}

// start class _sdsMedicFirmDocument_

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

function _sdsMedicFirmDocument_.pm_GetDsDrugList: IdsDrugList;
//#UC START# *500D3D150007_4939633A025Dget_var*
//#UC END# *500D3D150007_4939633A025Dget_var*
begin
 with pm_GetdsDrugListRef do
 begin
  if IsEmpty
   //#UC START# *500D3D150007_4939633A025Dget_need*
     AND (NeedMake <> vcm_nmNo)
     AND NeedMakeDrugList   
   // - условие создания ViewArea
  //#UC END# *500D3D150007_4939633A025Dget_need*
   then
    Referred := DoGet_dsDrugList;
  Result := IdsDrugList(Referred);
 end;//with pm_GetdsDrugListRef
end;

function _sdsMedicFirmDocument_.DoGet_dsDrugList: IdsDrugList;
//#UC START# *500D3D150007_4939633A025Darea_var*

 function lp_DrugList: IDynList;
 var
  l_DrugList: ICatalogBase;
 begin
  if (pm_GetDocInfo <> nil) and Assigned(pm_GetDocInfo.Doc) then
   try
    pm_GetDocInfo.Doc.GetDrugList(l_DrugList);
   except
    on ECanNotFindData do
     l_DrugList := nil;
   end//try..except
  else
   l_DrugList := nil;
  try
   Supports(l_DrugList, IDynList, Result);
  finally
   l_DrugList := nil;
  end;{try..finally}
 end;//lp_SimilarDocsList

//#UC END# *500D3D150007_4939633A025Darea_var*
begin
//#UC START# *500D3D150007_4939633A025Darea_impl*
 Result := TdsDrugList.Make(Self, TdeList.Make(lp_DrugList));
//#UC END# *500D3D150007_4939633A025Darea_impl*
end;//_sdsMedicFirmDocument_.DoGet_dsDrugList

function _sdsMedicFirmDocument_.pm_GetdsDrugListRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsDrugListRef;
end;

{$If not defined(NoVCM)}
procedure _sdsMedicFirmDocument_.DataExchange;
//#UC START# *47F37DF001FE_4939633A025D_var*
//#UC END# *47F37DF001FE_4939633A025D_var*
begin
//#UC START# *47F37DF001FE_4939633A025D_impl*
 ChangeDocument(InitialUseCaseData);
//#UC END# *47F37DF001FE_4939633A025D_impl*
end;//_sdsMedicFirmDocument_.DataExchange
{$IfEnd} //not NoVCM

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

{$If not defined(NoVCM)}
procedure _sdsMedicFirmDocument_.ClearAreas;
 {-}
begin
 pm_GetdsDrugListRef.Referred := nil;
 inherited;
end;//_sdsMedicFirmDocument_.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf sdsMedicFirmDocument_imp}
