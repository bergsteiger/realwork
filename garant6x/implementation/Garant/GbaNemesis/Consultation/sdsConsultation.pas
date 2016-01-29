unit sdsConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/sdsConsultation.pas"
// Начат: 2006/04/07 08:16:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TsdsConsultation
//
// Бизнес объект прецедента "Консультация"
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
  ConsultationDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  DocumentAndListInterfaces {a},
  l3IID,
  DocumentUnit,
  DocumentInterfaces,
  bsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = IbsConsultation;
 _SetType_ = IsdsConsultation;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsConsultation = {ucc} class(_vcmFormSetDataSourceWithoutData_, IsdsConsultation, IsdsGotoPointDataMaker {from IsdsConsultation})
  {* Бизнес объект прецедента "Консультация" }
 private
 // private fields
   f_IsListChanged : Boolean;
   f_NeedMark : Boolean;
   f_Consultation : IbsConsultation;
    {* Поле для свойства Consultation}
   f_dsConsultation : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsConsultation}
   f_dsList : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsList}
   f_DSConsultationMark : IvcmViewAreaControllerRef;
    {* Поле для области вывода DSConsultationMark}
 protected
 // realized methods
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
     {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
           новой сборки вернуться как результат для вызова операции модуля }
   function pm_GetDsConsultation: IdsConsultation;
   function DoGet_dsConsultation: IdsConsultation;
   function pm_GetDsList: IdsDocumentList;
   function DoGet_dsList: IdsDocumentList;
   function pm_GetDSConsultationMark(aForce: Boolean): IdsConsultationMark;
   function DoGet_DSConsultationMark(aForce: Boolean): IdsConsultationMark;
   procedure GiveMark; // can raise EbsConsultationAlreadyMark, EbsConsultationWasDeleted
     {* дать оценку.
           Возможные исключения:
           - EbsConsultationAlreadyMark }
   function NeedGiveMark: Boolean;
   procedure ConfirmPayment(anAccept: Boolean); // can raise EbsPaymentForbidden, EbsConsultationWasDeleted, EbsConsultationAlreadyConfirmed
     {* Подтвердить оплату консультации. Да/Нет;
           Исключения:
             - EbsPaymentForbidden }
   procedure UpdateAnswer;
     {* перечитать ответ }
   procedure ListChanged;
     {* список документов консультации изменен пользователем. Используется
           при перезагрузке консультации }
   procedure ConsultationWasMarked(const aConsultation: IsdsConsultation);
     {* консультация была оценена. Для случая когда консультацию оценили в
           дереве, при этом эта же консультация открыта на экране и ее нужно
           перечитать, чтобы ссылка оценить пропала }
   procedure MarkSended;
   function Get_BsConsultation: IbsConsultation;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected properties
   property Consultation: IbsConsultation
     read f_Consultation;
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
 end;//TsdsConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsConsultation,
  deDocInfo,
  dsConsultationMark,
  dsConsultationList,
  deDocumentList,
  DynamicDocListUnit,
  bsTypes,
  ConsultingUnit,
  bsConsultationManager,
  l3Base,
  SysUtils,
  bsUtils,
  DebugStr
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsConsultation;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

// start class TsdsConsultation

function TsdsConsultation.MakeGotoPointData(const aDocument: IDocument;
  aRefType: TDocumentPositionType;
  aPos: Longword): IdeDocInfo;
//#UC START# *492597A602F6_49228CA903BA_var*
//#UC END# *492597A602F6_49228CA903BA_var*
begin
//#UC START# *492597A602F6_49228CA903BA_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aRefType, aPos));
//#UC END# *492597A602F6_49228CA903BA_impl*
end;//TsdsConsultation.MakeGotoPointData

function TsdsConsultation.pm_GetDsConsultation: IdsConsultation;
//#UC START# *492EB71000D6_49228CA903BAget_var*
//#UC END# *492EB71000D6_49228CA903BAget_var*
begin
 if (f_dsConsultation = nil) then
 begin
  f_dsConsultation := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EB71000D6_49228CA903BAget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EB71000D6_49228CA903BAget_init*
 end;//f_dsConsultation = nil
 if f_dsConsultation.IsEmpty
  //#UC START# *492EB71000D6_49228CA903BAget_need*
  // - условие создания ViewArea
  //#UC END# *492EB71000D6_49228CA903BAget_need*
  then
   f_dsConsultation.Referred := DoGet_dsConsultation;
 Result := IdsConsultation(f_dsConsultation.Referred);
end;

function TsdsConsultation.DoGet_dsConsultation: IdsConsultation;
//#UC START# *492EB71000D6_49228CA903BAarea_var*
const
 cAnswer = 65534; 
//#UC END# *492EB71000D6_49228CA903BAarea_var*
begin
//#UC START# *492EB71000D6_49228CA903BAarea_impl*
 Assert(Assigned(Consultation.Text));
 Result := TdsConsultation.Make(Self,
                                TdeDocInfo.Make(Consultation.Text,
                                                TbsDocPos_S(cAnswer)));
//#UC END# *492EB71000D6_49228CA903BAarea_impl*
end;//TsdsConsultation.DoGet_dsConsultation

function TsdsConsultation.pm_GetDsList: IdsDocumentList;
//#UC START# *492EB77C0125_49228CA903BAget_var*
//#UC END# *492EB77C0125_49228CA903BAget_var*
begin
 if (f_dsList = nil) then
 begin
  f_dsList := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EB77C0125_49228CA903BAget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EB77C0125_49228CA903BAget_init*
 end;//f_dsList = nil
 if f_dsList.IsEmpty
  //#UC START# *492EB77C0125_49228CA903BAget_need*
  // - условие создания ViewArea
  //#UC END# *492EB77C0125_49228CA903BAget_need*
  then
   f_dsList.Referred := DoGet_dsList;
 Result := IdsDocumentList(f_dsList.Referred);
end;

function TsdsConsultation.DoGet_dsList: IdsDocumentList;
//#UC START# *492EB77C0125_49228CA903BAarea_var*
var
 l_List: IDynList;
//#UC END# *492EB77C0125_49228CA903BAarea_var*
begin
//#UC START# *492EB77C0125_49228CA903BAarea_impl*
 Result := nil;
 if Assigned(Consultation) and
  not (Consultation.Status * c_bsConsultationsWithoutList <> []) then
 begin
  l_List := nil;
  try
   Consultation.Data.GetDocumentList(l_List);
  except
   on ENoDocumentList do ;
   on EOldFormatConsultation do ;
  end;{try..except}
  if Assigned(l_List) then
   Result := TdsConsultationList.Make(Self, TdeDocumentList.Make(l_List));
 end;//if Assigned(Consultation)...
//#UC END# *492EB77C0125_49228CA903BAarea_impl*
end;//TsdsConsultation.DoGet_dsList

function TsdsConsultation.pm_GetDSConsultationMark(aForce: Boolean): IdsConsultationMark;
//#UC START# *492EB793009E_49228CA903BAget_var*
//#UC END# *492EB793009E_49228CA903BAget_var*
begin
 if (f_DSConsultationMark = nil) then
 begin
  f_DSConsultationMark := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EB793009E_49228CA903BAget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EB793009E_49228CA903BAget_init*
 end;//f_DSConsultationMark = nil
 if (f_DSConsultationMark.NeedMake = vcm_nmNo) and aForce then
  f_DSConsultationMark.NeedMake := vcm_nmYes;
 if f_DSConsultationMark.IsEmpty
  //#UC START# *492EB793009E_49228CA903BAget_need*
    and (f_DSConsultationMark.NeedMake <> vcm_nmNo)
  // - условие создания ViewArea
  //#UC END# *492EB793009E_49228CA903BAget_need*
  then
   f_DSConsultationMark.Referred := DoGet_DSConsultationMark(aForce);
 Result := IdsConsultationMark(f_DSConsultationMark.Referred);
end;

function TsdsConsultation.DoGet_DSConsultationMark(aForce: Boolean): IdsConsultationMark;
//#UC START# *492EB793009E_49228CA903BAarea_var*
//#UC END# *492EB793009E_49228CA903BAarea_var*
begin
//#UC START# *492EB793009E_49228CA903BAarea_impl*
 Result := TdsConsultationMark.Make(Self);
//#UC END# *492EB793009E_49228CA903BAarea_impl*
end;//TsdsConsultation.DoGet_DSConsultationMark

procedure TsdsConsultation.GiveMark; // can raise EbsConsultationAlreadyMark, EbsConsultationWasDeleted
//#UC START# *492EB7BA035E_49228CA903BA_var*
//#UC END# *492EB7BA035E_49228CA903BA_var*
begin
//#UC START# *492EB7BA035E_49228CA903BA_impl*
 // Консультация была удалена:
 if Consultation.WasDeleted then
  raise EbsConsultationWasDeleted.Create('')
 else
  // Консультация уже была оценена:
  if bs_csEstimationSent in Consultation.Status then
   raise EbsConsultationAlreadyMark.Create('');
 f_DSConsultationMark.NeedMake := vcm_nmForce;
 Refresh;
//#UC END# *492EB7BA035E_49228CA903BA_impl*
end;//TsdsConsultation.GiveMark

function TsdsConsultation.NeedGiveMark: Boolean;
//#UC START# *492EB82F0391_49228CA903BA_var*
//#UC END# *492EB82F0391_49228CA903BA_var*
begin
//#UC START# *492EB82F0391_49228CA903BA_impl*
 with Consultation do
  Result := (f_NeedMark and not (bs_csEstimationSent in Status)) and not WasDeleted;
//#UC END# *492EB82F0391_49228CA903BA_impl*
end;//TsdsConsultation.NeedGiveMark

procedure TsdsConsultation.ConfirmPayment(anAccept: Boolean); // can raise EbsPaymentForbidden, EbsConsultationWasDeleted, EbsConsultationAlreadyConfirmed
//#UC START# *492EB8620306_49228CA903BA_var*
//#UC END# *492EB8620306_49228CA903BA_var*
begin
//#UC START# *492EB8620306_49228CA903BA_impl*
 if Consultation.WasDeleted then
  raise EbsConsultationWasDeleted.Create('')
 else
  if not (bs_csPaymentRequest in Consultation.Status) then
   raise EbsConsultationAlreadyConfirmed.Create('');
 try
  Consultation.Data.PaymentConfirm(anAccept);
 except
  on EPaymentForbidden do
   raise EbsPaymentForbidden.Create('');
 end;//try..except
 // Уберем предупреждение, если все прочитаны и подтверждены:
 if IsConsultationManagerAssigned then
  g_ConsultationManager.UnreadChanged;
 // После подтверждения, уведомление нужно перечитать, фильтруются гиперссылки:
 UpdateAnswer;
//#UC END# *492EB8620306_49228CA903BA_impl*
end;//TsdsConsultation.ConfirmPayment

procedure TsdsConsultation.UpdateAnswer;
//#UC START# *492EB8820218_49228CA903BA_var*
//#UC END# *492EB8820218_49228CA903BA_var*
begin
//#UC START# *492EB8820218_49228CA903BA_impl*
 if Assigned(f_dsConsultation) then
  f_dsConsultation.Clear;
 if Consultation <> nil then
  Consultation.RefreshText;
 Refresh;
//#UC END# *492EB8820218_49228CA903BA_impl*
end;//TsdsConsultation.UpdateAnswer

procedure TsdsConsultation.ListChanged;
//#UC START# *492EB91F0391_49228CA903BA_var*
//#UC END# *492EB91F0391_49228CA903BA_var*
begin
//#UC START# *492EB91F0391_49228CA903BA_impl*
 f_IsListChanged := True;
//#UC END# *492EB91F0391_49228CA903BA_impl*
end;//TsdsConsultation.ListChanged

procedure TsdsConsultation.ConsultationWasMarked(const aConsultation: IsdsConsultation);
//#UC START# *492EB93700FF_49228CA903BA_var*
var
 l_Consultation: IbsConsultation;
//#UC END# *492EB93700FF_49228CA903BA_var*
begin
//#UC START# *492EB93700FF_49228CA903BA_impl*
 l_Consultation := aConsultation.bsConsultation;
 if (l_Consultation <> nil) then
 try
  if bsIsSame(l_Consultation.Data, Consultation.Data) and
     (bs_csEstimationSent in l_Consultation.Status) then
   MarkSended;
 finally
  l_Consultation := nil;
 end;//try..finally
//#UC END# *492EB93700FF_49228CA903BA_impl*
end;//TsdsConsultation.ConsultationWasMarked

procedure TsdsConsultation.MarkSended;
//#UC START# *492EBCE002E0_49228CA903BA_var*
//#UC END# *492EBCE002E0_49228CA903BA_var*
begin
//#UC START# *492EBCE002E0_49228CA903BA_impl*
 f_NeedMark := False;
 UpdateAnswer;
//#UC END# *492EBCE002E0_49228CA903BA_impl*
end;//TsdsConsultation.MarkSended

function TsdsConsultation.Get_BsConsultation: IbsConsultation;
//#UC START# *4F4E1E06038E_49228CA903BAget_var*
//#UC END# *4F4E1E06038E_49228CA903BAget_var*
begin
//#UC START# *4F4E1E06038E_49228CA903BAget_impl*
 Result := Self.Consultation;
//#UC END# *4F4E1E06038E_49228CA903BAget_impl*
end;//TsdsConsultation.Get_BsConsultation

procedure TsdsConsultation.Cleanup;
//#UC START# *479731C50290_49228CA903BA_var*
//#UC END# *479731C50290_49228CA903BA_var*
begin
//#UC START# *479731C50290_49228CA903BA_impl*
 f_Consultation := nil;
 inherited;
//#UC END# *479731C50290_49228CA903BA_impl*
end;//TsdsConsultation.Cleanup

procedure TsdsConsultation.InitFields;
//#UC START# *47A042E100E2_49228CA903BA_var*
//#UC END# *47A042E100E2_49228CA903BA_var*
begin
//#UC START# *47A042E100E2_49228CA903BA_impl*
 inherited;
 f_IsListChanged := False;
//#UC END# *47A042E100E2_49228CA903BA_impl*
end;//TsdsConsultation.InitFields

{$If not defined(NoVCM)}
procedure TsdsConsultation.DataExchange;
//#UC START# *47F37DF001FE_49228CA903BA_var*
//#UC END# *47F37DF001FE_49228CA903BA_var*
begin
//#UC START# *47F37DF001FE_49228CA903BA_impl*
 f_Consultation := InitialUseCaseData;
 Assert(f_Consultation <> nil);
  Assert(Assigned(Consultation.Data), caConsultationNotReceived);
  if Consultation.Status * c_bsSetReadStatusForConsultations <> [] then
  begin
   with Consultation do
   begin
    IsStatusChached := False;
    try
     Data.Read;
      // - установим статус консультация прочитана;
    finally
     IsStatusChached := True;
    end;//try..finally
   end;//with Consultation do
   if IsConsultationManagerAssigned then
    g_ConsultationManager.UnreadChanged;
  end;//if Consultation.Status * c_bsSetReadStatusForConsultations <> [] then
  f_NeedMark := Consultation.Status * c_bsNeedMarkForConsultations <> [];
//#UC END# *47F37DF001FE_49228CA903BA_impl*
end;//TsdsConsultation.DataExchange
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsConsultation.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_49228CA903BA_var*
var
 l_Consultation   : IbsConsultation;
 l_dsConsultation : IdsConsultation;
//#UC END# *491B02D80112_49228CA903BA_var*
begin
//#UC START# *491B02D80112_49228CA903BA_impl*
 Result := false;
 if not f_IsListChanged then
 begin
   // - если список консультации меняли, то перезагружаемся, даже если
   //   открывают ту же консультацию;
  l_Consultation := aDataSource.bsConsultation;
  if (l_Consultation <> nil) then
   Result := bsIsSame(l_Consultation.Data, Consultation.Data);
             // - идентификаторы консультаций совпадают;
 end;//not f_IsListChanged
 if Result then
 begin
  l_dsConsultation := Self.pm_GetDsConsultation;
  Result := (l_dsConsultation <> nil) and
            (l_Consultation.Status = l_dsConsultation.ShowingStatus);
            // - статус консультации не поменялся;
 end;//Result
//#UC END# *491B02D80112_49228CA903BA_impl*
end;//TsdsConsultation.GetIsNeedChangePosition
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TsdsConsultation.ClearAreas;
 {-}
begin
 if (f_dsConsultation <> nil) then f_dsConsultation.Referred := nil;
 if (f_dsList <> nil) then f_dsList.Referred := nil;
 if (f_DSConsultationMark <> nil) then f_DSConsultationMark.Referred := nil;
 inherited;
end;//TsdsConsultation.ClearAreas
{$IfEnd} //not NoVCM

function TsdsConsultation.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_49228CA903BA_var*
//#UC END# *4A60B23E00C3_49228CA903BA_var*
begin
//#UC START# *4A60B23E00C3_49228CA903BA_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IbsConsultation) then
  begin
   Assert(false, 'Не пользуйтесь запросом IbsConsultation у IsdsConsultation, через Supports. Пользуйтесь атрибутом bsConsultation на IsdsConsultation');
   IbsConsultation(Obj) := Consultation;
   Result.SetOK;
  end;//IID.EQ(IbsConsultation)
//#UC END# *4A60B23E00C3_49228CA903BA_impl*
end;//TsdsConsultation.COMQueryInterface

procedure TsdsConsultation.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Consultation := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsConsultation := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsList := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_DSConsultationMark := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TsdsConsultation.ClearFields

// Методы преобразования к реализуемым интерфейсам

function TsdsConsultation.As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.