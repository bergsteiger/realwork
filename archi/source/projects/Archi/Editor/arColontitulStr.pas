unit arColontitulStr;

{ $Id: arColontitulStr.pas,v 1.1 2011/06/21 12:33:02 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Chars;

const
 cBlockStr : array [Boolean] of string = ('', '(��������)');
 cUrgencyStr : array [0..2] of string = ('', '������', '� ������');
 cChDate = 'ChDate: ';
 csUpLeftFirstTilul = '%s������ ID : %s' + cc_SoftEnter +
                      '������: %s ���� (X1,6 = %s)' + cc_SoftEnter +
                      '����: %s %s' + cc_SoftEnter +
                      '����������: %s';
 csUpLeftTilul = '������ ID : %s%s';

implementation

end.
