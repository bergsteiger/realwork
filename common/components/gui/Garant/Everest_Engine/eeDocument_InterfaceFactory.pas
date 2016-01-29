unit eeDocument_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocument_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi For F1::Everest Engine::EVD::TeeDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evDocument_InterfaceFactory
  {$IfEnd} //k2ForEditor
  ,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeDocumentInterfaceFactory = class(TevDocumentInterfaceFactory)
 public
 // overridden public methods
   function QueryTool(aTag: Tl3Variant;
     const ID: Tl3IID;
     out I: Tk2ToolPrim): Boolean; override;
 end;//TeeDocumentInterfaceFactory
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  eeDocumentCursor,
  eeDocumentCursorPair
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TeeDocumentInterfaceFactory

function TeeDocumentInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 if ID.EQ(ev_iidCursor) then
  I := TeeDocumentCursor.Create(aTag)
 else
 if ID.EQ(ev_iidBlock) then
  I := TeeDocumentCursorPair.Create(aTag)
 else
  Result := inherited QueryTool(aTag, ID, I);
end;//TeeDocumentInterfaceFactory.QueryTool

{$IfEnd} //Nemesis

end.