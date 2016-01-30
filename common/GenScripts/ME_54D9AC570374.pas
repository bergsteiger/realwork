unit ddHyperlink;

// Модуль: "w:\common\components\rtl\Garant\dd\ddHyperlink.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
;

type
 TddHyperlink = class(TddTextSegment)
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aCHP: TddCharacterProperty;
    aParentCHP: TddCharacterProperty;
    LiteVersion: Boolean); override;
   function Clone: TddTextSegment; override;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
    LiteVersion: Boolean): Boolean; override;
   function IsHyperlink: Boolean; override;
 end;//TddHyperlink

implementation

uses
 l3ImplUses
 , ddTypes
 , ddHyperlinkTarget
;

procedure TddHyperlink.Write2Generator(const Generator: Ik2TagGenerator;
 aCHP: TddCharacterProperty;
 aParentCHP: TddCharacterProperty;
 LiteVersion: Boolean);
//#UC START# *54D888450259_54D9AC570374_var*
var
 j       : Integer;
 l_Target: TddHyperlinkTarget;
//#UC END# *54D888450259_54D9AC570374_var*
begin
//#UC START# *54D888450259_54D9AC570374_impl*
 StartHyperlink(Generator);
 try
  Generator.AddIntegerAtom(k2_tiStart, Start);
  Generator.AddIntegerAtom(k2_tiFinish, Stop);
  if HLHandle <> -1 then
   Generator.AddIntegerAtom(k2_tiHandle, HLHandle);
  for j := 0 to TargetList.Hi do
  begin
   l_Target := TargetList[j];
   l_Target.Write2Generator(Generator, LiteVersion);
  end; // for j
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
 LiteVersion: Boolean): Boolean;
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
