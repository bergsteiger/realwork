unit nsListWarningGenerator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PrimListControllers"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimListControllers/nsListWarningGenerator.pas"
// Начат: 05.12.2011 21:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::PrimListControllers::PrimListControllersRealization::TnsListWarningGenerator
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
  DocumentUnit,
  nevBase,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  l3StringIDEx,
  UnderControlInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsListWarningGenerator = class
 public
 // public methods
   class function Generate(const aWarning: IdsWarning;
     const aDoc: IDocument;
     const aGen: InevTagGenerator;
     aUserType: TvcmUserType;
     const anUnderControl: IucpUnderControl): TWarningTypeSet;
 end;//TnsListWarningGenerator
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocumentWarningGenerator,
  BaloonWarningUserTypes_remListModified_UserType,
  WarningUserTypes_Warning_UserType
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  bsUtils,
  Document_Const,
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
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Local }
  str_lstListModified : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstListModified'; rValue : 'Список изменён');
   { 'Список изменён' }
  str_lstListFiltered : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstListFiltered'; rValue : 'Список отфильтрован. Отменить все фильтры');
   { 'Список отфильтрован. Отменить все фильтры' }
  str_lstSwitchFiltersOff : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstSwitchFiltersOff'; rValue : 'Отменить все фильтры');
   { 'Отменить все фильтры' }
  str_lstTimeMachineOn : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lstTimeMachineOn'; rValue : 'Машина времени включена на дату %s');
   { 'Машина времени включена на дату %s' }

// start class TnsListWarningGenerator

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

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_lstListModified
 str_lstListModified.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_lstListFiltered
 str_lstListFiltered.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_lstSwitchFiltersOff
 str_lstSwitchFiltersOff.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_lstTimeMachineOn
 str_lstTimeMachineOn.Init;
{$IfEnd} //not Admin AND not Monitorings

end.