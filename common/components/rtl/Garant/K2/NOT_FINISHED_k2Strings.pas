unit NOT_FINISHED_k2Strings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/NOT_FINISHED_k2Strings.pas"
// �����: 11.04.2006 20:13
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::K2::k2Strings
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\K2\k2Define.inc}

interface

const
  { Exception Messages }
 k2_errInterfaceNotImplemented = 'Interface %d for %s is not implemented';
 k2_errReadOnly = '������ ��������� �������� ReadOnly �������� %s ��� %s.';
 k2_errNoChildren = 'Tag %s hasn''t children (%s)';
 k2_errBadChild = 'For %s child type %s incompartible with %s';
 k2_errConvertError = 'Cannot convert %s to %s';
 k2_errAbstractMethod = 'Abstract method ''%s'' call';
 k2_errPropExists = 'Atom #%d for %s is already defined and named %s';
 k2_errCannotInheriteType = 'Cannot inherite type %s from %s';
 k2_errTypeAlreadyDefined = 'Type %s already defined';
 k2_errDocumentHeaderMissing = '����� �� ������. �������� ����������� ��������� ���������.';
 k2_errInvalidType = '������������ ���.';
 k2_errBadSkipLevel = '������ �������� ������ ���������� ����� (������������������ ������ IncSkipTags/DecSkipTags)';
 k2_errBadFinishCall = '������� Finish ������ ��� ������� Start';
 k2_errParamNotDefined = 'Param %s for %s is not defined';
 k2_errBracketsNotClosed = '�� ������� %d ������ � %s';

implementation

end.