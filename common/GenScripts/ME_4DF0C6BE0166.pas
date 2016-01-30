unit k2TagByHandleView;

// ������: "w:\common\components\rtl\Garant\K2\k2TagByHandleView.pas"
// ���������: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2CustomTagView
 , l3PureMixIns
;

type
 Tk2TagByHandleView = class(Tk2CustomTagView)
  protected
   function CompareData(const anItem1: _ItemType_;
    const anItem2: _ItemType_): Integer; override;
 end;//Tk2TagByHandleView

implementation

uses
 l3ImplUses
 , k2Tags
;

function Tk2TagByHandleView.CompareData(const anItem1: _ItemType_;
 const anItem2: _ItemType_): Integer;
//#UC START# *4DEFB2D90167_4DF0C6BE0166_var*
//#UC END# *4DEFB2D90167_4DF0C6BE0166_var*
begin
//#UC START# *4DEFB2D90167_4DF0C6BE0166_impl*
 Result := anItem1.IntA[k2_tiHandle] - anItem2.IntA[k2_tiHandle];
//#UC END# *4DEFB2D90167_4DF0C6BE0166_impl*
end;//Tk2TagByHandleView.CompareData

end.
