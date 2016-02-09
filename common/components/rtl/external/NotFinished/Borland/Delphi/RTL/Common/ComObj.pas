unit ComObj;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\ComObj.pas"
// Стереотип: "UtilityPack"

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EOleError = class(Exception)
  {* EOleError is the exception class for low-level OLE errors }
 end;//EOleError

 EOleSysError = class(EOleError)
  {* EOleSysError is the exception class for errors specific to the OLE IDispatch interface }
 end;//EOleSysError

procedure OleCheck;

implementation

uses
 l3ImplUses
;

procedure OleCheck;
//#UC START# *4D186F8401C5_4981AC0701C1_var*
//#UC END# *4D186F8401C5_4981AC0701C1_var*
begin
//#UC START# *4D186F8401C5_4981AC0701C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D186F8401C5_4981AC0701C1_impl*
end;//OleCheck

end.
