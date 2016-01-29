unit sdsAAC;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AAC$DataSources"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/sdsAAC.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::AAC::AAC$DataSources::AACImplementation::TsdsAAC
//
// Контроллер прецедента "Актуальная аналитика"
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  WorkWithDocumentInterfaces,
  nsDocumentLikeStateHolder,
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  bsTypes,
  DocumentInterfaces,
  bsTypesNew,
  DynamicDocListUnit,
  PrimListInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID,
  nevTools,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces,
  ExternalObjectUnit,
  evdInterfaces,
  l3Tree_TLB,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  PreviewInterfaces,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
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
 _SetType_ = IsdsAAC;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.imp.pas}
 TsdsAAC = {ucc} class(_sdsDocument_, IsdsAAC)
  {* Контроллер прецедента "Актуальная аналитика" }
 private
 // private fields
   f_DocumentLikeStateHolder : InsDocumentLikeStateHolder;
   f_Container : IvcmViewAreaControllerRef;
    {* Поле для области вывода Container}
   f_Left : IvcmViewAreaControllerRef;
    {* Поле для области вывода Left}
   f_Right : IvcmViewAreaControllerRef;
    {* Поле для области вывода Right}
 private
 // private methods
   function MakeDocumentLikeStateHolder: InsDocumentLikeStateHolder;
 protected
 // realized methods
   function pm_GetContainer: IdsAACContainer;
   function DoGet_Container: IdsAACContainer;
   function pm_GetLeft: IdsBaseDocument;
   function DoGet_Left: IdsBaseDocument;
   function pm_GetRight: IdsBaseDocument;
   function DoGet_Right: IdsBaseDocument;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; override;
   {$IfEnd} //not NoVCM
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure ClearAllDS; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
 end;//TsdsAAC
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsDocument,
  dsAACContainer,
  dsAACDocumentLeft,
  dsAACDocumentRight,
  dDocument,
  SysUtils,
  dsDocumentListCRToPart,
  deDocumentListCR,
  dsWarning,
  dsContents,
  dsEditions
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmGUI
  {$IfEnd} //not NoVCM
  ,
  IOUnit
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  BaseTypesUnit,
  DataAdapter,
  k2Tags
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams
  {$IfEnd} //not NoVCM
  ,
  bsUtils,
  l3String,
  l3Core,
  nsDocumentTools,
  afwFacade,
  Graphics
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  nsConst,
  Document_Const,
  TextPara_Const,
  WarningUserTypes_Warning_UserType,
  UnderControlInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  ControlStatusUtils,
  nsDocumentWarningGenerator,
  dsTranslationWarning,
  dsCRWarning,
  nsTabbedInterfaceTypes,
  dsDocumentListCR,
  dsDocumentList,
  dsAnnotation,
  dsDocumentWithFlash,
  bsFrozenNode,
  deDocInfo,
  bsDataContainer,
  deDocumentList,
  bsUserCRListInfo,
  l3Types,
  DebugStr,
  l3Utils,
  nsUtils,
  dsTranslation,
  dsRelatedDoc,
  dsChronology,
  dsAttributes,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwSettingsChangePublisher,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsAAC;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.imp.pas}

// start class TsdsAAC

function TsdsAAC.MakeDocumentLikeStateHolder: InsDocumentLikeStateHolder;
//#UC START# *51ED56B903D6_4FF2E6B003C4_var*
//#UC END# *51ED56B903D6_4FF2E6B003C4_var*
begin
//#UC START# *51ED56B903D6_4FF2E6B003C4_impl*
 if not Assigned(f_DocumentLikeStateHolder) then
  f_DocumentLikeStateHolder := TnsDocumentLikeStateHolder.Make;
 Result := f_DocumentLikeStateHolder;
//#UC END# *51ED56B903D6_4FF2E6B003C4_impl*
end;//TsdsAAC.MakeDocumentLikeStateHolder

function TsdsAAC.pm_GetContainer: IdsAACContainer;
//#UC START# *4FF2E70A0103_4FF2E6B003C4get_var*
//#UC END# *4FF2E70A0103_4FF2E6B003C4get_var*
begin
 if (f_Container = nil) then
 begin
  f_Container := TvcmViewAreaControllerRef.Make;
  //#UC START# *4FF2E70A0103_4FF2E6B003C4get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4FF2E70A0103_4FF2E6B003C4get_init*
 end;//f_Container = nil
 if f_Container.IsEmpty
  //#UC START# *4FF2E70A0103_4FF2E6B003C4get_need*
  // - условие создания ViewArea
  //#UC END# *4FF2E70A0103_4FF2E6B003C4get_need*
  then
   f_Container.Referred := DoGet_Container;
 Result := IdsAACContainer(f_Container.Referred);
end;

function TsdsAAC.DoGet_Container: IdsAACContainer;
//#UC START# *4FF2E70A0103_4FF2E6B003C4area_var*
//#UC END# *4FF2E70A0103_4FF2E6B003C4area_var*
begin
//#UC START# *4FF2E70A0103_4FF2E6B003C4area_impl*
 Result := TdsAACContainer.Make(Self);
//#UC END# *4FF2E70A0103_4FF2E6B003C4area_impl*
end;//TsdsAAC.DoGet_Container

function TsdsAAC.pm_GetLeft: IdsBaseDocument;
//#UC START# *4FF2E78901DC_4FF2E6B003C4get_var*
//#UC END# *4FF2E78901DC_4FF2E6B003C4get_var*
begin
 if (f_Left = nil) then
 begin
  f_Left := TvcmViewAreaControllerRef.Make;
  //#UC START# *4FF2E78901DC_4FF2E6B003C4get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4FF2E78901DC_4FF2E6B003C4get_init*
 end;//f_Left = nil
 if f_Left.IsEmpty
  //#UC START# *4FF2E78901DC_4FF2E6B003C4get_need*
  // - условие создания ViewArea
  //#UC END# *4FF2E78901DC_4FF2E6B003C4get_need*
  then
   f_Left.Referred := DoGet_Left;
 Result := IdsBaseDocument(f_Left.Referred);
end;

function TsdsAAC.DoGet_Left: IdsBaseDocument;
//#UC START# *4FF2E78901DC_4FF2E6B003C4area_var*
//#UC END# *4FF2E78901DC_4FF2E6B003C4area_var*
begin
//#UC START# *4FF2E78901DC_4FF2E6B003C4area_impl*
 Result := TdsAACDocumentLeft.Make(Self, DocumentData, MakeDocumentLikeStateHolder);
// Result := Self.pm_GetdsDocument;
//#UC END# *4FF2E78901DC_4FF2E6B003C4area_impl*
end;//TsdsAAC.DoGet_Left

function TsdsAAC.pm_GetRight: IdsBaseDocument;
//#UC START# *4FF2E7BE016B_4FF2E6B003C4get_var*
//#UC END# *4FF2E7BE016B_4FF2E6B003C4get_var*
begin
 if (f_Right = nil) then
 begin
  f_Right := TvcmViewAreaControllerRef.Make;
  //#UC START# *4FF2E7BE016B_4FF2E6B003C4get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4FF2E7BE016B_4FF2E6B003C4get_init*
 end;//f_Right = nil
 if f_Right.IsEmpty
  //#UC START# *4FF2E7BE016B_4FF2E6B003C4get_need*
  // - условие создания ViewArea
  //#UC END# *4FF2E7BE016B_4FF2E6B003C4get_need*
  then
   f_Right.Referred := DoGet_Right;
 Result := IdsBaseDocument(f_Right.Referred);
end;

function TsdsAAC.DoGet_Right: IdsBaseDocument;
//#UC START# *4FF2E7BE016B_4FF2E6B003C4area_var*
//#UC END# *4FF2E7BE016B_4FF2E6B003C4area_var*
begin
//#UC START# *4FF2E7BE016B_4FF2E6B003C4area_impl*
 Result := TdsAACDocumentRight.Make(Self, DocumentData, MakeDocumentLikeStateHolder);
// Result := Self.pm_GetdsDocument;
//#UC END# *4FF2E7BE016B_4FF2E6B003C4area_impl*
end;//TsdsAAC.DoGet_Right

procedure TsdsAAC.Cleanup;
//#UC START# *479731C50290_4FF2E6B003C4_var*
//#UC END# *479731C50290_4FF2E6B003C4_var*
begin
//#UC START# *479731C50290_4FF2E6B003C4_impl*
 f_DocumentLikeStateHolder := nil;
 inherited;
//#UC END# *479731C50290_4FF2E6B003C4_impl*
end;//TsdsAAC.Cleanup

{$If not defined(NoVCM)}
function TsdsAAC.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_4FF2E6B003C4_var*
//#UC END# *491B02D80112_4FF2E6B003C4_var*
begin
//#UC START# *491B02D80112_4FF2E6B003C4_impl*
 Result := (_SetType_(Self) = aDataSource);
 // - сборки для ААК всегда отличаются,
 //   т.к. блоки в правой или левой половинах могут менятся
 if not Result AND (aDataSource <> nil) then
  if Self.pm_GetDocInfo.Pos.EQ(aDataSource.DocInfo.Pos) then
   Result := inherited GetIsNeedChangePosition(aDataSource);
//#UC END# *491B02D80112_4FF2E6B003C4_impl*
end;//TsdsAAC.GetIsNeedChangePosition
{$IfEnd} //not NoVCM

function TsdsAAC.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_4FF2E6B003C4_var*
//#UC END# *4925B1EC0100_4FF2E6B003C4_var*
begin
//#UC START# *4925B1EC0100_4FF2E6B003C4_impl*
 Result := pm_GetLeft;
 //Result := inherited BaseDocumentClass;
//#UC END# *4925B1EC0100_4FF2E6B003C4_impl*
end;//TsdsAAC.BaseDocumentClass

procedure TsdsAAC.ClearAllDS;
//#UC START# *4925B7F00156_4FF2E6B003C4_var*
//#UC END# *4925B7F00156_4FF2E6B003C4_var*
begin
//#UC START# *4925B7F00156_4FF2E6B003C4_impl*
 inherited;
 if (f_Container <> nil) then f_Container.Referred := nil;
 if (f_Left <> nil) then f_Left.Referred := nil;
 if (f_Right <> nil) then f_Right.Referred := nil;
//#UC END# *4925B7F00156_4FF2E6B003C4_impl*
end;//TsdsAAC.ClearAllDS

{$If not defined(NoVCM)}
procedure TsdsAAC.ClearAreas;
 {-}
begin
 if (f_Container <> nil) then f_Container.Referred := nil;
 if (f_Left <> nil) then f_Left.Referred := nil;
 if (f_Right <> nil) then f_Right.Referred := nil;
 inherited;
end;//TsdsAAC.ClearAreas
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsAAC.DoGetTabCaption: IvcmCString;
//#UC START# *54CF10260215_4FF2E6B003C4_var*
//#UC END# *54CF10260215_4FF2E6B003C4_var*
begin
//#UC START# *54CF10260215_4FF2E6B003C4_impl*
 Result := nsGetDocumentName(pm_GetDocInfo.Doc);
//#UC END# *54CF10260215_4FF2E6B003C4_impl*
end;//TsdsAAC.DoGetTabCaption
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.