unit F1LikeTextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , F1LikeTextLoad_Form
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
 Tkw_Form_F1LikeTextLoad = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� F1LikeTextLoad
----
*������ �������������*:
[code]
'aControl' �����::F1LikeTextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_F1LikeTextLoad
 
 Tkw_F1LikeTextLoad_Control_Text = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Control_Text
 
 Tkw_F1LikeTextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Control_Text_Push
 
 Tkw_F1LikeTextLoad_Component_TextSource = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Component_TextSource
 
 Tkw_F1LikeTextLoad_Component_LoadManager = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Component_LoadManager
 
 TkwF1LikeTextLoadFormText = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.Text
[panel]������� Text ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TeeEditorExport
*������:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.Text >>> l_TeeEditorExport
[code]  }
  function Text(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
   {* ���������� ����� ������� .TF1LikeTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormText
 
 TkwF1LikeTextLoadFormTextSource = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.TextSource
[panel]������� TextSource ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TeeTextSourceExport
*������:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
   {* ���������� ����� ������� .TF1LikeTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormTextSource
 
 TkwF1LikeTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.LoadManager
[panel]������� LoadManager ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
   {* ���������� ����� ������� .TF1LikeTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormLoadManager
 
end.
