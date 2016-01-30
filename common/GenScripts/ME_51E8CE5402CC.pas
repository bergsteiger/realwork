unit ddTab;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTab.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddBaseObject
 , ddTypes
 , k2Interfaces
;

type
 TddTab = class(TddBaseObject)
  private
   f_Kind: TTabKind;
    {* Поле для свойства Kind }
   f_TabLead: TTabLead;
    {* Поле для свойства TabLead }
   f_TabBar: LongInt;
    {* Поле для свойства TabBar }
   f_TabPos: LongInt;
    {* Поле для свойства TabPos }
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aLiteVersion: Boolean); override;
   procedure Assign(anObject: TddBaseObject); override;
   constructor Create; override;
  public
   property Kind: TTabKind
    read f_Kind
    write f_Kind;
   property TabLead: TTabLead
    read f_TabLead
    write f_TabLead;
   property TabBar: LongInt
    read f_TabBar
    write f_TabBar;
   property TabPos: LongInt
    read f_TabPos
    write f_TabPos;
 end;//TddTab

implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Chars
;

procedure TddTab.Write2Generator(const Generator: Ik2TagGenerator;
 aLiteVersion: Boolean);
//#UC START# *54DC9795018B_51E8CE5402CC_var*
//#UC END# *54DC9795018B_51E8CE5402CC_var*
begin
//#UC START# *54DC9795018B_51E8CE5402CC_impl*
 StartTab(Generator);
 try
 // перерасчитать размеры позиции
  if TabBar <> 0 then
   Generator.AddIntegerAtom(k2_tiStart, f_TabBar)
  else
   Generator.AddIntegerAtom(k2_tiStart, f_TabPos);
  case Kind of
   tkLeft: Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssLeft));
   tkRight: Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssRight));
   tkCentered: Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssCenter));
   tkDecimal: Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssDecimal));
  else
   Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssLine));
  end;
  case TabLead of
   tlDots       : Generator.AddStringAtom(k2_tiText, '.');
   tlMiddleDots : Generator.AddStringAtom(k2_tiText, cc_HardSpaceSymbol);
   tlHyphens    : Generator.AddStringAtom(k2_tiText, '-');
   tlUnderline  : Generator.AddStringAtom(k2_tiText, '_');
   tlThickLine  : Generator.AddStringAtom(k2_tiText, '_');
   tlEqualSign  : Generator.AddStringAtom(k2_tiText, '=');
  end;
 finally
  Generator.Finish;
 end;
//#UC END# *54DC9795018B_51E8CE5402CC_impl*
end;//TddTab.Write2Generator

procedure TddTab.Assign(anObject: TddBaseObject);
//#UC START# *52BACF8A01A9_51E8CE5402CC_var*
var
 l_Tab: TddTab;
//#UC END# *52BACF8A01A9_51E8CE5402CC_var*
begin
//#UC START# *52BACF8A01A9_51E8CE5402CC_impl*
 if anObject is TddTab then
 begin
  l_Tab := anObject as TddTab;
  f_Kind := l_Tab.Kind;
  f_TabPos := l_Tab.TabPos;
  f_TabLead := l_Tab.TabLead;
  f_TabBar := l_Tab.TabBar;
 end;
//#UC END# *52BACF8A01A9_51E8CE5402CC_impl*
end;//TddTab.Assign

constructor TddTab.Create;
//#UC START# *52BACFBE00D9_51E8CE5402CC_var*
//#UC END# *52BACFBE00D9_51E8CE5402CC_var*
begin
//#UC START# *52BACFBE00D9_51E8CE5402CC_impl*
 inherited Create;
 F_Kind := tkLeft;   {\tqr\tqc\tqdec}
 F_TabLead := tlNone;{\tldot\tlhyph\tlul\tleq}
 F_TabPos := 0;   {\tx}
 F_TabBar := 0;   {\tb}
//#UC END# *52BACFBE00D9_51E8CE5402CC_impl*
end;//TddTab.Create

end.
