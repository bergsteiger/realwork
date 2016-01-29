unit evOp;
{* �������� ����� ��������. }

{ ���������� ""         }
{ �����: ����� �.�.     }
{ ������: evOp - �������� �������� ��������������}
{ �����: 20.03.97 16:51 }
{ $Id: Evop.pas,v 1.20 2012/11/27 11:50:05 dinishev Exp $ }

// $Log: Evop.pas,v $
// Revision 1.20  2012/11/27 11:50:05  dinishev
// {Requestlink:410628348}
//
// Revision 1.19  2012/03/02 12:27:27  dinishev
// {Requestlink:340175024}
//
// Revision 1.18  2009/04/13 12:32:48  lulin
// [$142613919].
//
// Revision 1.17  2007/12/04 12:46:58  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.15.30.3  2005/07/19 09:37:48  lulin
// - ��������� �� ������� ���������.
//
// Revision 1.15.30.2  2005/06/16 14:11:29  lulin
// - cleanup: �������� ������� ��������� ���������� �� ����������.
//
// Revision 1.15.30.1  2005/05/27 12:05:56  lulin
// - ������ ������ �����������.
//
// Revision 1.15  2004/02/27 19:22:12  law
// - bug fix: ���������� ��������� ShortCut'�� ��� �������� �������.
// - bug fix: ���������� ������� ��������� ShortCut'�� � ������ ���������.
//
// Revision 1.14  2003/02/26 13:40:31  law
// - new: ����� ��� ����������� ������� ev_ocMakeChildChain.
//
// Revision 1.13  2002/09/10 13:29:20  law
// - comments: xHepGen.
//
// Revision 1.12  2002/07/03 11:10:17  law
// - new const: ev_ocWholeWordRight.
//
// Revision 1.11  2002/06/06 14:48:29  law
// - new behavior: Backspace ������ ��������� �������� � "���������" ��������.
//
// Revision 1.10  2002/05/17 10:41:07  law
// - new commands: ev_ocDeleteWordLeft, ev_ocDeleteWordRight.
//
// Revision 1.9  2001/06/06 12:43:52  law
// - new behavior: �������� ������� ���������� ����� �� ���������.
//
// Revision 1.8  2001/03/23 17:46:17  law
// - ��������� �������� ev_ocToggleInsertMode.
//
// Revision 1.7  2001/03/02 16:25:34  law
// - ������� ��������� ������ ^KB � ^KK.
//
// Revision 1.6  2000/12/15 15:10:33  law
// - ��������� ��������� Log.
//

{$I evDefine.inc }

interface

uses
  OvcConst, {-command and resource constants from Orpheus} {&&& $$$ &&&}
  
  l3Types,
  l3Operations
  ;

const
  { ������� �� Orpheus: }
  ev_ocShortCut         = l3_ocShortCut;
    {-}
  ev_ocNone             = ccNone;
    {* - ������ �������}
  ev_ocTab              = ccTab;
    {* - ���������}
  ev_ocAcceptChar       = ccAccept;
    {-}
  ev_ocActionItem       = ccActionItem;
    {-}
  ev_ocCharLeft         = ccLeft;
    {* - ���������� �� ������ �����}
  ev_ocCharRight        = ccRight;
    {* - ���������� �� ������ ������}
  ev_ocLineUp           = ccUp;
    {* - ���������� �� ������ �����}
  ev_ocLineDown         = ccDown;
    {* - ���������� �� ������ ����}
  ev_ocLineHome         = ccHome;
    {* - ������������� � ������ ������}
  ev_ocLineEnd          = ccEnd;
    {* - ������������� �� ����� ������}
  ev_ocPageUp           = ccPrevPage;
    {* - �������� �����}
  ev_ocPageDown         = ccNextPage;
    {* - �������� ����}
  ev_ocTopLeft          = ccFirstPage;
    {* - � ����� ������� ���� ���������}
  ev_ocBottomRight      = ccLastPage;
    {* - � ������ ������ ���� ���������}
  ev_ocPageTop          = ccTopOfPage;
    {* - ������ ��������}
  ev_ocPageBottom       = ccBotOfPage;
    {* - ���� ��������}
  ev_ocDeleteChar       = ccDel;
    {* - ������� ������� ������}
  ev_ocBackSpace        = ccBack;
    {* - ������� ������ ����� �� �������}
  ev_ocBreakPara        = ccNewLine;
    {* - ��������� �������� Loc}
  ev_ocWordLeft         = ccWordLeft;
    {* - ������������� �� ����� �����}
  ev_ocWordRight        = ccWordRight;
    {* - ������������� �� ����� ������ Bool(bParam) - �� ����� ����� ��� �� ����. �����}
  ev_ocCut              = ccCut;
    {* - ����������� ��������� � ����� � �������}
  ev_ocCopy             = ccCopy;
    {* - ����������� ��������� � �����}
  ev_ocPaste            = ccPaste;
    {* - �������� �� ������}
  ev_ocUndo             = ccUndo;
    {* - �������� ��������}
  ev_ocRedo             = ccRedo;
    {* - ������� ���������� ��������}
  ev_ocDeleteLine       = ccDelLine;
    {* - ������� ������}
  { ������� ��� ��������� ��������: }
  ev_ocSetMarker0       = ccSetMarker0;
  ev_ocSetMarker1       = ccSetMarker1;
  ev_ocSetMarker2       = ccSetMarker2;
  ev_ocSetMarker3       = ccSetMarker3;
  ev_ocSetMarker4       = ccSetMarker4;
  ev_ocSetMarker5       = ccSetMarker5;
  ev_ocSetMarker6       = ccSetMarker6;
  ev_ocSetMarker7       = ccSetMarker7;
  ev_ocSetMarker8       = ccSetMarker8;
  ev_ocSetMarker9       = ccSetMarker9;
  { ������� ��� �������� �� �������: }
  ev_ocGotoMarker0      = ccGotoMarker0;
  ev_ocGotoMarker1      = ccGotoMarker1;
  ev_ocGotoMarker2      = ccGotoMarker2;
  ev_ocGotoMarker3      = ccGotoMarker3;
  ev_ocGotoMarker4      = ccGotoMarker4;
  ev_ocGotoMarker5      = ccGotoMarker5;
  ev_ocGotoMarker6      = ccGotoMarker6;
  ev_ocGotoMarker7      = ccGotoMarker7;
  ev_ocGotoMarker8      = ccGotoMarker8;
  ev_ocGotoMarker9      = ccGotoMarker9;
  { ������� ��� ��������� ������ ����������� �����: }
  ev_ocExtLineDown      = ccExtendDown;
  ev_ocExtLineEnd       = ccExtendEnd;
  ev_ocExtLineHome      = ccExtendHome;
  ev_ocExtCharLeft      = ccExtendLeft;
  ev_ocExtPageDown      = ccExtendPgDn;
  ev_ocExtPageUp        = ccExtendPgUp;
  ev_ocExtCharRight     = ccExtendRight;
  ev_ocExtLineUp        = ccExtendUp;
  ev_ocExtPageBottom    = ccExtBotOfPage;
  ev_ocExtTop           = ccExtFirstPage;
  ev_ocExtBottom        = ccExtLastPage;
  ev_ocExtPageTop       = ccExtTopOfPage;
  ev_ocExtWordLeft      = ccExtWordLeft;
  ev_ocExtWordRight     = ccExtWordRight;

  ev_ocStartSelection   = ccStartSelBlock;
   {* - �������� ������ ���������. }
  ev_ocFinishSelection  = ccEndSelBlock;
   {* - �������� ����� ���������. }
  ev_ocToggleInsertMode = ccIns;
   {* - ����������� ����� �������/������. }
  ev_ocDeleteWordLeft   = ccDelWordLeft;
    {-}
  ev_ocDeleteWordRight  = ccDelWordRight;
    {-}

const
  { ����������� ������� ��������: }
  ev_ocBase             = ccUserFirst + 100;
    {* - ���� ��� �������� "��������"}
  ev_ocColumnLeft       = ev_ocBase;
    {* - ����������� ������ Loc �� ������ ����� �������� TevCaretPos(bParam)}
  ev_ocColumnRight      = ev_ocBase + 1;
    {* - ����������� ������ Loc �� ������ ������ �������� TevCaretPos(bParam)}
  ev_ocDeleteRow        = ev_ocBase + 2;
    {* - ������� ������� ������ �������}
  ev_ocDeleteColumn     = ev_ocBase + 3;
    {* - ������� ������� ������� �������}
  ev_ocParaHome         = ev_ocBase + 4;
    {* - � ������ ���������}
  ev_ocParaEnd          = ev_ocBase + 5;
    {* - � ����� ���������}
  ev_ocLineLeft         = ev_ocBase + 6;
    {* - �� ������ �����}
  ev_ocLineRight        = ev_ocBase + 7;
    {* - �� ������ ������}
  ev_ocParaLeft         = ev_ocBase + 8;
    {* - �� �������� �����}
  ev_ocParaUp           = ev_ocBase + 9;
    {* - �� �������� �����}
  ev_ocParaRight        = ev_ocBase + 10;
    {* - �� �������� ������}
  ev_ocParaDown         = ev_ocBase + 11;
    {* - �� �������� ����}
  ev_ocWordStart        = ev_ocBase + 12;
    {* - �� ������ �����}
  ev_ocWordFinish       = ev_ocBase + 13;
    {* - �� ����� �����}
  ev_ocExtParaUp        = ev_ocBase + 14;
    {-�� �������� �����}
  ev_ocExtParaDown      = ev_ocBase + 15;
    {-�� �������� ����}
  ev_ocListHome         = ev_ocBase + 16;
    {* - �� ������ ������ ����������. }
  ev_ocListEnd          = ev_ocBase + 17;
    {* - �� ����� ������ ����������. }
  ev_ocInsertRow        = ev_ocBase + 18;
    {* - �������� ������ �������. }
  ev_ocInsertColumn     = ev_ocBase + 19;
    {* - �������� ������� �������. }
  ev_ocExtParaEnd       = ev_ocBase + 20;
    {* - � ����� ���������. }
  ev_ocVTop             = ev_ocBase + 21;
    {* - � ������ ��������� (�� ���������). }
  ev_ocVBottom          = ev_ocBase + 22;
    {* - � ����� ��������� (�� ���������). }
  ev_ocPrevParaBottomRight = ev_ocBase + 23;
    {* - � ����� ����������� ���������. }
  ev_ocNextParaTopLeft  = ev_ocBase + 24;
    {* - � ������ ���������� ���������. }
  ev_ocPrevParaBottomRightInThisBlock = ev_ocBase + 25;
    {* - � ����� ����������� ��������� � ��� ����� ��� _ev_cpNull. }
  ev_ocExtParaHome      = ev_ocBase + 26;
    {* - � ������ ���������. }
  ev_ocExtParaLeft      = ev_ocBase + 27;
    {* - �� �������� �����. }
  ev_ocExtParaRight     = ev_ocBase + 28;
    {* - �� �������� ������. }
  ev_ocNextPara         = ev_ocBase + 29;
    {* - � ������ ���������� ���������. }
  ev_ocPrevCharForDelete = ev_ocBase + 30;
    {* - ���������� ������ ��� ��������. }
  ev_ocWholeWordRight   = ev_ocBase + 31;
    {* - ����� ������ ������� + �. �. �������. }
  ev_ocMakeChildChain   = ev_ocBase + 32;
    {* - ��������� ������� �����. }
  ev_ocParaDownWithEmptyRow = ev_ocBase + 33;
    {* - �� �������� �� ��������� ������ ������. }
  ev_ocBottomRightIgnoreMergedCell = ev_ocBase + 34;
    {* - � ������ ������ ���� ���������, ��������� ������������ ������}
  ev_ocUser             = ev_ocBase + 50;
    {-}

implementation

end.

