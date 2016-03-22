unit l3SimpleObject;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3SimpleObject" MUID: (47BC391D0259)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
;

type
 Tl3SimpleObject = class(Tl3ProtoObjectWithCOMQI)
  public
   constructor Create; reintroduce; virtual;
 end;//Tl3SimpleObject

implementation

uses
 l3ImplUses
;

constructor Tl3SimpleObject.Create;
//#UC START# *4DD3B7AB0108_47BC391D0259_var*
//#UC END# *4DD3B7AB0108_47BC391D0259_var*
begin
//#UC START# *4DD3B7AB0108_47BC391D0259_impl*
 inherited Create;
//#UC END# *4DD3B7AB0108_47BC391D0259_impl*
end;//Tl3SimpleObject.Create

end.
