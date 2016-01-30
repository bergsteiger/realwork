unit vgPtrList;
 {* Список указателей на куски памяти. Ничего не освобождает }

// Модуль: "w:\common\components\rtl\external\VGScene\vgPtrList.pas"
// Стереотип: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3DataPtrList
;

type
 TvgPtrList = class(Tl3DataPtrList)
  {* Список указателей на куски памяти. Ничего не освобождает }
 end;//TvgPtrList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
