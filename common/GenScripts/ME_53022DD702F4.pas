unit l3CastableObject;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CastableObject.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 _l3Castable_Parent_ = TObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}
 Tl3CastableObject = class(_l3Castable_)
 end;//Tl3CastableObject

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}

end.
