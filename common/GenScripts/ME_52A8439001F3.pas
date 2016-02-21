unit TB97ExtInterfaces;

// ������: "w:\common\components\rtl\external\tb97\TB97ExtInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
;

type
 ITB97Ctrl = interface
  {* ��������� �������������� �� ������������� ������������ ������������ �� toolbar-� }
  ['{239FBDAE-69C9-4CC1-A677-638DBAFFC648}']
  function Get_FullWidth: Integer;
  function Get_IsSizeable: Boolean;
  function Get_MinWidth: Integer;
  procedure DoFitToWidth(aWidth: Integer);
  procedure DoUnFitToWidth(aWidth: Integer);
  procedure Expand;
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
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoTB97)

end.
