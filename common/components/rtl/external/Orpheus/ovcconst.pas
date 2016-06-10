{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCCONST.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
  {$R OVCCONST.R32}
{$ELSE}
  {$R OVCCONST.R16}
{$ENDIF}


unit OvcConst;
  {-Command and resource constants}

interface

const
  {value used to offset string resource id's}
  BaseOffset      = 32768; {***}

const
  {$I OVCCONST.INC} {also used by resource compiler}

type
 TovcCommandName = (
  _ccNone,
  _ccBack,
  _ccBotOfPage,
  _ccBotRightCell,
  _ccCompleteDate,
  _ccCompleteTime,
  _ccCopy,
  _ccCtrlChar,
  _ccCut,
  _ccDec,
  _ccDel,
  _ccDelBol,
  _ccDelEol,
  _ccDelLine,
  _ccDelWord,
  _ccDown,
  _ccEnd,
  _ccExtendDown,
  _ccExtendEnd,
  _ccExtendHome,
  _ccExtendLeft,
  _ccExtendPgDn,
  _ccExtendPgUp,
  _ccExtendRight,
  _ccExtendUp,
  _ccExtBotOfPage,
  _ccExtFirstPage,
  _ccExtLastPage,
  _ccExtTopOfPage,
  _ccExtWordLeft,
  _ccExtWordRight,
  _ccFirstPage,
  _ccGotoMarker0,
  _ccGotoMarker1,
  _ccGotoMarker2,
  _ccGotoMarker3,
  _ccGotoMarker4,
  _ccGotoMarker5,
  _ccGotoMarker6,
  _ccGotoMarker7,
  _ccGotoMarker8,
  _ccGotoMarker9,
  _ccHome,
  _ccInc,
  _ccIns,
  _ccLastPage,
  _ccLeft,
  _ccNewLine,
  _ccNextPage,
  _ccPageLeft,
  _ccPageRight,
  _ccPaste,
  _ccPrevPage,
  _ccRedo,
  _ccRestore,
  _ccRight,
  _ccScrollDown,
  _ccScrollUp,
  _ccSetMarker0,
  _ccSetMarker1,
  _ccSetMarker2,
  _ccSetMarker3,
  _ccSetMarker4,
  _ccSetMarker5,
  _ccSetMarker6,
  _ccSetMarker7,
  _ccSetMarker8,
  _ccSetMarker9,
  _ccTab,
  _ccTableEdit,
  _ccTopLeftCell,
  _ccTopOfPage,
  _ccUndo,
  _ccUp,
  _ccWordLeft,
  _ccWordRight,

  _ccSelect,
  _ccAllSelect,
  _ccAllDeselect,
  _ccAllInvSelect,
  _ccActionItem,

  _ccTreeExpand,
  _ccTreeAllExpand,
  _ccMoveLeft,
  _ccMoveRight,
  _ccMoveUp,
  _ccMoveDown,

  _ccStartSelBlock,
  _ccEndSelBlock,

  _ccFastFindNext,

  _ccDelWordLeft,
  _ccDelWordRight,

  _ccTreeCollapse
 );

const 
  {offset for resource id's}
  CommandResOfs  = BaseOffset + 1000; {***}

  {command codes - corresponding text offset by CommandOfs, stored in rc file}
  {*** must be contiguous ***}
  ccFirstCmd               =  0; {first defined command}
  ccNone                   =  0; {no command or not a known command}
  ccBack                   =  1; {backspace one character}
  ccBotOfPage              =  2; {move caret to end of last page}
  ccBotRightCell           =  3; {move to the bottom right hand cell in a table}
  ccCompleteDate           =  4; {use default date for current date sub field}
  ccCompleteTime           =  5; {use default time for current time sub field}
  ccCopy                   =  6; {copy highlighted text to clipboard}
  ccCtrlChar               =  7; {accept control character}
  ccCut                    =  8; {copy highlighted text to clipboard and delete it}
  ccDec                    =  9; {decrement the current entry field value}
  ccDel                    = 10; {delete current character}
  ccDelBol                 = 11; {delete from caret to beginning of line}
  ccDelEol                 = 12; {delete from caret to end of line}
  ccDelLine                = 13; {delete entire line}
  ccDelWord                = 14; {delete word to right of caret}
  ccDown                   = 15; {cursor down}
  ccEnd                    = 16; {caret to end of line}
  ccExtendDown             = 17; {extend selection down one line}
  ccExtendEnd              = 18; {extend highlight to end of field}
  ccExtendHome             = 19; {extend highlight to start of field}
  ccExtendLeft             = 20; {extend highlight left one character}
  ccExtendPgDn             = 21; {extend selection down one page}
  ccExtendPgUp             = 22; {extend selection up one page}
  ccExtendRight            = 23; {extend highlight right one character}
  ccExtendUp               = 24; {extend selection up one line}
  ccExtBotOfPage           = 25; {extend selection to bottom of page}
  ccExtFirstPage           = 26; {extend selection to first page}
  ccExtLastPage            = 27; {extend selection to last page}
  ccExtTopOfPage           = 28; {extend selection to top of page}
  ccExtWordLeft            = 29; {extend highlight left one word}
  ccExtWordRight           = 30; {extend highlight right one word}
  ccFirstPage              = 31; {first page in table}
  ccGotoMarker0            = 32; {editor & viewer, go to a position marker}
  ccGotoMarker1            = 33; {editor & viewer, go to a position marker}
  ccGotoMarker2            = 34; {editor & viewer, go to a position marker}
  ccGotoMarker3            = 35; {editor & viewer, go to a position marker}
  ccGotoMarker4            = 36; {editor & viewer, go to a position marker}
  ccGotoMarker5            = 37; {editor & viewer, go to a position marker}
  ccGotoMarker6            = 38; {editor & viewer, go to a position marker}
  ccGotoMarker7            = 39; {editor & viewer, go to a position marker}
  ccGotoMarker8            = 40; {editor & viewer, go to a position marker}
  ccGotoMarker9            = 41; {editor & viewer, go to a position marker}
  ccHome                   = 42; {caret to beginning of line}
  ccInc                    = 43; {increment the current entry field value}
  ccIns                    = 44; {toggle insert mode}
  ccLastPage               = 45; {last page in table}
  ccLeft                   = 46; {caret left by one character}
  ccNewLine                = 47; {editor, create a new line}
  ccNextPage               = 48; {next page in table}
  ccPageLeft               = 49; {move left a page in the table}
  ccPageRight              = 50; {move right a page in the table}
  ccPaste                  = 51; {paste text from clipboard}
  ccPrevPage               = 52; {previous page in table}
  ccRedo                   = 53; {re-do the last undone operation}
  ccRestore                = 54; {restore default and continue}
  ccRight                  = 55; {caret right by one character}
  ccScrollDown             = 56; {editor, scroll page up one line}
  ccScrollUp               = 57; {editor, scroll page down one line}
  ccSetMarker0             = 58; {editor & viewer, set a position marker}
  ccSetMarker1             = 59; {editor & viewer, set a position marker}
  ccSetMarker2             = 60; {editor & viewer, set a position marker}
  ccSetMarker3             = 61; {editor & viewer, set a position marker}
  ccSetMarker4             = 62; {editor & viewer, set a position marker}
  ccSetMarker5             = 63; {editor & viewer, set a position marker}
  ccSetMarker6             = 64; {editor & viewer, set a position marker}
  ccSetMarker7             = 65; {editor & viewer, set a position marker}
  ccSetMarker8             = 66; {editor & viewer, set a position marker}
  ccSetMarker9             = 67; {editor & viewer, set a position marker}
  ccTab                    = 68; {editor, for tab entry}
  ccTableEdit              = 69; {enter/exit table edit mode}
  ccTopLeftCell            = 70; {move to the top left cell in a table}
  ccTopOfPage              = 71; {move caret to beginning of first page}
  ccUndo                   = 72; {undo last operation}
  ccUp                     = 73; {cursor up}
  ccWordLeft               = 74; {caret left one word}
  ccWordRight              = 75; {caret right one word}

  ccSelect                 = 76;
  ccAllSelect              = 77;
  ccAllDeselect            = 78;
  ccAllInvSelect           = 79;
  ccActionItem             = 80;

  ccTreeExpand             = 81;
  ccTreeAllExpand          = 82;
  ccMoveLeft               = 83;
  ccMoveRight              = 84;
  ccMoveUp                 = 85;
  ccMoveDown               = 86;
  
  ccStartSelBlock          = 87;
  ccEndSelBlock            = 88;

  ccFastFindNext           = 89;

  ccDelWordLeft            = 90;
  ccDelWordRight           = 91;

  ccTreeCollapse           = 92;

  ccLastCmd                = 92; {***} {last interfaced command}
  ccMoveLeftInt            = ccLastCmd + 1;
  ccMoveRightInt           = ccLastCmd + 2;

  {internal}
  ccChar                   = 249; {regular character; generated internally}
  ccMouse                  = 250; {mouse selection; generated internally}
  ccMouseMove              = 251; {mouse move; generated internally}
  ccAccept                 = 252; {accept next key; internal}
  ccDblClk                 = 253; {mouse double click; generated internally}
  ccSuppress               = 254; {suppress next key; internal}
  ccPartial                = 255; {partial command; internal}
  ccShortCut               = 256;

  {user defined commands start here}
  ccUserFirst              = 257;
  ccUser0                  = ccUserFirst + 0;
  ccUser1                  = ccUserFirst + 1;
  ccUser2                  = ccUserFirst + 2;
  ccUser3                  = ccUserFirst + 3;
  ccUser4                  = ccUserFirst + 4;
  ccUser5                  = ccUserFirst + 5;
  ccUser6                  = ccUserFirst + 6;
  ccUser7                  = ccUserFirst + 7;
  ccUser8                  = ccUserFirst + 8;
  ccUser9                  = ccUserFirst + 9;
  {...                     = ccUserFirst + 65535 - ccUserFirst}
  
{data type base offset}
const
  DataTypeOfs              =  BaseOffset + 1300; {***}

{entry field data type sub codes}
const
  fsubString               =  0; {field subclass codes}
  fsubChar                 =  1;
  fsubBoolean              =  2;
  fsubYesNo                =  3;
  fsubLongInt              =  4;
  fsubWord                 =  5;
  fsubInteger              =  6;
  fsubByte                 =  7;
  fsubShortInt             =  8;
  fsubReal                 =  9;
  fsubExtended             = 10;
  fsubDouble               = 11;
  fsubSingle               = 12;
  fsubComp                 = 13;
  fsubDate                 = 14;
  fsubTime                 = 15;


{constants for simple, picture, and numeric picture}
{mask samples used in the property editors}
const
  PictureMaskOfs           = BaseOffset + 1700; {***}

  {simple field mask characters}
  stsmFirst                = 34468;
  stsmLast                 = 34468 + 23;

  {numeric field picture masks}
  stnmFirst                = 34493;
  stnmLast                 = 34493 + 17;

  {picture field picture masks}
  stpmFirst                = 34518;
  stpmLast                 = 34518 + 23;

const
  {viewer/editor line selection cursor}
  crLineCursor             = BaseOffset - 100;

  {design-time tab selecting cursor id}
  crTabCursor              = BaseOffset - 101;

  {constants for bitmap resources for db array editors}
  bmArrow                  = BaseOffset - 102;
  bmEdit                   = BaseOffset - 103;
  bmInsert                 = BaseOffset - 104;

  {row/column move cursors for the table}
  crRowMove                = BaseOffset - 105;
  crColumnMove             = BaseOffset - 106;

  {bitmap for dialog button control}
  bmDots                   = BaseOffset - 107;

implementation

end.