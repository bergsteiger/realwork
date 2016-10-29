unit l3FakeProtoObject2;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject2.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FakeProtoObject2" MUID: (MSM7C7FB44D377D)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FakeProtoObject1
;

type
 Tl3FakeProtoObject2 = class(Tl3FakeProtoObject1)
 end;//Tl3FakeProtoObject2

 Tl3FakeTypedef2 = Tl3FakeProtoObject2;

implementation

uses
 l3ImplUses
 //#UC START# *MSM7C7FB44D377Dimpl_uses*
 //#UC END# *MSM7C7FB44D377Dimpl_uses*
;

end.
