unit evTableCursor;

interface

uses
 l3IntfUses
 , evTableCursorPrim
 , nevTools
 , nevBase
;

type
 TevTableCursor = class(TevTableCursorPrim)
  {* ������ ��� �������. }
  function CorrectPosition(const aView: InevView;
   aStart: Boolean): Boolean;
   {* ������������ �������. http://mdp.garant.ru/pages/viewpage.action?pageId=89096655&focusedCommentId=119474205#comment-119474205 }
 end;//TevTableCursor
 
implementation

uses
 l3ImplUses
 , evOp
 , evdTypes
 , SysUtils
 , k2Tags
;

end.
