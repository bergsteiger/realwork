unit sdsDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/sdsDrugList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Drug::sdsDrugList::TsdsDrugList
//
// БОС Список лекарственных препаратов.
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
  MedicInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  PrimPrimListInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces,
  DocumentInterfaces,
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
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicDocListUnit,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  SimpleListInterfaces {a},
  WorkWithListInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdDrugList;
 _InitDataType_ = IdeList;
 _SetType_ = IsdsDrugList;
 {$Include ..\Drug\sdsBaseDrugDocument.imp.pas}
 _nsListWarningGenerator_Parent_ = _sdsBaseDrugDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}
 TsdsDrugList = {ucc} class(_nsListWarningGenerator_, IsdsDrugList, IucpFilters {from IsdsDrugList}, IucpNodeForPositioningHolder {from IsdsDrugList}, InsWarningGenerator {from IsdsDrugList}, IsdsListPrim {from IsdsDrugList}, IsdsListNameHolder {from IsdsDrugList})
  {* БОС Список лекарственных препаратов. }
 private
 // private fields
   f_dsBaloonWarning : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning}
 protected
 // realized methods
   function pm_GetIsDocumentActive: Boolean;
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   procedure UpdateListInfo;
     {* - обновить информацию о списке. }
   procedure Open;
     {* открыть форму фильтры }
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure ReleaseNodeForPositioning;
     {* - освободить узел для позиционирования. }
   function BaseDocumentClass: IdsBaseDocument; override;
   function Get_DsListPrim: IdsList;
   function pm_GetDsBaloonWarning: IdsWarning;
   function DoGet_dsBaloonWarning: IdsWarning;
   function pm_GetDsDrugList: IdsDrugList;
   function DoGet_dsDrugList: IdsDrugList;
   function pm_GetdsDrugListRef: IvcmViewAreaControllerRef;
   function pm_GetDsSynchroView: IdsDrugListSynchroView;
   function DoGet_dsSynchroView: IdsDrugListSynchroView;
   function pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
   function pm_GetDsFilters: IdsFilters;
   function DoGet_dsFilters: IdsFilters;
   function pm_GetdsFiltersRef: IvcmViewAreaControllerRef;
   function pm_GetDsListInfo: IdsListInfo;
   function DoGet_dsListInfo: IdsListInfo;
   function pm_GetdsListInfoRef: IvcmViewAreaControllerRef;
   function pm_GetShortListName: Il3CString;
   function pm_GetListName: Il3CString;
   procedure OpenDocument;
     {* Открывает ViewArea "Собственно документ" }
   procedure OpenDrugInternationalNameSynonims;
     {* Открывает ViewArea "Бизнес объект "Синонимы по международному названию"" }
   function pm_GetIsAttributesActive: Boolean;
   function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
   procedure OpenAttributes;
     {* Открывает ViewArea "атрибуты документа" }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   procedure DoOpenAttributes; override;
     {* - атрибуты. }
   procedure DoOpenDrugInternationalNameSynonims; override;
     {* - открыть синонимы по международному названию. }
   function NeedMakeDSAttributes: Boolean; override;
     {* - необходимость создания БОФ атрибутов. }
   function NeedMakeDsDrugInternationalNameSynonims: Boolean; override;
     {* - нужно ли создавать БОФ синонимов по международному названию. }
   procedure ClearAllDS; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function NeedMakeDocument: Boolean; override;
     {* Определяет - нужно ли создавать область ввода для документа }
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure ChangeSynchroForm(aSynchroForm: TDrugList_SynchroView_Areas);
     {* Переключает форму синхронного просмотра }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IucpFilters: IucpFilters;
   function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
   function As_InsWarningGenerator: InsWarningGenerator;
   function As_IsdsListPrim: IsdsListPrim;
   function As_IsdsListNameHolder: IsdsListNameHolder;
 end;//TsdsDrugList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsDrugList,
  SysUtils,
  dsDrugListSynchroView,
  dDrugList,
  deList,
  dsFilters,
  dsMainDrugList,
  afwFacade
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsConst,
  dsListInfo,
  bsUtils,
  dsDrugListDocument,
  dsWarning,
  nsTabbedInterfaceTypes,
  l3Types,
  l3Utils,
  dsAttributes,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  WarningUserTypes_Warning_UserType,
  Document_Const,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsDocumentWarningGenerator,
  BaloonWarningUserTypes_remListModified_UserType,
  UnderControlInterfaces,
  nsListWarningGenerator,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsDrugList;

{$Include ..\Drug\sdsBaseDrugDocument.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}

// start class TsdsDrugList

procedure TsdsDrugList.ChangeSynchroForm(aSynchroForm: TDrugList_SynchroView_Areas);
//#UC START# *341E87C755C8_47EA0F2B031C_var*
//#UC END# *341E87C755C8_47EA0F2B031C_var*
begin
//#UC START# *341E87C755C8_47EA0F2B031C_impl*
 if (aSynchroForm <> SetData.DrugList_SynchroView_Form) then
 begin
  ClearAllDS;
  SetData.DrugList_SynchroView_Form := aSynchroForm;
  Refresh;
 end;//aSynchroForm <> SetData.DrugList_SynchroView_Form
//#UC END# *341E87C755C8_47EA0F2B031C_impl*
end;//TsdsDrugList.ChangeSynchroForm

function TsdsDrugList.pm_GetIsDocumentActive: Boolean;
//#UC START# *41B49128CE19_47EA0F2B031Cget_var*
//#UC END# *41B49128CE19_47EA0F2B031Cget_var*
begin
//#UC START# *41B49128CE19_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Document;
//#UC END# *41B49128CE19_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsDocumentActive

{$If not defined(NoVCM)}
function TsdsDrugList.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_47EA0F2B031C_var*
//#UC END# *47F3778403D9_47EA0F2B031C_var*
begin
//#UC START# *47F3778403D9_47EA0F2B031C_impl*
 Result := TdDrugList.Make;
 with Result do
 begin
  dsFiltersRef.NeedMake := vcm_nmYes;
  dsDrugInternationalNameSynonimsRef.NeedMake := vcm_nmYes;
 end;//with Result
//#UC END# *47F3778403D9_47EA0F2B031C_impl*
end;//TsdsDrugList.MakeData
{$IfEnd} //not NoVCM

procedure TsdsDrugList.UpdateListInfo;
//#UC START# *47F4BF4E0397_47EA0F2B031C_var*
//#UC END# *47F4BF4E0397_47EA0F2B031C_var*
begin
//#UC START# *47F4BF4E0397_47EA0F2B031C_impl*
 SetData.dsListInfoRef.Clear;
 Refresh;
//#UC END# *47F4BF4E0397_47EA0F2B031C_impl*
end;//TsdsDrugList.UpdateListInfo

procedure TsdsDrugList.Open;
//#UC START# *47FB2086026D_47EA0F2B031C_var*
//#UC END# *47FB2086026D_47EA0F2B031C_var*
begin
//#UC START# *47FB2086026D_47EA0F2B031C_impl*
 SetData.dsFiltersRef.NeedMake := vcm_nmForce;
 Refresh; 
//#UC END# *47FB2086026D_47EA0F2B031C_impl*
end;//TsdsDrugList.Open

function TsdsDrugList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *47FF2155021A_47EA0F2B031Cget_var*
//#UC END# *47FF2155021A_47EA0F2B031Cget_var*
begin
//#UC START# *47FF2155021A_47EA0F2B031Cget_impl*
 Result := SetData.NodeForPositioning;
//#UC END# *47FF2155021A_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetNodeForPositioning

procedure TsdsDrugList.ReleaseNodeForPositioning;
//#UC START# *47FF44850384_47EA0F2B031C_var*
//#UC END# *47FF44850384_47EA0F2B031C_var*
begin
//#UC START# *47FF44850384_47EA0F2B031C_impl*
 SetData.NodeForPositioning := nil;
//#UC END# *47FF44850384_47EA0F2B031C_impl*
end;//TsdsDrugList.ReleaseNodeForPositioning

function TsdsDrugList.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_47EA0F2B031C_var*
//#UC END# *4925B1EC0100_47EA0F2B031C_var*
begin
//#UC START# *4925B1EC0100_47EA0F2B031C_impl*
 Result := TdsDrugListDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_47EA0F2B031C_impl*
end;//TsdsDrugList.BaseDocumentClass

function TsdsDrugList.Get_DsListPrim: IdsList;
//#UC START# *49AE664F006B_47EA0F2B031Cget_var*
//#UC END# *49AE664F006B_47EA0F2B031Cget_var*
begin
//#UC START# *49AE664F006B_47EA0F2B031Cget_impl*
 Result := pm_GetDsDrugList;
//#UC END# *49AE664F006B_47EA0F2B031Cget_impl*
end;//TsdsDrugList.Get_DsListPrim

function TsdsDrugList.pm_GetDsBaloonWarning: IdsWarning;
//#UC START# *4DC185B80232_47EA0F2B031Cget_var*
//#UC END# *4DC185B80232_47EA0F2B031Cget_var*
begin
 if (f_dsBaloonWarning = nil) then
 begin
  f_dsBaloonWarning := TvcmViewAreaControllerRef.Make;
  //#UC START# *4DC185B80232_47EA0F2B031Cget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4DC185B80232_47EA0F2B031Cget_init*
 end;//f_dsBaloonWarning = nil
 if f_dsBaloonWarning.IsEmpty
  //#UC START# *4DC185B80232_47EA0F2B031Cget_need*
  // - условие создания ViewArea
  //#UC END# *4DC185B80232_47EA0F2B031Cget_need*
  then
   f_dsBaloonWarning.Referred := DoGet_dsBaloonWarning;
 Result := IdsWarning(f_dsBaloonWarning.Referred);
end;

function TsdsDrugList.DoGet_dsBaloonWarning: IdsWarning;
//#UC START# *4DC185B80232_47EA0F2B031Carea_var*
//#UC END# *4DC185B80232_47EA0F2B031Carea_var*
begin
//#UC START# *4DC185B80232_47EA0F2B031Carea_impl*
 Result := TdsWarning.Make(Self);
//#UC END# *4DC185B80232_47EA0F2B031Carea_impl*
end;//TsdsDrugList.DoGet_dsBaloonWarning

function TsdsDrugList.pm_GetDsDrugList: IdsDrugList;
//#UC START# *500D3D75005B_47EA0F2B031Cget_var*
//#UC END# *500D3D75005B_47EA0F2B031Cget_var*
begin
 with pm_GetdsDrugListRef do
 begin
  if IsEmpty
   //#UC START# *500D3D75005B_47EA0F2B031Cget_need*
  // - условие создания ViewArea
  //#UC END# *500D3D75005B_47EA0F2B031Cget_need*
   then
    Referred := DoGet_dsDrugList;
  Result := IdsDrugList(Referred);
 end;//with pm_GetdsDrugListRef
end;

function TsdsDrugList.DoGet_dsDrugList: IdsDrugList;
//#UC START# *500D3D75005B_47EA0F2B031Carea_var*
//#UC END# *500D3D75005B_47EA0F2B031Carea_var*
begin
//#UC START# *500D3D75005B_47EA0F2B031Carea_impl*
 //Result := TdsMainDrugList.Make(Self, TdeList.Make(SetData.List));
 // http://mdp.garant.ru/pages/viewpage.action?pageId=245208757&focusedCommentId=248190020#comment-248190020
 Result := TdsMainDrugList.Make(Self, InitialUseCaseData);
//#UC END# *500D3D75005B_47EA0F2B031Carea_impl*
end;//TsdsDrugList.DoGet_dsDrugList

function TsdsDrugList.pm_GetdsDrugListRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsDrugListRef;
end;

function TsdsDrugList.pm_GetDsSynchroView: IdsDrugListSynchroView;
//#UC START# *500D3E3500FF_47EA0F2B031Cget_var*
//#UC END# *500D3E3500FF_47EA0F2B031Cget_var*
begin
 with pm_GetdsSynchroViewRef do
 begin
  if IsEmpty
   //#UC START# *500D3E3500FF_47EA0F2B031Cget_need*
  // - условие создания ViewArea
  //#UC END# *500D3E3500FF_47EA0F2B031Cget_need*
   then
    Referred := DoGet_dsSynchroView;
  Result := IdsDrugListSynchroView(Referred);
 end;//with pm_GetdsSynchroViewRef
end;

function TsdsDrugList.DoGet_dsSynchroView: IdsDrugListSynchroView;
//#UC START# *500D3E3500FF_47EA0F2B031Carea_var*
//#UC END# *500D3E3500FF_47EA0F2B031Carea_var*
begin
//#UC START# *500D3E3500FF_47EA0F2B031Carea_impl*
 Result := TdsDrugListSynchroView.Make(Self);
//#UC END# *500D3E3500FF_47EA0F2B031Carea_impl*
end;//TsdsDrugList.DoGet_dsSynchroView

function TsdsDrugList.pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsSynchroViewRef;
end;

function TsdsDrugList.pm_GetDsFilters: IdsFilters;
//#UC START# *500D3E780156_47EA0F2B031Cget_var*
//#UC END# *500D3E780156_47EA0F2B031Cget_var*
begin
 with pm_GetdsFiltersRef do
 begin
  if IsEmpty
   //#UC START# *500D3E780156_47EA0F2B031Cget_need*
     AND ((afw.Settings.LoadBoolean(pi_List_Sheets_Filters, dv_List_Sheets_Filters) and
          (NeedMake = vcm_nmYes)) or (NeedMake = vcm_nmForce))   
  // - условие создания ViewArea
  //#UC END# *500D3E780156_47EA0F2B031Cget_need*
   then
    Referred := DoGet_dsFilters;
  Result := IdsFilters(Referred);
 end;//with pm_GetdsFiltersRef
end;

function TsdsDrugList.DoGet_dsFilters: IdsFilters;
//#UC START# *500D3E780156_47EA0F2B031Carea_var*
//#UC END# *500D3E780156_47EA0F2B031Carea_var*
begin
//#UC START# *500D3E780156_47EA0F2B031Carea_impl*
 Result := TdsFilters.Make(Self);
//#UC END# *500D3E780156_47EA0F2B031Carea_impl*
end;//TsdsDrugList.DoGet_dsFilters

function TsdsDrugList.pm_GetdsFiltersRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsFiltersRef;
end;

function TsdsDrugList.pm_GetDsListInfo: IdsListInfo;
//#UC START# *500D3EB1023F_47EA0F2B031Cget_var*
//#UC END# *500D3EB1023F_47EA0F2B031Cget_var*
begin
 with pm_GetdsListInfoRef do
 begin
  if IsEmpty
   //#UC START# *500D3EB1023F_47EA0F2B031Cget_need*
   // - условие создания ViewArea
  //#UC END# *500D3EB1023F_47EA0F2B031Cget_need*
   then
    Referred := DoGet_dsListInfo;
  Result := IdsListInfo(Referred);
 end;//with pm_GetdsListInfoRef
end;

function TsdsDrugList.DoGet_dsListInfo: IdsListInfo;
//#UC START# *500D3EB1023F_47EA0F2B031Carea_var*
//#UC END# *500D3EB1023F_47EA0F2B031Carea_var*
begin
//#UC START# *500D3EB1023F_47EA0F2B031Carea_impl*
 Result := TdsListInfo.Make(Self.As_IsdsListNameHolder, bsListCreationHistory(SetData.List));
//#UC END# *500D3EB1023F_47EA0F2B031Carea_impl*
end;//TsdsDrugList.DoGet_dsListInfo

function TsdsDrugList.pm_GetdsListInfoRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsListInfoRef;
end;

function TsdsDrugList.pm_GetShortListName: Il3CString;
//#UC START# *501806DE0323_47EA0F2B031Cget_var*
//#UC END# *501806DE0323_47EA0F2B031Cget_var*
begin
//#UC START# *501806DE0323_47EA0F2B031Cget_impl*
 Result := nil;
//#UC END# *501806DE0323_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetShortListName

function TsdsDrugList.pm_GetListName: Il3CString;
//#UC START# *50180BA801C2_47EA0F2B031Cget_var*
//#UC END# *50180BA801C2_47EA0F2B031Cget_var*
begin
//#UC START# *50180BA801C2_47EA0F2B031Cget_impl*
 Result := nil;
//#UC END# *50180BA801C2_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetListName

procedure TsdsDrugList.OpenDocument;
//#UC START# *5D78745D5001_47EA0F2B031C_var*
//#UC END# *5D78745D5001_47EA0F2B031C_var*
begin
//#UC START# *5D78745D5001_47EA0F2B031C_impl*
 SetData.dsDocumentRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_Document);
//#UC END# *5D78745D5001_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenDocument

procedure TsdsDrugList.OpenDrugInternationalNameSynonims;
//#UC START# *7680D04D575B_47EA0F2B031C_var*
//#UC END# *7680D04D575B_47EA0F2B031C_var*
begin
//#UC START# *7680D04D575B_47EA0F2B031C_impl*
 DoOpenDrugInternationalNameSynonims;
//#UC END# *7680D04D575B_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenDrugInternationalNameSynonims

function TsdsDrugList.pm_GetIsAttributesActive: Boolean;
//#UC START# *7ECE38CEFE6F_47EA0F2B031Cget_var*
//#UC END# *7ECE38CEFE6F_47EA0F2B031Cget_var*
begin
//#UC START# *7ECE38CEFE6F_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Attributes;
//#UC END# *7ECE38CEFE6F_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsAttributesActive

function TsdsDrugList.pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
//#UC START# *862011C4CE04_47EA0F2B031Cget_var*
//#UC END# *862011C4CE04_47EA0F2B031Cget_var*
begin
//#UC START# *862011C4CE04_47EA0F2B031Cget_impl*
 Result := SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_DrugInternationalNameSynonims;
//#UC END# *862011C4CE04_47EA0F2B031Cget_impl*
end;//TsdsDrugList.pm_GetIsDrugInternationalNameSynonimsActive

procedure TsdsDrugList.OpenAttributes;
//#UC START# *ECBE8DB2214F_47EA0F2B031C_var*
//#UC END# *ECBE8DB2214F_47EA0F2B031C_var*
begin
//#UC START# *ECBE8DB2214F_47EA0F2B031C_impl*
 inherited OpenAttributes;
//#UC END# *ECBE8DB2214F_47EA0F2B031C_impl*
end;//TsdsDrugList.OpenAttributes

{$If not defined(NoVCM)}
procedure TsdsDrugList.DataExchange;
//#UC START# *47F37DF001FE_47EA0F2B031C_var*
var
 l_List: IdeList;
//#UC END# *47F37DF001FE_47EA0F2B031C_var*
begin
//#UC START# *47F37DF001FE_47EA0F2B031C_impl*
 l_List := InitialUseCaseData;
  with SetData do
  begin
   List := l_List.List;
   NodeForPositioning := l_List.NodeForPositioning;
  end;//with SetData do
//#UC END# *47F37DF001FE_47EA0F2B031C_impl*
end;//TsdsDrugList.DataExchange
{$IfEnd} //not NoVCM

procedure TsdsDrugList.DoOpenAttributes;
//#UC START# *47FDDACC0101_47EA0F2B031C_var*
//#UC END# *47FDDACC0101_47EA0F2B031C_var*
begin
//#UC START# *47FDDACC0101_47EA0F2B031C_impl*
 SetData.dsAttributesRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_Attributes);
//#UC END# *47FDDACC0101_47EA0F2B031C_impl*
end;//TsdsDrugList.DoOpenAttributes

procedure TsdsDrugList.DoOpenDrugInternationalNameSynonims;
//#UC START# *47FDDD500143_47EA0F2B031C_var*
//#UC END# *47FDDD500143_47EA0F2B031C_var*
begin
//#UC START# *47FDDD500143_47EA0F2B031C_impl*
 SetData.dsDrugInternationalNameSynonimsRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_DrugList_SynchroView_DrugInternationalNameSynonims);
//#UC END# *47FDDD500143_47EA0F2B031C_impl*
end;//TsdsDrugList.DoOpenDrugInternationalNameSynonims

function TsdsDrugList.NeedMakeDSAttributes: Boolean;
//#UC START# *47FE03AE0225_47EA0F2B031C_var*
//#UC END# *47FE03AE0225_47EA0F2B031C_var*
begin
//#UC START# *47FE03AE0225_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Attributes) AND
           inherited NeedMakeDsAttributes;
//#UC END# *47FE03AE0225_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDSAttributes

function TsdsDrugList.NeedMakeDsDrugInternationalNameSynonims: Boolean;
//#UC START# *47FE048E0224_47EA0F2B031C_var*
//#UC END# *47FE048E0224_47EA0F2B031C_var*
begin
//#UC START# *47FE048E0224_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_DrugInternationalNameSynonims) AND
           inherited NeedMakeDsDrugInternationalNameSynonims;
//#UC END# *47FE048E0224_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDsDrugInternationalNameSynonims

procedure TsdsDrugList.ClearAllDS;
//#UC START# *4925B7F00156_47EA0F2B031C_var*
//#UC END# *4925B7F00156_47EA0F2B031C_var*
begin
//#UC START# *4925B7F00156_47EA0F2B031C_impl*
 if (f_dsBaloonWarning <> nil) then
  f_dsBaloonWarning.Referred := nil;
 inherited; 
//#UC END# *4925B7F00156_47EA0F2B031C_impl*
end;//TsdsDrugList.ClearAllDS

{$If not defined(NoVCM)}
procedure TsdsDrugList.ClearAreas;
 {-}
begin
 if (f_dsBaloonWarning <> nil) then f_dsBaloonWarning.Referred := nil;
 pm_GetdsDrugListRef.Referred := nil;
 pm_GetdsSynchroViewRef.Referred := nil;
 pm_GetdsFiltersRef.Referred := nil;
 pm_GetdsListInfoRef.Referred := nil;
 inherited;
end;//TsdsDrugList.ClearAreas
{$IfEnd} //not NoVCM

function TsdsDrugList.NeedMakeDocument: Boolean;
//#UC START# *493D1BE601B1_47EA0F2B031C_var*
//#UC END# *493D1BE601B1_47EA0F2B031C_var*
begin
//#UC START# *493D1BE601B1_47EA0F2B031C_impl*
 Result := (SetData.DrugList_SynchroView_Form = sva_DrugList_SynchroView_Document) AND
           inherited NeedMakeDocument;
//#UC END# *493D1BE601B1_47EA0F2B031C_impl*
end;//TsdsDrugList.NeedMakeDocument

{$If not defined(NoVCM)}
function TsdsDrugList.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_47EA0F2B031C_var*
//#UC END# *53B3BF9C00EF_47EA0F2B031C_var*
begin
//#UC START# *53B3BF9C00EF_47EA0F2B031C_impl*
 Result := nsTabIconIndex(titList);
//#UC END# *53B3BF9C00EF_47EA0F2B031C_impl*
end;//TsdsDrugList.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

// Методы преобразования к реализуемым интерфейсам

function TsdsDrugList.As_IucpFilters: IucpFilters;
begin
 Result := Self;
end;

function TsdsDrugList.As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
begin
 Result := Self;
end;

function TsdsDrugList.As_InsWarningGenerator: InsWarningGenerator;
begin
 Result := Self;
end;

function TsdsDrugList.As_IsdsListPrim: IsdsListPrim;
begin
 Result := Self;
end;

function TsdsDrugList.As_IsdsListNameHolder: IsdsListNameHolder;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.