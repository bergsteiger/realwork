unit l3ProtoDataContainer;
 {* Самый примитивный контейнер данных }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 _l3DataContainer_Parent_ = Tl3ProtoObject;
 {$Include l3DataContainer.imp.pas}
 Tl3ProtoDataContainer = {abstract} class(_l3DataContainer_)
  {* Самый примитивный контейнер данных }
 end;//Tl3ProtoDataContainer

implementation

uses
 l3ImplUses
;

{$Include l3DataContainer.imp.pas}

end.
