unit NOT_FINISHED_evdBufferedFilter;

// Модуль: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdBufferedFilter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evdBufferedFilter" MUID: (49E496880120)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdCustomBufferedFilter = class(Tk2TagFilter)
  protected
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; virtual;
   procedure DoFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer;
    aNeedCloseBracket: Boolean); virtual;
   function NeedStartBuffering(aID: Integer): Boolean; virtual;
 end;//TevdCustomBufferedFilter

 TevdBufferedFilter = class(TevdCustomBufferedFilter)
  protected
   procedure DoFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer;
    aNeedCloseBracket: Boolean); virtual;
 end;//TevdBufferedFilter

 TevdChildBufferedFilter = class(TevdBufferedFilter)
 end;//TevdChildBufferedFilter

 TevdCustomChildBufferedFilter = class(TevdBufferedFilter)
 end;//TevdCustomChildBufferedFilter

 TevdTagBufferedFilter = class(TevdBufferedFilter)
 end;//TevdTagBufferedFilter

implementation

uses
 l3ImplUses
;

function TevdCustomBufferedFilter.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_49E496650211_var*
//#UC END# *4CF7BC520161_49E496650211_var*
begin
//#UC START# *4CF7BC520161_49E496650211_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF7BC520161_49E496650211_impl*
end;//TevdCustomBufferedFilter.NeedFlushBuffer

procedure TevdCustomBufferedFilter.DoFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer;
 aNeedCloseBracket: Boolean);
//#UC START# *4CF7BEC40130_49E496650211_var*
//#UC END# *4CF7BEC40130_49E496650211_var*
begin
//#UC START# *4CF7BEC40130_49E496650211_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF7BEC40130_49E496650211_impl*
end;//TevdCustomBufferedFilter.DoFlushBuffer

function TevdCustomBufferedFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_49E496650211_var*
//#UC END# *4C56D54B002A_49E496650211_var*
begin
//#UC START# *4C56D54B002A_49E496650211_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C56D54B002A_49E496650211_impl*
end;//TevdCustomBufferedFilter.NeedStartBuffering

procedure TevdBufferedFilter.DoFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer;
 aNeedCloseBracket: Boolean);
//#UC START# *4D53D8BF00D5_49E4965202A1_var*
//#UC END# *4D53D8BF00D5_49E4965202A1_var*
begin
//#UC START# *4D53D8BF00D5_49E4965202A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D53D8BF00D5_49E4965202A1_impl*
end;//TevdBufferedFilter.DoFlushBuffer

end.
