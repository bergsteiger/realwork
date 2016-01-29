unit l3_Base;

interface

uses
 l3IntfUses
 , l3SimpleObject
;

type
 Tl3_Base = class(Tl3SimpleObject)
  {* ! Базовый класс объектов библиотеки L3. Рекомендуется для наследования от него остальных разрабатываемых объектов. Поддерживает контроль за распределением памяти и освобождением объектов. }
  function OCompare(anObject: Tl3_Base): Integer;
   {* функция сравнения объекта с другим объектом. }
  procedure Create;
   {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
 end;//Tl3_Base
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
