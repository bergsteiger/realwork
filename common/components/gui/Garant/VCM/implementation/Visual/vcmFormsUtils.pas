unit vcmFormsUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormsUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmFormsUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3SimpleDataContainer,
  vcmEntityForm,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TvcmEntityForm;
 _l3ObjectPtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmSlayedEntityFormsList = class(_l3ObjectPtrList_)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TvcmSlayedEntityFormsList;
    {- ���������� ��������� ����������. }
 end;//TvcmSlayedEntityFormsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


// start class TvcmSlayedEntityFormsList

var g_TvcmSlayedEntityFormsList : TvcmSlayedEntityFormsList = nil;

procedure TvcmSlayedEntityFormsListFree;
begin
 l3Free(g_TvcmSlayedEntityFormsList);
end;

class function TvcmSlayedEntityFormsList.Instance: TvcmSlayedEntityFormsList;
begin
 if (g_TvcmSlayedEntityFormsList = nil) then
 begin
  l3System.AddExitProc(TvcmSlayedEntityFormsListFree);
  g_TvcmSlayedEntityFormsList := Create;
 end;
 Result := g_TvcmSlayedEntityFormsList;
end;


type _Instance_R_ = TvcmSlayedEntityFormsList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

// start class TvcmSlayedEntityFormsList

class function TvcmSlayedEntityFormsList.Exists: Boolean;
 {-}
begin
 Result := g_TvcmSlayedEntityFormsList <> nil;
end;//TvcmSlayedEntityFormsList.Exists
{$IfEnd} //not NoVCM

end.