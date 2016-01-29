unit nsUnknownComponent.imp;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , afwInterfaces
;

type
 _nsUnknownComponent_ = class(IvcmSettingsSource, Ml3Unknown)
  {* ������� ���������� � ������, �������� �������� ������ ��������� ������� �������. }
  function CheckSettings: Boolean;
  procedure LoadSettings;
  procedure SaveSettings;
  procedure CheckLoadSettings;
  procedure CheckSaveSettings;
  function Settings: IafwSettings;
   {* ��������� �������� ������������ �������. }
  function BaseId: AnsiString;
   {* ������� ������������� ���������. ������������ ��� ������ ����� ���� ��� ��������������� ��������. }
 end;//_nsUnknownComponent_
 
implementation

uses
 l3ImplUses
;

end.
