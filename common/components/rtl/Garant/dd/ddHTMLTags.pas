unit ddHTMLTags;

interface

uses
  // RTFTypes,
  ddTypes,
  
  l3Chars,
  l3Parser,
  l3Interfaces;

type
 TddHTMLParamID = (dd_paridUnknown,
                   dd_paridHREF,
                   dd_paridNAME,
                   dd_paridALIGN,
                   dd_paridVALIGN,
                   dd_paridWIDTH,
                   dd_paridCOLSPAN,
                   dd_paridROWSPAN,
                   dd_paridSTYLE,
                   dd_paridCLASS,
                   dd_paridCHARSET,
                   dd_paridSRC,
                   dd_paridBorderBottom,
                   dd_paridBorderTop,
                   dd_paridBorderLeft,
                   dd_paridBorderRight,
                   dd_paridID,
                   dd_paridTextTransform,
                   dd_paridFindNext
                   );

 TddHTMLParamType = (dd_parKey,
                     dd_parInteger,
                     dd_parString,
                     dd_parAlign,
                     dd_parVAlign,
                     dd_parCharet,
                     dd_parHREF,
                     dd_parHREFURL,
                     dd_parBorderPart,
                     dd_parTextTransform);

 TddHTMLParam = record
  case rType: TddHTMLParamType of
   dd_parKey: ( rKeyValue: TddHTMLParamID );
   dd_parInteger: ( rValue: Integer;
                    rIsPercent: Boolean );
   dd_parString: ( rStart: Integer;
                   rFinish: Integer );
   dd_parAlign: ( rAlign: TJUST );
   dd_parVAlign: ( rVAlign: TddCellJust );
   dd_parCharet: ( rCharset: Integer );
   dd_parHREF: (rDocID: Integer;
                rSubID: Integer;
                );
   dd_parHREFURL: ( rStartURL: Integer;
                   rFinishURL: Integer );
   dd_parBorderPart: ( rHasBorder: Boolean );
   dd_parTextTransform: ( rTransform: TddCharCapsType );
 end;

 THTMLTagRec = record
  TagName: AnsiString;
  TagID  : Integer;
 end;

const
 cp_UTF8 = -255;

type
 TddHTMLCodePage = (dd_cpWin1251,
                    dd_cpKOI8R,
                    dd_cpUTF8);

const
 csHTMLTextAlign: Tl3PCharLenPrim = (S         : 'TEXT-ALIGN:';
                                     SLen      : 11;
                                     SCodePage : CP_ANSI);

 carHTMLCodePage: array [TddHTMLCodePage] of Tl3PCharLenPrim = (
                                          (S         : 'WINDOWS-1251';
                                          SLen      : 12;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'KOI8-R';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'UTF-8';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          )
                                          );

 carHTMLAign: array [justL..justF] of Tl3PCharLenPrim = (
                                          (S         : 'LEFT';
                                          SLen      : 4;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'RIGHT';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'CENTER';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'JUSTIFY';
                                          SLen      : 7;
                                          SCodePage : CP_ANSI
                                          )
                                          );

 carHTMLVAign: array [TddCellJust] of Tl3PCharLenPrim = (
                                          (S         : 'TOP';
                                          SLen      : 3;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'MIDDLE';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'BOTTOM';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          )
                                          );

 cnHTMLParamLast = High(TddHTMLParamID);

 carHTMLBorderStyle: Tl3PCharLenPrim = (S         : 'solid';
                                        SLen      : 5;
                                        SCodePage : CP_ANSI);

 carHTMLTransform: array [TddCharCapsType] of Tl3PCharLenPrim = (
                                          (S         : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI),
                                          (S         : 'UPPERCASE';
                                          SLen      : 9;
                                          SCodePage : CP_ANSI),
                                          (S         : 'LOWERCASE';
                                          SLen      : 9;
                                          SCodePage : CP_ANSI)
                                          );

 carHTMLParamStrArray: array [TddHTMLParamID] of Tl3PCharLenPrim = (
                                          (S        : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'HREF';
                                          SLen      : 4;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'NAME';
                                          SLen      : 4;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'ALIGN';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'VALIGN';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'WIDTH';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'COLSPAN';
                                          SLen      : 7;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'ROWSPAN';
                                          SLen      : 7;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'STYLE';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'CLASS';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'CHARSET';
                                          SLen      : 7;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'SRC';
                                          SLen      : 3;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'BORDER-BOTTOM';
                                          SLen      : 13;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'BORDER-TOP';
                                          SLen      : 10;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'BORDER-LEFT';
                                          SLen      : 11;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'BORDER-RIGHT';
                                          SLen      : 12;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'ID';
                                          SLen      : 2;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'TEXT-TRANSFORM';
                                          SLen      : 14;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI
                                          )
                                          );

 htmlWordChars = l3_DefaultParserWordChars + ['<', '/','_', cc_Tab]{ + cc_ANSIRussian +cc_Digits} ;
 htmlWhiteSpace = l3_DefaultParserWhiteSpace - [' ', '_', cc_Tab];// - htmlWordChars;


 tnHTML     = 'HTML';   tidHtml     = 1;
 tnP        = 'P';      tidP        = 2;
 tnPRE      = 'PRE';    tidPRE      = 3;
 tnB        = 'B';      tidB        = 4;
 tnSTRONG   = 'STRONG'; tidSTRONG   = 5;
 tnI        = 'I';      tidI        = 6;
 tnU        = 'U';      tidU        = 7;
 tnSPAN     = 'SPAN';   tidSPAN     = 8;
 tnFONT     = 'FONT';   tidFONT     = 9;
 tnH1       = 'H1';     tidH1       = 10;
 tnH2       = 'H2';     tidH2       = 11;
 tnH3       = 'H3';     tidH3       = 12;
 tnH4       = 'H4';     tidH4       = 13;
 tnTABLE    = 'TABLE';  tidTABLE    = 14;
 tnTR       = 'TR';     tidTR       = 15;
 tnTD       = 'TD';     tidTD       = 16;
 tnBR       = 'BR';     tidBR       = 17;
 tnUL       = 'UL';     tidUL       = 18;
 tnOL       = 'OL';     tidOL       = 19;
 tnLI       = 'LI';     tidLI       = 20;
 tnBODY     = 'BODY';   tidBODY     = 21;
 tnMETA     = 'META';   tidMETA     = 22;
 tnTITLE    = 'TITLE';  tidTITLE    = 23;
 tnDIV      = 'DIV';    tidDIV      = 24;
 tnSTYLE    = 'STYLE';  tidSTYLE    = 25;
 tnIMG      = 'IMG';    tidIMG      = 26;
 tnA        = 'A';      tidA        = 27;
 tnHEAD     = 'HEAD';   tidHEAD     = 28;
 tnHR       = 'HR';     tidHR       = 29;
 tnH        = 'H';      tidH        = 30;
 thTH       = 'TH';     tidTH       = 31;
 thSCRIPT   = 'SCRIPT'; tidSCRIPT   = 32;
 thTBODY    = 'TBODY';  tidTBODY    = 33;
 thTFOOT    = 'TFOOT';  tidTFOOT    = 34;
 thTHEAD    = 'THEAD';  tidTHEAD    = 35;
 thINS      = 'INS';    tidINS      = 36;
 thDEL      = 'DEL';    tidDEL      = 37;
 thSUP      = 'SUP';    tidSUP      = 38;
 thSUB      = 'SUB';    tidSUB      = 39;

const
 cMaxHTMLTag = 38;
 cHTMLTags : array[0..cMaxHTMLTag] of THTMLTagRec =
  (
   (TagName: tnHtml;   TagID: tidHTML),
   (TagName: tnP;      TagID: tidP),
   (TagName: tnPRE;    TagID: tidPRE),
   (TagName: tnB;      TagID: tidB),
   (TagName: tnSTRONG; TagID: tidSTRONG),
   (TagName: tnI;      TagID: tidI),
   (TagName: tnU;      TagID: tidU),
   (TagName: tnSPAN;   TagID: tidSPAN),
   (TagName: tnFONT;   TagID: tidFONT),
   (TagName: tnH1;     TagID: tidH1),
   (TagName: tnH2;     TagID: tidH2),
   (TagName: tnH3;     TagID: tidH3),
   (TagName: tnH4;     TagID: tidH4),
   (TagName: tnTABLE;  TagID: tidTABLE),
   (TagName: tnTR;     TagID: tidTR),
   (TagName: tnTD;     TagID: tidTD),
   (TagName: tnBR;     TagID: tidBR),
   (TagName: tnUL;     TagID: tidUL),
   (TagName: tnOL;     TagID: tidOL),
   (TagName: tnLI;     TagID: tidLI),
   (TagName: tnBODY;   TagID: tidBODY),
   (TagName: tnMETA;   TagID: tidMETA),
   (TagName: tnTITLE;  TagID: tidTITLE),
   (TagName: tnDIV;    TagID: tidDIV),
   (TagName: tnSTYLE;  TagID: tidSTYLE),
   (TagName: tnIMG;    TagID: tidIMG),
   (TagName: tnA;      TagID: tidA),
   (TagName: tnHEAD;   TagID: tidHEAD),
   (TagName: tnHR;     TagID: tidHR),
   (TagName: tnH;      TagID: tidH),
   (TagName: thTH;     TagID: tidTH),
   (TagName: thSCRIPT; TagID: tidSCRIPT),
   (TagName: thTBODY;  TagID: tidTBODY),
   (TagName: thTFOOT;  TagID: tidTFOOT),
   (TagName: thTHEAD; TagID: tidTHEAD),
   (TagName: thINS;    TagID: tidINS),
   (TagName: thDEL;    TagID: tidDEL),
   (TagName: thSUP;    TagID: tidSUP),
   (TagName: thSUB;    TagID: tidSUB)
  );

type
 TddCSSTagType = (dd_cssFontSize,
                  dd_cssFontFamily,
                  dd_cssFontWeight,
                  dd_cssFontStyle,
                  dd_cssColor,
                  dd_cssBackgroundColor,
                  dd_cssMarginLeft,
                  dd_cssMarginRight,
                  dd_cssMarginTop,
                  dd_cssMarginBottom,
                  dd_cssMargin,
                  dd_csTextAlign);

 TddCSSValueType = (css_vtNone, css_vtPixel, css_vtPoint, css_vtCM, css_vtInch, css_vtPercent);

const
 carCSSParamStrArray: array [TddCSSTagType] of Tl3PCharLenPrim = (
                                          (S         : 'font-size';
                                          SLen       : 9;
                                          SCodePage  : CP_ANSI
                                          ),
                                          (S         : 'font-family';
                                          SLen       : 11;
                                          SCodePage  : CP_ANSI
                                          ),
                                          (S        : 'font-weight';
                                          SLen      : 11;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'font-style';
                                          SLen      : 10;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'color';
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'background-color';
                                          SLen      : 16;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'margin-left';
                                          SLen      : 11;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'margin-right';
                                          SLen      : 12;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'margin-top';
                                          SLen      : 10;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'margin-bottom';
                                          SLen      : 13;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'margin';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S        : 'text-align';
                                          SLen      : 10;
                                          SCodePage : CP_ANSI
                                          )
                                          );

  casCSSNotBold: Tl3PCharLenPrim = (S         : 'normal';
                                    SLen      : 6;
                                    SCodePage : CP_ANSI);

  carCSSValueTypeArray: array [css_vtPixel..css_vtPercent] of Tl3PCharLenPrim = (
                                         (S        : 'px';
                                         SLen      : 2;
                                         SCodePage : CP_ANSI
                                         ),
                                        (S         : 'pt';
                                        SLen      : 2;
                                        SCodePage : CP_ANSI
                                        ),
                                        (S         : 'cm';
                                        SLen      : 2;
                                        SCodePage : CP_ANSI
                                        ),
                                        (S         : 'in';
                                        SLen      : 2;
                                        SCodePage : CP_ANSI
                                        ),
                                        (S         : '%';
                                        SLen      : 1;
                                        SCodePage : CP_ANSI
                                        )
                                       );

  function ddHTMLCodePage2CodePage(aValue: TddHTMLCodePage): Integer;

implementation

  function ddHTMLCodePage2CodePage(aValue: TddHTMLCodePage): Integer;
  begin
   case aValue of
    dd_cpKOI8R: Result := cp_koi8;
    dd_cpUTF8: Result := CP_UTF8;
    else
     Result := cp_Ansi;
   end;
  end;

end.
