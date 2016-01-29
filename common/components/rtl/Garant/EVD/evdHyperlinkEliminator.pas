unit evdHyperlinkEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/evdHyperlinkEliminator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdHyperlinkEliminator
//
// ������, ��������� ��� ����������� � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevdHyperlinkEliminator = class(TevdLeafParaFilter)
  {* ������, ��������� ��� ����������� � ��������� }
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdHyperlinkEliminator

implementation

uses
  HyperLink_Const
  ;

// start class TevdHyperlinkEliminator

function TevdHyperlinkEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E9FD8340247_var*
//#UC END# *49E488070386_4E9FD8340247_var*
begin
//#UC START# *49E488070386_4E9FD8340247_impl*
 Result := k2_typHyperLink;
//#UC END# *49E488070386_4E9FD8340247_impl*
end;//TevdHyperlinkEliminator.ParaTypeForFiltering

function TevdHyperlinkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4E9FD8340247_var*
//#UC END# *49E48829016F_4E9FD8340247_var*
begin
//#UC START# *49E48829016F_4E9FD8340247_impl*
 Result := False;
//#UC END# *49E48829016F_4E9FD8340247_impl*
end;//TevdHyperlinkEliminator.NeedWritePara

end.