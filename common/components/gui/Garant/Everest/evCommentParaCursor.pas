unit evCommentParaCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCommentParaCursor.pas"
// Начат: 17.11.2004 14:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevCommentParaCursor
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
  evDocumentPartCursor,
  nevBase,
  nevTools
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevCommentParaCursor = class(TevDocumentPartCursor)
 protected
 // overridden protected methods
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function IsShowingDocumentParts(const aView: InevControlView): Boolean; override;
 end;//TevCommentParaCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}

// start class TevCommentParaCursor

function TevCommentParaCursor.DoDeleteChar(const aView: InevView;
  aDrawLines: Boolean;
  const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_4A40EB120375_var*
//#UC END# *4A38F7F5022C_4A40EB120375_var*
begin
//#UC START# *4A38F7F5022C_4A40EB120375_impl*
 inherited DoDeleteChar(aView, aDrawLines, anOp);
 Result := true;
//#UC END# *4A38F7F5022C_4A40EB120375_impl*
end;//TevCommentParaCursor.DoDeleteChar

function TevCommentParaCursor.IsShowingDocumentParts(const aView: InevControlView): Boolean;
//#UC START# *4A3FA3FA0033_4A40EB120375_var*
//#UC END# *4A3FA3FA0033_4A40EB120375_var*
begin
//#UC START# *4A3FA3FA0033_4A40EB120375_impl*
 {$IfDef Nemesis}
 Result := false;
 {$Else  Nemesis}
 Result := true;
 {$EndIf Nemesis}
//#UC END# *4A3FA3FA0033_4A40EB120375_impl*
end;//TevCommentParaCursor.IsShowingDocumentParts

{$IfEnd} //evUseVisibleCursors

end.