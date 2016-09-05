unit ddObjectSegment;

// Модуль: "w:\common\components\rtl\Garant\dd\ddObjectSegment.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddObjectSegment" MUID: (54D9B0A2024C)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
 , ddTypes
;

type
 TddObjectSegment = class(TddTextSegment)
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aCHP: TddCharacterProperty;
    aParentCHP: TddCharacterProperty;
    aLiteVersion: TddLiteVersion); override;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
    aLiteVersion: TddLiteVersion): Boolean; override;
   function IsObjectSegment: Boolean; override;
 end;//TddObjectSegment

implementation

uses
 l3ImplUses
 , ddEVDTypesSupport
 , k2Tags
 //#UC START# *54D9B0A2024Cimpl_uses*
 //#UC END# *54D9B0A2024Cimpl_uses*
;

procedure TddObjectSegment.Write2Generator(const Generator: Ik2TagGenerator;
 aCHP: TddCharacterProperty;
 aParentCHP: TddCharacterProperty;
 aLiteVersion: TddLiteVersion);
//#UC START# *54D888450259_54D9B0A2024C_var*
//#UC END# *54D888450259_54D9B0A2024C_var*
begin
//#UC START# *54D888450259_54D9B0A2024C_impl*
 if not Data.CanWrite then Exit; 
 StartObjectSegment(Generator);
 try
  DoWriteSegmentProps(Generator, aCHP, aParentCHP, aLiteVersion);
  Data.Write2Generator(Generator, False, aLiteVersion);
 finally
  Generator.Finish;
 end; // k2_idTextSegment
//#UC END# *54D888450259_54D9B0A2024C_impl*
end;//TddObjectSegment.Write2Generator

function TddObjectSegment.SkipSegment(aDiffCHP: TddCharacterProperty;
 aLiteVersion: TddLiteVersion): Boolean;
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
