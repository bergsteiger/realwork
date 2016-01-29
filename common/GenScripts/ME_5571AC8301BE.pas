unit tfwTypeModifier;

interface

uses
 l3IntfUses
 , kwModifier
 , TypInfo
 , tfwTypeInfo
;

type
 TtfwClassModifier = class(TkwModifier)
  procedure Create(aClass: TClass);
  function Modifier: TtfwTypeInfo;
 end;//TtfwClassModifier
 
 TtfwTypeModifier = class(TkwModifier)
  function RegisterTypeModifier(aTypeInfo: PTypeInfo): Boolean; overload;
  procedure Create(aTypeInfo: PTypeInfo);
  function RegisterTypeModifier(aClass: TClass): Boolean; overload;
  function Modifier: TtfwTypeInfo;
 end;//TtfwTypeModifier
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
