unit ddObjectSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddObjectSegment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddObjectSegment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddTextSegment,
  k2Interfaces,
  ddCharacterProperty
  ;

type
 TddObjectSegment = class(TddTextSegment)
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aCHP: TddCharacterProperty;
     aParentCHP: TddCharacterProperty;
     LiteVersion: Boolean); override;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
     LiteVersion: Boolean): Boolean; override;
 public
 // overridden public methods
   function IsObjectSegment: Boolean; override;
 end;//TddObjectSegment

implementation

uses
  ddTypes,
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddObjectSegment

procedure TddObjectSegment.Write2Generator(const Generator: Ik2TagGenerator;
  aCHP: TddCharacterProperty;
  aParentCHP: TddCharacterProperty;
  LiteVersion: Boolean);
//#UC START# *54D888450259_54D9B0A2024C_var*
//#UC END# *54D888450259_54D9B0A2024C_var*
begin
//#UC START# *54D888450259_54D9B0A2024C_impl*
 if not Data.CanWrite then Exit; 
 StartObjectSegment(Generator);
 try
  DoWriteSegmentProps(Generator, aCHP, aParentCHP, LiteVersion);
  Data.Write2Generator(Generator, False, LiteVersion);
 finally
  Generator.Finish;
 end; // k2_idTextSegment
//#UC END# *54D888450259_54D9B0A2024C_impl*
end;//TddObjectSegment.Write2Generator

function TddObjectSegment.SkipSegment(aDiffCHP: TddCharacterProperty;
  LiteVersion: Boolean): Boolean;
//#UC START# *54E4325C00BE_54D9B0A2024C_var*
//#UC END# *54E4325C00BE_54D9B0A2024C_var*
begin
//#UC START# *54E4325C00BE_54D9B0A2024C_impl*
 Result := False;
//#UC END# *54E4325C00BE_54D9B0A2024C_impl*
end;//TddObjectSegment.SkipSegment

function TddObjectSegment.IsObjectSegment: Boolean;
//#UC START# *55E013DF03B9_54D9B0A2024C_var*
//#UC END# *55E013DF03B9_54D9B0A2024C_var*
begin
//#UC START# *55E013DF03B9_54D9B0A2024C_impl*
 Result := True;
//#UC END# *55E013DF03B9_54D9B0A2024C_impl*
end;//TddObjectSegment.IsObjectSegment

end.