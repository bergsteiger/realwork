unit afwSettingsReplace.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwSettingsReplace_ = class(IafwSettingsReplaceListener, Ml3Unknown)
  {* �������, ����������� IafwSettingsReplaceListener. }
  procedure SettingsReplaceStart;
  procedure SettingsReplaceFinish;
  procedure Start;
   {* ����� ������� ��������. }
  procedure Finish;
   {* ����� ������ ��������. }
 end;//_afwSettingsReplace_
 
implementation

uses
 l3ImplUses
 , afwFacade
 , afwSettingsChangePublisher
;

end.
