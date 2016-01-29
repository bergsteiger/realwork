unit vcmMenuManagerTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMenuManagerTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmMenuManagerTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmMenus
  ;

type
 IvcmMenuItemClickListener = interface(IUnknown)
   ['{3174E619-23DB-4925-8BD5-426D327F9D84}']
   procedure NotifyMenuItemClicked(anItem: TvcmMenuItem);
 end;//IvcmMenuItemClickListener
 PvcmMenuItemClickListener = ^IvcmMenuItemClickListener;

{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$IfEnd} //not NoVCM
end.