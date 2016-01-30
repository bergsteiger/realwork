unit daCondition;

// Модуль: "w:\common\components\rtl\Garant\DA\daCondition.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaCondition = class(Tl3ProtoObject, IdaCondition)
  protected
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; virtual; abstract;
   function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  public
   procedure Iterate;
 end;//TdaCondition

implementation

uses
 l3ImplUses
;

function TdaCondition.BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *5608E5FE0355_56408DB303B7_var*
//#UC END# *5608E5FE0355_56408DB303B7_var*
begin
//#UC START# *5608E5FE0355_56408DB303B7_impl*
 Result := DoBuildSQL(aHelper);
//#UC END# *5608E5FE0355_56408DB303B7_impl*
end;//TdaCondition.BuildSQLValue

procedure TdaCondition.Iterate;
//#UC START# *564089E3039B_56408DB303B7_var*
//#UC END# *564089E3039B_56408DB303B7_var*
begin
//#UC START# *564089E3039B_56408DB303B7_impl*
 anAction(Self);
//#UC END# *564089E3039B_56408DB303B7_impl*
end;//TdaCondition.Iterate

end.
