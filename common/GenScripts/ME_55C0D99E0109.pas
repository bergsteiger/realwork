unit tfwEnumConstantRegistrator;

interface

uses
 l3IntfUses
 , tfwIntegerConstantRegistrator
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwEnumConstantRegistrator = class(TtfwIntegerConstantRegistrator)
  procedure Create(aValue: Integer;
   aTypeInfo: PTypeInfo);
  procedure Register(const aName: AnsiString;
   aValue: Integer;
   aTypeInfo: PTypeInfo);
 end;//TtfwEnumConstantRegistrator
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
