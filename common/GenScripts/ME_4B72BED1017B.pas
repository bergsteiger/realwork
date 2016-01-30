unit NOT_FINISHED_jclDebug;

// Модуль: "w:\common\components\rtl\external\JEDI\source\windows\NOT_FINISHED_jclDebug.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(notDebugStackTrace)}
uses
 l3IntfUses
;

type
 TJclStackInfoList = class
 end;//TJclStackInfoList

procedure JclLastExceptStackList;
{$IfEnd} // NOT Defined(notDebugStackTrace)

implementation

{$If NOT Defined(notDebugStackTrace)}
uses
 l3ImplUses
;

procedure JclLastExceptStackList;
//#UC START# *4B72BEEB00CA_4B72BED1017B_var*
//#UC END# *4B72BEEB00CA_4B72BED1017B_var*
begin
//#UC START# *4B72BEEB00CA_4B72BED1017B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B72BEEB00CA_4B72BED1017B_impl*
end;//JclLastExceptStackList
{$IfEnd} // NOT Defined(notDebugStackTrace)

end.
