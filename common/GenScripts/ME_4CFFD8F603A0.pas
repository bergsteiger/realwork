unit eeEditorWithoutOperations;

// ������: "w:\common\components\gui\Garant\Everest_Engine\eeEditorWithoutOperations.pas"
// ���������: "GuiControl"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeEditor
 , evEditorWithOperations
;

type
 TeeEditorWithoutOperations = class(TeeEditor)
  protected
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* ����� �������� ����������� �����������. }
 end;//TeeEditorWithoutOperations

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TeeEditorWithoutOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* ����� �������� ����������� �����������. }
//#UC START# *48735C4A03C3_4CFFD8F603A0_var*
//#UC END# *48735C4A03C3_4CFFD8F603A0_var*
begin
//#UC START# *48735C4A03C3_4CFFD8F603A0_impl*
 Result := [];
//#UC END# *48735C4A03C3_4CFFD8F603A0_impl*
end;//TeeEditorWithoutOperations.DefineProvideOperations

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeEditorWithoutOperations);
 {* ����������� TeeEditorWithoutOperations }
{$IfEnd} // NOT Defined(NoScripts)

end.
