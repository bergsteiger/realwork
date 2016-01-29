{$IfNDef ListInfoUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListInfoUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ListInfoUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ListInfoUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _ListInfoUserTypes_ = {abstract form} class(_ListInfoUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure LiListInfoQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� liListInfo.OnQueryClose }
 end;//_ListInfoUserTypes_
{$Else}

 _ListInfoUserTypes_ = _ListInfoUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ListInfoUserTypes_imp}

{$IfNDef ListInfoUserTypes_imp_impl}
{$Define ListInfoUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ liListInfoLocalConstants }
  str_liListInfoCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : '������� � ������');
   { ��������� ����������������� ���� "������� � ������" }
  str_liListInfoSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : '������: ������� � ������');
   { ��������� ����������������� ���� "������� � ������" ��� ��������� ������� ������������ }

// start class _ListInfoUserTypes_

procedure _ListInfoUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(liListInfoName,
  str_liListInfoCaption,
  str_liListInfoSettingsCaption,
  true,
  20,
  10,
  '',
  nil,
  nil,
  LiListInfoQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(liListInfoName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  ListInfoUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_liListInfoCaption
 str_liListInfoCaption.Init;
// ������������� str_liListInfoSettingsCaption
 str_liListInfoSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ListInfoUserTypes_imp_impl}
{$EndIf ListInfoUserTypes_imp}
