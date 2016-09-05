unit NOT_FINISHED_csTaskTypes;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csTaskTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csTaskTypes" MUID: (532046D302C2)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

const
 cs_arsSuccess = 0;
 cs_arsAborted = 1;
 cs_arsGeneralError = 2;
 cs_arsUtilityNotFound = 3;
  {* Утилита не найдена }
 cs_arsTaskUnregistered = 4;

type
 TcsTaskStatus = (
 );//TcsTaskStatus

 TcsTaskType = (
 );//TcsTaskType

 TcsFileRenameMode = (
 );//TcsFileRenameMode

 TcsTaskTypes = set of TcsTaskType;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *532046D302C2impl_uses*
 //#UC END# *532046D302C2impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
