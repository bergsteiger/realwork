unit eeMemoWithEditOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeMemoWithEditOperations.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeMemoWithEditOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  eeMemo,
  evEditorWithOperations
  ;

type
 TeeMemoWithEditOperations = class(TeeMemo)
 protected
 // overridden protected methods
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
     {* Какие операции публикуются компонентом. }
 end;//TeeMemoWithEditOperations

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeMemoWithEditOperations

function TeeMemoWithEditOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
//#UC START# *48735C4A03C3_4AC5D3380185_var*
//#UC END# *48735C4A03C3_4AC5D3380185_var*
begin
//#UC START# *48735C4A03C3_4AC5D3380185_impl*
 Result := [potEdit];
//#UC END# *48735C4A03C3_4AC5D3380185_impl*
end;//TeeMemoWithEditOperations.DefineProvideOperations

initialization
{$If not defined(NoScripts)}
// Регистрация TeeMemoWithEditOperations
 TtfwClassRef.Register(TeeMemoWithEditOperations);
{$IfEnd} //not NoScripts

end.