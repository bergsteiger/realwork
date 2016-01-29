unit nsCutToLeafFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsCutToLeafFilter.pas"
// �����: 2008/06/25 08:04:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::BaseSearch::TnsCutToLeafFilter
//
// �������, ��� ���?
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3CacheableBase,
  BaseSearchInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsCutToLeafFilter = class(Tl3CacheableBase, InsCutToLeafFilter)
  {* �������, ��� ���? }
 private
 // private fields
   f_LeafCount : LongWord;
 protected
 // realized methods
   function pm_GetLeafCount: LongWord;
 public
 // public methods
   constructor Create(aCount: LongWord); reintroduce;
   class function Make(aCount: LongWord): InsCutToLeafFilter; reintroduce;
     {* ������ ������ }
 end;//TnsCutToLeafFilter
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}

// start class TnsCutToLeafFilter

constructor TnsCutToLeafFilter.Create(aCount: LongWord);
//#UC START# *4901FD3E03AD_4901FD0A034A_var*
//#UC END# *4901FD3E03AD_4901FD0A034A_var*
begin
//#UC START# *4901FD3E03AD_4901FD0A034A_impl*
 inherited Create;
 f_LeafCount := aCount;
//#UC END# *4901FD3E03AD_4901FD0A034A_impl*
end;//TnsCutToLeafFilter.Create

class function TnsCutToLeafFilter.Make(aCount: LongWord): InsCutToLeafFilter;
var
 l_Inst : TnsCutToLeafFilter;
begin
 l_Inst := Create(aCount);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsCutToLeafFilter.pm_GetLeafCount: LongWord;
//#UC START# *4901F74E0224_4901FD0A034Aget_var*
//#UC END# *4901F74E0224_4901FD0A034Aget_var*
begin
//#UC START# *4901F74E0224_4901FD0A034Aget_impl*
 Result := f_LeafCount;
//#UC END# *4901F74E0224_4901FD0A034Aget_impl*
end;//TnsCutToLeafFilter.pm_GetLeafCount

{$IfEnd} //not Admin

end.