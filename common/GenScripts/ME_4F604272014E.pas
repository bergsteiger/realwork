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
  {* ������� ��������� ����� ����� ������� � ���������. }
  function IsVertical: Boolean;
   {* ��� ��������� ���� �������� ������ ����. }
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
