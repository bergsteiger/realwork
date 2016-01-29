unit dsConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsConsultation.pas"
// Начат: 06.04.2006 17.27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TdsConsultation
//
// БОС запроса на консультацию
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
  bsTypes,
  ConsultationDomainInterfaces,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  WorkWithListInterfaces,
  nsDocumentLikeStateHolder
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3NotifyPtrList,
  UnderControlUnit,
  UnderControlInterfaces,
  DocumentUnit,
  bsTypesNew,
  FoldersDomainInterfaces,
  vcmControllers {a},
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsConsultation;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsConsultation = {vac} class(_dsBaseDocumentPrim_, IdsConsultation)
  {* БОС запроса на консультацию }
 private
 // private fields
   f_ShowingStatus : TbsConsultationStatuses;
   ucc_Consultation : IsdsConsultation;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function pm_GetShowingStatus: TbsConsultationStatuses;
 protected
 // overridden protected methods
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  SysUtils,
  ConsultingUnit,
  nsConsultationDocumentContainerNew,
  IOUnit,
  bsUtils,
  BaseTypesUnit,
  bsConvert,
  l3Utils,
  deDocInfo,
  nsTypes,
  nsDocInfoHAFMacroReplacer
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsFolderFilterInfo,
  l3InterfacesMisc,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsConsultation;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

// start class TdsConsultation

function TdsConsultation.pm_GetShowingStatus: TbsConsultationStatuses;
//#UC START# *491C3FAA009D_491C3E97009Fget_var*
//#UC END# *491C3FAA009D_491C3E97009Fget_var*
begin
//#UC START# *491C3FAA009D_491C3E97009Fget_impl*
 Result := f_ShowingStatus;
//#UC END# *491C3FAA009D_491C3E97009Fget_impl*
end;//TdsConsultation.pm_GetShowingStatus

procedure TdsConsultation.InitFields;
//#UC START# *47A042E100E2_491C3E97009F_var*
//#UC END# *47A042E100E2_491C3E97009F_var*
begin
//#UC START# *47A042E100E2_491C3E97009F_impl*
 inherited;
 f_ShowingStatus := ucc_Consultation.bsConsultation.Status;
//#UC END# *47A042E100E2_491C3E97009F_impl*
end;//TdsConsultation.InitFields

function TdsConsultation.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_491C3E97009F_var*
//#UC END# *4A60B23E00C3_491C3E97009F_var*
begin
//#UC START# *4A60B23E00C3_491C3E97009F_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and (ucc_Consultation.bsConsultation <> nil) then
  if IID.EQ(IConsultation) then
  begin
   Assert(false, 'Ну и кому такой запрос IConsultation понадобился? Пользуйтесь ucc_Consultation.bsConsultation.Data');
   IConsultation(Obj) := ucc_Consultation.bsConsultation.Data;
   if (IConsultation(Obj) <> nil) then
    Result.SetOk;
  end;//IID.EQ(IConsultation)
//#UC END# *4A60B23E00C3_491C3E97009F_impl*
end;//TdsConsultation.COMQueryInterface

function TdsConsultation.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491C3E97009F_var*
//#UC END# *4C6AB38800F3_491C3E97009F_var*
begin
//#UC START# *4C6AB38800F3_491C3E97009F_impl*
(* if (Consultation.Status * c_bsShowQueryForConsultations <> []) then
  Result := inherited MakeContainer
 else*)
  Result := TnsConsultationDocumentContainerNew.Make(DocInfo, ucc_Consultation.bsConsultation.Data);
//#UC END# *4C6AB38800F3_491C3E97009F_impl*
end;//TdsConsultation.MakeContainer

procedure TdsConsultation.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsConsultation, ucc_Consultation);
end;

procedure TdsConsultation.ClearRefs;
begin
 inherited;
 ucc_Consultation := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.