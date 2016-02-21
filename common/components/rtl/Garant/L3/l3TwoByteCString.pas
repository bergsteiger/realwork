unit l3TwoByteCString;

// Модуль: "w:\common\components\rtl\Garant\L3\l3TwoByteCString.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3TwoByteCString = class(Tl3CProtoObject, Il3CString)
  private
   f_Chars: Word;
  protected
   function pm_GetAsWStr: Tl3WString;
  public
   constructor Create(aChars: Word); reintroduce;
   class function Make(aChars: Word): Il3CString; reintroduce;
 end;//Tl3TwoByteCString

implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack
 {$IfEnd} // NOT Defined(NoScripts)
;

constructor Tl3TwoByteCString.Create(aChars: Word);
//#UC START# *4F5CBCAF00B4_4F5CBBE60070_var*
//#UC END# *4F5CBCAF00B4_4F5CBBE60070_var*
begin
//#UC START# *4F5CBCAF00B4_4F5CBBE60070_impl*
 inherited Create;
 f_Chars := aChars;
//#UC END# *4F5CBCAF00B4_4F5CBBE60070_impl*
end;//Tl3TwoByteCString.Create

class function Tl3TwoByteCString.Make(aChars: Word): Il3CString;
var
 l_Inst : Tl3TwoByteCString;
begin
 l_Inst := Create(aChars);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3TwoByteCString.Make

function Tl3TwoByteCString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_4F5CBBE60070get_var*
//#UC END# *46780DEF03E5_4F5CBBE60070get_var*
begin
//#UC START# *46780DEF03E5_4F5CBBE60070get_impl*
 Result.S := @f_Chars;
 Result.SLen := 2;
 Result.SCodePage := CP_ANSI;
//#UC END# *46780DEF03E5_4F5CBBE60070get_impl*
end;//Tl3TwoByteCString.pm_GetAsWStr

end.
