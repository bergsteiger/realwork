unit NOT_FINISHED_ArchiUserRequestManager;

// Модуль: "w:\archi\source\projects\Archi\NOT_FINISHED_ArchiUserRequestManager.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ArchiUserRequestManager" MUID: (57CFC223011F)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TArchiUserRequestManager = class
 end;//TArchiUserRequestManager

function ArchiRequestManager: TArchiUserRequestManager;
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *57CFC223011Fimpl_uses*
 //#UC END# *57CFC223011Fimpl_uses*
;

function ArchiRequestManager: TArchiUserRequestManager;
//#UC START# *57CFC26A0059_57CFC223011F_var*
//#UC END# *57CFC26A0059_57CFC223011F_var*
begin
//#UC START# *57CFC26A0059_57CFC223011F_impl*
 !!! Needs to be implemented !!!
//#UC END# *57CFC26A0059_57CFC223011F_impl*
end;//ArchiRequestManager
{$IfEnd} // Defined(AppClientSide)

end.
