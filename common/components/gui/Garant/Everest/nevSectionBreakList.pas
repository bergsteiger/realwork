unit nevSectionBreakList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/nevSectionBreakList.pas"
// �����: 10.11.2008 13:27
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Document::TnevSectionBreakList
//
// ������ �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevSectionBreakListPrim
  ;

type
 TnevSectionBreakList = class(TnevSectionBreakListPrim, InevSectionBreaks)
  {* ������ �������� �������� }
 protected
 // realized methods
   function GetSectionWidth(const aChild: InevObject;
     out theWidth: Integer): Boolean;
   function GetSectionBreak(const aChild: InevObject;
     out theBreak: InevObject): Boolean;
     {* ���������� ������ ������� ��� ���������� ��������� �������� }
 end;//TnevSectionBreakList

implementation

uses
  evSectionPara
  ;

// start class TnevSectionBreakList

function TnevSectionBreakList.GetSectionWidth(const aChild: InevObject;
  out theWidth: Integer): Boolean;
//#UC START# *491933680169_49180FCE035B_var*
var
 l_Break : InevObject;
//#UC END# *491933680169_49180FCE035B_var*
begin
//#UC START# *491933680169_49180FCE035B_impl*
 Result := GetSectionBreak(aChild, l_Break);
 if Result then
  theWidth := evSectionExtent(l_Break.AsObject).X;
//#UC END# *491933680169_49180FCE035B_impl*
end;//TnevSectionBreakList.GetSectionWidth

function TnevSectionBreakList.GetSectionBreak(const aChild: InevObject;
  out theBreak: InevObject): Boolean;
//#UC START# *4C0CF53A01A4_49180FCE035B_var*
var
 l_Index : Integer;
//#UC END# *4C0CF53A01A4_49180FCE035B_var*
begin
//#UC START# *4C0CF53A01A4_49180FCE035B_impl*
 Result := false;
 // - �� ����������
 if FindData(aChild, l_Index) then
  // - ����� ���������� ������
  theBreak := Items[l_Index]
 else
 if (l_Index > 0) then
  // - ����� ����� ������� ���������
  theBreak := Items[Pred(l_Index)]
 else
  // - �������� ��������� ����� ������ ��������
  Exit;
 Result := true;
 // - ���������� ������ ������
//#UC END# *4C0CF53A01A4_49180FCE035B_impl*
end;//TnevSectionBreakList.GetSectionBreak

end.