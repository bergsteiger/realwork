unit eeTextPara_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeTextPara_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi For F1::Everest Engine::EVD::TeeTextPara
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
  evTextPara_InterfaceFactory
  {$IfEnd} //k2ForEditor
  ,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeTextParaInterfaceFactory = class(TevTextParaInterfaceFactory)
 public
 // overridden public methods
   function QueryTool(aTag: Tl3Variant;
     const ID: Tl3IID;
     out I: Tk2ToolPrim): Boolean; override;
 end;//TeeTextParaInterfaceFactory
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  eeTextParaCursor,
  eeTextCursorPair
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TeeTextParaInterfaceFactory

function TeeTextParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 if ID.EQ(ev_iidCursor) then
  I := TeeTextParaCursor.Create(aTag)
 else
 if ID.EQ(ev_iidBlock) then
  I := TeeTextCursorPair.Create(aTag)
 else
  Result := inherited QueryTool(aTag, ID, I);
end;//TeeTextParaInterfaceFactory.QueryTool

{$IfEnd} //Nemesis

end.