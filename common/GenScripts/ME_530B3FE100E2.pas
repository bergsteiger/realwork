unit k2MemoryStream;

// ћодуль: "w:\common\components\rtl\Garant\K2\k2MemoryStream.pas"
// —тереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3Memory
 , k2Interfaces
;

type
 Tk2MemoryStream = class(Tl3MemoryStream, Ik2RawData)
  protected
   function pm_GetIsModified: Boolean;
 end;//Tk2MemoryStream

implementation

uses
 l3ImplUses
;

function Tk2MemoryStream.pm_GetIsModified: Boolean;
//#UC START# *49A67D980375_530B3FE100E2get_var*
//#UC END# *49A67D980375_530B3FE100E2get_var*
begin
//#UC START# *49A67D980375_530B3FE100E2get_impl*
// Result := false;
 Result := true;
 // - иначе на стороне Archi считают, что картинки нет, или она не изменилась
//#UC END# *49A67D980375_530B3FE100E2get_impl*
end;//Tk2MemoryStream.pm_GetIsModified

end.
