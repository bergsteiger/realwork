unit NOT_FINISHED_nevScroller;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_nevScroller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevScroller" MUID: (4DAEAF42022E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevViewControl
 , nevTools
;

type
 TnevScroller = class(TnevViewControl, InevScroller)
  protected
   procedure Top;
   procedure Bottom;
   procedure PageUp;
   function PageDown: Boolean;
   procedure LineUp(aCount: Integer);
   procedure LineDown(aCount: Integer);
   function Min: Integer;
   function Max: Integer;
   function Page: Integer;
   function Pos: Integer;
   function ScrollTo(aPosition: Integer): Boolean;
   procedure WheelUp;
   procedure WheelDown;
   procedure EndScroll;
 end;//TnevScroller

implementation

uses
 l3ImplUses
 //#UC START# *4DAEAF42022Eimpl_uses*
 //#UC END# *4DAEAF42022Eimpl_uses*
;

procedure TnevScroller.Top;
//#UC START# *47C5C2E003A5_4DAEAF42022E_var*
//#UC END# *47C5C2E003A5_4DAEAF42022E_var*
begin
//#UC START# *47C5C2E003A5_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C2E003A5_4DAEAF42022E_impl*
end;//TnevScroller.Top

procedure TnevScroller.Bottom;
//#UC START# *47C5C2E60286_4DAEAF42022E_var*
//#UC END# *47C5C2E60286_4DAEAF42022E_var*
begin
//#UC START# *47C5C2E60286_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C2E60286_4DAEAF42022E_impl*
end;//TnevScroller.Bottom

procedure TnevScroller.PageUp;
//#UC START# *47C5C2EC023D_4DAEAF42022E_var*
//#UC END# *47C5C2EC023D_4DAEAF42022E_var*
begin
//#UC START# *47C5C2EC023D_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C2EC023D_4DAEAF42022E_impl*
end;//TnevScroller.PageUp

function TnevScroller.PageDown: Boolean;
//#UC START# *47C5C2F203CF_4DAEAF42022E_var*
//#UC END# *47C5C2F203CF_4DAEAF42022E_var*
begin
//#UC START# *47C5C2F203CF_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C2F203CF_4DAEAF42022E_impl*
end;//TnevScroller.PageDown

procedure TnevScroller.LineUp(aCount: Integer);
//#UC START# *47C5C2FC027D_4DAEAF42022E_var*
//#UC END# *47C5C2FC027D_4DAEAF42022E_var*
begin
//#UC START# *47C5C2FC027D_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C2FC027D_4DAEAF42022E_impl*
end;//TnevScroller.LineUp

procedure TnevScroller.LineDown(aCount: Integer);
//#UC START# *47C5C304021F_4DAEAF42022E_var*
//#UC END# *47C5C304021F_4DAEAF42022E_var*
begin
//#UC START# *47C5C304021F_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C304021F_4DAEAF42022E_impl*
end;//TnevScroller.LineDown

function TnevScroller.Min: Integer;
//#UC START# *47C5C35200B1_4DAEAF42022E_var*
//#UC END# *47C5C35200B1_4DAEAF42022E_var*
begin
//#UC START# *47C5C35200B1_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C35200B1_4DAEAF42022E_impl*
end;//TnevScroller.Min

function TnevScroller.Max: Integer;
//#UC START# *47C5C35A002F_4DAEAF42022E_var*
//#UC END# *47C5C35A002F_4DAEAF42022E_var*
begin
//#UC START# *47C5C35A002F_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C35A002F_4DAEAF42022E_impl*
end;//TnevScroller.Max

function TnevScroller.Page: Integer;
//#UC START# *47C5C3610307_4DAEAF42022E_var*
//#UC END# *47C5C3610307_4DAEAF42022E_var*
begin
//#UC START# *47C5C3610307_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C3610307_4DAEAF42022E_impl*
end;//TnevScroller.Page

function TnevScroller.Pos: Integer;
//#UC START# *47C5C369036E_4DAEAF42022E_var*
//#UC END# *47C5C369036E_4DAEAF42022E_var*
begin
//#UC START# *47C5C369036E_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C369036E_4DAEAF42022E_impl*
end;//TnevScroller.Pos

function TnevScroller.ScrollTo(aPosition: Integer): Boolean;
//#UC START# *47C5C3790232_4DAEAF42022E_var*
//#UC END# *47C5C3790232_4DAEAF42022E_var*
begin
//#UC START# *47C5C3790232_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C3790232_4DAEAF42022E_impl*
end;//TnevScroller.ScrollTo

procedure TnevScroller.WheelUp;
//#UC START# *47C5C37F03D3_4DAEAF42022E_var*
//#UC END# *47C5C37F03D3_4DAEAF42022E_var*
begin
//#UC START# *47C5C37F03D3_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C37F03D3_4DAEAF42022E_impl*
end;//TnevScroller.WheelUp

procedure TnevScroller.WheelDown;
//#UC START# *47C5C385018F_4DAEAF42022E_var*
//#UC END# *47C5C385018F_4DAEAF42022E_var*
begin
//#UC START# *47C5C385018F_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C385018F_4DAEAF42022E_impl*
end;//TnevScroller.WheelDown

procedure TnevScroller.EndScroll;
//#UC START# *47C5C38B0229_4DAEAF42022E_var*
//#UC END# *47C5C38B0229_4DAEAF42022E_var*
begin
//#UC START# *47C5C38B0229_4DAEAF42022E_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C38B0229_4DAEAF42022E_impl*
end;//TnevScroller.EndScroll

end.
