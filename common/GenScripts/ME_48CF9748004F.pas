{$IfNDef k2TagBox_imp}

// ћодуль: "w:\common\components\rtl\Garant\K2\k2TagBox.imp.pas"
// —тереотип: "Impurity"

{$Define k2TagBox_imp}

 //#UC START# *48CF9748004Fci*
 //#UC END# *48CF9748004Fci*
 _k2Int64Holder_Parent_ = _k2TagBox_Parent_;
 {$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}
 _k2DoQT_Parent_ = _k2Int64Holder_;
 {$Include w:\common\components\rtl\Garant\K2\k2DoQT.imp.pas}
 //#UC START# *48CF9748004Fcit*
 //#UC END# *48CF9748004Fcit*
 _k2TagBox_ = class(_k2DoQT_, Il3TagRef)
  {* –еализаци€ инструмента, работающего с тегами }
  protected
   function GetAsPCharLen: Tl3WString; override;
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
   function DoMarkModified: Boolean; override;
   procedure DoDoLoad; override;
   function DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index;
    aLo: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   function GetIsStream(out theStream: IStream): Boolean; override;
   procedure DoForceStore; override;
   function GetAsLong: Integer; override;
   function GetIsNull: Boolean; override;
   function GetIsTransparent: Boolean; override;
   function GetAsString: AnsiString; override;
   function DoGetHasSubAtom(anIndex: Integer): Boolean; override;
   function GetIsOrd: Boolean; override;
   function GetAsBox: Tl3Variant; override;
   procedure DoSetRef(var theRef: Tl3Variant); override;
   function GetTagType: Tl3VariantDef; override;
   procedure SetAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Tl3Variant); override;
   function GetAttr(anIndex: Integer;
    out theValue: Tl3Variant): Boolean; override;
   procedure SetBoolAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Boolean); override;
   procedure SetIntAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Integer); override;
   procedure SetWStrAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    const aValue: Tl3WString); override;
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
   function pm_GetChildrenCount: Integer; override;
   procedure pm_SetChildrenCapacity(aValue: Integer); override;
   function pm_GetChildPrim(anIndex: Integer): Tl3Variant; override;
   function DoAddChild(aChild: Tl3Variant;
    const aContext: Il3OpPack): Integer; override;
   function CheckAttr(const aPath: array of Integer;
    const aContext: Il3OpPack;
    DoCheck: Boolean;
    theIndex: PLongint): Tl3Variant; override;
   function DoCAtom(anIndex: Integer;
    const aContext: Il3OpPack;
    anAtomType: Tl3VariantDef): Tl3Variant; override;
   function GetAsRef: Il3TagRef; override;
  public
   function GetRedirect: Tl3Variant;
   function AssignTag(Source: Tl3Variant;
    AssignMode: Tk2AssignModes = k2_amAll;
    const Context: Il3OpPack = nil): Boolean; override;
   function CloneTag: Il3TagRef; override;
   procedure AssignCloneParams(aSource: Tl3Variant;
    AssignMode: Tk2AssignModes = k2_amAll;
    const Context: Il3OpPack = nil); override;
   procedure WriteTag(const G: Ik2TagGenerator;
    Flags: Tk2StorePropertyFlags = l3_spfAll;
    Exclude: TByteSet = []); override;
    {* записать тег в генератор. }
   procedure InsertChildTag(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack = nil); override;
    {* вставить ребенка. }
   function IndexOfChild(aChild: Tl3Variant): Integer; override;
   procedure DeleteChildren(const Context: Il3OpPack = nil); override;
    {* удалить всех детей. }
   function CompareWithInt(aValue: Integer;
    anIndex: Integer): Integer; override;
    {* —равнивает тег с целым. }
   function CompareWithTag(aTag: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer; override;
   function rOwnAtom(anIndex: Integer): Tl3Variant; override;
   function GetLinkedInterface(const IID: TGUID;
    out Obj): Boolean; override;
   function DoQT(const IID: TGUID;
    out Obj;
    const aProcessor: Ik2Processor): Boolean; override;
 //#UC START# *48CF9748004Fpubl*
 //#UC END# *48CF9748004Fpubl*
 end;//_k2TagBox_

{$Else k2TagBox_imp}

{$IfNDef k2TagBox_imp_impl}

{$Define k2TagBox_imp_impl}

type
 Tl3HackVariant = {final} class(Tl3Variant)
 end;//Tl3HackVariant

{$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}

{$Include w:\common\components\rtl\Garant\K2\k2DoQT.imp.pas}

function _k2TagBox_.GetRedirect: Tl3Variant;
//#UC START# *53219B250295_48CF9748004F_var*
//#UC END# *53219B250295_48CF9748004F_var*
begin
//#UC START# *53219B250295_48CF9748004F_impl*
 Result := Redirect;
 if (Result = nil) then
  Result := Tk2NullTagImpl.Instance;
//#UC END# *53219B250295_48CF9748004F_impl*
end;//_k2TagBox_.GetRedirect

function _k2TagBox_.AssignTag(Source: Tl3Variant;
 AssignMode: Tk2AssignModes = k2_amAll;
 const Context: Il3OpPack = nil): Boolean;
//#UC START# *47612DD0012B_48CF9748004F_var*
//#UC END# *47612DD0012B_48CF9748004F_var*
begin
//#UC START# *47612DD0012B_48CF9748004F_impl*
 Result := GetRedirect.AssignTag(Source, AssignMode, Context);
//#UC END# *47612DD0012B_48CF9748004F_impl*
end;//_k2TagBox_.AssignTag

function _k2TagBox_.CloneTag: Il3TagRef;
//#UC START# *47612DF00301_48CF9748004F_var*
//#UC END# *47612DF00301_48CF9748004F_var*
begin
//#UC START# *47612DF00301_48CF9748004F_impl*
 Result := GetRedirect.Box.CloneTag;
//#UC END# *47612DF00301_48CF9748004F_impl*
end;//_k2TagBox_.CloneTag

procedure _k2TagBox_.AssignCloneParams(aSource: Tl3Variant;
 AssignMode: Tk2AssignModes = k2_amAll;
 const Context: Il3OpPack = nil);
//#UC START# *47612E530082_48CF9748004F_var*
//#UC END# *47612E530082_48CF9748004F_var*
begin
//#UC START# *47612E530082_48CF9748004F_impl*
 GetRedirect.AssignCloneParams(aSource, AssignMode, Context);
//#UC END# *47612E530082_48CF9748004F_impl*
end;//_k2TagBox_.AssignCloneParams

procedure _k2TagBox_.WriteTag(const G: Ik2TagGenerator;
 Flags: Tk2StorePropertyFlags = l3_spfAll;
 Exclude: TByteSet = []);
 {* записать тег в генератор. }
//#UC START# *4761324203B8_48CF9748004F_var*
//#UC END# *4761324203B8_48CF9748004F_var*
begin
//#UC START# *4761324203B8_48CF9748004F_impl*
 GetRedirect.Box.WriteTag(G, Flags, Exclude);
//#UC END# *4761324203B8_48CF9748004F_impl*
end;//_k2TagBox_.WriteTag

function _k2TagBox_.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_48CF9748004F_var*
//#UC END# *47A869BB02DE_48CF9748004F_var*
begin
//#UC START# *47A869BB02DE_48CF9748004F_impl*
 Result := GetRedirect.AsWStr;
//#UC END# *47A869BB02DE_48CF9748004F_impl*
end;//_k2TagBox_.GetAsPCharLen

function _k2TagBox_.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_48CF9748004F_var*
//#UC END# *48CF96D80241_48CF9748004F_var*
begin
//#UC START# *48CF96D80241_48CF9748004F_impl*
 Result := GetRedirect.IterateChildrenF(Action, aLo, aHi, aLoadedOnly);
//#UC END# *48CF96D80241_48CF9748004F_impl*
end;//_k2TagBox_.DoIterateChildrenF

procedure _k2TagBox_.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_48CF9748004F_var*
//#UC END# *49A545D501F6_48CF9748004F_var*
begin
//#UC START# *49A545D501F6_48CF9748004F_impl*
 GetRedirect.IterateProperties(Action, All);
//#UC END# *49A545D501F6_48CF9748004F_impl*
end;//_k2TagBox_.DoIterateProperties

procedure _k2TagBox_.InsertChildTag(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack = nil);
 {* вставить ребенка. }
//#UC START# *4A42358A00C2_48CF9748004F_var*
//#UC END# *4A42358A00C2_48CF9748004F_var*
begin
//#UC START# *4A42358A00C2_48CF9748004F_impl*
 GetRedirect.InsertChildTag(anIndex, aChild, aContext);
//#UC END# *4A42358A00C2_48CF9748004F_impl*
end;//_k2TagBox_.InsertChildTag

function _k2TagBox_.IndexOfChild(aChild: Tl3Variant): Integer;
//#UC START# *4A4235B70288_48CF9748004F_var*
//#UC END# *4A4235B70288_48CF9748004F_var*
begin
//#UC START# *4A4235B70288_48CF9748004F_impl*
 Result := GetRedirect.IndexOfChild(aChild);
//#UC END# *4A4235B70288_48CF9748004F_impl*
end;//_k2TagBox_.IndexOfChild

procedure _k2TagBox_.DeleteChildren(const Context: Il3OpPack = nil);
 {* удалить всех детей. }
//#UC START# *4A42378D0030_48CF9748004F_var*
//#UC END# *4A42378D0030_48CF9748004F_var*
begin
//#UC START# *4A42378D0030_48CF9748004F_impl*
 GetRedirect.DeleteChildren(Context);
//#UC END# *4A42378D0030_48CF9748004F_impl*
end;//_k2TagBox_.DeleteChildren

function _k2TagBox_.CompareWithInt(aValue: Integer;
 anIndex: Integer): Integer;
 {* —равнивает тег с целым. }
//#UC START# *4BC8415802B6_48CF9748004F_var*
//#UC END# *4BC8415802B6_48CF9748004F_var*
begin
//#UC START# *4BC8415802B6_48CF9748004F_impl*
 Result := GetRedirect.CompareWithInt(aValue, anIndex);
//#UC END# *4BC8415802B6_48CF9748004F_impl*
end;//_k2TagBox_.CompareWithInt

function _k2TagBox_.CompareWithTag(aTag: Tl3Variant;
 aSortIndex: Tl3SortIndex): Integer;
//#UC START# *4BC8415E021A_48CF9748004F_var*
//#UC END# *4BC8415E021A_48CF9748004F_var*
begin
//#UC START# *4BC8415E021A_48CF9748004F_impl*
 Result := GetRedirect.CompareWithTag(aTag, aSortIndex);
//#UC END# *4BC8415E021A_48CF9748004F_impl*
end;//_k2TagBox_.CompareWithTag

function _k2TagBox_.rOwnAtom(anIndex: Integer): Tl3Variant;
//#UC START# *4BC843C40240_48CF9748004F_var*
//#UC END# *4BC843C40240_48CF9748004F_var*
begin
//#UC START# *4BC843C40240_48CF9748004F_impl*
 Result := GetRedirect.rOwnAtom(anIndex);
//#UC END# *4BC843C40240_48CF9748004F_impl*
end;//_k2TagBox_.rOwnAtom

function _k2TagBox_.GetLinkedInterface(const IID: TGUID;
 out Obj): Boolean;
//#UC START# *4BC84CF702F5_48CF9748004F_var*
//#UC END# *4BC84CF702F5_48CF9748004F_var*
begin
//#UC START# *4BC84CF702F5_48CF9748004F_impl*
 Result := GetInterface(IID, Obj);
 if not Result then
  Result := GetRedirect.GetLinkedInterface(IID, Obj);
//#UC END# *4BC84CF702F5_48CF9748004F_impl*
end;//_k2TagBox_.GetLinkedInterface

function _k2TagBox_.DeleteChildPrim(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_48CF9748004F_var*
//#UC END# *4C6CE735026E_48CF9748004F_var*
begin
//#UC START# *4C6CE735026E_48CF9748004F_impl*
 Result := Tl3HackVariant(GetRedirect).DeleteChildPrim(anIndex, aChild, aContext);
//#UC END# *4C6CE735026E_48CF9748004F_impl*
end;//_k2TagBox_.DeleteChildPrim

function _k2TagBox_.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_48CF9748004F_var*
//#UC END# *4C6D1C29031F_48CF9748004F_var*
begin
//#UC START# *4C6D1C29031F_48CF9748004F_impl*
 Result := GetRedirect.MarkModified;
//#UC END# *4C6D1C29031F_48CF9748004F_impl*
end;//_k2TagBox_.DoMarkModified

procedure _k2TagBox_.DoDoLoad;
//#UC START# *4CEFA0BA0233_48CF9748004F_var*
//#UC END# *4CEFA0BA0233_48CF9748004F_var*
begin
//#UC START# *4CEFA0BA0233_48CF9748004F_impl*
 GetRedirect.DoLoad;
//#UC END# *4CEFA0BA0233_48CF9748004F_impl*
end;//_k2TagBox_.DoDoLoad

function _k2TagBox_.DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index;
 aLo: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *5081632303E6_48CF9748004F_var*
//#UC END# *5081632303E6_48CF9748004F_var*
begin
//#UC START# *5081632303E6_48CF9748004F_impl*
 Result := GetRedirect.IterateChildrenBack(Action, aHi, aLo, aLoadedOnly);
//#UC END# *5081632303E6_48CF9748004F_impl*
end;//_k2TagBox_.DoIterateChildrenBack

function _k2TagBox_.GetIsStream(out theStream: IStream): Boolean;
//#UC START# *530B20AC019A_48CF9748004F_var*
//#UC END# *530B20AC019A_48CF9748004F_var*
begin
//#UC START# *530B20AC019A_48CF9748004F_impl*
 Result := GetRedirect.IsStream(theStream);
//#UC END# *530B20AC019A_48CF9748004F_impl*
end;//_k2TagBox_.GetIsStream

procedure _k2TagBox_.DoForceStore;
//#UC START# *5321B9DF011A_48CF9748004F_var*
//#UC END# *5321B9DF011A_48CF9748004F_var*
begin
//#UC START# *5321B9DF011A_48CF9748004F_impl*
 GetRedirect.ForceStore;
//#UC END# *5321B9DF011A_48CF9748004F_impl*
end;//_k2TagBox_.DoForceStore

function _k2TagBox_.GetAsLong: Integer;
//#UC START# *5326D7B603A3_48CF9748004F_var*
//#UC END# *5326D7B603A3_48CF9748004F_var*
begin
//#UC START# *5326D7B603A3_48CF9748004F_impl*
 Result := GetRedirect.AsLong;
//#UC END# *5326D7B603A3_48CF9748004F_impl*
end;//_k2TagBox_.GetAsLong

function _k2TagBox_.GetIsNull: Boolean;
//#UC START# *5327E77D0084_48CF9748004F_var*
//#UC END# *5327E77D0084_48CF9748004F_var*
begin
//#UC START# *5327E77D0084_48CF9748004F_impl*
 Result := GetRedirect.IsNull;
//#UC END# *5327E77D0084_48CF9748004F_impl*
end;//_k2TagBox_.GetIsNull

function _k2TagBox_.GetIsTransparent: Boolean;
//#UC START# *5327E7AA01F1_48CF9748004F_var*
//#UC END# *5327E7AA01F1_48CF9748004F_var*
begin
//#UC START# *5327E7AA01F1_48CF9748004F_impl*
 Result := GetRedirect.IsTransparent;
//#UC END# *5327E7AA01F1_48CF9748004F_impl*
end;//_k2TagBox_.GetIsTransparent

function _k2TagBox_.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_48CF9748004F_var*
//#UC END# *5329CD1A020E_48CF9748004F_var*
begin
//#UC START# *5329CD1A020E_48CF9748004F_impl*
 Result := GetRedirect.AsString;
//#UC END# *5329CD1A020E_48CF9748004F_impl*
end;//_k2TagBox_.GetAsString

function _k2TagBox_.DoGetHasSubAtom(anIndex: Integer): Boolean;
//#UC START# *532AD5480329_48CF9748004F_var*
//#UC END# *532AD5480329_48CF9748004F_var*
begin
//#UC START# *532AD5480329_48CF9748004F_impl*
 Result := GetRedirect.HasSubAtom(anIndex);
//#UC END# *532AD5480329_48CF9748004F_impl*
end;//_k2TagBox_.DoGetHasSubAtom

function _k2TagBox_.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_48CF9748004F_var*
//#UC END# *532AE8F2009A_48CF9748004F_var*
begin
//#UC START# *532AE8F2009A_48CF9748004F_impl*
 Result := GetRedirect.IsOrd;
//#UC END# *532AE8F2009A_48CF9748004F_impl*
end;//_k2TagBox_.GetIsOrd

function _k2TagBox_.DoQT(const IID: TGUID;
 out Obj;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *532C4D4102D8_48CF9748004F_var*
//#UC END# *532C4D4102D8_48CF9748004F_var*
begin
//#UC START# *532C4D4102D8_48CF9748004F_impl*
 if Self.GetLinkedInterface(IID, Obj) then
  Result := true
 else
  Result := inherited DoQT(IID, Obj, aProcessor); 
//#UC END# *532C4D4102D8_48CF9748004F_impl*
end;//_k2TagBox_.DoQT

function _k2TagBox_.GetAsBox: Tl3Variant;
//#UC START# *532FFF230250_48CF9748004F_var*
//#UC END# *532FFF230250_48CF9748004F_var*
begin
//#UC START# *532FFF230250_48CF9748004F_impl*
 Result := GetRedirect.Box;
//#UC END# *532FFF230250_48CF9748004F_impl*
end;//_k2TagBox_.GetAsBox

procedure _k2TagBox_.DoSetRef(var theRef: Tl3Variant);
//#UC START# *533069050153_48CF9748004F_var*
//#UC END# *533069050153_48CF9748004F_var*
begin
//#UC START# *533069050153_48CF9748004F_impl*
 GetRedirect.SetRef(theRef);
//#UC END# *533069050153_48CF9748004F_impl*
end;//_k2TagBox_.DoSetRef

function _k2TagBox_.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_48CF9748004F_var*
//#UC END# *533121AF0203_48CF9748004F_var*
begin
//#UC START# *533121AF0203_48CF9748004F_impl*
 Result := GetRedirect.TagType;
//#UC END# *533121AF0203_48CF9748004F_impl*
end;//_k2TagBox_.GetTagType

procedure _k2TagBox_.SetAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Tl3Variant);
//#UC START# *5331961F0280_48CF9748004F_var*
//#UC END# *5331961F0280_48CF9748004F_var*
begin
//#UC START# *5331961F0280_48CF9748004F_impl*
 GetRedirect.AttrW[anIndex, aContext] := aValue;
//#UC END# *5331961F0280_48CF9748004F_impl*
end;//_k2TagBox_.SetAttr

function _k2TagBox_.GetAttr(anIndex: Integer;
 out theValue: Tl3Variant): Boolean;
//#UC START# *53319C270138_48CF9748004F_var*
//#UC END# *53319C270138_48CF9748004F_var*
begin
//#UC START# *53319C270138_48CF9748004F_impl*
 theValue := GetRedirect.Attr[anIndex];
 Result := (theValue <> nil) {AND not theValue.IsNull};
//#UC END# *53319C270138_48CF9748004F_impl*
end;//_k2TagBox_.GetAttr

procedure _k2TagBox_.SetBoolAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Boolean);
//#UC START# *5331B00B02DD_48CF9748004F_var*
//#UC END# *5331B00B02DD_48CF9748004F_var*
begin
//#UC START# *5331B00B02DD_48CF9748004F_impl*
 GetRedirect.BoolW[anIndex, aContext] := aValue;
//#UC END# *5331B00B02DD_48CF9748004F_impl*
end;//_k2TagBox_.SetBoolAttr

procedure _k2TagBox_.SetIntAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Integer);
//#UC START# *5332CD8801A6_48CF9748004F_var*
//#UC END# *5332CD8801A6_48CF9748004F_var*
begin
//#UC START# *5332CD8801A6_48CF9748004F_impl*
 GetRedirect.IntW[anIndex, aContext] := aValue;
//#UC END# *5332CD8801A6_48CF9748004F_impl*
end;//_k2TagBox_.SetIntAttr

procedure _k2TagBox_.SetWStrAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 const aValue: Tl3WString);
//#UC START# *5332FB8403B6_48CF9748004F_var*
//#UC END# *5332FB8403B6_48CF9748004F_var*
begin
//#UC START# *5332FB8403B6_48CF9748004F_impl*
 GetRedirect.PCharLenW[anIndex, aContext] := aValue;
//#UC END# *5332FB8403B6_48CF9748004F_impl*
end;//_k2TagBox_.SetWStrAttr

function _k2TagBox_.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_48CF9748004Fget_var*
//#UC END# *53343980014A_48CF9748004Fget_var*
begin
//#UC START# *53343980014A_48CF9748004Fget_impl*
 Result := GetRedirect.Owner;
//#UC END# *53343980014A_48CF9748004Fget_impl*
end;//_k2TagBox_.pm_GetTagOwner

procedure _k2TagBox_.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_48CF9748004Fset_var*
//#UC END# *53343980014A_48CF9748004Fset_var*
begin
//#UC START# *53343980014A_48CF9748004Fset_impl*
 GetRedirect.Owner := aValue;
//#UC END# *53343980014A_48CF9748004Fset_impl*
end;//_k2TagBox_.pm_SetTagOwner

function _k2TagBox_.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_48CF9748004Fget_var*
//#UC END# *5335815D03DC_48CF9748004Fget_var*
begin
//#UC START# *5335815D03DC_48CF9748004Fget_impl*
 Result := GetRedirect.ChildrenCount;
//#UC END# *5335815D03DC_48CF9748004Fget_impl*
end;//_k2TagBox_.pm_GetChildrenCount

procedure _k2TagBox_.pm_SetChildrenCapacity(aValue: Integer);
//#UC START# *533581770377_48CF9748004Fset_var*
//#UC END# *533581770377_48CF9748004Fset_var*
begin
//#UC START# *533581770377_48CF9748004Fset_impl*
 GetRedirect.ChildrenCapacity := aValue;
//#UC END# *533581770377_48CF9748004Fset_impl*
end;//_k2TagBox_.pm_SetChildrenCapacity

function _k2TagBox_.pm_GetChildPrim(anIndex: Integer): Tl3Variant;
//#UC START# *53358545012C_48CF9748004Fget_var*
//#UC END# *53358545012C_48CF9748004Fget_var*
begin
//#UC START# *53358545012C_48CF9748004Fget_impl*
 Result := GetRedirect.Child[anIndex];
//#UC END# *53358545012C_48CF9748004Fget_impl*
end;//_k2TagBox_.pm_GetChildPrim

function _k2TagBox_.DoAddChild(aChild: Tl3Variant;
 const aContext: Il3OpPack): Integer;
//#UC START# *533D587B0359_48CF9748004F_var*
//#UC END# *533D587B0359_48CF9748004F_var*
begin
//#UC START# *533D587B0359_48CF9748004F_impl*
 Result := GetRedirect.AddChild(aChild, aContext);
//#UC END# *533D587B0359_48CF9748004F_impl*
end;//_k2TagBox_.DoAddChild

function _k2TagBox_.CheckAttr(const aPath: array of Integer;
 const aContext: Il3OpPack;
 DoCheck: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *533D6FD80051_48CF9748004F_var*
//#UC END# *533D6FD80051_48CF9748004F_var*
begin
//#UC START# *533D6FD80051_48CF9748004F_impl*
 Result := Tl3Hackvariant(GetRedirect).CheckAttr(aPath, aContext, DoCheck, theIndex);
//#UC END# *533D6FD80051_48CF9748004F_impl*
end;//_k2TagBox_.CheckAttr

function _k2TagBox_.DoCAtom(anIndex: Integer;
 const aContext: Il3OpPack;
 anAtomType: Tl3VariantDef): Tl3Variant;
//#UC START# *533D791300DA_48CF9748004F_var*
//#UC END# *533D791300DA_48CF9748004F_var*
begin
//#UC START# *533D791300DA_48CF9748004F_impl*
 Result := Tl3HackVariant(GetRedirect).DoCAtom(anIndex, aContext, anAtomType);
//#UC END# *533D791300DA_48CF9748004F_impl*
end;//_k2TagBox_.DoCAtom

function _k2TagBox_.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_48CF9748004F_var*
//#UC END# *53568FCA01E8_48CF9748004F_var*
begin
//#UC START# *53568FCA01E8_48CF9748004F_impl*
 Result := Self;
//#UC END# *53568FCA01E8_48CF9748004F_impl*
end;//_k2TagBox_.GetAsRef

//#UC START# *48CF9748004Fimpl*
//#UC END# *48CF9748004Fimpl*

{$EndIf k2TagBox_imp_impl}

{$EndIf k2TagBox_imp}

