unit evArchiLikeDocumentContainer;

// ������: "w:\archi\source\projects\Common\Utils\evArchiLikeDocumentContainer.pas"
// ���������: "SimpleClass"
// ������� ������: "TevArchiLikeDocumentContainer" MUID: (50F8F97E0292)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
;

type
 TevArchiLikeDocumentContainer = class(TnevPrintableDocumentContainer)
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
 end;//TevArchiLikeDocumentContainer

implementation

uses
 l3ImplUses
 , l3Base
;

procedure TevArchiLikeDocumentContainer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_50F8F97E0292_var*
//#UC END# *479731C50290_50F8F97E0292_var*
begin
//#UC START# *479731C50290_50F8F97E0292_impl*
 inherited;
//#UC END# *479731C50290_50F8F97E0292_impl*
end;//TevArchiLikeDocumentContainer.Cleanup

end.
