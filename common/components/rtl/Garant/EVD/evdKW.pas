unit evdKW;
{* ������� �������� ���� ������� evd. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evdKW -         }
{ �����: 13.10.1999 12:09 }
{ $Id: evdKW.pas,v 1.6 2010/02/27 10:50:25 lulin Exp $ }

// $Log: evdKW.pas,v $
// Revision 1.6  2010/02/27 10:50:25  lulin
// {RequestLink:193822954}.
// - �������� ���������.
//
// Revision 1.5  2009/07/21 15:10:14  lulin
// - bug fix: �� ��������� � �� ������� ���������� � �����.
//
// Revision 1.4  2008/02/06 09:55:27  lulin
// - ���������� ������� ������� ��������������� ���������.
//
// Revision 1.3  2008/02/05 09:58:07  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.2  2007/08/29 15:04:50  lulin
// - ���������� �� ������� ������� ��������� �������.
//
// Revision 1.1  2005/06/23 13:08:26  lulin
// - ���� � ��������� ������� �������� � ����� EVD.
//
// Revision 1.11.4.1  2005/05/18 12:42:46  lulin
// - ����� ����� �����.
//
// Revision 1.10.6.2  2005/05/18 12:32:08  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.10.6.1  2005/04/28 09:18:29  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.10.14.1  2005/04/26 14:30:39  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.11  2005/04/28 15:03:37  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.10.14.1  2005/04/26 14:30:39  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.10  2004/09/28 17:21:56  lulin
// - � ������ ����������� ������ ��� ����������. ���� ��� ��������� ���������� �� ����.
//
// Revision 1.9  2004/04/15 09:59:01  law
// - bug fix: ������� ���������� ������� ��� ���������������.
//
// Revision 1.8  2003/03/11 10:30:17  law
// - new class: Tl3StringMap.
//
// Revision 1.7  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.6  2000/12/19 15:52:40  law
// - ������ �������� ��������� ����������.
//
// Revision 1.5  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3KeyWrd
  ;

const
  evd_kwBinary       = 0;
    {* - ������ �������� ������. }
  evd_kwProducer     = 1;
    {* - ��������� ���������. }
  evd_kwBrackets     = 2;
    {* - ��������� ����� ������ �������. }
  evd_kwInary        = 3;
    {* - ����� �������� ������. }
  evd_kwNdBinary     = 4;
    {* - ����� �������� ������. }
  evd_kwEndPlainText = 5;
    {* - ����� ������������������ ������. }
  evd_kwPlainText    = 6;
    {* - ������ ������������������ ������. }
  evd_kwVersion      = 7;
    {* - ������. }
  evd_kwRevision     = 8;
    {* - �������. }
  evd_kwDate         = 9;
    {* - ����. }
  evd_kwComment      = 10;
    {* - ��������� ����� ���������� �����������. }
  evd_kwLineComment  = 11;
    {* - ��������� ����� ���������� �����������. }
  evd_kwFormat       = 12;
    {* - ������� ����� �������. }
  evd_kwEndBinary    = 13;
    {* - ����� �������� ������. }
  evd_kwPBinary      = 14;
    {* - ������ �������� ������. }

function EvdKeyWords: Tl3KeyWords;
 {* ������� �������� ���� ������� evd. }

implementation

var g_EvdKeyWords : Tl3KeyWords = nil;

procedure EvdKeyWordsFree;
begin
 l3Free(g_EvdKeyWords);
end;

function EvdKeyWords: Tl3KeyWords;
begin
 with l3System do
 begin
  EnterGlobalCS;
  try
   if (g_EvdKeyWords = nil) then
   begin
    AddExitProc(EvdKeyWordsFree);
    g_EvdKeyWords := Tl3KeyWords.Create;
    try
     g_EvdKeyWords.AddKeyWord('binary', evd_kwBinary);
     g_EvdKeyWords.AddKeyWord('producer', evd_kwProducer);
     g_EvdKeyWords.AddKeyWord('brackets', evd_kwBrackets);
     g_EvdKeyWords.AddKeyWord('inary', evd_kwInary);
     g_EvdKeyWords.AddKeyWord('ndbinary', evd_kwNdBinary);
     g_EvdKeyWords.AddKeyWord('endplaintext', evd_kwEndPlainText);
     g_EvdKeyWords.AddKeyWord('plaintext', evd_kwPlainText);
     g_EvdKeyWords.AddKeyWord('version', evd_kwVersion);
     g_EvdKeyWords.AddKeyWord('revision', evd_kwRevision);
     g_EvdKeyWords.AddKeyWord('date', evd_kwDate);
     g_EvdKeyWords.AddKeyWord('comment', evd_kwComment);
     g_EvdKeyWords.AddKeyWord('linecomment', evd_kwLineComment);
     g_EvdKeyWords.AddKeyWord('format', evd_kwFormat);
     g_EvdKeyWords.AddKeyWord('endbinary', evd_kwEndBinary);
     g_EvdKeyWords.AddKeyWord('pbinary', evd_kwPBinary);
     Result := g_EvdKeyWords;
    except
     l3Free(g_EvdKeyWords);
     raise;
    end;//try..except
   end//g_EvdKeyWords = nil
   else
    Result := g_EvdKeyWords;
  finally
   LeaveGlobalCS;
  end;//try..finally
 end;//with l3System
end;

end.

