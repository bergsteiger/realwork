unit evMessage;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evMessage -     }
{ �����: 18.07.2002 14:51 }
{ $Id: evMessage.pas,v 1.3 2002/07/18 13:43:55 law Exp $ }

// $Log: evMessage.pas,v $
// Revision 1.3  2002/07/18 13:43:55  law
// - bug fix.
//
// Revision 1.2  2002/07/18 12:00:42  law
// - rename message const: ev* -> ev_Mes*.
//
// Revision 1.1  2002/07/18 11:12:28  law
// - new behavior: ���� ���� ���������� � �������� ��������� ����� ����� ��� ����, �� ��������� ����������.
//

{$I evDefine.inc }

interface

resourcestring
  ev_MesBlockAlreadyExists = '���� � ��������������� %d ��� ����������';

implementation

end.

