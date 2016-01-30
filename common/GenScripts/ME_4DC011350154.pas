unit sdsMainWindow;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\MainWindowControllers\sdsMainWindow.pas"
// ���������: "UseCaseControllerImp"

{$Include nsDefine.inc}

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
 , l3StringIDEx
;

type
 _SetType_ = IsdsMainWindow;
 {$Include vcmTinyUseCaseController.imp.pas}
 TsdsMainWindow = class(_vcmTinyUseCaseController_, IsdsMainWindow, InsWarningGenerator)
  private
   f_OldBaseWarning: Il3CString;
   f_dsBaloonWarning: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsBaloonWarning }
  protected
   function pm_GetOldBaseWarning: Il3CString; virtual;
   function As_InsWarningGenerator: InsWarningGenerator;
    {* ����� ���������� ������ ���������� � InsWarningGenerator }
   function pm_GetdsBaloonWarning: IdsWarning;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
    {* ��������� �������� � ���, ����� �������������� ���� � ���������. ���� ��� �� ������ ��������������, �� �������� cEmptyWarning }
  private
   property OldBaseWarning: Il3CString
    read pm_GetOldBaseWarning;
 end;//TsdsMainWindow
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsWarning
 , Document_Const
 , bsUtils
 , DataAdapter
 , l3String
 , l3Base
 , l3Chars
 , evdTypes
 , k2Tags
 , l3MessageID
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
;

const
 {* ������������ ������ Local }
 str_mwUnreadConsultations: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultations'; rValue : '�������� ������ ��� ����������� �� ������ �������� ��������� ������. ������� � ������ ������.');
  {* '�������� ������ ��� ����������� �� ������ �������� ��������� ������. ������� � ������ ������.' }
 str_mwUnreadConsultationsLink: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultationsLink'; rValue : '������� � ������ ������');
  {* '������� � ������ ������' }
 str_mwOnlineDead: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwOnlineDead'; rValue : '� ������� ���������� ���������� ������ ��������������� ����� ������ ����� 6 �������. ' + 
'������-�������� ������������ ���������� ���������.' + #13#10 + 
'��� ���������� ������� ������ ���������� � ������������� ��� �����������:' + #13#10 + 
'%s');
  {* '� ������� ���������� ���������� ������ ��������������� ����� ������ ����� 6 �������. ' + 
'������-�������� ������������ ���������� ���������.' + #13#10 + 
'��� ���������� ������� ������ ���������� � ������������� ��� �����������:' + #13#10 + 
'%s' }
 str_mwTrialModeWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwTrialModeWarning'; rValue : '�� ��������� � ��������������� ������� ������� ������.' +
' �� ��������� ����� �� �������� �������� ����: %s.' + #13#10 + #13#10 +

'����� ����� ������������������ ������������� ������� ������ � �������� ������ �������� �������������-��������� �����������, ����������� � �������� "������" ��� � �� ������������ ���������:' + #13#10 + #13#10 +

'%s');
  {* '�� ��������� � ��������������� ������� ������� ������.' +
' �� ��������� ����� �� �������� �������� ����: %s.' + #13#10 + #13#10 +

'����� ����� ������������������ ������������� ������� ������ � �������� ������ �������� �������������-��������� �����������, ����������� � �������� "������" ��� � �� ������������ ���������:' + #13#10 + #13#10 +

'%s' }
 str_mwControlledChangingWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwControlledChangingWarning'; rValue : '��������! ��������� �� �������� ����������.');
  {* '��������! ��������� �� �������� ����������.' }

type _Instance_R_ = TsdsMainWindow;

{$Include vcmTinyUseCaseController.imp.pas}

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
 {* ����� ���������� ������ ���������� � InsWarningGenerator }
begin
 Result := Self;
end;//TsdsMainWindow.As_InsWarningGenerator

function TsdsMainWindow.Generate(const aWarning: IdsWarning;
 const aGen: InevTagGenerator;
 aUserType: TvcmUserType): TWarningTypeSet;
 {* ��������� �������� � ���, ����� �������������� ���� � ���������. ���� ��� �� ������ ��������������, �� �������� cEmptyWarning }
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

function TsdsMainWindow.pm_GetdsBaloonWarning: IdsWarning;
//#UC START# *4DC010300124_4DC011350154get_var*
//#UC END# *4DC010300124_4DC011350154get_var*
begin
//#UC START# *4DC010300124_4DC011350154get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DC010300124_4DC011350154get_impl*
end;//TsdsMainWindow.pm_GetdsBaloonWarning

{$If NOT Defined(NoVCM)}
procedure TsdsMainWindow.ClearAreas;
 {* ������� ������ �� ������� ����� }
//#UC START# *4938F7E702B7_4DC011350154_var*
//#UC END# *4938F7E702B7_4DC011350154_var*
begin
//#UC START# *4938F7E702B7_4DC011350154_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4DC011350154_impl*
end;//TsdsMainWindow.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsMainWindow.ClearFields;
begin
 f_OldBaseWarning := nil;
 f_dsBaloonWarning := nil;
 inherited;
end;//TsdsMainWindow.ClearFields

initialization
 str_mwUnreadConsultations.Init;
 {* ������������� str_mwUnreadConsultations }
 str_mwUnreadConsultationsLink.Init;
 {* ������������� str_mwUnreadConsultationsLink }
 str_mwOnlineDead.Init;
 {* ������������� str_mwOnlineDead }
 str_mwTrialModeWarning.Init;
 {* ������������� str_mwTrialModeWarning }
 str_mwControlledChangingWarning.Init;
 {* ������������� str_mwControlledChangingWarning }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
