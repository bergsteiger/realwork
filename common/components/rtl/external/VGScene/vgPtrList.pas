unit vgPtrList;
 {* Список указателей на куски памяти. Ничего не освобождает }

// Модуль: "w:\common\components\rtl\external\VGScene\vgPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgPtrList" MUID: (4D52D86D0330)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

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
 //#UC START# *4D52D86D0330impl_uses*
 //#UC END# *4D52D86D0330impl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
