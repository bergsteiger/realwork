unit Concret;

// ������: "w:\common\components\SandBox\Concret.pas"
// ���������: "Interfaces"

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , Pure
;

type
 //_T_ = Concret;
 Concret = interface
  ['{14AF2DBE-A147-42ED-82B8-C7B7360DB3A8}']
  function compare(const x: Concret;
   const y: Concret): Integer;
 end;//Concret

implementation

uses
 l3ImplUses
;

end.
