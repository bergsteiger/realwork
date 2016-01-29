unit dd_lcYearCodeCorrector;
{ ����������� ��� � ������ �� ���� ������ }

{ $Id: dd_lcYearCodeCorrector.pas,v 1.7 2014/04/07 09:34:04 lulin Exp $ }

// $Log: dd_lcYearCodeCorrector.pas,v $
// Revision 1.7  2014/04/07 09:34:04  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.6  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.5  2011/09/13 05:33:39  narry
// ������������ ������ ���������� ���������� (265410470)
//
// Revision 1.4  2011/06/07 14:13:50  narry
// � �������������� ��� � ���������� ����������� ����� ������������� (268350079)
//
// Revision 1.3  2011/04/11 13:21:45  narry
// ������� CODE ��� ������������� ������������� ��������� (259892916)
//
// Revision 1.2  2011/04/11 07:51:05  narry
// ����������� ������ (259893511)
//
// Revision 1.1  2011/03/25 13:24:03  narry
// K259164340. ������ ����� ���� � ���
//

interface

uses
 ddHeaderFilter, k2Interfaces, dd_lcCodeCorrector;

type
 Tdd_lcYearCodeCorrector = class(Tdd_lcCodeCorrector)
 private
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 end;

implementation

uses
 StrUtils, k2Tags, dt_types, NumAndDate_Const, k2Base, SysUtils, l3Base,
 dd_lcSourceUtils, Math, dd_lcUtils;

procedure Tdd_lcYearCodeCorrector.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Sources, l_Numbers: Tl3Variant;
 i, j: Integer;
 l_2DigitNumber: AnsiString;
 l_4DigitNumber: AnsiString;
 l_Number: AnsiString;
 l_Date: Integer;

begin
 l_Sources:= aHeaderRoot.Attr[k2_tiSources];
 if l_Sources.IsValid then
 begin
  for i:= 0 to Pred(l_Sources.ChildrenCount) do
  begin
   if Source2DossierType(l_Sources.Child[i].StrA[k2_tiName]) <> lc_dtVAC then
   begin // ��� ������, ���� ������
    l_Numbers:= aHeaderRoot.Attr[k2_tiNumANDDates];
    if l_Numbers.IsValid then
    begin
     l_2DigitNumber:= ''; l_4DigitNumber:= '';
     for j:= 0 to Pred(l_Numbers.ChildrenCount) do
     begin
      if l_Numbers.Child[j].IntA[k2_tiType] = Ord(dnPublish) then
      begin
       l_Number:= l_Numbers.Child[j].StrA[k2_tiNumber];
       l_Date:= l_Numbers.Child[j].IntA[k2_tiStart];
       if IsTwoDigitsNumber(l_Number) then
        l_2DigitNumber:= l_Number
       else
        l_4DigitNumber:= l_Number;
      end; // l_Numbers.Child[j].IntA[k2_tiType] = Ord(dnPublish)
     end; // for j
     if (l_2DigitNumber <> '') and (l_4DigitNumber = '') then
      AddNumber(l_Numbers, MakeTwinNumber(l_2DigitNumber), l_Date)
     else
     if (l_2DigitNumber = '') and (l_4DigitNumber <> '') then
      AddNumber(l_Numbers, MakeTwinNumber(l_4DigitNumber), l_Date)
    end;
    break
   end; // AnsiContainsText(l_Sources.Child[i].StrA[k2_tiName], '���')
  end;
 end;
end;


end.
