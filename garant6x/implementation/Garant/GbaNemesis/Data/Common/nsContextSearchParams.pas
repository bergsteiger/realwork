unit nsContextSearchParams;

(*-----------------------------------------------------------------------------
 ��������:   nsContextSearchParams
 �����:      �������� �. �.
 ����������: ������� ��� �������� ������� ��� ������������ _������_
 ������:
   $Id: nsContextSearchParams.pas,v 1.3 2011/01/27 15:01:56 lulin Exp $
 �������:
   $Log: nsContextSearchParams.pas,v $
   Revision 1.3  2011/01/27 15:01:56  lulin
   {RequestLink:248195582}.
   - �������� ���������������� �� �����.

   Revision 1.2  2011/01/27 12:14:15  lulin
   {RequestLink:248195582}.
   - ����������� �� ����������� �������.

   Revision 1.1  2009/09/14 11:28:53  lulin
   - ������� ���� � ��� ������������� �������.

   Revision 1.4  2008/01/10 07:23:30  oman
   ������� �� ����� �������

   Revision 1.3.4.5  2007/12/05 12:43:44  oman
   ������������ �� ����� ������� - ������� �����������

   Revision 1.3.4.4  2007/11/23 10:41:09  oman
   cleanup

   Revision 1.3.4.3  2007/11/22 14:20:24  oman
   ������������ �� ����� �������

   Revision 1.3.4.2  2007/11/22 13:20:37  oman
   ������������ �� ����� �������

   Revision 1.3.4.1  2007/11/20 15:07:05  oman
   ������������ �� ����� �������

   Revision 1.3  2007/05/17 12:04:16  oman
   cleanup

   Revision 1.2  2007/05/17 10:33:52  oman
   cleanup

   Revision 1.1  2007/03/30 11:04:27  oman
   ����������� ������ ������������ ������� ��� �����������
   ������


-----------------------------------------------------------------------------*)

interface

uses
  l3Interfaces,

  DynamicTreeUnit
  ;

function nsMakeContextSearchFilterList(const aContext: Il3CString;
                                       const aWholeWord: Boolean;
                                       const TreatParagraphAsAllLevel: Boolean) : IFilterList;
  {* - ��������� ���������� IFilter, �������� ��� � ������ � ����������
       ������. }

implementation

uses
 DataAdapter,

 nsTypes;

function nsMakeContextSearchFilterList(const aContext: Il3CString;
 const aWholeWord: Boolean; const TreatParagraphAsAllLevel: Boolean) : IFilterList;
  {* - ��������� ���������� IFilter, �������� ��� � ������ � ����������
       ������. }
//overload;
var
 l_Filter : IContextFilter;
begin
 l_Filter := defDataAdapter.NativeAdapter.MakeContextFilter;
 l_Filter.SetContext(nsIStr(aContext));
 if aWholeWord then
  l_Filter.SetPlace(CP_WHOLE_WORD)
 else
  l_Filter.SetOrder(FO_ANY);
 if TreatParagraphAsAllLevel then
  l_Filter.SetArea(SA_ALL_LEVEL)
 else
  l_Filter.SetArea(SA_ONE_LEVEL);
 Result := defDataAdapter.NativeAdapter.MakeFilterList;
 Result.Add(l_Filter);
end;

end.
