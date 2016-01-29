unit vcmToolbarsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/vcmToolbarsInterfaces.pas"
// �����: 12.02.2008 21:10
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmToolbarsInterfaces
//
// ���������� ��� ������ � �������� ������������
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
  vcmExternalInterfaces
  ;

type
 IvcmToolbarsCustomizeListener = interface(IvcmBase)
  {* ��������� ������� ��������� ������� ������������ }
   ['{68687746-F997-4BEC-BD6B-BDCFBD82726B}']
   procedure BeforeCustomize;
     {* ���������� ����� ������� ���� �������������� ������� ������������ }
 end;//IvcmToolbarsCustomizeListener

 IvcmToolbarsCustomizeNotify = interface(IvcmBase)
  {* ���������� � �������� �������������� ������ ������������ }
   ['{30A12550-6409-4E0E-B7FD-817414AE3CC2}']
   procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
   procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
 end;//IvcmToolbarsCustomizeNotify

 IvcmToolbarsCustomize = interface(IvcmBase)
  {* ��������� ������� ������������ }
   ['{4A5A5457-01CE-4FFF-B872-7633827158D4}']
   function pm_GetNotify: IvcmToolbarsCustomizeNotify;
   property Notify: IvcmToolbarsCustomizeNotify
     read pm_GetNotify;
 end;//IvcmToolbarsCustomize
{$IfEnd} //not NoVCM

implementation

end.