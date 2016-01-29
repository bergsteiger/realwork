unit NOT_FINISHED_nsFolderNodes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/NOT_FINISHED_nsFolderNodes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Common$Lib::Folders::nsFolderNodes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  FoldersDomainInterfaces
  ;

type
 TnsNodeWithRights = class
 private
 // private fields
   f_AcceptedRights : TFoldersActionsSet;
   f_RestrictedRights : TFoldersActionsSet;
 end;//TnsNodeWithRights

 TnsFoldersNode = class(TnsNodeWithRights)
 end;//TnsFoldersNode
procedure NsFindInsertPosition;
   {* Сигнатура метода nsFindInsertPosition }
procedure NsHasNodeAnyFlag;
   {* Сигнатура метода nsHasNodeAnyFlag }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
// unit methods

procedure NsFindInsertPosition;
//#UC START# *4C7E782B01A4_4AD5B48E038A_var*
//#UC END# *4C7E782B01A4_4AD5B48E038A_var*
begin
//#UC START# *4C7E782B01A4_4AD5B48E038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E782B01A4_4AD5B48E038A_impl*
end;//NsFindInsertPosition

procedure NsHasNodeAnyFlag;
//#UC START# *4C7E785A02DA_4AD5B48E038A_var*
//#UC END# *4C7E785A02DA_4AD5B48E038A_var*
begin
//#UC START# *4C7E785A02DA_4AD5B48E038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E785A02DA_4AD5B48E038A_impl*
end;//NsHasNodeAnyFlag
{$IfEnd} //not Admin AND not Monitorings

end.