unit m3BaseArcStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3BaseArcStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3BaseArcStream" MUID: (53FF2D7500EB)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , ActiveX
 , m3BaseHeaderStream
;

type
 Tm3BaseArcStreamHeader = packed record
 //#UC START# *53FF2DA80270publ*
   RZerroFrontierByte: Byte;
   RRealSize: Int64;
   RListPos: Int64;
 //#UC END# *53FF2DA80270publ*
 end;//Tm3BaseArcStreamHeader

 _HeaderType_ = Tm3BaseArcStreamHeader;
 {$Include w:\common\components\rtl\Garant\m3\m3CustomHeaderStream.imp.pas}
 Tm3BaseArcStream = class(_m3CustomHeaderStream_)
  public
   class function HeaderID: TCLSID; override;
   class function DefaultHeaderValue: _HeaderType_; override;
 end;//Tm3BaseArcStream

implementation

uses
 l3ImplUses
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
 //#UC START# *53FF2D7500EBimpl_uses*
 //#UC END# *53FF2D7500EBimpl_uses*
;

{$Include w:\common\components\rtl\Garant\m3\m3CustomHeaderStream.imp.pas}

class function Tm3BaseArcStream.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_53FF2D7500EB_var*
const
 cHeaderID : TCLSID = '{06FC0FAE-71B5-433C-AA4D-A2A18B891668}';
//#UC END# *53FDFAF900ED_53FF2D7500EB_var*
begin
//#UC START# *53FDFAF900ED_53FF2D7500EB_impl*
 Result := cHeaderID;
//#UC END# *53FDFAF900ED_53FF2D7500EB_impl*
end;//Tm3BaseArcStream.HeaderID

class function Tm3BaseArcStream.DefaultHeaderValue: _HeaderType_;
//#UC START# *53FF37DC003A_53FF2D7500EB_var*
const
  CHeaderData000: Tm3BaseArcStreamHeader = (
   RZerroFrontierByte: 0;
   RRealSize: 0;
   RListPos: Int64(-1);
 );
//#UC END# *53FF37DC003A_53FF2D7500EB_var*
begin
//#UC START# *53FF37DC003A_53FF2D7500EB_impl*
 Result := CHeaderData000;
//#UC END# *53FF37DC003A_53FF2D7500EB_impl*
end;//Tm3BaseArcStream.DefaultHeaderValue

end.
