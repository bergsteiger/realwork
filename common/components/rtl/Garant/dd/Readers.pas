unit Readers;

{ $Id: Readers.pas,v 1.13 2015/04/24 14:45:19 lulin Exp $ }

// $Log: Readers.pas,v $
// Revision 1.13  2015/04/24 14:45:19  lulin
// - правильный define.
//
// Revision 1.12  2015/04/13 10:26:47  lulin
// - пытаемся собрать библиотеку.
//
// Revision 1.11  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.10  2002/01/05 11:00:42  law
// - some cosmetics.
//
// Revision 1.9  2001/10/23 09:03:38  law
// - new const: evEverestReaders & evEverestWriters.
//
// Revision 1.8  2001/05/24 13:36:10  law
// no message
//
// Revision 1.7  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  ddRTFReader,
  ddDocReader,
  ddHTML_r
  ;

type
  TRTFReader = class(TddRTFReader)
    published
      property Filer;
        {-}
      property Generator;
        {-}
  end;{TRTFReader}

  TevRTFReader = TRTFReader;

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}
{$IfNDef evRunTime}
procedure Register;
{$EndIf  evRunTime}
{$EndIf l3ConsoleApp}

implementation

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}
uses
  Classes,
  
  evConst
  ;

{$IfNDef evRunTime}
procedure Register;
begin
 {$IfDef k2GeneratorIsComponent}
 RegisterComponents(evReaders, [TRTFReader,
                                {$If Declared(TddDocReader)}
                                TddDocReader,
                                {$IfEnd}
                                TddHTMLReader]);
 {$EndIf k2GeneratorIsComponent}                               
end;
{$EndIf  evRunTime}
{$EndIf l3ConsoleApp}

end.