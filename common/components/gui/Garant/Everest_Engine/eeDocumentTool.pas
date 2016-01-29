unit eeDocumentTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentTool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Engine Core::TeeDocumentTool
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
  l3Tool,
  eeInterfacesEx
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeDocumentTool = class(Tl3Tool)
 protected
 // property methods
   function pm_GetDocument: IeeDocumentEx;
 public
 // public methods
   constructor Create(const aDocument: IeeDocumentEx); reintroduce;
 public
 // public properties
   property Document: IeeDocumentEx
     read pm_GetDocument;
 end;//TeeDocumentTool
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TeeDocumentTool

constructor TeeDocumentTool.Create(const aDocument: IeeDocumentEx);
//#UC START# *548717AB01C5_54817DBA01BE_var*
//#UC END# *548717AB01C5_54817DBA01BE_var*
begin
//#UC START# *548717AB01C5_54817DBA01BE_impl*
 inherited Create(aDocument as IeeToolOwner);
//#UC END# *548717AB01C5_54817DBA01BE_impl*
end;//TeeDocumentTool.Create

function TeeDocumentTool.pm_GetDocument: IeeDocumentEx;
//#UC START# *5487171F0251_54817DBA01BEget_var*
//#UC END# *5487171F0251_54817DBA01BEget_var*
begin
//#UC START# *5487171F0251_54817DBA01BEget_impl*
 Result := IeeToolOwner(f_Owner) as IeeDocumentEx;
//#UC END# *5487171F0251_54817DBA01BEget_impl*
end;//TeeDocumentTool.pm_GetDocument

{$IfEnd} //Nemesis

end.