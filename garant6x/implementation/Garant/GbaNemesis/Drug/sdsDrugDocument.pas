unit sdsDrugDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/sdsDrugDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Drug::sdsDrugDocument::TsdsDrugDocument
//
// Базовый для списка препаратов и описания препаратов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  MedicInterfaces,
  DocumentInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID,
  nevTools,
  bsTypes,
  afwInterfaces,
  FoldersDomainInterfaces,
  vcmControllers {a},
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces,
  WorkWithDocumentInterfaces {a}
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  F1TagDataProviderInterface,
  nsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdDrugDocument;
 _InitDataType_ = IdeDocInfo;
 _SetType_ = IsdsDrugDocument;
 {$Include ..\Drug\sdsBaseDrugDocument.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _sdsBaseDrugDocument_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _nsOpenContents_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsOpenContents.imp.pas}
 TsdsDrugDocument = {ucc} class(_nsOpenContents_, IsdsDrugDocument, IucpDocumentWithContents {from IsdsDrugDocument})
  {* Базовый для списка препаратов и описания препаратов. }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   procedure OpenDrugInternationalNameSynonims;
     {* Открыть список синонимов по международному названию. }
   function BaseDocumentClass: IdsBaseDocument; override;
   function pm_GetDsContents: IdsBaseContents;
   function DoGet_dsContents: IdsBaseContents;
   function pm_GetdsContentsRef: IvcmViewAreaControllerRef;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   procedure ClearAllDS; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   procedure FillState; override;
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IucpDocumentWithContents: IucpDocumentWithContents;
 end;//TsdsDrugDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsBaseContents,
  dsDrugDocument,
  dDrugDocument,
  SysUtils,
  l3Types,
  dsDrugList,
  l3Utils,
  bsUtils,
  deList,
  afwFacade,
  dsAttributes,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsDrugDocument;

{$Include ..\Drug\sdsBaseDrugDocument.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsOpenContents.imp.pas}

// start class TsdsDrugDocument

{$If not defined(NoVCM)}
function TsdsDrugDocument.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_47F4A2F801D8_var*
//#UC END# *47F3778403D9_47F4A2F801D8_var*
begin
//#UC START# *47F3778403D9_47F4A2F801D8_impl*
 Result := TdDrugDocument.Make;
//#UC END# *47F3778403D9_47F4A2F801D8_impl*
end;//TsdsDrugDocument.MakeData
{$IfEnd} //not NoVCM

procedure TsdsDrugDocument.OpenDrugInternationalNameSynonims;
//#UC START# *47FDF09F0290_47F4A2F801D8_var*
//#UC END# *47FDF09F0290_47F4A2F801D8_var*
begin
//#UC START# *47FDF09F0290_47F4A2F801D8_impl*
 DoOpenDrugInternationalNameSynonims;
//#UC END# *47FDF09F0290_47F4A2F801D8_impl*
end;//TsdsDrugDocument.OpenDrugInternationalNameSynonims

function TsdsDrugDocument.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_47F4A2F801D8_var*
//#UC END# *4925B1EC0100_47F4A2F801D8_var*
begin
//#UC START# *4925B1EC0100_47F4A2F801D8_impl*
 Result := TdsDrugDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_47F4A2F801D8_impl*
end;//TsdsDrugDocument.BaseDocumentClass

function TsdsDrugDocument.pm_GetDsContents: IdsBaseContents;
//#UC START# *500CEEBD01CB_47F4A2F801D8get_var*
//#UC END# *500CEEBD01CB_47F4A2F801D8get_var*
begin
 with pm_GetdsContentsRef do
 begin
  if IsEmpty
   //#UC START# *500CEEBD01CB_47F4A2F801D8get_need*
     AND (NeedMake <> vcm_nmNo)
   // - условие создания ViewArea
  //#UC END# *500CEEBD01CB_47F4A2F801D8get_need*
   then
    Referred := DoGet_dsContents;
  Result := IdsBaseContents(Referred);
 end;//with pm_GetdsContentsRef
end;

function TsdsDrugDocument.DoGet_dsContents: IdsBaseContents;
//#UC START# *500CEEBD01CB_47F4A2F801D8area_var*
//#UC END# *500CEEBD01CB_47F4A2F801D8area_var*
begin
//#UC START# *500CEEBD01CB_47F4A2F801D8area_impl*
 if Assigned(SetData.ContentsTree) then
  Result := TdsBaseContents.Make(Self, SetData.ContentsTree)
 else
  Result := nil;
//#UC END# *500CEEBD01CB_47F4A2F801D8area_impl*
end;//TsdsDrugDocument.DoGet_dsContents

function TsdsDrugDocument.pm_GetdsContentsRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsContentsRef;
end;

procedure TsdsDrugDocument.FinishDataUpdate;
//#UC START# *47EA4E9002C6_47F4A2F801D8_var*
//#UC END# *47EA4E9002C6_47F4A2F801D8_var*
begin
//#UC START# *47EA4E9002C6_47F4A2F801D8_impl*
 inherited;
 pm_GetDocInfo.ClearListNode;
 SetData.ResetBooleans; // http://mdp.garant.ru/pages/viewpage.action?pageId=297704301
 ClearAllDS;
 Refresh;
//#UC END# *47EA4E9002C6_47F4A2F801D8_impl*
end;//TsdsDrugDocument.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TsdsDrugDocument.DataExchange;
//#UC START# *47F37DF001FE_47F4A2F801D8_var*
//#UC END# *47F37DF001FE_47F4A2F801D8_var*
begin
//#UC START# *47F37DF001FE_47F4A2F801D8_impl*
 ChangeDocument(InitialUseCaseData);
//#UC END# *47F37DF001FE_47F4A2F801D8_impl*
end;//TsdsDrugDocument.DataExchange
{$IfEnd} //not NoVCM

procedure TsdsDrugDocument.ClearAllDS;
//#UC START# *4925B7F00156_47F4A2F801D8_var*
//#UC END# *4925B7F00156_47F4A2F801D8_var*
begin
//#UC START# *4925B7F00156_47F4A2F801D8_impl*
 inherited;
//#UC END# *4925B7F00156_47F4A2F801D8_impl*
end;//TsdsDrugDocument.ClearAllDS

{$If not defined(NoVCM)}
procedure TsdsDrugDocument.ClearAreas;
 {-}
begin
 pm_GetdsContentsRef.Referred := nil;
 inherited;
end;//TsdsDrugDocument.ClearAreas
{$IfEnd} //not NoVCM

procedure TsdsDrugDocument.FillState;
//#UC START# *493D51ED0329_47F4A2F801D8_var*
//#UC END# *493D51ED0329_47F4A2F801D8_var*
begin
//#UC START# *493D51ED0329_47F4A2F801D8_impl*
 inherited;
 if pm_GetHasDrugInternationalNameSynonims then
  SetData.dsDrugInternationalNameSynonimsRef.NeedMake := vcm_nmYes;
//#UC END# *493D51ED0329_47F4A2F801D8_impl*
end;//TsdsDrugDocument.FillState

// Методы преобразования к реализуемым интерфейсам

function TsdsDrugDocument.As_IucpDocumentWithContents: IucpDocumentWithContents;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.