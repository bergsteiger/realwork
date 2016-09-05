unit k2NonAtomicTag;
 {* ������� ����������� ��� }

// ������: "w:\common\components\rtl\Garant\K2\k2NonAtomicTag.pas"
// ���������: "SimpleClass"
// ������� ������: "Tk2NonAtomicTag" MUID: (532080BB027A)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Tag
;

type
 Tk2NonAtomicTag = {abstract} class(Tk2Tag)
  {* ������� ����������� ��� }
  protected
   function GetIsOrd: Boolean; override;
 end;//Tk2NonAtomicTag

implementation

uses
 l3ImplUses
 //#UC START# *532080BB027Aimpl_uses*
 //#UC END# *532080BB027Aimpl_uses*
;

function Tk2NonAtomicTag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_532080BB027A_var*
//#UC END# *532AE8F2009A_532080BB027A_var*
begin
//#UC START# *532AE8F2009A_532080BB027A_impl*
 Result := false;
//#UC END# *532AE8F2009A_532080BB027A_impl*
end;//Tk2NonAtomicTag.GetIsOrd

end.
