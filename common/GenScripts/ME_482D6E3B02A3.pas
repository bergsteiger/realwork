unit NOT_FINISHED_evCustomTxtReader;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomTxtReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomTxtReader" MUID: (482D6E3B02A3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileReader
 , l3Base
;

type
 TevCustomTxtReader = class(Tk2CustomFileReader)
  protected
   procedure DoText(aText: Tl3String); virtual;
   function NeedOpenDefaultChild(aText: Tl3String): Boolean; virtual;
 end;//TevCustomTxtReader

implementation

uses
 l3ImplUses
;

procedure TevCustomTxtReader.DoText(aText: Tl3String);
//#UC START# *4D6BB62C01C8_482D6E3B02A3_var*
//#UC END# *4D6BB62C01C8_482D6E3B02A3_var*
begin
//#UC START# *4D6BB62C01C8_482D6E3B02A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D6BB62C01C8_482D6E3B02A3_impl*
end;//TevCustomTxtReader.DoText

function TevCustomTxtReader.NeedOpenDefaultChild(aText: Tl3String): Boolean;
//#UC START# *4E0B6520020B_482D6E3B02A3_var*
//#UC END# *4E0B6520020B_482D6E3B02A3_var*
begin
//#UC START# *4E0B6520020B_482D6E3B02A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0B6520020B_482D6E3B02A3_impl*
end;//TevCustomTxtReader.NeedOpenDefaultChild

end.
