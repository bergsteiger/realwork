unit kwSelectCellsWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwSelectCellsWord = class(TkwEditorFromStackWord)
  {* Примесь выделения мышью части таблицы в редакторе. }
  function IsVertical: Boolean;
   {* При выделении мышь движется сверху вниз. }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwSelectCellsWord
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Units
 , nevTools
 , evConst
 , nevGUIInterfaces
;

end.
