unit csUserEditQueryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csUserEditQueryPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsUserEditQueryPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csProcessTask,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsUserEditQueryPrim = class(TddProcessTask)
 protected
 // property methods
   function pm_GetID: Integer;
   procedure pm_SetID(aValue: Integer);
   function pm_GetIsGroup: Boolean;
   procedure pm_SetIsGroup(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ID: Integer
     read pm_GetID
     write pm_SetID;
   property IsGroup: Boolean
     read pm_GetIsGroup
     write pm_SetIsGroup;
 end;//TcsUserEditQueryPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  UserEditQuery_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsUserEditQueryPrim

function TcsUserEditQueryPrim.pm_GetID: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrID]);
end;//TcsUserEditQueryPrim.pm_GetID

procedure TcsUserEditQueryPrim.pm_SetID(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrID, nil] := (aValue);
end;//TcsUserEditQueryPrim.pm_SetID

function TcsUserEditQueryPrim.pm_GetIsGroup: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsGroup]);
end;//TcsUserEditQueryPrim.pm_GetIsGroup

procedure TcsUserEditQueryPrim.pm_SetIsGroup(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsGroup, nil] := (aValue);
end;//TcsUserEditQueryPrim.pm_SetIsGroup

class function TcsUserEditQueryPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typUserEditQuery;
end;//TcsUserEditQueryPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.