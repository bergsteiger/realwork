unit KeyboardInputPack;

interface

uses
 l3IntfUses
 , tfwAxiomaticsResNameGetter
;

implementation

uses
 l3ImplUses
 , kwKey
 , kwHardKey
 , kwKeyDown
 , kwKeyUp
 , tfwScriptingTypes
;

type
 TKeyboardInputPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TKeyboardInputPackResNameGetter
 
end.
