unit vgTypesPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgTypesPrim.pas"
// Начат: 11.02.2011 15:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Core::vgTypesPrim
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
  vgCustomObject
  ;

type
 TvgObjectSortCompare = function (item1: TvgCustomObject;
  item2: TvgCustomObject): integer;
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
{$IfEnd} //not NoVGScene
end.