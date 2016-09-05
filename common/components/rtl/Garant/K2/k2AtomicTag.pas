unit k2AtomicTag;
 {* Базовый атомарный тег }

// Модуль: "w:\common\components\rtl\Garant\K2\k2AtomicTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2AtomicTag" MUID: (53207C0102F8)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2NotStructuredTag
 , l3Interfaces
;

type
 Rk2AtomicTag = class of Tk2AtomicTag;

 Tk2AtomicTag = {abstract} class(Tk2NotStructuredTag)
  {* Базовый атомарный тег }
  protected
   f_Value: Integer;
  protected
   function GetAsPCharLen: Tl3WString; override;
   function GetAsLong: Integer; override;
   function GetAsString: AnsiString; override;
   function GetIsOrd: Boolean; override;
 end;//Tk2AtomicTag

implementation

uses
 l3ImplUses
 , l3String
 , k2Base
 //#UC START# *53207C0102F8impl_uses*
 //#UC END# *53207C0102F8impl_uses*
;

function Tk2AtomicTag.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_53207C0102F8_var*
//#UC END# *47A869BB02DE_53207C0102F8_var*
begin
//#UC START# *47A869BB02DE_53207C0102F8_impl*
 Result := l3PCharLen(AsString);
//#UC END# *47A869BB02DE_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsPCharLen

function Tk2AtomicTag.GetAsLong: Integer;
//#UC START# *5326D7B603A3_53207C0102F8_var*
//#UC END# *5326D7B603A3_53207C0102F8_var*
begin
//#UC START# *5326D7B603A3_53207C0102F8_impl*
 Result := f_Value;
//#UC END# *5326D7B603A3_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsLong

function Tk2AtomicTag.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_53207C0102F8_var*
//#UC END# *5329CD1A020E_53207C0102F8_var*
begin
//#UC START# *5329CD1A020E_53207C0102F8_impl*
 Result := Tk2Type(Self.TagType).Wrapper.AsString(Self);
//#UC END# *5329CD1A020E_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsString

function Tk2AtomicTag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53207C0102F8_var*
//#UC END# *532AE8F2009A_53207C0102F8_var*
begin
//#UC START# *532AE8F2009A_53207C0102F8_impl*
 Result := true;
//#UC END# *532AE8F2009A_53207C0102F8_impl*
end;//Tk2AtomicTag.GetIsOrd

end.
