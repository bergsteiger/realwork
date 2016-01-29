unit QFLikeTextLoad_Form;

interface

uses
 l3IntfUses
 , PrimTextLoad_Form
 , evQueryCardInt
 , evTextSource
 , evQueryCardEditor
 , evCustomTextSource
 , evCustomEditor
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_QFLikeTextLoad
 
 QFLikeTextLoadFormDef = interface
  {* ������������� ����� QFLikeTextLoad }
 end;//QFLikeTextLoadFormDef
 
 TQFLikeTextLoadForm = class(TPrimTextLoadForm, QFLikeTextLoadFormDef)
  {* ����� ��� ������ � �� }
  function TextSource: TevCustomTextSource;
  function Text: TevCustomEditor;
 end;//TQFLikeTextLoadForm
 
implementation

uses
 l3ImplUses
 , evQueryDocumentContainer
 , evControlContainerEX
 , nevTools
 , l3InterfacesMisc
 , TtfwClassRef_Proxy
 , l3MessageID
 , QFLikeTextLoadKeywordsPack
;

type
 Tkw_FormUserType_ut_QFLikeTextLoad = class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_QFLikeTextLoad }
 end;//Tkw_FormUserType_ut_QFLikeTextLoad
 
end.
