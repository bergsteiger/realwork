unit vcmContentConst;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmContentConst - }
{ �����: 09.03.2004 22:07 }
{ $Id: vcmContentConst.pas,v 1.3 2006/03/20 15:09:19 lulin Exp $ }

// $Log: vcmContentConst.pas,v $
// Revision 1.3  2006/03/20 15:09:19  lulin
// - new behavior: �������� ��������� ��������� ���������.
//
// Revision 1.2  2006/03/10 11:49:01  lulin
// - ������������ ��������� IvcmResources - � �����������.
//
// Revision 1.1  2006/03/09 19:19:02  lulin
// - �������� ���������.
//

{$Include vcmDefine.inc }

interface

uses
  vcmExportConst
  ;

const
  c_vcmContentSep = '\';
  c_vcmValueEnd = '#';
  c_vcmOpenKey = '{';
  c_vcmCloseKey = '}';
  c_vcmModuleOperation = 'm'+c_vcmOperation;

implementation

end.

