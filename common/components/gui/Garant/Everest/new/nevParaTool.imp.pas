{$IfNDef nevParaTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevParaTool.imp.pas"
// �����: 04.04.2008 11:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevParaTool
//
// ���������� ��� InevPara
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParaTool_imp}
 _X_ = InevPara;
 _nevParaXTool_Parent_ = _nevParaTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevParaTool_ = {mixin} class(_nevParaXTool_)
  {* ���������� ��� InevPara }
 end;//_nevParaTool_

{$Else nevParaTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevParaTool_imp}
