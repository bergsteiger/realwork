unit vgPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgPtrList.pas"
// Начат: 09.02.2011 21:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgPtrList
//
// Список указателей на куски памяти. Ничего не освобождает
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3DataPtrList
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgPtrList = class(Tl3DataPtrList)
  {* Список указателей на куски памяти. Ничего не освобождает }
 end;//TvgPtrList
{$IfEnd} //not NoVGScene

implementation

end.