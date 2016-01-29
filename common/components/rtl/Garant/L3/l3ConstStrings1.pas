unit l3ConstStrings1;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ConstStrings1.pas"
// �����: 05.04.2010 15:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::��������� �������������� ���������::Tl3ConstStrings1
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3StringIDEx,
  l3Types
  ;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = Tl3ConstStringsPrim;
 {$Include ..\L3\l3Searcher.imp.pas}
 Tl3ConstStrings1 = class(_l3Searcher_, Il3ApplicationL10NStrings)
 protected
 // realized methods
   procedure Define(const aName: AnsiString;
    const aRus: AnsiString;
    const anAlien: AnsiString);
 end;//Tl3ConstStrings1

implementation

uses
  l3String,
  SysUtils
  ;

// start class Tl3ConstStrings1

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4BB9C58B039B_var*
//#UC END# *47B9BAFD01F4_4BB9C58B039B_var*
begin
//#UC START# *47B9BAFD01F4_4BB9C58B039B_impl*
 Assert(aSortIndex = l3_siByID);
 //Result := CompareStr(anItem.rKey, l3Str(aData));
 Result := l3Compare(l3PCharLen(anItem.rKey), aData, aSortIndex);
//#UC END# *47B9BAFD01F4_4BB9C58B039B_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3ConstStrings1;

{$Include ..\L3\l3Searcher.imp.pas}

// start class Tl3ConstStrings1

procedure Tl3ConstStrings1.Define(const aName: AnsiString;
  const aRus: AnsiString;
  const anAlien: AnsiString);
//#UC START# *4BB9C06901AE_4BB9C58B039B_var*

 function CutPrefix(const aPref : String; const aStr : Tl3WString): Tl3WString;
 var
  l_Len : Integer;
 begin
  l_Len := Length(aPref);
  Result.S := aStr.S + l_Len;
  Result.SLen := aStr.SLen - l_Len;
  Result.SCodePage := aStr.SCodePage;
 end;

const
 cSep = '\';
 cPref = 'string' + cSep;
var
 l_S : Tl3WString;
 l_Suff : Tl3WString;
 l_Index : Integer;
//#UC END# *4BB9C06901AE_4BB9C58B039B_var*
begin
//#UC START# *4BB9C06901AE_4BB9C58B039B_impl*
 if (anAlien = '') then
 // - �� ��� ��������� ������������� ������
  Exit;
 l_S := l3PCharLen(aName);
 if l3Starts(cPref, l_S) then
 begin
  l_S := CutPrefix(cPref, l_S);
  l_Suff := l3FindChar(cSep, l_S);
  l_S := l3RTrim(l_S, [cSep]);
  if l3Same(l_Suff, 'Caption') then
  begin
   if Self.FindData(l_S, l_Index, l3_siByID) then
    Items[l_Index].Localize(aRus, anAlien);
  end;//l3Same(l_Suff, 'Caption')
 end;//l3Starts(cPef, l_S)
//#UC END# *4BB9C06901AE_4BB9C58B039B_impl*
end;//Tl3ConstStrings1.Define

end.