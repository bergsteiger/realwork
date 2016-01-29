unit k2DictRecTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2DictRecTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2DictRecTag
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2LeafTag,
  l3Variant,
  l3Interfaces
  ;

type
 Tk2DictRecTag = {abstract} class(Tk2LeafTag, Il3TagRef)
 protected
 // overridden protected methods
   function GetAsPCharLen: Tl3WString; override;
   function GetAsLong: Integer; override;
   function GetAsString: AnsiString; override;
   function GetAsRef: Il3TagRef; override;
 end;//Tk2DictRecTag

implementation

uses
  k2Tags
  ;

// start class Tk2DictRecTag

function Tk2DictRecTag.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_53208F54004F_var*
//#UC END# *47A869BB02DE_53208F54004F_var*
begin
//#UC START# *47A869BB02DE_53208F54004F_impl*
 Result := Attr[k2_tiName].AsWStr;
//#UC END# *47A869BB02DE_53208F54004F_impl*
end;//Tk2DictRecTag.GetAsPCharLen

function Tk2DictRecTag.GetAsLong: Integer;
//#UC START# *5326D7B603A3_53208F54004F_var*
//#UC END# *5326D7B603A3_53208F54004F_var*
begin
//#UC START# *5326D7B603A3_53208F54004F_impl*
 Result := rLong(k2_tiHandle, -1);
 // - это специально поправлено, т.к. рамки без Handle у SBS перезатирались
 //Result := IntA[k2_tiHandle];
//#UC END# *5326D7B603A3_53208F54004F_impl*
end;//Tk2DictRecTag.GetAsLong

function Tk2DictRecTag.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_53208F54004F_var*
//#UC END# *5329CD1A020E_53208F54004F_var*
begin
//#UC START# *5329CD1A020E_53208F54004F_impl*
 Result := StrA[k2_tiName];
//#UC END# *5329CD1A020E_53208F54004F_impl*
end;//Tk2DictRecTag.GetAsString

function Tk2DictRecTag.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_53208F54004F_var*
//#UC END# *53568FCA01E8_53208F54004F_var*
begin
//#UC START# *53568FCA01E8_53208F54004F_impl*
 Result := Self;
//#UC END# *53568FCA01E8_53208F54004F_impl*
end;//Tk2DictRecTag.GetAsRef

end.