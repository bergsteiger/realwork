unit vcmApplicationRef;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/Design/vcmApplicationRef.pas"
// �����: 17.09.2009 16:41
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Design::TvcmApplicationRef
//
// ��� ��� ����������� ��������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If defined(DesignTimeLibrary) AND not defined(NoVCM)}
uses
  vcmApplication
  ;
{$IfEnd} //DesignTimeLibrary AND not NoVCM

{$If defined(DesignTimeLibrary) AND not defined(NoVCM)}
type
 TvcmApplicationRef = class(TvcmApplication)
  {* ��� ��� ����������� ��������������� ������� }
 end;//TvcmApplicationRef
{$IfEnd} //DesignTimeLibrary AND not NoVCM

implementation

end.