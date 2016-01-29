unit OvcController;

{$Include OVC.INC}

interface

uses
  OvcBase
  ;

type
 TOvcController = OvcBase.TOvcController;

function GetDefController : TOvcController;
  {-}

implementation

{$IfDef nsTest}
uses
  Windows,

  TypInfo,

  SysUtils,

  Controls,

  l3InternalInterfaces,

  OvcConst,

  afwFacade

  {$IfNDef NoScripts}
  ,
  tfwScriptingInterfaces,
  tfwAutoregisteredDiction
  //tfwScriptEngine
  {$EndIf  NoScripts}
  ;
{$EndIf nsTest}

function GetDefController : TOvcController;
  {-}
begin
 Result := OvcBase.GetDefController;
end;

{$IfDef nsTest}
{$IfNDef NoScripts}
type
  TovcWord = class(TtfwWord)
  private
   f_Code : TOvcCommandName;
 public
 // public methods
   constructor Create(aCode : TOvcCommandName);
   procedure DoDoIt(const aCtx: TtfwContext); override;
  end;//TovcWord

constructor TovcWord.Create(aCode : TOvcCommandName);
begin
 inherited Create;
 f_Code := aCode;
end;

procedure TovcWord.DoDoIt(const aCtx: TtfwContext);
var
 l_C : TControl;
 l_P : Il3CommandTarget;
begin
 afw.ProcessMessages;
 l_C := FindControl(GetFocus);
 aCtx.rCaller.Check(l_C <> nil,
                    Format('Нет контрола в фокусе для выполнения: %s',
                           [GetEnumName(TypeInfo(TOvcCommandName), Ord(f_Code))]
                          )
                   );
 if not Supports(l_C, Il3CommandTarget, l_P) then
  aCtx.rCaller.Check(false,
                     Format('Контрол %s:%s не поддерживает интерфейс Il3CommandTarget для выполнения: %s',
                            [l_C.Name,
                             l_C.ClassName,
                             GetEnumName(TypeInfo(TOvcCommandName), Ord(f_Code))]
                           )
                    )
 else
  try
   aCtx.rCaller.Check(l_P.ProcessCommand(Ord(f_Code), true, 1),
                      Format('Не выполнилась операция %s на конроле %s:%s',
                             [GetEnumName(TypeInfo(TOvcCommandName), Ord(f_Code)),
                              l_C.Name,
                              l_C.ClassName]
                            )
                     );
  finally
   l_P := nil;
  end;//try..finally
end;

procedure AddCommandsToDictionary;
var
 l_Index : TovcCommandName;
 l_W     : TovcWord;
 l_S     : String;
begin
 TovcWord.RegisterClass;
 for l_Index := Succ(Low(TovcCommandName)) to High(TovcCommandName) do
 begin
  l_W := TovcWord.Create(l_Index);
  try
   l_S := GetEnumName(TypeInfo(TOvcCommandName), Ord(l_Index));
   Delete(l_S, 1, 3);
   TtfwAutoregisteredDiction.Instance.AddWord('cc:' + l_S, l_W);
   //TtfwScriptEngine.GlobalAddWord('cc:' + l_S, l_W);
  finally
   FreeAndNil(l_W); 
  end;//try..finally
 end;//for l_Index
end;
{$EndIf NoScripts}
{$EndIf nsTest}

{$IfDef nsTest}
{$IfNDef NoScripts}
initialization
 AddCommandsToDictionary;
{$EndIf NoScripts}
{$EndIf nsTest}

end.
