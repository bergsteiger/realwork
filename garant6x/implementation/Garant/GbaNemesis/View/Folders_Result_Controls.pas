unit Folders_Result_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders_Result_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 �������� ����������::Folders::View::Result
//
// ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vcmExternalInterfaces {a}
  ;

(* Result = operations
  {* ��������� ������� }
   ['{BA265A1A-E004-410C-8A4B-337F64ACE2F3}']
   operation Append;
     {* �������� }
 end;//Result*)

(* ResultExt = operations
   ['{3C815B0A-A80C-4971-83EC-1606AD876BBA}']
   operation Ok; has states;
     {* OK }
      None = state
       { ����������� ����� }
      end;//None
      NewFolder = state
       { ������� ����� }
      end;//NewFolder
      Edit = state
       { ��������� ����������������� ��������� }
      end;//Edit
      Load = state
       { ��������� }
       { ��������� ��������� ������� }
      end;//Load
      Select = state
       { ����������� ����� �������� }
      end;//Select
      FolderSave = state
       { ��������� }
       { ��������� ������� � ������� ����� }
      end;//FolderSave
   operation Append; has states;
     {* �������� }
      Bookmark = state
       { �������� ����� �������� � ���������� ������������ ����� ������� }
      end;//Bookmark
      List = state
       { �������� ����� ������ � ���������� ������������ ����� ������� }
      end;//List
      Query = state
       { �������� ����� ������ � ���������� ������������ ����� ������� }
      end;//Query
   operation Cancel;
     {* ������ }
 end;//ResultExt*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Result = 'Result';
 en_capResult = '��������� �������';
 op_Append = 'Append';
 op_capAppend = '��������';
 en_ResultExt = 'ResultExt';
 en_capResultExt = '';
 op_Ok = 'Ok';
 op_capOk = 'OK';
 op_Cancel = 'Cancel';
 op_capCancel = '������';

// ��������� ��������:
var st_user_ResultExt_Ok_None : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> None
var st_user_ResultExt_Ok_NewFolder : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> NewFolder
var st_user_ResultExt_Ok_Edit : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Edit
var st_user_ResultExt_Ok_Load : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> ���������
var st_user_ResultExt_Ok_Select : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Select
var st_user_ResultExt_Ok_FolderSave : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> ���������
var st_user_ResultExt_Append_Bookmark : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> �������� <-> Bookmark
var st_user_ResultExt_Append_List : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> �������� <-> List
var st_user_ResultExt_Append_Query : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> �������� <-> Query
{$IfEnd} //not Admin AND not Monitorings

implementation

end.