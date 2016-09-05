unit nsListWarningGenerator;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsListWarningGenerator" MUID: (4EDCFD4D037C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsTypes
 , DocumentAndListInterfaces
 , DocumentUnit
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , UnderControlInterfaces
;

type
 TnsListWarningGenerator = class
  public
   class function Generate(const aWarning: IdsWarning;
    const aDoc: IDocument;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType;
    const anUnderControl: IucpUnderControl): TWarningTypeSet;
 end;//TnsListWarningGenerator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsDocumentWarningGenerator
 , BaloonWarningUserTypes_remListModified_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , bsUtils
 , Document_Const
 , k2Tags
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
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , BaloonWarningUserTypes_ControlledChangingWarning_UserType
 //#UC START# *4EDCFD4D037Cimpl_uses*
 //#UC END# *4EDCFD4D037Cimpl_uses*
;

const
 {* Локализуемые строки Local }
 str_lstListModified: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstListModified'; rValue : 'Список изменён');
  {* 'Список изменён' }
 str_lstListFiltered: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstListFiltered'; rValue : 'Список отфильтрован. Отменить все фильтры');
  {* 'Список отфильтрован. Отменить все фильтры' }
 str_lstSwitchFiltersOff: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstSwitchFiltersOff'; rValue : 'Отменить все фильтры');
  {* 'Отменить все фильтры' }
 str_lstTimeMachineOn: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstTimeMachineOn'; rValue : 'Машина времени включена на дату %s');
  {* 'Машина времени включена на дату %s' }

class function TnsListWarningGenerator.Generate(const aWarning: IdsWarning;
 const aDoc: IDocument;
 const aGen: InevTagGenerator;
 aUserType: TvcmUserType;
 const anUnderControl: IucpUnderControl): TWarningTypeSet;
//#UC START# *4EDCFD7E0323_4EDCFD4D037C_var*
//#UC END# *4EDCFD7E0323_4EDCFD4D037C_var*
begin
//#UC START# *4EDCFD7E0323_4EDCFD4D037C_impl*
 Result := [];
 if (aGen <> nil) then
 begin
  if (aUserType < remListModified) then
   Result := TnsDocumentWarningGenerator.Generate(aWarning,
                                                  aDoc,
                                                  //Self.pm_GetDsDocument.DocInfo.Doc,
                                                  //pm_GetDocInfo.Doc,
                                                  aGen, aUserType,
                                                  //Self.pm_GetDsDocument As IucpUnderControl
                                                  anUnderControl)
  else
  begin
   aGen.Start;
   try
    aGen.StartChild(k2_typDocument);
    try
     aGen.AddIntegerAtom(k2_tiSpaceBefore, 0);
     Case aUserType of
      remListModified:
       bsEditorAddPara(aGen, str_lstListModified.AsWStr, true);
      remListFiltered:
       bsEditorAddPara(aGen, str_lstListFiltered.AsWStr, true,
                       cNoneWarningSub,
                       cNone_LinkHandle,
                       0,
                       0,
                       str_lstSwitchFiltersOff.AsCStr,
                       cSwitchFiltersOff_LinkHandle);
      remTimeMachineWarning:
       bsEditorAddPara(aGen,
                       vcmFmt(str_lstTimeMachineOn,
                              [DefDataAdapter.TimeMachine.DateStr]).AsWStr,
                       true);
      else
       Assert(false);
     end;//Case aUserType
    finally
     aGen.Finish;
    end;//try..finally
   finally
    aGen.Finish;
   end;//try..finally
  end;//aUserType < remListModified
 end;//aGen <> nil
//#UC END# *4EDCFD7E0323_4EDCFD4D037C_impl*
end;//TnsListWarningGenerator.Generate

initialization
 str_lstListModified.Init;
 {* Инициализация str_lstListModified }
 str_lstListFiltered.Init;
 {* Инициализация str_lstListFiltered }
 str_lstSwitchFiltersOff.Init;
 {* Инициализация str_lstSwitchFiltersOff }
 str_lstTimeMachineOn.Init;
 {* Инициализация str_lstTimeMachineOn }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
