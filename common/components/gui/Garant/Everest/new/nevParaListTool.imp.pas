{$IfNDef nevParaListTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevParaListTool.imp.pas"
// �����: 04.04.2005 15:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevParaListTool
//
// ���������� ��� InevParaList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParaListTool_imp}
 _X_ = InevParaList;
 _nevParaXTool_Parent_ = _nevParaListTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevParaListTool_ = {mixin} class(_nevParaXTool_)
  {* ���������� ��� InevParaList }
 end;//_nevParaListTool_

{$Else nevParaListTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevParaListTool_imp}
