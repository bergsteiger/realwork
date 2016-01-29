unit evdLeafParaFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevdLeafParaFilter = class(Tk2TagFilter)
  {* Класс, фильтрующий "листьевые" абзацы. Параметры фильтрации
 задаются методом TevdLeafParaFilter.ParaTypeForFiltering
(если нужно фильтровать один тип) и TevdLeafParaFilter.NeedWritePara
(если нужно фильтровать несколько типов или условие
фильтрации меняется с течением времени). Запись
отфильтрованного абзаца выполняется в методе TevdLeafParaFilter.DoWritePara,
перекрывая который, можно вносить изменения в содержание
абзаца }
  function ParaTypeForFiltering: Tk2Type;
   {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
  function NeedWritePara(aLeaf: Tl3Variant): Boolean;
   {* Определяет нужно ли фильтровать переданный абзац }
  procedure DoWritePara(aLeaf: Tl3Variant);
   {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevdLeafParaFilter
 
implementation

uses
 l3ImplUses
;

end.
