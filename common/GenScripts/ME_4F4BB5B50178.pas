unit kwFORWARD;
 {* Предварительное определение слова }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwFORWARD.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "FORWARD" MUID: (4F4BB5B50178)
// Имя типа: "TkwFORWARD"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwNewWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwFORWARD = {final} class(TtfwNewWord)
  {* Предварительное определение слова }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   function AcceptsKeyWordAfter(const aContext: TtfwContext;
    aWordNumber: Integer): Boolean; override;
   procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
    aCompiled: TkwCompiledWordPrim;
    const aContext: TtfwContext); override;
    {* Завершает определение вновь созданного слова }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwFORWARD
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwForwardDeclaration
 , SysUtils
;

function TkwFORWARD.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F4BB5B50178_var*
//#UC END# *4DB6C99F026E_4F4BB5B50178_var*
begin
//#UC START# *4DB6C99F026E_4F4BB5B50178_impl*
 Result := nil;
//#UC END# *4DB6C99F026E_4F4BB5B50178_impl*
end;//TkwFORWARD.EndBracket

function TkwFORWARD.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_4F4BB5B50178_var*
//#UC END# *4DB9B446039A_4F4BB5B50178_var*
begin
//#UC START# *4DB9B446039A_4F4BB5B50178_impl*
 Result := 0;
//#UC END# *4DB9B446039A_4F4BB5B50178_impl*
end;//TkwFORWARD.AfterWordMaxCount

function TkwFORWARD.AcceptsKeyWordAfter(const aContext: TtfwContext;
 aWordNumber: Integer): Boolean;
//#UC START# *4DB9B502013D_4F4BB5B50178_var*
//#UC END# *4DB9B502013D_4F4BB5B50178_var*
begin
//#UC START# *4DB9B502013D_4F4BB5B50178_impl*
 Result := false;
//#UC END# *4DB9B502013D_4F4BB5B50178_impl*
end;//TkwFORWARD.AcceptsKeyWordAfter

procedure TkwFORWARD.FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
 aCompiled: TkwCompiledWordPrim;
 const aContext: TtfwContext);
 {* Завершает определение вновь созданного слова }
//#UC START# *4F219629036A_4F4BB5B50178_var*
var
 l_W : TkwForwardDeclaration;
//#UC END# *4F219629036A_4F4BB5B50178_var*
begin
//#UC START# *4F219629036A_4F4BB5B50178_impl*
 CompilerAssert(not aCompiled.HasCode,
                'Слово не может иметь параметров',
                aContext
               );
 l_W := TkwForwardDeclaration.Create;
 try
  aWordToFinish.SetWord(aContext, l_W);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *4F219629036A_4F4BB5B50178_impl*
end;//TkwFORWARD.FinishDefinitionOfNewWord

class function TkwFORWARD.GetWordNameForRegister: AnsiString;
begin
 Result := 'FORWARD';
end;//TkwFORWARD.GetWordNameForRegister

initialization
 TkwFORWARD.RegisterInEngine;
 {* Регистрация FORWARD }
{$IfEnd} // NOT Defined(NoScripts)

end.
