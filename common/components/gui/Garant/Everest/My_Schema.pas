unit My_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/My_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi::Everest::Standard::My
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evMyEditor)}
uses
  Everest_Schema,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a}
  ;
{$IfEnd} //evMyEditor

{$If defined(evMyEditor)}

type
 TMySchema = class(TEverestSchema)
 public
   constructor Create; override;
 end;//TMySchema

{$IfEnd} //evMyEditor

implementation

{$If defined(evMyEditor)}
uses
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  k2List {a},
  k2NonOptimizeContext {a}
  ;
{$IfEnd} //evMyEditor


{$If defined(evMyEditor)}

// start class TMySchema

constructor TMySchema.Create;
begin
 inherited;
end;

{$IfEnd} //evMyEditor


initialization
{$If defined(evMyEditor)}
 TMySchema.SetAsDefault;
{$IfEnd} //evMyEditor


end.