unit NOT_FINISHED_nscEditor;

// ������: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscEditor.pas"
// ���������: "GuiControl"
// ������� ������: "TnscEditor" MUID: (495119C4011A)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeEditor
;

type
 TnscEditor = class(TeeEditor)
 end;//TnscEditor
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscEditor);
 {* ����������� TnscEditor }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
