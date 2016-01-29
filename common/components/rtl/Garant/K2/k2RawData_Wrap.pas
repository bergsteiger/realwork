unit k2RawData_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2RawData_Wrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::K2::Standard::Wk2RawData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  Persistent_Wrap,
  l3Variant
  ;

type
 Wk2RawData = class(WPersistent)
 protected
 // overridden protected methods
   function ObjToTag(aValue: TObject): Il3TagRef; override;
 end;//Wk2RawData

implementation

uses
  l3Stream,
  SysUtils,
  k2SizedMemoryPool
  ;

// start class Wk2RawData

function Wk2RawData.ObjToTag(aValue: TObject): Il3TagRef;
//#UC START# *484CEAD301AE_53C0068E01BC_var*
var
 l_Pool : Tk2RawData;
//#UC END# *484CEAD301AE_53C0068E01BC_var*
begin
//#UC START# *484CEAD301AE_53C0068E01BC_impl*
 if (aValue Is Tl3PrimString) then
 begin
  l_Pool := Tk2RawData.CreateFromString(Tl3PrimString(aValue));
  try
   Result := l_Pool.AsRef;
  finally
   FreeAndNil(l_Pool);
  end;//try..finally
 end//aValue Is Tl3PrimString
 else
  Result := inherited ObjToTag(aValue);
//#UC END# *484CEAD301AE_53C0068E01BC_impl*
end;//Wk2RawData.ObjToTag

end.