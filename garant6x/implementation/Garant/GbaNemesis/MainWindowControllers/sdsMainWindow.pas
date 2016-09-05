unit sdsMainWindow;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainWindowControllers\sdsMainWindow.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsMainWindow" MUID: (4DC011350154)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MainWindowInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , DocumentAndListInterfaces
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _SetType_ = IsdsMainWindow;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsMainWindow = class(_vcmTinyUseCaseController_, IsdsMainWindow, InsWarningGenerator)
  private
   f_OldBaseWarning: Il3CString;
   f_dsBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning }
  protected
   function pm_GetOldBaseWarning: Il3CString; virtual;
   function As_InsWarningGenerator: InsWarningGenerator;
    {* Метод приведения нашего интерфейса к InsWarningGenerator }
   function pm_GetDsBaloonWarning: IdsWarning;
   function DoGet_DsBaloonWarning: IdsWarning;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
    {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
  private
   property OldBaseWarning: Il3CString
    read pm_GetOldBaseWarning;
 end;//TsdsMainWindow
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , dsWarning
 , Document_Const
 , bsUtils
 , DataAdapter
 , l3String
 , l3Base
 , l3Chars
 , evdTypes
 , k2Tags
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , WarningUserTypes_Warning_UserType
 , BaloonWarningUserTypes_Fake_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , BaloonWarningUserTypes_ControlledChangingWarning_UserType
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4DC011350154impl_uses*
 //#UC END# *4DC011350154impl_uses*
;

const
 {* Локализуемые строки Local }
 str_mwUnreadConsultations: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultations'; rValue : 'Получены ответы или уведомления от службы Правовой поддержки онлайн. Перейти к тексту ответа.');
  {* 'Получены ответы или уведомления от службы Правовой поддержки онлайн. Перейти к тексту ответа.' }
 str_mwUnreadConsultationsLink: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultationsLink'; rValue : 'Перейти к тексту ответа');
  {* 'Перейти к тексту ответа' }
 str_mwOnlineDead: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwOnlineDead'; rValue : 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. ' + 
'Онлайн-проверка актуальности документов отключена.' + #13#10 + 
'Для обновления системы ГАРАНТ обратитесь в обслуживающую Вас организацию:' + #13#10 + 
'%s');
  {* 'С момента последнего обновления Вашего информационного банка прошло более 6 месяцев. ' + 
'Онлайн-проверка актуальности документов отключена.' + #13#10 + 
'Для обновления системы ГАРАНТ обратитесь в обслуживающую Вас организацию:' + #13#10 + 
'%s' }
 str_mwTrialModeWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwTrialModeWarning'; rValue : 'Вы работаете с ознакомительной версией системы ГАРАНТ.' +
' До окончания срока ее действия осталось дней: %s.' + #13#10 + #13#10 +

'Чтобы стать зарегистрированным пользователем системы ГАРАНТ и получать полный комплекс информационно-правового обеспечения, обращайтесь в компанию "Гарант" или к ее региональным партнерам:' + #13#10 + #13#10 +

'%s');
  {* 'Вы работаете с ознакомительной версией системы ГАРАНТ.' +
' До окончания срока ее действия осталось дней: %s.' + #13#10 + #13#10 +

'Чтобы стать зарегистрированным пользователем системы ГАРАНТ и получать полный комплекс информационно-правового обеспечения, обращайтесь в компанию "Гарант" или к ее региональным партнерам:' + #13#10 + #13#10 +

'%s' }
 str_mwControlledChangingWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwControlledChangingWarning'; rValue : 'Внимание! Документы на контроле изменились.');
  {* 'Внимание! Документы на контроле изменились.' }

type _Instance_R_ = TsdsMainWindow;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

function TsdsMainWindow.pm_GetOldBaseWarning: Il3CString;
//#UC START# *4DC03F5B00A1_4DC011350154get_var*
//#UC END# *4DC03F5B00A1_4DC011350154get_var*
begin
//#UC START# *4DC03F5B00A1_4DC011350154get_impl*
 if (f_OldBaseWarning = nil) then
  f_OldBaseWarning := l3CStr(l3RTrim(defDataAdapter.GetOldBaseWarning.AsWStr,
                                     cc_NonReadable));
 Result := f_OldBaseWarning;                                    
//#UC END# *4DC03F5B00A1_4DC011350154get_impl*
end;//TsdsMainWindow.pm_GetOldBaseWarning

function TsdsMainWindow.As_InsWarningGenerator: InsWarningGenerator;
 {* Метод приведения нашего интерфейса к InsWarningGenerator }
begin
 Result := Self;
end;//TsdsMainWindow.As_InsWarningGenerator

function TsdsMainWindow.Generate(const aWarning: IdsWarning;
 const aGen: InevTagGenerator;
 aUserType: TvcmUserType): TWarningTypeSet;
 {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
//#UC START# *493E4F7E039B_4DC011350154_var*
//#UC END# *493E4F7E039B_4DC011350154_var*
begin
//#UC START# *493E4F7E039B_4DC011350154_impl*
 Result := [];
 if (aGen <> nil) then
 begin
  aGen.Start;
  try
   aGen.StartChild(k2_typDocument);
   try
    aGen.AddIntegerAtom(k2_tiSpaceBefore, 0);
    Case aUserType of
     remUnreadConsultations:
      bsEditorAddPara(aGen, str_mwUnreadConsultations.AsWStr, true,
                      cNoneWarningSub,
                      cNone_LinkHandle,
                      0,
                      0,
                      str_mwUnreadConsultationsLink.AsCStr,
                      cUnreadConsultations_LinkHandle);
     BaloonWarningUserTypes_OldBaseWarning_UserType.OldBaseWarning:
      bsEditorAddPara(aGen, l3PCharLen(Self.OldBaseWarning), true,
                      ev_itLeft, true);
     remOnlineDead:
      bsEditorAddPara(aGen,
                      l3Fmt(str_mwOnlineDead.AsCStr,
                            [DefDataAdapter.GetDealerInfo]).AsWStr,
                      true);
     TrialModeWarning:
      bsEditorAddPara(aGen,
                      l3Fmt(str_mwTrialModeWarning.AsCStr,
                            [DefDataAdapter.TrialDaysLeft,
                             DefDataAdapter.GetDealerInfo]).AsWStr,
                      true);
     ControlledChangingWarning:                 
      bsEditorAddPara(aGen, str_mwControlledChangingWarning.AsWStr, true);
     else
      Assert(false);
    end;//Case aUserType
   finally
    aGen.Finish;
   end;//try..finally
  finally
   aGen.Finish;
  end;//try..finally
 end;//aGen <> nil
//#UC END# *493E4F7E039B_4DC011350154_impl*
end;//TsdsMainWindow.Generate

function TsdsMainWindow.pm_GetDsBaloonWarning: IdsWarning;
//#UC START# *4DC010300124_4DC011350154get_var*
//#UC END# *4DC010300124_4DC011350154get_var*
begin
 if (f_dsBaloonWarning = nil) then
 begin
  f_dsBaloonWarning := TvcmViewAreaControllerRef.Make;
  //#UC START# *4DC010300124_4DC011350154get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4DC010300124_4DC011350154get_init*
 end;//f_dsBaloonWarning = nil
 if f_dsBaloonWarning.IsEmpty
  //#UC START# *4DC010300124_4DC011350154get_need*
  // - условие создания ViewArea
  //#UC END# *4DC010300124_4DC011350154get_need*
  then
   f_dsBaloonWarning.Referred := DoGet_dsBaloonWarning;
 Result := IdsWarning(f_dsBaloonWarning.Referred);
end;//TsdsMainWindow.pm_GetDsBaloonWarning

function TsdsMainWindow.DoGet_DsBaloonWarning: IdsWarning;
//#UC START# *4DC010300124_4DC011350154area_var*
//#UC END# *4DC010300124_4DC011350154area_var*
begin
//#UC START# *4DC010300124_4DC011350154area_impl*
 Result := TdsWarning.Make(Self);
//#UC END# *4DC010300124_4DC011350154area_impl*
end;//TsdsMainWindow.DoGet_DsBaloonWarning

procedure TsdsMainWindow.ClearFields;
begin
 f_OldBaseWarning := nil;
 f_dsBaloonWarning := nil;
 inherited;
end;//TsdsMainWindow.ClearFields

{$If NOT Defined(NoVCM)}
procedure TsdsMainWindow.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_dsBaloonWarning <> nil) then f_dsBaloonWarning.Referred := nil;
 inherited;
end;//TsdsMainWindow.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_mwUnreadConsultations.Init;
 {* Инициализация str_mwUnreadConsultations }
 str_mwUnreadConsultationsLink.Init;
 {* Инициализация str_mwUnreadConsultationsLink }
 str_mwOnlineDead.Init;
 {* Инициализация str_mwOnlineDead }
 str_mwTrialModeWarning.Init;
 {* Инициализация str_mwTrialModeWarning }
 str_mwControlledChangingWarning.Init;
 {* Инициализация str_mwControlledChangingWarning }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
