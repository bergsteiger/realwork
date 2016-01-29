unit TextViaEditorProcessorPrim;

interface

uses
 l3IntfUses
 , VCMBaseTest
 , PrimTextLoad_Form
 , nevTools
;

type
 TTextViaEditorProcessorPrim = class(TVCMBaseTest)
  {* ���������� ������ ����� �������� }
  procedure Load(aForm: TPrimTextLoadForm;
   const aFileName: AnsiString;
   const aStr: AnsiString);
   {* ��������� �������� � �������� ��������� ����� }
  procedure Save(aForm: TPrimTextLoadForm);
   {* ��������� ����� �� ��������� � ����������� �������� ���� }
  procedure Scroll(aForm: TPrimTextLoadForm;
   const aSubName: AnsiString);
  procedure ScrollBack(aForm: TPrimTextLoadForm;
   const aSubName: AnsiString);
   {* ����������� ����� � �������� ����������� }
  procedure ScrollByWeel(aForm: TPrimTextLoadForm;
   aCount: Integer;
   aGoTop: Boolean);
   {* ���������� �������� ����� ��� � ������� ������ ���� }
  procedure ScrollByLine(aForm: TPrimTextLoadForm;
   aCount: Integer;
   aUp: Boolean;
   aFromBottom: Boolean);
   {* ������������ ��������� �������� ����� ��� ����� ��� ���� }
  procedure GotoDocumentBottom(aForm: TPrimTextLoadForm);
   {* ������� � ����� ��������� }
  procedure PageUp(aForm: TPrimTextLoadForm);
   {* ������� �� �������� ����� }
  procedure PageDown(aForm: TPrimTextLoadForm);
  function ScrollByPage: Boolean;
  function WebStyle: Boolean;
  function SendKey: Boolean;
   {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
  procedure CheckTopAnchor(const aView: InevInputView);
   {* ��������� ����� ������ ��������� ����� ��������� ��������� }
  function F1Like: Boolean;
  function QFLike: Boolean;
   {* ������� �����-�������� ��� ������ � ��. }
  procedure DoBeforeLoad(aForm: TPrimTextLoadForm);
   {* �������� �������������� �������� ��������� }
  function AllowMultiSelect: Boolean;
   {* ��������� ���������������. }
  function WithBaseSearch: Boolean;
   {* ����� �� ������� �������� ������. }
 end;//TTextViaEditorProcessorPrim
 
implementation

uses
 l3ImplUses
 , TextLoad_Form
 , evdSchema
 , F1LikeTextLoad_Form
 , QFLikeTextLoad_Form
 , F1LikeFormWithBS_Form
 , TestFrameWork
 , vcmBase
 , SysUtils
 , Forms
 , l3Base
 , Document_Const
 , k2OperationContainer
 , evdNativeWriter
 , l3Filer
 , evOp
 , l3InternalInterfaces
 , Windows
 , evCustomEditorWindow
 , Messages
;

end.
