unit nsBaseTagNode;
 {* Базовая реализация тега на уровне оболочки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBaseTagNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , k2HugeTagObject
 , l3Variant
 , k2Interfaces
;

type
 TnsBaseTagNode = {abstract} class(Tk2HugeTagObject)
  {* Базовая реализация тега на уровне оболочки }
  protected
   function BaseDeleteChild(anIndex: Integer;
    const aContext: Ik2Op): Boolean;
   procedure CheckChildDelete(anIndex: Integer;
    aChild: Tl3Tag); virtual;
   function DoDeleteChild(anIndex: Integer;
    const aContext: Ik2Op): Boolean; virtual;
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
 end;//TnsBaseTagNode

implementation

uses
 l3ImplUses
;

function TnsBaseTagNode.BaseDeleteChild(anIndex: Integer;
 const aContext: Ik2Op): Boolean;
//#UC START# *4C6CEDA601C5_467FCA4701F9_var*
//#UC END# *4C6CEDA601C5_467FCA4701F9_var*
begin
//#UC START# *4C6CEDA601C5_467FCA4701F9_impl*
 Result := inherited DeleteChildPrim(anIndex, nil, aContext);
//#UC END# *4C6CEDA601C5_467FCA4701F9_impl*
end;//TnsBaseTagNode.BaseDeleteChild

procedure TnsBaseTagNode.CheckChildDelete(anIndex: Integer;
 aChild: Tl3Tag);
//#UC START# *4C6CED10018F_467FCA4701F9_var*
//#UC END# *4C6CED10018F_467FCA4701F9_var*
begin
//#UC START# *4C6CED10018F_467FCA4701F9_impl*
//#UC END# *4C6CED10018F_467FCA4701F9_impl*
end;//TnsBaseTagNode.CheckChildDelete

function TnsBaseTagNode.DoDeleteChild(anIndex: Integer;
 const aContext: Ik2Op): Boolean;
//#UC START# *4C6CED4C009B_467FCA4701F9_var*
//#UC END# *4C6CED4C009B_467FCA4701F9_var*
begin
//#UC START# *4C6CED4C009B_467FCA4701F9_impl*
 Result := BaseDeleteChild(anIndex, aContext);
//#UC END# *4C6CED4C009B_467FCA4701F9_impl*
end;//TnsBaseTagNode.DoDeleteChild

function TnsBaseTagNode.DeleteChildPrim(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_467FCA4701F9_var*
//#UC END# *4C6CE735026E_467FCA4701F9_var*
begin
//#UC START# *4C6CE735026E_467FCA4701F9_impl*
 CheckChildDelete(anIndex, aChild);
 Result := DoDeleteChild(anIndex, aContext);
//#UC END# *4C6CE735026E_467FCA4701F9_impl*
end;//TnsBaseTagNode.DeleteChildPrim

end.
