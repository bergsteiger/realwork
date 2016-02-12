unit l3CastableStrings;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CastableStrings.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
 , l3Interfaces
;

type
 _l3Castable_Parent_ = TStrings;
 {$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}
 Tl3CastableStrings = class(_l3Castable_)
 end;//Tl3CastableStrings

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}

end.
