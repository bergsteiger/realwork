unit vgAnyObjectList;
 {* Списсок указателей на объект. НИЧЕГО не освобождает }

// Модуль: "w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgAnyObjectList" MUID: (4D52D82E0312)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ObjectList
;

type
 TvgAnyObjectList = class(Tl3ObjectList)
  {* Списсок указателей на объект. НИЧЕГО не освобождает }
 end;//TvgAnyObjectList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
