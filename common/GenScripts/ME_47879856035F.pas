unit l3_Base;
 {* ! Базовый класс объектов библиотеки L3. Рекомендуется для наследования от него остальных разрабатываемых объектов. Поддерживает контроль за распределением памяти и освобождением объектов. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3_Base.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3_Base" MUID: (47879856035F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3PureMixIns
;

type
 _l3Changing_Parent_ = Tl3SimpleObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 Tl3_Base = class(_l3Changing_)
  {* ! Базовый класс объектов библиотеки L3. Рекомендуется для наследования от него остальных разрабатываемых объектов. Поддерживает контроль за распределением памяти и освобождением объектов. }
  public
   function OCompare(anObject: Tl3_Base): Integer; virtual;
    {* функция сравнения объекта с другим объектом. }
   constructor Create; reintroduce; virtual;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
 end;//Tl3_Base

implementation

uses
 l3ImplUses
 , l3Base
;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

function Tl3_Base.OCompare(anObject: Tl3_Base): Integer;
 {* функция сравнения объекта с другим объектом. }
//#UC START# *478CEE670214_47879856035F_var*
//#UC END# *478CEE670214_47879856035F_var*
begin
//#UC START# *478CEE670214_47879856035F_impl*
 Assert(false);
 Result := -1;
//#UC END# *478CEE670214_47879856035F_impl*
end;//Tl3_Base.OCompare

constructor Tl3_Base.Create;
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_47879856035F_var*
//#UC END# *47914F960008_47879856035F_var*
begin
//#UC START# *47914F960008_47879856035F_impl*
 inherited Create;
//#UC END# *47914F960008_47879856035F_impl*
end;//Tl3_Base.Create

end.
