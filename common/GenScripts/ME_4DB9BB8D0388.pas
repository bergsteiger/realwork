unit kwBEGIN;

interface

uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
;

type
 TkwBEGIN = class(TtfwBeginLikeWord)
  {* ��������� ������ BEGIN END � ����� �������. }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwBEGIN
 
implementation

uses
 l3ImplUses
 , kwEND
;

end.
