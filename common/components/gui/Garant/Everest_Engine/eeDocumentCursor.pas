unit eeDocumentCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentCursor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Cursors::TeeDocumentCursor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  Classes
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursor
  {$IfEnd} //evUseVisibleCursors
  
  ;

type
 TeeDocumentCursor = class(TevDocumentCursor)
 end;//TeeDocumentCursor

implementation

end.