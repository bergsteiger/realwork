unit sdsMainWindow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MainWindowControllers$BaseOperations"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/MainWindowControllers/sdsMainWindow.pas"
// �����: 03.05.2011 18:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Base Operations::MainWindowControllers$BaseOperations::MainWindowControllersRealization::TsdsMainWindow
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  MainWindowInterfaces
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
  l3NotifyPtrList,
  DocumentAndListInterfaces {a},
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  DocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetType_ = IsdsMainWindow;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsMainWindow = {ucc} class(_vcmTinyUseCaseController_, IsdsMainWindow, InsWarningGenerator {from IsdsMainWindow})
 private
 // private fields
   f_OldBaseWarning : Il3CString;
   f_dsBaloonWarning : IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsBaloonWarning}
 protected
 // property methods
   function pm_GetOldBaseWarning: Il3CString; virtual;
 protected
 // realized methods
   function pm_GetDsBaloonWarning: IdsWarning;
   function DoGet_dsBaloonWarning: IdsWarning;
 public
 // realized methods
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
     {* ��������� �������� � ���, ����� �������������� ���� � ���������. ���� ��� �� ������ ��������������, �� �������� cEmptyWarning }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* ������� ������ �� ������� ����� }
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 private
 // private properties
   property OldBaseWarning: Il3CString
     read pm_GetOldBaseWarning;
 protected
 // ������ �������������� � ����������� �����������
   function As_InsWarningGenerator: InsWarningGenerator;
 end;//TsdsMainWindow
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsWarning,
  WarningUserTypes_Warning_UserType,
  Document_Const,
  bsUtils,
  DataAdapter,
  l3String,
  l3Base,
  l3Chars,
  evdTypes,
  k2Tags,
  BaloonWarningUserTypes_Fake_UserType,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  l3MessageID
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsMainWindow;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

var
   { ������������ ������ Local }
  str_mwUnreadConsultations : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultations'; rValue : '�������� ������ ��� ����������� �� ������ �������� ��������� ������. ������� � ������ ������.');
   { '�������� ������ ��� ����������� �� ������ �������� ��������� ������. ������� � ������ ������.' }
  str_mwUnreadConsultationsLink : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwUnreadConsultationsLink'; rValue : '������� � ������ ������');
   { '������� � ������ ������' }
  str_mwOnlineDead : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwOnlineDead'; rValue : '� ������� ���������� ���������� ������ ��������������� ����� ������ ����� 6 �������. ' + 
'������-�������� ������������ ���������� ���������.' + #13#10 + 
'��� ���������� ������� ������ ���������� � ������������� ��� �����������:' + #13#10 + 
'%s');
   { '� ������� ���������� ���������� ������ ��������������� ����� ������ ����� 6 �������. ' + 
'������-�������� ������������ ���������� ���������.' + #13#10 + 
'��� ���������� ������� ������ ���������� � ������������� ��� �����������:' + #13#10 + 
'%s' }
  str_mwTrialModeWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwTrialModeWarning'; rValue : '�� ��������� � ��������������� ������� ������� ������.' +
' �� ��������� ����� �� �������� �������� ����: %s.' + #13#10 + #13#10 +

'����� ����� ������������������ ������������� ������� ������ � �������� ������ �������� �������������-��������� �����������, ����������� � �������� "������" ��� � �� ������������ ���������:' + #13#10 + #13#10 +

'%s');
   { '�� ��������� � ��������������� ������� ������� ������.' +
' �� ��������� ����� �� �������� �������� ����: %s.' + #13#10 + #13#10 +

'����� ����� ������������������ ������������� ������� ������ � �������� ������ �������� �������������-��������� �����������, ����������� � �������� "������" ��� � �� ������������ ���������:' + #13#10 + #13#10 +

'%s' }
  str_mwControlledChangingWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mwControlledChangingWarning'; rValue : '��������! ��������� �� �������� ����������.');
   { '��������! ��������� �� �������� ����������.' }

// start class TsdsMainWindow

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

function TsdsMainWindow.Generate(const aWarning: IdsWarning;
  const aGen: InevTagGenerator;
  aUserType: TvcmUserType): TWarningTypeSet;
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
  // - ��� ������������� ������ �� ViewArea
  //#UC END# *4DC010300124_4DC011350154get_init*
 end;//f_dsBaloonWarning = nil
 if f_dsBaloonWarning.IsEmpty
  //#UC START# *4DC010300124_4DC011350154get_need*
  // - ������� �������� ViewArea
  //#UC END# *4DC010300124_4DC011350154get_need*
  then
   f_dsBaloonWarning.Referred := DoGet_dsBaloonWarning;
 Result := IdsWarning(f_dsBaloonWarning.Referred);
end;

function TsdsMainWindow.DoGet_dsBaloonWarning: IdsWarning;
//#UC START# *4DC010300124_4DC011350154area_var*
//#UC END# *4DC010300124_4DC011350154area_var*
begin
//#UC START# *4DC010300124_4DC011350154area_impl*
 Result := TdsWarning.Make(Self);
//#UC END# *4DC010300124_4DC011350154area_impl*
end;//TsdsMainWindow.DoGet_dsBaloonWarning

{$If not defined(NoVCM)}
procedure TsdsMainWindow.ClearAreas;
 {-}
begin
 if (f_dsBaloonWarning <> nil) then f_dsBaloonWarning.Referred := nil;
 inherited;
end;//TsdsMainWindow.ClearAreas
{$IfEnd} //not NoVCM

procedure TsdsMainWindow.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_OldBaseWarning := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsBaloonWarning := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TsdsMainWindow.ClearFields

// ������ �������������� � ����������� �����������

function TsdsMainWindow.As_InsWarningGenerator: InsWarningGenerator;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_mwUnreadConsultations
 str_mwUnreadConsultations.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_mwUnreadConsultationsLink
 str_mwUnreadConsultationsLink.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_mwOnlineDead
 str_mwOnlineDead.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_mwTrialModeWarning
 str_mwTrialModeWarning.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_mwControlledChangingWarning
 str_mwControlledChangingWarning.Init;
{$IfEnd} //not Admin AND not Monitorings

end.