unit RTFtypes;

{ $Id: rtftypes.PAS,v 1.82 2015/10/15 11:13:12 dinishev Exp $ }

// $Log: rtftypes.PAS,v $
// Revision 1.82  2015/10/15 11:13:12  dinishev
// {Requestlink:609602166}
//
// Revision 1.81  2015/10/08 08:35:15  dinishev
// {Requestlink:588548123}. Все уже придумано до нас, нужно только научиться это использовать.
//
// Revision 1.80  2015/09/08 07:30:18  dinishev
// {Requestlink:606634250}. Читаем картинки из \sv
//
// Revision 1.79  2015/08/27 14:53:09  dinishev
// {Requestlink:606138650}
//
// Revision 1.78  2015/08/27 12:07:18  lulin
// {RequestLink:605842696}
//
// Revision 1.77  2015/08/21 13:23:19  dinishev
// {Requestlink:605843892}
//
// Revision 1.76  2015/08/07 10:33:45  dinishev
// {Requestlink:603416415}
//
// Revision 1.75  2015/08/06 14:22:22  dinishev
// {Requestlink:603416415}
//
// Revision 1.74  2015/08/05 15:33:09  dinishev
// {Requestlink:603416415}
//
// Revision 1.73  2015/07/07 15:01:19  dinishev
// {Requestlink:601462517}
//
// Revision 1.72  2015/05/21 14:13:14  dinishev
// {Requestlink:600084540}
//
// Revision 1.71  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.70  2015/03/24 09:10:44  dinishev
// Задел на будущее.
//
// Revision 1.69  2015/03/23 07:18:56  dinishev
// Правки по результатам тестов.
//
// Revision 1.68  2015/03/20 11:11:17  dinishev
// {Requestlink:591142760}
//
// Revision 1.67  2015/03/20 08:47:51  dinishev
// {Requestlink:591142760}. Закоммител перед генерацией.
//
// Revision 1.66  2015/03/19 12:20:45  dinishev
// Bug fix: немножко подразнес.
//
// Revision 1.65  2015/03/19 12:13:23  dinishev
// {Requestlink:591142760}
//
// Revision 1.64  2015/03/19 09:48:00  dinishev
// {Requestlink:591142760}. Заокоммител, пока компилируется.
//
// Revision 1.63  2015/03/12 07:02:40  dinishev
// {Requestlink:590745463}
//
// Revision 1.62  2015/02/09 14:50:59  dinishev
// Флаг ReadWMFIfExists для чтения WMF картинок вместо PNG, если информация о них есть в nonshppict
//
// Revision 1.61  2014/11/10 14:18:53  dinishev
// {Requestlink:571646843}. Пытаемся игнрорировать лишний текст.
//
// Revision 1.60  2014/06/05 09:48:25  dinishev
// {Requestlink:540414514}
//
// Revision 1.59  2014/05/21 12:14:30  dinishev
// {Requestlink:535902713}
//
// Revision 1.58  2014/04/14 12:05:58  dinishev
// {Requestlink:528446913}
//
// Revision 1.57  2014/04/08 08:18:20  dinishev
// {Requestlink:526715670}
//
// Revision 1.56  2014/04/03 10:35:36  dinishev
// {Requestlink:526715670}. Учимся читать формат картинки из RTF.
//
// Revision 1.55  2014/01/10 12:35:45  dinishev
// {Requestlink:510621098}. "Картинки" дорисовал, теперь будут отлаживать.
//
// Revision 1.54  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.53  2013/10/16 11:11:23  dinishev
// {Requestlink:493324121}
//
// Revision 1.52  2013/10/16 09:23:06  dinishev
// {Requestlink:493324121}
//
// Revision 1.51  2013/08/27 10:35:04  dinishev
// {Requestlink:479402808}
//
// Revision 1.50  2013/07/19 09:59:19  dinishev
// {Requestlink:466752604}. Нарисованы TdestNorm и его наследники на модели. Нарисован TddBreak на модели.
//
// Revision 1.49  2013/07/16 11:11:17  dinishev
// {Requestlink:422512540}. Вычистил отстаки костылей.
//
// Revision 1.48  2013/07/12 10:37:37  dinishev
// {Requestlink:422512540}
//
// Revision 1.47  2013/07/10 08:59:34  dinishev
// {Requestlink:449678171}
//
// Revision 1.46  2013/05/16 11:42:27  dinishev
// {Requestlink:453164226}. Поддержка чтения \lastrow \irown и игнорирование группы с \nonesttables
//
// Revision 1.45  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.44  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.43  2013/02/06 09:41:56  narry
// Поддержка команды \brdrtbl
//
// Revision 1.42  2013/01/30 11:51:57  narry
// исправление непрошедших тестов Арчи
//
// Revision 1.41  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.40  2012/11/09 08:52:29  narry
// Скрытый текст в исходных файлах (407750788)
//
// Revision 1.39  2012/06/26 13:56:16  narry
// Распознавание текста из фреймов
//
// Revision 1.38  2011/09/21 12:30:06  narry
// Пропадают куски текста при форматировании (285510478)
//
// Revision 1.37  2011/04/15 12:41:27  narry
// Обрезать картинку (262636436)
//
// Revision 1.36  2011/02/09 11:34:21  narry
// К253657673. Чтение картинок из RTF
//
// Revision 1.35  2009/06/24 11:11:48  narry
// - русско-японские RTF от OpenOffice
//
// Revision 1.34  2008/05/12 11:43:40  narry
// - поиски пропавшего сегмента
// - рсширение списка констант
//
// Revision 1.33  2008/04/22 10:09:20  narry
// - текст некоторых полей пропадал
//
// Revision 1.32  2008/04/10 10:59:13  narry
// - импорт абзацных отступов для элементов списка
//
// Revision 1.31  2008/04/09 13:51:15  narry
// - рефакторинг
// - замена символов буллета на (*, о, #)
//
// Revision 1.30  2008/03/14 11:36:55  narry
// - борьба с попаданием разрыва страницы внутрь абзаца
//
// Revision 1.29  2006/01/05 15:02:45  narry
// - новое: чтение объединенных по горизонтали ячеек (не совсем корректно)
//
// Revision 1.28  2005/12/06 14:37:35  narry
// - ошибка: AV при обработке вложенных таблиц
// - заточка: обработка таблицы стилей
//
// Revision 1.27  2004/01/21 16:11:41  narry
// - update
//
// Revision 1.26  2004/01/16 10:08:57  narry
// - new: игнорирование дубликата картинки
//
// Revision 1.25  2003/05/15 11:45:13  narry
// - add: поддержка табуляций
//
// Revision 1.24  2003/04/30 12:42:05  narry
// - add: константа rtfTwip
// - change: замена 1440 на rtfTwip
//
// Revision 1.23  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.22  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.21  2002/05/29 14:29:31  narry
// - bug fix, update and new behavior
//
// Revision 1.20  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.19  2001/09/28 07:11:28  narry
// - bug fix: были ошибки в курсоре для списка строк.
//
// Revision 1.18  2001/04/10 10:54:46  narry
// Update - добавлено новый тип
//
// Revision 1.17  2001/03/02 11:52:35  narry
// Update for ddHTML_r
//
// Revision 1.16  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  Classes,
  l3Interfaces;

const
  UseParam    = Low(Longint);

Type
  TRTfBool = (boolFalse, boolTrue, boolNotDefined);
  TAnime = (atNone, atLasVegas, atBlnkBkg, atSparkle,
            atBlackAnts, atRedAnts, atShimmer, atNotDefined);

  TddStyleDef = (sdParagraph, sdCharacter, sdSection);

  TUnderline = (utNone, utThick, utDotted, utDash, utDotDash, utDotDotDash,
                utDouble, utWord, utWave, utNotDefined);

  TSBK = (sbkNon, sbkCol, sbkEvn, sbkOdd, sbkPg, sbkNotDefined);
  TPGN = (pgDec, pgURom, pgLRom, pgULtr, pgLLtr, pgNotDefined);

  TRDS = (rdsSkip, rdsNorm, rdsFontTable, rdsStyleSheet, rdsColorTable,
           rdsFalt, rdsHeader, rdsFooter, rdsFName, rdsFootnote, rdsPicture,
           rdsPanose,  rdsPictureProp, rdsField, rdsFieldInstruction, rdsFieldResult,
           rdsFormField, rdsFormFieldItem,
           rdsInfo, rdsTitle, rdsAuthor, rdsOperator, rdsCreaTim, rdsRevTim,
           rdsCompany, rdsUpr, rdsParaNum, rdsAnnotation, rdsNone, rdsListText,
           rdsBookmarkStart, rdsBookmarkEnd, rdsParaNumbered, rdsSkipGroup,
           rdsShp, rdsShpInst, rdsShpRslt, rdsShpTxt, rdsListTable, rdsListLevel, rdsLevelText,
           rdsList, rdsListOverride, rdsListOverridetable, rdsListPicture, rdsListStylename,
           rdsListName, rdsLevelNumbers, rdsOldParaNumbering, rdsLFOlevel, rdsShpGrp, rdsSv, rdsSp);

  TRTFPictureSkip = (rtf_psNo, rtf_psYes, rtf_psWMF);         

          { Rtf Destination State   }
  TRIS = ( risNorm, risBin, risHex );       { Rtf Internal State     }

  TShadingType = (stNone, stHoriz, stVert, stDiag, stCross, stDCross,
                  stDkHor, stDkVert, stDkfDiag, stDkbDiag, stDkCross );
  TStrikeType = (srtNone, srtSingle, srtDouble);
  TCharCapsType  = (ccNone, ccAllCaps, ccSmallCaps, ccNotDefined);
  TContourType   = (ctNone, ctEmbo, ctEngrave, ctNotDefined);
  TACTN = (actnSpec, actnByte, actnWord);

  TPropType = (propNone, propChp, propPap, propSep, propDop, propStyle,
               propRow, propCell, propFrame, propFont, propTAB, propPict,
               propFormField, propLevel, propList, propColorTable,
               propNestedCell, propNestedRow, propShape);
               
  TRTFSubject = Integer;

  TddBreakType = (breakPage, breakColumn, breakSection);
  TCharPosition = (cpNone, cpSuperScript, cpSubScript, cpNotDefined);
  TddParagraphProperties = (dd_xaLeft, dd_xaRight, dd_xaFirst, dd_Before,
                            dd_After, dd_InTable, dd_Between,
                            dd_Saving, dd_Hyph,  dd_Keep, dd_KeepWNext,
                            dd_NoLine, dd_BreakBefore, dd_SideBSide, dd_JUST,
                            dd_LineSpaceExact, dd_Box, dd_Style, dd_TrimText,
                            dd_Bullet, dd_ListItem, dd_ilvl, dd_itap, dd_posx, dd_posy, dd_absh, dd_absw);


{ What types of properties are there?                          }
  TIPROP = Integer;
const
  ipropNone = 0;
  { Common properties}
  ipropName     = 1;
  ipropNumber   = succ(ipropName);
  ipropHeight   = Succ(ipropNumber);
  ipropWidth    = Succ(ipropHeight);
  ipropTop      = Succ(ipropWidth);
  ipropLeft     = Succ(ipropTop);
  ipropBottom   = Succ(ipropLeft);
  ipropRight    = Succ(ipropBottom);
  ipropColorF   = Succ(ipropRight);
  ipropColorB   = Succ(ipropColorF);
  ipropLang     = Succ(ipropColorB);
  ipropLineType = Succ(ipropLang);       { задается выбором из списка }
  ipropShading  = succ(ipropLineType);
  ipropSbk      = succ(ipropShading);
  ipropPard     = succ(ipropSbk);
  ipropSectd    = succ(ipropPard);
  ipropPlain    = succ(ipropSectd);
  ipropBorderWhere = succ(ipropPlain);   { задается выбором из списка }
  ipropScale    = succ(ipropBorderWhere);
  ipropDefault  = succ(ipropScale); { сброс параметров в значение по умолчанию }
  iproPAnsiCharSet  = succ(ipropDefault);
  ipropCodePage  = succ(iproPAnsiCharSet);
  ipropBrdrTbl   = succ(ipropCodePage); // Рамка есть, но в редакторе свойств она не выствлена, т.е. на чтение не влияет. См. http://mdp.garant.ru/pages/viewpage.action?pageId=479402808
  ipropBrdrNil   = succ(ipropBrdrTbl); // нет рамки
  ipropclwWidth  = succ(ipropBrdrNil); // Шириная ячейки 

  { Character properties }
  ipropAnime     = 100;
  ipropPos       = Succ(ipropAnime);
  ipropHighlight = Succ(ipropPos);
  ipropBold      = succ(ipropHighlight);
  ipropItalic    = succ(ipropBold);
  ipropUnderline = succ(ipropItalic);    { задается выбором из списка }
  iproPAnsiCharCaps  = succ(ipropUnderline); { задается выбором из списка }
  ipropHidden    = succ(iproPAnsiCharCaps);
  ipropDeleted   = succ(ipropHidden);
  iproPAnsiCharScale = succ(ipropDeleted);
  iproPAnsiCharpos   = succ(iproPAnsiCharScale); { задается выбором из списка }
  ipropContour   = succ(iproPAnsiCharPos);    { задается выбором из списка }
  ipropStriked   = succ(ipropContour);   { задается выбором из списка }
  ipropExpan     = succ(ipropStriked);
  ipropKerningSize = succ(ipropExpan);
  ipropUnicode   = succ(ipropKerningSize);
  ipropStrikeout = succ(ipropUnicode);

  { Section&Document properties }
  ipropCols      = 200;
  ipropLandscape = succ(ipropCols);
  ipropFacingp   = succ(ipropLandscape);
  ipropPgnStart  = succ(ipropFacingp);
  ipropPgnFormat = succ(ipropPgnStart);
  ipropEncoding  = succ(ipropPgnFormat);
  ipropRed       = succ(ipropEncoding);
  ipropGreen     = succ(ipropRed);
  ipropBlue      = succ(ipropGreen);
  ipropDefFont   = succ(ipropBlue);
  ipropDefLang   = succ(ipropDefFont);
  ipropDefTab    = succ(ipropDefLang);
  ipropVersion   = succ(ipropDefTab);
  ipropDay       = succ(ipropVersion);
  ipropMonth     = succ(ipropDay);
  ipropYear      = succ(ipropMonth);
  ipropHour      = succ(ipropYear);
  ipropMin       = succ(ipropHour);
  ipropedmins    = Succ(ipropMin);
  ipropnofpages  = Succ(ipropEdMins);
  ipropnofwords  = Succ(ipropNofPages);
  ipropnofchars  = Succ(ipropNofWords);
  ipropnofcharsws = Succ(ipropnofchars);
  ipropVern      = succ(ipropnofcharsws);
  ipropwidowctrl    = succ(ipropVern);
  ipropftnbj        = succ(ipropWidowCtrl);
  ipropaenddoc      = succ(ipropFtnBj);
  ipropnoxlattoyen  = succ(ipropAEndDoc);
  ipropexpshrtn     = succ(ipropNoxLattoyen);
  ipropnoultrlspc   = succ(ipropExpShrtn);
  ipropdntblnsbdb   = succ(ipropNoUltrLspc);
  ipropnospaceforul = succ(ipropdntblnsbdb);
  iprophyphcaps     = succ(ipropnospaceforul);
  ipropformshade    = succ(iprophyphcaps);
  ipropviewkind     = succ(ipropformshade);
  ipropviewscale    = succ(ipropviewkind);
  ipropviewzk       = succ(ipropviewscale);
  iproppgbrdrhead   = succ(ipropviewzk);
  iproppgbrdrfoot   = succ(iproppgbrdrhead);
  ipropfet          = succ(iproppgbrdrfoot);
  iproplinex        = succ(ipropfet);
  ipropendnhere     = succ(iproplinex);
  ipropBreak        = succ(ipropEndnhere);
  ipropUC           = succ(ipropBreak);      

  { Paragraph properties }
  ipropFirst          = 300;
  ipropJust           = succ(ipropFirst);{ задается выбором из списка }
  ipropMax            = succ(ipropJust);
  ipropHyph           = succ(ipropMax); { ???? }
  ipropInTable        = succ(ipropHyph);
  ipropKeep           = succ(ipropInTable);
  ipropKeepWNext      = succ(ipropKeep);
  ipropNoLine         = succ(ipropKeepWNext);
  ipropBreakBefore    = succ(ipropNoLine);
  ipropSideBSide      = succ(ipropBreakBefore);
  ipropBetween        = succ(ipropSideBSide);
  ipropLineSpaceExact = succ(ipropBetween);
  ipropTabKind        = succ(ipropLineSpaceExact);
  ipropTabLead        = succ(ipropTabKind);
  ipropTabBar         = succ(ipropTabLead);
  ipropTabSize        = succ(ipropTabBar);
  ipropLS             = succ(ipropTabSize);
  ipropLevel          = succ(ipropLS);
  ipropilvl           = succ(ipropLevel);
  ipropitap           = succ(ipropilvl);
  ipropposx           = succ(ipropitap);
  ipropposy           = succ(ipropposx);
  ipropabsh           = succ(ipropposy);
  ipropabsw           = succ(ipropabsh);

  { table properties }
  ipropMerged         = 400;
  ipropMergedFirst    = succ(ipropMerged);
  ipropVMerged        = succ(ipropMergedFirst);
  ipropVMergeFirst    = succ(ipropVMerged);
  ipropVertAlign      = succ(ipropVMergeFirst);
  ipropLast           = succ(ipropVertAlign);
  ipropirow           = succ(ipropLast);
  iproptrwWidthB      = succ(ipropirow);
  iproptrwWidthA      = succ(iproptrwWidthB);
  iproptrftsWidthA    = succ(iproptrwWidthA);
  iproptrftsWidthB    = succ(iproptrftsWidthA);

  { font properties }
  ipropFprq           = 500;
  ipropPanose         = succ(ipropFprq);
  ipropNonTaggedName  = succ(ipropPanose);
  ipropFontname       = succ(ipropNonTaggedName);
  ipropFontFamily     = succ(ipropFontName);

  { style properties }
  ipropParaStyle      = 600;
  iproPAnsiCharStyle  = succ(ipropParaStyle);
  ipropSectStyle      = succ(iproPAnsiCharStyle);
  ipropkeycode        = succ(ipropSectStyle);
  ipropkeys           = succ(ipropKeyCode);
  ipropkey            = succ(ipropKeys);
  ipropadditive       = succ(ipropKey);
  ipropbased          = succ(ipropAdditive);
  ipropnext           = succ(ipropBased);
  ipropautoupd        = succ(ipropNext);
  iproppersonal       = succ(ipropAutoUpd);
  ipropcompose        = succ(ipropPersonal);
  ipropreply          = succ(ipropCompose);

  { Picture properties }
  ipropScaleX         = 700;
  ipropScaleY         = succ(ipropScaleX);
  ipropSkipPicture    = succ(ipropScaleY);
  ipropPictType       = succ(ipropSkipPicture);
  ipropPicCropL       = succ(ipropPictType);
  ipropPicCropR       = succ(ipropPicCropL);
  ipropPicCropB       = succ(ipropPicCropR);
  ipropPicCropT       = succ(ipropPicCropB);
  ipropPicEMF         = succ(ipropPicCropT);
  ipropPicJPEG        = succ(ipropPicEMF);
  ipropPicPNG        = succ(ipropPicJPEG);
  ipropPicWMF        = succ(ipropPicPNG);
  ipropBin           = succ(ipropPicWMF);
  iproppicw          = succ(ipropBin);
  iproppich          = succ(iproppicw);

  { FormField properties }
  ipropFFDefRes       = 800;
  ipropFFRes          = succ(ipropFFDefRes);
  ipropFFType         = succ(ipropFFRes);

  { List Level properties}
  iproplevelpicturenosize	 = 1000;
  iproplisthybrid          = 1001;
  iproplistoverridestartat =	1002;
  iproplevelfollow         =	1003;
  iproplevelindent         =	1004;
  ipropleveljc             =	1005;
  ipropleveljcn            =	1006;
  iproplevellegal          =	1007;
  iproplevelnfc            =	1008;
  iproplevelnfcn           =	1009;
  iproplevelnorestart      =	1010;
  iproplevelold            =	1011;
  iproplevelpicture        = 	1012;
  iproplevelprev           =	1013;
  iproplevelprevspace      =	1014;
  iproplevelspace          =  1015;
  iproplevelstartat        = 	1016;
  ipropleveltemplateid     = 	1017;
  iproplistid              =	1018;
  iproplistoverridecount   =	1019;
  iproplistoverrideformat  = 	1020;
  iproplistrestarthdn      =	1021;
  iproplistsimple          = 	1022;
  ipropliststyleid         =	1023;
  iproplisttemplateid      =	1024;

const
  rsNone      = ord(propNone);
  rsDocument  = ord(propDOP);
  rsSection   = ord(propSEP);
  rsParagraph = ord(propPAP);
  rsChar      = ord(propCHP);
  rsRow       = ord(propRow);
  rsCell      = ord(propCell);
  rsFrame     = ord(propFrame);

  rtfTwip     = 1440;

type
  TrtfCharacterSet = (rtfANSI, rtfMac, rtfPC, rtfPCA);
  TFontFamily = (ffNil, ffRoman, ffSwiss, ffModern, ffScript, ffDecor,
                 ffTech, ffBidi, ffNotDefined);
  TFontType   = (ftNil, ftTrueType, ftNotDefined);
  TIPFN = (ipfnBin, ipfnHex, ipfnSkipDest);
  TIDEST = (idestPict, idestSkip);

  { RTF parser error codes }
  TRTFErrorCode =(
             ecOK,                     { Everything's fine!  }
             ecNotRTF,
             ecStackUnderflow,         (* Unmatched '}'       *)
             ecStackOverflow,          { Too many '{' -- memory exhausted }
             ecUnmatchedBrace,         { RTF ended during an open group.  }
             ecInvalidHex,             { invalid hex character found in data }
             ecBadTable,               { RTF table (sym or prop) invalid    }
             ecAssertion,              { Assertion failure           }
             ecEndOfFile,              { End of file reached while reading RTF }
             { statuses for RTFWriter }
             ecTableNotOpen,
             ecParaNotOpen,
             ecFileNotOpen,
             ecInvalidPropertyTarget,
             ecInvalidPicture
             );

  TddBorderType = (btNone,
                 btSingleThick,    {\brdrs}
                 btDoubleThick,    {\brdrth}
                 btShadowed,       {\brdrsh}
                 btDouble,         {\brdrdb}
                 btDotted,         {\brdrdot}
                 btDashed,         {\brdrdash}
                 btHairline,       {\brdrhair}
                 btDashSmall,      {\brdrdashsm}
                 btDotDash,        {\brdrdashd}
                 btDotDotDash,     {\brdrdashdd}
                 btTriple,         {\brdrtriple}
                 btThickThinS,     {\brdrtnthsg}
                 btThinThickS,     {\brdrthtnsg}
                 btThinThickThinS, {\brdrtnthtnsg}
                 btThickThinM,     {\brdrtnthmg}
                 btThinThickM,     {\brdrthtnmg}
                 btThinThickThinM, {\brdrtnthtnmg}
                 btThickThinL,     {\brdrtnthlg}
                 btThinThickL,     {\brdrthtnlg}
                 btThinThickThinL, {\brdrtnthtnlg}
                 btWavy,           {\brdrwavy}
                 btWavyDouble,     {\brdrwavydb}
                 btStriped,        {\brdrdashdotstr}
                 btEmboss,         {\brdremboss}
                 btEngrave,        {\brdrengrave}
                 btNotDefined
                 );

  TddBorderWhere = (bwNone, bwTop, bwLeft, bwBottom, bwRight, bwHorizontal,
                  bwVertical, bwBox, bwNotDefined);

  TddBorderParts = (bpTop, bpLeft, bpBottom, bpRight, bpHorizontal, bpVertical, bpBox);

const
  fValidMac  = $01;
  fValidDOS  = $02;
  fValidNTFS = $04;
  fValidHPFS = $08;
  fNetwork   = $10;
const
  symbolFootnote = -1;
  symbolRepeateText = 92;

const
//character set of a font in the font table
 fCharsetANSI              = 0;
 fCharsetDefault           = 1;
 fCharsetSymbol            = 2;
 fCharsetInvalid           = 3;
 fCharsetMac               = 77;
 fCharsetShiftJis          = 128;
 fCharsetHangul            = 129;
 fCharsetJohab             = 130;
 fCharsetGB2312            = 134;
 fCharsetBig5              = 136;
 fCharsetGreek             = 161;
 fCharsetTurkish           = 162;
 fCharsetVietnamese        = 163;
 fCharsetHebrew            = 177;
 fCharsetArabic            = 178;
 fCharsetArabicTraditional = 179;
 fCharsetArabicUser        = 180;
 fCharsetHebrewUser        = 181;
 fCharsetBaltic            = 186;
 fCharsetRussian           = 204;
 fCharsetThai              = 222;
 fCharsetEasternEuropean   = 238;
 fCharsetPC437             = 254;
 fCharsetOEM               = 255;

type
 TddFieldType = (
   dd_fieldUnknown
 , dd_fieldHyperlink
 , dd_fieldSymbol
 , dd_fieldForm
 , dd_fieldHyperlinkMailTo
 , dd_fieldPAGE
 );//TddFieldType

 TddFormulaRepresent = (
   dd_frUnknown,
   dd_frCharID,
   dd_frLessAndEqual,
   dd_frPlusMinus,
   dd_frMoreAndEqual,
   dd_frMultply,
   dd_frSumma,
   dd_frAny,
   dd_frExists
 );

const
 carCharID2FormualRepresent: array [AnsiChar] of TddFormulaRepresent = (dd_frUnknown, // 0
                                                  dd_frUnknown, // 1
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown, // 32
                                                  dd_frCharID,  // 33
                                                  dd_frAny,     // 34
                                                  dd_frCharID,  // 35
                                                  dd_frExists,  // 36
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frUnknown, // 39
                                                  dd_frCharID, // 40
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,  // 45
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID, // 50
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID, // 55
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID, // 60
                                                  dd_frCharID,
                                                  dd_frCharID,
                                                  dd_frCharID, // 63
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frLessAndEqual, //163
                                                  dd_frUnknown,
                                                  dd_frUnknown, //165
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown, // 175
                                                  dd_frUnknown, // 176
                                                  dd_frPlusMinus, // 177
                                                  dd_frUnknown,
                                                  dd_frMoreAndEqual, // 179
                                                  dd_frMultply, // 180
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown,
                                                  dd_frUnknown);

const
 csFontNameInField: Tl3PCharLenPrim = (S         : 'f';
                                       SLen      : 1;
                                       SCodePage : CP_ANSI
                                      );

 caFieldStrArray: array [TddFieldType] of Tl3PCharLenPrim = (
                                          (S         : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'HYPERLINK';
                                          SLen      : 9;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'SYMBOL';
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'FORMDROPDOWN';
                                          SLen      : 12;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'MAILTO';
                                          SLen      : 7;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'PAGE';
                                          SLen      : 4;
                                          SCodePage : CP_ANSI
                                          )
                                         );

 csFormulaRepresent: array [TddFormulaRepresent] of Tl3PCharLenPrim = (
                                          (S         : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : nil;
                                          SLen      : 0;
                                          SCodePage : CP_ANSI
                                          ), // dd_frCharID
                                          (S         : 'Symbol($2264)'; // dd_frLessAndEqual
                                          SLen      : 13;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Symbol(177)'; // dd_frPlusMins
                                          SLen      : 11;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Symbol($2265)'; // dd_frMoreAndEqual
                                          SLen      : 13;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Symbol(215)'; // dd_frMultply
                                          SLen      : 11;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Sigma'; // dd_frSumma
                                          SLen      : 5;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Any'; // dd_frAny
                                          SLen      : 3;
                                          SCodePage : CP_ANSI
                                          ),
                                          (S         : 'Exists'; // dd_frExists
                                          SLen      : 6;
                                          SCodePage : CP_ANSI
                                          )
                                         );

 cnHighDiv10 = High(Integer) div 10;

implementation

end.
