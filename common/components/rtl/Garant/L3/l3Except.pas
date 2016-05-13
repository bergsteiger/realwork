unit l3Except;
 {* ������� ���������� L3. }

// ������: "w:\common\components\rtl\Garant\L3\l3Except.pas"
// ���������: "Interfaces"
// ������� ������: "l3Except" MUID: (4787B0A8007B)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , SysUtils
;

const
 {* ��������� �� �������. }
 l3_excAbortLoad = '�������� �������� ���������.';

type
 El3Exception = class(Exception)
 end;//El3Exception

 El3CannotModify = class(El3Exception)
 end;//El3CannotModify

 El3Error = class(El3Exception)
 end;//El3Error

 El3Warning = class(El3Exception)
 end;//El3Warning

 El3NotFound = class(El3Error)
 end;//El3NotFound

 El3Abort = class(El3Error)
 end;//El3Abort

 El3AbortLoad = class(El3Abort)
 end;//El3AbortLoad

 El3FilerError = class(El3Error)
 end;//El3FilerError

 El3ReadError = class(El3FilerError)
 end;//El3ReadError

 El3NoLoggedException = class(El3Exception)
  {* ������ ������, ������� � ��� �� �������� (��. l3ExceptionsLog) }
 end;//El3NoLoggedException

 El3InfoException = class(El3Exception)
  {* ������ ������ ��� �������������� ����� (��������� �������������) }
 end;//El3InfoException

 El3DuplicateItem = class(El3Exception)
  {* ������������ �������� � ������ }
 end;//El3DuplicateItem

 El3ConvertError = class(El3Exception)
 end;//El3ConvertError

 El3BadPictureFormat = class(El3Error)
 end;//El3BadPictureFormat

 El3AbortLoadFilter = class(El3AbortLoad)
 end;//El3AbortLoadFilter

 El3BadDataInPara = class(El3Exception)
 end;//El3BadDataInPara

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3Exception));
 {* ����������� ���� El3Exception }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3CannotModify));
 {* ����������� ���� El3CannotModify }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3Error));
 {* ����������� ���� El3Error }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3Warning));
 {* ����������� ���� El3Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3NotFound));
 {* ����������� ���� El3NotFound }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3Abort));
 {* ����������� ���� El3Abort }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3AbortLoad));
 {* ����������� ���� El3AbortLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3FilerError));
 {* ����������� ���� El3FilerError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3ReadError));
 {* ����������� ���� El3ReadError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3NoLoggedException));
 {* ����������� ���� El3NoLoggedException }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3InfoException));
 {* ����������� ���� El3InfoException }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3DuplicateItem));
 {* ����������� ���� El3DuplicateItem }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3ConvertError));
 {* ����������� ���� El3ConvertError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3BadPictureFormat));
 {* ����������� ���� El3BadPictureFormat }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3AbortLoadFilter));
 {* ����������� ���� El3AbortLoadFilter }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(El3BadDataInPara));
 {* ����������� ���� El3BadDataInPara }
{$IfEnd} // NOT Defined(NoScripts)

end.
