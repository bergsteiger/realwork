unit ddHyperlink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddHyperlink.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddHyperlink
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
  ddCharacterProperty,
  ddTypes
  ;

type
 TddHyperlink = class(TddTextSegment)
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aCHP: TddCharacterProperty;
     aParentCHP: TddCharacterProperty;
     aLiteVersion: TddLiteVersion); override;
   function Clone: TddTextSegment; override;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
     aLiteVersion: TddLiteVersion): Boolean; override;
 public
 // overridden public methods
   function IsHyperlink: Boolean; override;
 end;//TddHyperlink

implementation

uses
  ddHyperlinkTarget,
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddHyperlink

procedure TddHyperlink.Write2Generator(const Generator: Ik2TagGenerator;
  aCHP: TddCharacterProperty;
  aParentCHP: TddCharacterProperty;
  aLiteVersion: TddLiteVersion);
//#UC START# *54D888450259_54D9AC570374_var*
var
 j       : Integer;
 l_HasURL: Boolean;
 l_Target: TddHyperlinkTarget;
//#UC END# *54D888450259_54D9AC570374_var*
begin
//#UC START# *54D888450259_54D9AC570374_impl*
 l_HasURL := not URL.Empty;
 StartHyperlink(Generator);
 try
  Generator.AddIntegerAtom(k2_tiStart, Start);
  Generator.AddIntegerAtom(k2_tiFinish, Stop);
  if HLHandle <> -1 then
   Generator.AddIntegerAtom(k2_tiHandle, HLHandle);
  for j := 0 to TargetList.Hi do
  begin
   l_Target := TargetList[j];
   l_Target.Write2Generator(Generator, aLiteVersion);
  end; // for j
  if l_HasURL then
   Generator.AddStringAtom(k2_tiURL, URL.AsWStr);
 finally
  Generator.Finish;
 end; // idHyperlink
//#UC END# *54D888450259_54D9AC570374_impl*
end;//TddHyperlink.Write2Generator

function TddHyperlink.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9AC570374_var*
//#UC END# *54DC46B50110_54D9AC570374_var*
begin
//#UC START# *54DC46B50110_54D9AC570374_impl*
 Result := TddHyperlink.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9AC570374_impl*
end;//TddHyperlink.Clone

function TddHyperlink.SkipSegment(aDiffCHP: TddCharacterProperty;
  aLiteVersion: TddLiteVersion): Boolean;
//#UC START# *54E4325C00BE_54D9AC570374_var*
//#UC END# *54E4325C00BE_54D9AC570374_var*
begin
//#UC START# *54E4325C00BE_54D9AC570374_impl*
 Result := False;
//#UC END# *54E4325C00BE_54D9AC570374_impl*
end;//TddHyperlink.SkipSegment

function TddHyperlink.IsHyperlink: Boolean;
//#UC START# *55E004D80069_54D9AC570374_var*
//#UC END# *55E004D80069_54D9AC570374_var*
begin
//#UC START# *55E004D80069_54D9AC570374_impl*
 Result := True;
//#UC END# *55E004D80069_54D9AC570374_impl*
end;//TddHyperlink.IsHyperlink

end.