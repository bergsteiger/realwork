unit evTypes;
{* ������� ���� ���������� "�������". }

{ ���������� "�������" }
{ �����: ����� �.�. �  }
{ ������: evTypes - �������� ������� ����� ���������� }
{ �����: 11.12.96 }
{ $Id: evTypes.pas,v 1.87 2015/08/18 13:18:19 lulin Exp $ }

// $Log: evTypes.pas,v $
// Revision 1.87  2015/08/18 13:18:19  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=433561370&focusedCommentId=605821164#comment-605821164
//
// Revision 1.86  2015/08/18 13:12:28  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=433561370&focusedCommentId=605821164#comment-605821164
//
// Revision 1.85  2015/08/14 11:50:16  dinishev
// {Requestlink:602009846}. ������� TevCustomHyperlinkSearcher ��� ������������� ������ ������� + ����� IFDEF � ���� ������������� ���������, ���� ���� �������
//
// Revision 1.84  2015/06/03 12:43:15  lulin
// - �������� ��������� �����������.
//
// Revision 1.83  2015/05/05 11:32:15  dinishev
// {Requestlink:590772837}
//
// Revision 1.82  2015/03/03 09:34:57  lulin
// - ���������� ��������� �����. [$589886561].
//
// Revision 1.81  2015/03/02 14:46:01  lulin
// - ������������� �����.
//
// Revision 1.80  2014/03/04 09:11:14  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.79  2014/03/03 16:25:21  lulin
// - ��������� ����� ���������.
//
// Revision 1.78  2013/09/08 08:34:48  dinishev
// {Requestlink:481428636}
//
// Revision 1.77  2013/04/04 11:18:52  lulin
// - ���������.
//
// Revision 1.76  2012/11/01 09:41:35  lulin
// - ����� ����� � �������.
//
// Revision 1.75  2012/11/01 07:42:57  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.74  2012/07/04 14:10:28  kostitsin
// [$373005769]
//
// Revision 1.73  2011/12/19 17:35:49  lulin
// {RequestLink:282693895}
// - ������ ����.
//
// Revision 1.72  2009/07/16 12:08:13  lulin
// - ��������� ������, �� ���� ���������� ���������.
//
// Revision 1.71  2008/06/09 12:16:49  lulin
// - bug fix: �� ��������� �������.
//
// Revision 1.70  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.69  2008/05/30 07:06:11  lulin
// - <K>: 92766396.
//
// Revision 1.68  2008/05/22 11:56:14  lulin
// - ������ ������, � �� ���������.
//
// Revision 1.67  2008/05/22 11:38:17  lulin
// - ������������ ������ ��������� �����.
//
// Revision 1.66  2008/05/15 13:25:34  lulin
// - <K>: 90446803.
//
// Revision 1.65  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.64  2007/12/04 12:47:07  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.58.4.28  2007/09/07 12:27:34  lulin
// - cleanup.
//
// Revision 1.58.4.27  2007/07/19 06:18:09  oman
// - fix: ���������� �����������. ����� ���������, ������ �� ������� �� ��������.
// (�� ���������� ����������)
//
// Revision 1.58.4.26  2007/07/18 15:07:19  lulin
// - ���������� �����������. ����� ���������, ������ �� ������� �� ��������.
//
// Revision 1.58.4.25  2007/07/04 05:59:15  lulin
// - ���������� �������� ��������� � ����� ����� ������.
//
// Revision 1.58.4.24  2007/03/16 14:47:18  lulin
// - cleanup.
//
// Revision 1.58.4.23  2006/12/14 10:47:05  lulin
// - cleanup.
//
// Revision 1.58.4.22  2006/10/02 11:38:35  lulin
// - ���������� � ������ � ������� ������� ���������� �������������� �������� �����.
//
// Revision 1.58.4.21.2.1  2006/09/29 11:09:07  lulin
// - ��� �������� ����� �������� � ������� ����������.
//
// Revision 1.58.4.21  2006/09/14 07:54:36  oman
// - new beh: ��������������� ��������� �������� ���� "�����
//  ��������"
//
// Revision 1.58.4.20  2006/09/11 13:57:02  oman
// - fix: ����� ���������� ���������� IevCommonControl
//
// Revision 1.58.4.19  2006/04/18 16:03:37  dinishev
// ����� ��� ��������� ��� ������� ������������
//
// Revision 1.58.4.18  2006/02/07 10:50:47  lulin
// - bug fix: �� ������ ����� ����������������� � ����������� (CQ OIT5-19497).
//
// Revision 1.58.4.17  2006/01/30 12:18:12  lulin
// - �������������� ������ ��� �����, � �� �������� �� ���������.
//
// Revision 1.58.4.16  2006/01/30 11:17:17  lulin
// - cleanup.
//
// Revision 1.58.4.15  2006/01/10 16:26:52  dinishev
// Comments _changed
//
// Revision 1.58.4.14  2005/12/20 12:15:26  lulin
// - �������� ��������� ������ ��������.
//
// Revision 1.58.4.13  2005/11/14 18:36:57  lulin
// - ������ ��� ������ � ����� ������ � ���� �������� ��������� ���������, � �� TextSource - ������ �������� ������ CQ OIT5-17870.
//
// Revision 1.58.4.12  2005/11/09 15:28:25  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.58.4.11  2005/11/04 10:49:18  lulin
// - cleanup.
//
// Revision 1.58.4.10  2005/10/05 17:29:03  dinishev
// New ControlType
//
// Revision 1.58.4.9  2005/09/23 12:15:00  dinishev
// Bug fix: ������  "��� ������ ��������" � "������ � ������������� ���������"
//  �������� ������� �����. ������� ����� �� ����
//
// Revision 1.58.4.8  2005/08/16 13:05:29  dinishev
// ����������� � �����
//
// Revision 1.58.4.7  2005/07/22 15:01:58  dinishev
// ����� ���� ���������
//
// Revision 1.58.4.6  2005/07/21 13:00:35  lulin
// - �������� ������� EVD �������� � ����� EVD.
//
// Revision 1.58.4.5  2005/07/13 12:26:12  lulin
// - ����������� ������������� �����������, ���������� ���������.
//
// Revision 1.58.4.4  2005/05/26 13:19:29  lulin
// - new unit: _l3ScreenIC.
//
// Revision 1.58.4.3  2005/05/19 15:57:18  lulin
// - cleanup.
//
// Revision 1.58.4.2  2005/05/19 12:48:34  lulin
// - new unit: evInterface.
//
// Revision 1.58.4.1  2005/05/18 12:42:48  lulin
// - ����� ����� �����.
//
// Revision 1.56.2.1  2005/05/18 12:32:10  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.58  2005/05/12 13:45:16  lulin
// - ������� �������� �������� RecalcMode.
//
// Revision 1.57  2005/05/12 12:40:33  lulin
// - ������� �������� ���������.
//
// Revision 1.56  2005/03/21 08:00:55  mmorozov
// new: type TevStyleId;
//
// Revision 1.55  2005/03/14 07:59:52  lulin
// - new behavior: ���������� ��������� ������ ��������� DocID (��� ����, ����� ��������� ����������� ��������� ���������, �������� �����������).
//
// Revision 1.54  2005/01/12 14:50:31  dinishev
// ��������� true-�������� ������. ������ �� ������ ���������.
//
// Revision 1.53  2004/12/30 11:46:24  lulin
// - ���������� ����������� � _Preview ��������� � ���������� AFW.
//
// Revision 1.52  2004/12/28 16:20:21  lulin
// - new unit: evHAFPainterEx.
//
// Revision 1.51  2004/12/27 12:24:21  lulin
// - cleanup.
//
// Revision 1.50  2004/12/16 16:11:59  dinishev
// ������ � ������������� ������ ��������.
// ������������� ������.
//
// Revision 1.49  2004/12/07 14:41:46  dinishev
// ����� ��������� ev_ctCalEdit - ComboBox � ���������� ����������.
// �������� ����������� ���������� ��������.
// ����� ���������� IDropBase - ������� ��������� ��� ����������
// ��������� � IDropCalendar - ��������� ��� ���������.
//
// Revision 1.48  2004/11/30 17:50:19  dinishev
// ���������� ����������� ������ ��� CombobBox'�. ��������� ����������� �����������.
//
// Revision 1.47  2004/11/12 16:15:02  dinishev
// ������ ���������� ���������� ���������. ��������� ����� ������ evEditDrawUtils.pas
// �������� ��������������� ������ � evControlPara.pas � evControlParaPainter.pas
//
// Revision 1.46  2004/11/11 18:24:10  lulin
// - � ������ ����������� ������� ���������� �������� ������ � �������������.
//
// Revision 1.45  2004/11/02 13:25:52  lulin
// - ����� �������: k2_idControlPara.k2_tiType.
//
// Revision 1.44  2004/10/21 16:10:22  lulin
// - �������� Limits ������� �� ��������, �.�. ��� ����������� ��������� �� ���� �� �� ������ ������� � ���������� ������ ��� ��������������.
//
// Revision 1.43  2004/10/15 10:01:21  lulin
// - new types: _TevSubHandle, _TevSubHandles.
//
// Revision 1.42  2004/10/14 08:54:57  lulin
// - new behavior: ������ ����������� ���������������� ����� ���������� ������.
//
// Revision 1.41  2004/08/05 09:08:41  law
// - change: ������-�� TevCustomEditorWindow.Select - ������ ���� ��������� �������� ���� ������.
//
// Revision 1.40  2004/07/27 13:21:58  law
// - new behavior: ����������� ������� �� IevSearcher'� ��� �������� ���������.
//
// Revision 1.39  2004/07/27 11:57:15  law
// - new const: ev_sbtHyperlink.
//
// Revision 1.38  2004/07/22 14:49:48  law
// - new type: Tl3OperationCode.
//
// Revision 1.37  2004/07/15 16:29:08  law
// - �������� �������� ����������� ����� ��������� � ���������� �� TextSource.
// - � ����� �� ��������� ��������� �������� ����������� ����� ���������.
//
// Revision 1.36  2004/06/08 12:13:45  law
// - ������� �������� ��������� �������, �������� ������ �� ��������.
//
// Revision 1.35  2004/05/14 14:55:51  law
// - ���������� ���� �� evTypesE � evTypes.
//
// Revision 1.34  2004/02/03 16:31:44  law
// - new const: ev_UserCommentFlags.
//
// Revision 1.33  2003/12/01 14:39:59  law
// - new methods: TevCustomEditor.TextBufConvert, TextBufConvertF.
//
// Revision 1.32  2003/09/10 12:18:31  law
// - new type: idMark.
// - new const: ev_sbtMark.
//
// Revision 1.31  2003/09/08 13:08:23  law
// - new const: ev_sbtPara.
//
// Revision 1.30  2003/05/15 15:27:06  law
// - new type: Tl3TabStop.
//
// Revision 1.29  2003/05/14 13:17:13  law
// - change _format: ���������� ��������� �������� ������ ������� ���������.
//
// Revision 1.28  2002/12/20 15:35:46  law
// - new const: ����� ����� ������ ev_soDocumentPart - ������ � ����� ��������� �����.
//
// Revision 1.27  2002/07/09 12:02:22  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.26  2002/03/27 17:10:09  law
// - new unit: evLoadDocumentManager.
//
// Revision 1.25  2002/01/08 12:44:11  law
// - new behavior: ������� ���������� ������ � cf_EverestTxt ��� EverestLite.
//
// Revision 1.24  2002/01/03 14:19:03  law
// - some cosmetics.
//
// Revision 1.23  2001/12/18 14:06:34  law
// - new unit: evSaveDocumentManager.
//
// Revision 1.22  2001/08/31 07:19:14  law
// - split unit: evDsgn -> evDsgn, l3HackRTTI.
//
// Revision 1.21  2001/08/01 15:06:33  law
// - new constant: cf_HTML.
//
// Revision 1.20  2001/04/05 08:57:37  law
// - cleanup: ������������� ������� WinTypes � WinProcs ������� �� Windows.
//
// Revision 1.19  2001/04/04 14:26:34  law
// - new: ��������� ��������� ����������.
//
// Revision 1.18  2001/03/15 14:52:23  law
// - cleaning & coments.
//
// Revision 1.17  2001/03/11 17:08:22  law
// - �������� ����������� ��� XHelpGen.
//
// Revision 1.16  2001/03/11 14:58:33  law
// - ��������� ��� �����������.
//
// Revision 1.15  2001/02/27 15:36:34  law
// - �������� �����������.
//
// Revision 1.14  2001/01/15 15:50:08  law
// - ��������� �������� k2_tiVerticalAligment - ������������ �� ���������.
//
// Revision 1.13  2000/12/20 10:18:10  law
// - bug fix: working with clipboard.
//
// Revision 1.12  2000/12/15 15:10:39  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

{$C PRELOAD}

interface

uses
  Windows,
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  Classes,
  {$EndIf l3ConsoleApp}
  Graphics,
  TypInfo,

  l3Interfaces,
  l3Types,
  l3Units,

  afwTypes
  ;

const
  ev_sfOwn = 4;
    {* - ����������� ��������. }
    
{������� ���� Integer, Word, Char etc.}
type
  TevStyleId = type Tl3StyleID;
    {* ������������� ������� ������. }

{������������ ����}
  {Search option flags for editor and viewer}
  TevSearchOptionEx = (
       ev_soFind,        {find  (this option is assumed)        }
       ev_soBackward,    {search backwards                      }
       ev_soMatchCase,   {don't ignore case when searching      }
       ev_soGlobal,      {search globally                       }
       ev_soReplace,     {find and replace         (editor only)}
       ev_soReplaceAll,  {find and replace all     (editor only)}
       ev_soWholeWord,   {match on whole word only (editor only)}
       ev_soSelText,     {search in selected text  (editor only)}
       ev_soConfirm,     {����������� ������ ��� ������         }
       ev_soCheckOwnerCollapsed, {������������ ������ � ��������� ������}
       ev_soIngoreExternalLink, {������������ ������� ������}
       ev_soDocumentPart,{������ �� ����� ��������� ������ ������� ������}
       ev_soUseInternalCursor,
       ev_soNoException,
       ev_soNoSelection,
       ev_soNoProgress,
       ev_soInPageDown,
       ev_soInPageUp
       );
    {* ����� ������/������:
       |<br>
       |<ul>
       |<li><b>ev_soFind</b> - ����� (��� �� ���������).</li>
       |<li><b>ev_soBackward</b> - ����� �����.</li>
       |<li><b>ev_soMatchCase</b> - ���������� ���������.</li>
       |<li><b>ev_soGlobal</b> - ����� �� ����� ������.</li>
       |<li><b>ev_soReplace</b> - ������.</li>
       |<li><b>ev_soReplaceAll</b> - �������� ���.</li>
       |<li><b>ev_soWholeWord</b> - ������ ����� �����.</li>
       |<li><b>ev_soSelText</b> - ����� � ���������.</li>
       |<li><b>ev_soConfirm</b> - ������ �� ������.</li>
       |<li><b>ev_soDocumentPart</b> - ������ �� ����� ��������� ������ ������� ������.</li>
       |</ul>
    }
  TevSearchOptionSetEx = set of TevSearchOptionEx;
    {* ����� ����� ������/������. }
  TevSearchOption = ev_soFind .. ev_soIngoreExternalLink;
    {* ��������� ����� ������/������. }
  TevSearchOptionSet = set of TevSearchOption;
    {* ����� ��������� ����� ������/������. }
  TevSelectTarget = (ev_stChar, ev_stWord, ev_stLine, ev_stPara, ev_stDocument);
    {* �������� � �������� ����������� ���������:
       |<br>
       |<ul>
       | <li><b>ev_stChar</b> - ������.</li>
       | <li><b>ev_stWord</b> - �����.</li>
       | <li><b>ev_stLine</b> - ������.</li>
       | <li><b>ev_stPara</b> - ��������.</li>
       | <li><b>ev_stDocument</b> - ��������.</li>
       |</ul>
    }

  TevPageColontituls = (
    pcUpLeftFirst,
    pcUpRightFirst,
    pcDownLeftFirst,
    pcDownRightFirst,
    pcUpLeft,
    pcUpRight,
    pcDownLeft,
    pcDownRight
  );

  TevFormat = Tl3ClipboardFormat;
    {* - ������������� ������� ������. ����� ����:
         cf_EverestBin. cf_EverestTxt, cf_RTF, cf_RTFLite, cf_Text, cf_OEMText etc.}

{������� ��������� ����������, ����� etc.}
  TevInch  = Long;
  TevPixel = Long;

  TevUnits = (ev_unInch, ev_unCm, ev_unPixel, ev_unChar);
    {* - ������� ���������. }

{�������}
  TevTextConvertEvent = function (Sender   : TObject;
                                  Buf      : PAnsiChar;
                                  Len      : Long;
                                  CodePage : Long): Bool of object;

  TevTextBufConvertEvent = function (
                                     Sender       : TObject;
                                     var Buf      : PAnsiChar;
                                     var Len      : Long;
                                     var CodePage : SmallInt;
                                     Data         : Pointer
                                    ): Bool of object;
  TevTextBufConvertProc = function (var aStr : Tl3PCharLen): Bool;
    {-}

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}
var
  cf_EverestBin : TevFormat = 0;
    {* - �������� ������ �������. }
  cf_EverestBinForce : TevFormat = 0;
    {* - �������� ������ ������� (��� ���������). }
  cf_EverestBinForceAndUnpacked : TevFormat = 0;
    {* - �������� ������ ������� (��� ���������). }
  cf_EverestTxt : TevFormat = 0;
    {* - ��������� ������ �������. }
  cf_RTF        : TevFormat = 0;
    {* - ������ RTF. }
  cf_RTFLite    : TevFormat = 0;
    {* - "�����������" ������ RTF. }
  cf_HTML       : TevFormat = 0;
    {* - ������ HTML. }
  cf_XML       : TevFormat = 0;
    {* - ������ XML. }
  cf_Doc        : TevFormat = 0;
    {* - ������ Doc. }
  cf_PDF        : TevFormat = 0;
    {* - ������ PDF. }
  {$IfNDef evExternalProduct}
  cf_NSRC       : TevFormat = 0;
    {* - ������ NSRC. }
  {$EndIf evExternalProduct}
{$EndIf l3ConsoleApp}

implementation

{$IfDef l3ConsoleApp}
{$Else  l3ConsoleApp}

{$IfDef EverestLite}
 {$Undef evdNeedEverestTxt}
{$EndIf EverestLite}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evTypes.pas initialization enter'); {$EndIf}
  {$IfDef evMyEditor}
  cf_EverestBin := Windows.RegisterClipboardFormat('My Editor v1.0');
  cf_EverestBinForce := Windows.RegisterClipboardFormat('My Editor v1.0 (force)');
  {$IfDef evdNeedEverestTxt}
  cf_EverestTxt := Windows.RegisterClipboardFormat('My Editor v1.0 (text)');
  {$Else  evdNeedEverestTxt}
  cf_EverestTxt := cf_EverestBin;
  {$EndIf evdNeedEverestTxt}
  {$Else  evMyEditor}
  cf_EverestBin := Windows.RegisterClipboardFormat('Everest Editor v1.0 (Binary)');
  cf_EverestBinForce := Windows.RegisterClipboardFormat('Everest Editor v1.0 (Binary force)');
  cf_EverestBinForceAndUnpacked := Windows.RegisterClipboardFormat('Everest Editor v1.0 (Binary force and Unpacked)');
  {$IfDef evdNeedEverestTxt}
  cf_EverestTxt := Windows.RegisterClipboardFormat('Everest Editor v1.0 (Text)');
  {$Else  evdNeedEverestTxt}
  cf_EverestTxt := cf_EverestBin;
  {$EndIf evdNeedEverestTxt}
  {$EndIf evMyEditor}
  cf_RTF := Windows.RegisterClipboardFormat('Rich Text Format');
  cf_RTFLite := Windows.RegisterClipboardFormat('Rich Text Format (Lite)');
  cf_HTML := Windows.RegisterClipboardFormat('HTML Format');
  cf_XML := Windows.RegisterClipboardFormat('XML Format');
  cf_Doc := Windows.RegisterClipboardFormat('MS Word Format');
  cf_PDF := Windows.RegisterClipboardFormat('Adobe PDF format');
  {$IfNDef evExternalProduct}
  cf_NSRC := Windows.RegisterClipboardFormat('NSRC Format');
  {$EndIf  evExternalProduct}
{$EndIf l3ConsoleApp}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evTypes.pas initialization leave'); {$EndIf}
end.
