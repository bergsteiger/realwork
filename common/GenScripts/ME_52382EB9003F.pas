unit AppConfigTestMixin.imp;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , ddConfigStorages
;

type
 _AppConfigTestMixin_ = class(Ml3Unknown)
 end;//_AppConfigTestMixin_
 
implementation

uses
 l3ImplUses
 , ddAppConfigUtils
 , Windows
 , ConfigStorageStub
 , SysUtils
 , ddAppConfig
 , TestFrameWork
;

end.
