unit l3DataContainerWithoutIUnknown;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3DataContainerWithoutIUnknown.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3DataContainerWithoutIUnknown
//
// Контейнер данных без реализации IUnknown, но во всей интерфейсной поддержкой
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3DataContainerWithoutIUnknownPrim,
  l3PureMixIns
  ;

type
 _l3Changing_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Include ..\L3\l3Changing.imp.pas}
 Tl3DataContainerWithoutIUnknown = {abstract} class(_l3Changing_)
  {* Контейнер данных без реализации IUnknown, но во всей интерфейсной поддержкой }
 end;//Tl3DataContainerWithoutIUnknown

implementation

{$Include ..\L3\l3Changing.imp.pas}

end.