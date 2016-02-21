unit daGUITypes;

// Модуль: "w:\common\components\rtl\Garant\DA\daGUITypes.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfig
;

type
 TBuildConfigProc = procedure(aConfig: TddAppConfiguration;
  const aProviderKey: AnsiString = '';
  ForInfoOnly: Boolean = False) of object;

implementation

uses
 l3ImplUses
;

end.
