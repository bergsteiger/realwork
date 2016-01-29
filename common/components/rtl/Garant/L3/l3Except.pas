unit l3Except;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Except.pas"
// �����: 22.04.1998 11:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3Except
//
// ������� ���������� L3.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  SysUtils
  ;

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

const
  { ��������� �� �������. }
 l3_excAbortLoad = '�������� �������� ���������.';

type
 El3BadPictureFormat = class(El3Error)
 end;//El3BadPictureFormat

 El3AbortLoadFilter = class(El3AbortLoad)
 end;//El3AbortLoadFilter

 El3BadDataInPara = class(El3Exception)
 end;//El3BadDataInPara

implementation

end.