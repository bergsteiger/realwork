{$IfNDef nevAnchor_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevAnchor.imp.pas"
// �����: 09.04.2009 21:44
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Anchors::nevAnchor
//
// ������� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevAnchor_imp}
{$If defined(k2ForEditor)}
 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
 _nevAnchor_ = {mixin} class(_nevDiff_)
  {* ������� ���������� ������ }
 end;//_nevAnchor_
{$Else}

 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
 _nevAnchor_ = _nevDiff_;

{$IfEnd} //k2ForEditor

{$Else nevAnchor_imp}

{$If defined(k2ForEditor)}


{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}


{$IfEnd} //k2ForEditor

{$EndIf nevAnchor_imp}
