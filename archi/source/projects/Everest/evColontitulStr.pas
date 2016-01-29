unit evColontitulStr;

{ $Id: evColontitulStr.pas,v 1.3 2009/07/07 08:03:30 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Chars;

const
 SOtherDataSize = '%OtherDataSize%';
 csUpLeftFirstTitul = 'Документ : %s' + cc_SoftEnter +
                      'Размер: %s байт (X1,6 = %s)' + cc_SoftEnter +
                      'Напечатано: %s';
 csUpLeftTitul = 'Документ : %s';

implementation

end.
