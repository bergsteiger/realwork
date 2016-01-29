unit evQueryCardCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evQueryCardCursor.pas"
// Начат: 2008/04/14 13:46:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevQueryCardCursor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evDocumentCursor
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevQueryCardCursor = class(TevDocumentCursor)
 protected
 // overridden protected methods
   function CanInsertParaOnMove: Boolean; override;
 end;//TevQueryCardCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}

// start class TevQueryCardCursor

function TevQueryCardCursor.CanInsertParaOnMove: Boolean;
//#UC START# *4BFFD9C80181_4BFFD963014E_var*
//#UC END# *4BFFD9C80181_4BFFD963014E_var*
begin
//#UC START# *4BFFD9C80181_4BFFD963014E_impl*
 {$IfDef Nemesis}
 Result := false;
 {$Else  Nemesis}
 Result := inherited CanInsertParaOnMove;
 {$EndIf Nemesis}
//#UC END# *4BFFD9C80181_4BFFD963014E_impl*
end;//TevQueryCardCursor.CanInsertParaOnMove

{$IfEnd} //evUseVisibleCursors

end.