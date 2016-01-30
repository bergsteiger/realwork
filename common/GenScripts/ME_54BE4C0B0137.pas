unit eeCursorTools;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeCursorTools.pas"
// Стереотип: "UtilityPack"

{$Include eeDefine.inc}

interface

uses
 l3IntfUses
 , eeInterfaces
 , nevTools
;

function eeEditorByPara(const aPara: InevPara): IeeEditor;
function eeIsReadOnlyPara(const aView: InevView;
 const aPara: InevPara): Boolean;

implementation

uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , eePara
 {$IfEnd} // Defined(Nemesis)
 , evdStyles
 , eeInterfacesEx
;

function eeEditorByPara(const aPara: InevPara): IeeEditor;
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
end;//eeEditorByPara

function eeIsReadOnlyPara(const aView: InevView;
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
end;//eeIsReadOnlyPara

end.
