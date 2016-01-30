unit bsConsultation;
 {* Бизнес объект прецедента "Консультация" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\bsConsultation.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , ConsultationDomainInterfaces
 , l3Types
 , bsTypes
 , ConsultingUnit
 , DocumentUnit
 , l3Interfaces
;

type
 TbsConsultation = class(Tl3SimpleObject, IbsConsultation)
  {* Бизнес объект прецедента "Консультация" }
  private
   f_IsRefusedOldFormat: Tl3Bool;
    {* отклоненная консультация старого формата }
   f_IsStatusChached: Boolean;
   f_Text: IDocument;
   f_CachedStatuses: TbsConsultationStatuses;
    {* Поле для свойства CachedStatuses }
   f_Consultation: IConsultation;
    {* Поле для свойства Consultation }
  protected
   procedure RefreshText;
    {* обновить текст. Необхоидимо при изменении состояния консультации }
   function pm_GetStatus: TbsConsultationStatuses;
   function pm_GetIsStatusChached: Boolean;
   procedure pm_SetIsStatusChached(aValue: Boolean);
   function pm_GetData: IConsultation;
   function pm_GetWasDeleted: Boolean;
   function pm_GetId: Il3CString;
   function pm_GetWasCreated: SysDateTime;
   function pm_GetWasModified: SysDateTime;
   function pm_GetCaption: Il3CString;
   function pm_GetText: IDocument;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aConsultation: IConsultation); reintroduce;
   class function Make(const aConsultation: IConsultation): IbsConsultation; reintroduce;
  protected
   property CachedStatuses: TbsConsultationStatuses
    read f_CachedStatuses
    write f_CachedStatuses;
    {* кешированный статус, на время открытия консультации }
   property Consultation: IConsultation
    read f_Consultation
    write f_Consultation;
 end;//TbsConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , IOUnit
 , BaseTypesUnit
 , bsConvert
 , nsTypes
 , bsUtils
;

constructor TbsConsultation.Create(const aConsultation: IConsultation);
//#UC START# *498FFACA0046_49228BA50210_var*
//#UC END# *498FFACA0046_49228BA50210_var*
begin
//#UC START# *498FFACA0046_49228BA50210_impl*
 inherited Create;
 Consultation := aConsultation;
 f_IsRefusedOldFormat := l3_bUnknown;
//#UC END# *498FFACA0046_49228BA50210_impl*
end;//TbsConsultation.Create

class function TbsConsultation.Make(const aConsultation: IConsultation): IbsConsultation;
var
 l_Inst : TbsConsultation;
begin
 l_Inst := Create(aConsultation);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsConsultation.Make

procedure TbsConsultation.RefreshText;
 {* обновить текст. Необхоидимо при изменении состояния консультации }
//#UC START# *491C42400193_49228BA50210_var*
//#UC END# *491C42400193_49228BA50210_var*
begin
//#UC START# *491C42400193_49228BA50210_impl*
 f_Text := nil;
//#UC END# *491C42400193_49228BA50210_impl*
end;//TbsConsultation.RefreshText

function TbsConsultation.pm_GetStatus: TbsConsultationStatuses;
//#UC START# *491C424C019F_49228BA50210get_var*

  procedure lp_IsPaymentRefusalOldFormat;
  var
   l_Answer: IDocument;
  begin
   if bs_csPaymentRefusal in Result then
   begin
    if f_IsRefusedOldFormat = l3_bUnknown then
    try
     Consultation.GetAnswer(l_Answer);
     f_IsRefusedOldFormat := l3_bFalse;
    except
     on EOldFormatConsultation do
      f_IsRefusedOldFormat := l3_bTrue;
    end;//try..except
    if f_IsRefusedOldFormat = l3_bTrue then
     Result := [bs_csPaymentRefusalOldFormat];
   end;//if Result = bs_csPaymentRefusal then
  end;//lp_IsPaymentRefusalOldFormat

//#UC END# *491C424C019F_49228BA50210get_var*
begin
//#UC START# *491C424C019F_49228BA50210get_impl*
 try
  if pm_GetIsStatusChached then
  begin
   Result := CachedStatuses;
   Exit;
  end;//if pm_GetIsStatusChached then
  if Consultation = nil then
   Result := [bs_csNone]
  else
   Result := bsAdapterToBusiness(Consultation.GetStatus);
  // Проверим не является ли отклоненная консультация старого формата:
  lp_IsPaymentRefusalOldFormat;
 except
  on EDeleted do
   Result := [bs_csNone];
 end;//try..except
//#UC END# *491C424C019F_49228BA50210get_impl*
end;//TbsConsultation.pm_GetStatus

function TbsConsultation.pm_GetIsStatusChached: Boolean;
//#UC START# *491C427502ED_49228BA50210get_var*
//#UC END# *491C427502ED_49228BA50210get_var*
begin
//#UC START# *491C427502ED_49228BA50210get_impl*
 Result := f_IsStatusChached;
//#UC END# *491C427502ED_49228BA50210get_impl*
end;//TbsConsultation.pm_GetIsStatusChached

procedure TbsConsultation.pm_SetIsStatusChached(aValue: Boolean);
//#UC START# *491C427502ED_49228BA50210set_var*
//#UC END# *491C427502ED_49228BA50210set_var*
begin
//#UC START# *491C427502ED_49228BA50210set_impl*
 // Прочитаем актуальный статус:
 if aValue then
  CachedStatuses := pm_GetStatus;
 f_IsStatusChached := aValue;
//#UC END# *491C427502ED_49228BA50210set_impl*
end;//TbsConsultation.pm_SetIsStatusChached

function TbsConsultation.pm_GetData: IConsultation;
//#UC START# *491C42A60032_49228BA50210get_var*
//#UC END# *491C42A60032_49228BA50210get_var*
begin
//#UC START# *491C42A60032_49228BA50210get_impl*
 Result := Consultation;
//#UC END# *491C42A60032_49228BA50210get_impl*
end;//TbsConsultation.pm_GetData

function TbsConsultation.pm_GetWasDeleted: Boolean;
//#UC START# *491C42C30267_49228BA50210get_var*
//#UC END# *491C42C30267_49228BA50210get_var*
begin
//#UC START# *491C42C30267_49228BA50210get_impl*
 try
  if Consultation <> nil then
   Consultation.GetStatus;
  Result := False;
 except
  on EDeleted do
   Result := True;
 end;//try..except
//#UC END# *491C42C30267_49228BA50210get_impl*
end;//TbsConsultation.pm_GetWasDeleted

function TbsConsultation.pm_GetId: Il3CString;
//#UC START# *491C42EC02BC_49228BA50210get_var*
var
 l_String: IString;
//#UC END# *491C42EC02BC_49228BA50210get_var*
begin
//#UC START# *491C42EC02BC_49228BA50210get_impl*
 if Consultation <> nil then
 begin
  Consultation.GetId(l_String);
  Result := nsCStr(l_String);
 end
 else
  Result := nil;
//#UC END# *491C42EC02BC_49228BA50210get_impl*
end;//TbsConsultation.pm_GetId

function TbsConsultation.pm_GetWasCreated: SysDateTime;
//#UC START# *491C430C0132_49228BA50210get_var*
var
 l_Date: BaseTypesUnit.TDateTime;
//#UC END# *491C430C0132_49228BA50210get_var*
begin
//#UC START# *491C430C0132_49228BA50210get_impl*
 if Consultation <> nil then
 begin
  Consultation.GetCreationDate(l_Date);
  Result := bsAdapterToBusiness(l_Date);
 end//if Consultation <> nil then
 else
  Result := 0;
//#UC END# *491C430C0132_49228BA50210get_impl*
end;//TbsConsultation.pm_GetWasCreated

function TbsConsultation.pm_GetWasModified: SysDateTime;
//#UC START# *491C431F01F8_49228BA50210get_var*
var
 l_Date: BaseTypesUnit.TDateTime;
//#UC END# *491C431F01F8_49228BA50210get_var*
begin
//#UC START# *491C431F01F8_49228BA50210get_impl*
 if Consultation <> nil then
 begin
  Consultation.GetModificationDate(l_Date);
  Result := bsAdapterToBusiness(l_Date);
 end//if Consultation <> nil then
 else
  Result := 0;
//#UC END# *491C431F01F8_49228BA50210get_impl*
end;//TbsConsultation.pm_GetWasModified

function TbsConsultation.pm_GetCaption: Il3CString;
//#UC START# *491C43420213_49228BA50210get_var*
//#UC END# *491C43420213_49228BA50210get_var*
begin
//#UC START# *491C43420213_49228BA50210get_impl*
 Result := bsConsultationName(Consultation);
//#UC END# *491C43420213_49228BA50210get_impl*
end;//TbsConsultation.pm_GetCaption

function TbsConsultation.pm_GetText: IDocument;
//#UC START# *491C437500BB_49228BA50210get_var*
       
 function bsMakeConsultationText(const aConsultation: IbsConsultation): IDocument;
   {* - в зависимости от состояния консультации возвращает текст консультации.
        Если консультация находится в исходящих, то возвращается текст запроса
        пользователя. }
 begin
  try
   // В неподтвержденной пользователем консультации старого формата нет ответа,
   // также как и запросах находящихся в обработке:
   if aConsultation.Status * c_bsShowQueryForConsultations <> [] then
    aConsultation.Data.GetQuery(Result)
   else
    aConsultation.Data.GetAnswer(Result);
   Exit;
  except
   on ENoConnection do ;
   on ENoSubscription do ;
   on EDeleted do ;
   on EOldFormatConsultation do ;
  end;//try..finally
  Result := nil;
 end;//bsMakeConsultationText
 
//#UC END# *491C437500BB_49228BA50210get_var*
begin
//#UC START# *491C437500BB_49228BA50210get_impl*
 if not Assigned(f_Text) then
  f_Text := bsMakeConsultationText(Self);
 Result := f_Text;
//#UC END# *491C437500BB_49228BA50210get_impl*
end;//TbsConsultation.pm_GetText

procedure TbsConsultation.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49228BA50210_var*
//#UC END# *479731C50290_49228BA50210_var*
begin
//#UC START# *479731C50290_49228BA50210_impl*
 f_Consultation       := nil;
 f_Text               := nil;
 f_IsRefusedOldFormat := l3_bUnknown;
 inherited;
//#UC END# *479731C50290_49228BA50210_impl*
end;//TbsConsultation.Cleanup

procedure TbsConsultation.ClearFields;
begin
 Consultation := nil;
 inherited;
end;//TbsConsultation.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
