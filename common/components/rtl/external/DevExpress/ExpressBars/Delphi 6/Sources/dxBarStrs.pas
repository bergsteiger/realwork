
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars string table constants                          }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxBarStrs;

interface

const
  DXBAR_WANTTORESETTOOLBAR = 39001;        // Are you sure you want to reset the changes made to the '%s' toolbar?                          
  DXBAR_WANTTORESETUSAGEDATA = 39002;      // This will delete the record of the commands
    // you've used in this application and restore the default set of visible commands
    // to the menus and toolbars. It will not undo any explicit customizations.   Are you sure you want to do this?                          
  DXBAR_BARMANAGERMORETHENONE  = 39003;    // Form should have only a single TdxBarManager
  DXBAR_BARMANAGERBADOWNER = 39004;        // TdxBarManager should have as Owner - TForm (TCustomForm)
  DXBAR_NOBARMANAGERS = 39005;             // There are no TdxBarManagers available
  DXBAR_WANTTODELETETOOLBAR = 39006;       // Are you sure you want to delete the '%s' toolbar?
  DXBAR_WANTTODELETECATEGORY = 39007;      // Are you sure you want to delete the '%s' category?
  DXBAR_WANTTOCLEARCOMMANDS = 39008;       // Are you sure you want to delete all commands in the '%s' category?
  DXBAR_RECURSIVESUBITEMS = 39009;         // You cannot create recursive subitems
  DXBAR_COMMANDNAMECANNOTBEBLANK = 39010;  // A command name cannot be blank. Please enter a name.
  DXBAR_TOOLBAREXISTS = 39011;             // A toolbar named '%s' already exists. Type another name.
  DXBAR_RECURSIVEGROUPS = 39012;           // You cannot create recursive groups
  DXBAR_DEFAULTCATEGORYNAME = 39101;       // Default

  DXBAR_CP_RESET = 39150;                  // &Reset
  DXBAR_CP_DELETE = 39151;                 // &Delete
  DXBAR_CP_NAME = 39152;                   // &Name:
  DXBAR_CP_DEFAULTSTYLE = 39153;           // Defa&ult style
  DXBAR_CP_TEXTONLYALWAYS = 39154;         // &Text Only (Always)
  DXBAR_CP_TEXTONLYINMENUS = 39155;        // Text &Only (in Menus)
  DXBAR_CP_IMAGEANDTEXT = 39156;           // Image &and Text
  DXBAR_CP_BEGINAGROUP = 39157;            // Begin a &Group
  DXBAR_CP_VISIBLE = 39158;                // &Visible
  DXBAR_CP_MOSTRECENTLYUSED = 39159;       // &Most recently used

  DXBAR_ADDEX = 39202;                     // Add...
  DXBAR_RENAMEEX = 39206;                  // Rename...
  DXBAR_DELETE = 39207;                    // Delete
  DXBAR_CLEAR = 39208;                     // Clear
  DXBAR_VISIBLE = 39209;                   // Visible
  DXBAR_OK = 39210;                        // OK
  DXBAR_CANCEL = 39211;                    // Cancel
  DXBAR_SUBMENUEDITOR = 39213;             // SubMenu Editor...
  DXBAR_SUBMENUEDITORCAPTION = 39214;      // ExpressBars SubMenu Editor
  DXBAR_INSERTEX = 39215;                  // Insert...
  DXBAR_MOVEUP = 39216;                    // Move Up
  DXBAR_MOVEDOWN = 39217;                  // Move Down
  DXBAR_POPUPMENUEDITOR = 39218;           // PopupMenu Editor...
  DXBAR_TABSHEET1 = 39219;                 //  Toolbars
  DXBAR_TABSHEET2 = 39220;                 //  Commands
  DXBAR_TABSHEET3 = 39221;                 //  Options
  DXBAR_TOOLBARS = 39222;                  // Toolb&ars:
  DXBAR_TNEW = 39223;                      // &New...
  DXBAR_TRENAME = 39224;                   // R&ename...
  DXBAR_TDELETE = 39225;                   // &Delete
  DXBAR_TRESET = 39226;                    // &Reset...
  DXBAR_CLOSE = 39227;                     // Close
  DXBAR_CAPTION = 39228;                   // Customize
  DXBAR_CATEGORIES = 39229;                // Cate&gories:
  DXBAR_COMMANDS = 39230;                  // Comman&ds:
  DXBAR_DESCRIPTION = 39231;               // Description

  DXBAR_CUSTOMIZE = 39300;                 // &Customize...
  DXBAR_ADDREMOVEBUTTONS = 39301;          // &Add or Remove Buttons
  DXBAR_MOREBUTTONS = 39302;               // More Buttons
  DXBAR_RESETTOOLBAR = 39303;              // &Reset Toolbar
  DXBAR_EXPAND = 39304;                    // Expand (Ctrl-Down)
  DXBAR_DRAGTOMAKEMENUFLOAT = 39305;       // Drag to make this menu float
  DXBAR_CATEGORYADD  = 39314;              // Add Category
  DXBAR_CATEGORYINSERT  = 39315;           // Insert Category
  DXBAR_CATEGORYRENAME  = 39316;           // Rename Category
  DXBAR_TOOLBARADD  = 39317;               // Custom 
  DXBAR_TOOLBARRENAME  = 39318;            // Rename Toolbar
  DXBAR_CATEGORYNAME  = 39324;             // &Category Name:
  DXBAR_TOOLBARNAME  = 39325;              // &Toolbar name:
  DXBAR_CUSTOMIZINGFORM = 39327;           // Customization Form...
  DXBAR_MODIFY = 39336;                    // ... modify

  DXBAR_PERSMENUSANDTOOLBARS = 39340;      // Personalized Menus and Toolbars  
  DXBAR_MENUSSHOWRECENTITEMS = 39341;      // Me&nus show recently used commands first
  DXBAR_SHOWFULLMENUSAFTERDELAY = 39342;   // Show f&ull menus after a short delay
  DXBAR_RESETUSAGEDATA = 39343;            // &Reset my usage data
  DXBAR_OTHEROPTIONS = 39344;              // Other  
  DXBAR_LARGEICONS = 39345;                // &Large icons
  DXBAR_HINTOPT1 = 39346;                  // Show Tool&Tips on toolbars
  DXBAR_HINTOPT2 = 39347;                  // Show s&hortcut keys in ToolTips
  DXBAR_MENUANIMATIONS = 39348;            // &Menu animations:
  DXBAR_MENUANIM1 = 39349;                 // (None)
  DXBAR_MENUANIM2 = 39350;                 // Random
  DXBAR_MENUANIM3 = 39351;                 // Unfold
  DXBAR_MENUANIM4 = 39352;                 // Slide

implementation

{$R dxBarStrs.res}

end.
