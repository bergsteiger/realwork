unit dd_lcVASSourceCorrector;
{ ������ ����� ��� ������������� ���������� ��� }

{ $Id: dd_lcVASSourceCorrector.pas,v 1.3 2014/04/07 09:34:04 lulin Exp $ }

// $Log: dd_lcVASSourceCorrector.pas,v $
// Revision 1.3  2014/04/07 09:34:04  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.2  2011/03/29 07:41:06  narry
// K259170852. ��������� ��� ��
//
// Revision 1.1  2011/03/28 11:01:17  narry
// K259169921. ��������� ������ ��� ���������� ��� ��
//

interface

uses
 ddHeaderFilter, k2Interfaces;

type
 Tdd_lcVASSourceCorrector = class(TddHeaderFilter)
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 end;

implementation

uses
 StrUtils, k2Tags, dt_types, NumAndDate_Const, k2Base, SysUtils;

procedure Tdd_lcVASSourceCorrector.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Sources, l_Types: Tl3Variant;
 i: Integer;
 l_CorrectSource: Boolean;
begin
 l_Types:= aHeaderRoot.Attr[k2_tiTypes];
 if l_Types.IsValid then
 begin
  l_CorrectSource:= False;
  for i:= 0 to Pred(l_Types.ChildrenCount) do
  begin
   l_CorrectSource:= AnsiContainsText(l_Types.Child[i].StrA[k2_tiName], '������������� ���������� ��� ��');
   if AnsiSameText(l_Types.Child[i].StrA[k2_tiName], '�������������') then
   begin
    l_Sources:= aHeaderRoot.Attr[k2_tiSources];
    if (l_Sources.IsValid) and (l_Sources.ChildrenCount > 0) then
     l_CorrectSource:= AnsiContainsText(l_Sources.Child[0].StrA[k2_tiName], '��� ��');
   end; // AnsiSameText(l_Types.Child[i].StrA[k2_tiName], '�������������')
   if l_CorrectSource then
   begin // ��� ������, ���� �����
    l_Sources:= aHeaderRoot.Attr[k2_tiSources];
    if (l_Sources.IsValid) and (l_Sources.ChildrenCount > 0) then
     l_Sources.Child[0].StrA[k2_tiName]:= '������ �������� ������ �� � ����\������ ����������� ��� ������\��������� ��� ��';
    break
   end; // AnsiContainsText(l_Sources.Child[i].StrA[k2_tiName], '���')
  end; // for i
 end; // l_Types.IsValid
end;


end.
