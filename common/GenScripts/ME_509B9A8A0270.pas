unit kwGetFontSize;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGetFontSize = class(TtfwRegisterableWord)
  {* ���������� ������������� ������ ������ ��� ����� "����������". }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetFontSize
 
implementation

uses
 l3ImplUses
 , evStyleInterface
 , SysUtils
;

end.
