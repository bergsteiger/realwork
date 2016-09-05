unit l3OneByteCString;

// Модуль: "w:\common\components\rtl\Garant\L3\l3OneByteCString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3OneByteCString" MUID: (4F5CBB9600F6)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3OneByteCString = class(Tl3CProtoObject, Il3CString)
  private
   f_Ch: AnsiChar;
  protected
   function pm_GetAsWStr: Tl3WString;
  public
   constructor Create(aChar: AnsiChar); reintroduce;
   class function Make(aChar: AnsiChar): Il3CString; reintroduce;
 end;//Tl3OneByteCString

implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4F5CBB9600F6impl_uses*
 //#UC END# *4F5CBB9600F6impl_uses*
;

constructor Tl3OneByteCString.Create(aChar: AnsiChar);
//#UC START# *4F5CBC4003A2_4F5CBB9600F6_var*
//#UC END# *4F5CBC4003A2_4F5CBB9600F6_var*
begin
//#UC START# *4F5CBC4003A2_4F5CBB9600F6_impl*
 inherited Create;
 f_Ch := aChar;
//#UC END# *4F5CBC4003A2_4F5CBB9600F6_impl*
end;//Tl3OneByteCString.Create

class function Tl3OneByteCString.Make(aChar: AnsiChar): Il3CString;
var
 l_Inst : Tl3OneByteCString;
begin
 l_Inst := Create(aChar);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3OneByteCString.Make

function Tl3OneByteCString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_4F5CBB9600F6get_var*
//#UC END# *46780DEF03E5_4F5CBB9600F6get_var*
begin
//#UC START# *46780DEF03E5_4F5CBB9600F6get_impl*
 Result.S := @f_Ch;
 Result.SLen := 1;
 Result.SCodePage := CP_ANSI;
//#UC END# *46780DEF03E5_4F5CBB9600F6get_impl*
end;//Tl3OneByteCString.pm_GetAsWStr

end.
