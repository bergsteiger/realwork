unit DayTips_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/DayTips_Module.pas"
// Начат: 04.09.2009 12:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Интерфейсные элементы::DayTips::View::DayTips::DayTips
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  DocumentAndListInterfaces,
  CommonDictionInterfaces,
  DayTipsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  vtFocusLabel,
  StartupTips_Form,
  PrimStartupTips_Form,
  vtLabel,
  DocumentUserTypes_dftTips_UserType,
  DocumentInterfaces,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType,
  PrimCommonDiction_utTips_UserType,
  Common_FormDefinitions_Controls,
  BaseDocumentWithAttributesInterfaces
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtCheckBox,
  ElPopBtn
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  fsTips
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StartupTipsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TDayTipsModule = {formspack} class(TvcmModule)
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   class procedure OpenTipsPrim(const aSDS: IsdsCommonDiction;
     const aContainer: IvcmContainer);
   procedure opShowDayTipsTest(const aParams: IvcmTestParamsPrim);
   procedure opShowDayTips(const aParams: IvcmExecuteParamsPrim);
 public
 // public methods
   class procedure OpenTip(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает совет дня }
   class function ShowDayTipsAtStartup: IvcmEntityForm;
 end;//TDayTipsModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  sdsTips,
  l3Base {a},
  DocumentUnit,
  l3MessageID,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  nsStartupTips
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  DataAdapter
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Tips_opShowDayTips
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TDayTipsModule

class procedure TDayTipsModule.OpenTip(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
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
end;//TDayTipsModule.OpenTip

class procedure TDayTipsModule.OpenTipsPrim(const aSDS: IsdsCommonDiction;
  const aContainer: IvcmContainer);
//#UC START# *4AA52EC603DC_4AA0D5380056_var*
//#UC END# *4AA52EC603DC_4AA0D5380056_var*
begin
//#UC START# *4AA52EC603DC_4AA0D5380056_impl*
 Tfs_Tips.Make(aSDS, aContainer);
//#UC END# *4AA52EC603DC_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTipsPrim

class function TDayTipsModule.ShowDayTipsAtStartup: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB9DAAC00AC_4AA0D5380056_var*
//#UC END# *4AB9DAAC00AC_4AA0D5380056_var*
var
 l_Data : InsStartupTips;
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
end;//TDayTipsModule.ShowDayTipsAtStartup

procedure TDayTipsModule.opShowDayTipsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB9DBA1038E_4AA0D5380056test_var*
//#UC END# *4AB9DBA1038E_4AA0D5380056test_var*
begin
//#UC START# *4AB9DBA1038E_4AA0D5380056test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.NativeAdapter.MakeTipsManager.IsExist;
//#UC END# *4AB9DBA1038E_4AA0D5380056test_impl*
end;//TDayTipsModule.opShowDayTipsTest

procedure TDayTipsModule.opShowDayTips(const aParams: IvcmExecuteParamsPrim);
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
        'Пользуйтесь фабрикой OpenTipsPrim');
(* if Supports(aParams.Data, IsdsCommonDiction, l_SDS) AND (l_SDS <> nil) then
  OpenTipsPrim(l_SDS, aParams.Container)
 else*)
 if {(l_SDS = nil) AND} not lp_HasTipsForm {or Assigned(l_SDS)} then
  OpenTip(nil, CheckContainer(nil));
//#UC END# *4AB9DBA1038E_4AA0D5380056exec_impl*
end;//TDayTipsModule.opShowDayTips

procedure TDayTipsModule.Loaded;
begin
 inherited;
 PublishOp('opShowDayTips', opShowDayTips, opShowDayTipsTest);
end;

class procedure TDayTipsModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TefStartupTips);
end;

{$IfEnd} //not Admin AND not Monitorings

end.