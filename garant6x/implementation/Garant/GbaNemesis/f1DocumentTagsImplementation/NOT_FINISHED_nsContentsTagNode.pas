unit NOT_FINISHED_nsContentsTagNode;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_FINISHED_nsContentsTagNode.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsContentsTagNode" MUID: (4682828F0267)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsContentsNode
 , k2Interfaces
;

type
 TnsContentsTagNode = class(TnsContentsNode)
  private
   f_Tag: Ik2Tag;
    {* ���, ������� ������������ ����. }
  protected
   procedure ClearFields; override;
 end;//TnsContentsTagNode

implementation

uses
 l3ImplUses
 //#UC START# *4682828F0267impl_uses*
 //#UC END# *4682828F0267impl_uses*
;

procedure TnsContentsTagNode.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TnsContentsTagNode.ClearFields

end.
