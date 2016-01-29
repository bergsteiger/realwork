unit SpinEditWordsPack;

interface

uses
 l3IntfUses
 , vtSpinEdit
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpinEditValue = class(TtfwPropertyLike)
  {* ����� ������� pop:SpinEdit:Value
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aSpinEdit pop:SpinEdit:Value >>> l_Integer
[code]  }
  function Value(const aCtx: TtfwContext;
   aSpinEdit: TvtSpinEdit): Integer;
   {* ���������� ����� ������� pop:SpinEdit:Value }
  procedure DoSetValue(aSpinEdit: TvtSpinEdit;
   aValue: Integer);
   {* ����� ��������� �������� �������� Value }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopSpinEditValue
 
end.
