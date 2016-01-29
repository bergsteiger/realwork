unit K272666721;

interface

uses
 l3IntfUses
 , InsertSectionBreak
 , evCustomEditorWindow
;

type
 TK272666721 = class(TInsertSectionBreak)
  {* [$272666721] }
  function MoveCursorCount: Integer;
  procedure CheckPara(const aText: TevCustomEditorWindow);
 end;//TK272666721
 
implementation

uses
 l3ImplUses
 , nevBase
 , TestFrameWork
;

end.
