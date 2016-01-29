unit Writers;

{ $Id: Writers.pas,v 1.10 2011/10/03 08:28:39 voba Exp $ }

// $Log: Writers.pas,v $
// Revision 1.10  2011/10/03 08:28:39  voba
// - k : 281525254
//
// Revision 1.9  2004/05/14 17:27:03  law
// - remove unit: evStrGen.
//
// Revision 1.8  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.7  2002/09/19 13:19:26  law
// - remove unit: ddHTML.
//
// Revision 1.6  2002/01/05 11:00:42  law
// - some cosmetics.
//
// Revision 1.5  2001/10/23 09:03:38  law
// - new const: evEverestReaders & evEverestWriters.
//
// Revision 1.4  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  ddHTMLWriter,
  ddRTFWriter
  ;

type
  TevHTMLWriter = class(TddHTMLGenerator)
    published
    {published properties}
      property Filer;
        {-}
  end;{TevHTMLWriter}

  TevRTFWriter = class(TevRTFObjectGenerator)
    published
    {published properties}
      property Filer;
        {-}
  end;{TevRTFWriter}

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}
{$IfNDef evRunTime}
{$IFDEF k2GeneratorIsComponent}
procedure Register;
{$ENDIF k2GeneratorIsComponent}
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
{$IFDEF k2GeneratorIsComponent}
procedure Register;
begin
 RegisterComponents(evWriters, [TevHTMLWriter, TevRTFWriter]);
end;
{$ENDIF k2GeneratorIsComponent}
{$EndIf evRunTime}
{$EndIf l3ConsoleApp}

end.