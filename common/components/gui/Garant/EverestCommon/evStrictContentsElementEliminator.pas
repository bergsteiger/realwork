unit evStrictContentsElementEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evStrictContentsElementEliminator.pas"
// Начат: 29.09.2010 13:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevStrictContentsElementEliminator
//
// Фильтр, удаляющий "элементы оглавления" (k2_idContentsElement). Но не блоки, и никаких других
// наследников
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevStrictContentsElementEliminator = class(Tk2TagFilter)
  {* Фильтр, удаляющий "элементы оглавления" (k2_idContentsElement). Но не блоки, и никаких других наследников }
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevStrictContentsElementEliminator

implementation

uses
  ContentsElement_Const
  ;

// start class TevStrictContentsElementEliminator

function TevStrictContentsElementEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA2FFC10275_var*
//#UC END# *4CA3006302BC_4CA2FFC10275_var*
begin
//#UC START# *4CA3006302BC_4CA2FFC10275_impl*
 Result := (CurrentType.ID <> k2_idContentsElement);
//#UC END# *4CA3006302BC_4CA2FFC10275_impl*
end;//TevStrictContentsElementEliminator.NeedTranslateChildToNext

end.