unit k2Strings;

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2Strings -     }
{ �����: 11.04.2006 20:13 }
{ $Id: k2Strings.pas,v 1.3 2006/04/18 07:45:23 lulin Exp $ }

// $Log: k2Strings.pas,v $
// Revision 1.3  2006/04/18 07:45:23  lulin
// - cleanup.
//
// Revision 1.2  2006/04/11 17:55:28  lulin
// - ������������ ��� ������ ��������� ����� (�� ������ ���� ��� ����� ������� � �������� 20% ������������������).
//
// Revision 1.1  2006/04/11 16:35:37  lulin
// - ������������ ��� ������ ��������� ����� (�� ������ ���� ��� ����� ������� � �������� 20% ������������������).
//

{$Include k2Define.inc }

interface

resourcestring
 k2_errInterfaceNotImplemented = 'Interface %d for %s is not implemented';
 k2_errReadOnly = '������ ��������� �������� ReadOnly �������� %s ��� %s.';
 k2_errNoChildren = 'Tag %s hasn''t children (%s)';
 k2_errBadChild = 'For %s child type %s incompartible with %s';
 k2_errConvertError = 'Cannot convert %s to %s';
 k2_errAbstractMethod = 'Abstract method ''%s'' call';
 k2_errPropExists = 'Atom #%d for %s is already defined and named %s';
 k2_errCannotInheriteType = 'Cannot inherite type %s from %s';
 k2_errTypeAlreadyDefined = 'Type %s already defined';
 k2_strNil = 'nil';
 k2_errDocumentHeaderMissing = '����� �� ������. �������� ����������� ��������� ���������.';
 k2_errInvalidType = '������������ ���.';
 k2_errBadSkipLevel = '������ �������� ������ ���������� ����� (������������������ ������ IncSkipTags/DecSkipTags)';
 k2_errBadFinishCall = '������� Finish ������ ��� ������� Start';
 k2_errParamNotDefined = 'Param %s for %s is not defined';
 k2_errBracketsNotClosed = '�� ������� %d ������ � %s';

implementation

end.

