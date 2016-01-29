unit daGUITypes;

interface

uses
 l3IntfUses
 , ddAppConfig
;

type
 TBuildConfigProc = procedure(aConfig: TddAppConfiguration;
  const aProviderKey: AnsiString;
  ForInfoOnly: Boolean) of object;
 
implementation

uses
 l3ImplUses
;

end.
