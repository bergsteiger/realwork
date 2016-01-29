unit evdTxtConst;
{* ��������� ������� evd. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evdConst -      }
{ �����: 09.11.1999 15:57 }
{ $Id: evdTxtConst.pas,v 1.2 2007/08/29 14:52:33 lulin Exp $ }

// $Log: evdTxtConst.pas,v $
// Revision 1.2  2007/08/29 14:52:33  lulin
// - �� ����� ���������� � ��������� �������.
//
// Revision 1.1  2007/08/29 12:00:33  lulin
// - ��������� ��������� �� ��� �����.
//
// Revision 1.3  2006/01/27 11:00:49  lulin
// - bug fix: ��� ������������ ����� ������ �� ������� EVD, �.�. � ����� ��� ����� (CQ OIT5-19345).
//
// Revision 1.2  2005/07/21 11:41:21  lulin
// - ������ ������ �����������.
//
// Revision 1.1  2005/06/23 12:55:39  lulin
// - ���� � ����������� �������� � ����� EVD.
//
// Revision 1.31  2002/09/18 09:33:26  law
// - new behavior: ��� ������ � evd-binary �������� ��� ��������� ���� �� ���������.
//
// Revision 1.30  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, k2Ver.
// - new behavior: Tk2CustomReader ������ ����������� �� Tk2CustomStackGenerator � �������������� ��������� ��� ���������.
//
// Revision 1.29  2001/10/23 08:14:46  law
// - new const: idLink.
//
// Revision 1.28  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.27  2001/05/31 07:43:14  law
// - new version: � ������ ������� �������� ������ �������� Frame.
//
// Revision 1.26  2001/05/30 12:19:42  law
// - new version: � ������ ������� ������ �������� k2_tiFrame.
//
// Revision 1.25  2001/02/23 13:44:26  law
// - � ���������� ��������� ��������� �������� AllowHyphen.
//
// Revision 1.24  2001/01/25 13:54:53  law
// - � ���������� IedParagraphFormatting ��������� �������� FirstIndent.
//
// Revision 1.23  2001/01/24 14:53:43  law
// - ������� ����� ���������� ���������� ���� �������
//
// Revision 1.22  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include evdDefine.inc }

interface

uses
  l3Chars
  ;

const
  evDirectivePrefix    = cc_PercentSign;
    {* - ������� ���������. }
  evRollbackPrefix     = cc_Tilda;
    {* - ������� ������ ����. }
  evTransparentToken   = '@';
    {* - ������� ������������ ����. }

  evdOpenBracket = '{';
    {-}
  evdCloseBracket = '}';
    {-}

implementation

end.

