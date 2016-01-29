unit eeCursorTools;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeCursorTools.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Everest Engine::Cursors::eeCursorTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  nevTools,
  eeInterfaces
  ;

function EeEditorByPara(const aPara: InevPara): IeeEditor;
function EeIsReadOnlyPara(const aView: InevView;
  const aPara: InevPara): Boolean;

implementation

uses
  Classes
  {$If defined(Nemesis)}
  ,
  eePara
  {$IfEnd} //Nemesis
  ,
  evdStyles,
  eeInterfacesEx
  ;

// unit methods

function EeEditorByPara(const aPara: InevPara): IeeEditor;
//#UC START# *54BE4C5B0165_54BE4C0B0137_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *54BE4C5B0165_54BE4C0B0137_var*
begin
//#UC START# *54BE4C5B0165_54BE4C0B0137_impl*
 l_Container := aPara.DocumentContainer;
 if (l_Container = nil) OR (l_Container.TextSource = nil) then
  Result := nil
 else
  l_Container.TextSource.CastAnyEditorTo(IeeEditor, Result);
//#UC END# *54BE4C5B0165_54BE4C0B0137_impl*
end;//EeEditorByPara

function EeIsReadOnlyPara(const aView: InevView;
  const aPara: InevPara): Boolean;
//#UC START# *54BE4CA1027C_54BE4C0B0137_var*
var
 l_Para   : IeeStyledLeafPara;
 l_Editor : IeeEditor;
//#UC END# *54BE4CA1027C_54BE4C0B0137_var*
begin
//#UC START# *54BE4CA1027C_54BE4C0B0137_impl*
 l_Editor := EeEditorByPara(aPara);
 if (l_Editor <> nil) then
  try
   l_Para := TeeStyledLeafPara.Make(aPara.AsObject.Box, l_Editor As IeeDocumentEx);
   try
    Result := not l_Para.IsUserComment;
    if not Result and Assigned(aView) then
     Result := -ev_saUserComment in aView.Metrics.HiddenStyles;
   finally
    l_Para := nil;
   end;//try..finally
  finally
   l_Editor := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *54BE4CA1027C_54BE4C0B0137_impl*
end;//EeIsReadOnlyPara

end.