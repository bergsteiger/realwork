unit vgAnyObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgAnyObjectList.pas"
// Начат: 09.02.2011 21:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgAnyObjectList
//
// Списсок указателей на объект. НИЧЕГО не освобождает
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
  l3ObjectList
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgAnyObjectList = class(Tl3ObjectList)
  {* Списсок указателей на объект. НИЧЕГО не освобождает }
 end;//TvgAnyObjectList
{$IfEnd} //not NoVGScene

implementation

end.