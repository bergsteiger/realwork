unit afwSettingsReplace.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwSettingsReplace_ = class(IafwSettingsReplaceListener, Ml3Unknown)
  {* Примесь, реализующая IafwSettingsReplaceListener. }
  procedure SettingsReplaceStart;
  procedure SettingsReplaceFinish;
  procedure Start;
   {* перед заменой настроек. }
  procedure Finish;
   {* после замены настроек. }
 end;//_afwSettingsReplace_
 
implementation

uses
 l3ImplUses
 , afwFacade
 , afwSettingsChangePublisher
;

end.
