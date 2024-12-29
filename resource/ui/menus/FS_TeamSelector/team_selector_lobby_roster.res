"resource/ui/menus/FS_TeamSelector/team_selector_lobby_roster.res"
{
	PanelFrame
	{
		ControlName				Label
		xpos					0
		ypos					0
		wide					%100
		tall					%100
		labelText				""
		bgcolor_override		"255 16 16 8"
		visible					0
		paintbackground			1
		proportionalToParent    1
	}

	RosterBg
	{
		ControlName				ImagePanel
		wide					%100
		tall					352
		visible					1
		proportionalToParent    1
		scaleImage				1
		image					"vgui/HUD/white"
		drawColor				"0 0 0 191"

		pin_to_sibling		  PanelFrame
		pin_corner_to_sibling   BOTTOM
		pin_to_sibling_corner   BOTTOM
	}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    LobbyRosterButton00
    {
		ControlName		     RuiButton
		rui				     "ui/settings_choice_button.rpak" //Let's use something generic and available in s3 ui rpak

		wide				    415 //%110 //%50
		xpos 20
		ypos 10
		
		
		ruiArgs
		{
			isSelected 1
			buttonText "TEAM UNASSIGNED"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
			
		tall				    70
		// proportionalToParent    1

		pin_to_sibling		  PanelFrame
		pin_corner_to_sibling   CENTER//TOP_LEFT
		pin_to_sibling_corner   CENTER//TOP_LEFT
		use_pin_locale_direction 1

		scriptId				0
    }

    LobbyRosterButton01
    {
		ControlName		     RuiButton
		rui				     "ui/tab_button.rpak"

		wide				    %50
		visible 				0
		tall				    48
		proportionalToParent    1

		pin_to_sibling		  PanelFrame
		pin_corner_to_sibling   TOP_RIGHT
		pin_to_sibling_corner   TOP_RIGHT
		use_pin_locale_direction 1

		scriptId				1
    }

    LobbyRoster00
    {
		ControlName		     GridButtonListPanel

		ypos				    -36

		scriptId				0

		pin_to_sibling		  PanelFrame
		pin_corner_to_sibling   BOTTOM
		pin_to_sibling_corner   BOTTOM

		columns				 1
		rows				    6
		buttonSpacing		   2
		scrollbarSpacing		1
		scrollbarOnLeft		 0
		selectOnDpadNav		 1

		ButtonSettings
		{
		    rui				     "ui/tab_button.rpak"
		    clipRui				 1
		    wide				    272
		    tall				    48
		    cursorVelocityModifier  0.7
		    rightClickEvents		1
		    doubleClickEvents       1
		    middleClickEvents       1
		    sound_focus		     "UI_Menu_Focus_Small"
		    sound_accept		    ""
		    sound_deny		      ""
		}
    }

    LobbyRoster01
    {
		ControlName		     GridButtonListPanel

		xpos				    0
		ypos				    -36

		scriptId				1

		pin_to_sibling		  PanelFrame
		pin_corner_to_sibling   BOTTOM
		pin_to_sibling_corner   BOTTOM

		columns				 1
		rows				    6
		buttonSpacing		   2
		scrollbarSpacing		1
		scrollbarOnLeft		 0
		selectOnDpadNav		 1

		ButtonSettings
		{
		    rui				     "ui/tab_button.rpak"
		    clipRui				 1
		    wide				    272
		    tall				    48
		    cursorVelocityModifier  0.7
		    rightClickEvents		1
		    doubleClickEvents       1
		    middleClickEvents       1
		    sound_focus		     "UI_Menu_Focus_Small"
		    sound_accept		    ""
		    sound_deny		      ""
		}
    }
}