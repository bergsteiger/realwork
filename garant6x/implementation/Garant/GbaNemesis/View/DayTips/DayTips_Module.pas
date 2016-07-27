unit DayTips_Module;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\DayTips_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "DayTips" MUID: (4AA0D5380056)
// ��� ����: "TDayTipsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDayTipsModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   class procedure OpenTipsPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure opShowDayTipsTest(const aParams: IvcmTestParamsPrim);
   procedure opShowDayTipsExecute(const aParams: IvcmExecuteParamsPrim);
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TDayTipsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3ProtoObject
 , Base_Operations_F1Services_Contracts
 , DocumentInterfaces
 , PrimCommonDiction_utTips_UserType
 , Common_FormDefinitions_Controls
 , nsStartupTips
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , sdsTips
 , DataAdapter
 , SysUtils
 , l3Base
 , fsTips
 , StartupTips_Form
 //#UC START# *4AA0D5380056impl_uses*
 //#UC END# *4AA0D5380056impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TDayTipsServiceImpl = {final} class(Tl3ProtoObject, IDayTipsService)
  public
   function ShowDayTipsAtStartup: IvcmEntityForm;
   procedure OpenTip(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ��������� ����� ��� }
   class function Instance: TDayTipsServiceImpl;
    {* ����� ��������� ���������� ���������� TDayTipsServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TDayTipsServiceImpl

var g_TDayTipsServiceImpl: TDayTipsServiceImpl = nil;
 {* ��������� ���������� TDayTipsServiceImpl }

procedure TDayTipsServiceImplFree;
 {* ����� ������������ ���������� ���������� TDayTipsServiceImpl }
begin
 l3Free(g_TDayTipsServiceImpl);
end;//TDayTipsServiceImplFree

function TDayTipsServiceImpl.ShowDayTipsAtStartup: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB9DAAC00AC_4AA0D5380056_var*
//#UC END# *4AB9DAAC00AC_4AA0D5380056_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB9DAAC00AC_4AA0D5380056_impl*
 l_Data := TnsStartupTips.Make;
 if Assigned(l_Data) then
  Result := TefStartupTips.MakeSingleChild(l_Data,
                                 CheckContainer(nil),
                                 vcm_ztFloating)
 else
  Result := nil;
//#UC END# *4AB9DAAC00AC_4AA0D5380056_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDayTipsServiceImpl.ShowDayTipsAtStartup

procedure TDayTipsServiceImpl.OpenTip(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ��������� ����� ��� }
var
 __WasEnter : Boolean;
//#UC START# *4AA11A2E0144_4AA0D5380056_var*
//#UC END# *4AA11A2E0144_4AA0D5380056_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA11A2E0144_4AA0D5380056_impl*
 OpenTipsPrim(TsdsTips.Make(aDocInfo), aContainer);
//#UC END# *4AA11A2E0144_4AA0D5380056_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDayTipsServiceImpl.OpenTip

class function TDayTipsServiceImpl.Instance: TDayTipsServiceImpl;
 {* ����� ��������� ���������� ���������� TDayTipsServiceImpl }
begin
 if (g_TDayTipsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TDayTipsServiceImplFree);
  g_TDayTipsServiceImpl := Create;
 end;
 Result := g_TDayTipsServiceImpl;
end;//TDayTipsServiceImpl.Instance

class function TDayTipsServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDayTipsServiceImpl <> nil;
end;//TDayTipsServiceImpl.Exists

class procedure TDayTipsModule.OpenTipsPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52EC603DC_4AA0D5380056_var*
//#UC END# *4AA52EC603DC_4AA0D5380056_var*
begin
//#UC START# *4AA52EC603DC_4AA0D5380056_impl*
 Tfs_Tips.Make(aSDS, aContainer);
//#UC END# *4AA52EC603DC_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTipsPrim

procedure TDayTipsModule.opShowDayTipsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB9DBA1038E_4AA0D5380056test_var*
//#UC END# *4AB9DBA1038E_4AA0D5380056test_var*
begin
//#UC START# *4AB9DBA1038E_4AA0D5380056test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.NativeAdapter.MakeTipsManager.IsExist;
//#UC END# *4AB9DBA1038E_4AA0D5380056test_impl*
end;//TDayTipsModule.opShowDayTipsTest

procedure TDayTipsModule.opShowDayTipsExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB9DBA1038E_4AA0D5380056exec_var*

 function lp_HasTipsForm: Boolean;
 begin
  Result := CheckContainer(nil).HasForm(fm_en_CommonDiction.rFormID,
                                        vcm_ztNavigator,
                                        True,
                                        nil,
                                        Ord(utTips));
 end;//lp_HasTipsForm

//#UC END# *4AB9DBA1038E_4AA0D5380056exec_var*
begin
//#UC START# *4AB9DBA1038E_4AA0D5380056exec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        '����������� �������� OpenTipsPrim');
(* if Supports(aParams.Data, IsdsCommonDiction, l_SDS) AND (l_SDS <> nil) then
  OpenTipsPrim(l_SDS, aParams.Container)
 else*)
 if {(l_SDS = nil) AND} not lp_HasTipsForm {or Assigned(l_SDS)} then
  OpenTip(nil, CheckContainer(nil));
//#UC END# *4AB9DBA1038E_4AA0D5380056exec_impl*
end;//TDayTipsModule.opShowDayTipsExecute

procedure TDayTipsModule.Loaded;
begin
 inherited;
 PublishOp('opShowDayTips', opShowDayTipsExecute, opShowDayTipsTest);
end;//TDayTipsModule.Loaded

class procedure TDayTipsModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TefStartupTips);
end;//TDayTipsModule.GetEntityForms

initialization
 TDayTipsService.Instance.Alien := TDayTipsServiceImpl.Instance;
 {* ����������� TDayTipsServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
