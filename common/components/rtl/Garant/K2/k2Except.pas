unit k2Except;

// ������: "w:\common\components\rtl\Garant\K2\k2Except.pas"
// ���������: "Interfaces"
// ������� ������: "k2Except" MUID: (47AC80BD020B)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Except
;

type
 Ek2Error = class(El3Error)
 end;//Ek2Error

 Ek2Warning = class(El3Warning)
 end;//Ek2Warning

 Ek2NotFound = class(El3NotFound)
 end;//Ek2NotFound

 Ek2CannotDefine = class(Ek2Error)
 end;//Ek2CannotDefine

 Ek2TypeAlreadyDefined = class(Ek2CannotDefine)
 end;//Ek2TypeAlreadyDefined

 Ek2PropertyAlreadyDefined = class(Ek2CannotDefine)
 end;//Ek2PropertyAlreadyDefined

 Ek2CannotDefineType = class(Ek2CannotDefine)
 end;//Ek2CannotDefineType

 Ek2ConversionError = class(Ek2Error)
 end;//Ek2ConversionError

 Ek2CannotAddChild = class(El3Exception)
 end;//Ek2CannotAddChild

 Ek2InvalidChildType = class(Ek2CannotAddChild)
 end;//Ek2InvalidChildType

 Ek2ReadOnlyProperty = class(Ek2Warning)
 end;//Ek2ReadOnlyProperty

 Ek2ReadOnly = class(Ek2Warning)
 end;//Ek2ReadOnly

 Ek2LimitReached = class(Ek2Warning)
 end;//Ek2LimitReached

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2Error));
 {* ����������� ���� Ek2Error }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2Warning));
 {* ����������� ���� Ek2Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2NotFound));
 {* ����������� ���� Ek2NotFound }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2CannotDefine));
 {* ����������� ���� Ek2CannotDefine }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2TypeAlreadyDefined));
 {* ����������� ���� Ek2TypeAlreadyDefined }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2PropertyAlreadyDefined));
 {* ����������� ���� Ek2PropertyAlreadyDefined }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2CannotDefineType));
 {* ����������� ���� Ek2CannotDefineType }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2ConversionError));
 {* ����������� ���� Ek2ConversionError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2CannotAddChild));
 {* ����������� ���� Ek2CannotAddChild }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2InvalidChildType));
 {* ����������� ���� Ek2InvalidChildType }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2ReadOnlyProperty));
 {* ����������� ���� Ek2ReadOnlyProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2ReadOnly));
 {* ����������� ���� Ek2ReadOnly }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ek2LimitReached));
 {* ����������� ���� Ek2LimitReached }
{$IfEnd} // NOT Defined(NoScripts)

end.
