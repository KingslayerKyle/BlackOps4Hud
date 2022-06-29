CoD.T8SelfScore = InheritFrom( LUI.UIElement )
CoD.T8SelfScore.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T8SelfScore )
	self.id = "T8SelfScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.ScoreBGGlow = LUI.UIImage.new()
	self.ScoreBGGlow:setLeftRight( true, false, 25.5, 237 )
	self.ScoreBGGlow:setTopBottom( false, true, -96, -23 )
	self.ScoreBGGlow:setImage( RegisterImage( "t8_hud_ammowidget_bg_glow" ) )
	self.ScoreBGGlow:setYRot( 180 )
	self:addElement( self.ScoreBGGlow )

	self.ScoreBG = LUI.UIImage.new()
	self.ScoreBG:setLeftRight( true, false, 25.5, 237 )
	self.ScoreBG:setTopBottom( false, true, -96, -23 )
	self.ScoreBG:setImage( RegisterImage( "t8_hud_ammowidget_bg" ) )
	self.ScoreBG:setYRot( 180 )
	self:addElement( self.ScoreBG )

	self.PortraitImage = LUI.UIImage.new()
	self.PortraitImage:setLeftRight( true, false, 19, 103 )
	self.PortraitImage:setTopBottom( false, true, -96, -22 )
	self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char1" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_nikolai" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char1_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_nikolai_ultimus" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char2" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_takeo" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char2_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_takeo_ultimus" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char3" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_dempsey" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char3_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_dempsey_ultimus" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char4" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_richtofen" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char4_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_richtofen_ultimus" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char5" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_jessica" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char6" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_jack" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char7" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_nero" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char8" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_floyd" ) )
			end
		end
	end )
	self:addElement( self.PortraitImage )

	self.ScoreText = LUI.UIText.new()
	self.ScoreText:setLeftRight( true, false, 91, 237 )
	self.ScoreText:setTopBottom( false, true, -77.5, -47.5 )
	self.ScoreText:setTTF( "fonts/skorzhen.ttf" )
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.ScoreText:linkToElementModel( self, "clientNum", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreText:setRGB( ZombieClientScoreboardColor( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self.ScoreText:linkToElementModel( self, "playerScore", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.ScoreText )

	self.HealthBar = LUI.UIImage.new()
	self.HealthBar:setLeftRight( true, false, 124, 213.5 )
	self.HealthBar:setTopBottom( false, true, -46, -41 )
	self.HealthBar:setImage( RegisterImage( "t8_hud_healthbar" ) )
	self.HealthBar:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.HealthBar:setShaderVector( 1, 0, 0, 0, 0 )
	self.HealthBar:setShaderVector( 2, 1, 0, 0, 0 )
	self.HealthBar:setShaderVector( 3, 0, 0, 0, 0 )
	self.HealthBar:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "T8.Health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) ~= nil then
				if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) > 0 then
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )

					if Engine.GetModelValue( modelRef ) <= 200 / 3 then
						self.HealthBar:setRGB( 1, 0, 0 )
					else
						self.HealthBar:setRGB( 1, 1, 1 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 4 ) )
					)
				else
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
					
					if Engine.GetModelValue( modelRef ) <= 100 / 3 then
						self.HealthBar:setRGB( 1, 0, 0 )
					else
						self.HealthBar:setRGB( 1, 1, 1 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 4 ) )
					)
				end
			end
		end
	end )
	self:addElement( self.HealthBar )

	self.HealthText = LUI.UIText.new()
	self.HealthText:setLeftRight( true, false, 101, 121 )
	self.HealthText:setTopBottom( false, true, -48.5, -37.5 )
	self.HealthText:setTTF( "fonts/skorzhen.ttf" )
	self.HealthText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.HealthText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "T8.Health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.HealthText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.HealthText )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ScoreBGGlow:close()
		element.ScoreBG:close()
		element.PortraitImage:close()
		element.ScoreText:close()
		element.HealthBar:close()
		element.HealthText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
