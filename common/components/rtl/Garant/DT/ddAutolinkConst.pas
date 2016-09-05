unit ddAutolinkConst;

{ $Id: ddAutolinkConst.pas,v 1.2 2016/07/18 10:49:49 fireton Exp $ }

interface
uses
 DT_Types;

const
 sAutolinkDataFN = 'autolink.dat';
 cMaxCodex       = 40;

 cShortNameDictID      = -154;
 cSkippiesDictID       = -155;
 cCodexDictID          = -156;
 cCodexAbbrDictID      = -157;
 cCodexSpecials        = -158;
 cCodexKeywordsDictID  = -159;
 cStopWordsDictID      = -160;

 cs_Further = 1; // "далее"

 ctc_CodexName    = 0;
 ctc_Abbreviation = 1;
 ctc_DocumentID   = 2;
 ctc_Keywords     = 3;

 c_NoEdition = High(TDocID);

 sp_RusFed = '(РФ)|(Российской Федерации)';

implementation

end.