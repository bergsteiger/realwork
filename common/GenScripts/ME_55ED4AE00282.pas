unit tfwMembersIteratorPrim;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIteratorPrim.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwMembersIteratorPrim" MUID: (55ED4AE00282)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParent
 , tfwDictionaryPrim
;

type
 TtfwMembersIteratorPrim = {abstract} class(TtfwIteratableParent)
  private
   f_Dictionary: TtfwDictionaryPrim;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aDictionary: TtfwDictionaryPrim); reintroduce;
  protected
   property Dictionary: TtfwDictionaryPrim
    read f_Dictionary;
 end;//TtfwMembersIteratorPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwMembersIteratorPrim.Create(aDictionary: TtfwDictionaryPrim);
//#UC START# *52E29FCF00BC_55ED4AE00282_var*
//#UC END# *52E29FCF00BC_55ED4AE00282_var*
begin
//#UC START# *52E29FCF00BC_55ED4AE00282_impl*
 inherited Create;
 f_Dictionary := aDictionary;
 //aDictionary.SetRefTo(f_Dictionary);
//#UC END# *52E29FCF00BC_55ED4AE00282_impl*
end;//TtfwMembersIteratorPrim.Create

procedure TtfwMembersIteratorPrim.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_55ED4AE00282_var*
//#UC END# *479731C50290_55ED4AE00282_var*
begin
//#UC START# *479731C50290_55ED4AE00282_impl*
 //FreeAndNil(f_Dictionary);
 f_Dictionary := nil;
 inherited;
//#UC END# *479731C50290_55ED4AE00282_impl*
end;//TtfwMembersIteratorPrim.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

end.
