unit ddAppConfigBase;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddAppConfigBase" MUID: (5301EC0E0156)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoPersistent
;

type
 TddAppConfigBase = class(Tl3ProtoPersistent)
  public
   constructor Create; reintroduce; virtual;
   function Clone: Pointer; virtual;
 end;//TddAppConfigBase

implementation

uses
 l3ImplUses
;

constructor TddAppConfigBase.Create;
//#UC START# *5301EC5A006A_5301EC0E0156_var*
//#UC END# *5301EC5A006A_5301EC0E0156_var*
begin
//#UC START# *5301EC5A006A_5301EC0E0156_impl*
 inherited Create;
//#UC END# *5301EC5A006A_5301EC0E0156_impl*
end;//TddAppConfigBase.Create

function TddAppConfigBase.Clone: Pointer;
//#UC START# *5301EC7500FF_5301EC0E0156_var*
type
 RddAppConfigBase = class of TddAppConfigBase;
//#UC END# *5301EC7500FF_5301EC0E0156_var*
begin
//#UC START# *5301EC7500FF_5301EC0E0156_impl*
 Result := RddAppConfigBase(ClassType).Create;
 TddAppConfigBase(Result).Assign(Self);
//#UC END# *5301EC7500FF_5301EC0E0156_impl*
end;//TddAppConfigBase.Clone

end.
