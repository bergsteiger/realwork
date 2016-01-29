unit TextLoad_Form;

interface

uses
 l3IntfUses
 , PrimTextLoad_Form
 , evEditor
 , evTextSource
 , evCustomTextSource
 , evCustomEditor
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_TextLoad
 
 TextLoadFormDef = interface
  {* ������������� ����� TextLoad }
 end;//TextLoadFormDef
 
 TTextLoadForm = class(TPrimTextLoadForm, TextLoadFormDef)
  {* ����� ��� �������� ��������� }
  function TextSource: TevCustomTextSource;
  function Text: TevCustomEditor;
 end;//TTextLoadForm
 
implementation

uses
 l3ImplUses
 , Controls
 , Forms
 , vcmStringIDExHelper
 , TtfwClassRef_Proxy
 , l3MessageID
 , TextLoadKeywordsPack
;

type
 Tkw_FormUserType_ut_TextLoad = class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TextLoad }
 end;//Tkw_FormUserType_ut_TextLoad
 
end.
