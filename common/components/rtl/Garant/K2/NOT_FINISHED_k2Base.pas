unit NOT_FINISHED_k2Base;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/NOT_FINISHED_k2Base.pas"
// Начат: 12.04.1998 11:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::K2::k2PrimObjects::k2Base
//
// Базовые классы библиотеки K-2.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  k2Prim,
  k2TypeModelPart,
  k2AtomWrapPrim,
  l3Variant
  ;

type
 Tk2CustomProperty = {abstract} class(Tk2CustomPropertyPrim)
  {* Базовый класс для описания свойства тега. }
 protected
 // realized methods
   function pm_GetEmptyMapping: Integer; override;
   function pm_GetReadOnly: Boolean; override;
   function pm_GetMappingTarget: Integer; override;
   function pm_GetDefaultValue: Integer; override;
 end;//Tk2CustomProperty

 Tk2Property = class(Tk2CustomProperty)
  {* Описание свойства тега. }
 private
 // private fields
   f_EmptyMapping : Integer;
   f_DefaultValue : Integer;
   f_MappingTarget : Integer;
   f_ReadOnly : Boolean;
 end;//Tk2Property

 Tk2Type = class(Tk2TypeModelPart)
 end;//Tk2Type

 Tk2ChildrenProperty = class(Tk2CustomProperty)
 private
 // private fields
   f_ChildType : Tk2Type;
   f_DefaultChildType : Tk2Type;
   f_StoredChild : Integer;
   f_SortIndex : Integer;
   f_Duplicates : Tl3Duplicates;
 end;//Tk2ChildrenProperty

 Wk2Atom = class(Tk2AtomWrapPrim)
  {* Инструмент для реализации операций с тегами. }
 protected
 // protected methods
   function AsString(A: Tl3Variant): AnsiString; virtual;
   function StrToTag(const aValue: AnsiString): Tl3Tag; virtual;
   function ObjToTag(aValue: TObject): Il3TagRef; virtual;
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; virtual;
   function PreGetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; virtual;
 public
 // public methods
   procedure ForceStore(aTag: Tl3Variant); virtual;
   function MarkModified(aTag: Tl3Variant): Boolean; virtual;
 end;//Wk2Atom

 Tk2CustomPropertyPrim = k2Prim.Tk2CustomPropertyPrim;

 Tk2TypePrim = k2Prim.Tk2TypePrim;

 Tk2Base = k2Prim.Tk2Base;

 Tk2TypeTable = class(Tk2TypeTablePrim)
 end;//Tk2TypeTable

 Tk2Prop = Tk2CustomProperty;

 Tk2ArrayProperty = Tk2ChildrenProperty;
procedure K2NullTag;
   {* Сигнатура метода k2NullTag }

implementation

uses
  l3IID,
  l3InterfacesMisc,
  k2PropSorter,
  k2NullTagImpl,
  k2SortTagsList
  ;

// start class Tk2CustomProperty

function Tk2CustomProperty.pm_GetEmptyMapping: Integer;
//#UC START# *4A4DF48F02F1_47AC6F6A00FAget_var*
//#UC END# *4A4DF48F02F1_47AC6F6A00FAget_var*
begin
//#UC START# *4A4DF48F02F1_47AC6F6A00FAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4DF48F02F1_47AC6F6A00FAget_impl*
end;//Tk2CustomProperty.pm_GetEmptyMapping

function Tk2CustomProperty.pm_GetReadOnly: Boolean;
//#UC START# *4A4DF4D90012_47AC6F6A00FAget_var*
//#UC END# *4A4DF4D90012_47AC6F6A00FAget_var*
begin
//#UC START# *4A4DF4D90012_47AC6F6A00FAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4DF4D90012_47AC6F6A00FAget_impl*
end;//Tk2CustomProperty.pm_GetReadOnly

function Tk2CustomProperty.pm_GetMappingTarget: Integer;
//#UC START# *4A4DF71B035B_47AC6F6A00FAget_var*
//#UC END# *4A4DF71B035B_47AC6F6A00FAget_var*
begin
//#UC START# *4A4DF71B035B_47AC6F6A00FAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4DF71B035B_47AC6F6A00FAget_impl*
end;//Tk2CustomProperty.pm_GetMappingTarget

function Tk2CustomProperty.pm_GetDefaultValue: Integer;
//#UC START# *4A4DF88301A2_47AC6F6A00FAget_var*
//#UC END# *4A4DF88301A2_47AC6F6A00FAget_var*
begin
//#UC START# *4A4DF88301A2_47AC6F6A00FAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4DF88301A2_47AC6F6A00FAget_impl*
end;//Tk2CustomProperty.pm_GetDefaultValue
// start class Wk2Atom

procedure Wk2Atom.ForceStore(aTag: Tl3Variant);
//#UC START# *4CED2E7E010A_484CCCFF00D7_var*
//#UC END# *4CED2E7E010A_484CCCFF00D7_var*
begin
//#UC START# *4CED2E7E010A_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CED2E7E010A_484CCCFF00D7_impl*
end;//Wk2Atom.ForceStore

function Wk2Atom.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE5D3002FC_484CCCFF00D7_var*
//#UC END# *4CEE5D3002FC_484CCCFF00D7_var*
begin
//#UC START# *4CEE5D3002FC_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CEE5D3002FC_484CCCFF00D7_impl*
end;//Wk2Atom.MarkModified

function Wk2Atom.AsString(A: Tl3Variant): AnsiString;
//#UC START# *484CCE970073_484CCCFF00D7_var*
//#UC END# *484CCE970073_484CCCFF00D7_var*
begin
//#UC START# *484CCE970073_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *484CCE970073_484CCCFF00D7_impl*
end;//Wk2Atom.AsString

function Wk2Atom.StrToTag(const aValue: AnsiString): Tl3Tag;
//#UC START# *484CCEBC00DC_484CCCFF00D7_var*
//#UC END# *484CCEBC00DC_484CCCFF00D7_var*
begin
//#UC START# *484CCEBC00DC_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *484CCEBC00DC_484CCCFF00D7_impl*
end;//Wk2Atom.StrToTag

function Wk2Atom.ObjToTag(aValue: TObject): Il3TagRef;
//#UC START# *484CEAD301AE_484CCCFF00D7_var*
//#UC END# *484CEAD301AE_484CCCFF00D7_var*
begin
//#UC START# *484CEAD301AE_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *484CEAD301AE_484CCCFF00D7_impl*
end;//Wk2Atom.ObjToTag

function Wk2Atom.GetAtomData(AE: Tl3Variant;
  aProp: Tk2CustomProperty;
  out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_484CCCFF00D7_var*
//#UC END# *4857A995029E_484CCCFF00D7_var*
begin
//#UC START# *4857A995029E_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4857A995029E_484CCCFF00D7_impl*
end;//Wk2Atom.GetAtomData

function Wk2Atom.PreGetAtomData(AE: Tl3Variant;
  aProp: Tk2CustomProperty;
  out Data: Tl3Variant): Boolean;
//#UC START# *48DD0CE60313_484CCCFF00D7_var*
//#UC END# *48DD0CE60313_484CCCFF00D7_var*
begin
//#UC START# *48DD0CE60313_484CCCFF00D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48DD0CE60313_484CCCFF00D7_impl*
end;//Wk2Atom.PreGetAtomData
// unit methods

procedure K2NullTag;
//#UC START# *4CB46C85024E_47AC6F0B025E_var*
//#UC END# *4CB46C85024E_47AC6F0B025E_var*
begin
//#UC START# *4CB46C85024E_47AC6F0B025E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB46C85024E_47AC6F0B025E_impl*
end;//K2NullTag

end.