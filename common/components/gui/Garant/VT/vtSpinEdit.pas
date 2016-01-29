unit vtSpinEdit;

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  vtSpin
  ;

type
 TvtSpinEdit = vtSpin.TvtSpinEdit;

implementation

  {$If not defined(NoScripts)}
uses  
  SpinEditWordsPack
  ;
  {$IfEnd} //not NoScripts
  
end.