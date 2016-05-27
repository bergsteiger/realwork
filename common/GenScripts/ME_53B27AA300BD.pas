unit csUserEditQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csUserEditQueryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUserEditQueryPrim" MUID: (53B27AA300BD)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsUserEditQueryPrim = class(TddProcessTask)
  protected
   function pm_GetID: Integer;
   procedure pm_SetID(aValue: Integer);
   function pm_GetIsGroup: Boolean;
   procedure pm_SetIsGroup(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ID: Integer
    read pm_GetID
    write pm_SetID;
   property IsGroup: Boolean
    read pm_GetIsGroup
    write pm_SetIsGroup;
 end;//TcsUserEditQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , UserEditQuery_Const
;

function TcsUserEditQueryPrim.pm_GetID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrID]);
end;//TcsUserEditQueryPrim.pm_GetID

procedure TcsUserEditQueryPrim.pm_SetID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrID, nil] := (aValue);
end;//TcsUserEditQueryPrim.pm_SetID

function TcsUserEditQueryPrim.pm_GetIsGroup: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsGroup]);
end;//TcsUserEditQueryPrim.pm_GetIsGroup

procedure TcsUserEditQueryPrim.pm_SetIsGroup(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsGroup, nil] := (aValue);
end;//TcsUserEditQueryPrim.pm_SetIsGroup

class function TcsUserEditQueryPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typUserEditQuery;
end;//TcsUserEditQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
