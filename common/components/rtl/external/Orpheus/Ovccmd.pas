unit OvcCmd;
 {* Translates messages into commands. }

{*********************************************************}
{*                   OVCCMD.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{ $Id: Ovccmd.pas,v 1.42 2014/11/25 08:39:54 morozov Exp $ }

// $Log: Ovccmd.pas,v $
// Revision 1.42  2014/11/25 08:39:54  morozov
// {RequestLink: 565477492}
//
// Revision 1.41  2014/07/01 05:49:30  morozov
// {RequestLink: 340174500}
//
// Revision 1.40  2014/02/17 16:26:07  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.39  2013/04/04 11:34:26  lulin
// - портируем.
//
// Revision 1.38  2008/02/12 12:53:13  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.37  2007/11/01 07:39:22  mmorozov
// - new: новая ovc-команда ccTreeCollapse (в рамках работы над CQ: OIT5-27189);
//
// Revision 1.36  2006/07/04 10:51:20  oman
// - fix: Если контрол публикует операцию, то он должен перестать
//  обрабатывать соответствующую команду.
//
// Revision 1.35  2006/06/08 13:38:12  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.34  2005/09/20 14:27:17  voba
// - add новая команда ccTreeAllExpand открыть все ветки (Ctrl +)
//
// Revision 1.33  2005/02/21 11:41:26  fireton
// - bug fix: не компилялся allArchiComponents7
//
// Revision 1.32  2005/01/28 12:52:05  voba
// -new beh. : DoOnUserCommand теперь  function
//
// Revision 1.31  2005/01/17 09:50:01  lulin
// - добавлены директивы CVS.
//

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

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Forms, Menus, Messages, SysUtils,
  OvcConst, OvcData, OvcExcpt, OvcMisc,
  OvcKeyDataListenerList,
  l3Types,
  l3InternalInterfaces,
  l3Base,
  l3ProtoPersistent
  ;


ResourceString
  scUnknownTable       = '(Unknown)';
  scDefaultTableName   = 'Default';
  scWordStarTableName  = 'WordStar';
  scListTableName      = 'List';
  scGridTableName      = 'Grid';

const
  {$IfDef Nemesis}
  ovcTextEditorCommands : array [0..0] of AnsiString = (scDefaultTableName);
  {$Else  Nemesis}
  ovcTextEditorCommands : array [0..1] of AnsiString = (scDefaultTableName, scWordStarTableName);
  {$EndIf Nemesis}
  ovcListCommands       : array [0..1] of AnsiString = (scListTableName, scDefaultTableName);

  {default primary command/key table}
  DefMaxCommands = 66;
  DefCommandTable : array[0..DefMaxCommands-1] of TOvcCmdRec = (
 {Key #1          Shift state #1
  Key #2          Shift state #2              Command}
 (Key1:VK_LEFT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLeft),
 (Key1:VK_RIGHT;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRight),
 (Key1:VK_LEFT;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccWordLeft),
 (Key1:VK_RIGHT;  SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccWordRight),
 (Key1:VK_HOME;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccHome),
 (Key1:VK_END;    SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccEnd),
 (Key1:VK_DELETE; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDel),
 (Key1:VK_BACK;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBack),
 (Key1:VK_BACK;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBack),
 (Key1:VK_PRIOR;  SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTopOfPage),
 (Key1:VK_NEXT;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBotOfPage),
 (Key1:VK_INSERT; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccIns),
 (Key1:VK_Z;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccUndo),
 (Key1:VK_BACK;   SS1:ss_Alt;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRestore),
 (Key1:VK_UP;     SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccUp),
 (Key1:VK_DOWN;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDown),
 (Key1:VK_RETURN; SS1:ss_None;                                
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccNewLine),
 (Key1:VK_LEFT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendLeft),
 (Key1:VK_RIGHT;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendRight),
 (Key1:VK_HOME;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendHome),
 (Key1:VK_END;    SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendEnd),
 (Key1:VK_LEFT;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtWordLeft),
 (Key1:VK_RIGHT;  SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtWordRight),
 (Key1:VK_PRIOR;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgUp),
 (Key1:VK_NEXT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgDn),
 (Key1:VK_UP;     SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendUp),
 (Key1:VK_DOWN;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendDown),
 (Key1:VK_HOME;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtFirstPage),
 (Key1:VK_END;    SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtLastPage),
 (Key1:VK_PRIOR;  SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtTopOfPage),
 (Key1:VK_NEXT;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtBotOfPage),
 (Key1:VK_DELETE; SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCut),
 (Key1:VK_X;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCut),
 (Key1:VK_INSERT; SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCopy),
 (Key1:VK_C;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCopy),
 (Key1:VK_INSERT; SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPaste),
 (Key1:VK_V;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPaste),
 (Key1:VK_PRIOR;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPrevPage),
 (Key1:VK_NEXT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccNextPage),
 (Key1:VK_HOME;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccFirstPage),
 (Key1:VK_END;    SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLastPage),
 (Key1:VK_TAB;    SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTab),
 (Key1:VK_TAB;    SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTab),
 (Key1:VK_Z;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRedo),
 (Key1:VK_BACK;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDelWordLeft),
 (Key1:VK_DELETE;    SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDelWordRight),
 (Key1:VK_0;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker0),
 (Key1:VK_1;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker1),
 (Key1:VK_2;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker2),
 (Key1:VK_3;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker3),
 (Key1:VK_4;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker4),
 (Key1:VK_5;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker5),
 (Key1:VK_6;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker6),
 (Key1:VK_7;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker7),
 (Key1:VK_8;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker8),
 (Key1:VK_9;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccGotoMarker9),
 (Key1:VK_0;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker0),
 (Key1:VK_1;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker1),
 (Key1:VK_2;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker2),
 (Key1:VK_3;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker3),
 (Key1:VK_4;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker4),
 (Key1:VK_5;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker5),
 (Key1:VK_6;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker6),
 (Key1:VK_7;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker7),
 (Key1:VK_8;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker8),
 (Key1:VK_9;      SS1:ss_Ctrl+ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccSetMarker9));

 {V}
  DefListMaxCommands = 36;
  DefListCommandTable : array[0..DefListMaxCommands-1] of TOvcCmdRec = (
 {Key #1          Shift state #1
  Key #2          Shift state #2              Command}
 (Key1:VK_LEFT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLeft),
 (Key1:VK_RIGHT;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRight),
 (Key1:VK_HOME;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccHome),
 (Key1:VK_END;    SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccEnd),
 (Key1:VK_UP;     SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccUp),
 (Key1:VK_DOWN;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDown),
 (Key1:VK_LEFT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendLeft),
 (Key1:VK_RIGHT;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendRight),
 (Key1:VK_HOME;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendHome),
 (Key1:VK_END;    SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendEnd),
 (Key1:VK_PRIOR;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgUp),
 (Key1:VK_NEXT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgDn),
 (Key1:VK_UP;     SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendUp),
 (Key1:VK_DOWN;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendDown),
 (Key1:VK_HOME;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtFirstPage),
 (Key1:VK_END;    SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtLastPage),
 (Key1:VK_PRIOR;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPrevPage),
 (Key1:VK_NEXT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccNextPage),
 (Key1:VK_HOME;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccFirstPage),
 (Key1:VK_END;    SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLastPage),
 (Key1:VK_DELETE; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDel),
 (Key1:VK_INSERT; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccIns),
 (Key1:VK_Space;    SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccSelect),
 (Key1:VK_A;        SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccAllSelect),
 (Key1:VK_Subtract; SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccAllDeselect),
 (Key1:VK_Multiply; SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccAllInvselect),
 (Key1:VK_Return;   SS1:ss_None;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccActionItem),
 (Key1:VK_Return;   SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccActionItem),

 (Key1:VK_Add;      SS1:ss_None;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccTreeExpand),
 (Key1:VK_Add;      SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccTreeAllExpand),
 (Key1:VK_Left;     SS1:ss_Alt;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccMoveLeft),
 (Key1:VK_Right;    SS1:ss_Alt;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccMoveRight),
 (Key1:VK_Up;       SS1:ss_Alt;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccMoveUp),
 (Key1:VK_Down;     SS1:ss_Alt;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccMoveDown),

 (Key1:VK_DOWN;     SS1:ss_Ctrl;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccFastFindNext),
 (Key1:VK_SUBTRACT; SS1:ss_None;
  Key2:VK_NONE;     SS2:ss_None;              Cmd:ccTreeCollapse));


  {default WordStar command-key table}
  DefWsMaxCommands = 40 + 2{добавлены} - 14{удалены};
  DefWsCommandTable : array[0..DefWsMaxCommands-1] of TOvcCmdRec = (
 {Key #1          Shift state #1
  Key #2          Shift state #2              Command}
 {Удалены за ненадобностью
 (Key1:VK_S;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLeft),
 (Key1:VK_D;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRight),
 (Key1:VK_E;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccUp),
 (Key1:VK_X;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDown),
 (Key1:VK_R;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPrevPage),
 (Key1:VK_C;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccNextPage),
 (Key1:VK_W;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccScrollUp),
 (Key1:VK_Z;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccScrollDown),
 (Key1:VK_A;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccWordLeft),
 (Key1:VK_F;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccWordRight),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_S;      SS2:ss_Wordstar;            Cmd:ccHome),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_D;      SS2:ss_Wordstar;            Cmd:ccEnd),
 (Key1:VK_G;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDel),
 (Key1:VK_H;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBack),
 }
 (Key1:VK_Y;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDelLine),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_Y;      SS2:ss_Wordstar;            Cmd:ccDelEol),
 (Key1:VK_V;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccIns),
 (Key1:VK_T;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDelWord),
 (Key1:VK_P;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCtrlChar),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_L;      SS2:ss_Wordstar;            Cmd:ccRestore),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_0;      SS2:ss_Wordstar;            Cmd:ccGotoMarker0),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_1;      SS2:ss_Wordstar;            Cmd:ccGotoMarker1),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_2;      SS2:ss_Wordstar;            Cmd:ccGotoMarker2),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_3;      SS2:ss_Wordstar;            Cmd:ccGotoMarker3),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_4;      SS2:ss_Wordstar;            Cmd:ccGotoMarker4),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_5;      SS2:ss_Wordstar;            Cmd:ccGotoMarker5),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_6;      SS2:ss_Wordstar;            Cmd:ccGotoMarker6),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_7;      SS2:ss_Wordstar;            Cmd:ccGotoMarker7),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_8;      SS2:ss_Wordstar;            Cmd:ccGotoMarker8),
 (Key1:VK_Q;      SS1:ss_Ctrl;
  Key2:VK_9;      SS2:ss_Wordstar;            Cmd:ccGotoMarker9),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_0;      SS2:ss_Wordstar;            Cmd:ccSetMarker0),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_1;      SS2:ss_Wordstar;            Cmd:ccSetMarker1),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_2;      SS2:ss_Wordstar;            Cmd:ccSetMarker2),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_3;      SS2:ss_Wordstar;            Cmd:ccSetMarker3),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_4;      SS2:ss_Wordstar;            Cmd:ccSetMarker4),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_5;      SS2:ss_Wordstar;            Cmd:ccSetMarker5),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_6;      SS2:ss_Wordstar;            Cmd:ccSetMarker6),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_7;      SS2:ss_Wordstar;            Cmd:ccSetMarker7),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_8;      SS2:ss_Wordstar;            Cmd:ccSetMarker8),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_9;      SS2:ss_Wordstar;            Cmd:ccSetMarker9),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_B;      SS2:ss_Wordstar;            Cmd:ccStartSelBlock),
 (Key1:VK_K;      SS1:ss_Ctrl;
  Key2:VK_K;      SS2:ss_Wordstar;            Cmd:ccEndSelBlock));

  {default Orpheus Table command/key table}
  DefGridMaxCommands = 38;
  DefGridCommandTable : array[0..DefGridMaxCommands-1] of TOvcCmdRec = (
 {Key #1          Shift state #1
  Key #2          Shift state #2              Command}
 (Key1:VK_LEFT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLeft),
 (Key1:VK_RIGHT;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRight),
 (Key1:VK_LEFT;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPageLeft),
 (Key1:VK_RIGHT;  SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPageRight),
 (Key1:VK_HOME;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccHome),
 (Key1:VK_END;    SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccEnd),
 (Key1:VK_DELETE; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDel),
 (Key1:VK_BACK;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBack),
 (Key1:VK_NEXT;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBotOfPage),
 (Key1:VK_PRIOR;  SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTopOfPage),
 (Key1:VK_INSERT; SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccIns),
 (Key1:VK_Z;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccRestore),
 (Key1:VK_UP;     SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccUp),
 (Key1:VK_DOWN;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccDown),
 (Key1:VK_LEFT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendLeft),
 (Key1:VK_RIGHT;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendRight),
 (Key1:VK_HOME;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendHome),
 (Key1:VK_END;    SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendEnd),
 (Key1:VK_LEFT;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtWordLeft),
 (Key1:VK_RIGHT;  SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtWordRight),
 (Key1:VK_PRIOR;  SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgUp),
 (Key1:VK_NEXT;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendPgDn),
 (Key1:VK_UP;     SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendUp),
 (Key1:VK_DOWN;   SS1:ss_Shift;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtendDown),
 (Key1:VK_HOME;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtFirstPage),
 (Key1:VK_END;    SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtLastPage),
 (Key1:VK_PRIOR;  SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtTopOfPage),
 (Key1:VK_NEXT;   SS1:ss_Shift+ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccExtBotOfPage),
 (Key1:VK_X;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCut),
 (Key1:VK_C;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccCopy),
 (Key1:VK_V;      SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPaste),
 (Key1:VK_PRIOR;  SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccPrevPage),
 (Key1:VK_HOME;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccFirstPage),
 (Key1:VK_NEXT;   SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccNextPage),
 (Key1:VK_END;    SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccLastPage),
 (Key1:VK_UP;     SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTopLeftCell),
 (Key1:VK_DOWN;   SS1:ss_Ctrl;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccBotRightCell),
 (Key1:VK_F2;     SS1:ss_None;
  Key2:VK_NONE;   SS2:ss_None;                Cmd:ccTableEdit));

type
  {command processor states}
  TState = (stNone, stPartial, stLiteral);

  {user command notify event}
  TUserCommandEvent =
    function(Sender : TObject; Command : Word) : boolean
    of object;

  {forward class declarations}
  TOvcCommandProcessor = class;

  TOvcCommandTable = class(TPersistent)
  {.Z+}
  protected {private}
    FActive      : Boolean; {true to use this command table}
    FCommandList : TList;   {list of command/key mappings}
    FTableName   : AnsiString;  {the name of this command table}

    {property methods}
    function GetCmdRec(Index : Integer) : TOvcCmdRec;
      {-return the list item corresponding to "Index"}
    function GetCount : Integer;
      {-return the number of records in the list}
    procedure PutCmdRec(Index : Integer; const CR : TOvcCmdRec);
      {-store a new command entry to the list at "Index" position}

    {internal methods}
    procedure ctDisposeCommandEntry(P : POvcCmdRec);
      {-dispose of a command entry record}
    function ctNewCommandEntry(const CR : TOvcCmdRec): POvcCmdRec;
      {-allocate a new command entry record}
    procedure ctReadData(Reader : TReader);
      {-called to read the table from the stream}
    procedure ctWriteData(Writer : TWriter);
      {-called to store the table on the stream}

  protected
    procedure DefineProperties(Filer : TFiler);
      override;
  {.Z-}

  public
    constructor Create;
    destructor Destroy;
      override;

    function AddRec(const CR : TOvcCmdRec) : Integer;
      {-add a record to the list}
    procedure Clear;
      {-delete all records from the list}
    procedure Delete(Index : Integer);
      {-delete a record from the list}
    procedure Exchange(Index1, Index2 : Integer);
      {-exchange list locations of the two specified records}
    function IndexOf(const CR : TOvcCmdRec) : Integer;
      {-return the index of the specified record}
    procedure InsertRec(Index : Integer; const CR : TOvcCmdRec);
      {-insert a record at the specified index}
    procedure LoadFromFile(const FileName: AnsiString);
      {-read command entries from a text file}
    procedure Move(CurIndex, NewIndex : Integer);
      {-move one record to anothers index location}
    procedure SaveToFile(const FileName: AnsiString);
      {-write command entries to a text file}

    property Commands[Index : Integer] : TOvcCmdRec
      read GetCmdRec
      write PutCmdRec;
      default;

    property Count : Integer
      read GetCount
      stored False;

    property IsActive : Boolean
      read FActive
      write FActive;

    property TableName : AnsiString
      read FTableName
      write FTableName;
  end;

  TOvcExtCommandHandler = function (Command : Word) : Boolean of object;
  TOvcExtGlobalKeyHandler = function(aKeyCode: Byte; aShiftFlags: Byte): Boolean of object;


  TOvcTablesArray = array of AnsiString;

  TOvcCommandProcessor = class(Tl3ProtoPersistent, Il3CommandProcessor)
  {.Z+}
  protected {private}
    {property variables}
    f_LastTime        : Cardinal;
    f_LastCommand     : Word;
    f_LastCommands    : TStringArray;
    f_LastTable       : AnsiString;

    f_KeyDataListeners: TOvcKeyDataListenerList;

    FTableList        : TList;    {list of command tables}
    FExtTableName     : AnsiString;   {external table name}
    FStopExtTableName : AnsiString;   {таблица исключений для external table}
    FOnExtCommand     : TOvcExtCommandHandler;

    {internal variables}
    cpState     : TState;   {current state}
    cpSaveKey   : Byte;     {saved last key processed}
    cpSaveSS    : Byte;     {saved shift key state}

    {property methods}
    function GetCount: Integer;
      {-return the number of tables in the list}
    function GetTable(Index : Integer) : TOvcCommandTable;
      {-return the table referenced by "Index"}
    procedure SetTable(Index : Integer; CT : TOvcCommandTable);
      {-store a command table at position "Index"}

    {internal methods}
    function cpFillCommandRec(Key1, ShiftState1,
                              Key2, ShiftState2 : Byte;
                              Command : Word) : TOvcCmdRec;
      {-fill a command record}
    procedure cpReadData(Reader: TReader);
      {-called to read the command processor from the stream}
    function cpScanTable(CT : TOvcCommandTable; Key, SFlags : Byte) : Word;
      {-Scan the command table for a match}
    procedure cpWriteData(Writer: TWriter);
      {-called to store the command processor to the stream}
    function ProcessKeyDataListeners(aKey: Byte; aShiftFlags: Byte): Boolean;
      {-}
  protected
    procedure DefineProperties(Filer: TFiler);
      override;

  public
    constructor Create;
      reintroduce;
    procedure Cleanup;
      override;
{.Z-}

    procedure Add(CT : TOvcCommandTable);
      {-add a command table to the list of tables}
    procedure AddCommand(const TableName: AnsiString;
                         Key1, ShiftState1,
                         Key2, ShiftState2 : Byte;
                         Command : Word);
      overload;
      {-add a command and key sequence to the command table}
    function  AddCommand(const TableName : AnsiString;
                         Key1            : Byte;
                         ShiftState1     : TShiftState = [];
                         Key2            : Byte = 0;
                         ShiftState2     : TShiftState = [];
                         Command         : Word = ccNone): Word;
      overload;
      {-add a command and key sequence to the command table}
    procedure AddCommandRec(const TableName: AnsiString; const CR : TOvcCmdRec);
      {-add a command record to the command table}
    procedure ChangeTableName(const OldName, NewName: AnsiString);
      {-change the name of a table}
    procedure Clear;
      virtual;
      {-delete all tables from the list}
    function CreateCommandTable(const TableName : AnsiString; Active : Boolean) : Integer;
      {-create a command table and add it to the table list}
    procedure Delete(Index : Integer);
      {-delete the "Index" table from the list of tables}
    procedure DeleteCommand(const TableName   : AnsiString;
                            Key1              : Byte;
                            ShiftState1       : Byte = ss_None;
                            Key2              : Byte = 0;
                            ShiftState2       : Byte = ss_None);
      {-delete a command and key sequence from a command table}
    procedure DeleteCommandTable(const TableName : AnsiString);
      {-delete a command table and remove it from the table list}
    procedure Exchange(Index1, Index2 : Integer);
      {-exchange list locations of the two specified command tables}
    function GetCommandCount(const TableName : AnsiString) : Integer;
      {-return the number of commands in the command table}
    function GetCommandTable(const TableName : AnsiString) : TOvcCommandTable;
      {-return a pointer to the specified command table or nil}
    procedure GetState(var State : TState; var Key, Shift : Byte);
      {-return the current status of the command processor}
    function GetCommandTableIndex(const TableName : AnsiString) : Integer;
      {-return index to the specified command table or -1 for failure}
    function LoadCommandTable(const FileName : AnsiString) : Integer; virtual;
      {-creates and then fills a command table from a text file}
    procedure ResetCommandProcessor;
      {-reset the command processor}
    procedure SaveCommandTable(const TableName, FileName : AnsiString); virtual;
      {-save a command table to a text file}
    procedure SetScanPriority(const Names : array of AnsiString);
      {-reorder the list of tables based on this array}
    procedure SetState(State : TState; Key, Shift : Byte);
      {-set the state to the command processor}
    function GetTables: TOvcTablesArray;
      {-}
    function Translate(var Msg       : TMessage;
                       aTime         : Cardinal = 0;
                       const aTarget : Il3CommandTarget = nil) : Word;
      {-translate a message into a command}
    function TranslateUsing(const Tables  : array of AnsiString;
                            var Msg       : TMessage;
                            aTime         : Cardinal;
                            const aTarget : Il3CommandTarget = nil) : Word;
      {-translate a message into a command using the given tables}
    function TranslateKey(Key : Word; ShiftState : TShiftState) : Word;
      {-translate a key and shift-state into a command}
    function TranslateKeyUsing(Tables : array of AnsiString; Key : Word; ShiftState : TShiftState) : Word;
      {-translate a key and shift-state into a command using the given tables}
    procedure SubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
      {-}
    procedure UnsubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
      {-}
    property Count: Integer
      read GetCount
      stored False;

    property Table[Index : Integer]: TOvcCommandTable
      read GetTable
      write SetTable;
      default;

    property ExtTableName: AnsiString
      read FExtTableName
      write FExtTableName;

    property StopExtTableName: AnsiString
      read FStopExtTableName
      write FStopExtTableName;

    property OnExtCommand: TOvcExtCommandHandler
      read FOnExtCommand
      write FOnExtCommand;
 
  end;

function OvcByteShift(aShift: TShiftState): Byte;

implementation


function OvcByteShift(aShift: TShiftState): Byte;
begin
 result := ss_None;
 if ssShift in aShift then
  result := result or ss_Shift;
 if ssCtrl in aShift then
  result := result or ss_Ctrl;
 if ssAlt in aShift then
  result := result or ss_Alt;
end;

{*** TOvcCommandTable ***}

function TOvcCommandTable.AddRec(const CR : TOvcCmdRec) : Integer;
begin
  Result := GetCount;
  InsertRec(Result, CR);
end;

procedure TOvcCommandTable.Clear;
var
  I: Integer;
begin
  {dispose of all command records in the list}
  for I := 0 to FCommandList.Count - 1 do
    ctDisposeCommandEntry(FCommandList[I]);
  {clear the list entries}
  FCommandList.Clear;
end;

constructor TOvcCommandTable.Create;
begin
  inherited Create;
  FTableName := scUnknownTable;
  FActive := True;
  FCommandList := TList.Create;
end;

procedure TOvcCommandTable.ctDisposeCommandEntry(P : POvcCmdRec);
begin
  if Assigned(P) then
    FreeMem(P, SizeOf(TOvcCmdRec));
end;

function TOvcCommandTable.ctNewCommandEntry(const CR : TOvcCmdRec): POvcCmdRec;
begin
  GetMem(Result, SizeOf(TOvcCmdRec));
  Result^ := CR;
end;

procedure TOvcCommandTable.ctReadData(Reader : TReader);
var
  CR  : TOvcCmdRec;

  procedure ReadAndCompareTable(CT : array of TOvcCmdRec);
  var
    I   : Integer;
    Idx : Integer;
  begin
    {add all records initially}
    for I := 0 to High(CT) do
      AddRec(CT[I]);

    while not Reader.EndOfList do begin
      with CR, Reader do begin
        Keys := ReadInteger;
        Cmd := ReadInteger;
      end;
      {if keys on stream are dups replace default with redefinition}
      Idx := IndexOf(CR);
      if Idx > -1 then begin
        {if assigned to ccNone, remove instead of replace}
        if CR.Cmd = ccNone then
          Delete(Idx)
        else
          Commands[Idx] := CR
      end else
        AddRec(CR);
    end;
  end;

begin
  FTableName := Reader.ReadString;
  FActive := Reader.ReadBoolean;
  Reader.ReadListBegin;
  Clear;

  if CompareText(scDefaultTableName, FTableName) = 0 then
    {if this is the "default" table, fill it with default commands}
    ReadAndCompareTable(DefCommandTable)
  else if CompareText(scWordStarTableName, FTableName) = 0 then
    {if this is the "wordstar" table, fill it with default commands}
    ReadAndCompareTable(DefWsCommandTable)
  else if CompareText(scGridTableName, FTableName) = 0 then
    {if this is the "grid" table, fill it with default commands}
    ReadAndCompareTable(DefGridCommandTable)
  else if CompareText(scListTableName, FTableName) = 0 then
    {if this is the "grid" table, fill it with default commands}
    ReadAndCompareTable(DefListCommandTable)

  else begin
  {otherwise, load complete command table from stream}
    while not Reader.EndOfList do begin
      with CR, Reader do begin
        Keys := ReadInteger;
        Cmd := ReadInteger;
      end;
      AddRec(CR);
    end;
  end;

  Reader.ReadListEnd;
end;

procedure TOvcCommandTable.ctWriteData(Writer : TWriter);
var
  I  : Integer;
  CR : TOvcCmdRec;

  procedure CompareAndWriteTable(CT : array of TOvcCmdRec);
  var
    I, J : Integer;
    Idx  : Integer;
  begin
    {find commands in the CT table but missing from this table}
    for I := 0 to High(CT) do begin
      Idx := IndexOf(CT[I]);
      if Idx = -1 then begin
        {not found, store and assign to ccNone}
        with CT[I], Writer do begin
          WriteInteger(Keys);
          WriteInteger(ccNone);
        end;
      end;
    end;

    {store all commands in new table if they are additions to the CT table}
    for I := 0 to Count - 1 do begin
      CR := GetCmdRec(I);
      {search CT for a match}
      Idx := -1;
      for J := 0 to High(CT) do begin
        if (CR.Keys = CT[J].Keys) and (CR.Cmd = CT[J].Cmd) then begin
          Idx := J;
          Break;
        end;
      end;
      if Idx = -1 then begin
        {not found, store it}
        with CR, Writer do begin
          WriteInteger(Keys);
          WriteInteger(Cmd);
        end;
      end;
    end;
  end;

begin
  Writer.WriteString(FTableName);
  Writer.WriteBoolean(FActive);
  Writer.WriteListBegin;

  {if this is the default command table, don't store command if not changed}
  if CompareText(scDefaultTableName, FTableName) = 0 then
    {if this is the "default" command table, don't store commands if not changed}
    CompareAndWriteTable(DefCommandTable)
  else if CompareText(scWordStarTableName, FTableName) = 0 then
    {if this is the "wordstar" command table, don't store commands if not changed}
    CompareAndWriteTable(DefWsCommandTable)
  else if CompareText(scGridTableName, FTableName) = 0 then
    {if this is the "grid" command table, don't store commands if not changed}
    CompareAndWriteTable(DefGridCommandTable)
  else if CompareText(scListTableName, FTableName) = 0 then
    {if this is the "grid" command table, don't store commands if not changed}
    CompareAndWriteTable(DefListCommandTable)
  else begin
    {otherwise, save the complete table}
    for I := 0 to Count - 1 do begin
      CR := GetCmdRec(I);
      with CR, Writer do begin
        WriteInteger(Keys);
        WriteInteger(Cmd);
      end;
    end;
  end;

  Writer.WriteListEnd;
end;

procedure TOvcCommandTable.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('CommandList', ctReadData, ctWriteData, Count > 0);
end;

procedure TOvcCommandTable.Delete(Index : Integer);
begin
  ctDisposeCommandEntry(FCommandList[Index]);
  FCommandList.Delete(Index);
end;

destructor TOvcCommandTable.Destroy;
begin
  Clear;
  FCommandList.Free;
  FCommandList := nil;
  inherited;
end;

procedure TOvcCommandTable.Exchange(Index1, Index2 : Integer);
begin
  FCommandList.Exchange(Index1, Index2);
end;

function TOvcCommandTable.GetCmdRec(Index : Integer) : TOvcCmdRec;
begin
  Result := POvcCmdRec(FCommandList[Index])^;
end;

function TOvcCommandTable.GetCount : Integer;
begin
  Result := FCommandList.Count;
end;

function TOvcCommandTable.IndexOf(const CR : TOvcCmdRec) : Integer;
begin
  for Result := 0 to GetCount - 1 do
    if CR.Keys = GetCmdRec(Result).Keys then
      Exit;
  Result := -1;
end;

procedure TOvcCommandTable.InsertRec(Index : Integer; const CR : TOvcCmdRec);
begin
  FCommandList.Expand.Insert(Index, ctNewCommandEntry(CR));
end;

procedure TOvcCommandTable.LoadFromFile(const FileName: AnsiString);
var
  T  : System.Text;
  CR : TOvcCmdRec;
begin
  Clear;  {erase current contents of list}
  System.Assign(T, FileName);
  System.Reset(T);
  try {finally}
    ReadLn(T, FTableName);  {get table name}
    while not Eof(T) do begin
      with CR do ReadLn(T, Key1, SS1, Key2, SS2, Cmd);
      AddRec(CR);
    end;
  finally
    System.Close(T);
  end;
end;

procedure TOvcCommandTable.Move(CurIndex, NewIndex : Integer);
var
  CR : TOvcCmdRec;
begin
  if CurIndex <> NewIndex then begin
    CR := GetCmdRec(CurIndex);
    Delete(CurIndex);
    InsertRec(NewIndex, CR);
  end;
end;

procedure TOvcCommandTable.PutCmdRec(Index : Integer; const CR : TOvcCmdRec);
var
  P : POvcCmdRec;
begin
  P := FCommandList[Index];
  try
    FCommandList[Index] := ctNewCommandEntry(CR);
  finally
    ctDisposeCommandEntry(P);
  end;
end;

procedure TOvcCommandTable.SaveToFile(const FileName: AnsiString);
var
  T  : System.Text;
  I  : Integer;
  CR : TOvcCmdRec;
begin
  System.Assign(T, FileName);
  System.Rewrite(T);
  try {finally}
    System.WriteLn(T, FTableName);  {save the table name}
    for I := 0 to Count-1 do begin
      CR := GetCmdRec(I);
      with CR do
        System.WriteLn(T, Key1:4, SS1:4, Key2:4, SS2:4, Cmd:6);
    end;
  finally
    System.Close(T);
  end;
end;


{*** TCommandProcessor ***}

procedure TOvcCommandProcessor.Add(CT : TOvcCommandTable);
  {-add a command table to the list of tables}
var
  I    : Integer;
  Base : AnsiString;
  Name : AnsiString;
begin
  {make sure the table name is unique}
  I := 0;

  Base := CT.TableName;

  {remove trailing numbers from the name, forming the base name}
  while (Length(Base) > 1) and (Base[Length(Base)] in ['0'..'9']) do
    {$IFDEF Win32}
      {$IFOPT H+}
      SetLength(Base, Length(Base)-1);
      {$ELSE}
      Dec(Byte(Base[0]));
      {$ENDIF}
    {$ELSE}
    Dec(Byte(Base[0]));
    {$ENDIF}

  Name := Base;

  {keep appending numbers until we find a unique name}
  while GetCommandTable(Name) <> nil do begin
    Inc(I);
    Name := Base + Format('%d', [I]);
  end;
  if I > 0 then
    CT.TableName := Name;

  {add table to the list}
  FTableList.Add(CT);
end;

procedure TOvcCommandProcessor.AddCommand(const TableName: AnsiString;
                                          Key1, ShiftState1,
                                          Key2, ShiftState2 : Byte;
                                          Command : Word);
  {-add a command and key sequence to the command table}
var
  CR : TOvcCmdRec;
begin
  {fill temp command record}
  CR := cpFillCommandRec(Key1, ShiftState1, Key2, ShiftState2, Command);
  {add the command}
  AddCommandRec(TableName, CR);
end;

function TOvcCommandProcessor.AddCommand(const TableName : AnsiString;
                                         Key1            : Byte;
                                         ShiftState1     : TShiftState;
                                         Key2            : Byte;
                                         ShiftState2     : TShiftState;
                                         Command         : Word): Word;
  //overload;
  {-add a command and key sequence to the command table}
begin
 if (Command = ccNone) then
 begin
  while true do
  begin
   Command := Random(High(Command));
   if (Command = ccNone) OR (Command = ccAccept) OR (Command = ccShortCut) OR
      (Command = ccSuppress) OR (Command = ccChar) OR (Command = ccMouse) OR
      (Command = ccMouseMove) OR (Command = ccDblClk) OR (Command = ccPartial) then
    continue;
   try
    AddCommand(TableName, Key1, OvcByteShift(ShiftState1), Key2, OvcByteShift(ShiftState2), Command);
   except
    on EDuplicateCommand do
    begin
     Command := 0;
     continue;
    end;//on EDuplicateCommand
   end;//try..except
   break;
  end;//while true
 end//Command = ccNone
 else
  AddCommand(TableName, Key1, OvcByteShift(ShiftState1), Key2, OvcByteShift(ShiftState2), Command);
 Result := Command;
end;

procedure TOvcCommandProcessor.AddCommandRec(const TableName: AnsiString; const CR : TOvcCmdRec);
  {-add a command record to the command table}
var
  TmpTbl : TOvcCommandTable;
begin
  {get the command table pointer}
  TmpTbl := GetCommandTable(TableName);
  if Assigned(TmpTbl) then begin
    {does this key sequence conflict with any others}
    if TmpTbl.IndexOf(CR) = -1 then
      {add the new command-key sequence}
      TmpTbl.AddRec(CR)
    else
      raise EDuplicateCommand.Create;
  end else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.ChangeTableName(const OldName, NewName: AnsiString);
  {-change the name of a table}
var
  TmpTbl : TOvcCommandTable;
begin
  TmpTbl := GetCommandTable(OldName);
  if Assigned(TmpTbl) then
    TmpTbl.TableName := NewName
  else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.Clear;
  {-delete all tables from the list}
var
  I : Integer;
begin
  {dispose of all command tables in the list}
  for I := 0 to Count - 1 do
    TOvcCommandTable(FTableList[I]).Free;
  {clear the list entries}
  FTableList.Clear;
end;

function TOvcCommandProcessor.cpFillCommandRec(Key1, ShiftState1,
                                            Key2, ShiftState2 : Byte;
                                            Command : Word) : TOvcCmdRec;
  {-fill a command record}
begin
  Result.Key1 := Key1;
  Result.SS1 := ShiftState1;
  Result.Key2 := Key2;
  Result.SS2 := ShiftState2;
  Result.Cmd := Command;
end;

procedure TOvcCommandProcessor.cpReadData(Reader : TReader);
var
  TmpTbl : TOvcCommandTable;
begin
  {empty current table list}
  Clear;
  {read the start of list marker}
  Reader.ReadListBegin;
  while not Reader.EndOfList do begin
    {create a command table}
    TmpTbl := TOvcCommandTable.Create;
    {load commands into the table}
    TmpTbl.ctReadData(Reader);
    {add the new table to the table list}
    Add(TmpTbl);
  end;
  {read the end of list marker}
  Reader.ReadListEnd;
end;

function TOvcCommandProcessor.cpScanTable(CT : TOvcCommandTable; Key, SFlags : Byte) : Word;
  {-Scan the command table for a match}
var
  J : Integer;
begin
  {assume failed match}
  Result := ccNone;

  {scan the list of commands looking for a match}
  for J := 0 to CT.Count-1 do with CT[J] do begin

    {do we already have a partial command}
    if cpState = stPartial then begin
      {does first key/shift state match the saved key/shift state?}
      if (Key1 = cpSaveKey) and (SS1 = cpSaveSS) then
        {does the key match?}
        if (Key2 = Key) then
          {does the shift state match?}
          {or, is this the second key of a wordstar command}
          if (SS2 = SFlags) or ((SS2 = ss_Wordstar) and
             ((SFlags = ss_None) or (SFlags = ss_Ctrl))) then begin
            Result := Cmd;  {return the command}
            {if the command is ccCtrlChar, next key is literal}
            if Cmd = ccCtrlChar then
              cpState := stLiteral
            else
              cpState := stNone;
            Exit;
          end;
    end else if (Key1 = Key) and (SS1 = SFlags) then begin
      {we have an initial key match}
      if Key2 = 0 then begin
        {no second key}
        Result := Cmd;  {return the command}
        {if the command is ccCtrlChar, next key is literal}
        if Cmd = ccCtrlChar then
          cpState := stLiteral;
        Exit;
      end else begin
        {it's a partial command}
        Result := ccPartial;
        cpState := stPartial;

        {save the key and shift state}
        cpSaveKey := Key;
        cpSaveSS := SFlags;
        Exit;
      end;
    end;

  end;
end;

procedure TOvcCommandProcessor.cpWriteData(Writer: TWriter);
var
  I : Integer;
begin
  {write the start of list marker}
  Writer.WriteListBegin;
  {have each table write itself}
  for I := 0 to Count - 1 do
    TOvcCommandTable(FTableList[I]).ctWriteData(Writer);
  {write the end of list marker}
  Writer.WriteListEnd;
end;

function TOvcCommandProcessor.ProcessKeyDataListeners(aKey: Byte; aShiftFlags: Byte): Boolean;
var
 l_Handled: Boolean;

 function lp_DoNotifyListener(anItem: PIl3KeyDataListener; anIndex: Integer): Boolean;
 var
  l_Listener: Il3KeyDataListener;
 begin
  l_Listener := anItem^;
  Assert(l_Listener <> nil);
  try
   if l_Listener.ProcessKeyData(aKey, aShiftFlags) then
    l_Handled := True;
  finally
   l_Listener := nil;
  end;
  Result := True;
 end;//lp_DoNotifyListener

begin
 l_Handled := False;
 try
  f_KeyDataListeners.IterateAllF(l3L2IA(@lp_DoNotifyListener));
 except
  on E: Exception do
  begin
    Assert(False, E.Message);
  end;
 end;
 Result := l_Handled;
end;

constructor TOvcCommandProcessor.Create;
var
  I : Integer;
  S : AnsiString;
begin
  inherited Create;

  f_KeyDataListeners := TOvcKeyDataListenerList.Create;

  {create an empty command table list}
  FTableList  := TList.Create;

  {create and fill the default command table}
  S := scDefaultTableName;
  CreateCommandTable(S, True);
  for I := 0 to DefMaxCommands-1 do
    AddCommandRec(S, DefCommandTable[I]);

  {create and fill the WordStar command table}
  S := scWordStarTableName;
  CreateCommandTable(S, False {not active});
  for I := 0 to DefWsMaxCommands-1 do
    AddCommandRec(S, DefWsCommandTable[I]);

  {create and fill the List command table}
  S := scListTableName;
  CreateCommandTable(S, False {not active});
  for I := 0 to DefListMaxCommands-1 do
    AddCommandRec(S, DefListCommandTable[I]);

  {create and fill the Grid command table}
  S := scGridTableName;
  CreateCommandTable(S, False {not active});
  for I := 0 to DefGridMaxCommands-1 do
    AddCommandRec(S, DefGridCommandTable[I]);

  ResetCommandProcessor;
end;

function TOvcCommandProcessor.CreateCommandTable(const TableName : AnsiString; Active : Boolean) : Integer;
  {-create a command table and add it to the table list}
var
  TmpTbl : TOvcCommandTable;
begin
  TmpTbl := TOvcCommandTable.Create;
  TmpTbl.TableName := TableName;
  TmpTbl.IsActive := Active;
  Add(TmpTbl);
  Result := FTableList.IndexOf(TmpTbl);
end;

procedure TOvcCommandProcessor.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('TableList', cpReadData, cpWriteData, Count > 0);
end;

procedure TOvcCommandProcessor.Delete(Index : Integer);
  {-delete the "Index" table from the list of tables}
begin
  if (Index >= 0) and (Index < Count) then begin
    {delete the command table}
    TOvcCommandTable(FTableList[Index]).Free;
    {remove it from the list}
    FTableList.Delete(Index);
  end else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.DeleteCommand(const TableName   : AnsiString;
                                             Key1              : Byte;
                                             ShiftState1       : Byte = 0;
                                             Key2              : Byte = 0;
                                             ShiftState2       : Byte = ss_None);
var
  I      : Integer;
  CR     : TOvcCmdRec;
  TmpTbl : TOvcCommandTable;
begin
  {get the command table pointer}
  TmpTbl := GetCommandTable(TableName);
  if Assigned(TmpTbl) then begin
    {fill temp command record}
    CR := cpFillCommandRec(Key1, ShiftState1, Key2, ShiftState2, 0);
    {find index of entry}
    I := TmpTbl.IndexOf(CR);
    {if found, delete it -- no error if not found}
    if I > -1 then
      TmpTbl.Delete(I);
  end else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.DeleteCommandTable(const TableName : AnsiString);
  {-delete a command table and remove from the table list}
var
  I      : Integer;
  TmpTbl : TOvcCommandTable;
begin
  TmpTbl := GetCommandTable(TableName);;
  if Assigned(TmpTbl) then begin
    I := FTableList.IndexOf(TmpTbl);
    Delete(I);
  end else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.Cleanup;
begin
  if Assigned(FTableList) then begin
    Clear;
    FTableList.Free;
  end;
  FreeAndNil(f_KeyDataListeners);  
  inherited;
end;

procedure TOvcCommandProcessor.Exchange(Index1, Index2 : Integer);
  {-exchange list locations of the two specified command tables}
begin
  FTableList.Exchange(Index1, Index2);
end;

function TOvcCommandProcessor.GetTable(Index : Integer) : TOvcCommandTable;
  {-return the table referenced by "Index"}
begin
  Result := TOvcCommandTable(FTableList[Index]);
end;

function TOvcCommandProcessor.GetCommandCount(const TableName : AnsiString) : Integer;
  {-return the number of commands in the command table}
var
  TmpTbl : TOvcCommandTable;
begin
  {get the command table pointer}
  TmpTbl := GetCommandTable(TableName);
  if Assigned(TmpTbl) then
    Result := TmpTbl.Count
  else
    raise ETableNotFound.Create;
end;

function TOvcCommandProcessor.GetCommandTable(const TableName : AnsiString) : TOvcCommandTable;
  {-return a pointer to the specified command table or nil}
var
  I : Integer;
begin
  Result := nil;
  for I := 0 To Count-1 do
    if UpperCase(TOvcCommandTable(FTableList[I]).TableName) = UpperCase(TableName) then begin
      Result := FTableList[I];
      Break;
    end;
end;

function TOvcCommandProcessor.GetCommandTableIndex(const TableName : AnsiString) : Integer;
  {-return index to the specified command table or -1 for failure}
var
  I : Integer;
begin
  Result := -1;
  for I := 0 To Count-1 do
    if UpperCase(TOvcCommandTable(FTableList[I]).TableName) = UpperCase(TableName) then begin
      Result := I;
      Break;
    end;
end;

function TOvcCommandProcessor.GetCount : Integer;
  {-return the number of tables in the list}
begin
  Result := FTableList.Count;
end;

procedure TOvcCommandProcessor.GetState(var State : TState; var Key, Shift : Byte);
begin
  State := cpState;
  Key := cpSaveKey;
  Shift := cpSaveSS;
end;

function TOvcCommandProcessor.LoadCommandTable(const FileName : AnsiString) : Integer;
  {-creates and then fills a command table from a text file}
var
  TmpTbl : TOvcCommandTable;
begin
  TmpTbl := TOvcCommandTable.Create;
  try
    TmpTbl.LoadFromFile(FileName);
    Add(TmpTbl);
    Result := FTableList.IndexOf(TmpTbl);
  except
    TmpTbl.Free;
    raise;
  end;
end;

procedure TOvcCommandProcessor.ResetCommandProcessor;
  {-reset the command processor}
begin
  cpState   := stNone;
  cpSaveKey := VK_NONE;
  cpSaveSS  := 0;
end;

procedure TOvcCommandProcessor.SaveCommandTable(const TableName, FileName : AnsiString);
  {-save a command table to a text file}
var
  TmpTbl : TOvcCommandTable;
begin
  TmpTbl := GetCommandTable(TableName);
  if Assigned(TmpTbl) then
    TmpTbl.SaveToFile(FileName);
end;

procedure TOvcCommandProcessor.SetScanPriority(const Names : array of AnsiString);
  {-reorder the list of tables based on this array}
var
  I      : Integer;
  Idx    : Integer;
  TmpTbl : TOvcCommandTable;
begin
  for I := 0 to Pred(High(Names)) do begin
    TmpTbl := GetCommandTable(Names[I]);
    if Assigned(TmpTbl) then begin
      Idx := FTableList.IndexOf(TmpTbl);
      if (Idx > -1) and (Idx <> I) then
        Exchange(I, Idx);
    end;
  end;
end;

procedure TOvcCommandProcessor.SetTable(Index : Integer; CT : TOvcCommandTable);
  {-store a command table at position "Index"}
var
  P : TOvcCommandTable;
begin
  if (Index >= 0) and (Index < Count) then begin
    P := FTableList[Index];
    FTableList[Index] := CT;
    P.Free;
  end else
    raise ETableNotFound.Create;
end;

procedure TOvcCommandProcessor.SetState(State : TState; Key, Shift : Byte);
begin
  cpState := State;
  cpSaveKey := Key;
  cpSaveSS := Shift;
end;

function TOvcCommandProcessor.GetTables: TOvcTablesArray;
  {-}
var
 l_Index : Integer;  
begin
 SetLength(Result, Count);
 for l_Index := 0 to Count-1 do
  with TOvcCommandTable(FTableList[l_Index]) do
   if IsActive then
    Result[l_Index] := TableName;
end;

function TOvcCommandProcessor.Translate(var Msg       : TMessage;
                                        aTime         : Cardinal = 0;
                                        const aTarget : Il3CommandTarget = nil) : Word;
  {-translate a message into a command}
begin
 Result := TranslateUsing(GetTables, Msg, aTime, aTarget);
end;

function TOvcCommandProcessor.TranslateKey(Key : Word; ShiftState : TShiftState) : Word;
  {-translate a key and shift-state into a command}
var
  Command : Word;
  I       : Integer;
  SS      : Byte;        {shift flags}
begin
  {accept the key if no match found}
  Result := ccAccept;

  {check for shift state keys, note partial status and exit}
  case Key of
    VK_SHIFT,     {shift}
    VK_CONTROL,   {ctrl}
    VK_ALT,       {alt}
    VK_CAPITAL,   {caps lock}
    VK_NUMLOCK,   {num lock}
    VK_SCROLL :   {scroll lock}
      begin
        {if we had a partial command before, we still do}
        if cpState = stPartial then
          Result := ccPartial;
        Exit;
      end;
  end;

  {exit if this key is to be interpreted literally}
  if cpState = stLiteral then begin
    cpState := stNone;
    Exit;
  end;

  {get the current shift flags}
  SS := (Ord(ssCtrl in ShiftState) * ss_Ctrl) +
        (Ord(ssShift in ShiftState) * ss_Shift) +
        (Ord(ssAlt in ShiftState) * ss_Alt);

  Command := ccNone;
  for I := 0 to Count-1 do
    if TOvcCommandTable(FTableList[I]).IsActive then begin
      Command := cpScanTable(FTableList[I], Key, SS);
      if Command <> ccNone then
        Break;
    end;

  {if we found a match, return command and exit}
  if Command <> ccNone then begin
    Result := Command;
    Exit;
  end;

  {if we had a partial command, suppress this key}
  if cpState = stPartial then
    Result:= ccSuppress;

  cpState := stNone;
end;

function TOvcCommandProcessor.TranslateUsing(const Tables  : array of AnsiString;
                                             var Msg       : TMessage;
                                             aTime         : Cardinal;
                                             const aTarget : Il3CommandTarget = nil) : Word;
  {-translate a message into a command using the given tables}
var
  TmpTbl   : TOvcCommandTable;
  Command  : Word;
  K        : Byte;        {message key code}
  SS       : Byte;        {shift flags}

 function lDoExtCommand: Bool;
  {find in external table}
 begin//lDoExtCommand
  Result := false;
  if Assigned(OnExtCommand) and (ExtTableName <> '') then
  begin
   TmpTbl := GetCommandTable(ExtTableName);
   if Assigned(TmpTbl) then
   begin
    Command := cpScanTable(TmpTbl, K, SS);
    if (Command <> ccNone) then
     if OnExtCommand(Command) then
     begin
      Result := true;
      cpState := stNone;
      TranslateUsing := ccShortCut;
      Command := ccShortCut;
     end
     else
      Command := ccNone;
   end;//Assigned(TmpTbl)
  end;//Assigned(OnExtCommand)..
 end;//lDoExtCommand

 function lDoCustomCommand: Word;
  {find in Tables}
 var
  I      : Integer;
  l_Name : AnsiString;
  l_Publisher: Il3CommandPublisherInfo;
 begin//lDoCustomCommand
  Result := ccNone;
  for I := 0 to High(Tables) do
  begin
   l_Name := Tables[I];
   if (cpState = stPartial) AND (f_LastTable <> l_Name) then
   begin
    Command := ccSuppress;
    continue;
   end;//cpState = stPartial..
   TmpTbl := GetCommandTable(l_Name);
   if Assigned(TmpTbl) then
   begin
    Command := cpScanTable(TmpTbl, K, SS);
    if (Command <> ccNone) then
    begin
     if (aTarget <> nil) then
     begin
      if Supports(aTarget, Il3CommandPublisherInfo, l_Publisher) and l_Publisher.IsCommandPublished(Command) then
       Command := ccNone
      else
      begin
       Result := Command;
       if aTarget.ProcessCommand(Command, false, Lo(TWMKey(Msg).KeyData)) then
        Command := ccShortCut
       else
        Command := ccNone;
      end;
     end;//aTarget <> nil
     f_LastTable := l_Name;
     Break;
    end;//Command <> ccNone
   end;//Assigned(TmpTbl)
  end;//for I
 end;//lDoCustomCommand

var
 l_Command : Word;
begin
 if (f_LastTime = aTime) AND l3StringArrayEQ(f_LastCommands, Tables) then
  // - это то же самое нажатие
 begin
  Result := f_LastCommand;
 end
 else
 try
  {accept the key if no match found}
  Result := ccAccept;

  {check for shift state keys, note partial status and exit}
  K := Lo(Msg.wParam);
  case K of
    VK_SHIFT,     {shift}
    VK_CONTROL,   {ctrl}
    VK_ALT,       {alt}
    VK_CAPITAL,   {caps lock}
    VK_NUMLOCK,   {num lock}
    VK_SCROLL :   {scroll lock}
      begin
        {if we had a partial command before, we still do}
        if cpState = stPartial then
          Result := ccPartial;
        Exit;
      end;
  end;//case K of

  {get out if this key is to be interpreted literally}
  if (cpState = stLiteral) then
  begin
    cpState := stNone;
    Exit;
  end;//cpState = stLiteral

  {get the current shift flags}
  SS := GetShiftFlags;

  if ProcessKeyDataListeners(K, SS) then
  begin
   cpState := stNone;
   TranslateUsing := ccShortCut;
   Command := ccShortCut;
   Exit;
  end;

  Command := ccNone;

  {find in stop external table}
  if (StopExtTableName <> '') then
  begin
   TmpTbl := GetCommandTable(StopExtTableName);
   if Assigned(TmpTbl) then
    Command := cpScanTable(TmpTbl, K, SS);
  end;//StopExtTableName <> ''

  if (Command <> ccNone) then
  begin
   Command := ccNone;
   if lDoExtCommand then
    // - это если VCM обработал
    Exit;
   lDoCustomCommand;
   // - передаем в контрол
  end//Command <> ccNone
  else
  begin
   l_Command := lDoCustomCommand;
   if (Command = ccNone) then
   begin
    // - это если контрол не обработал
    if not lDoExtCommand then
     // - передаем в VCM
     if (l_Command <> ccNone) AND (aTarget <> nil) then
     begin
      // - повторно передаем в контрол
      Command := l_Command;
      if aTarget.ProcessCommand(l_Command, true, Lo(TWMKey(Msg).KeyData)) then
       Command := ccShortCut
      else
       Command := ccNone;
     end;//aTarget <> nil
   end;//Command = ccNone
  end;//Command <> ccNone

  {if we found a match, return command and exit}
  if (Command <> ccNone) then
  begin
    Result := Command;
    Exit;
  end;//Command <> ccNone

  {if we had a partial command, suppress this key}
  if cpState = stPartial then
    Result := ccSuppress;

  cpState := stNone;
 finally
  f_LastTime := aTime;
  f_LastCommand := Result;
  f_LastCommands := l3StringArray(Tables);
 end;//try..finally
end;

function TOvcCommandProcessor.TranslateKeyUsing(Tables : array of AnsiString; Key : Word; ShiftState : TShiftState) : Word;
  {-translate a Key and shift-state into a command using the given tables}
var
  TmpTbl  : TOvcCommandTable;
  Command : Word;
  I       : Integer;
  SS      : Byte;        {shift flags}
begin
  {accept the key if no match found}
  Result := ccAccept;

  {check for shift state keys, note partial status and exit}
  case Key of
    VK_SHIFT,     {shift}
    VK_CONTROL,   {ctrl}
    VK_ALT,       {alt}
    VK_CAPITAL,   {caps lock}
    VK_NUMLOCK,   {num lock}
    VK_SCROLL :   {scroll lock}
      begin
        {if we had a partial command before, we still do}
        if cpState = stPartial then
          Result := ccPartial;
        Exit;
      end;
  end;

  {get out if this key is to be interpreted literally}
  if cpState = stLiteral then begin
    cpState := stNone;
    Exit;
  end;

  {get the shift flags}
  SS := (Ord(ssCtrl in ShiftState) * ss_Ctrl) +
        (Ord(ssShift in ShiftState) * ss_Shift) +
        (Ord(ssAlt in ShiftState) * ss_Alt);

  Command := ccNone;
  for I := 0 to High(Tables) do begin
    TmpTbl := GetCommandTable(Tables[I]);
    if Assigned(TmpTbl) then begin
      Command := cpScanTable(TmpTbl, Key, SS);
      if Command <> ccNone then
        Break;
    end;
  end;

  {if we found a match, return command and exit}
  if Command <> ccNone then begin
    Result := Command;
    Exit;
  end;

  {if we had a partial command, suppress this key}
  if cpState = stPartial then
    Result:= ccSuppress;

  cpState := stNone;
end;

procedure TOvcCommandProcessor.SubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
 {-}
begin
 Assert(aListener <> nil);
 Assert(f_KeyDataListeners.IndexOf(aListener) = -1);
 f_KeyDataListeners.Add(aListener);
end;

procedure TOvcCommandProcessor.UnsubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
 {-}
begin
 Assert(aListener <> nil);
 if (f_KeyDataListeners.IndexOf(aListener) <> -1) then
  f_KeyDataListeners.Remove(aListener);
end;

end.