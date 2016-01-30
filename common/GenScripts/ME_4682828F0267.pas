unit NOT_FINISHED_nsContentsTagNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_FINISHED_nsContentsTagNode.pas"
// Стереотип: "SimpleClass"

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
    {* Тег, который представляет нода. }
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
