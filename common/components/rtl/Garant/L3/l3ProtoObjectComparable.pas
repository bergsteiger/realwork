unit l3ProtoObjectComparable;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoObjectComparable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoObjectComparable" MUID: (4D5BF8930032)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3ProtoObjectComparable = class(Tl3ProtoObject)
  public
   function CompareWith(anOther: Tl3ProtoObjectComparable): Integer; virtual; abstract;
 end;//Tl3ProtoObjectComparable

implementation

uses
 l3ImplUses
 //#UC START# *4D5BF8930032impl_uses*
 //#UC END# *4D5BF8930032impl_uses*
;

end.
