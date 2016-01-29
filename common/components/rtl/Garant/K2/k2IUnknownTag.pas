unit k2IUnknownTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2IUnknownTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2IUnknownTag
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant,
  k2NotStructuredTag,
  k2Base,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = Tk2NotStructuredTag;
 {$Include ..\K2\k2Tag.imp.pas}
 Tk2IUnknownTag = class(_k2Tag_)
 private
 // private fields
   f_Interface : IUnknown;
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   function GetTagType: Tl3VariantDef; override;
 public
 // public methods
   constructor Create(const anInterface: IUnknown); reintroduce;
   class function Make(const anInterface: IUnknown): Il3TagRef; reintroduce;
     {* Сигнатура фабрики Tk2IUnknownTag.Make }
 end;//Tk2IUnknownTag

implementation

uses
  k2IUnknown_Const,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  SysUtils,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Stream,
  l3Base,
  k2Facade,
  Classes,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2String,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2IUnknownTag;

{$Include ..\K2\k2Tag.imp.pas}

// start class Tk2IUnknownTag

constructor Tk2IUnknownTag.Create(const anInterface: IUnknown);
//#UC START# *531F2C14010E_531F2B0B0102_var*
//#UC END# *531F2C14010E_531F2B0B0102_var*
begin
//#UC START# *531F2C14010E_531F2B0B0102_impl*
 inherited Create;
 f_Interface := anInterface;
//#UC END# *531F2C14010E_531F2B0B0102_impl*
end;//Tk2IUnknownTag.Create

class function Tk2IUnknownTag.Make(const anInterface: IUnknown): Il3TagRef;
var
 l_Inst : Tk2IUnknownTag;
begin
 l_Inst := Create(anInterface);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$If not defined(k2TagIsAtomic)}
function Tk2IUnknownTag.SetAtomPrim(const aProp: _PropIn_;
  var V: Tk2Values): Boolean;
//#UC START# *49A545580241_531F2B0B0102_var*
//#UC END# *49A545580241_531F2B0B0102_var*
begin
//#UC START# *49A545580241_531F2B0B0102_impl*
 Result := false;
 Assert(false);
//#UC END# *49A545580241_531F2B0B0102_impl*
end;//Tk2IUnknownTag.SetAtomPrim
{$IfEnd} //not k2TagIsAtomic

procedure Tk2IUnknownTag.Cleanup;
//#UC START# *479731C50290_531F2B0B0102_var*
//#UC END# *479731C50290_531F2B0B0102_var*
begin
//#UC START# *479731C50290_531F2B0B0102_impl*
 f_Interface := nil;
 inherited;
//#UC END# *479731C50290_531F2B0B0102_impl*
end;//Tk2IUnknownTag.Cleanup

procedure Tk2IUnknownTag.InitFields;
//#UC START# *47A042E100E2_531F2B0B0102_var*
//#UC END# *47A042E100E2_531F2B0B0102_var*
begin
//#UC START# *47A042E100E2_531F2B0B0102_impl*
 inherited;
 //f_TagType := k2_typIUnknown;
//#UC END# *47A042E100E2_531F2B0B0102_impl*
end;//Tk2IUnknownTag.InitFields

function Tk2IUnknownTag.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_531F2B0B0102_var*
//#UC END# *4A60B23E00C3_531F2B0B0102_var*
begin
//#UC START# *4A60B23E00C3_531F2B0B0102_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail AND (f_Interface <> nil) then
  Result := Tl3HResult_C(f_Interface.QueryInterface(IID.IID, Obj));
//#UC END# *4A60B23E00C3_531F2B0B0102_impl*
end;//Tk2IUnknownTag.COMQueryInterface

function Tk2IUnknownTag.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_531F2B0B0102_var*
//#UC END# *533121AF0203_531F2B0B0102_var*
begin
//#UC START# *533121AF0203_531F2B0B0102_impl*
 Result := k2_typIUnknown;
//#UC END# *533121AF0203_531F2B0B0102_impl*
end;//Tk2IUnknownTag.GetTagType

end.