unit NOT_FINISHED_EdWin;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Main\NOT_FINISHED_EdWin.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "EdWin" MUID: (5146CA0A03DE)

interface

uses
 l3IntfUses
;

type
 TEditorWindow = class
  public
   function IsNeedSave: Boolean;
 end;//TEditorWindow

implementation

uses
 l3ImplUses
 , D_spell
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , archiEditorWindowWordsPack
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
;

function TEditorWindow.IsNeedSave: Boolean;
//#UC START# *5146CA96020D_5146CA34003E_var*
//#UC END# *5146CA96020D_5146CA34003E_var*
begin
//#UC START# *5146CA96020D_5146CA34003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5146CA96020D_5146CA34003E_impl*
end;//TEditorWindow.IsNeedSave

end.
