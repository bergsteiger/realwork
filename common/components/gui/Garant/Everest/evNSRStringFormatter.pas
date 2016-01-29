unit evNSRStringFormatter;

{ ���������� "�������"    }
{ �����: ������ �.�.       }
{ ������: evNSRStringFormatter - ��������� ������ � ������������� ��� NSR. }
{ �����: 21.09.2006 10:18 }
{ $Id: evNSRStringFormatter.pas,v 1.5 2010/08/11 09:05:17 dinishev Exp $ }

// $Log: evNSRStringFormatter.pas,v $
// Revision 1.5  2010/08/11 09:05:17  dinishev
// [$182452385]. ������, �.�. � �������� � � ������ ����������� - ����������. :-(
//
// Revision 1.4  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.3  2007/12/04 13:04:55  lulin
// - ���������� ��� �������� � ����������� ��������.
//
// Revision 1.2  2006/11/03 10:59:46  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.1.2.2  2006/10/12 16:10:18  lulin
// - ��������� � ����� �����.
//
// Revision 1.1  2006/10/12 15:26:30  lulin
// - ��������� � ����� �����.
//
// Revision 1.1  2006/09/21 12:27:40  dinishev
// new class: TevNSRCStringFormatter - ��� ������������ ����� � �������������
//

{$Include evDefine.inc }

interface

uses
 l3Base,
 l3Types,
 l3StringFormatter;

type 
 TevNSRCStringFormatter = class(Tl3StringFormatted) 
 private
  f_HypLnkStartText : Long;
    {* - ������� ������ ������ �����������. }
  f_HypLnkEndText   : Long;
    {* - ������� ��������� ������ �����������. }
  f_HypLnkEndPos    : Long; 
    {* - ������� ��������� ������ � �����������. }
  procedure InitHyperlinkPositions;
    {-}    
 protected
  procedure DoBeforeFormatting; override;
    {* - �������� ����� ������� �������������� ������. }
  procedure DoBeforeInsertSpaces; override;
    {* - �������� ����� �������� ��������. }
  procedure DoAfterInsertSpaces; override;
    {* - �������� ����� �������� ��������. } 
 end;

implementation

uses
 l3Chars;

{ TevNSRCStringFormatter }

procedure TevNSRCStringFormatter.DoAfterInsertSpaces;
begin
 if f_HypLnkStartText > -1 then
  // - ���� ���� ������� ��������, �� ����� "�������" ���������� �����������. 
  InitHyperlinkPositions;
end;

procedure TevNSRCStringFormatter.DoBeforeFormatting;
begin
 f_HypLnkStartText := 0;
 InitHyperlinkPositions;
end;

procedure TevNSRCStringFormatter.DoBeforeInsertSpaces;
begin
 if f_HypLnkStartText > -1 then
 // - ����������� �����������...
 begin
  if f_CurrSpacePos > f_HypLnkEndPos then 
  // - ����� �� ������� �����������.
  begin
   f_HypLnkStartText := f_HypLnkEndPos + 1;
   InitHyperlinkPositions;
  end;//if l_CharIndex > l_HypLnkEndPos then
  if (f_HypLnkStartText > -1) and (f_HypLnkEndText < f_CurrSpacePos) 
     and (f_CurrSpacePos < f_HypLnkEndPos) then
  // - ������ � ������� � ������� � ����������� - �� ����� ��������� �������.
   f_CurrSpaceCnt := 0;
 end;//if l_HypLnkStartText > -1 then
end;

procedure TevNSRCStringFormatter.InitHyperlinkPositions;
begin
 f_HypLnkStartText := f_String.FindChar(f_HypLnkStartText, cc_HyperLinkChar); 
 if f_HypLnkStartText > -1 then
 begin  
  f_HypLnkEndText := f_HypLnkStartText + 1;
  f_HypLnkEndText := f_String.FindChar(f_HypLnkEndText, cc_HyperLinkChar);
  if f_HypLnkEndText > -1 then 
  begin
   f_HypLnkEndPos := f_HypLnkEndText + 1;
   f_HypLnkEndPos := f_String.FindChar(f_HypLnkEndPos, cc_HyperLinkChar);
  end
  else
   f_HypLnkEndPos := f_HypLnkEndText;
 end
 else
 begin
  f_HypLnkEndText := -1; 
  f_HypLnkEndPos := -1;
 end; 
end;

end.

