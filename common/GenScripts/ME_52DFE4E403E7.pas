unit kwTemporaryCompiledCode;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwTemporaryCompiledCode = class(TkwRuntimeWordWithCode)
  {* ��������� �������� ����������������� ����, ������� ���� ����� ����������. �� ������� ������ ������� "������" ������. �������� ��� Caller }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTemporaryCompiledCode
 
implementation

uses
 l3ImplUses
;

end.
