unit NOT_FINISHED_l3Canvas;
 {* ������� ���������� ������ ������ ���������� ��� DeviceContext. }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Canvas.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3Canvas" MUID: (478E3C97021E)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CanvasPrim
;

type
 //#UC START# *478E3C97021Eci*
 //#UC END# *478E3C97021Eci*
 //#UC START# *478E3C97021Ecit*
 //#UC END# *478E3C97021Ecit*
 Tl3Canvas = {final} class(Tl3CanvasPrim)
  {* ������� ���������� ������ ������ ���������� ��� DeviceContext. }
 //#UC START# *478E3C97021Epubl*
 public
   property etoFlags default eto_Opaque;
   property BackColor default def_PaperColor;
   property Font: Il3Font
     read Get_Font
     write Set_Font;
   property TextColor default clBlack;
   property PageWidthNumber: Integer
     read pm_GetPageWidthNumber;
   property DrawSpecial default false;
   property Zoom default def_Zoom;
 //#UC END# *478E3C97021Epubl*
 end;//Tl3Canvas

implementation

uses
 l3ImplUses
;

//#UC START# *478E3C97021Eimpl*
//#UC END# *478E3C97021Eimpl*

end.
