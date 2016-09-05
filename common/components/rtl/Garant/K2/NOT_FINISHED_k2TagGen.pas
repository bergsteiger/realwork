unit NOT_FINISHED_k2TagGen;
 {* Базовый абстрактный класс для генераторов тегов. }

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2TagGen.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "k2TagGen" MUID: (47ECAA270135)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3_Base
 , l3Variant
 , l3Interfaces
 , Classes
;

type
 Ik2TagGeneratorWrap = interface
  ['{E2449818-8F20-4255-847C-CE853016CF3C}']
 end;//Ik2TagGeneratorWrap

 Tk2TagGeneratorOwner = class
 end;//Tk2TagGeneratorOwner

 Ik2TagGeneratorChainEnd = interface
  ['{8E51C45A-4B99-4B6F-A266-EE9E388FE1C2}']
 end;//Ik2TagGeneratorChainEnd

 Tk2TagGenerator = class(Tl3_Base, Ik2TagGenerator, Ik2TagGeneratorWrap, Ik2TagGeneratorChainEnd)
  {* Базовый абстрактный класс для генераторов тегов. }
  protected
   procedure AddAtom(AtomIndex: Integer;
    aValue: Tl3Variant); overload; virtual;
   procedure StartChild(TypeID: Tl3Type); overload; virtual;
   procedure StartTag(TagID: Integer); overload; virtual;
   procedure OpenStream; virtual;
    {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure CloseStream(NeedUndo: Boolean); virtual;
    {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
   procedure CloseStructure(NeedUndo: Boolean); virtual;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure GeneratorChanged; virtual;
    {* нотификация о смене следующего генератора. Для перекрытия в потомках. }
   function GetObjectID(const Name: AnsiString;
    Child: Boolean): Integer; virtual;
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); overload; virtual;
   procedure AfterStreamOpened; virtual;
   procedure Error(Message: PAnsiChar;
    NeedException: Boolean = True); virtual;
   procedure AddStringAtom(TagID: Integer;
    const Value: AnsiString;
    aCodePage: Integer = CP_ANSI); overload;
    {* добавить строковый атом. }
   procedure AddStringAtom(TagID: Integer;
    const Value: Tl3WString); overload;
    {* добавить строковый атом. }
   procedure AddStreamAtom(TagID: Integer;
    aStream: TStream);
    {* добавить атом из потока. }
   procedure AddTransparentAtom(TagID: Integer);
    {* добавить "прозрачный" атом. }
   procedure AddIntegerAtom(TagID: Integer;
    Value: Integer);
    {* добавить целочисленный атом. }
   procedure AddBoolAtom(TagID: Integer;
    Value: Boolean);
   procedure AddAtom(AtomIndex: Integer;
    aValue: Tl3Variant); overload;
    {* добавить атом. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); overload;
   procedure Start;
    {* начать генерацию. }
   procedure StartChild(TypeID: Tl3VariantDef); overload;
    {* начать дочерний объект тега. }
   procedure StartDefaultChild;
    {* начать дочерний объект тега с типом по-умолчанию. }
   procedure StartTag(TagID: Integer); overload;
    {* начать вложеный тег. }
   procedure Finish(NeedUndo: Boolean = False);
    {* закрыть скобку этапа генерации. }
   procedure pm_SetCharsInLine(aValue: Integer);
   function pm_GetNextGenerator: Ik2TagGenerator;
   procedure pm_SetNextGenerator(const aValue: Ik2TagGenerator);
   function pm_GetCurrentStartLevel: Integer;
   procedure Rollback(CheckBrackets: Boolean = False);
    {* откатить все открытые "скобки". }
   function Pixel2Char(Pixel: Integer): Integer;
   function Get_CurrentVersion: Integer;
   procedure Set_CurrentVersion(aValue: Integer);
   procedure AddInt64Atom(aTagID: Integer;
    aValue: Int64);
    {* Добавляет 64-битный атом }
   function Char2Pixel(aCh: Integer): Integer;
   function pm_GetContext: Il3OpPack;
  public
   constructor Create(anOwner: Tk2TagGeneratorOwner = nil); reintroduce; virtual;
 end;//Tk2TagGenerator

implementation

uses
 l3ImplUses
 , k2VariantImpl
 {$If NOT Defined(NoScripts)}
 , kwFiltersAndGeneratorsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *47ECAA270135impl_uses*
 //#UC END# *47ECAA270135impl_uses*
;

procedure Tk2TagGenerator.AddAtom(AtomIndex: Integer;
 aValue: Tl3Variant);
//#UC START# *4836D26F0055_47ECAA5B0394_var*
//#UC END# *4836D26F0055_47ECAA5B0394_var*
begin
//#UC START# *4836D26F0055_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D26F0055_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddAtom

procedure Tk2TagGenerator.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_47ECAA5B0394_var*
//#UC END# *4836D4650177_47ECAA5B0394_var*
begin
//#UC START# *4836D4650177_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4650177_47ECAA5B0394_impl*
end;//Tk2TagGenerator.StartChild

procedure Tk2TagGenerator.StartTag(TagID: Integer);
//#UC START# *4836D477022A_47ECAA5B0394_var*
//#UC END# *4836D477022A_47ECAA5B0394_var*
begin
//#UC START# *4836D477022A_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D477022A_47ECAA5B0394_impl*
end;//Tk2TagGenerator.StartTag

procedure Tk2TagGenerator.OpenStream;
 {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
//#UC START# *4836D49800CA_47ECAA5B0394_var*
//#UC END# *4836D49800CA_47ECAA5B0394_var*
begin
//#UC START# *4836D49800CA_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D49800CA_47ECAA5B0394_impl*
end;//Tk2TagGenerator.OpenStream

procedure Tk2TagGenerator.CloseStream(NeedUndo: Boolean);
 {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
//#UC START# *4836D4B003DC_47ECAA5B0394_var*
//#UC END# *4836D4B003DC_47ECAA5B0394_var*
begin
//#UC START# *4836D4B003DC_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4B003DC_47ECAA5B0394_impl*
end;//Tk2TagGenerator.CloseStream

procedure Tk2TagGenerator.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_47ECAA5B0394_var*
//#UC END# *4836D4C20059_47ECAA5B0394_var*
begin
//#UC START# *4836D4C20059_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4C20059_47ECAA5B0394_impl*
end;//Tk2TagGenerator.CloseStructure

procedure Tk2TagGenerator.GeneratorChanged;
 {* нотификация о смене следующего генератора. Для перекрытия в потомках. }
//#UC START# *4836D4D503C9_47ECAA5B0394_var*
//#UC END# *4836D4D503C9_47ECAA5B0394_var*
begin
//#UC START# *4836D4D503C9_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4D503C9_47ECAA5B0394_impl*
end;//Tk2TagGenerator.GeneratorChanged

function Tk2TagGenerator.GetObjectID(const Name: AnsiString;
 Child: Boolean): Integer;
//#UC START# *4836D4F5021B_47ECAA5B0394_var*
//#UC END# *4836D4F5021B_47ECAA5B0394_var*
begin
//#UC START# *4836D4F5021B_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4F5021B_47ECAA5B0394_impl*
end;//Tk2TagGenerator.GetObjectID

procedure Tk2TagGenerator.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_47ECAA5B0394_var*
//#UC END# *4836D52400D9_47ECAA5B0394_var*
begin
//#UC START# *4836D52400D9_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D52400D9_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddAtomEx

procedure Tk2TagGenerator.AfterStreamOpened;
//#UC START# *4836D534009A_47ECAA5B0394_var*
//#UC END# *4836D534009A_47ECAA5B0394_var*
begin
//#UC START# *4836D534009A_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D534009A_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AfterStreamOpened

procedure Tk2TagGenerator.Error(Message: PAnsiChar;
 NeedException: Boolean = True);
//#UC START# *4836D5440159_47ECAA5B0394_var*
//#UC END# *4836D5440159_47ECAA5B0394_var*
begin
//#UC START# *4836D5440159_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D5440159_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Error

constructor Tk2TagGenerator.Create(anOwner: Tk2TagGeneratorOwner = nil);
//#UC START# *538C1F9A00C7_47ECAA5B0394_var*
//#UC END# *538C1F9A00C7_47ECAA5B0394_var*
begin
//#UC START# *538C1F9A00C7_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *538C1F9A00C7_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Create

procedure Tk2TagGenerator.AddStringAtom(TagID: Integer;
 const Value: AnsiString;
 aCodePage: Integer = CP_ANSI);
 {* добавить строковый атом. }
//#UC START# *469F83C300B2_47ECAA5B0394_var*
//#UC END# *469F83C300B2_47ECAA5B0394_var*
begin
//#UC START# *469F83C300B2_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F83C300B2_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddStringAtom

procedure Tk2TagGenerator.AddStringAtom(TagID: Integer;
 const Value: Tl3WString);
 {* добавить строковый атом. }
//#UC START# *469F84BB0023_47ECAA5B0394_var*
//#UC END# *469F84BB0023_47ECAA5B0394_var*
begin
//#UC START# *469F84BB0023_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F84BB0023_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddStringAtom

procedure Tk2TagGenerator.AddStreamAtom(TagID: Integer;
 aStream: TStream);
 {* добавить атом из потока. }
//#UC START# *469F870C01B6_47ECAA5B0394_var*
//#UC END# *469F870C01B6_47ECAA5B0394_var*
begin
//#UC START# *469F870C01B6_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F870C01B6_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddStreamAtom

procedure Tk2TagGenerator.AddTransparentAtom(TagID: Integer);
 {* добавить "прозрачный" атом. }
//#UC START# *469F872B0124_47ECAA5B0394_var*
//#UC END# *469F872B0124_47ECAA5B0394_var*
begin
//#UC START# *469F872B0124_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F872B0124_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddTransparentAtom

procedure Tk2TagGenerator.AddIntegerAtom(TagID: Integer;
 Value: Integer);
 {* добавить целочисленный атом. }
//#UC START# *469F87470084_47ECAA5B0394_var*
//#UC END# *469F87470084_47ECAA5B0394_var*
begin
//#UC START# *469F87470084_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F87470084_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddIntegerAtom

procedure Tk2TagGenerator.AddBoolAtom(TagID: Integer;
 Value: Boolean);
//#UC START# *469F87D4002D_47ECAA5B0394_var*
//#UC END# *469F87D4002D_47ECAA5B0394_var*
begin
//#UC START# *469F87D4002D_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F87D4002D_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddBoolAtom

procedure Tk2TagGenerator.AddAtom(AtomIndex: Integer;
 aValue: Tl3Variant);
 {* добавить атом. }
//#UC START# *469F8818037E_47ECAA5B0394_var*
//#UC END# *469F8818037E_47ECAA5B0394_var*
begin
//#UC START# *469F8818037E_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8818037E_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddAtom

procedure Tk2TagGenerator.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *469F8B580244_47ECAA5B0394_var*
//#UC END# *469F8B580244_47ECAA5B0394_var*
begin
//#UC START# *469F8B580244_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8B580244_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddAtomEx

procedure Tk2TagGenerator.Start;
 {* начать генерацию. }
//#UC START# *469F8B9E02C7_47ECAA5B0394_var*
//#UC END# *469F8B9E02C7_47ECAA5B0394_var*
begin
//#UC START# *469F8B9E02C7_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8B9E02C7_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Start

procedure Tk2TagGenerator.StartChild(TypeID: Tl3VariantDef);
 {* начать дочерний объект тега. }
//#UC START# *469F8BBA01EB_47ECAA5B0394_var*
//#UC END# *469F8BBA01EB_47ECAA5B0394_var*
begin
//#UC START# *469F8BBA01EB_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8BBA01EB_47ECAA5B0394_impl*
end;//Tk2TagGenerator.StartChild

procedure Tk2TagGenerator.StartDefaultChild;
 {* начать дочерний объект тега с типом по-умолчанию. }
//#UC START# *469F8BCC02D7_47ECAA5B0394_var*
//#UC END# *469F8BCC02D7_47ECAA5B0394_var*
begin
//#UC START# *469F8BCC02D7_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8BCC02D7_47ECAA5B0394_impl*
end;//Tk2TagGenerator.StartDefaultChild

procedure Tk2TagGenerator.StartTag(TagID: Integer);
 {* начать вложеный тег. }
//#UC START# *469F8BF00166_47ECAA5B0394_var*
//#UC END# *469F8BF00166_47ECAA5B0394_var*
begin
//#UC START# *469F8BF00166_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8BF00166_47ECAA5B0394_impl*
end;//Tk2TagGenerator.StartTag

procedure Tk2TagGenerator.Finish(NeedUndo: Boolean = False);
 {* закрыть скобку этапа генерации. }
//#UC START# *469F8C0A031C_47ECAA5B0394_var*
//#UC END# *469F8C0A031C_47ECAA5B0394_var*
begin
//#UC START# *469F8C0A031C_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8C0A031C_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Finish

procedure Tk2TagGenerator.pm_SetCharsInLine(aValue: Integer);
//#UC START# *469F8C450231_47ECAA5B0394set_var*
//#UC END# *469F8C450231_47ECAA5B0394set_var*
begin
//#UC START# *469F8C450231_47ECAA5B0394set_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8C450231_47ECAA5B0394set_impl*
end;//Tk2TagGenerator.pm_SetCharsInLine

function Tk2TagGenerator.pm_GetNextGenerator: Ik2TagGenerator;
//#UC START# *469F8C6D01B6_47ECAA5B0394get_var*
//#UC END# *469F8C6D01B6_47ECAA5B0394get_var*
begin
//#UC START# *469F8C6D01B6_47ECAA5B0394get_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8C6D01B6_47ECAA5B0394get_impl*
end;//Tk2TagGenerator.pm_GetNextGenerator

procedure Tk2TagGenerator.pm_SetNextGenerator(const aValue: Ik2TagGenerator);
//#UC START# *469F8C6D01B6_47ECAA5B0394set_var*
//#UC END# *469F8C6D01B6_47ECAA5B0394set_var*
begin
//#UC START# *469F8C6D01B6_47ECAA5B0394set_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8C6D01B6_47ECAA5B0394set_impl*
end;//Tk2TagGenerator.pm_SetNextGenerator

function Tk2TagGenerator.pm_GetCurrentStartLevel: Integer;
//#UC START# *469F8C8C02FB_47ECAA5B0394get_var*
//#UC END# *469F8C8C02FB_47ECAA5B0394get_var*
begin
//#UC START# *469F8C8C02FB_47ECAA5B0394get_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F8C8C02FB_47ECAA5B0394get_impl*
end;//Tk2TagGenerator.pm_GetCurrentStartLevel

procedure Tk2TagGenerator.Rollback(CheckBrackets: Boolean = False);
 {* откатить все открытые "скобки". }
//#UC START# *469F956E01A6_47ECAA5B0394_var*
//#UC END# *469F956E01A6_47ECAA5B0394_var*
begin
//#UC START# *469F956E01A6_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F956E01A6_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Rollback

function Tk2TagGenerator.Pixel2Char(Pixel: Integer): Integer;
//#UC START# *469F9589032C_47ECAA5B0394_var*
//#UC END# *469F9589032C_47ECAA5B0394_var*
begin
//#UC START# *469F9589032C_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *469F9589032C_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Pixel2Char

function Tk2TagGenerator.Get_CurrentVersion: Integer;
//#UC START# *4C1B7F810123_47ECAA5B0394get_var*
//#UC END# *4C1B7F810123_47ECAA5B0394get_var*
begin
//#UC START# *4C1B7F810123_47ECAA5B0394get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C1B7F810123_47ECAA5B0394get_impl*
end;//Tk2TagGenerator.Get_CurrentVersion

procedure Tk2TagGenerator.Set_CurrentVersion(aValue: Integer);
//#UC START# *4C1B7F810123_47ECAA5B0394set_var*
//#UC END# *4C1B7F810123_47ECAA5B0394set_var*
begin
//#UC START# *4C1B7F810123_47ECAA5B0394set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C1B7F810123_47ECAA5B0394set_impl*
end;//Tk2TagGenerator.Set_CurrentVersion

procedure Tk2TagGenerator.AddInt64Atom(aTagID: Integer;
 aValue: Int64);
 {* Добавляет 64-битный атом }
//#UC START# *4E31464A0116_47ECAA5B0394_var*
//#UC END# *4E31464A0116_47ECAA5B0394_var*
begin
//#UC START# *4E31464A0116_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E31464A0116_47ECAA5B0394_impl*
end;//Tk2TagGenerator.AddInt64Atom

function Tk2TagGenerator.Char2Pixel(aCh: Integer): Integer;
//#UC START# *532AD07903C5_47ECAA5B0394_var*
//#UC END# *532AD07903C5_47ECAA5B0394_var*
begin
//#UC START# *532AD07903C5_47ECAA5B0394_impl*
 !!! Needs to be implemented !!!
//#UC END# *532AD07903C5_47ECAA5B0394_impl*
end;//Tk2TagGenerator.Char2Pixel

function Tk2TagGenerator.pm_GetContext: Il3OpPack;
//#UC START# *533C0C71011C_47ECAA5B0394get_var*
//#UC END# *533C0C71011C_47ECAA5B0394get_var*
begin
//#UC START# *533C0C71011C_47ECAA5B0394get_impl*
 !!! Needs to be implemented !!!
//#UC END# *533C0C71011C_47ECAA5B0394get_impl*
end;//Tk2TagGenerator.pm_GetContext

end.
