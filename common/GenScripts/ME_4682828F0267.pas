unit NOT_FINISHED_nsContentsTagNode;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_FINISHED_nsContentsTagNode.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

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
;

procedure TnsContentsTagNode.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TnsContentsTagNode.ClearFields

end.
