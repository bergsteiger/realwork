unit QFLikeTextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , QFLikeTextLoad_Form
 , evTextSource
 , evQueryCardEditor
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
 Tkw_Form_QFLikeTextLoad = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� QFLikeTextLoad
----
*������ �������������*:
[code]
'aControl' �����::QFLikeTextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_QFLikeTextLoad
 
 Tkw_QFLikeTextLoad_Component_TextSource = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Component_TextSource
 
 Tkw_QFLikeTextLoad_Control_Text = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Control_Text
 
 Tkw_QFLikeTextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Control_Text_Push
 
 Tkw_QFLikeTextLoad_Component_LoadManager = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Component_LoadManager
 
 TkwQFLikeTextLoadFormTextSource = class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.TextSource
[panel]������� TextSource ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
   {* ���������� ����� ������� .TQFLikeTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormTextSource
 
 TkwQFLikeTextLoadFormText = class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.Text
[panel]������� Text ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevQueryCardEditor
*������:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.Text >>> l_TevQueryCardEditor
[code]  }
  function Text(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
   {* ���������� ����� ������� .TQFLikeTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormText
 
 TkwQFLikeTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.LoadManager
[panel]������� LoadManager ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
   {* ���������� ����� ������� .TQFLikeTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormLoadManager
 
end.
