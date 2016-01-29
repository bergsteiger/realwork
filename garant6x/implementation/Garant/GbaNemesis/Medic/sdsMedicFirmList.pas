unit sdsMedicFirmList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/sdsMedicFirmList.pas"
// Начат: 2008/03/31 08:40:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TsdsMedicFirmList
//
// Бизнес объект прецедента список медицинских фирм-производителей
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
  PreviewInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdMedicFirmList;
 _SetType_ = IsdsMedicFirmList;
 {$Include ..\Medic\sdsMedicFirmDocument.imp.pas}
 TsdsMedicFirmList = {ucc} class(_sdsMedicFirmDocument_, IsdsMedicFirmList)
  {* Бизнес объект прецедента список медицинских фирм-производителей }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   function pm_GetDsFirmList: IdsMedicFirmList;
   function DoGet_dsFirmList: IdsMedicFirmList;
   function pm_GetdsFirmListRef: IvcmViewAreaControllerRef;
   function pm_GetDsSynchroView: IdsMedicFirmListSynchroView;
   function DoGet_dsSynchroView: IdsMedicFirmListSynchroView;
   function pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
   procedure OpenAttributes;
     {* Открывает ViewArea "атрибуты документа" }
   function pm_GetIsAttributesActive: Boolean;
   function pm_GetIsDocumentActive: Boolean;
   procedure OpenDrugList;
     {* Открывает ViewArea "список производимых препаратов" }
   function pm_GetIsDrugListActive: Boolean;
   procedure OpenDocument;
     {* Открывает ViewArea "Собственно документ" }
 protected
 // overridden protected methods
   procedure DoOpenAttributes; override;
     {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; override;
     {* - необходимость создания БОФ атрибутов. }
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function NeedMakeDrugList: Boolean; override;
   function NeedMakeDocument: Boolean; override;
     {* Определяет - нужно ли создавать область ввода для документа }
    {$If not defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure ChangeSynchroForm(aSynchroForm: TMedicFirmList_SynchroView_Areas);
     {* Переключает форму синхронного просмотра }
 end;//TsdsMedicFirmList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  dMedicFirmList,
  dsMedicFirmList,
  dsMedicFirmSynchroView,
  dsMedicFirmDocument,
  dsDrugList,
  afwFacade,
  BaseTypesUnit,
  deList,
  bsUtils,
  dsAttributes,
  l3Types,
  l3Utils,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsMedicFirmList;

{$Include ..\Medic\sdsMedicFirmDocument.imp.pas}

// start class TsdsMedicFirmList

procedure TsdsMedicFirmList.ChangeSynchroForm(aSynchroForm: TMedicFirmList_SynchroView_Areas);
//#UC START# *2D720EE59BD5_493A658D0181_var*
//#UC END# *2D720EE59BD5_493A658D0181_var*
begin
//#UC START# *2D720EE59BD5_493A658D0181_impl*
 if (aSynchroForm <> SetData.MedicFirmList_SynchroView_Form) then
 begin
  ClearAllDS;
  SetData.MedicFirmList_SynchroView_Form := aSynchroForm;
  Refresh;
 end;//aSynchroForm <> SetData.MedicFirmList_SynchroView_Form
//#UC END# *2D720EE59BD5_493A658D0181_impl*
end;//TsdsMedicFirmList.ChangeSynchroForm

{$If not defined(NoVCM)}
function TsdsMedicFirmList.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_493A658D0181_var*
//#UC END# *47F3778403D9_493A658D0181_var*
begin
//#UC START# *47F3778403D9_493A658D0181_impl*
 Result := TdMedicFirmList.Make;
 Result.dsFirmListRef.NeedMake := vcm_nmYes;
 Result.dsSynchroViewRef.NeedMake := vcm_nmYes;
//#UC END# *47F3778403D9_493A658D0181_impl*
end;//TsdsMedicFirmList.MakeData
{$IfEnd} //not NoVCM

function TsdsMedicFirmList.pm_GetDsFirmList: IdsMedicFirmList;
//#UC START# *500D3DC401D9_493A658D0181get_var*
//#UC END# *500D3DC401D9_493A658D0181get_var*
begin
 with pm_GetdsFirmListRef do
 begin
  if IsEmpty
   //#UC START# *500D3DC401D9_493A658D0181get_need*
     AND (NeedMake <> vcm_nmNo)   
  // - условие создания ViewArea
  //#UC END# *500D3DC401D9_493A658D0181get_need*
   then
    Referred := DoGet_dsFirmList;
  Result := IdsMedicFirmList(Referred);
 end;//with pm_GetdsFirmListRef
end;

function TsdsMedicFirmList.DoGet_dsFirmList: IdsMedicFirmList;
//#UC START# *500D3DC401D9_493A658D0181area_var*
var
 l_deMedicFirmList: IdeMedicFirmList;
//#UC END# *500D3DC401D9_493A658D0181area_var*
begin
//#UC START# *500D3DC401D9_493A658D0181area_impl*
 l_deMedicFirmList := nil;
 Supports(InitialUseCaseData, IdeMedicFirmList, l_deMedicFirmList);
 Result := TdsMedicFirmList.Make(Self, l_deMedicFirmList);
//#UC END# *500D3DC401D9_493A658D0181area_impl*
end;//TsdsMedicFirmList.DoGet_dsFirmList

function TsdsMedicFirmList.pm_GetdsFirmListRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsFirmListRef;
end;

function TsdsMedicFirmList.pm_GetDsSynchroView: IdsMedicFirmListSynchroView;
//#UC START# *500D3E05033F_493A658D0181get_var*
//#UC END# *500D3E05033F_493A658D0181get_var*
begin
 with pm_GetdsSynchroViewRef do
 begin
  if IsEmpty
   //#UC START# *500D3E05033F_493A658D0181get_need*
  // - условие создания ViewArea
  //#UC END# *500D3E05033F_493A658D0181get_need*
   then
    Referred := DoGet_dsSynchroView;
  Result := IdsMedicFirmListSynchroView(Referred);
 end;//with pm_GetdsSynchroViewRef
end;

function TsdsMedicFirmList.DoGet_dsSynchroView: IdsMedicFirmListSynchroView;
//#UC START# *500D3E05033F_493A658D0181area_var*
//#UC END# *500D3E05033F_493A658D0181area_var*
begin
//#UC START# *500D3E05033F_493A658D0181area_impl*
 Result := TdsMedicFirmSynchroView.Make(Self);
//#UC END# *500D3E05033F_493A658D0181area_impl*
end;//TsdsMedicFirmList.DoGet_dsSynchroView

function TsdsMedicFirmList.pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsSynchroViewRef;
end;

procedure TsdsMedicFirmList.OpenAttributes;
//#UC START# *547039B70620_493A658D0181_var*
//#UC END# *547039B70620_493A658D0181_var*
begin
//#UC START# *547039B70620_493A658D0181_impl*
 inherited OpenAttributes;
//#UC END# *547039B70620_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenAttributes

function TsdsMedicFirmList.pm_GetIsAttributesActive: Boolean;
//#UC START# *5D132F53CBB1_493A658D0181get_var*
//#UC END# *5D132F53CBB1_493A658D0181get_var*
begin
//#UC START# *5D132F53CBB1_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Attributes;
//#UC END# *5D132F53CBB1_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsAttributesActive

function TsdsMedicFirmList.pm_GetIsDocumentActive: Boolean;
//#UC START# *A5A4F8CABF20_493A658D0181get_var*
//#UC END# *A5A4F8CABF20_493A658D0181get_var*
begin
//#UC START# *A5A4F8CABF20_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Document;
//#UC END# *A5A4F8CABF20_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsDocumentActive

procedure TsdsMedicFirmList.OpenDrugList;
//#UC START# *BF9026B194BB_493A658D0181_var*
//#UC END# *BF9026B194BB_493A658D0181_var*
begin
//#UC START# *BF9026B194BB_493A658D0181_impl*
 SetData.dsDrugListRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_DrugList);
//#UC END# *BF9026B194BB_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenDrugList

function TsdsMedicFirmList.pm_GetIsDrugListActive: Boolean;
//#UC START# *C88FE4927F04_493A658D0181get_var*
//#UC END# *C88FE4927F04_493A658D0181get_var*
begin
//#UC START# *C88FE4927F04_493A658D0181get_impl*
 Result := SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_DrugList;
//#UC END# *C88FE4927F04_493A658D0181get_impl*
end;//TsdsMedicFirmList.pm_GetIsDrugListActive

procedure TsdsMedicFirmList.OpenDocument;
//#UC START# *E0B72D4BE61F_493A658D0181_var*
//#UC END# *E0B72D4BE61F_493A658D0181_var*
begin
//#UC START# *E0B72D4BE61F_493A658D0181_impl*
 SetData.dsDocumentRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_Document);
//#UC END# *E0B72D4BE61F_493A658D0181_impl*
end;//TsdsMedicFirmList.OpenDocument

procedure TsdsMedicFirmList.DoOpenAttributes;
//#UC START# *47FDDACC0101_493A658D0181_var*
//#UC END# *47FDDACC0101_493A658D0181_var*
begin
//#UC START# *47FDDACC0101_493A658D0181_impl*
 SetData.dsAttributesRef.SetIfNeedMakeNo(vcm_nmForce);
 ChangeSynchroForm(sva_MedicFirmList_SynchroView_Attributes);
//#UC END# *47FDDACC0101_493A658D0181_impl*
end;//TsdsMedicFirmList.DoOpenAttributes

function TsdsMedicFirmList.NeedMakeDSAttributes: Boolean;
//#UC START# *47FE03AE0225_493A658D0181_var*
//#UC END# *47FE03AE0225_493A658D0181_var*
begin
//#UC START# *47FE03AE0225_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Attributes) AND
           inherited NeedMakeDSAttributes;
//#UC END# *47FE03AE0225_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDSAttributes

{$If not defined(NoVCM)}
procedure TsdsMedicFirmList.ClearAreas;
 {-}
begin
 pm_GetdsFirmListRef.Referred := nil;
 pm_GetdsSynchroViewRef.Referred := nil;
 inherited;
end;//TsdsMedicFirmList.ClearAreas
{$IfEnd} //not NoVCM

function TsdsMedicFirmList.NeedMakeDrugList: Boolean;
//#UC START# *493964C6039A_493A658D0181_var*
//#UC END# *493964C6039A_493A658D0181_var*
begin
//#UC START# *493964C6039A_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_DrugList) and
           inherited NeedMakeDrugList;
//#UC END# *493964C6039A_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDrugList

function TsdsMedicFirmList.NeedMakeDocument: Boolean;
//#UC START# *493D1BE601B1_493A658D0181_var*
//#UC END# *493D1BE601B1_493A658D0181_var*
begin
//#UC START# *493D1BE601B1_493A658D0181_impl*
 Result := (SetData.MedicFirmList_SynchroView_Form = sva_MedicFirmList_SynchroView_Document) AND
           inherited NeedMakeDocument;
//#UC END# *493D1BE601B1_493A658D0181_impl*
end;//TsdsMedicFirmList.NeedMakeDocument

{$If not defined(NoVCM)}
function TsdsMedicFirmList.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_493A658D0181_var*
//#UC END# *55C1DD070354_493A658D0181_var*
begin
//#UC START# *55C1DD070354_493A658D0181_impl*
 Result := pm_GetDsFirmList.MakeNewDocInfo;
//#UC END# *55C1DD070354_493A658D0181_impl*
end;//TsdsMedicFirmList.GetDataForClone
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.