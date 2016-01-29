{$IfNDef vtDefine}
{ Библиотека "VT"         }
{ Автор: Бабанин В.Б. ©   }
{ Модуль: vtDefine -      }
{ Начат: 19.04.2003 15:19 }
{ $Id: vtDefine.inc,v 1.17 2015/03/31 16:44:12 lulin Exp $ }

// $Log: vtDefine.inc,v $
// Revision 1.17  2015/03/31 16:44:12  lulin
// - правим руками для NoTabs.
//
// Revision 1.16  2015/03/31 16:43:00  lulin
// - правим руками для NoTabs.
//
// Revision 1.15  2013/04/25 14:56:19  lulin
// - правим за Виктором немного.
//
// Revision 1.14  2011/03/29 14:44:09  lulin
// - неудачные попытки выставить форме предупреждения родителя.
//
// Revision 1.13  2011/02/18 12:11:59  lulin
// - расширяем заготовочку для Валентина.
//
// Revision 1.12  2010/12/10 12:47:43  lulin
// - по директиве _nsTool не тянем за собой VGScene.
//
// Revision 1.11  2010/12/08 16:03:36  lulin
// {RequestLink:228688602}.
// - мигаем рамкой.
//
// Revision 1.10  2009/08/18 08:47:34  lulin
// {ReqestLink:158795592}. №2.
//
// Revision 1.9  2008/05/21 17:05:16  lulin
// - <K>: 90441490.
//
// Revision 1.8  2008/05/21 14:34:01  lulin
// - <K>: 90450132.
//
// Revision 1.7  2008/05/21 13:28:23  lulin
// - cleanup.
//
// Revision 1.6  2007/09/05 11:57:51  lulin
// - сделана возможность определять проектные директивы в специально отведенном файле.
//
// Revision 1.5  2007/02/27 09:54:58  lulin
// - cleanup.
//
// Revision 1.4  2004/08/02 14:05:43  law
// - открутил VCM от тесной интеграции с моделью Немезиса.
//
// Revision 1.3  2004/05/26 19:38:33  law
// - убран ненужный define.
//
// Revision 1.2  2004/04/22 08:51:26  law
// - выделяем интерфейс Il3Tree. Промежуточный коммит. В старых проектах ничего разъехаться не должно.
//
// Revision 1.1  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//

{$Define vtDefine}

{$IfNDef evDefine}
 {$Include evDefine.inc}
{$EndIf  evDefine}

{.$Define vtUseVCM}

{$IfDef UseProjectDefine}
 {$I ProjectDefine.inc}
{$EndIf UseProjectDefine}

{$IfNDef Shell}
 {$IfDef Nemesis}
  {$If not Defined(Admin) AND not Defined(Monitorings) AND not Defined(nsTool)}
   {$Define Shell}
  {$IfEnd}
 {$EndIf Nemesis}
{$EndIf Shell}

{$IfDef Nemesis}
 {$IfNDef Shell}
  {$Define NoTabs}
 {$EndIf Shell}
{$EndIf Nemesis}

{$Define vtLayeredFormIsForm}

{$IfDef DesignTimeLibrary}
 {$Define eeNotNeedOvc}
{$EndIf DesignTimeLibrary}

{$IfNDef eeNotNeedOvc}
 {$Define eeNeedOvc}
{$EndIf  eeNotNeedOvc}

{$EndIf vtDefine}
