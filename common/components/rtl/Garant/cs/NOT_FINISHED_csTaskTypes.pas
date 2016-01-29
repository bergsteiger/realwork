unit NOT_FINISHED_csTaskTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csTaskTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::ArchiClientServer::csTaskTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
type
 TcsTaskStatus = (
   
 );//TcsTaskStatus

 TcsTaskType = (
   
 );//TcsTaskType

 TcsFileRenameMode = (
   
 );//TcsFileRenameMode

 TcsTaskTypes = set of TcsTaskType;

const
  { TcsExecutionStatus }
 cs_arsSuccess = 0;
 cs_arsAborted = 1;
 cs_arsGeneralError = 2;
 cs_arsUtilityNotFound = 3;
  { Утилита не найдена }
 cs_arsTaskUnregistered = 4;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.