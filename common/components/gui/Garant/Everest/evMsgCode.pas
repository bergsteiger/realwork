unit evMsgCode;
{* ��������� Everest'�. �������� ������� ���������������� ��������.
   ����������� �� �������� �����. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evMsgCode -     }
{ �����: 09.07.2002 17:09 }
{ $Id: evMsgCode.pas,v 1.15 2008/09/26 10:10:47 dinishev Exp $ }

// $Log: evMsgCode.pas,v $
// Revision 1.15  2008/09/26 10:10:47  dinishev
// <K>: 77235630 ��� Head'�
//
// Revision 1.14  2008/04/09 17:57:07  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.13  2007/12/04 12:47:03  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.12.14.4  2005/12/05 04:18:16  lulin
// - cleanup.
//
// Revision 1.12.14.3  2005/10/13 06:00:24  lulin
// - cleanup.
//
// Revision 1.12.14.2  2005/07/19 08:25:03  lulin
// - ��������� �� ������� ��������� ��� ����������� ������ ��������� - ������� ����������� �� ����� �������� Search/_Replace.
//
// Revision 1.12.14.1  2005/07/19 06:58:45  lulin
// - cleanup: ������ ������ ��������� ��� ����������� ������ ����������.
//
// Revision 1.12  2005/01/27 16:45:27  lulin
// - optimization: ������ ��������������� �������� �� ���� ����� ������� ��������� ������.
//
// Revision 1.11  2003/12/01 14:39:59  law
// - new methods: TevCustomEditor.TextBufConvert, TextBufConvertF.
//
// Revision 1.10  2003/10/10 18:47:25  law
// - new behavior: ��������� �� ������������������ ������ WM_Size.
// - change: ����� �� ��������� ���� �� ����� ������������������ (��. ����������� TevCustomEditorWindow.Paint - f_ScrollTagWrap). � �� ������ ��������� �������� ��� Maximize ��� WebStyle.
//
// Revision 1.9  2003/10/10 15:22:41  law
// - new behavior: �������/����� ������������ ������� ���������.
// - �������� ��������� ������� ��������������.
// - change: � ���������� ������ �������� ���������� �����, ��� ������������ �������� ��������������.
//
// Revision 1.8  2003/09/25 17:00:17  law
// - new behavior: ������� ���������� �������� ����.
//
// Revision 1.7  2003/07/04 19:39:45  law
// - ����������� ������������������ ������ � ������� ������ (�� ����� �� ��������, �� ������� ����� ����).
//
// Revision 1.6  2003/02/06 15:15:03  law
// - cleanup: ��������� �� ��������� (message) � ����������� ��������.
//
// Revision 1.5  2003/02/06 14:42:59  law
// - cleanup: ��������� �� ��������� (message)  � ����������� ��������.
//
// Revision 1.4  2003/02/06 12:35:22  law
// - cleanup: ��������� �� ��������� (message)  � ����������� ��������.
//
// Revision 1.3  2003/02/05 13:53:11  law
// - cleanup: ��������� �� ��������� (message)  � ����������� ��������.
//
// Revision 1.2  2003/01/17 15:20:03  law
// - change: ������� �� message � interface.
// - new behavior: � ���������� ����� ���������� ����������� ������.
//
// Revision 1.1  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//

{$Include evDefine.inc }

interface

const {-��������� Everest'�}
  ev_msgFirst = $7F00 - 300;
    {* - ������ ��������� Everest'�}

  ev_msgFirstOp = ev_msgFirst;
    {-}
  ev_msgSetAtom         = ev_msgFirstOp;
    {* - ���������� ����. }
  ev_msgAddHyperlink    = ev_msgFirstOp + 1;
    {* - ��������� �������������� ������. ��: evIntf.TevmsgAddHyperlink.}
  ev_msgDeleteHyperlink = ev_msgFirstOp + 2;
    {* - ������� �������������� ������. ��: evIntf.TevmsgDeleteHyperlink.}
  ev_msgAddSub          = ev_msgFirstOp + 3;
    {* - ��������� Sub. ��: evIntf.TevmsgAddSub.}
  ev_msgDeleteSub       = ev_msgFirstOp + 4;
    {* - ������� Sub. ��: evIntf.TevmsgDeleteSub. }
  ev_msgInsertBlock     = ev_msgFirstOp + 5;
    {* - �������� ���� ������. ��: evIntf.TevmsgInsertBlock.}
  ev_msgInsertString    = ev_msgFirstOp + 6;
    {* - �������� ������. ��: evIntf.TevmsgInsertString.}
  ev_msgDeleteString    = ev_msgFirstOp + 7;
    {* - ������� wParam ��������. ��: evIntf.TevmsgDeleteString. }
  ev_msgDeleteChar      = ev_msgFirstOp + 8;
    {* - ������� ������. }
  ev_msgJoinParas       = ev_msgFirstOp + 9;
    {* - ���������� ���������. }
  ev_msgBreakPara       = ev_msgFirstOp + 10;
    {* - ��������� ��������. ��: evIntf.TevmsgBreakPara. }
  ev_msgInsertPara      = ev_msgFirstOp + 11;
    {* - �������� ��������. }
  ev_msgSearch          = ev_msgFirstOp + 12;
    {* - �����. ��: evIntf.TevmsgSearch. }
  ev_msgMove            = ev_msgFirstOp + 13;
    {* - ��������. ��: evIntv.TevmsgMove. }
  ev_msgChangeParam     = ev_msgFirstOp + 14;
    {* - �������� �������� ���������. }
  ev_msgBackspace       = ev_msgFirstOp + 15;
    {* - ������� ���������� ������. ��: evIntsf.TevmsgBackspace. }
  M_evJoinWith          = ev_msgFirstOp + 16;
    {* - ���������� ���������. ��: evMsg.MevJoinWith. }
  M_evSplit             = M_evJoinWith  + 1;
    {* - ��������� ��������. ��: evMsg.MevSplit. }
  ev_msgDeletePara      = M_evJoinWith  + 2;
    {* - ������� ��������. }
  ev_msgLastOp = ev_msgDeletePara;
    {* - ��������� ��������. }
  ev_msgBlock2Para      = ev_msgLastOp + 1;
    {* - ������������� ��������� � ��������. }
  ev_msgNeedPaint       = ev_msgBlock2Para + 1;
    {-}
  ev_msgWasWMSize       = ev_msgNeedPaint + 1;
    {* - ��������� ������� ���������. }
  ev_msgNeedDoc         = ev_msgWasWMSize + 1;
    {-}
  ev_msgAddMarker      = ev_msgWasWMSize + 2;
    {* - �������� ������. }
  ev_msgLast            = ev_msgAddMarker;
    {* - ��������� ������� ���������. }

implementation

end.

