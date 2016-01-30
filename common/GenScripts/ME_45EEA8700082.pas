unit ProfileUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ProfileUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 IStopWatch = interface
  ['{B162C5E6-8FE2-44B5-B806-F1E65F17587E}']
 end;//IStopWatch

 IStopWatchEx = interface
  ['{266C0FFA-01E6-4FA4-A4D6-BC620B8B7F76}']
 end;//IStopWatchEx

class function make(context: PAnsiChar): BadFactoryType;
class function make(id: PAnsiChar;
 context: PAnsiChar): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(context: PAnsiChar): BadFactoryType;
var
 l_Inst : IStopWatch;
begin
 l_Inst := Create(context);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(id: PAnsiChar;
 context: PAnsiChar): BadFactoryType;
var
 l_Inst : IStopWatchEx;
begin
 l_Inst := Create(id, context);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
