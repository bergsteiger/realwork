unit k2RawData_Wrap;

// Модуль: "w:\common\components\rtl\Garant\K2\k2RawData_Wrap.pas"
// Стереотип: "Wrapper"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , Persistent_Wrap
 , l3Variant
;

type
 Wk2RawData = class(WPersistent)
  protected
   function ObjToTag(aValue: TObject): Il3TagRef; override;
 end;//Wk2RawData

implementation

uses
 l3ImplUses
 , l3Stream
 , SysUtils
 , k2SizedMemoryPool
;

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
