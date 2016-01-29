unit m3LZODeflateStreamNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3LZODeflateStreamNew.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::ArchiveStreams::Tm3LZODeflateStreamNew
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
 Tm3LZODeflateStreamNew = class(Tm3LZODeflateStream)
 protected
 // overridden protected methods
   class function NeedHeaderAlignment: Boolean; override;
 public
 // overridden public methods
   class function HeaderID: TCLSID; override;
 end;//Tm3LZODeflateStreamNew

implementation

// start class Tm3LZODeflateStreamNew

class function Tm3LZODeflateStreamNew.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_542AA47B0241_var*
const
 cID : TGUID = '{93A7EBCE-9A80-4727-B8FD-8CABA46FE5B6}';
//#UC END# *53FDFAF900ED_542AA47B0241_var*
begin
//#UC START# *53FDFAF900ED_542AA47B0241_impl*
 Result := cID;
//#UC END# *53FDFAF900ED_542AA47B0241_impl*
end;//Tm3LZODeflateStreamNew.HeaderID

class function Tm3LZODeflateStreamNew.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_542AA47B0241_var*
//#UC END# *5408826C0072_542AA47B0241_var*
begin
//#UC START# *5408826C0072_542AA47B0241_impl*
 Result := false;
//#UC END# *5408826C0072_542AA47B0241_impl*
end;//Tm3LZODeflateStreamNew.NeedHeaderAlignment

end.