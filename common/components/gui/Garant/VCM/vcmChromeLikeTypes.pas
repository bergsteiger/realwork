unit vcmChromeLikeTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/vcmChromeLikeTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::vcmChromeLikeSupport::vcmChromeLikeTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  ;

type
 IvcmMenuHolder = interface(IUnknown)
   ['{06E8AA85-09B4-4185-839F-66D5F1138AA0}']
   function Get_MainMenu: TMenuItem;
   property MainMenu: TMenuItem
     read Get_MainMenu;
 end;//IvcmMenuHolder
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$IfEnd} //not NoVCM
end.