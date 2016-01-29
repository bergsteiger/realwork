unit ddNSRCKwd;

{ $Id: ddNSRCKwd.pas,v 1.7 2005/02/16 17:10:41 narry Exp $ }

// $Log: ddNSRCKwd.pas,v $
// Revision 1.7  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.6  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.5  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.4  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3KeyWrd
  ;

const
  nrscNone        = 0;
  nrscEOL         = 1;
  nrscText        = 2;
  nrscTOPIC       = 3;
  nrscSTYLE       = 4;
  nrscSUB         = 5;
  nrscCLASS       = 6;
  nrscNAME        = 7;
  nrscSOURCE      = 8;
  nrscTYPE        = 9;
  nrscKEYWORDS    = 10;
  nrscBELONGS     = 11;
  nrscWARNING     = 12;
  nrscSUFFIX      = 13;
  nrscDOC         = 14;
  nrscNODOC       = 15;
  nrscCALENDAR    = 16;
  nrscBUSINESS    = 17;
  nrscUSERINFO    = 18;
  nrscDATE        = 19;
  nrscCODE        = 20;
  nrscRDATE       = 21;
  nrscRCODE       = 22;
  nrscGDDATE      = 23;
  nrscGDCODE      = 24;
  nrscSFDATE      = 25;
  nrscSFCODE      = 26;
  nrscVINCLUDED   = 27;
  nrscVCHANGED    = 28;
  nrscVABOLISHED  = 29;
  nrscVANONCED    = 30;
  nrscREVISION    = 31;
  nrscVLCONTROL   = 32;
  nrscRELATED     = 33;
  nrscBLOCK       = 34;
  nrscBLOCKEND    = 35;
  nrscPRIORITY    = 36;
  nrscSORTDATE    = 37;
  nrscNOACTIVE    = 38;
  nrscREL         = 39;
  nrscSTAGE       = 40;
  nrscCHECK       = 41;
  { Новые команды }
  nrscPUBLISHEDIN = 42;
  nrscPREFIX      = 43;
  nrscTERRITORY   = 44;
  nrscNORM        = 45;
  nrscPREACTIVE   = 46;
  nrscMOJNOTREG   = 47;
  nrscOBJPATH     = 48;
  nrscOBJTOPIC    = 49;
  nrscOBJTYPE     = 50;
  nsrcPRICELEVEL  = 51;
  { Аннотации }
  nsrcANNOTOPIC   = 52;
  nsrcANNONAME    = 53;
  nsrcANNODATE    = 54;
  nsrcANNOCLASS   = 55;



function NSRCKeyWords: Tl3KeyWords;

implementation

var
  NSRCKeyWordsIndex : Long = -1;


function NSRCKeyWords: Tl3KeyWords;
var
 KW : Tl3KeyWords;
begin
 if (NSRCKeyWordsIndex < 0) then
 begin
  KW := Tl3KeyWords.Create(nil);
  try
    KW.AddKeyWord('!TOPIC', nrscTopic);
    KW.AddKeyWord('!STYLE', nrscSTYLE);
    KW.AddKeyWord('!SUB', nrscSUB);
    KW.AddKeyWord('!CLASS', nrscCLASS);
    KW.AddKeyWord('!NAME', nrscNAME);
    KW.AddKeyWord('!SOURCE', nrscSOURCE);
    KW.AddKeyWord('!TYPE', nrscTYPE);
    KW.AddKeyWord('!KEYWORDS', nrscKEYWORDS);
    KW.AddKeyWord('!BELONGS', nrscBELONGS);
    KW.AddKeyWord('!WARNING', nrscWARNING);
    KW.AddKeyWord('!SUFFIX', nrscSUFFIX);
    KW.AddKeyWord('!DOC', nrscDOC);
    KW.AddKeyWord('!NODOC', nrscNODOC);
    KW.AddKeyWord('!CALENDAR', nrscCALENDAR);
    KW.AddKeyWord('!BUSINESS', nrscBUSINESS);
    KW.AddKeyWord('!USERINFO', nrscUSERINFO);
    KW.AddKeyWord('!DATE', nrscDATE);
    KW.AddKeyWord('!CODE', nrscCODE);
    KW.AddKeyWord('!RDATE',  nrscRDATE);
    KW.AddKeyWord('!RCODE', nrscRCODE);
    KW.AddKeyWord('!GDDATE', nrscGDDATE);
    KW.AddKeyWord('!GDCODE', nrscGDCODE);
    KW.AddKeyWord('!SFDATE', nrscSFDATE);
    KW.AddKeyWord('!SFCODE', nrscSFCODE);
    KW.AddKeyWord('!VINCLUDED', nrscVINCLUDED);
    KW.AddKeyWord('!VCHANGED', nrscVCHANGED);
    KW.AddKeyWord('!VABOLISHED', nrscVABOLISHED);
    KW.AddKeyWord('!VANONCED', nrscVANONCED);
    KW.AddKeyWord('!REVISION', nrscREVISION);
    KW.AddKeyWord('!VLCONTROL', nrscVLCONTROL);
    KW.AddKeyWord('!RELATED', nrscRELATED);
    KW.AddKeyWord('!BLOCK', nrscBLOCK);
    KW.AddKeyWord('!BLOCKEND', nrscBLOCKEND);
    KW.AddKeyWord('!PRIORITY', nrscPRIORITY);
    KW.AddKeyWord('!SORTDATE', nrscSORTDATE);
    KW.AddKeyWord('!NOACTIVE', nrscNOACTIVE);
    KW.AddKeyWord('!REL', nrscREL);
    KW.AddKeyWord('!STAGE', nrscSTAGE);
    KW.AddKeyWord('!CHECK', nrscCHECK);
    KW.AddKeyWord('!PUBLISHEDIN', nrscPUBLISHEDIN);
    KW.AddKeyWord('!PREFIX', nrscPREFIX);
    KW.AddKeyWord('!TERRITORY', nrscTERRITORY);
    KW.AddKeyWord('!NORM', nrscNORM);
    KW.AddKeyWord('!PREACTIVE', nrscPREACTIVE);
    KW.AddKeyWord('!MOJNOTREG', nrscMOJNOTREG);
    KW.AddKeyWord('!OBJPATH', nrscOBJPATH);
    KW.AddKeyWord('!OBJTOPIC', nrscOBJTOPIC);
    KW.AddKeyWord('!OBJTYPE', nrscOBJTYPE);
    KW.AddKeyWord('!PRICELEVEL', nrscPRICELEVEL);
  finally
   Result := l3Free(KW);
  end;{try..finally}
 end
 else
  Result := l3System.GlobalObjects.Items[NSRCKeyWordsIndex];
end;

end.
