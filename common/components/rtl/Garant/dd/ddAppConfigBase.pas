unit ddAppConfigBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd$AppConfig"
// Модуль: "w:/common/components/rtl/Garant/dd/ddAppConfigBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd$AppConfig::AppConfig::TddAppConfigBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoPersistent
  ;

type
 TddAppConfigBase = class(Tl3ProtoPersistent)
 public
 // public methods
   constructor Create; reintroduce; virtual;
   function Clone: Pointer; virtual;
 end;//TddAppConfigBase

implementation

// start class TddAppConfigBase

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