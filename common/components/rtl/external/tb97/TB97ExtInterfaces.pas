unit TB97ExtInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "tb97"
// ������: "w:/common/components/rtl/external/tb97/TB97ExtInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::tb97::TB97ExtInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
type
 ITB97Ctrl = interface(IUnknown)
  {* ��������� �������������� �� ������������� ������������ ������������ �� toolbar-� }
   ['{239FBDAE-69C9-4CC1-A677-638DBAFFC648}']
   procedure DoFitToWidth(aWidth: Integer);
   procedure DoUnFitToWidth(aWidth: Integer);
   procedure Expand;
     {* ��������� ������ Expand }
   function Get_FullWidth: Integer;
   function Get_IsSizeable: Boolean;
   function Get_MinWidth: Integer;
   property FullWidth: Integer
     read Get_FullWidth;
     {* ������� ������ ����������, ��� ���������� � ���������� ����������� }
   property IsSizeable: Boolean
     read Get_IsSizeable;
     {* ��������� ����� �������� ������� }
   property MinWidth: Integer
     read Get_MinWidth;
     {* ����������� ������ �� �������� ����� ��������� ��������� }
 end;//ITB97Ctrl
{$IfEnd} //not NoTB97

implementation

end.