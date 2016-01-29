unit F1LikeFormWithBSKeywordsPack;

interface

uses
 l3IntfUses
 , F1LikeFormWithBS_Form
 , nscTreeComboWithHistoryAndOperations
 , eeEditorExport
 , eeTextSourceExport
 , evLoadDocumentManager
 , tfwControlString
 , kwBynameControlPush
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_F1LikeFormWithBS = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� F1LikeFormWithBS
----
*������ �������������*:
[code]
'aControl' �����::F1LikeFormWithBS TryFocus ASSERT
[code] }
 end;//Tkw_Form_F1LikeFormWithBS
 
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchControl
----
*������ �������������*:
[code]
�������::BaseSearchControl TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl
 
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchControl
----
*������ �������������*:
[code]
�������::BaseSearchControl:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push
 
 Tkw_F1LikeFormWithBS_Control_Text = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_Text
 
 Tkw_F1LikeFormWithBS_Control_Text_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_Text_Push
 
 Tkw_F1LikeFormWithBS_Component_TextSource = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Component_TextSource
 
 Tkw_F1LikeFormWithBS_Component_LoadManager = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Component_LoadManager
 
 TkwF1LikeFormWithBSFormBaseSearchControl = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.BaseSearchControl
[panel]������� BaseSearchControl ����� TF1LikeFormWithBSForm[panel]
*��� ����������:* TnscTreeComboWithHistoryAndOperations
*������:*
[code]
OBJECT VAR l_TnscTreeComboWithHistoryAndOperations
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.BaseSearchControl >>> l_TnscTreeComboWithHistoryAndOperations
[code]  }
  function BaseSearchControl(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
   {* ���������� ����� ������� .TF1LikeFormWithBSForm.BaseSearchControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormBaseSearchControl
 
 TkwF1LikeFormWithBSFormText = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.Text
[panel]������� Text ����� TF1LikeFormWithBSForm[panel]
*��� ����������:* TeeEditorExport
*������:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.Text >>> l_TeeEditorExport
[code]  }
  function Text(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
   {* ���������� ����� ������� .TF1LikeFormWithBSForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormText
 
 TkwF1LikeFormWithBSFormTextSource = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.TextSource
[panel]������� TextSource ����� TF1LikeFormWithBSForm[panel]
*��� ����������:* TeeTextSourceExport
*������:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
   {* ���������� ����� ������� .TF1LikeFormWithBSForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormTextSource
 
 TkwF1LikeFormWithBSFormLoadManager = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.LoadManager
[panel]������� LoadManager ����� TF1LikeFormWithBSForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
   {* ���������� ����� ������� .TF1LikeFormWithBSForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormLoadManager
 
end.
