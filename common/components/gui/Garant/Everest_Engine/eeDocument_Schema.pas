unit eeDocument_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocument_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi For F1::Everest Engine::EVD::eeDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  F1_Schema,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a}
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

type
 TeeDocumentSchema = class(TF1Schema)
 public
   constructor Create; override;
 end;//TeeDocumentSchema

{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
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
{$IfEnd} //Nemesis


{$If defined(Nemesis)}

// start class TeeDocumentSchema

constructor TeeDocumentSchema.Create;
begin
 inherited;
end;

{$IfEnd} //Nemesis


initialization
{$If defined(Nemesis)}
 TeeDocumentSchema.SetAsDefault;
{$IfEnd} //Nemesis


end.