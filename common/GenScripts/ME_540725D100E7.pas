unit NOT_FINISHED_m3Exceptions;

// ������: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3Exceptions.pas"
// ���������: "UtilityPack"
// ������� ������: "m3Exceptions" MUID: (540725D100E7)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3Except
;

type
 Em3Exception = class(El3Exception)
 end;//Em3Exception

 Em3InvalidStream = class(Em3Exception)
 end;//Em3InvalidStream

 Em3NilStream = class(Em3InvalidStream)
 end;//Em3NilStream

 Em3NoIndex = class(Em3Exception)
 end;//Em3NoIndex

implementation

uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Em3Exception));
 {* ����������� ���� Em3Exception }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Em3InvalidStream));
 {* ����������� ���� Em3InvalidStream }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Em3NilStream));
 {* ����������� ���� Em3NilStream }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Em3NoIndex));
 {* ����������� ���� Em3NoIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
