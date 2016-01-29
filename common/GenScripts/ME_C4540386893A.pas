unit TextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , TextLoad_Form
 , evEditor
 , evTextSource
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
 Tkw_Form_TextLoad = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TextLoad
----
*������ �������������*:
[code]
'aControl' �����::TextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_TextLoad
 
 Tkw_TextLoad_Control_Text = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Control_Text
 
 Tkw_TextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Control_Text_Push
 
 Tkw_TextLoad_Component_TextSource = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Component_TextSource
 
 Tkw_TextLoad_Component_LoadManager = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Component_LoadManager
 
 TkwTextLoadFormText = class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.Text
[panel]������� Text ����� TTextLoadForm[panel]
*��� ����������:* TevEditor
*������:*
[code]
OBJECT VAR l_TevEditor
 aTextLoadForm .TTextLoadForm.Text >>> l_TevEditor
[code]  }
  function Text(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevEditor;
   {* ���������� ����� ������� .TTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormText
 
 TkwTextLoadFormTextSource = class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.TextSource
[panel]������� TextSource ����� TTextLoadForm[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aTextLoadForm .TTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevTextSource;
   {* ���������� ����� ������� .TTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormTextSource
 
 TkwTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.LoadManager
[panel]������� LoadManager ����� TTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aTextLoadForm .TTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
   {* ���������� ����� ������� .TTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormLoadManager
 
end.
