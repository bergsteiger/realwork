unit m3LZOInflateStreamNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3LZOInflateStreamNew.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::ArchiveStreams::Tm3LZOInflateStreamNew
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3ArcCla,
  ActiveX
  ;

type
 Tm3LZOInflateStreamNew = class(Tm3LZOInflateStream)
 protected
 // overridden protected methods
   class function NeedHeaderAlignment: Boolean; override;
 public
 // overridden public methods
   class function HeaderID: TCLSID; override;
 end;//Tm3LZOInflateStreamNew

implementation

uses
  m3LZODeflateStreamNew
  ;

// start class Tm3LZOInflateStreamNew

class function Tm3LZOInflateStreamNew.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_542AA48C0354_var*
//#UC END# *53FDFAF900ED_542AA48C0354_var*
begin
//#UC START# *53FDFAF900ED_542AA48C0354_impl*
 Result := Tm3LZODeflateStreamNew.HeaderID;
//#UC END# *53FDFAF900ED_542AA48C0354_impl*
end;//Tm3LZOInflateStreamNew.HeaderID

class function Tm3LZOInflateStreamNew.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_542AA48C0354_var*
//#UC END# *5408826C0072_542AA48C0354_var*
begin
//#UC START# *5408826C0072_542AA48C0354_impl*
 Result := false;
//#UC END# *5408826C0072_542AA48C0354_impl*
end;//Tm3LZOInflateStreamNew.NeedHeaderAlignment

end.