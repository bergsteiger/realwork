unit kwRAISE;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwRAISE = class(TtfwRegisterableWord)
  {* ����������������� ����� RAISE. ���������� raise �� Delphi. ���� �� ���� ����������, �� ������������ EtfwScriptException.
������:
[code]
TRY
 '�������� ����������' RAISE
EXCEPT
 true >>> WasException
END
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRAISE
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
