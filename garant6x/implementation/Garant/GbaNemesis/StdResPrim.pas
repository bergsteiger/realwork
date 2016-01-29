unit StdResPrim;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: StdResPrim -    }
{ Начат: 26.04.2011 14:15 }
{ $Id: StdResPrim.pas,v 1.2 2015/08/26 15:19:25 lulin Exp $ }

// $Log: StdResPrim.pas,v $
// Revision 1.2  2015/08/26 15:19:25  lulin
// {RequestLink:606128535}
//
// Revision 1.1  2013/09/11 16:12:57  lulin
// - добавляем операции для возможности определения состояний операций.
//
// Revision 1.10  2013/09/11 10:51:47  lulin
// - добавляем операции для возможности определения состояний операций.
//
// Revision 1.9  2013/02/19 16:53:37  lulin
// {RequestLink:358352192}
//
// Revision 1.8  2013/02/19 15:37:05  lulin
// {RequestLink:358352192}
//
// Revision 1.7  2012/11/02 09:23:51  lulin
// - выкидываем лишнее.
//
// Revision 1.6  2012/11/02 09:16:34  lulin
// - выкидываем лишнее.
//
// Revision 1.5  2012/03/22 11:43:51  lulin
// - заготовочка.
//
// Revision 1.4  2012/03/22 10:52:49  lulin
// - чиним за Мишей.
//
// Revision 1.3  2011/10/04 11:52:26  lulin
// {RequestLink:289933577}.
//
// Revision 1.2  2011/06/03 09:53:39  dinishev
// Переносим общие слова из F1
//
// Revision 1.1  2011/04/26 13:19:07  lulin
// {RequestLink:265391857}.
//

{$IfNDef NoVCM}
{$Include vcmDefine.inc }
{$EndIf  NoVCM}

interface

{$IfNDef NoVCM}
uses
  // !!! добавлять модули можно ДО этой строчки !!!
  {$IfDef NewGen}
  {$IfDef nsTest}
  NemesisRes
  {$Else  nsTest}
  NewGenRes
  {$EndIf nsTest}
  {$Else  NewGen}
  {$IfDef Nemesis}
  {$IfDef Admin}
  {$IfDef InsiderTest}
  AdminTestRes
  {$Else  InsiderTest}
  AdminAppRes
  {$EndIf InsiderTest}
  {$Else  Admin}
  {$IfDef Monitorings}
  {$IfDef InsiderTest}
  PrimeTestRes
  {$Else  InsiderTest}
  MonitoringsRes
  {$EndIf InsiderTest}
  {$Else  Monitorings}
  {$IfDef InsiderTest}
  NemesisTestRes
  {$Else  InsiderTest}
  NemesisRes
  {$EndIf InsiderTest}
  {$EndIf Monitorings}
  {$EndIf Admin}
  {$Else  Nemesis}
  {$IFDEF Archi}
  ArchiAppRes
  {$Else}
  //NemesisRes
  vcmApplication
  {$ENDIF Archi}
  {$EndIf Nemesis}
  {$EndIf NewGen}
  ;
{$EndIf  NoVCM}

{$IfNDef NoVCM}
type
  TdmStdRes =
   {$IfDef NewGen}
   {$IfDef nsTest}
   TNemesisRes
   {$Else  nsTest}
   TNewGenRes
   {$EndIf nsTest}
   {$Else  NewGen}
   {$IfDef Nemesis}
   {$IfDef Admin}
   {$IfDef InsiderTest}
   TAdminTestRes
   {$Else  InsiderTest}
   TAdminAppRes
   {$EndIf InsiderTest}
   {$Else  Admin}
   {$IfDef Monitorings}
   {$IfDef InsiderTest}
   TPrimeTestRes
   {$Else  InsiderTest}
   TMonitoringsRes
   {$EndIf InsiderTest}
   {$Else  Monitorings}
   {$IfDef InsiderTest}
   TNemesisTestRes
   {$Else  InsiderTest}
   TNemesisRes
   {$EndIf InsiderTest}
   {$EndIf Monitorings}
   {$EndIf Admin}
   {$Else  Nemesis}
   {$IFDEF Archi}
   {$IfNDef NoVCM}
   TArchiAppRes
   {$EndIf  NoVCM}
   {$ELSE}
   //TNemesisRes
   TvcmApplication
   {$ENDIF Archi}
   {$EndIf Nemesis}
   {$EndIf NewGen}
  ;

  TvcmApplicationRef = TdmStdRes;
{$EndIf  NoVCM}

implementation

uses
 f1VersionInfoService
 ;

end.

