{$IfNDef Navigator_imp}

// ������: "w:\common\components\gui\Garant\Everest\EditorUsers\Navigator.imp.pas"
// ���������: "Impurity"

{$Define Navigator_imp}

{$If NOT Defined(NoScripts)}
 _Navigator_ = class(_Navigator_Parent_)
  protected
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); virtual; abstract;
    {* ������������� ������ ��� ��������� }
 end;//_Navigator_

{$Else NOT Defined(NoScripts)}

_Navigator_ = _Navigator_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else Navigator_imp}

{$IfNDef Navigator_imp_impl}

{$Define Navigator_imp_impl}

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$EndIf Navigator_imp_impl}

{$EndIf Navigator_imp}

