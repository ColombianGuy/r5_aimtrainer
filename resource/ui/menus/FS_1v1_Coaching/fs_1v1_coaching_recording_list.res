"platform/scripts/resource/ui/menus/FS_1v1_Coaching/fs_1v1_coaching_recording_list.res"
{
	//Screen
	//{
	//	ControlName		ImagePanel
	//	wide			%100
	//	tall			%100
	//}

	/////////////////////////////////////////////
	// 1
	//////////////////////////////////////////////
	
	// Background
	// {
		// ControlName 			RuiPanel
		// xpos					0
		// ypos					0
		// wide					266 //same as this CNest in parent
		// tall					830 //same as this CNest in parent
		// visible					0
		// image 					"ui/menu/lobby/lobby_playlist_back_01"
		// rui                     "ui/basic_border_box.rpak"
		// scaleImage				1
	// }

	Header
    {
        ControlName				ImagePanel
        InheritProperties		SubheaderBackgroundWide
        xpos					0
        ypos					0

        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
	
    HeaderText
    {
        ControlName				Label
        InheritProperties		SubheaderText
		
		font					DefaultRegularFont
		allcaps					0
		
        pin_to_sibling			Header
        pin_corner_to_sibling	LEFT
        pin_to_sibling_corner	LEFT
        labelText				"%$rui/bullet_point% Select a record to play, or start a new one."
		fontHeight				"40"
    }

    NoRecordingsText
    {
        ControlName				Label
        InheritProperties		SubheaderText
		
		font					DefaultRegularFont
		allcaps					0
		
        pin_to_sibling			Header
        pin_corner_to_sibling	LEFT
        pin_to_sibling_corner	LEFT
        labelText				"%$rui/bullet_point% There are no recordings. Start a new game."
		fontHeight				"40"
    }
	
    Button0
    {
        ControlName				RuiButton
		classname               MenuButton
        wide					1024
		ypos                     "15"
        tall					60
		zpos					5
        rui                     "ui/generic_icon_button.rpak"
		isSelected 				0
        visible					0
        // cursorVelocityModifier  0.7

		sound_focus             "UI_Menu_Focus_Small"
		
        tabPosition				1
        // navDown					SldADSAdvancedSensitivity0
		
		scriptID				0
		
        pin_to_sibling          Header
        pin_corner_to_sibling	TOP_LEFT
        pin_to_sibling_corner	BOTTOM_LEFT
    }
	
	Text0
	{
		ControlName					"Label"
		labelText					"Test"
		xpos						"-25"
		ypos						"0"
		zpos						"5"
		wide						"500"
		tall						"45"
		fontHeight					"45"
		visible					0
		
		pin_to_sibling				Button0
		pin_corner_to_sibling		LEFT
		pin_to_sibling_corner		LEFT
	}


    Button1
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              2
		scriptID				1
        pin_to_sibling           Button0
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text1
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
		visible					0
		
        pin_to_sibling           Button1
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button2
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              3
		scriptID				2
        pin_to_sibling           Button1
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text2
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button2
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button3
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              4
		scriptID				3
        pin_to_sibling           Button2
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text3
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button3
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button4
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              5
		scriptID				4
        pin_to_sibling           Button3
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text4
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button4
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button5
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              6
		scriptID				5
        pin_to_sibling           Button4
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text5
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button5
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button6
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              7
		scriptID				6
        pin_to_sibling           Button5
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text6
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button6
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button7
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              8
		scriptID				7
        pin_to_sibling           Button6
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text7
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button7
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button8
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              9
		scriptID				8
        pin_to_sibling           Button7
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text8
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button8
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button9
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              10
		scriptID				9
        pin_to_sibling           Button8
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text9
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button9
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button10
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              11
		scriptID				10
        pin_to_sibling           Button9
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text10
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button10
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button11
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              12
		scriptID				11
        pin_to_sibling           Button10
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text11
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button11
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button12
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              13
		scriptID				12
        pin_to_sibling           Button11
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text12
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button12
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button13
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              14
		scriptID				13
        pin_to_sibling           Button12
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text13
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button13
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button14
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              15
		scriptID				14
        pin_to_sibling           Button13
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text14
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button14
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button15
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              16
		scriptID				15
        pin_to_sibling           Button14
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text15
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button15
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button16
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              17
		scriptID				16
        pin_to_sibling           Button15
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text16
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button16
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button17
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              18
		scriptID				17
        pin_to_sibling           Button16
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text17
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button17
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button18
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              19
		scriptID				18
        pin_to_sibling           Button17
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text18
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button18
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button19
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              20
		scriptID				19
        pin_to_sibling           Button18
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text19
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button19
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button20
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				20
        pin_to_sibling           Button19
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text20
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button20
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button21
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				21
        pin_to_sibling           Button20
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text21
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button21
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button22
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				22
        pin_to_sibling           Button21
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text22
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button22
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button23
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				23
        pin_to_sibling           Button22
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text23
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button23
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button24
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				24
        pin_to_sibling           Button23
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text24
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button24
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button25
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				25
        pin_to_sibling           Button24
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text25
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button25
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button26
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				26
        pin_to_sibling           Button25
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text26
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button26
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button27
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				27
        pin_to_sibling           Button26
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text27
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button27
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button28
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				28
        pin_to_sibling           Button27
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text28
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button28
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button29
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				29
        pin_to_sibling           Button28
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text29
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button29
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button30
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				30
        pin_to_sibling           Button29
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text30
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button30
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button31
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				31
        pin_to_sibling           Button30
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text31
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button31
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button32
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				32
        pin_to_sibling           Button31
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text32
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button32
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button33
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				33
        pin_to_sibling           Button32
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text33
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button33
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button34
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				34
        pin_to_sibling           Button33
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text34
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button34
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button35
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				35
        pin_to_sibling           Button34
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text35
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button35
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button36
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				36
        pin_to_sibling           Button35
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text36
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button36
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button37
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				37
        pin_to_sibling           Button36
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text37
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button37
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button38
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				38
        pin_to_sibling           Button37
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text38
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button38
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button39
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				39
        pin_to_sibling           Button38
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text39
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button39
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button40
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				40
        pin_to_sibling           Button39
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text40
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button40
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button41
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				41
        pin_to_sibling           Button40
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text41
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button41
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button42
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				42
        pin_to_sibling           Button41
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text42
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button42
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button43
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				43
        pin_to_sibling           Button42
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text43
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button43
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button44
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				44
        pin_to_sibling           Button43
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text44
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button44
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button45
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				45
        pin_to_sibling           Button44
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text45
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button45
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button46
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				46
        pin_to_sibling           Button45
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text46
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button46
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button47
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				47
        pin_to_sibling           Button46
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text47
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button47
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button48
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				48
        pin_to_sibling           Button47
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text48
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button48
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button49
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				49
        pin_to_sibling           Button48
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text49
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button49
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    

    Button50
    {
        ControlName              RuiButton
        classname                MenuButton
        wide                     1024
		ypos                     "15"
        tall                     60
        zpos                     5
        rui                      "ui/generic_icon_button.rpak"
        isSelected               0
        visible                  0
        sound_focus              "UI_Menu_Focus_Small"
        tabPosition              1
		scriptID				50
        pin_to_sibling           Button49
        pin_corner_to_sibling    TOP_LEFT
        pin_to_sibling_corner    BOTTOM_LEFT
    }
    
    Text50
    {
        ControlName              "Label"
        labelText                "Test"
        xpos                     "-25"
        ypos                     "0"
        zpos                     "5"
        wide                     "500"
        tall                     "45"
        fontHeight               "45"
		visible					0
        pin_to_sibling           Button50
        pin_corner_to_sibling    LEFT
        pin_to_sibling_corner    LEFT
    }
    	
}
