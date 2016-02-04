unit l3MultiThreadSortedIntegerList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MultiThreadSortedIntegerList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3MultiThreadIntegerList
;

type
 Tl3MultiThreadSortedIntegerList = class(Tl3MultiThreadIntegerList)
  protected
   function NeedSort: Boolean; override;
 end;//Tl3MultiThreadSortedIntegerList

implementation

uses
 l3ImplUses
;

function Tl3MultiThreadSortedIntegerList.NeedSort: Boolean;
//#UC START# *53A2C90A0344_53A2C9290311_var*
//#UC END# *53A2C90A0344_53A2C9290311_var*
begin
//#UC START# *53A2C90A0344_53A2C9290311_impl*
 Result := true;
//#UC END# *53A2C90A0344_53A2C9290311_impl*
end;//Tl3MultiThreadSortedIntegerList.NeedSort

end.
