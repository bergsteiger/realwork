unit evBlocksEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evBlocksEliminator.pas"
// Начат: 2004/10/12 15:30:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevBlocksEliminator
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
 TevBlocksEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevBlocksEliminator

implementation

uses
  Block_Const,
  Document_Const
  ;

// start class TevBlocksEliminator

function TevBlocksEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA311770238_var*
//#UC END# *4CA3006302BC_4CA311770238_var*
begin
//#UC START# *4CA3006302BC_4CA311770238_impl*
 with CurrentType do
  Result := not IsKindOf(k2_typBlock) OR IsKindOf(k2_typDocument);
//#UC END# *4CA3006302BC_4CA311770238_impl*
end;//TevBlocksEliminator.NeedTranslateChildToNext

end.