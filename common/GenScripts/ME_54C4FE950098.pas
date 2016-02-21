unit eeNodeUtils;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeNodeUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , eeInterfaces
;

function eeDirection2l3Direction(aDirection: TeeDirection): Tl3Direction;

implementation

uses
 l3ImplUses
;

function eeDirection2l3Direction(aDirection: TeeDirection): Tl3Direction;
//#UC START# *54C4FED303A5_54C4FE950098_var*
//#UC END# *54C4FED303A5_54C4FE950098_var*
begin
//#UC START# *54C4FED303A5_54C4FE950098_impl*
 Result := Tl3Direction(Byte(aDirection));
//#UC END# *54C4FED303A5_54C4FE950098_impl*
end;//eeDirection2l3Direction

end.
