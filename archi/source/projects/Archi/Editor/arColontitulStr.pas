unit arColontitulStr;

{ $Id: arColontitulStr.pas,v 1.1 2011/06/21 12:33:02 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Chars;

const
 cBlockStr : array [Boolean] of string = ('', '(фрагмент)');
 cUrgencyStr : array [0..2] of string = ('', 'СРОЧНО', 'В ВЕРСИЮ');
 cChDate = 'ChDate: ';
 csUpLeftFirstTilul = '%sГарант ID : %s' + cc_SoftEnter +
                      'Размер: %s байт (X1,6 = %s)' + cc_SoftEnter +
                      'Базы: %s %s' + cc_SoftEnter +
                      'Напечатано: %s';
 csUpLeftTilul = 'Гарант ID : %s%s';

implementation

end.
