{$IfNDef nevTextParaTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevTextParaTool.imp.pas"
// �����: 04.04.2005 15:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevTextParaTool
//
// ���������� ��� InevTextPara
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevTextParaTool_imp}
 _X_ = InevTextPara;
 _nevParaXTool_Parent_ = _nevTextParaTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevTextParaTool_ = {mixin} class(_nevParaXTool_)
  {* ���������� ��� InevTextPara }
 end;//_nevTextParaTool_

{$Else nevTextParaTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevTextParaTool_imp}
