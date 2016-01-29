unit evEditProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evEditProcessor.pas"
// Начат: 13.05.2008 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevEditProcessor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evMemoProcessor
  ;

type
 TevEditProcessor = class(TevMemoProcessor)
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure BeepOnParaLimit; override;
 end;//TevEditProcessor

implementation

// start class TevEditProcessor

procedure TevEditProcessor.InitFields;
//#UC START# *47A042E100E2_482D8B94020E_var*
//#UC END# *47A042E100E2_482D8B94020E_var*
begin
//#UC START# *47A042E100E2_482D8B94020E_impl*
 inherited;
 TextParaLimit := 1;
//#UC END# *47A042E100E2_482D8B94020E_impl*
end;//TevEditProcessor.InitFields

procedure TevEditProcessor.BeepOnParaLimit;
//#UC START# *482D91730258_482D8B94020E_var*
//#UC END# *482D91730258_482D8B94020E_var*
begin
//#UC START# *482D91730258_482D8B94020E_impl*
 // - не пищим
//#UC END# *482D91730258_482D8B94020E_impl*
end;//TevEditProcessor.BeepOnParaLimit

end.