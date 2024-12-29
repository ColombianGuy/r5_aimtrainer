"resource/ui/menus/FS_TeamSelector/team_selector_lobby_team.res"
{
	PanelFrame
	{
		ControlName				Label
		xpos					0
		ypos					0
		wide					1920
		tall					%100
		labelText				""
		visible					1
		enabled 				1
		scaleImage				1
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame02
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-20
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				PanelFrame
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton02
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				    "ui/settings_choice_button.rpak"//"ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			selected	0
			buttonText "TEAM 1"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame02
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember02_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame02
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember02_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame02
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember02_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame02
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	TeamFrame03
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame02
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton03
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 2"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame03
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember03_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame03
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember03_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame03
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember03_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame03
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame04
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame03
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton04
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 3"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame04
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember04_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame04
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember04_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame04
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember04_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame04
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame05
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame04
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton05
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 4"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame05
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember05_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame05
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember05_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame05
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember05_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame05
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame06
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame05
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton06
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 5"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame06
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember06_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame06
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember06_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame06
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember06_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame06
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame07
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					0
		ypos				    -215
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame02
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton07
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 6"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame07
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember07_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame07
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember07_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame07
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember07_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame07
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame08
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame07
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton08
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 7"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame08
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember08_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame08
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember08_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame08
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember08_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame08
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame09
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame08
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton09
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 8"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame09
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember09_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame09
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember09_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame09
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember09_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame09
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame10
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame09
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton10
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 9"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame10
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember10_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame10
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember10_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame10
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember10_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame10
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame11
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame10
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton11
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 10"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame11
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember11_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame11
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember11_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame11
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember11_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame11
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame12
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					0
		ypos				    -215
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame07
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton12
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 11"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame12
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember12_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame12
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember12_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame12
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember12_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame12
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame13
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame12
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton13
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 12"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame13
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember13_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame13
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember13_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame13
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember13_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame13
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame14
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame13
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton14
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 13"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame14
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember14_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame14
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember14_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame14
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember14_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame14
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame15
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame14
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton15
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 14"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame15
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember15_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame15
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember15_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame15
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember15_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame15
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame16
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame15
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton16
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 15"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame16
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember16_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame16
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember16_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame16
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember16_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame16
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame17
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					0
		ypos				    -215
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame12
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton17
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 16"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame17
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember17_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame17
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember17_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame17
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember17_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame17
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame18
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame17
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton18
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 17"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame18
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember18_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame18
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember18_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame18
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember18_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame18
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame19
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame18
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton19
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 18"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame19
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember19_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame19
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember19_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame19
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember19_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame19
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame20
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame19
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton20
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 19"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame20
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember20_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame20
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember20_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame20
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember20_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame20
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	TeamFrame21
	{
		ControlName				RuiPanel
		classname		       "TeamFrame"
		
		rui				     "ui/basic_border_box.rpak"
		drawColor				"0 0 0 50"
		wide						280
		tall						200
		xpos					-290
		ypos				    0
		visible					1
		enabled					1
		scaleImage				1

		pin_to_sibling				TeamFrame20
		pin_corner_to_sibling		TOP_LEFT
		pin_to_sibling_corner		TOP_LEFT
	}
	
	TeamSelectButton21
	{
		ControlName		     RuiButton
		classname		       "TeamButton"
		rui				     "ui/settings_choice_button.rpak" //"ui/custom_match_roster_tab_button.rpak" //Let's use something generic and available in s3 ui rpak

		ruiArgs
		{
			isSelected 0
			buttonText "TEAM 20"
			basicImageColor     "255 255 255"
			basicImageAlpha     1
		}
		
		wide					307
		ypos 8
		tall					60
		xpos					0
		
		pin_to_sibling		  TeamFrame21
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
	}

	TeamPlayerMember21_1
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -50
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame21
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				1
	}

	TeamPlayerMember21_2
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -100
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame21
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				2
	}

	TeamPlayerMember21_3
	{
		ControlName				Label
		classname		       "TeamPlayer"
		
		xpos					0
		ypos				    -150
		
		wide					281
		tall					50
		textAlignment			center
		visible					1
		labelText				""
		font					DefaultRegularFont
		fontHeight				25
		allcaps					1
		fgcolor_override		"255 255 255 255"

		pin_to_sibling		  TeamFrame21
		pin_corner_to_sibling   TOP
		pin_to_sibling_corner   TOP
		
		scriptID				3
	}
}